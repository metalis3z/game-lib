-- TutorialServiceClient (Client ModuleScript)
-- Place: ReplicatedStorage > Source > Features > Tutorial > TutorialServiceClient

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local client = require(ReplicatedStorage.Packages.DataService).client
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Networker = require(ReplicatedStorage.Packages.Networker)
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local TutorialServiceUtils = require(script.Parent.TutorialServiceUtils)
local Vide = require(ReplicatedStorage.Packages.Vide)

local t1 = {}

-- ─── Normalize equipped table ─────────────────────────────────────────────────
-- RollService saves equipped as array-style {[1]="uid1", [2]="uid2"}
-- but TutorialServiceUtils expects dict-style {"uid1"=true} OR a normalized map.
-- This converts array-style to dict-style so ALL tutorial checks work correctly.
local function normalizeEquipped(equipped)
	if type(equipped) ~= "table" then return {} end
	local result = {}
	for k, v in pairs(equipped) do
		if type(k) == "number" and type(v) == "string" then
			-- array style: {[1]="uid"} → {"uid"=true}
			result[v] = true
		elseif type(k) == "string" and (v == true or type(v) == "boolean") then
			-- dict style: already correct
			result[k] = true
		end
	end
	return result
end

local function getExtraEquipSlots()
	return MonetizationServiceUtils.getExtraEquipSlots(function(p1)
		local v59 = Products[p1]
		return v59 ~= nil and MonetizationServiceClient:ownsGamepass(v59)
	end)
end

function t1.init(p2)
	p2.networker = Networker.client.new("TutorialService", p2)
	p2.janitor = Janitor.new()
	p2.enemyCountSource = Vide.source(0)
	p2.trackedEnemies = {}
	p2.firstEnemyCameraFinished = p2:hasCompletedTutorial()
	p2.focusedEnemyUniqueId = nil
	p2.previousCameraOffset = nil
end

function t1.syncStep(p2, newStep: string)
	if type(newStep) ~= "string" then return end
	print("[TutorialServiceClient] Server syncStep ->", newStep)
	if newStep == "complete" then
		client:set({"tutorial", "step"}, "complete")
		client:set({"tutorial", "completed"}, true)
	else
		client:set({"tutorial", "step"}, newStep)
	end
	local stepNum = TutorialServiceUtils.getStepNumFromStep(newStep)
	local killedNum = TutorialServiceUtils.getStepNumFromStep("enemyKilled")
	if stepNum and killedNum and stepNum > killedNum then
		p2.firstEnemyCameraFinished = true
		p2:stopFirstEnemyCameraFocus()
	end
end

function t1.advanceStep(p3, s1: string)
	if p3:hasCompletedTutorial() then
		return false
	end
	local currentClientStep = client:get({"tutorial", "step"})
	if s1 ~= currentClientStep then
		warn("[TutorialServiceClient] advanceStep called with stale step:",
			s1, "current:", currentClientStep)
		return false
	end
	local v18, v19 = p3.networker:fetch("requestAdvanceStep", s1)
	if not v18 and type(v19) == "string" then
		print("[TutorialServiceClient] Resyncing to server step:", v19)
		if v19 == "complete" then
			client:set({"tutorial", "step"}, "complete")
			client:set({"tutorial", "completed"}, true)
		else
			client:set({"tutorial", "step"}, v19)
		end
		return false
	end
	if not v18 or type(v19) ~= "string" then
		return false
	end
	client:set({"tutorial", "step"}, v19)
	if v19 == "complete" then
		client:set({"tutorial", "completed"}, true)
	end
	if TutorialServiceUtils.getStepNumFromStep(v19) and
		TutorialServiceUtils.getStepNumFromStep(v19) >
		TutorialServiceUtils.getStepNumFromStep("enemyKilled") then
		p3.firstEnemyCameraFinished = true
		p3:stopFirstEnemyCameraFocus()
	end
	return true
end

function t1.getStep(p4)
	if p4:hasCompletedTutorial() then return nil end
	return client:get({"tutorial", "step"})
end

function t1.getStepIndex(p5)
	return TutorialServiceUtils.getStepNumFromStep(p5:getStep())
end

function t1.hasCompletedTutorial(_)
	return (client:get("tutorial") or {}).completed == true
end

function t1.isInTutorial(p7)
	return not p7:hasCompletedTutorial()
end

function t1.shouldShowUpgradeButton(_)
	return TutorialServiceUtils.shouldShowUpgradeButton(
		client:get("tutorial") or {},
		client:get("upgrades") or {}
	)
end

function t1.shouldShowBackpackButton(_)
	return TutorialServiceUtils.shouldShowBackpackButton(
		client:get("tutorial") or {},
		client:get("upgrades") or {}
	)
end

function t1.canOpenMenu(_, s2: string?)
	return TutorialServiceUtils.canOpenMenu(client:get("tutorial") or {}, s2)
end

function t1.canOpenUpgradeScreen(_)
	return TutorialServiceUtils.canOpenUpgradeScreen(client:get("tutorial") or {})
end

function t1.canOpenUpgradeTree(_)
	return TutorialServiceUtils.canOpenUpgradeTree(client:get("tutorial") or {})
end

function t1.canRoll(_)
	return TutorialServiceUtils.canRoll(client:get("tutorial") or {})
end

function t1.canUnlockUpgrade(_, s3: string)
	return TutorialServiceUtils.canUnlockUpgrade(client:get("tutorial") or {}, s3)
