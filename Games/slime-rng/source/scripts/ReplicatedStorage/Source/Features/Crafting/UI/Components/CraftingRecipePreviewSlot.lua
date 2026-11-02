-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingRecipePreviewSlot, time of decompilation: Sun May  3 10:12:29 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeHoverInfo = require(ReplicatedStorage.Source.Features.App.Components.SlimeHoverInfo)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(t1: {[any]: any}) -- line: 25
	-- upvalues: Vide (copy), InventoryServiceUtils (copy), Slimes (copy), Button (copy), ImageIds (copy), SlimeHoverInfo (copy), SlimeIcon (copy), TextLabel (copy), Mutations (copy), OddsLabel (copy)
	local function v13() -- line: 26
		-- upvalues: Vide (copy), t1 (copy)
		return Vide.read(t1.SlimeData)
	end

	local v14 = Vide.derive(function() -- line: 29
		-- upvalues: InventoryServiceUtils (copy), v13 (copy)
		return InventoryServiceUtils.getVisualOdds(v13())
	end)
	local v15 = Vide.derive(function() -- line: 32
		-- upvalues: Slimes (copy), Vide (copy), t1 (copy)
		return Slimes.getSlime(Vide.read(t1.SlimeData).id)
	end)
	local v16 = Vide.derive(function() -- line: 35
		-- upvalues: InventoryServiceUtils (copy), v13 (copy)
		return InventoryServiceUtils.getLevelProgress(v13())
	end)

	return Button({
		Name = "RecipePreviewSlot",
		Image = ImageIds.blackCheckeredButton,
		Size = t1.Size or UDim2.fromOffset(124, 124),
		LayoutOrder = t1.LayoutOrder,
		HoverScale = 1.02,
		Activated = t1.Activated or function() -- line: 45
		end,
		OnEnter = function() --[[ OnEnter ]] -- line: 46
			-- upvalues: t1 (copy), SlimeHoverInfo (copy), v13 (copy)
			if t1.Discovered() then
				SlimeHoverInfo.setSlimeData(v13())

				return
			end

			SlimeHoverInfo.setSlimeData(nil)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 53
			-- upvalues: SlimeHoverInfo (copy)
			SlimeHoverInfo.setSlimeData(nil)
		end,
		SlimeIcon({
			ZIndex = 2,
			SlimeData = v13,
			Size = UDim2.fromScale(0.72, 0.72),
			Position = UDim2.fromScale(0.5, 0.82),
			AnchorPoint = Vector2.new(0.5, 1),
			ImageColor3 = function() --[[ ImageColor3 ]] -- line: 62
				-- upvalues: t1 (copy)
				if t1.Discovered() then
					return Color3.fromRGB(255, 255, 255)
				end

				return Color3.fromRGB(0, 0, 0)
			end,
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 69
				-- upvalues: t1 (copy)
				if t1.Discovered() then
					return 0
				end

				return 0.4
			end
		}),
		Vide.show(function() -- line: 79
			-- upvalues: t1 (copy)
			return t1.ShowDetails == true
		end, function() -- line: 81
			-- upvalues: TextLabel (copy), t1 (copy), Mutations (copy), v15 (copy), Vide (copy), v16 (copy), OddsLabel (copy), v14 (copy)
			return {
				TextLabel({
					TextSize = 22,
					ZIndex = 2,
					Text = function() --[[ Text ]] -- line: 84
						-- upvalues: t1 (copy), Mutations (copy), v15 (copy), Vide (copy)
						if t1.Discovered() then
							return Mutations.getDisplayName(v15().name, Vide.read(t1.SlimeData).mutations)
						end

						return "???"
					end,
					Size = UDim2.new(1, -18, 0, 24),
					Position = UDim2.new(0.5, 0, 0, 8),
					AnchorPoint = Vector2.new(0.5, 0),
					Stroke = {
						Thickness = 3,
						Color = Color3.fromRGB(24, 24, 24)
					},
					DropShadow = {}
				}),
				Vide.show(function() -- line: 103
					-- upvalues: t1 (copy), v16 (copy)
					return t1.Discovered() and v16().showBar
				end, function() -- line: 105
					-- upvalues: TextLabel (copy), v16 (copy)
					return TextLabel({
						ZIndex = 2,
						Text = function() --[[ Text ]] -- line: 107
							-- upvalues: v16 (copy)
							return `Lv. { v16().level }`
						end,
						Size = UDim2.new(0.5, -8, 0, 20),
						Position = UDim2.new(1, -6, 0, 6),
						AnchorPoint = Vector2.new(1, 0),
						TextXAlignment = Enum.TextXAlignment.Right,
						TextColor3 = Color3.fromRGB(60, 144, 255),
						Stroke = {}
					})
				end),
				OddsLabel({
					TextSize = 18,
					ZIndex = 2,
					odds = v14,
					Size = UDim2.new(1, -10, 0, 26),
					Position = UDim2.new(0.5, 0, 1, -8),
					AnchorPoint = Vector2.new(0.5, 1)
				})
			}
		end)
	})
end
