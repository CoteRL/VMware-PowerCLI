Function Get-VMDisk {
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
				$ID = $VMView.Config.Hardware.Device | where {$_.GetType().Name -eq "VirtualDisk"} | where {$_.DeviceInfo.Label -eq $Disk.Name} | Select UnitNumber
				$DiskProperties | Add-Member Noteproperty "SCSI ID" -Value $ID.UnitNumber
				$DiskProperties | Add-Member Noteproperty Persistence -Value $Disk.Persistence
				$DiskProperties
			}
		}
	}
}