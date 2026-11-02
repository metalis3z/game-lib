return function(Tool)
	local shell = Tool.GunModel.ShellInChamber
	
	if (shell.Transparency == 0) then
		local shellDrop = shell:clone()
		shellDrop.CanCollide = true
		shellDrop.Velocity = (Tool.GunModel.MainPart.CFrame * CFrame.Angles(0.5,-math.pi/2,0)).lookVector * 20
		shellDrop.RotVelocity = Vector3.new(math.random(),math.random(),math.random())
		shellDrop.Parent = workspace
		
		shell.Transparency = 1
		
		local debris = game:GetService("Debris")
		debris:AddItem(shellDrop,5)
	end
end