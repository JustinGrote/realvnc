using namespace RealVnc
Add-Type -Path $PSScriptRoot/bin/RealVnc.Client.dll
$ErrorActionPreference = 'Stop'

$SCRIPT:CurrentClient = [RealVnc.CurrentClient]

function Connect-RVnc {
	[CmdletBinding()]
	[OutputType([RealVnc.Client])]
	param(
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential = $(Get-Credential),
		[Switch]$Force
	)

	if ($SCRIPT:CurrentClient::Client -and -not $Force) {
		Write-Warning 'A connection is already established. Use -Force to reconnect.'
		return $SCRIPT:CurrentClient::Client
	}

	$newClient = [RealVnc.Client]::new()

	$authResponse = $newClient.CreateSession([CreateAccessKeySessionRequest]@{
			AccessKeyId = $Credential.UserName
			AccessKey   = $Credential.GetNetworkCredential().Password
		})
	if (-not $authResponse.Token) {
		throw 'Authentiation response was received but Token was not present. This is probably a bug.'
	}
	$newClient.AuthToken = $authResponse.Token
	$SCRIPT:CurrentClient::Client = $newClient

	return $SCRIPT:CurrentClient::Client
}

function Assert-Client ($Client) {
	if (-not $Client) {
		throw 'No client is connected. Use Connect-RVnc to connect.'
	}

}

function Get-RVncEntry {
	[CmdletBinding()]
	[OutputType([RealVnc.Entry[]])]
	param(
		[string]$From = [String]::Empty,
		[RealVnc.Client]$Client = $SCRIPT:CurrentClient::Client
	)

	Assert-Client $Client
	return $Client.ListEntries($From).Entries
}

function Get-RVncEntryGroup {
	[CmdletBinding()]
	[OutputType([RealVnc.Entry[]])]
	param(
		[string]$EntryId,
		[RealVnc.Client]$Client = $SCRIPT:CurrentClient::Client
	)

	Assert-Client $Client
	return $EntryId ? $Client.ListEntryGroups_1($EntryId).Groups : $Client.ListEntryGroups().Groups
}
