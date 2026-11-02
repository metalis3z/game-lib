local CollectionService = game:GetService("CollectionService")
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = Lib.UI.Get("CameraSystem")
local CameraEffects = v1:WaitForChild("CameraEffects")
local Sounds = v1:WaitForChild("Sounds")
local Controls = v1:WaitForChild("Controls")
local v2 = Lib.Functional.WaitForPath("Workspace.Misc.SecurityCamPC.PP")
local t = {}

for i, v in ipairs((game.ReplicatedStorage:WaitForChild("AnomalyEvents"):WaitForChild("Local"):GetChildren())) do
	if v:IsA("ModuleScript") and string.match(v.Name, "Camera") then
		t[v.Name] = require(v)
	end
end

local Vignette2 = Lib.UI.Get("Vignette"):WaitForChild("Vignette2")
local CurrentCam = Controls:WaitForChild("Container"):WaitForChild("ButtonsHolder"):WaitForChild("CurrentCam")
local LeftButton = Controls:WaitForChild("Container"):WaitForChild("ButtonsHolder"):WaitForChild("LeftButton")
local RightButton = Controls:WaitForChild("Container"):WaitForChild("ButtonsHolder"):WaitForChild("RightButton")
local BackButton = Controls:WaitForChild("Container"):WaitForChild("ButtonsHolder"):WaitForChild("BackButton")
local Click = Sounds:WaitForChild("Click")
local v4 = Sounds:WaitForChild("Static Effect")
local staticframe = CameraEffects:WaitForChild("static"):WaitForChild("staticframe")
local Lines = CameraEffects:WaitForChild("Lines")
local TransitionFrame = CameraEffects:WaitForChild("TransitionFrame")
local CurrentCamera = workspace.CurrentCamera

game:GetService("TweenService")
TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local v5 = false
local v6 = 1
local ContextActionService = game:GetService("ContextActionService")
local v7 = nil
local v8 = nil

local function createTransition(p1) --[[ createTransition | Line: 36 | Upvalues: LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy) ]]
	task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), p1 (copy) ]]
		LeftButton.Active = false
		RightButton.Active = false
		TransitionFrame.Visible = true
		Click:Play()

		if p1 == "Long" then
			task.wait(2)
		elseif p1 == "Short" then
			task.wait(0.2)
		end

		TransitionFrame.Visible = false
		LeftButton.Active = true
		RightButton.Active = true
	end)
end

local Cameras = game.Workspace:WaitForChild("Misc"):WaitForChild("Cameras")
local Cameras2 = game.Workspace:WaitForChild("Misc"):WaitForChild("Cameras2")

local function getCamModels() --[[ getCamModels | Line: 54 | Upvalues: Cameras (copy), Cameras2 (copy) ]]
	return {
		Cameras:WaitForChild("Check-In"),
		Cameras:WaitForChild("Lobby"),
		Cameras:WaitForChild("Medical"),
		Cameras2:WaitForChild("Emergency")
	}
end

local StarterGui = game:GetService("StarterGui")

local function setGhostLocalVisible(p1, p2) --[[ setGhostLocalVisible | Line: 68 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = if p2 then v:GetAttribute("GhostOrigT") or 0 else 1
		end
	end
end

local function cameraOnFX() --[[ cameraOnFX | Line: 76 | Upvalues: LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy), v4 (copy), staticframe (copy), Lines (copy), Controls (copy), StarterGui (copy), Lib (copy), CollectionService (copy), setGhostLocalVisible (copy) ]]
	local v1 = "Short"

	task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), v1 (copy) ]]
		LeftButton.Active = false
		RightButton.Active = false
		TransitionFrame.Visible = true
		Click:Play()

		if v1 == "Long" then
			task.wait(2)
		elseif v1 == "Short" then
			task.wait(0.2)
		end

		TransitionFrame.Visible = false
		LeftButton.Active = true
		RightButton.Active = true
	end)
	v4:Play()
	staticframe.Visible = true
	Lines.Visible = true
	Controls.Container.Visible = true
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	local v2 = Lib.IsTouch and game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BackpackGui")

	if v2 then
		v2.Enabled = false
	end

	local ColorCorrection = game.Lighting:WaitForChild("ColorCorrection")

	ColorCorrection:SetAttribute("OldTintColor", ColorCorrection:GetAttribute("OldTintColor") or ColorCorrection.TintColor)
	ColorCorrection.TintColor = Color3.fromRGB(184, 251, 197)

	for i, v in ipairs(CollectionService:GetTagged("NPC")) do
		Lib.ApplySkinwalkerDisguiseReveal(v, "CameraEffect")

		if v:HasTag("GhostAnomaly") then
			setGhostLocalVisible(v, true)
		end
	end
