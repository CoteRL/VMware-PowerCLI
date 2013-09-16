Function Set-VMXPersistence {
<#
.SYNOPSIS
  Set vmx config entry for persistent disks
.DESCRIPTION
  The function will set the vmx scsiX:Y.mode entry to persistent for disks
.NOTES
  Authors: Bob Cote
.PARAMETER VM
  A list of disks from Get-VMDisk
#>
	Param(  
		[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
		$Disks
	)
	Process {
		Foreach ($Disk in $Disks) {
			
		}
	}
}