-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotWheelOption, time of decompilation: Sun May  3 10:11:52 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

return function(t1: {[any]: any}) -- line: 29
	-- upvalues: Slimes (copy), Frame (copy), DropShadow (copy), SlimeIcon (copy), TextLabel (copy), Mutations (copy), OddsLabel (copy), InventoryServiceUtils (copy)
	local reward = t1.reward
	local t2 = {
		level = 1,
		xp = 0,
		id = reward.id,
		mutations = reward.mutations
	}
	local v14 = Slimes.getSlime(t1.reward.id)
	local v15 = t1.zIndex or 1

	return Frame({
		Name = "JackpotWheelOption_" .. v14.id,
		Size = UDim2.fromOffset(142, 158),
		Position = t1.position,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Rotation = t1.rotation or 0,
		BackgroundTransparency = 1,
		ZIndex = v15,
		DropShadow({
			ImageTransparency = 0.48,
			Size = UDim2.fromScale(0.9, 0.9),
			Position = UDim2.fromScale(0.5, 0.55),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = v15
		}),
		SlimeIcon({
			UseCanvasFrames = true,
			SlimeData = t2,
			Size = UDim2.fromScale(0.86, 0.86),
			Position = UDim2.fromScale(0.5, 0.475),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = v15 + 1
		}),
		TextLabel({
			Name = "RewardName",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.92, 0.18),
			Position = UDim2.fromScale(0.5, 0.025),
			AnchorPoint = Vector2.new(0.5, 0),
			Text = string.upper(Mutations.getDisplayName(v14.name, t1.reward.mutations)),
			TextColor3 = Color3.fromRGB(255, 247, 214),
			ZIndex = v15 + 2,
			Stroke = {
				Thickness = 3,
				Color = Color3.fromRGB(53, 26, 11)
			}
		}),
		OddsLabel({
			Name = "RewardOdds",
			Size = UDim2.fromScale(0.7, 0.15),
			Position = UDim2.fromScale(0.5, 0.9),
			AnchorPoint = Vector2.new(0.5, 0.5),
			odds = InventoryServiceUtils.getVisualOdds(t2),
			ZIndex = v15 + 2
		})
	})
end
