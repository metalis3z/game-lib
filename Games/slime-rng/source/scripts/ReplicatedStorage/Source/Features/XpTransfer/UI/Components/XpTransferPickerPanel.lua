-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: XpTransferPickerPanel, time of decompilation: Sun May  3 10:12:38 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local InsetFrame = require(ReplicatedStorage.Source.Features.App.Components.InsetFrame)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local indexes = Vide.indexes

local function PickerButton(p1, s1: string, p2: ((...any) -> ...any)) -- line: 36
	-- upvalues: Frame (copy), SlimeButton (copy), ImageIds (copy), InventoryServiceUtils (copy)
	return Frame({
		LayoutOrder = function() --[[ LayoutOrder ]] -- line: 38
			-- upvalues: p1 (copy)
			return p1().layoutOrder
		end,
		SlimeButton({
			IconScale = 0.68,
			Name = "XpTransferPicker_" .. s1,
			IconPosition = UDim2.fromScale(0.5, 0.76),
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Image = function() --[[ Image ]] -- line: 49
				-- upvalues: p1 (copy), ImageIds (copy)
				if p1().isSelected then
					return ImageIds.blackButtonWhiteOutline
				end

				return ImageIds.blackCheckeredButton
			end,
			SlimeData = function() --[[ SlimeData ]] -- line: 56
				-- upvalues: p1 (copy)
				return p1().slimeData
			end,
			Amount = function() --[[ Amount ]] -- line: 59
				-- upvalues: p1 (copy)
				return p1().amount
			end,
			ShowLevel = function() --[[ ShowLevel ]] -- line: 62
				-- upvalues: p1 (copy), InventoryServiceUtils (copy)
				local v21 = p1()
				local showLevel = v21.showLevel

				if showLevel then
					local slimeData = v21.slimeData

					if slimeData == nil then
						return false
					end

					showLevel = InventoryServiceUtils.getLevelProgress(slimeData).showBar
				end

				return showLevel
			end,
			Activated = function() --[[ Activated ]] -- line: 66
				-- upvalues: p2 (copy), s1 (copy)
				p2(s1)
			end
		})
	})
end

return function(t1: {[any]: any}) -- line: 73
	-- upvalues: Vide (copy), InsetFrame (copy), ScrollingFrame (copy), UIGridLayout (copy), UIPadding (copy), indexes (copy), PickerButton (copy), TextLabel (copy)
	local v19 = Vide.derive(function() -- line: 80
		-- upvalues: t1 (copy)
		if t1.ActivePicker() == "Input" then
			return t1.InputEntries()
		end

		if t1.ActivePicker() == "Output" then
			return t1.OutputEntries()
		end

		return {}
	end)
	local v20 = Vide.derive(function() -- line: 90
		-- upvalues: v19 (copy)
		return next(v19()) ~= nil
	end)

	return InsetFrame({
		Size = UDim2.new(1, -8, 0, 205),
		Position = UDim2.fromOffset(4, 192),
		Visible = function() --[[ Visible ]] -- line: 97
			-- upvalues: t1 (copy)
			return t1.ActivePicker() ~= nil
		end,
		ZIndex = 2,
		Vide.show(v20, function() -- line: 102
			-- upvalues: ScrollingFrame (copy), UIGridLayout (copy), UIPadding (copy), indexes (copy), v19 (copy), PickerButton (copy), t1 (copy)
			return ScrollingFrame({
				Size = UDim2.fromScale(0.98, 0.91),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 0,
				ScrollBarImageTransparency = 1,
				ZIndex = 3,
				UIGridLayout({
					CellSize = UDim2.fromOffset(118.8, 124.2),
					CellPadding = UDim2.fromOffset(-3, 0),
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
				UIPadding({
					PaddingTop = UDim.new(0, 2),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 2),
					PaddingRight = UDim.new(0, 2)
				}),
				indexes(v19, function(p3, p4) -- line: 128
					-- upvalues: PickerButton (copy), t1 (copy)
					return PickerButton(p3, p4, function(p5) -- line: 129
						-- upvalues: t1 (copy)
						if t1.ActivePicker() == "Input" then
							t1.OnSelectInput(p5)

							return
						end

						if t1.ActivePicker() == "Output" then
							t1.OnSelectOutput(p5)
						end
					end)
				end)
			})
		end, function() -- line: 138
			-- upvalues: TextLabel (copy), t1 (copy)
			return TextLabel({
				TextWrapped = true,
				TextSize = 19,
				ZIndex = 3,
				Text = function() --[[ Text ]] -- line: 140
					-- upvalues: t1 (copy)
					if t1.ActivePicker() == "Input" then
						return "Only slimes with XP can be used as inputs."
					end

					if t1.ActivePicker() == "Output" then
						return "Choose an input slime first, then pick a target."
					end

					return "Select a + slot above."
				end,
				Size = UDim2.new(1, -28, 1, -52),
				Position = UDim2.fromOffset(14, 42),
				TextColor3 = Color3.fromRGB(210, 210, 210),
				Stroke = {}
			})
		end)
	})
end