end

function t1.canPurchaseZone(_, n1: number)
	return TutorialServiceUtils.canPurchaseZone(client:get("tutorial") or {}, n1)
end

function t1.getRecommendedEquipUniqueId(_)
	return TutorialServiceUtils.getRecommendedEquipUniqueId(
		client:get("inventory") or {},
		normalizeEquipped(client:get("equipped") or {}),  -- FIXED
		client:get("upgrades") or {},
		getExtraEquipSlots()
	)
end

function t1.isBestEquipSatisfied(_)
	return TutorialServiceUtils.isBestEquipSatisfied(
		client:get("inventory") or {},
		normalizeEquipped(client:get("equipped") or {}),  -- FIXED
		client:get("upgrades") or {},
		getExtraEquipSlots()
	)
end

function t1.canEquipSlime(_, s4: string)
	return TutorialServiceUtils.canEquipSlime(
		client:get("tutorial") or {},
		s4,
		client:get("inventory") or {},
		normalizeEquipped(client:get("equipped") or {}),  -- FIXED
		client:get("upgrades") or {},
		getExtraEquipSlots()
	)
end

function t1.canEquipSlimeIfSpace(_, s5: string)
	return TutorialServiceUtils.canEquipSlimeIfSpace(
		client:get("tutorial") or {},
		s5,
		client:get("inventory") or {},
		normalizeEquipped(client:get("equipped") or {}),  -- FIXED
		client:get("upgrades") or {},
		getExtraEquipSlots()
	)
end

function t1.canEquipBest(_)
	return TutorialServiceUtils.canEquipBest(client:get("tutorial") or {})
end

function t1.canUnequipSlime(_)
	return TutorialServiceUtils.canUnequipSlime(client:get("tutorial") or {})
end

function t1.canUseInventoryItems(_)
	return TutorialServiceUtils.canUseInventoryItems(client:get("tutorial") or {})
end

function t1.getEnemyCount(p23)
	return p23.enemyCountSource()
end

function t1.startFirstEnemyCameraFocus(p24, n2: number)
	if p24.focusedEnemyUniqueId ~= nil or p24.firstEnemyCameraFinished then
		return
	end
	local v47 = p24.trackedEnemies[n2]
	local CurrentCamera = Workspace.CurrentCamera
	if v47 == nil or CurrentCamera == nil then return end
	p24.focusedEnemyUniqueId = n2
	local elapsed = os.clock()
	RunService:BindToRenderStep("TutorialFirstEnemyCamera",
		Enum.RenderPriority.Camera.Value + 1,
		function()
			local CurrentCamera2 = Workspace.CurrentCamera
			local Character = Players.LocalPlayer.Character
			local v62 = p24.trackedEnemies[n2]
			if CurrentCamera2 == nil or Character == nil
				or v62 == nil or v62.model.Parent == nil then
				p24:stopFirstEnemyCameraFocus()
				return
			end
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart == nil or not HumanoidRootPart:IsA("BasePart") then
				return
			end
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if Humanoid == nil then return end
			if os.clock() - elapsed >= 0.4 then
				p24:stopFirstEnemyCameraFocus()
				return
			end
			local pos = v62.pos
			local v66 = pos + Vector3.new(0, 2.5, 0)
			if p24.previousCameraOffset == nil then
				p24.previousCameraOffset = Humanoid.CameraOffset
			end
			local HumanoidRootPartPosition = HumanoidRootPart.Position
			local vector3 = Vector3.new(pos.X, HumanoidRootPartPosition.Y, pos.Z)
			if (vector3 - HumanoidRootPartPosition).Magnitude > 0.001 then
				HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(
					CFrame.lookAt(HumanoidRootPartPosition, vector3), 0.28)
			end
			Humanoid.CameraOffset = Vector3.new(5, 2.25, 0)
			CurrentCamera2.CFrame = CurrentCamera2.CFrame:Lerp(
				CFrame.lookAt(CurrentCamera2.CFrame.Position, v66), 0.35)
		end
	)
end

function t1.stopFirstEnemyCameraFocus(p25)
	if p25.focusedEnemyUniqueId == nil then return end
	RunService:UnbindFromRenderStep("TutorialFirstEnemyCamera")
	p25.focusedEnemyUniqueId = nil
	local Character = Players.LocalPlayer.Character
	local v52 = Character and Character:FindFirstChildOfClass("Humanoid")
	if v52 ~= nil and p25.previousCameraOffset ~= nil then
		v52.CameraOffset = p25.previousCameraOffset
	end
	p25.previousCameraOffset = nil
end

function t1.onEnemyAdded(p26, p27)
	if p26.trackedEnemies[p27.uniqueId] == nil then
		p26.enemyCountSource(p26.enemyCountSource() + 1)
	end
	p26.trackedEnemies[p27.uniqueId] = p27
	local v55 = p26:getStep()
	if v55 == "rollCompleted" or v55 == "enemySpawned" then
		p26:startFirstEnemyCameraFocus(p27.uniqueId)
	end
end

function t1.onEnemyRemoving(p28, n3: number)
	if p28.trackedEnemies[n3] ~= nil then
		p28.trackedEnemies[n3] = nil
		p28.enemyCountSource(math.max(p28.enemyCountSource() - 1, 0))
	end
	if n3 == p28.focusedEnemyUniqueId then
		p28:stopFirstEnemyCameraFocus()
	end
end

return t1