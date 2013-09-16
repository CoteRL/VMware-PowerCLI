Function Get-VMDisk {
<#
.SYNOPSIS
  Lists specific properties of VM disks
.DESCRIPTION
  The function will list VM Name, Disk Name, SCSI Controller ID, SCSI ID, and Persistence state for every disk of a VM or multiple VMs
.NOTES
  Authors: Bob Cote
.PARAMETER VM
  A virtual machine or multiple virtual machines
#>
	Param(  
		[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
		$VM
	)
	Process {
		Foreach ($VMachine in $VM) {
			$VMView = $VMachine | Get-View
			$Disks = $VMachine | Get-HardDisk
			Foreach ($Disk in $Disks) {
				$DiskProperties = New-Object PsObject
				$DiskProperties | Add-Member Noteproperty VMName -Value $_.Name
				$DiskProperties | Add-Member Noteproperty "Disk Name" -Value $Disk.Name
				$Info = $VMView.Config.Hardware.Device | where {$_.GetType().Name -eq "VirtualDisk"} | where {$_.DeviceInfo.Label -eq $Disk.Name}
				$DiskProperties | Add-Member Noteproperty "SCSI Controller" -Value $Info.ControllerKey
				$DiskProperties | Add-Member Noteproperty "SCSI ID" -Value $Info.UnitNumber
				$DiskProperties | Add-Member Noteproperty Persistence -Value $Disk.Persistence
				$DiskProperties
			}
		}
	}
}