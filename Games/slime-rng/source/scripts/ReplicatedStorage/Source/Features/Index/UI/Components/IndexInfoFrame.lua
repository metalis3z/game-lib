-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexInfoFrame, time of decompilation: Sun May  3 10:12:33 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local RarityTiers = require(ReplicatedStorage.Source.Game.Items.RarityTiers)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local rect = Rect.new(28, 22, 107, 100)

return function(t1: {[any]: any}) -- line: 21
	-- upvalues: Vide (copy), IndexServiceUtils (copy), RarityTiers (copy), InventoryServiceUtils (copy), ImageLabel (copy), ImageIds (copy), rect (copy), SlimeIcon (copy), TextLabel (copy), Slimes (copy), Mutations (copy), OddsLabel (copy), Abbreviate (copy)
	local v16 = Vide.derive(function() -- line: 26
		-- upvalues: t1 (copy), IndexServiceUtils (copy)
		local v20 = t1.SelectedSlimeId() or "goopy"

		return IndexServiceUtils.createDisplaySlimeData(t1.CategoryId(), v20)
	end)
	local v17 = Vide.derive(function() -- line: 31
		-- upvalues: v16 (copy), IndexServiceUtils (copy), t1 (copy)
		local v21 = v16()

		if v21 == nil then
			return false
		end

		return IndexServiceUtils.isUnlockedFromData(t1.IndexData(), t1.CategoryId(), v21.id)
	end)
	local v18 = Vide.derive(function() -- line: 40
		-- upvalues: v16 (copy), RarityTiers (copy), InventoryServiceUtils (copy)
		local v22 = v16()

		if v22 == nil then
			return nil
		end

		return RarityTiers.getTier(InventoryServiceUtils.getActualOdds(v22))
	end)
	local v19 = Vide.derive(function() -- line: 49
		-- upvalues: v16 (copy), InventoryServiceUtils (copy)
		local v23 = v16()

		if v23 == nil then
			return nil
		end

		return InventoryServiceUtils.getSlimeStatsFromData(v23)
	end)

	return ImageLabel({
		Name = "IndexInfoFrame",
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromScale(0.31, 0.6),
		Position = UDim2.new(1, 0, 0, 8),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		SlimeIcon({
			ZIndex = 2,
			SlimeData = v16,
			Size = UDim2.fromOffset(140, 140),
			Position = UDim2.fromScale(0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			ImageColor3 = function() --[[ ImageColor3 ]] -- line: 73
				-- upvalues: v17 (copy)
				if v17() then
					return Color3.fromRGB(255, 255, 255)
				end

				return Color3.fromRGB(0, 0, 0)
			end,
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 80
				-- upvalues: v17 (copy)
				if v17() then
					return 0
				end

				return 0.35
			end
		}),
		TextLabel({
			Name = "SlimeName",
			ZIndex = 3,
			Text = function() --[[ Text ]] -- line: 92
				-- upvalues: v16 (copy), v17 (copy), Slimes (copy), Mutations (copy)
				local v24 = v16()

				if v17() then
					local name = Slimes.getSlime(v24.id).name

					return string.upper(Mutations.getDisplayName(name, v24.mutations))
				end

				return "???"
			end,
			Size = UDim2.new(0.9, 0, 0, 30),
			Position = UDim2.new(0.5, 0, 0, 116),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {},
			DropShadow = {}
		}),
		OddsLabel({
			ZIndex = 2,
			odds = function() --[[ odds ]] -- line: 110
				-- upvalues: InventoryServiceUtils (copy), v16 (copy)
				return InventoryServiceUtils.getActualOdds(v16())
			end,
			Size = UDim2.fromScale(1, 0.1),
			Position = UDim2.fromScale(0.5, 0.55),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}),
		TextLabel({
			Name = "TierBadge",
			Text = function() --[[ Text ]] -- line: 121
				-- upvalues: v18 (copy)
				local v26 = v18()

				if v26 == nil then
					return "-"
				end

				return v26.name
			end,
			Size = UDim2.new(0.9, 0, 0, 26),
			Position = UDim2.new(0.5, 0, 0, 174),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 3,
				Color = Color3.fromRGB(43, 43, 43)
			},
			DropShadow = {
				Transparency = 0.5
			},
			Gradient = {
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 135
					-- upvalues: v18 (copy), RarityTiers (copy)
					return (v18() or RarityTiers.getTier(1)).gradient
				end
			}
		}),
		TextLabel({
			Name = "Damage",
			TextSize = 28,
			Text = function() --[[ Text ]] -- line: 145
				-- upvalues: v17 (copy), v19 (copy), Abbreviate (copy)
				if not v17() or v19() == nil then
					return "???"
				end

				return Abbreviate(v19().damage)
			end,
			Size = UDim2.new(0.5, 0, 0, 30),
			Position = UDim2.fromScale(0.05, 0.7),
			AnchorPoint = Vector2.new(0, 0),
			Stroke = {},
			Prefix = {
				Image = ImageIds.damageIcon,
				Size = UDim2.fromScale(0.8, 0.8),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				Padding = UDim.new(0, 8)
			}
		}),
		TextLabel({
			Name = "Health",
			TextSize = 28,
			Text = function() --[[ Text ]] -- line: 167
				-- upvalues: v17 (copy), v19 (copy), Abbreviate (copy)
				if not v17() or v19() == nil then
					return "???"
				end

				return Abbreviate(v19().maxHealth)
			end,
			Size = UDim2.new(0.5, 0, 0, 30),
			Position = UDim2.fromScale(0.95, 0.7),
			AnchorPoint = Vector2.new(1, 0),
			Stroke = {},
			Prefix = {
				Image = ImageIds.healthIcon,
				Size = UDim2.fromScale(0.8, 0.8),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				Padding = UDim.new(0, 8)
			}
		}),
		TextLabel({
			Name = "NumRolls",
			TextSize = 28,
			Text = function() --[[ Text ]] -- line: 189
				-- upvalues: v16 (copy), Abbreviate (copy), IndexServiceUtils (copy), t1 (copy)
				local v27 = v16()

				return "Rolls: " .. Abbreviate(IndexServiceUtils.getCountFromData(t1.IndexData(), t1.CategoryId(), v27.id))
			end,
			Size = UDim2.new(0.5, 0, 0, 30),
			Position = UDim2.fromScale(0.5, 0.8),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {},
			Prefix = {
				Image = ImageIds.dice,
				Size = UDim2.fromScale(0.8, 0.8),
				SizeConstraint = Enum.SizeConstraint.RelativeYY,
				Padding = UDim.new(0, 8)
			}
		})
	})
end
