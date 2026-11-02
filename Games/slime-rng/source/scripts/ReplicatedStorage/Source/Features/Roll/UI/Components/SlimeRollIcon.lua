-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeRollIcon, time of decompilation: Sun May  3 10:11:50 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local RollServiceUtils = require(ReplicatedStorage.Source.Features.Roll.RollServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)

return function(p1, p2) -- line: 18
	-- upvalues: Slimes (copy), Vide (copy), RollServiceUtils (copy), InventoryServiceUtils (copy), Mutations (copy), Frame (copy), SlimeIcon (copy), OddsLabel (copy), TextLabel (copy), ImageLabel (copy), ImageIds (copy), UIGradient (copy), OddsGradients (copy)
	local v17 = Slimes.getSortedSlimes()[1]
	local v18 = Vide.source(v17)
	local v19 = Vide.source(v17.odds)
	local v20 = Vide.source({
		level = 1,
		xp = 0,
		mutations = nil,
		id = v17.id
	})

	Vide.effect(function() -- line: 28
		-- upvalues: p1 (copy), RollServiceUtils (copy), v18 (copy), Slimes (copy), v20 (copy), v19 (copy), InventoryServiceUtils (copy)
		local v22 = p1()

		if not v22 or RollServiceUtils.isNonSlimeRoll(v22) then
			return
		end

		v18(Slimes.getSlime(v22.id))
		v20({
			level = 1,
			xp = 0,
			id = v22.id,
			mutations = v22.mutations
		})
		v19(InventoryServiceUtils.getVisualOdds(v20()))
	end)

	local v21 = Vide.derive(function() -- line: 44
		-- upvalues: Mutations (copy), v20 (copy)
		return Mutations.getIconZoom(v20().mutations)
	end)

	return Frame({
		Size = UDim2.fromScale(1, 1),
		SlimeIcon({
			SlimeData = v20,
			Size = UDim2.fromScale(1, 1),
			ImageTransparency = p2
		}),
		OddsLabel({
			odds = function() --[[ odds ]] -- line: 58
				-- upvalues: v19 (copy)
				return v19()
			end,
			TextTransparency = p2,
			Size = UDim2.fromScale(1, 0.2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.25, 0.25),
			Rotation = function() --[[ Rotation ]] -- line: 65
				-- upvalues: p2 (copy)
				return math.cos(p2() * 3.141592653589793 * 2) * -15
			end
		}),
		TextLabel({
			ZIndex = 3,
			Text = function() --[[ Text ]] -- line: 71
				-- upvalues: Mutations (copy), v18 (copy), v20 (copy)
				return Mutations.getDisplayName(v18().name, v20().mutations)
			end,
			TextTransparency = p2,
			Size = UDim2.fromScale(1, 0.2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.9),
			Stroke = {
				Thickness = 3,
				Transparency = p2
			},
			DropShadow = {
				Transparency = function() --[[ Transparency ]] -- line: 81
					-- upvalues: p2 (copy)
					return 1 - 0.5 * (1 - p2())
				end,
				Offset = UDim2.fromScale(0, 0.16)
			}
		}),
		ImageLabel({
			Name = "Sunburst",
			Image = ImageIds.sunburst,
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 91
				-- upvalues: p2 (copy)
				return 0.2 + p2() * 4
			end,
			Size = UDim2.fromScale(1.7, 1.7),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = -2,
			UIGradient({
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 101
					-- upvalues: OddsGradients (copy), v19 (copy)
					return OddsGradients.getGradient(v19())
				end
			})
		}),
		ImageLabel({
			Name = "DropShadow",
			ZIndex = -1,
			Visible = function() --[[ Visible ]] -- line: 109
				-- upvalues: v21 (copy)
				return v21() <= 1
			end,
			Image = function() --[[ Image ]] -- line: 112
				-- upvalues: v20 (copy), Slimes (copy)
				local v23 = v20()

				return Slimes.getImage(v23.id, v23.mutations)
			end,
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 117
				-- upvalues: p2 (copy)
				return 0.5 + 0.5 * p2()
			end,
			Size = function() --[[ Size ]] -- line: 121
				-- upvalues: v18 (copy), Mutations (copy), v20 (copy)
				local v24 = (v18().iconSize or 1) * Mutations.getIconZoom(v20().mutations)

				return UDim2.fromScale(v24, v24)
			end,
			Position = function() --[[ Position ]] -- line: 125
				-- upvalues: v18 (copy)
				return (v18().iconPosition or UDim2.fromScale(0.5, 0.5)) + UDim2.fromScale(0, 0.1)
			end,
			AnchorPoint = Vector2.new(0.5, 0.5)
		})
	})
end
