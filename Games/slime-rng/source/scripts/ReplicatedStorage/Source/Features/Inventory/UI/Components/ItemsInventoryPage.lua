-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ItemsInventoryPage, time of decompilation: Sun May  3 10:11:29 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local FoodFeedPreviewCard = require(ReplicatedStorage.Source.Features.Inventory.UI.Components.FoodFeedPreviewCard)
local InventoryItemUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryItemUtils)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local Food = require(ReplicatedStorage.Source.Game.Items.Food)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local indexes = Vide.indexes
local rect = Rect.new(28, 22, 107, 100)

local function FeedAllCheckbox(p1) -- line: 37
	-- upvalues: Frame (copy), Button (copy), ImageIds (copy), TextLabel (copy)
	return Frame({
		Name = "FeedAllToggleRow",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(132, 58),
		Position = UDim2.new(1, -36, 1, -16),
		AnchorPoint = Vector2.new(1, 1),
		Button({
			Name = "FeedAllToggleButton",
			Image = function() --[[ Image ]] -- line: 47
				-- upvalues: p1 (copy), ImageIds (copy)
				if p1() then
					return ImageIds.blackButtonWhiteOutline
				end

				return ImageIds.blackCheckeredButton
			end,
			Size = UDim2.fromOffset(34, 34),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			Activated = function() --[[ Activated ]] -- line: 57
				-- upvalues: p1 (copy)
				p1(not p1())
			end,
			TextLabel({
				Name = "Checkmark",
				TextSize = 20,
				Text = function() --[[ Text ]] -- line: 63
					-- upvalues: p1 (copy)
					if p1() then
						return "X"
					end

					return ""
				end,
				Size = UDim2.fromScale(0.8, 0.8),
				Position = UDim2.fromScale(0.5, 0.45),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {},
				DropShadow = {}
			})
		}),
		TextLabel({
			Name = "FeedAllToggleLabel",
			Text = "Feed All",
			TextSize = 24,
			Size = UDim2.new(1, -42, 0, 28),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {},
			DropShadow = {}
		})
	})
end
local function ItemButton(p2, s1: string, p3, p4) -- line: 93
	-- upvalues: Button (copy), ImageIds (copy), DropShadow (copy), ImageLabel (copy), TextLabel (copy)
	return Button({
		Name = `{ s1 }ItemButton`,
		Image = function() --[[ Image ]] -- line: 101
			-- upvalues: p4 (copy), s1 (copy), ImageIds (copy)
			if p4() == s1 then
				return ImageIds.blackButtonWhiteOutline
			end

			return ImageIds.blackCheckeredButton
		end,
		Size = UDim2.fromOffset(105.6, 110.4),
		LayoutOrder = function() --[[ LayoutOrder ]] -- line: 109
			-- upvalues: p2 (copy)
			return p2().definition.layoutOrder or 0
		end,
		Activated = function() --[[ Activated ]] -- line: 112
			-- upvalues: p3 (copy), s1 (copy)
			p3(s1)
		end,
		DropShadow({
			ZIndex = -3,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0, 0.12)
		}),
		ImageLabel({
			Name = "Icon",
			Image = function() --[[ Image ]] -- line: 124
				-- upvalues: p2 (copy)
				return p2().definition.icon
			end,
			Size = UDim2.fromOffset(56, 56),
			Position = UDim2.fromScale(0.5, 0.34),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			Text = function() --[[ Text ]] -- line: 134
				-- upvalues: p2 (copy)
				return p2().definition.name
			end,
			Size = UDim2.new(0.85, 0, 0, 34),
			Position = UDim2.fromScale(0.5, 0.74),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {},
			DropShadow = {}
		}),
		TextLabel({
			Name = "Amount",
			Text = function() --[[ Text ]] -- line: 146
				-- upvalues: p2 (copy)
				return `x{ p2().amountOwned }`
			end,
			Size = UDim2.new(1, -12, 0, 18),
			Position = UDim2.fromScale(0.875, 0.05),
			AnchorPoint = Vector2.new(1, 0),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {}
		})
	})
