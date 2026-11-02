local TrapSystem = game.ReplicatedStorage.TrapSystem
local trap = game.ServerStorage.Trap

TrapSystem.PlaceTrap.OnServerEvent:Connect(function(player, hrpcframe)
	local trapclone = trap:Clone()
	trapclone.PlacedPlayer.Value = player.Name
	trapclone.Parent = player.Character
	
	local Partforcframe = Instance.new("Part")
	Partforcframe.CFrame = hrpcframe

	trapclone:SetPrimaryPartCFrame(hrpcframe - Vector3.new(0,3,0))
	wait()
	trapclone.TrapVisual.Orientation = Vector3.new(-90, trapclone.TrapVisual.Orientation.Y, trapclone.TrapVisual.Orientation.Z)
	Partforcframe:Destroy()
	TrapSystem.PlaceTrap:FireClient(player, trapclone)
end)