using namespace RealVnc
Add-Type -Path $PSScriptRoot/bin/RealVnc.Client.dll
$ErrorActionPreference = 'Stop'


function Connect-RVnc {
	[CmdletBinding()]
	[OutputType([RealVnc.Client])]
	param(
		[ValidateNotNullOrEmpty()]
		#Specify your API Key ID as the username and the API Key as the password
		[PSCredential]$Credential = $(Get-Credential),
		#Replace any existing connections
		[Switch]$Force,
		#Dont set as the current client, return only
		[Switch]$NoDefault

	)

	if ([RealVnc.CurrentClient]::Client -and -not $Force) {
		Write-Warning 'A connection is already established. Use -Force to reconnect.'
		return [RealVnc.CurrentClient]::Client
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
	if (-not $NoDefault) {
		[RealVnc.CurrentClient]::Client = $newClient
	}

	return [RealVnc.CurrentClient]::Client
}

function Assert-Client ($Client) {
	if (-not $Client) {
		throw 'No client is connected. Use Connect-RVnc to connect.'
	}

}

function Get-RVncEntry {
	[CmdletBinding()]
	[OutputType([RealVnc.Entry])]
	param(
		[string]$From = [String]::Empty,
		[RealVnc.Client]$Client = [RealVnc.CurrentClient]::Client
	)

	Assert-Client $Client
	return $Client.ListEntries($From).Entries
}

function Get-RVncEntryGroup {
	[CmdletBinding()]
	[OutputType([RealVnc.EntryGroup])]
	param(
		[string]$EntryId,
		[RealVnc.Client]$Client = [RealVnc.CurrentClient]::Client
	)

	Assert-Client $Client
	if ([String]::IsNullOrWhiteSpace($EntryId)) {
		return $Client.ListEntryGroups().Groups
	} else {
		return $Client.ListEntryGroups_1($EntryId).Groups
	}
}