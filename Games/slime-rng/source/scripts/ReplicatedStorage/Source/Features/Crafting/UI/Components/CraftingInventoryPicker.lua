-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingInventoryPicker, time of decompilation: Sun May  3 10:12:27 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local indexes = Vide.indexes

local function PickerButton(p1, s1: string, p2: ((...any) -> ...any)) -- line: 29
	-- upvalues: Frame (copy), SlimeButton (copy), ImageIds (copy)
	return Frame({
		Size = UDim2.fromOffset(132, 132),
		LayoutOrder = function() --[[ LayoutOrder ]] -- line: 32
			-- upvalues: p1 (copy)
			return p1().layoutOrder
		end,
		SlimeButton({
			IconScale = 0.72,
			Name = "CraftingPicker_" .. s1,
			IconPosition = UDim2.fromScale(0.5, 0.76),
			Size = UDim2.fromScale(0.95, 0.95),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.55),
			Image = function() --[[ Image ]] -- line: 43
				-- upvalues: p1 (copy), ImageIds (copy)
				if p1().isSelected then
					return ImageIds.blackButtonWhiteOutline
				end

				return ImageIds.blackCheckeredButton
			end,
			SlimeData = function() --[[ SlimeData ]] -- line: 50
				-- upvalues: p1 (copy)
				return p1().slimeData
			end,
			Amount = function() --[[ Amount ]] -- line: 53
				-- upvalues: p1 (copy)
				return p1().amount
			end,
			ShowLevel = function() --[[ ShowLevel ]] -- line: 56
				-- upvalues: p1 (copy)
				return p1().showLevel
			end,
			Activated = function() --[[ Activated ]] -- line: 60
				-- upvalues: p2 (copy), s1 (copy)
				p2(s1)
			end
		})
	})
end

return function(t1: {[any]: any}) -- line: 67
	-- upvalues: Vide (copy), Frame (copy), ScrollingFrame (copy), indexes (copy), PickerButton (copy), UIListLayout (copy), UIPadding (copy), TextLabel (copy)
	local v16 = Vide.derive(function() -- line: 68
		-- upvalues: t1 (copy)
		return next(t1.Entries()) ~= nil
	end)

	return Frame({
		Name = "CraftingInventoryPicker",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Vide.show(v16, function() -- line: 77
			-- upvalues: ScrollingFrame (copy), indexes (copy), t1 (copy), PickerButton (copy), UIListLayout (copy), UIPadding (copy)
			return ScrollingFrame({
				Name = "PickerList",
				Size = UDim2.fromScale(0.97, 0.9),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ScrollBarThickness = 10,
				ScrollingDirection = Enum.ScrollingDirection.X,
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.X,
				HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
				indexes(t1.Entries, function(p3, p4) -- line: 90
					-- upvalues: PickerButton (copy), t1 (copy)
					return PickerButton(p3, p4, t1.OnSelect)
				end),
				UIListLayout({
					Padding = UDim.new(0, 8),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Center
				}),
				UIPadding({
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 2),
					PaddingRight = UDim.new(0, 2)
				})
			})
		end, function() -- line: 109
			-- upvalues: TextLabel (copy), t1 (copy)
			return TextLabel({
				TextWrapped = true,
				TextSize = 20,
				Text = t1.EmptyText,
				Size = UDim2.new(1, -10, 1, -10),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Stroke = {}
			})
		end)
	})
end
