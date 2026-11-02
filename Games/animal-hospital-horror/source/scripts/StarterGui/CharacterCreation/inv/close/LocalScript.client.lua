local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("SocialService")

local LocalPlayer = game.Players.LocalPlayer
local v1 = script.Parent
local CurrentCamera = game.Workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

local function fadeSound(sound, vol)
	if sound then
		TweenService:Create(sound, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
			Volume = vol
		}):Play()
	end
end

Lib.Buttons.OnActivate(v1, function() --[[ Line: 12 ]]
	local PlayerGui = LocalPlayer.PlayerGui
	-- Assets opcionales: si faltan, NO deben impedir que la cámara vuelva
	local creation = PlayerGui:FindFirstChild("creation")
	local music = workspace:FindFirstChild("music")

	TweenService:Create(PlayerGui.blackscreen.black, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
		BackgroundTransparency = 0
	}):Play()
	fadeSound(creation, 0)
	task.wait(2)
	if creation then
		creation:Stop()
	end

	-- Restaurar la cámara SIEMPRE (esto iba después de assets que podían faltar)
	CurrentCamera.CameraType = Enum.CameraType.Custom
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		CurrentCamera.CameraSubject = hum
	end

	PlayerGui.Menu.Enabled = true
	PlayerGui.CharacterCreation.Enabled = false
	TweenService:Create(PlayerGui.blackscreen.black, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
		BackgroundTransparency = 1
	}):Play()

	if music then
		music:Play()
		fadeSound(music, 0.5)
	end
end)
