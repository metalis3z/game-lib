-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NewSlimeScreen, time of decompilation: Sun May  3 10:11:46 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local create = Vide.create
local uDim2 = UDim2.fromScale(1, 0)
local uDim2_2 = UDim2.fromScale(1, 1)
local t1 = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.Touch] = true,
	[Enum.UserInputType.Keyboard] = true,
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}

local function getVisibleNewSlimeData() -- line: 52
	-- upvalues: RollSlice (copy)
	return RollSlice.activeNewSlimePopupData()
end
local function getRolledSlimeUniqueIds() -- line: 75
	-- upvalues: RollSlice (copy), InventoryServiceUtils (copy)
	local t2 = {}

	for _, v29 in RollSlice.rollResults() do
		local v30 = v29[#v29]

		if type(v30) == "table" and v30.id ~= nil then
			table.insert(t2, InventoryServiceUtils.genKey(v30))
		end
	end

	return t2
end
local function StatPill(t3: {[any]: any}) -- line: 100
	-- upvalues: Frame (copy), create (copy), TextLabel (copy)
	return Frame({
		Name = t3.label .. "Pill",
		LayoutOrder = t3.layoutOrder,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.88,
		BorderSizePixel = 0,
		create("UICorner")({
			CornerRadius = UDim.new(1, 0)
		}),
		create("UIStroke")({
			Transparency = 0.7,
			Thickness = 2,
			Color = Color3.fromRGB(255, 255, 255)
		}),
		TextLabel({
			Name = "Value",
			LayoutOrder = 2,
			Size = UDim2.fromScale(0.9, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Text = t3.value,
			Stroke = {},
			Prefix = {
				Image = t3.icon
			}
		})
	})
end
local function NewSlimeContent() -- line: 137
	-- upvalues: Vide (copy), getVisibleNewSlimeData (copy), uDim2 (copy), RollSlice (copy), SoundController (copy), Sounds (copy), uDim2_2 (copy), InventoryServiceUtils (copy), UserInputService (copy), t1 (copy), AutoScaledFrame (copy), Frame (copy), SlimeIcon (copy), TextLabel (copy), Slimes (copy), Mutations (copy), OddsLabel (copy), create (copy), StatPill (copy), ImageIds (copy), Abbreviate (copy)
	local v33 = Vide.source(getVisibleNewSlimeData())
	local v34 = Vide.source(uDim2)
	local v35 = Vide.spring(v34, 0.34, 0.68)
	local v36 = Vide.source(9)
	local v37 = Vide.spring(v36, 1, 0.4)
	local u38 = nil

	Vide.effect(function() -- line: 145
		-- upvalues: RollSlice (copy), v34 (copy), uDim2 (copy), v36 (copy), v33 (copy), u38 (ref), SoundController (copy), Sounds (copy), uDim2_2 (copy), Vide (copy)
		local v45 = RollSlice.activeNewSlimePopupData()

		if v45 == nil then
			v34(uDim2)
			v36(0)

			return
		end

		v33(v45)

		if u38 then
			task.cancel(u38)
			u38 = nil
		end

		v34(uDim2)
		v36(9)
		u38 = task.delay(0.03, function() -- line: 162
			-- upvalues: SoundController (copy), Sounds (copy), v34 (copy), uDim2_2 (copy), v36 (copy), u38 (ref)
			SoundController:Play(Sounds.ui.newItem)
			v34(uDim2_2)
			v36(-5)
			u38 = nil
		end)
		Vide.cleanup(function() -- line: 169
			-- upvalues: u38 (ref)
			if u38 then
				task.cancel(u38)
				u38 = nil
			end
		end)
	end)

	local v39 = Vide.derive(function() -- line: 177
		-- upvalues: v33 (copy)
		local v46 = v33()

		assert(v46 ~= nil, "Expected displayed slime data for visible NewSlimeScreen")

		return {
			level = 1,
			xp = 0,
			id = v46.id,
			mutations = v46.mutations
		}
	end)
	local v40 = Vide.derive(function() -- line: 182
		-- upvalues: InventoryServiceUtils (copy), v39 (copy)
		return InventoryServiceUtils.getVisualOdds(v39())
	end)
	local v41 = Vide.derive(function() -- line: 185
		-- upvalues: InventoryServiceUtils (copy), v39 (copy)
		return InventoryServiceUtils.getSlimeStatsFromData(v39())
	end)
	local connection = UserInputService.InputBegan:Connect(function(input) -- line: 193
		-- upvalues: t1 (copy), RollSlice (copy)
		if t1[input.UserInputType] ~= true or input.KeyCode == Enum.KeyCode.Unknown and (input.UserInputType ~= Enum.UserInputType.MouseButton1 and (input.UserInputType ~= Enum.UserInputType.MouseButton2 and input.UserInputType ~= Enum.UserInputType.Touch)) then
			return
		end

		RollSlice.actions.dismissNewSlime()
	end)

	Vide.cleanup(function() -- line: 201
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return AutoScaledFrame({
		Size = UDim2.fromOffset(2000, 250),
		MinSize = Vector2.new(0, 150),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Name = "NewSlimeBar",
		Frame({
			Name = "NewSlimeBar",
			Size = v35,
			Position = UDim2.fromScale(0.5, 0.53),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Rotation = v37,
			BackgroundColor3 = Color3.fromRGB(9, 9, 10),
			BackgroundTransparency = 0.365,
			ZIndex = 4001,
			SlimeIcon({
				SlimeData = v39,
				Size = UDim2.fromScale(1, 1),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5)
			}),
			TextLabel({
				Text = "NEW SLIME",
				Size = UDim2.fromScale(1, 0.25),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.fromScale(0.5, -0.01),
				Stroke = {
					Color = Color3.fromRGB(61, 52, 34)
				},
				Gradient = {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 199, 87))
					})
				}
			}),
			TextLabel({
				Name = "SlimeName",
				Size = UDim2.fromScale(1, 0.2),
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Text = function() --[[ Text ]] -- line: 251
					-- upvalues: Slimes (copy), v39 (copy), Mutations (copy)
					local v48 = Slimes.getSlime(v39().id)

					return string.upper(Mutations.getDisplayName(v48.name, v39().mutations))
				end,
				Stroke = {
					Thickness = 3
				}
			}),
			OddsLabel({
				Name = "Odds",
				Size = UDim2.fromScale(1, 0.15),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.75),
				odds = function() --[[ odds ]] -- line: 263
					-- upvalues: v40 (copy)
					return v40()
				end
			}),
			Frame({
				Name = "StatsRow",
				Size = UDim2.fromScale(0.6, 0.15),
				Position = UDim2.fromScale(0.5, 0.98),
				AnchorPoint = Vector2.new(0.5, 1),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				BackgroundTransparency = 1,
				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0.2, 0)
				}),
				StatPill({
					layoutOrder = 1,
					label = "Damage",
					icon = ImageIds.damageIcon,
					value = function() --[[ value ]] -- line: 288
						-- upvalues: Abbreviate (copy), v41 (copy)
						return `{ Abbreviate(v41().damage) }`
					end
				}),
				StatPill({
					layoutOrder = 2,
					label = "Health",
					icon = ImageIds.healthIcon,
					value = function() --[[ value ]] -- line: 297
						-- upvalues: Abbreviate (copy), v41 (copy)
						return `{ Abbreviate(v41().maxHealth) }`
					end
				})
			}),
			TextLabel({
				Text = "press any button to continue",
				Size = UDim2.fromScale(1, 0.175),
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 1.05),
				Stroke = {}
			})
		})
	})