end
local function FeedTargetButton(p5, s2: string, p6) -- line: 158
	-- upvalues: Vide (copy), InventoryServiceUtils (copy), SlimeButton (copy), ImageIds (copy)
	local v38 = Vide.derive(function() -- line: 163
		-- upvalues: InventoryServiceUtils (copy), s2 (copy), p5 (copy)
		return InventoryServiceUtils.getSlimeData(s2, p5().value)
	end)

	return SlimeButton({
		IconScale = 0.76,
		HoverScale = 1.03,
		Image = function() --[[ Image ]] -- line: 168
			-- upvalues: p6 (copy), s2 (copy), ImageIds (copy)
			if p6() == s2 then
				return ImageIds.blackButtonWhiteOutline
			end

			return ImageIds.blackCheckeredButton
		end,
		SlimeData = v38,
		Amount = function() --[[ Amount ]] -- line: 176
			-- upvalues: p5 (copy)
			return p5().amount
		end,
		ShowLevel = function() --[[ ShowLevel ]] -- line: 179
			-- upvalues: p5 (copy)
			return type(p5().value) == "table"
		end,
		IconPosition = UDim2.fromScale(0.5, 0.825),
		LayoutOrder = function() --[[ LayoutOrder ]] -- line: 185
			-- upvalues: InventoryServiceUtils (copy), v38 (copy)
			return InventoryServiceUtils.getLayoutOrder(v38())
		end,
		Activated = function() --[[ Activated ]] -- line: 188
			-- upvalues: p6 (copy), s2 (copy)
			p6(s2)
		end
	})
end
local function InfoPanel(p7, p8) -- line: 194
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy), Frame (copy), TextLabel (copy)
	return ImageLabel({
		Name = "ItemInfo",
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Visible = function() --[[ Visible ]] -- line: 200
			-- upvalues: p8 (copy)
			return not p8()
		end,
		Size = UDim2.new(0.33, 0, 1, -20),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 20),
		Frame({
			Name = "InfoContent",
			Size = UDim2.new(1, -24, 1, -24),
			Position = UDim2.new(0.5, 0, 0, 12),
			AnchorPoint = Vector2.new(0.5, 0),
			ImageLabel({
				Name = "ItemIcon",
				Image = function() --[[ Image ]] -- line: 215
					-- upvalues: p7 (copy)
					local v69 = p7()

					if v69 then
						return v69.definition.icon
					end

					return ""
				end,
				Size = UDim2.fromOffset(108, 108),
				Position = UDim2.new(0.5, 0, 0, 12),
				AnchorPoint = Vector2.new(0.5, 0),
				ScaleType = Enum.ScaleType.Fit,
				Visible = function() --[[ Visible ]] -- line: 223
					-- upvalues: p7 (copy)
					return p7() ~= nil
				end
			}),
			TextLabel({
				Name = "ItemName",
				TextSize = 22,
				TextWrapped = true,
				Text = function() --[[ Text ]] -- line: 230
					-- upvalues: p7 (copy), p8 (copy)
					local v70 = p7()

					if v70 then
						return v70.definition.name
					end

					if p8() then
						return "No Items"
					end

					return "Select An Item"
				end,
				Size = UDim2.new(1, -10, 0, 44),
				Position = UDim2.new(0.5, 0, 0, 128),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {},
				DropShadow = {}
			}),
			TextLabel({
				Name = "OwnedAmount",
				TextSize = 16,
				Text = function() --[[ Text ]] -- line: 253
					-- upvalues: p7 (copy)
					local v71 = p7()

					if not v71 then
						return ""
					end

					return `Owned: x{ v71.amountOwned }`
				end,
				Size = UDim2.new(1, -16, 0, 24),
				Position = UDim2.new(0.5, 0, 0, 176),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {}
			}),
			TextLabel({
				Name = "Description",
				TextWrapped = true,
				TextSize = 18,
				Text = function() --[[ Text ]] -- line: 270
					-- upvalues: p7 (copy), p8 (copy)
					local v72 = p7()

					if v72 then
						return v72.definition.description
					end

					if p8() then
						return "Consumables you earn will show up here once you own at least one."
					end

					return "Pick an item on the left to see what it does."
				end,
				Size = UDim2.new(1, -18, 0, 118),
				Position = UDim2.new(0.5, 0, 0, 212),
				AnchorPoint = Vector2.new(0.5, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				Stroke = {}
			})
		})
	})
end

