local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = game:GetService("Players").LocalPlayer

ContextActionService:BindAction("Sprint", function(_, Input, _)
	
	if Input == Enum.UserInputState.Begin then
		
		local Character = LocalPlayer.Character
		
		if Character then
			Character.Humanoid.WalkSpeed = 36
		end
		
	else
		
		local Character = LocalPlayer.Character
		
		if Character then
			Character.Humanoid.WalkSpeed = 16
		end
		
	end
	
	return Enum.ContextActionResult.Pass
	
end, true, Enum.KeyCode.RightControl, Enum.KeyCode.LeftControl)

ContextActionService:SetPosition("Sprint", UDim2.new(1, -70, 0, 10))
ContextActionService:SetImage("Sprint", "rbxassetid://0123456789")

local RunKeys = { Enum.KeyCode.LeftControl, Enum.KeyCode.ButtonL2 }

UserInputService.InputBegan:Connect(function(Input, IsProcessed)
	
	if IsProcessed then
		
		return
			
	end
	
	if (Input.UserInputType == Enum.UserInputType.Keyboard or Input.UserInputType == Enum.UserInputType.Gamepad1) and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and table.find(RunKeys, Input.KeyCode) then
		
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 36
		
	end
	
end)

UserInputService.InputEnded:Connect(function(Input)
	
	if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and table.find(RunKeys, Input.KeyCode) then
		
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		
	end
	
end)
