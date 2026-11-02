-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferEquation, time of decompilation: Sun May  3 10:12:38 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	id = "goopy",
	level = 1,
	xp = 0,
	mutations = nil
}

local function ShownSlimeDataSlot(t2: {[any]: any}) -- line: 49
	-- upvalues: SlimeButton (copy), ImageIds (copy), t1 (copy), InventoryServiceUtils (copy)
	return SlimeButton({
		IconScale = 0.66,
		Size = UDim2.fromScale(1, 1),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		IconPosition = UDim2.fromScale(0.5, 0.76),
		Image = function() --[[ Image ]] -- line: 57
			-- upvalues: t2 (copy), ImageIds (copy)
			if t2.Selected ~= nil and t2.Selected() then
				return ImageIds.blackButtonWhiteOutline
			end

			return ImageIds.blackCheckeredButton
		end,
		SlimeData = function() --[[ SlimeData ]] -- line: 64
			-- upvalues: t2 (copy), t1 (copy)
			return t2.SlimeData() or t1
		end,
		ShowLevel = function() --[[ ShowLevel ]] -- line: 67
			-- upvalues: t2 (copy), InventoryServiceUtils (copy)
			local v18 = t2.SlimeData()

			if v18 == nil then
				return false
			end

			return InventoryServiceUtils.getLevelProgress(v18).showBar
		end,
		Activated = if not t2.IsResult then t2.OnActivate else nil
	})
end
local function EmptySlimeDataSlot(t3: {[any]: any}) -- line: 74
	-- upvalues: Button (copy), ImageIds (copy), TextLabel (copy)
	return Button({
		Size = UDim2.fromScale(1, 1),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = function() --[[ Image ]] -- line: 80
			-- upvalues: t3 (copy), ImageIds (copy)
			if t3.Selected ~= nil and t3.Selected() then
				return ImageIds.blackButtonWhiteOutline
			end

			return ImageIds.blackCheckeredButton
		end,
		Activated = if not t3.IsResult then t3.OnActivate else nil,
		if t3.IsResult then nil else TextLabel({
			Text = "+",
			Size = UDim2.fromScale(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		})
	})
end
local function SlimeSlot(t4: {[any]: any}) -- line: 101
	-- upvalues: Frame (copy), Vide (copy), ShownSlimeDataSlot (copy), EmptySlimeDataSlot (copy)
	return Frame({
		Size = UDim2.fromOffset(134.4, 129.6),
		Position = t4.Position,
		AnchorPoint = t4.AnchorPoint,
		Vide.show(t4.SlimeData, function() -- line: 107
			-- upvalues: ShownSlimeDataSlot (copy), t4 (copy)
			return ShownSlimeDataSlot(t4)
		end, function() -- line: 109
			-- upvalues: EmptySlimeDataSlot (copy), t4 (copy)
			return EmptySlimeDataSlot(t4)
		end)
	})
end

return function(t5: {[any]: any}) -- line: 115
	-- upvalues: Frame (copy), SlimeSlot (copy), TextLabel (copy)
	return Frame({
		Size = UDim2.fromOffset(760, 108),
		Position = UDim2.fromScale(0.5, 0.27),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 3,
		SlimeSlot({
			SlimeData = t5.InputSlimeData,
			Position = UDim2.fromOffset(0, 0),
			OnActivate = t5.OnSelectInput,
			Selected = t5.InputSelected
		}),
		SlimeSlot({
			SlimeData = t5.OutputSlimeData,
			Position = UDim2.fromScale(0.25, 0),
			AnchorPoint = Vector2.new(0, 0),
			OnActivate = t5.OnSelectOutput,
			Selected = t5.OutputSelected
		}),
		TextLabel({
			Text = "->",
			ZIndex = 4,
			Size = UDim2.fromScale(1, 1),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		}),
		SlimeSlot({
			IsResult = true,
			SlimeData = t5.DrainedInputSlimeData,
			Position = UDim2.fromScale(0.75, 0),
			AnchorPoint = Vector2.new(1, 0)
		}),
		SlimeSlot({
			IsResult = true,
			SlimeData = t5.PreviewSlimeData,
			Position = UDim2.fromScale(1, 0),
			AnchorPoint = Vector2.new(1, 0)
		})
	})
end