end

local function cameraOffFX() --[[ cameraOffFX | Line: 98 | Upvalues: v4 (copy), LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy), staticframe (copy), Lines (copy), Controls (copy), CameraEffects (copy), StarterGui (copy), Lib (copy), CollectionService (copy), setGhostLocalVisible (copy) ]]
	v4:Stop()

	local v1 = "Short"

	task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), v1 (copy) ]]
		LeftButton.Active = false
		RightButton.Active = false
		TransitionFrame.Visible = true
		Click:Play()

		if v1 == "Long" then
			task.wait(2)
		elseif v1 == "Short" then
			task.wait(0.2)
		end

		TransitionFrame.Visible = false
		LeftButton.Active = true
		RightButton.Active = true
	end)
	staticframe.Visible = false
	Lines.Visible = false
	Controls.Container.Visible = false
	CameraEffects.black.Visible = false
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Lib.IsTouch)

	local v2 = Lib.IsTouch and game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BackpackGui")

	if v2 then
		v2.Enabled = true
	end

	local ColorCorrection = game.Lighting:WaitForChild("ColorCorrection")

	ColorCorrection.TintColor = ColorCorrection:GetAttribute("OldTintColor")

	for i, v in ipairs(CollectionService:GetTagged("NPC")) do
		Lib.UnDoSkinwalkerDisguiseReveal(v, "CameraEffect")

		if v:HasTag("GhostAnomaly") then
			setGhostLocalVisible(v, v:GetAttribute("GhostVisible") == true)
		end
	end
end

local function checkAnomalyOn() --[[ checkAnomalyOn | Line: 120 | Upvalues: getCamModels (copy), t (copy), v6 (ref), Vignette2 (copy) ]]
	local v1 = getCamModels()

	for k, v in pairs(t) do
		if v.CheckAnomalyInCamView(v1[v6]) then
			Vignette2.ImageTransparency = 0

			return
		end
	end
end

local function checkAnomalyOff() --[[ checkAnomalyOff | Line: 132 | Upvalues: getCamModels (copy), t (copy), v6 (ref), Vignette2 (copy) ]]
	local v1 = getCamModels()

	for k, v in pairs(t) do
		if v.PlayerStoppedWatching(v1[v6]) then
			Vignette2.ImageTransparency = 1

			return
		end
	end
end

local function leftClicked(p1) --[[ leftClicked | Line: 144 | Upvalues: LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy), checkAnomalyOff (copy), v6 (ref), checkAnomalyOn (copy) ]]
	local v1 = "Short"

	task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), v1 (copy) ]]
		LeftButton.Active = false
		RightButton.Active = false
		TransitionFrame.Visible = true
		Click:Play()

		if v1 == "Long" then
			task.wait(2)
		elseif v1 == "Short" then
			task.wait(0.2)
		end

		TransitionFrame.Visible = false
		LeftButton.Active = true
		RightButton.Active = true
	end)
	checkAnomalyOff()

	local count = #p1

	repeat
		v6 = if v6 - 1 > 0 then v6 - 1 else #p1
		count = count - 1
	until p1[v6]:HasTag("SecurityCamera") or count <= 0

	checkAnomalyOn()

	return v6
end

