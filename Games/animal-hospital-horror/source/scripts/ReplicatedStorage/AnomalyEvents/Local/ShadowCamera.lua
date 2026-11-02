local t = {}
local Anomalies = game.ReplicatedStorage:WaitForChild("NPCs"):WaitForChild("Anomalies")
local Shadow = Anomalies:WaitForChild("Shadow")
local CollectionService = game:GetService("CollectionService")
local Jumpscares = require(game.ReplicatedStorage:WaitForChild("AnomalyEvents"):WaitForChild("Local"):WaitForChild("Jumpscares"))

t.Type = script.Parent.Name
t.SanityDamage = 20

local v1 = nil
local v2 = nil

local function Jumpscare() --[[ Jumpscare | Line: 14 | Upvalues: Jumpscares (copy), Shadow (copy), v2 (ref), t (copy) ]]
	Jumpscares.JumpscareShadow(Shadow)
	;(v2 or require(game.ReplicatedStorage:WaitForChild("Lib"))).PlayerLostSanity(t.SanityDamage, "Jumpscare")
end

local function getClosestPoint(p1) --[[ getClosestPoint | Line: 21 ]]
	local ShadowCamPoints = game.ReplicatedStorage.AreaDetectors.ShadowCamPoints
	local Position = p1:GetPivot().Position

	p1:GetPivot()

	return ShadowCamPoints:FindFirstChild(p1.Name)
end

local function PlayAnomaly(p1) --[[ PlayAnomaly | Line: 47 | Upvalues: Shadow (copy), v1 (ref), Jumpscares (copy), v2 (ref), t (copy), Anomalies (copy) ]]
	local ShadowCamPoints = game.ReplicatedStorage.AreaDetectors.ShadowCamPoints
	local Position = p1:GetPivot().Position

	p1:GetPivot()

	local v12 = ShadowCamPoints:FindFirstChild(p1.Name)

	print("closest point for cam " .. p1.Name .. " is " .. v12.Name)
	Shadow:SetPrimaryPartCFrame(v12.CFrame)
	Shadow.Parent = workspace.Misc

	local CurrentCamera = workspace.CurrentCamera
	local Position2 = Shadow.PrimaryPart.Position
	local v22 = 0
	local v3 = tick()
	local MainLook = p1:FindFirstChild("MainLook")

	if not MainLook then
		return
	end

	local v4 = MainLook.CFrame
	local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
	local v5 = CFrame.lookAt(v4.Position:Lerp(Position2, 0.75), Position2)

	v1 = Lib.TS:Create(CurrentCamera, TweenInfo.new(4.8, Enum.EasingStyle.Linear), {
		FieldOfView = 50,
		CFrame = v5
	})
	v1:Play()

	local sound = Lib.MusicService.Get("horror buildup", "jumpscare").sound

	sound.TimePosition = 14.2
	sound:Play()

	while p1:GetAttribute("AnomalyShadowActive") and v22 < 1 do
		task.wait()

		if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
			break
		end

		v22 = math.min((tick() - v3) / 4.8, 1)
	end

	if v1 then
		v1:Cancel()
		v1 = nil
	end

	if v22 >= 1 then
		Lib.ToggleCameraControls(false)
		Jumpscares.JumpscareShadow(Shadow)
		;(v2 or require(game.ReplicatedStorage:WaitForChild("Lib"))).PlayerLostSanity(t.SanityDamage, "Jumpscare")
		Lib.ToggleCamera()
	else
		sound:Stop()
		CurrentCamera.CFrame = v4
	end

	CurrentCamera.FieldOfView = 70
	Shadow.Parent = Anomalies
	p1:RemoveTag("AnomalyShadow")
	print("done Resetting camera after shadow anomaly...", Shadow.Parent)
end

local function StalkerAnomaly(p1) --[[ StalkerAnomaly | Line: 114 | Upvalues: CollectionService (copy), Jumpscares (copy), v2 (ref), t (copy), Anomalies (copy) ]]
	local v1 = CollectionService:GetTagged("TallMonsterHead")[1]

	v1:SetAttribute("InUse", v1:GetAttribute("InUse") + 1)
	v1.Parent = workspace.Misc

	local v22 = p1:GetPivot()

	v1:SetPrimaryPartCFrame(v22 + v22.LookVector * 3)

	for i = 1, 50 do
		if not p1:GetAttribute("StalkerJumpscare") then
			break
		end

		task.wait(0.02)
	end

	v1:SetAttribute("InUse", v1:GetAttribute("InUse") - 1)

	if p1:GetAttribute("StalkerJumpscare") then
		Jumpscares.JumpscareStalker(v1)
		;(v2 or require(game.ReplicatedStorage:WaitForChild("Lib"))).PlayerLostSanity(t.SanityDamage / 2, "Jumpscare")
	end

	if not (v1:GetAttribute("InUse") <= 0) then
		return
	end

	v1.Parent = Anomalies
end

function t.CheckAnomalyInCamView(p1) --[[ CheckAnomalyInCamView | Line: 140 | Upvalues: v2 (ref), PlayAnomaly (copy), StalkerAnomaly (copy) ]]
	v2 = v2 or require(game.ReplicatedStorage:WaitForChild("Lib"))

	if p1:HasTag("AnomalyShadow") then
		if not p1:GetAttribute("AnomalyShadowActive") then
			p1:SetAttribute("AnomalyShadowActive", true)
			task.spawn(PlayAnomaly, p1)
			v2.ToggleCameraControls(false)
			task.delay(1.5, function() --[[ Line: 150 | Upvalues: v2 (ref) ]]
				v2.ToggleCameraControls(true)
			end)

			return true
		end
	elseif p1:HasTag("StalkerJumpscare") then
		p1:SetAttribute("StalkerJumpscare", true)
		task.spawn(StalkerAnomaly, p1)

		return true
	end
end
function t.ApplyAnomalyToCam(p1) --[[ ApplyAnomalyToCam | Line: 165 ]]
	p1:AddTag("AnomalyShadow")
end
function t.PlayerStoppedWatching(p1) --[[ PlayerStoppedWatching | Line: 169 | Upvalues: v1 (ref) ]]
	if p1:HasTag("AnomalyShadow") and p1:GetAttribute("AnomalyShadowActive") then
		if not v1 then
			p1:SetAttribute("AnomalyShadowActive", false)

			return true
		end

		v1:Cancel()
		v1 = nil
		p1:SetAttribute("AnomalyShadowActive", false)

		return true
	end

	if p1:HasTag("StalkerJumpscare") and p1:GetAttribute("StalkerJumpscare") then
		p1:SetAttribute("StalkerJumpscare", false)

		return true
	end
end
function t.RemoveAnomalyFromCam(p1) --[[ RemoveAnomalyFromCam | Line: 181 | Upvalues: CollectionService (copy) ]]
	local v1 = if p1 then p1 else CollectionService:GetTagged("AnomalyShadow")[1]

	if v1 then
		v1:RemoveTag("AnomalyShadow")
		v1:SetAttribute("AnomalyShadowActive", false)
		v1:RemoveTag("StalkerJumpscare")
		v1:SetAttribute("StalkerJumpscare", false)
	end
end
task.spawn(function() --[[ Line: 192 ]]
	game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("Idle")
end)
function t.ApplyVisualMutation(p1) --[[ ApplyVisualMutation | Line: 197 ]] end

return t