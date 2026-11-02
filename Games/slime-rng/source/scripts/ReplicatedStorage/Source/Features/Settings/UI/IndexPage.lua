-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexPage, time of decompilation: Sun May  3 10:11:56 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local OddsLabel = require(ReplicatedStorage.Source.Features.App.Components.OddsLabel)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local RarityTiers = require(ReplicatedStorage.Source.Game.Items.RarityTiers)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local rect = Rect.new(28, 22, 107, 100)
local colorSequence = ColorSequence.new(Color3.fromRGB(220, 220, 220))

local function StatRow(t1: {[any]: any}) -- line: 49
	-- upvalues: Frame (copy), TextLabel (copy)
	return Frame({
		Size = UDim2.new(0.9, 0, 0, 34),
		LayoutOrder = t1.LayoutOrder,
		TextLabel({
			TextSize = 20,
			Text = t1.Label,
			Size = UDim2.fromScale(0.42, 1),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Color3.fromRGB(197, 197, 197)
		}),
		TextLabel({
			TextSize = 20,
			Text = t1.Value,
			Size = UDim2.fromScale(0.58, 1),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(1, 0.5),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {
				Color = Color3.fromRGB(48, 48, 48)
			},
			Gradient = t1.Gradient
		})
	})
end
local function IndexSlimeCard(t2: {[any]: any}) -- line: 87
	-- upvalues: Vide (copy), Button (copy), ImageIds (copy), DropShadow (copy), SlimeIcon (copy), TextLabel (copy), OddsLabel (copy), InventoryServiceUtils (copy)
	local id = t2.SlimeInfo.id
	local t3 = {
		level = 1,
		xp = 0,
		id = id,
		mutations = {}
	}
	local v33 = Vide.source(1)
	local v34, v35 = Vide.spring(v33, 1, 0.3)

	return Button({
		Image = function() --[[ Image ]] -- line: 93
			-- upvalues: t2 (copy), ImageIds (copy)
			if t2.Selected() then
				return "rbxassetid://71350434421011"
			end

			return ImageIds.blackCheckeredButton
		end,
		Size = UDim2.fromOffset(132, 132),
		LayoutOrder = t2.LayoutOrder,
		HoverScale = 1,
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ImageTransparency = function() --[[ ImageTransparency ]] -- line: 104
			-- upvalues: t2 (copy)
			if t2.Obtained() then
				return 0
			end

			return 0.35
		end,
		Activated = t2.OnSelected,
		OnEnter = function() --[[ OnEnter ]] -- line: 112
			-- upvalues: v35 (copy)
			v35({
				impulse = -2
			})
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 115
			-- upvalues: v33 (copy)
			v33(1)
		end,
		OnDown = function() --[[ OnDown ]] -- line: 118
			-- upvalues: v33 (copy)
			v33(0.66)
		end,
		OnUp = function() --[[ OnUp ]] -- line: 121
			-- upvalues: v33 (copy)
			v33(1)
		end,
		DropShadow({
			ZIndex = -3,
			ImageTransparency = 0.6,
			Size = UDim2.fromScale(1, 0.33),
			Position = UDim2.fromScale(0, 0.55)
		}),
		SlimeIcon({
			ZIndex = 0,
			SlimeData = t3,
			Size = function() --[[ Size ]] -- line: 134
				-- upvalues: v34 (copy)
				return UDim2.fromScale(0.76, 0.76 * v34())
			end,
			Position = UDim2.fromScale(0.5, 0.82),
			AnchorPoint = Vector2.new(0.5, 1),
			ImageColor3 = function() --[[ ImageColor3 ]] -- line: 139
				-- upvalues: t2 (copy)
				if t2.Obtained() then
					return Color3.fromRGB(255, 255, 255)
				end

				return Color3.fromRGB(0, 0, 0)
			end,
			ImageTransparency = function() --[[ ImageTransparency ]] -- line: 146
				-- upvalues: t2 (copy)
				if t2.Obtained() then
					return 0
				end

				return 0.45
			end
		}),
		TextLabel({
			ZIndex = 2,
			Text = function() --[[ Text ]] -- line: 157
				-- upvalues: t2 (copy)
				if t2.Obtained() then
					return t2.SlimeInfo.name
				end

				return "???"
			end,
			Size = UDim2.new(1, -18, 0, 24),
			Position = UDim2.new(0.5, 0, 0, 8),
			AnchorPoint = Vector2.new(0.5, 0),
			TextSize = function() --[[ TextSize ]] -- line: 167
				-- upvalues: t2 (copy)
				if t2.Obtained() then
					return 22
				end

				return 30
			end,
			Stroke = {
				Thickness = 3,
				Color = Color3.fromRGB(24, 24, 24)
			},
			DropShadow = {}
		}),
		OddsLabel({
			TextSize = 18,
			ZIndex = 2,
			odds = InventoryServiceUtils.getActualOdds(t3),
			Size = UDim2.new(1, -10, 0, 26),
			Position = UDim2.new(0.5, 0, 1, -8),
			AnchorPoint = Vector2.new(0.5, 1)
		})
	})
