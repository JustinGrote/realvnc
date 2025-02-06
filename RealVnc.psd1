@{
	# Script module or binary module file associated with this manifest.
	RootModule        = 'RealVnc.psm1'

	# Version number of this module.
	ModuleVersion     = '0.0.1'

	# ID used to uniquely identify this module
	GUID              = 'b1158ed3-e07d-4e50-a1c4-281ec35be5d5'

	# Author of this module
	Author            = 'Justin Grote github.com/JustinGrote BlueSky:@posh.guru'

	# Company or vendor of this module
	CompanyName       = 'Unknown'

	# Copyright statement for this module
	Copyright         = '(c) Justin Grote. All rights reserved.'

	# Description of the functionality provided by this module
	Description       = 'PowerShell Module for RealVNC Connect'

	# Minimum version of the PowerShell engine required by this module
	PowerShellVersion = '7.2'

	# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
	FunctionsToExport = @(
		'Connect-RVnc'
		'Get-RVncEntry'
		'Get-RVncEntryGroup'
	)

	# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
	CmdletsToExport   = @()

	# Variables to export from this module
	VariablesToExport = @()

	# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
	AliasesToExport   = @()

	# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData       = @{
		PSData = @{
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags         = @('RealVNC', 'VNC', 'Remote')

			# A URL to the license for this module.
			LicenseUri   = 'https://opensource.org/licenses/MIT'

			# A URL to the main website for this project.
			ProjectUri   = 'https://github.com/JustinGrote/RealVnc'

			# ReleaseNotes of this module
			ReleaseNotes = 'Initial Release'
		}
	}
}
