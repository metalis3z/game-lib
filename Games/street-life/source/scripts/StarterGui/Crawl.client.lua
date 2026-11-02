if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game.Players.LocalPlayer
local char = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = char:WaitForChild('Humanoid')

local Mouser = Player:GetMouse()
local name = Player.Name

local crouching = false
_G.Crouching = false
local crawling = false
local sprinting = false

local debounce = false

local Animation = script.Anim

animtrack = char.Humanoid:LoadAnimation(Animation)
animtrack.Priority = Enum.AnimationPriority.Action4

wait(.2)

game:FindService('UserInputService').InputBegan:Connect(function(Key, Processed)
	if not Processed then
		if Key.KeyCode == Enum.KeyCode.C or Key.KeyCode == Enum.KeyCode.DPadLeft then
			if Humanoid.Sit then return end
			if crouching == false and crawling == false and sprinting == false then
				crouching = true
				_G.Crouching = true
				for i = 1,2 do
					wait()
					char.Humanoid.CameraOffset = Vector3.new(0,-0-i*.25,0)
				end
				animtrack:Play()
				animtrack:AdjustSpeed(0)
				char.Humanoid.WalkSpeed = 5
				char.Humanoid.JumpPower = 0
				local Event = char.Humanoid.Running:Connect(function(speed)
					if speed == 0 then
						animtrack:AdjustSpeed(0)
					else
						animtrack:AdjustSpeed(1)
					end
				end)
			elseif  crouching == true and crawling == false and sprinting == false then
				crouching = false
				_G.Crouching = false
				for i = 1,2 do
					wait(0)
					char.Humanoid.CameraOffset = Vector3.new(0,0+i*.1,0)
				end
				animtrack:Stop()
				char.Humanoid.WalkSpeed = 7.5
				char.Humanoid.JumpPower = 0
			end
		end
	end
end)

Humanoid.Seated:Connect(function(Seated)
	if Seated then
		if _G.Crouching == true and crouching == true then
			crouching = false
			_G.Crouching = false
			for i = 1,2 do
				wait(0)
				char.Humanoid.CameraOffset = Vector3.new(0,0+i*.1,0)
			end
			animtrack:Stop()
			char.Humanoid.WalkSpeed = 7.5
			char.Humanoid.JumpPower = 0
		end
	end
end)