-- Reference copy for study. Game: miami-shootout
-- Original: StarterGui/CrouchSystem/Crouch/Crouch script.client.lua  (LocalScript, 51 lines)
-- What it does: Button toggles crouch: plays a crouch animation (paused when standing still, playing when moving), lowers WalkSpeed and disables jumping.

local Player = game.Players.LocalPlayer
repeat
	wait()
until Player.Character
local button = game.Players.LocalPlayer.PlayerGui.CrouchSystem.Crouch
local name = Player.Name
local Character = game.Workspace[Player.Name]

local Crouching = false
local Sprinting = false

local debounce = false

local Animation = script.Animation

local animeTrack = Character.Humanoid:LoadAnimation(Animation)

button.MouseButton1Click:Connect(function() -- Start Crouching
	if Crouching == false and Sprinting == false then
		Crouching = true
		for i = 1,2 do
			wait()
			Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
			Character.HumanoidRootPart.CanCollide = false
		end
		animeTrack:Play()
		animeTrack:AdjustSpeed(0)
		Character.Humanoid.WalkSpeed = 8
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
			for i = 1,2 do
				wait()
				Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
				Character.HumanoidRootPart.CanCollide = true
			end
			animeTrack:Stop()
			Character.Humanoid.WalkSpeed = 7.5
			Character.Humanoid.JumpPower = 50
		end
	end
end)
