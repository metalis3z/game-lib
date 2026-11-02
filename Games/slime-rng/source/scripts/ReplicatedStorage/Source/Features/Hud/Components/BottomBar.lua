-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BottomBar, time of decompilation: Sun May  3 10:11:24 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local InventoryMenu = require(ReplicatedStorage.Source.Features.Inventory.UI.InventoryMenu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local BottomBarButton = require(script.Parent.BottomBarButton)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local SpecialRollUtils = require(ReplicatedStorage.Source.Features.Roll.SpecialRollUtils)
local SpecialRollStatusIcon = require(ReplicatedStorage.Source.Features.Roll.UI.Components.SpecialRollStatusIcon)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local TutorialServiceUtils = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceUtils)
local TutorialSlice = require(ReplicatedStorage.Source.Features.Tutorial.TutorialSlice)
local UpgradeCounterUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeCounterUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return function() -- line: 40
	-- upvalues: getDataSource (copy), TutorialSlice (copy), Vide (copy), UpgradeCounterUtils (copy), RollSlice (copy), SpecialRollUtils (copy), UpgradeServiceUtils (copy), SpecialDiceServiceUtils (copy), ImageIds (copy), SpecialRollStatusIcon (copy), RollServiceClient (copy), SlideFrame (copy), screenCoveredSource (copy), Frame (copy), UIListLayout (copy), BottomBarButton (copy), TutorialServiceUtils (copy), TutorialServiceClient (copy), InventoryMenu (copy), UpgradeSlice (copy)
	local v26 = getDataSource("upgrades")
	local v27 = getDataSource("armedSpecialDice")
	local v28 = getDataSource("armedJackpotSpins")
	local v29 = getDataSource("specialRollProgression")
	local v30 = TutorialSlice.step()
	local v31 = TutorialSlice.completed()
	local v32 = Vide.source(1)
	local v33 = Vide.spring(v32, 0.22, 0.5)
	local t1 = {}

	for _, v36 in UpgradeCounterUtils.getCurrencyPaths() do
		t1[v36] = getDataSource(v36)
	end

	local u37 = RollSlice.rollResults()[1] ~= nil
	local u38 = nil

	Vide.effect(function() -- line: 58
		-- upvalues: RollSlice (copy), u37 (ref), v32 (copy), u38 (ref), Vide (copy)
		local v42 = RollSlice.rollResults()[1] ~= nil

		if v42 and not u37 then
			v32(1.09)

			if u38 then
				task.cancel(u38)
			end

			u38 = task.delay(0.12, function() -- line: 65
				-- upvalues: v32 (copy), u38 (ref)
				v32(1)
				u38 = nil
			end)
		elseif not v42 and not u38 then
			v32(1)
		end

		u37 = v42
		Vide.cleanup(function() -- line: 75
			-- upvalues: u38 (ref)
			if u38 then
				task.cancel(u38)
				u38 = nil
			end
		end)
	end)

	local v39 = Vide.derive(function() -- line: 88
		-- upvalues: UpgradeServiceUtils (copy), v26 (copy)
		return UpgradeServiceUtils.ownsUpgrade("backpack", v26() or {})
	end)

	local function getDisplayedSpecialRollKind() -- line: 112
		-- upvalues: SpecialRollUtils (copy), RollSlice (copy), v26 (copy), v29 (copy)
		local t2 = {}

		for _, v48 in SpecialRollUtils.getKinds() do
			if RollSlice.activeSpecialRolls()[v48] == true or if SpecialRollUtils.isUnlocked(v48, v26()) then SpecialRollUtils.resolveProgression(v29(), v26())[v48].rollsUntilNext <= 0 else false then
				t2[v48] = true
			end
		end

		return SpecialRollUtils.getHighestPriorityActiveKind(t2)
	end
	local function createSpecialRollIcon(p1, uDim2: UDim2) -- line: 137
		-- upvalues: SpecialRollUtils (copy), v26 (copy), RollSlice (copy), v29 (copy), getDisplayedSpecialRollKind (copy), SpecialRollStatusIcon (copy), RollServiceClient (copy)
		return SpecialRollStatusIcon({
			Name = `{ p1 }RollStatusIcon`,
			Image = SpecialRollUtils.getImage(p1),
			Position = uDim2,
			Visible = function() --[[ isVisible ]] -- line: 138
				-- upvalues: SpecialRollUtils (copy), p1 (copy), v26 (copy), RollSlice (copy), v29 (copy), getDisplayedSpecialRollKind (copy)
				if not SpecialRollUtils.isUnlocked(p1, v26()) then
					return false
				end

				local v54 = p1

				if RollSlice.activeSpecialRolls()[v54] == true or if SpecialRollUtils.isUnlocked(v54, v26()) then SpecialRollUtils.resolveProgression(v29(), v26())[v54].rollsUntilNext <= 0 else false then
					return getDisplayedSpecialRollKind() ~= p1
				end

				return true
			end,
			ShowCounter = function() --[[ ShowCounter ]] -- line: 159
				-- upvalues: p1 (copy), RollSlice (copy), SpecialRollUtils (copy), v26 (copy), v29 (copy)
				local v55 = p1

				return not (RollSlice.activeSpecialRolls()[v55] == true or if SpecialRollUtils.isUnlocked(v55, v26()) then SpecialRollUtils.resolveProgression(v29(), v26())[v55].rollsUntilNext <= 0 else false)
			end,
			Active = function() --[[ Active ]] -- line: 162
				-- upvalues: p1 (copy), RollSlice (copy), SpecialRollUtils (copy), v26 (copy), v29 (copy)
				local v56 = p1
				local v57 = true

				if RollSlice.activeSpecialRolls()[v56] ~= true then
					if not SpecialRollUtils.isUnlocked(v56, v26()) then
						return false
					end

					v57 = SpecialRollUtils.resolveProgression(v29(), v26())[v56].rollsUntilNext <= 0
				end

				return v57
			end,
			Paused = function() --[[ Paused ]] -- line: 165
				-- upvalues: SpecialRollUtils (copy), v29 (copy), v26 (copy), p1 (copy)
				return SpecialRollUtils.resolveProgression(v29(), v26())[p1].paused
			end,
			RollsUntilNext = function() --[[ RollsUntilNext ]] -- line: 168
				-- upvalues: p1 (copy), RollSlice (copy), SpecialRollUtils (copy), v26 (copy), v29 (copy)
				local v58 = p1

				if RollSlice.activeSpecialRolls()[v58] == true or if SpecialRollUtils.isUnlocked(v58, v26()) then SpecialRollUtils.resolveProgression(v29(), v26())[v58].rollsUntilNext <= 0 else false then
					return 0
				end

				return SpecialRollUtils.resolveProgression(v29(), v26())[p1].rollsUntilNext
			end,
			Progress = function() --[[ Progress ]] -- line: 174
				-- upvalues: RollSlice (copy), p1 (copy), SpecialRollUtils (copy), v29 (copy), v26 (copy)
				if RollSlice.activeSpecialRolls()[p1] then
					return 1
				end

				return SpecialRollUtils.getProgress(p1, SpecialRollUtils.resolveProgression(v29(), v26()), v26())
			end,
			Activated = function() --[[ Activated ]] -- line: 180
				-- upvalues: SpecialRollUtils (copy), v29 (copy), v26 (copy), p1 (copy), RollServiceClient (copy)
				local v59 = SpecialRollUtils.resolveProgression(v29(), v26())[p1]

				RollServiceClient:setSpecialRollPaused(p1, not v59.paused)
			end
		})
	end

	return SlideFrame({
		Name = "BottomBar",
		Shown = function() --[[ Shown ]] -- line: 189
			-- upvalues: screenCoveredSource (copy)
			return not screenCoveredSource()
		end,
		ShownPosition = UDim2.fromScale(0.5, 0.98),
		HiddenPosition = UDim2.fromScale(0.5, 1.3),
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.fromOffset(500, 140),
		Frame({
			Name = "ButtonRow",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 20)
			}),
			BottomBarButton({
				Name = "BackpackButton",
				Label = "BACKPACK",
				LayoutOrder = 1,
				Visible = function() --[[ Visible ]] -- line: 213
					-- upvalues: TutorialServiceUtils (copy), v30 (copy), v31 (copy), v26 (copy)
					return TutorialServiceUtils.shouldShowBackpackButton({
						step = v30(),
						completed = v31()
					}, v26() or {})
				end,
				Image = ImageIds.backpack,
				ImageColor3 = function() --[[ ImageColor3 ]] -- line: 217
					-- upvalues: v39 (copy)
					if v39() then
						return Color3.fromRGB(255, 255, 255)
					end

					return Color3.fromRGB(70, 70, 70)
				end,
				Size = UDim2.fromOffset(105.3, 92.7),
				TextColor3 = function() --[[ TextColor3 ]] -- line: 224
					-- upvalues: v39 (copy)
					if v39() then
						return Color3.fromRGB(255, 255, 255)
					end

					return Color3.fromRGB(70, 70, 70)
				end,
				Activated = function() --[[ Activated ]] -- line: 230
					-- upvalues: v39 (copy), TutorialServiceClient (copy), InventoryMenu (copy)
					if v39() and TutorialServiceClient:canOpenMenu("Inventory") then
						InventoryMenu.openSlimesPage()
					end
				end,
				HintKeyCode = Enum.KeyCode.ButtonY,
				TextPosition = UDim2.fromScale(0.5, 0.9),
				IconPosition = UDim2.fromScale(0.5, 0.6),
				ShadowPosition = UDim2.fromScale(0.5, 1.1)
			}),
			BottomBarButton({
				Name = "RollButton",
				Label = "ROLL",
				LayoutOrder = 2,
				Image = function() --[[ getRollButtonImage ]] -- line: 123
					-- upvalues: SpecialDiceServiceUtils (copy), v27 (copy), v28 (copy), ImageIds (copy), getDisplayedSpecialRollKind (copy), SpecialRollUtils (copy)
					local v49 = SpecialDiceServiceUtils.getActiveItemId(v27(), v28())
					local v50 = SpecialDiceServiceUtils.getItemIcon(v49) or ImageIds.dice

					if v50 ~= ImageIds.dice then
						return v50
					end

					local v51 = getDisplayedSpecialRollKind()

					if v51 then
						return SpecialRollUtils.getImage(v51)
					end

					return v50
				end,
				Scale = v33,
				Size = UDim2.fromOffset(119.2, 130.8),
				Activated = function() --[[ Activated ]] -- line: 248
					-- upvalues: RollServiceClient (copy)
					RollServiceClient:activateRollButton()
				end,
				HintKeyCode = Enum.KeyCode.ButtonX,
				TextPosition = UDim2.fromScale(0.5, 0.9),
				Children = {
					createSpecialRollIcon("golden", UDim2.fromScale(0.05, 0)),
					createSpecialRollIcon("diamond", UDim2.fromScale(0.5, -0.19)),
					createSpecialRollIcon("void", UDim2.fromScale(0.95, 0))
				}
			}),
			BottomBarButton({
				Name = "UpgradeButton",
				Label = "UPGRADE",
				LayoutOrder = 3,
				Visible = function() --[[ Visible ]] -- line: 263
					-- upvalues: TutorialServiceUtils (copy), v30 (copy), v31 (copy), v26 (copy)
					return TutorialServiceUtils.shouldShowUpgradeButton({
						step = v30(),
						completed = v31()
					}, v26() or {})
				end,
				Image = ImageIds.upgradeButton,
				Size = UDim2.fromOffset(88.4, 99.2),
				TextPosition = UDim2.fromScale(0.5, 0.98),
				NotificationCount = function() --[[ NotificationCount ]] -- line: 270
					-- upvalues: UpgradeCounterUtils (copy), v26 (copy), t1 (copy)
					return UpgradeCounterUtils.countPurchasableTotal(v26(), function(s1: string) -- line: 271
						-- upvalues: t1 (copy)
						local v61 = t1[s1]

						if not v61 then
							return 0
						end

						local v62 = v61()

						if type(v62) ~= "number" then
							return 0
						end

						return v62
					end)
				end,
				Activated = function() --[[ Activated ]] -- line: 275
					-- upvalues: TutorialServiceClient (copy), UpgradeSlice (copy)
					if TutorialServiceClient:canOpenUpgradeScreen() then
						UpgradeSlice.shown(true)
					end
				end,
				HintKeyCode = Enum.KeyCode.DPadUp
			})
		})
	})
end
