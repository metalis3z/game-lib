-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TutorialRoot, time of decompilation: Sun May  3 10:12:00 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Vide = require(ReplicatedStorage.Packages.Vide)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)
local TutorialSlice = require(ReplicatedStorage.Source.Features.Tutorial.TutorialSlice)
local Pointer = require(ReplicatedStorage.Source.Features.Tutorial.UI.Components.Pointer)
local InstructionLabel = require(ReplicatedStorage.Source.Features.Tutorial.UI.Components.InstructionLabel)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local vector2 = Vector2.new(128, 128)
local t1 = {
	firstRoll = {
		text = "Roll your first Slime!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 40
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("RollButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.35, 0.15),
		anchorPoint = Vector2.new(0.5, 1)
	},
	rollCompleted = {
		text = "Slimes fight automatically!"
	},
	enemySpawned = {
		text = "Slimes fight automatically!"
	},
	secondRoll = {
		text = "Roll another Slime!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 56
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("RollButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.35, 0.15),
		anchorPoint = Vector2.new(0.5, 1)
	},
	thirdRoll = {
		text = "Roll one more Slime!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 66
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("RollButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.35, 0.15),
		anchorPoint = Vector2.new(0.5, 1)
	},
	openUpgrades = {
		text = "Open Upgrades!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 76
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("UpgradeButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.35, 0.2),
		anchorPoint = Vector2.new(0.5, 1)
	},
	buyBackpackUpgrade = {
		text = "Unlock the Backpack!",
		rotation = 235,
		target = function() --[[ target ]] -- line: 86
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("backpackTile", true))
			end

			return nil
		end,
		position = UDim2.fromOffset(180, -30),
		anchorPoint = Vector2.new(0.5, 0.5)
	},
	closeUpgrades = {
		text = "Close Upgrades!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 96
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
			local v30 = if not PlayerGui then nil else PlayerGui:FindFirstChild("Root")

			if v30 == nil then
				return nil
			end

			local UpgradeScreen = v30:FindFirstChild("UpgradeScreen")

			if UpgradeScreen then
				return (UpgradeScreen:FindFirstChild("CloseButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.4, 0),
		anchorPoint = Vector2.new(0.5, 1)
	},
	openBackpack = {
		text = "Open your Backpack!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 112
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("BackpackButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.35, 0.2),
		anchorPoint = Vector2.new(0.5, 1)
	},
	equipBetterSlime = {
		text = "Equip the Slime!",
		rotation = -90,
		target = function() --[[ target ]] -- line: 122
			-- upvalues: TutorialServiceClient (copy), Players (copy)
			local v33 = TutorialServiceClient:getRecommendedEquipUniqueId()

			if v33 == nil then
				return nil
			end

			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui == nil then
				return nil
			end

			return (PlayerGui:FindFirstChild("InventorySlime_" .. v33, true))
		end,
		position = UDim2.fromScale(1, 0.5),
		anchorPoint = Vector2.new(0, 0.5)
	},
	closeBackpack = {
		text = "Close your Backpack!",
		rotation = 70,
		target = function() --[[ target ]] -- line: 141
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
			local v36 = if not PlayerGui then nil else PlayerGui:FindFirstChild("Root")

			if v36 == nil then
				return nil
			end

			local Inventory = v36:FindFirstChild("Inventory")

			if Inventory then
				return (Inventory:FindFirstChild("CloseButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.1, 1.5),
		anchorPoint = Vector2.new(1, 0.5)
	},
	earnCoins200 = {
		text = "Earn $200!"
	},
	openUpgradeForAuto = {
		text = "Unlock Auto Roll!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 160
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("UpgradeButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.5, 0),
		anchorPoint = Vector2.new(0.5, 1)
	},
	buyAutoUpgrade = {
		text = "Unlock Auto Roll!",
		rotation = 305,
		target = function() --[[ target ]] -- line: 170
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui then
				return (PlayerGui:FindFirstChild("autoRollTile", true))
			end

			return nil
		end,
		position = UDim2.fromOffset(180, 130),
		anchorPoint = Vector2.new(0.5, 0.5)
	},
	closeUpgradeForAuto = {
		text = "Close Upgrades!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 180
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
			local v41 = if not PlayerGui then nil else PlayerGui:FindFirstChild("Root")

			if v41 == nil then
				return nil
			end

			local UpgradeScreen = v41:FindFirstChild("UpgradeScreen")

			if UpgradeScreen then
				return (UpgradeScreen:FindFirstChild("CloseButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.4, 0),
		anchorPoint = Vector2.new(0.5, 1)
	},
	earnCoins400 = {
		text = "Earn $400!"
	},
	unlockZone2 = {
		text = "Unlock Zone 2!",
		rotation = 180,
		target = function() --[[ target ]] -- line: 199
			-- upvalues: Players (copy)
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

			if PlayerGui == nil then
				return nil
			end

			local ZonePurchase = PlayerGui:FindFirstChild("ZonePurchase")

			if ZonePurchase then
				return (ZonePurchase:FindFirstChild("BuyButton", true))
			end

			return nil
		end,
		position = UDim2.fromScale(0.5, 0),
		anchorPoint = Vector2.new(0.5, 1)
	}
}

local function shouldAdvanceStep(s1: string, n1: number, n2: number, n3: number, n4: number, t2: {[any]: any}, s2: string?, b1: boolean, b2: boolean, n5: number, b3: boolean) -- line: 214
	if s1 == "init" then
		return true
	end

	if s1 == "firstRoll" then
		return n1 >= 1 and not b2
	end

	if s1 == "rollCompleted" then
		return n5 > 0
	end

	if s1 == "enemySpawned" then
		return n2 >= 1
	end

	if s1 == "enemyKilled" or s1 == "secondRollCompleted" or s1 == "thirdRollCompleted" then
		return true
	end

	if s1 == "secondRoll" then
		return n1 >= 2
	end

	if s1 == "thirdRoll" then
		return n1 >= 3
	end

	if s1 == "openUpgrades" or s1 == "openUpgradeForAuto" then
		return b1
	end

	if s1 == "buyBackpackUpgrade" then
		return t2.backpack == true
	end

	if s1 == "closeUpgrades" or s1 == "closeUpgradeForAuto" then
		return not b1
	end

	if s1 == "openBackpack" then
		return s2 == "Inventory"
	end

	if s1 == "equipBetterSlime" then
		return b3
	end

	if s1 == "closeBackpack" then
		return s2 ~= "Inventory"
	end

	if s1 == "earnCoins200" then
		return n3 >= 200
	end

	if s1 == "buyAutoUpgrade" then
		return t2.autoRoll == true
	end

	if s1 == "earnCoins400" then
		return n3 >= 400
	end

	if s1 == "unlockZone2" then
		return n4 >= 2
	end

	return false
end
local function getPresentedStep(s3: string?) -- line: 298
	-- upvalues: t1 (copy), TutorialServiceUtils (copy)
	local v57 = s3
	local t3 = {}

	while type(v57) == "string" and not t3[v57] do
		t3[v57] = true

		if t1[v57] ~= nil then
			return v57
		end

		v57 = TutorialServiceUtils.getNextStep(v57)
	end

	return s3
end
local function updatePointerSprite(p1, n6: number) -- line: 330
	-- upvalues: vector2 (copy)
	local Sprite = p1:FindFirstChild("Sprite")

	if not Sprite or not Sprite:IsA("ImageLabel") then
		return
	end

	local v64 = math.floor(n6 * 20) % 6
	local v65 = ((if not (v64 < 4) then 4 - (v64 - 3) else v64 + 1)) - 1
	local v66 = v65 % 4
	local v67 = math.floor(v65 / 4)

	Sprite.ImageRectOffset = Vector2.new(v66 * vector2.X, v67 * vector2.Y)
end
local function getZoneGateBack(n7: number) -- line: 343
	-- upvalues: Workspace (copy)
	local Zones = Workspace:FindFirstChild("Zones")
	local v70 = Zones and Zones:FindFirstChild((tostring(n7)))
	local v71 = v70 and v70:FindFirstChild("Gate")
	local v72 = v71 and v71:FindFirstChild("Back")

	if v72 and v72:IsA("BasePart") then
		return v72
	end

	return nil
end

return function() -- line: 355
	-- upvalues: TutorialSlice (copy), getDataSource (copy), Vide (copy), VfxUtils (copy), Players (copy), getZoneGateBack (copy), Workspace (copy), getPresentedStep (copy), shouldAdvanceStep (copy), Menu (copy), UpgradeSlice (copy), screenCoveredSource (copy), TutorialServiceClient (copy), TutorialServiceUtils (copy), RunService (copy), RollSlice (copy), updatePointerSprite (copy), t1 (copy), Frame (copy), InstructionLabel (copy), Pointer (copy)
	local v73 = TutorialSlice.step()
	local v74 = TutorialSlice.completed()
	local v75 = getDataSource({
		"stats",
		"rolls"
	})
	local v76 = getDataSource({
		"stats",
		"kills"
	})
	local v77 = getDataSource("coins")
	local v78 = getDataSource("maxZone")
	local v79 = getDataSource("inventory")
	local v80 = getDataSource("equipped")
	local v81 = getDataSource("upgrades")
	local u82 = false
	local v83 = Vide.source(nil)
	local u84 = nil
	local u85 = nil
	local u86 = nil

	local function ensureGuideBeam() -- line: 391
		-- upvalues: Players (copy), getZoneGateBack (copy), u84 (ref), VfxUtils (copy), u85 (ref), u86 (ref), Workspace (copy)
		local Character = Players.LocalPlayer.Character
		local v89 = Character and Character:FindFirstChild("HumanoidRootPart")
		local v90 = getZoneGateBack(2)

		if not v89 or (not v89:IsA("BasePart") or v90 == nil) then
			if u84 ~= nil then
				u84.Enabled = false
				u84.Attachment0 = nil
				u84.Attachment1 = nil
				VfxUtils.cacheVfx("ArrowGuideBeam", u84)
				u84 = nil
			end

			if u85 ~= nil then
				u85:Destroy()
				u85 = nil
			end

			if u86 ~= nil then
				u86:Destroy()
				u86 = nil
			end

			return
		end

		if u84 == nil or u84.Parent == nil then
			local v91 = VfxUtils.getVfx("ArrowGuideBeam", Workspace)

			assert(v91:IsA("Beam"), string.format("VFX '%s' must be a Beam", "ArrowGuideBeam"))
			u84 = v91
		end

		if u85 == nil or v89 ~= u85.Parent then
			if u85 ~= nil then
				u85:Destroy()
			end

			local Attachment = Instance.new("Attachment")

			Attachment.Name = "TutorialGuideBeamStart"
			Attachment.Position = Vector3.new(0, 2, 0)
			Attachment.Parent = v89
			u85 = Attachment
		end

		if u86 == nil or v90 ~= u86.Parent then
			if u86 ~= nil then
				u86:Destroy()
			end

			local Attachment = Instance.new("Attachment")

			Attachment.Name = "TutorialGuideBeamEnd"
			Attachment.Position = Vector3.new(0, v90.Size.Y * 0.15, 0)
			Attachment.Parent = v90
			u86 = Attachment
		end

		u84.Attachment0 = u85
		u84.Attachment1 = u86
		u84.Enabled = true
	end

	Vide.effect(function() -- line: 445
		-- upvalues: v73 (copy), v74 (copy), shouldAdvanceStep (copy), v75 (copy), v76 (copy), v77 (copy), v78 (copy), v81 (copy), Menu (copy), UpgradeSlice (copy), screenCoveredSource (copy), TutorialServiceClient (copy), TutorialServiceUtils (copy), v79 (copy), v80 (copy), u82 (ref), getPresentedStep (copy), v83 (copy)
		local v95 = v73()

		if v74() or type(v95) ~= "string" then
			return
		end

		if not shouldAdvanceStep(v95, v75() or 0, v76() or 0, v77() or 0, v78() or 1, v81() or {}, Menu.openedMenu(), UpgradeSlice.shown(), screenCoveredSource(), TutorialServiceClient:getEnemyCount(), TutorialServiceUtils.isBestEquipSatisfied(v79() or {}, v80() or {}, v81() or {})) or u82 then
			return
		end

		local v96 = getPresentedStep(TutorialServiceUtils.getNextStep(v95))
		local v97 = TutorialServiceUtils.getStepNumFromStep(v95) or 0
		local v98 = TutorialServiceUtils.getStepNumFromStep(v96)

		if v98 ~= nil and v97 < v98 then
			task.defer(function() -- line: 436
				-- upvalues: v83 (copy), v96 (copy)
				v83(v96)
			end)
		end

		u82 = true
		task.spawn(function() -- line: 477
			-- upvalues: TutorialServiceClient (copy), v95 (copy), v83 (copy), u82 (ref)
			if not TutorialServiceClient:advanceStep(v95) then
				local v113 = nil

				task.defer(function() -- line: 436
					-- upvalues: v83 (copy), v113 (copy)
					v83(v113)
				end)
			end

			u82 = false
		end)
	end)
	Vide.effect(function() -- line: 486
		-- upvalues: v83 (copy), v74 (copy), v73 (copy), TutorialServiceUtils (copy)
		local v99 = v83()

		if v99 == nil then
			return
		end

		if v74() then
			local v100 = nil

			task.defer(function() -- line: 436
				-- upvalues: v83 (copy), v100 (copy)
				v83(v100)
			end)

			return
		end

		local v101 = v73()
		local v102 = TutorialServiceUtils.getStepNumFromStep(v101) or 0
		local v103 = TutorialServiceUtils.getStepNumFromStep(v99)

		if v103 ~= nil and v103 <= v102 then
			local v104 = nil

			task.defer(function() -- line: 436
				-- upvalues: v83 (copy), v104 (copy)
				v83(v104)
			end)
		end
	end)
	Vide.effect(function() -- line: 505
		-- upvalues: v73 (copy), v74 (copy), Menu (copy), TutorialServiceUtils (copy), UpgradeSlice (copy)
		local v105 = v73()
		local v106 = v74()
		local t4 = {
			step = v105,
			completed = v106
		}

		if v106 then
			return
		end

		local v108 = Menu.openedMenu()

		if v108 ~= nil and not TutorialServiceUtils.canOpenMenu(t4, v108) then
			task.defer(function() -- line: 519
				-- upvalues: Menu (copy), v108 (copy)
				if Menu.openedMenu() == v108 then
					Menu.setOpenedMenu(nil)
				end
			end)
		end

		if UpgradeSlice.shown() and not TutorialServiceUtils.canOpenUpgradeScreen(t4) then
			task.defer(function() -- line: 527
				-- upvalues: UpgradeSlice (copy)
				if UpgradeSlice.shown() then
					UpgradeSlice.shown(false)
				end
			end)
		end

		if UpgradeSlice.tree() ~= "main" and not TutorialServiceUtils.canOpenUpgradeTree(t4) then
			task.defer(function() -- line: 535
				-- upvalues: UpgradeSlice (copy)
				if UpgradeSlice.tree() ~= "main" then
					UpgradeSlice.tree("main")
				end
			end)
		end
	end)
	Vide.effect(function() -- line: 543
		-- upvalues: RunService (copy), v83 (copy), getPresentedStep (copy), v73 (copy), v74 (copy), RollSlice (copy), ensureGuideBeam (copy), u84 (ref), VfxUtils (copy), u85 (ref), u86 (ref), Vide (copy)
		local connection = RunService.RenderStepped:Connect(function() -- line: 544
			-- upvalues: v83 (copy), getPresentedStep (copy), v73 (copy), v74 (copy), RollSlice (copy), ensureGuideBeam (copy), u84 (ref), VfxUtils (copy), u85 (ref), u86 (ref)
			local v114 = v83() or getPresentedStep(v73())

			if not v74() and (not (RollSlice.rollScreenShown() or (RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil)) and v114 == "unlockZone2") then
				ensureGuideBeam()

				return
			end

			if u84 ~= nil then
				u84.Enabled = false
				u84.Attachment0 = nil
				u84.Attachment1 = nil
				VfxUtils.cacheVfx("ArrowGuideBeam", u84)
				u84 = nil
			end

			if u85 ~= nil then
				u85:Destroy()
				u85 = nil
			end

			if u86 ~= nil then
				u86:Destroy()
				u86 = nil
			end
		end)

		Vide.cleanup(function() -- line: 557
			-- upvalues: connection (copy), u84 (ref), VfxUtils (copy), u85 (ref), u86 (ref)
			connection:Disconnect()

			if u84 ~= nil then
				u84.Enabled = false
				u84.Attachment0 = nil
				u84.Attachment1 = nil
				VfxUtils.cacheVfx("ArrowGuideBeam", u84)
				u84 = nil
			end

			if u85 ~= nil then
				u85:Destroy()
				u85 = nil
			end

			if u86 ~= nil then
				u86:Destroy()
				u86 = nil
			end
		end)
	end)
	Vide.effect(function() -- line: 563
		-- upvalues: RunService (copy), Players (copy), updatePointerSprite (copy), v83 (copy), getPresentedStep (copy), v73 (copy), v74 (copy), RollSlice (copy), t1 (copy), Vide (copy)
		local connection = RunService.RenderStepped:Connect(function() -- line: 564
			-- upvalues: Players (copy), updatePointerSprite (copy), v83 (copy), getPresentedStep (copy), v73 (copy), v74 (copy), RollSlice (copy), t1 (copy)
			local elapsed = os.clock()
			local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
			local v117 = PlayerGui and PlayerGui:FindFirstChild("Root")
			local v118 = v117 and v117:FindFirstChild("TutorialOverlay")
			local v119 = v118 and v118:FindFirstChild("TutorialPointerTemplate")
			local v120 = PlayerGui and PlayerGui:FindFirstChild("TutorialPointer", true)

			if v120 == nil and (v119 and v119:IsA("Frame") and v118) then
				v120 = v119:Clone()
				v120.Name = "TutorialPointer"
				v120.Visible = false
				v120.Parent = v118
			end

			if not v120 or not v120:IsA("Frame") then
				return
			end

			updatePointerSprite(v120, elapsed)

			if v119 and v119:IsA("Frame") then
				updatePointerSprite(v119, elapsed)
			end

			local v121 = v83() or getPresentedStep(v73())

			if v74() or (RollSlice.rollScreenShown() or (RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil)) or type(v121) ~= "string" then
				if v118 and v118 ~= v120.Parent then
					v120.Parent = v118
				end

				v120.Visible = false

				return
			end

			local v122 = t1[v121]

			if v122 == nil or v122.target == nil or v122.position == nil or v122.rotation == nil or v122.anchorPoint == nil then
				if v118 and v118 ~= v120.Parent then
					v120.Parent = v118
				end

				v120.Visible = false

				return
			end

			local v123 = v122.target()

			if v123 == nil or v123.AbsoluteSize.Magnitude <= 0 then
				if v118 and v118 ~= v120.Parent then
					v120.Parent = v118
				end

				v120.Visible = false

				return
			end

			if v123 ~= v120.Parent then
				v120.Parent = v123
			end

			v120.AnchorPoint = v122.anchorPoint
			v120.Position = v122.position
			v120.Rotation = v122.rotation
			v120.Visible = true
		end)

		Vide.cleanup(function() -- line: 627
			-- upvalues: connection (copy)
			connection:Disconnect()
		end)
	end)

	return Frame({
		Name = "TutorialOverlay",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = function() --[[ Visible ]] -- line: 636
			-- upvalues: v74 (copy)
			return not v74()
		end,
		ZIndex = 450,
		InstructionLabel({
			Text = function() --[[ Text ]] -- line: 642
				-- upvalues: t1 (copy), v83 (copy), getPresentedStep (copy), v73 (copy)
				local v111 = t1[v83() or getPresentedStep(v73()) or ""]

				if v111 then
					return v111.text or ""
				end

				return ""
			end,
			Visible = function() --[[ Visible ]] -- line: 646
				-- upvalues: t1 (copy), v83 (copy), getPresentedStep (copy), v73 (copy), v74 (copy), RollSlice (copy)
				local v112 = t1[v83() or getPresentedStep(v73()) or ""]

				return v112 ~= nil and (v112.text ~= nil and (not v74() and not (RollSlice.rollScreenShown() or (RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil))))
			end
		}),
		Pointer({
			Name = "TutorialPointerTemplate",
			Rotation = 0,
			Visible = false,
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0.5, 0.5)
		})
	})
end
