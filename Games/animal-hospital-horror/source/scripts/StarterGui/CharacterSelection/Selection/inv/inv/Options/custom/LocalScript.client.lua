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
	-- Assets opcionales: si faltan, NO deben colgar ni romper la cámara
	local music = workspace:FindFirstChild("music")
	local ocRoom = workspace:FindFirstChild("OCRoom")
	local cam0 = ocRoom and ocRoom:FindFirstChild("cam0")

	Lib.Buttons.ChangeVisibility(PlayerGui.CharacterSelection.Selection)
	TweenService:Create(PlayerGui.blackscreen.black, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
		BackgroundTransparency = 0
	}):Play()
	fadeSound(music, 0)
	task.wait(2)
	if music then
		music:Stop()
	end

	-- Solo movemos la cámara si existe el punto cam0 (antes: WaitForChild colgaba)
	if cam0 then
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		CurrentCamera.CameraSubject = cam0
		CurrentCamera.CFrame = cam0.CFrame
		CurrentCamera.Focus = cam0.CFrame
	else
		warn("[CharacterCreation] falta workspace.OCRoom.cam0 — cámara sin mover")
	end

	PlayerGui.Menu.Enabled = false
	PlayerGui.CharacterCreation.Enabled = true
	TweenService:Create(PlayerGui.blackscreen.black, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
		BackgroundTransparency = 1
	}):Play()

	local creation = PlayerGui:FindFirstChild("creation")
	if creation then
		creation:Play()
		fadeSound(creation, 0.5)
	end
end)