end
local function HoverPanel(t4: {[any]: any}) -- line: 199
	-- upvalues: Vide (copy), Slimes (copy), CraftingServiceUtils (copy), ImageLabel (copy), ImageIds (copy), rect (copy), Frame (copy), TextLabel (copy), UIListLayout (copy), StatRow (copy), RarityTiers (copy), InventoryServiceUtils (copy), colorSequence (copy), Abbreviate (copy), OddsGradients (copy), IndexServiceUtils (copy)
	local v37 = Vide.derive(function() -- line: 200
		-- upvalues: t4 (copy), Slimes (copy)
		local v49 = t4.SelectedSlimeId()

		if v49 == nil then
			return nil
		end

		return Slimes.getSlime(v49)
	end)
	local v38 = Vide.derive(function() -- line: 208
		-- upvalues: v37 (copy), CraftingServiceUtils (copy), t4 (copy)
		local v50 = v37()

		if v50 == nil then
			return false
		end

		return CraftingServiceUtils.hasDiscoveredSlime(v50.id, t4.Inventory() or {}, t4.IndexData() or {})
	end)

	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.new(0.33, 0, 1, -20),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 20),
		Frame({
			Size = UDim2.new(1, -24, 1, -24),
			Position = UDim2.new(0.5, 0, 0, 12),
			AnchorPoint = Vector2.new(0.5, 0),
			ImageLabel({
				Image = function() --[[ Image ]] -- line: 231
					-- upvalues: v37 (copy)
					local v51 = v37()

					if v51 then
						return v51.image
					end

					return ""
				end,
				Size = UDim2.fromOffset(122, 122),
				Position = UDim2.new(0.5, 0, 0, 12),
				AnchorPoint = Vector2.new(0.5, 0),
				ImageColor3 = function() --[[ ImageColor3 ]] -- line: 238
					-- upvalues: v38 (copy)
					if v38() then
						return Color3.fromRGB(255, 255, 255)
					end

					return Color3.fromRGB(0, 0, 0)
				end,
				ImageTransparency = function() --[[ ImageTransparency ]] -- line: 245
					-- upvalues: v38 (copy)
					if v38() then
						return 0
					end

					return 0.45
				end,
				Visible = function() --[[ Visible ]] -- line: 252
					-- upvalues: v37 (copy)
					return v37() ~= nil
				end
			}),
			TextLabel({
				TextWrapped = true,
				Text = function() --[[ Text ]] -- line: 258
					-- upvalues: v37 (copy), v38 (copy)
					local v52 = v37()

					if v52 == nil then
						return "SELECT A SLIME"
					end

					if not v38() then
						return "???"
					end

					return v52.name
				end,
				Size = UDim2.new(1, -8, 0, 42),
				Position = UDim2.new(0.5, 0, 0, 142),
				AnchorPoint = Vector2.new(0.5, 0),
				TextSize = function() --[[ TextSize ]] -- line: 273
					-- upvalues: v38 (copy)
					if not v38() then
						return 34
					end

					return 24
				end,
				Stroke = {}
			}),
			Frame({
				Size = UDim2.new(1, 0, 1, -188),
				Position = UDim2.fromOffset(0, 182),
				UIListLayout({
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0, 4)
				}),
				StatRow({
					Label = "Rarity",
					LayoutOrder = 1,
					Value = function() --[[ Value ]] -- line: 297
						-- upvalues: v37 (copy), RarityTiers (copy), InventoryServiceUtils (copy)
						local v53 = v37()

						if v53 == nil then
							return "-"
						end

						local getTier = RarityTiers.getTier
						local getActualOdds = InventoryServiceUtils.getActualOdds
						local id = v53.id

						return getTier(getActualOdds({
							level = 1,
							xp = 0,
							id = id,
							mutations = {}
						})).name
					end,
					Gradient = {
						Rotation = 90,
						Color = function() --[[ Color ]] -- line: 308
							-- upvalues: v37 (copy), colorSequence (copy), RarityTiers (copy), InventoryServiceUtils (copy)
							local v57 = v37()

							if v57 == nil then
								return colorSequence
							end

							local getTier = RarityTiers.getTier
							local getActualOdds = InventoryServiceUtils.getActualOdds
							local id = v57.id

							return getTier(getActualOdds({
								level = 1,
								xp = 0,
								id = id,
								mutations = {}
							})).gradient
						end
					}
				}),
				StatRow({
					Label = "Odds",
					LayoutOrder = 2,
					Value = function() --[[ Value ]] -- line: 321
						-- upvalues: v37 (copy), Abbreviate (copy), InventoryServiceUtils (copy)
						local v61 = v37()

						if v61 == nil then
							return "-"
						end

						local v62 = Abbreviate
						local getRarity = InventoryServiceUtils.getRarity
						local id = v61.id

						return `1/{ v62((math.ceil((getRarity({
							level = 1,
							xp = 0,
							id = id,
							mutations = {}
						}))))) }`
					end,
					Gradient = {
						Rotation = 90,
						Color = function() --[[ Color ]] -- line: 331
							-- upvalues: v37 (copy), colorSequence (copy), OddsGradients (copy), InventoryServiceUtils (copy)
							local v65 = v37()

							if v65 == nil then
								return colorSequence
							end

							local getGradient = OddsGradients.getGradient
							local getActualOdds = InventoryServiceUtils.getActualOdds
							local id = v65.id

							return getGradient(getActualOdds({
								level = 1,
								xp = 0,
								id = id,
								mutations = {}
							}))
						end
					}
				}),
				StatRow({
					Label = "Times Obtained",
					LayoutOrder = 3,
					Value = function() --[[ Value ]] -- line: 344
						-- upvalues: v37 (copy), v38 (copy), Abbreviate (copy), IndexServiceUtils (copy), t4 (copy)
						local v69 = v37()

						if v69 == nil then
							return "-"
						end

						if not v38() then
							return "???"
						end

						return Abbreviate(IndexServiceUtils.getCount(t4.IndexData(), "basic", v69.id))
					end
				}),
				StatRow({
					Label = "Damage",
					LayoutOrder = 4,
					Value = function() --[[ Value ]] -- line: 361
						-- upvalues: v37 (copy), v38 (copy)
						local v70 = v37()

						if v70 == nil then
							return "-"
						end

						if not v38() then
							return "???"
						end

						return (tostring(v70.damage))
					end
				}),
				StatRow({
					Label = "Health",
					LayoutOrder = 5,
					Value = function() --[[ Value ]] -- line: 378
						-- upvalues: v37 (copy), v38 (copy)
						local v71 = v37()

						if v71 == nil then
							return "-"
						end

						if not v38() then
							return "???"
						end

						return (tostring(v71.health))
					end
				})
			})
		})
	})