return function() -- line: 295
	-- upvalues: getDataSource (copy), Vide (copy), InventoryItemUtils (copy), Food (copy), InventoryServiceUtils (copy), RunService (copy), Frame (copy), ScrollingFrame (copy), indexes (copy), ItemButton (copy), UIGridLayout (copy), UIPadding (copy), TextLabel (copy), InfoPanel (copy), StylizedButton (copy), InventoryServiceClient (copy), FeedTargetButton (copy), ImageLabel (copy), ImageIds (copy), rect (copy), SlimeIcon (copy), FoodFeedPreviewCard (copy), SoundController (copy), Sounds (copy), FeedAllCheckbox (copy)
	local v41 = getDataSource("boosts")
	local v42 = getDataSource("items")
	local v43 = getDataSource("inventory")
	local v44 = Vide.source(nil)
	local v45 = Vide.source(nil)
	local v46 = Vide.source(nil)
	local v47 = Vide.source(false)
	local v48 = Vide.source(1)
	local v49, v50 = Vide.spring(v48, 1, 0.3)
	local v51 = Vide.source(1)
	local v52 = Vide.spring(v51, 0.24, 0.5)
	local v53 = Vide.derive(function() -- line: 314
		-- upvalues: InventoryItemUtils (copy), v41 (copy), v42 (copy)
		return InventoryItemUtils.getConsumableEntries(v41(), v42())
	end)
	local v54 = Vide.derive(function() -- line: 317
		-- upvalues: v44 (copy), v53 (copy), InventoryItemUtils (copy), v41 (copy), v42 (copy)
		local v73 = v44()
		local v74 = v53()

		if v73 and v74[v73] then
			return v73
		end

		return InventoryItemUtils.getFirstOwnedConsumableId(v41(), v42())
	end)
	local v55 = Vide.derive(function() -- line: 326
		-- upvalues: v54 (copy), v53 (copy)
		local v75 = v54()

		if not v75 then
			return nil
		end

		return v53()[v75]
	end)
	local v56 = Vide.derive(function() -- line: 334
		-- upvalues: v53 (copy)
		return next(v53()) == nil
	end)
	local v57 = Vide.derive(function() -- line: 337
		-- upvalues: v45 (copy), v53 (copy)
		local v76 = v45()

		if not v76 then
			return nil
		end

		local v77 = v53()[v76]

		if v77 and v77.definition.kind == "food" then
			return v77
		end

		return nil
	end)
	local v58 = Vide.derive(function() -- line: 350
		-- upvalues: v57 (copy), Food (copy)
		local v78 = v57()

		if not v78 then
			return nil
		end

		return Food.getFood(v78.definition.id)
	end)
	local v59 = Vide.derive(function() -- line: 358
		-- upvalues: v57 (copy), v47 (copy)
		local v79 = v57()

		if not v79 then
			return 1
		end

		if v47() then
			return (math.max(v79.amountOwned, 1))
		end

		return 1
	end)
	local v60 = Vide.derive(function() -- line: 370
		-- upvalues: v43 (copy)
		local t1 = {}

		for v81, v82 in v43() do
			local v83 = type(v82) ~= "number" and 1 or v82

			if v83 > 0 then
				t1[v81] = {
					value = v82,
					amount = v83
				}
			end
		end

		return t1
	end)
	local v61 = Vide.derive(function() -- line: 383
		-- upvalues: v60 (copy)
		return next(v60()) ~= nil
	end)
	local v62 = Vide.derive(function() -- line: 386
		-- upvalues: v46 (copy), v60 (copy)
		local v84 = v46()

		if v84 and v60()[v84] then
			return v84
		end

		return nil
	end)
	local v63 = Vide.derive(function() -- line: 394
		-- upvalues: v62 (copy), v60 (copy), InventoryServiceUtils (copy)
		local v85 = v62()

		if not v85 then
			return nil
		end

		local v86 = v60()[v85]

		if not v86 then
			return nil
		end

		return InventoryServiceUtils.getSlimeData(v85, v86.value)
	end)
	local v64 = Vide.derive(function() -- line: 407
		-- upvalues: v58 (copy), v63 (copy), InventoryServiceUtils (copy), v59 (copy)
		local v87 = v58()
		local v88 = v63()

		if not v87 or not v88 then
			return nil
		end

		return InventoryServiceUtils.getPreviewAfterXp(v88, v87.xp * v59())
	end)
	local v65 = Vide.derive(function() -- line: 416
		-- upvalues: v57 (copy), v62 (copy)
		return v57() ~= nil and v62() == nil
	end)
	local v66 = Vide.derive(function() -- line: 419
		-- upvalues: v57 (copy), v64 (copy)
		return v57() ~= nil and v64() ~= nil
	end)

	Vide.effect(function() -- line: 423
		-- upvalues: v57 (copy), v46 (copy), v47 (copy)
		if v57() == nil then
			v46(nil)
			v47(false)
		end
	end)

	local n1 = 0
	local connection = RunService.Heartbeat:Connect(function(dt: number) -- line: 431
		-- upvalues: n1 (ref), v50 (copy)
		n1 += dt

		if n1 < 1.15 then
			return
		end

		n1 = 0
		v50({
			impulse = -2
		})
	end)

	Vide.cleanup(function() -- line: 441
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return Frame({
		Name = "ItemsInventoryPage",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Frame({
			Name = "DefaultItemsView",
			Visible = function() --[[ Visible ]] -- line: 452
				-- upvalues: v57 (copy)
				return v57() == nil
			end,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Frame({
				Name = "ConsumablesPanel",
				Size = UDim2.new(0.68, -4, 1, -20),
				Position = UDim2.fromOffset(0, 20),
				BackgroundTransparency = 1,
				ScrollingFrame({
					Name = "ConsumablesList",
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ScrollBarImageTransparency = 1,
					ScrollBarThickness = 0,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					CanvasSize = UDim2.fromOffset(0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					indexes(v53, function(p9, p10) -- line: 474
						-- upvalues: ItemButton (copy), v44 (copy), v54 (copy)
						return ItemButton(p9, p10, v44, v54)
					end),
					UIGridLayout({
						CellSize = UDim2.fromOffset(106, 112),
						CellPadding = UDim2.fromOffset(7, 7),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					UIPadding({
						PaddingTop = UDim.new(0, 6),
						PaddingLeft = UDim.new(0, 2),
						PaddingRight = UDim.new(0, 2),
						PaddingBottom = UDim.new(0, 8)
					})
				})
			}),
			TextLabel({
				Name = "EmptyState",
				Text = "No items owned.",
				TextSize = 26,
				Visible = v56,
				Size = UDim2.new(1, -24, 0, 36),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {},
				DropShadow = {}
			}),
			InfoPanel(v55, v56),
			StylizedButton({
				Name = "UseButton",
				Theme = function() --[[ Theme ]] -- line: 510
					-- upvalues: v55 (copy)
					local v92 = v55()

					if v92 and v92.definition.kind == "food" then
						return "Blue"
					end

					return "Green"
				end,
				Visible = function() --[[ Visible ]] -- line: 518
					-- upvalues: v55 (copy)
					return v55() ~= nil
				end,
				Size = UDim2.fromOffset(160, 60),
				Position = UDim2.new(0.835, 0, 1, -31),
				AnchorPoint = Vector2.new(0.5, 1),
				Activated = function() --[[ Activated ]] -- line: 524
					-- upvalues: v55 (copy), v45 (copy), v46 (copy), v47 (copy), InventoryServiceClient (copy)
					local v93 = v55()

					if not v93 then
						return
					end

					if v93.definition.kind == "food" then
						v45(v93.definition.id)
						v46(nil)
						v47(false)

						return
					end

					InventoryServiceClient:useItem(v93.definition.id)
				end,
				TextLabel({
					Name = "ButtonLabel",
					Text = function() --[[ Text ]] -- line: 542
						-- upvalues: v55 (copy)
						local v94 = v55()

						if v94 and v94.definition.kind == "food" then
							return "Feed"
						end

						return "Use"
					end,
					Size = UDim2.fromScale(0.85, 0.6),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.425),
					Stroke = {},
					DropShadow = {}
				})
			})
		}),
		Frame({
			Name = "ChooseSlimeView",
			Visible = v65,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextLabel({
				Name = "FeedPrompt",
				Text = "Choose a slime to feed!",
				TextSize = 26,
				Size = UDim2.new(0.64, -8, 0, 36),
				Position = UDim2.fromOffset(0, 14),
				AnchorPoint = Vector2.new(0, 0),
				Stroke = {},
				DropShadow = {}
			}),
			Frame({
				Name = "SlimeSelectionPanel",
				Size = UDim2.new(0.68, -4, 1, -64),
				Position = UDim2.fromOffset(0, 58),
				BackgroundTransparency = 1,
				ScrollingFrame({
					Name = "FeedableSlimesList",
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ScrollBarImageTransparency = 1,
					ScrollBarThickness = 0,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					CanvasSize = UDim2.fromOffset(0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					indexes(v60, function(p11, p12) -- line: 592
						-- upvalues: FeedTargetButton (copy), v46 (copy)
						return FeedTargetButton(p11, p12, v46)
					end),
					UIGridLayout({
						CellSize = UDim2.fromOffset(106, 112),
						CellPadding = UDim2.fromOffset(7, 7),
						FillDirection = Enum.FillDirection.Horizontal,
						SortOrder = Enum.SortOrder.LayoutOrder
					}),
					UIPadding({
						PaddingTop = UDim.new(0, 6),
						PaddingLeft = UDim.new(0, 2),
						PaddingRight = UDim.new(0, 2),
						PaddingBottom = UDim.new(0, 8)
					})
				})
			}),
			ImageLabel({
				Name = "FoodInfo",
				Image = ImageIds.blackFrame,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = rect,
				Size = UDim2.new(0.33, 0, 1, -20),
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, 0, 0, 20),
				Frame({
					Name = "InfoContent",
					Size = UDim2.new(1, -24, 1, -24),
					Position = UDim2.new(0.5, 0, 0, 12),
					AnchorPoint = Vector2.new(0.5, 0),
					ImageLabel({
						Name = "FoodIcon",
						Image = function() --[[ Image ]] -- line: 629
							-- upvalues: v58 (copy)
							local v97 = v58()

							if v97 then
								return v97.icon
							end

							return ""
						end,
						Size = UDim2.fromOffset(108, 108),
						Position = UDim2.new(0.5, 0, 0, 12),
						AnchorPoint = Vector2.new(0.5, 0),
						ScaleType = Enum.ScaleType.Fit
					}),
					TextLabel({
						Name = "FoodName",
						TextSize = 22,
						TextWrapped = true,
						Text = function() --[[ Text ]] -- line: 641
							-- upvalues: v58 (copy)
							local v98 = v58()

							if v98 then
								return v98.name
							end

							return "Food"
						end,
						Size = UDim2.new(1, -10, 0, 44),
						Position = UDim2.new(0.5, 0, 0, 128),
						AnchorPoint = Vector2.new(0.5, 0),
						Stroke = {},
						DropShadow = {}
					}),
					TextLabel({
						Name = "FeedXp",
						TextSize = 16,
						Text = function() --[[ Text ]] -- line: 656
							-- upvalues: v58 (copy)
							local v99 = v58()

							if not v99 then
								return ""
							end

							return `Feed XP: +{ v99.xp }`
						end,
						Size = UDim2.new(1, -16, 0, 24),
						Position = UDim2.new(0.5, 0, 0, 176),
						AnchorPoint = Vector2.new(0.5, 0),
						Stroke = {}
					}),
					TextLabel({
						Name = "FoodDescription",
						TextWrapped = true,
						TextSize = 18,
						Text = function() --[[ Text ]] -- line: 673
							-- upvalues: v58 (copy), v61 (copy)
							if not v58() then
								return ""
							end

							if not v61() then
								return "You need a slime in your inventory before you can feed it."
							end

							return "Select a slime on the left to open the feed preview."
						end,
						Size = UDim2.new(1, -18, 0, 130),
						Position = UDim2.new(0.5, 0, 0, 212),
						AnchorPoint = Vector2.new(0.5, 0),
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
						Stroke = {}
					}),
					StylizedButton({
						Name = "CancelFeedButton",
						Theme = "Red",
						Text = "Cancel",
						Size = UDim2.fromOffset(160, 60),
						Position = UDim2.new(0.5, 0, 1, -18),
						AnchorPoint = Vector2.new(0.5, 1),
						Activated = function() --[[ cancelFoodSelection ]] -- line: 308
							-- upvalues: v45 (copy), v46 (copy), v47 (copy)
							v45(nil)
							v46(nil)
							v47(false)
						end
					})
				})
			})
		}),
		Frame({
			Name = "PreviewFeedView",
			Visible = v66,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextLabel({
				Name = "PreviewTitle",
				TextSize = 24,
				Text = function() --[[ Text ]] -- line: 716
					-- upvalues: v58 (copy), v59 (copy)
					local v100 = v58()

					if not v100 then
						return "Feed Slime"
					end

					local v101 = v59()
					local v102 = v100.xp * v101

					return `Feed { v100.name }? (+{ v102 } XP)`
				end,
				Size = UDim2.new(1, -24, 0, 36),
				Position = UDim2.new(0.5, 0, 0, 10),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {},
				DropShadow = {}
			}),
			Vide.show(v63, function(p13) -- line: 735
				-- upvalues: Frame (copy), v52 (copy), SlimeIcon (copy), v49 (copy)
				return Frame({
					Name = "PreviewSlimeIconFrame",
					BackgroundTransparency = 1,
					Size = function() --[[ Size ]] -- line: 739
						-- upvalues: v52 (copy)
						local v112 = v52()

						return UDim2.fromOffset(110 * v112, 110 * v112)
					end,
					Position = UDim2.new(0.5, -320, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					SlimeIcon({
						Name = "PreviewSlimeIcon",
						SlimeData = p13,
						Size = function() --[[ Size ]] -- line: 749
							-- upvalues: v49 (copy)
							return UDim2.fromScale(1, v49())
						end,
						Position = UDim2.fromScale(0.5, 1),
						AnchorPoint = Vector2.new(0.5, 1)
					})
				})
			end),
			Vide.show(function() -- line: 758
				-- upvalues: v63 (copy), v64 (copy)
				return v63() ~= nil and v64() ~= nil
			end, function() -- line: 760
				-- upvalues: v63 (copy), v64 (copy), FoodFeedPreviewCard (copy)
				local v104 = v63()
				local v105 = v64()

				if not v104 or not v105 then
					return nil
				end

				return FoodFeedPreviewCard({
					CurrentSlimeData = function() --[[ CurrentSlimeData ]] -- line: 768
						-- upvalues: v63 (copy), v104 (copy)
						return v63() or v104
					end,
					PreviewSlimeData = function() --[[ PreviewSlimeData ]] -- line: 771
						-- upvalues: v64 (copy), v105 (copy)
						return v64() or v105
					end,
					Position = UDim2.new(0.5, 0, 0, 66),
					AnchorPoint = Vector2.new(0.5, 0)
				})
			end),
			StylizedButton({
				Name = "BackToSlimesButton",
				Theme = "Red",
				Text = "Back",
				Size = UDim2.fromOffset(150, 58),
				Position = UDim2.new(0.5, -92, 1, -16),
				AnchorPoint = Vector2.new(0.5, 1),
				Activated = function() --[[ Activated ]] -- line: 786
					-- upvalues: v46 (copy), v47 (copy)
					v46(nil)
					v47(false)
				end
			}),
			StylizedButton({
				Name = "ConfirmFeedButton",
				Theme = "Green",
				Size = UDim2.fromOffset(150, 58),
				Position = UDim2.new(0.5, 92, 1, -16),
				AnchorPoint = Vector2.new(0.5, 1),
				Activated = function() --[[ Activated ]] -- line: 798
					-- upvalues: v57 (copy), v62 (copy), InventoryServiceClient (copy), v59 (copy), v46 (copy), SoundController (copy), Sounds (copy), v51 (copy)
					local v106 = v57()
					local v107 = v62()

					if not v106 or not v107 then
						return
					end

					local v108, _, v110 = InventoryServiceClient:useFood(v106.definition.id, v107, v59())

					if v108 then
						if v110 then
							v46(v110)
						end

						SoundController:Play(Sounds.misc.eat)
						v51(1.5)
						task.delay(0.08, function() -- line: 814
							-- upvalues: v51 (copy)
							v51(1)
						end)
					end
				end,
				TextLabel({
					Name = "FeedButtonLabel",
					Text = function() --[[ Text ]] -- line: 822
						-- upvalues: v59 (copy)
						local v111 = v59()

						if v111 > 1 then
							return `Feed ({ v111 })`
						end

						return "Feed"
					end,
					Size = UDim2.fromScale(0.85, 0.6),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.425),
					Stroke = {},
					DropShadow = {}
				})
			}),
			FeedAllCheckbox(v47)
		})
	})
end
