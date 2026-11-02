if not game:IsLoaded() then game.Loaded:Wait() end

task.wait(3)

local Player = game.Players.LocalPlayer
local Character  = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
local button = game.Players.LocalPlayer.PlayerGui.CrouchSystem.Crouch
local name = Player.Name

local Crouching = false
local Sprinting = false
_G.Crouching = false
local debounce = false

local Animation = script.Animation

local animeTrack = Character.Humanoid:LoadAnimation(Animation)

if game:GetService("UserInputService").TouchEnabled == true then
	script.Parent.Visible = true
end

button.MouseButton1Click:Connect(function() -- Start Crouching
	if Crouching == false and Sprinting == false then
		Crouching = true
		_G.Crouching = true
		for i = 1,2 do
			wait()
			Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
			Character.HumanoidRootPart.CanCollide = false
		end
		animeTrack:Play()
		animeTrack:AdjustSpeed(0)
		Character.Humanoid.WalkSpeed = 5
		Character.Humanoid.JumpPower = 0

		local Event = Character.Humanoid.Running:Connect(function(speed)
			if speed == 0 then 
				animeTrack:AdjustSpeed(0)
			else
				animeTrack:AdjustSpeed(1)
			end
		end)
	else
		if Crouching == true and Sprinting == false then -- Stop Crouching
			Crouching = false
			_G.Crouching = false
			for i = 1,2 do
				wait()
				Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
				Character.HumanoidRootPart.CanCollide = true
			end
			animeTrack:Stop()
			Character.Humanoid.WalkSpeed = 7.5
			Character.Humanoid.JumpPower = 0
		end
	end
end)