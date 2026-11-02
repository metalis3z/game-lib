if not game:IsLoaded() then game.Loaded:Wait() end

task.wait(5)

local MobileCameraFramework = {}
local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local CAS = game:GetService("ContextActionService")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local Shiftlock = character:WaitForChild('Shiftlock')
local Remote = script:WaitForChild('RemoteEvent')
local Head = character:WaitForChild('Head')
task.wait(1)
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character.Humanoid
local camera = workspace.CurrentCamera
local button = script.Parent

--Visiblity
uis = game:GetService("UserInputService")
ismobile = uis.TouchEnabled
button.Visible = ismobile

local states = {
	OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
	ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
}
local MAX_LENGTH = 900000
local active = false
local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
local function UpdateImage(STATE)
	button.Image = states[STATE]
end
local function UpdateAutoRotate(BOOL)
	humanoid.AutoRotate = BOOL
end
local function GetUpdatedCameraCFrame(ROOT, CAMERA)
	return CFrame.new(root.Position, Vector3.new(CAMERA.CFrame.LookVector.X * MAX_LENGTH, root.Position.Y, CAMERA.CFrame.LookVector.Z * MAX_LENGTH))
end
local function EnableShiftlock()
	UpdateAutoRotate(false)
	UpdateImage("ON")
	root.CFrame = GetUpdatedCameraCFrame(root, camera)
	camera.CFrame = camera.CFrame * ENABLED_OFFSET
	Remote:FireServer(Shiftlock, true) 
end
local function DisableShiftlock()
	UpdateAutoRotate(true)
	UpdateImage("OFF")
	camera.CFrame = camera.CFrame * DISABLED_OFFSET
	pcall(function()
		active:Disconnect()
		active = nil
	end)
	Remote:FireServer(Shiftlock, false)
end
UpdateImage("OFF")
active = false
function ShiftLock()
	if character:WaitForChild('InCar').Value == false then
		if not player.PlayerGui:FindFirstChild('CarDealerGui') and not player.PlayerGui:FindFirstChild('GunStore') then
			if not active then
				active = runservice.RenderStepped:Connect(function()
					EnableShiftlock()
					task.wait(.1)
				end)
			else
				DisableShiftlock()
			end
		end
	end
	
end
local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, "On")
CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))

button.MouseButton1Click:Connect(function()
	if character:WaitForChild('InCar').Value == false and Head.LocalTransparencyModifier ~= 1 then
		if not player.PlayerGui:FindFirstChild('CarDealerGui') and not player.PlayerGui:FindFirstChild('GunStore') then
			if not active then
				active = runservice.RenderStepped:Connect(function()
					EnableShiftlock()
					task.wait(.1)
				end)
			else
				DisableShiftlock()
			end
		end
	end
end)

game:FindService('UserInputService').InputBegan:Connect(function(Key, Processed)
	if not Processed and Key.KeyCode == Enum.KeyCode.ButtonL3 then
		if character:WaitForChild('InCar').Value == false and Head.LocalTransparencyModifier ~= 1 then
			if not player.PlayerGui:FindFirstChild('CarDealerGui') and not player.PlayerGui:FindFirstChild('GunStore') then
				if not active then
					active = runservice.RenderStepped:Connect(function()
						EnableShiftlock()
						task.wait(.1)
					end)
				else
					DisableShiftlock()
				end
			end
		end
	end
end)

player.PlayerGui.ChildAdded:Connect(function(Child)
	if Child.Name == 'GunStore' or Child.Name == 'CarDealerGui' then
		DisableShiftlock()
	end
end)

return MobileCameraFramework
