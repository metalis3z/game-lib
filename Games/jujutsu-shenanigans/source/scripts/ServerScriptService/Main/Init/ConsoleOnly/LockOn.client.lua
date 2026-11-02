local UIS = game:GetService("UserInputService")
local Players = game:GetService('Players')



local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()



if not UIS.GamepadEnabled then
	local lckon = game.StarterPlayer.StarterCharacterScripts.ControllerOnly:FindFirstChild('LockOn')
	if lckon then
		lckon:Destroy()
	end
	
	script:Destroy()
	
	return
end



local ShiftlockConnection: RBXScriptConnection



local cameraModule = require(script:WaitForChild("Camera"))
local cameraMode = "Freecam"



UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if input.KeyCode == Enum.KeyCode.ButtonL3 then
		if cameraMode == "Freecam" then
			Character:AddTag('CantRotate')
			ShiftlockConnection = game.CollectionService:GetInstanceRemovedSignal('CantRotate'):Connect(function(_Instance)
				if _Instance == Character then
					Character:AddTag('CantRotate')
				end
			end)
			
			cameraMode = "LockNearest"
			cameraModule.LockNearest()
		else
			ShiftlockConnection:Disconnect()
			Character:RemoveTag('CantRotate')
			
			cameraMode = "Freecam"
			cameraModule.Freecam()
		end
	end
end)