local function rightClicked(p1) --[[ rightClicked | Line: 163 | Upvalues: LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy), checkAnomalyOff (copy), v6 (ref), checkAnomalyOn (copy) ]]
	local v1 = "Short"

	task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), v1 (copy) ]]
		LeftButton.Active = false
		RightButton.Active = false
		TransitionFrame.Visible = true
		Click:Play()

		if v1 == "Long" then
			task.wait(2)
		elseif v1 == "Short" then
			task.wait(0.2)
		end

		TransitionFrame.Visible = false
		LeftButton.Active = true
		RightButton.Active = true
	end)
	checkAnomalyOff()

	local count = #p1

	repeat
		v6 = if #p1 < v6 + 1 then 1 else v6 + 1
		count = count - 1
	until p1[v6]:HasTag("SecurityCamera") or count <= 0

	checkAnomalyOn()

	return v6
end

local function setupCamera(p1) --[[ setupCamera | Line: 182 | Upvalues: CurrentCam (copy), CurrentCamera (copy), cameraOnFX (copy), v7 (ref) ]]
	CurrentCam.Text = "CAM " .. p1
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	cameraOnFX()
	v7()
end

local function resetCamera() --[[ resetCamera | Line: 190 | Upvalues: CurrentCamera (copy) ]]
	CurrentCamera.CameraType = Enum.CameraType.Custom
end

local function updateCameraView() --[[ updateCameraView | Line: 195 | Upvalues: getCamModels (copy), CurrentCam (copy), v6 (ref), CurrentCamera (copy), CameraEffects (copy), CollectionService (copy), staticframe (copy) ]]
	local v1 = getCamModels()

	CurrentCam.Text = v1[v6].Name
	CurrentCamera.CFrame = v1[v6].MainLook.CFrame
	CameraEffects.black.Visible = CollectionService:HasTag(v1[v6], "BrokenCam") and not CollectionService:HasTag(v1[v6], "AnomalyShadow")
	staticframe.Visible = CameraEffects.black.Visible
end

local function receiver() --[[ receiver | Line: 203 | Upvalues: v5 (ref), getCamModels (copy), v6 (ref), CurrentCam (copy), CurrentCamera (copy), cameraOnFX (copy), v7 (ref), checkAnomalyOn (copy), updateCameraView (copy), LeftButton (copy), RightButton (copy), TransitionFrame (copy), Click (copy), cameraOffFX (copy) ]]
	v5 = not v5

	if not v5 then
		cameraOffFX()

		return
	end

	if #getCamModels() > 0 then
		CurrentCam.Text = "CAM " .. v6
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		cameraOnFX()
		v7()
		checkAnomalyOn()
		updateCameraView()
	else
		local v1 = "Long"

		task.spawn(function() --[[ Line: 37 | Upvalues: LeftButton (ref), RightButton (ref), TransitionFrame (ref), Click (ref), v1 (copy) ]]
			LeftButton.Active = false
			RightButton.Active = false
			TransitionFrame.Visible = true
			Click:Play()

			if v1 == "Long" then
				task.wait(2)
			elseif v1 == "Short" then
				task.wait(0.2)
			end

			TransitionFrame.Visible = false
			LeftButton.Active = true
			RightButton.Active = true
		end)
		v5 = false
	end
end

LeftButton.Activated:Connect(function() --[[ Line: 220 | Upvalues: getCamModels (copy), leftClicked (copy), updateCameraView (copy) ]]
	leftClicked((getCamModels()))
	updateCameraView()
end)
RightButton.Activated:Connect(function() --[[ Line: 226 | Upvalues: getCamModels (copy), rightClicked (copy), updateCameraView (copy) ]]
	rightClicked((getCamModels()))
	updateCameraView()
end)