end

return function() -- line: 397
	-- upvalues: getDataSource (copy), Slimes (copy), Vide (copy), CraftingServiceUtils (copy), IndexSlimeCard (copy), Frame (copy), ScrollingFrame (copy), UIPadding (copy), UIGridLayout (copy), HoverPanel (copy)
	local v39 = getDataSource("inventory")
	local v40 = getDataSource("index")
	local v41 = Slimes.getSortedSlimes()
	local v42 = #v41
	local v43 = Vide.source(if not (v42 > 0) then nil else v41[1].id)
	local t5 = {}

	for i = 1, v42 do
		local v46 = v41[i]
		local v47 = Vide.derive(function() -- line: 407
			-- upvalues: CraftingServiceUtils (copy), v46 (copy), v39 (copy), v40 (copy)
			return CraftingServiceUtils.hasDiscoveredSlime(v46.id, v39() or {}, v40() or {})
		end)
		local v48 = Vide.derive(function() -- line: 410
			-- upvalues: v43 (copy), v46 (copy)
			return v43() == v46.id
		end)

		table.insert(t5, IndexSlimeCard({
			SlimeInfo = v46,
			LayoutOrder = v46.layout,
			Obtained = v47,
			Selected = v48,
			OnSelected = function() --[[ OnSelected ]] -- line: 421
				-- upvalues: v43 (copy), v46 (copy)
				v43(v46.id)
			end
		}))
	end

	return Frame({
		Size = UDim2.fromScale(1, 1),
		ScrollingFrame({
			BackgroundTransparency = 1,
			Size = UDim2.new(0.68, -4, 1, -20),
			Position = UDim2.fromOffset(0, 20),
			CanvasSize = UDim2.fromOffset(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 0,
			UIPadding({
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 2)
			}),
			UIGridLayout({
				CellSize = UDim2.fromOffset(132, 132),
				CellPadding = UDim2.fromOffset(6, 6),
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder
			}),
			t5
		}),
		HoverPanel({
			SelectedSlimeId = v43,
			Inventory = v39,
			IndexData = v40
		})
	})
end
