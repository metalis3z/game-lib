local Remote = game.ReplicatedStorage:WaitForChild("HomeConfig"):WaitForChild("Camera")

local camera = workspace.CurrentCamera -- Variable for CurrentCamera
local player = game.Players.LocalPlayer

Remote.OnClientEvent:Connect(function(Enabled)
	if Enabled == true then
	
		camera.CameraType = Enum.CameraType.Scriptable--allows us to script the camera
         
		while true do
			for i = 1, 1350 do
				camera.CoordinateFrame = CFrame.new(586.853, 251.424, 269.595)
	
				wait()
			end
		end
	else
		camera.CameraSubject = player.Character.Humanoid
		camera.CameraType = Enum.CameraType.Custom--allows us to script the camera
	end
end)