local function CameraOff() --[[ CameraOff | Line: 232 | Upvalues: v5 (ref), v2 (copy), checkAnomalyOff (copy), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
	v5 = false
	v2.Enabled = true
	checkAnomalyOff()
	CurrentCamera.CameraType = Enum.CameraType.Custom
	cameraOffFX()
	v8()
end

v7 = function() --[[ bindCamControls | Line: 243 | Upvalues: Lib (copy), LeftButton (copy), ContextActionService (copy), getCamModels (copy), leftClicked (copy), updateCameraView (copy), rightClicked (copy), v5 (ref), v2 (copy), checkAnomalyOff (copy), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
	if Lib.IsConsole then
		game:GetService("GuiService").GuiNavigationEnabled = true
		game:GetService("GuiService").SelectedObject = LeftButton
		ContextActionService:BindAction("CCTVControls", function(p1, p2, p3) --[[ Line: 247 | Upvalues: getCamModels (ref), leftClicked (ref), updateCameraView (ref), rightClicked (ref), v5 (ref), v2 (ref), checkAnomalyOff (ref), CurrentCamera (ref), cameraOffFX (ref), v8 (ref) ]]
			if p2 ~= Enum.UserInputState.Begin then
				return
			end

			local v1 = getCamModels()
			local KeyCode = p3.KeyCode

			if KeyCode == Enum.KeyCode.DPadLeft then
				leftClicked(v1)
				updateCameraView()

				return
			end

			if KeyCode == Enum.KeyCode.DPadRight then
				rightClicked(v1)
				updateCameraView()

				return
			end

			if KeyCode ~= Enum.KeyCode.ButtonB then
				return
			end

			v5 = false
			v2.Enabled = true
			checkAnomalyOff()
			CurrentCamera.CameraType = Enum.CameraType.Custom
			cameraOffFX()
			v8()
		end, false, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight, Enum.KeyCode.ButtonB)
	end
end
v8 = function() --[[ unbindCamControls | Line: 261 | Upvalues: Lib (copy), ContextActionService (copy), LeftButton (copy), RightButton (copy), BackButton (copy) ]]
	if not Lib.IsConsole then
		return
	end

	ContextActionService:UnbindAction("CCTVControls")

	local GuiService = game:GetService("GuiService")

	if GuiService.SelectedObject ~= LeftButton and (GuiService.SelectedObject ~= RightButton and GuiService.SelectedObject ~= BackButton) then
		return
	end

	GuiService.SelectedObject = nil
end
BackButton.Activated:Connect(function() --[[ Line: 270 | Upvalues: v5 (ref), v2 (copy), checkAnomalyOff (copy), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
	v5 = false
	v2.Enabled = true
	checkAnomalyOff()
	CurrentCamera.CameraType = Enum.CameraType.Custom
	cameraOffFX()
	v8()
end)
Lib.Inject("ToggleCamera", function() --[[ Line: 274 | Upvalues: v5 (ref), v2 (copy), checkAnomalyOff (copy), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
	if v5 then
		v5 = false
		v2.Enabled = true
		checkAnomalyOff()
		CurrentCamera.CameraType = Enum.CameraType.Custom
		cameraOffFX()
		v8()
	end
end)
Lib.Network:BindEvents({
	ToggleCameraOff = function() --[[ ToggleCameraOff | Line: 280 | Upvalues: v5 (ref), v2 (copy), checkAnomalyOff (copy), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
		if v5 then
			v5 = false
			v2.Enabled = true
			checkAnomalyOff()
			CurrentCamera.CameraType = Enum.CameraType.Custom
			cameraOffFX()
			v8()
		end
	end
})
Lib.Inject("ToggleCameraControls", function(p1) --[[ Line: 286 | Upvalues: v5 (ref), Controls (copy) ]]
	if v5 then
		Controls.Container.Visible = p1
	end
end)
v2.Triggered:Connect(function() --[[ Line: 291 | Upvalues: v2 (copy), receiver (copy) ]]
	v2.Enabled = false
	receiver()
end)
game.Players.PlayerAdded:Connect(function(p1) --[[ Line: 296 | Upvalues: v5 (ref), CurrentCamera (copy), cameraOffFX (copy), v8 (ref) ]]
	p1.CharacterAdded:Connect(function(p12) --[[ Line: 297 | Upvalues: p1 (copy), v5 (ref), CurrentCamera (ref), cameraOffFX (ref), v8 (ref) ]]
		if p1 ~= game.Players.LocalPlayer then
			return
		end

		p12:WaitForChild("Humanoid").Died:Connect(function() --[[ Line: 299 | Upvalues: v5 (ref), CurrentCamera (ref), cameraOffFX (ref), v8 (ref) ]]
			if not v5 then
				return
			end

			v5 = false
			CurrentCamera.CameraType = Enum.CameraType.Custom
			cameraOffFX()
			v8()
		end)
	end)
end)

return {}