end

return function() -- line: 314
	-- upvalues: Vide (copy), RollSlice (copy), getRolledSlimeUniqueIds (copy), InventoryServiceClient (copy), NewSlimeContent (copy)
	local u43 = nil
	local u44 = nil

	Vide.effect(function() -- line: 317
		-- upvalues: RollSlice (copy), u44 (ref), getRolledSlimeUniqueIds (copy), InventoryServiceClient (copy)
		if not RollSlice.autoEquipPending() or (not RollSlice.rollComplete() or (RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil)) or u44 ~= nil then
			return
		end

		u44 = task.defer(function() -- line: 326
			-- upvalues: u44 (ref), RollSlice (copy), getRolledSlimeUniqueIds (copy), InventoryServiceClient (copy)
			u44 = nil
			RollSlice.actions.clearAutoEquipPending()

			for _, v50 in getRolledSlimeUniqueIds() do
				InventoryServiceClient:equipSlimeIfSpace(v50)
			end
		end)
	end)
	Vide.effect(function() -- line: 335
		-- upvalues: RollSlice (copy), u43 (ref), Vide (copy)
		if RollSlice.newSlimePopupReady() or (RollSlice.newSlimeQueue()[1] == nil or (RollSlice.rareRollCutsceneShown() or (RollSlice.rareRollCutsceneData() ~= nil or (RollSlice.jackpotScreenShown() or RollSlice.jackpotSpinData() ~= nil or not RollSlice.rollComplete() and (RollSlice.rollScreenShown() or (RollSlice.rollResults()[1] ~= nil or next(RollSlice.bonusRollResults()) ~= nil)))))) then
			if u43 then
				task.cancel(u43)
				u43 = nil
			end

			return
		end

		u43 = task.delay(1, function() -- line: 347
			-- upvalues: u43 (ref), RollSlice (copy)
			u43 = nil

			if RollSlice.newSlimeQueue()[1] == nil then
				return
			end

			if RollSlice.rareRollCutsceneShown() or (RollSlice.rareRollCutsceneData() ~= nil or (RollSlice.jackpotScreenShown() or RollSlice.jackpotSpinData() ~= nil or not RollSlice.rollComplete() and (RollSlice.rollScreenShown() or (RollSlice.rollResults()[1] ~= nil or next(RollSlice.bonusRollResults()) ~= nil)))) then
				return
			end

			RollSlice.actions.markNewSlimePopupReady()
		end)
		Vide.cleanup(function() -- line: 359
			-- upvalues: u43 (ref)
			if u43 then
				task.cancel(u43)
				u43 = nil
			end
		end)
	end)
	Vide.effect(function() -- line: 367
		-- upvalues: RollSlice (copy)
		if not RollSlice.newSlimePopupReady() then
			return
		end

		if RollSlice.activeNewSlimePopupData() ~= nil then
			return
		end

		if RollSlice.rareRollCutsceneShown() or (RollSlice.rareRollCutsceneData() ~= nil or (RollSlice.jackpotScreenShown() or RollSlice.jackpotSpinData() ~= nil or not RollSlice.rollComplete() and (RollSlice.rollScreenShown() or (RollSlice.rollResults()[1] ~= nil or next(RollSlice.bonusRollResults()) ~= nil)))) then
			return
		end

		if RollSlice.newSlimeQueue()[1] == nil then
			return
		end

		task.defer(RollSlice.actions.showNextNewSlimePopup)
	end)

	return Vide.show(function() -- line: 384
		-- upvalues: RollSlice (copy)
		return RollSlice.activeNewSlimePopupData() ~= nil
	end, function() -- line: 386
		-- upvalues: NewSlimeContent (copy)
		return NewSlimeContent(), 0.18
	end)
end
