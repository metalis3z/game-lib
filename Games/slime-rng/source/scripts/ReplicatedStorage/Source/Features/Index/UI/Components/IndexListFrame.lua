-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexListFrame, time of decompilation: Sun May  3 10:12:34 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local rect = Rect.new(62, 52, 62, 52)

local function IndexEntry(t1: {[any]: any}) -- line: 28
	-- upvalues: Vide (copy), IndexServiceUtils (copy), Mutations (copy), ImageLabel (copy), ImageIds (copy), rect (copy), SlimeButton (copy), TextLabel (copy)
	local v16 = Vide.derive(function() -- line: 29
		-- upvalues: IndexServiceUtils (copy), t1 (copy)
		return IndexServiceUtils.createDisplaySlimeData(t1.CategoryId(), t1.SlimeInfo.id)
	end)
	local v17 = Vide.derive(function() -- line: 32
		-- upvalues: Mutations (copy), t1 (copy), v16 (copy)
		return Mutations.getDisplayName(t1.SlimeInfo.name, v16().mutations)
	end)

	return ImageLabel({
		Name = t1.SlimeInfo.id .. "IndexEntry",
		Image = function() --[[ Image ]] -- line: 41
			-- upvalues: t1 (copy), ImageIds (copy)
			if t1.SelectedSlimeId() == t1.SlimeInfo.id then
				return ImageIds.blackButtonWhiteOutline
			end

			return ImageIds.blackCheckeredButton
		end,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		LayoutOrder = t1.SlimeInfo.layout,
		SlimeButton({
			ShowLevel = false,
			ZIndex = 2,
			ShowHoverInfo = false,
			SlimeData = v16,
			Size = UDim2.fromScale(0.75, 0.75),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.425),
			IconColor3 = function() --[[ IconColor3 ]] -- line: 58
				-- upvalues: IndexServiceUtils (copy), t1 (copy)
				if IndexServiceUtils.isUnlockedFromData(t1.IndexData(), t1.CategoryId(), t1.SlimeInfo.id) then
					return Color3.fromRGB(255, 255, 255)
				end

				return Color3.fromRGB(0, 0, 0)
			end,
			IconTransparency = function() --[[ IconTransparency ]] -- line: 65
				-- upvalues: IndexServiceUtils (copy), t1 (copy)
				if IndexServiceUtils.isUnlockedFromData(t1.IndexData(), t1.CategoryId(), t1.SlimeInfo.id) then
					return 0
				end

				return 0.35
			end,
			Activated = function() --[[ Activated ]] -- line: 73
				-- upvalues: t1 (copy)
				t1.OnSelected(t1.SlimeInfo.id)
			end
		}),
		TextLabel({
			Name = "SlimeName",
			ZIndex = 3,
			Text = function() --[[ Text ]] -- line: 81
				-- upvalues: IndexServiceUtils (copy), t1 (copy), v17 (copy)
				if IndexServiceUtils.isUnlockedFromData(t1.IndexData(), t1.CategoryId(), t1.SlimeInfo.id) then
					return string.upper(v17())
				end

				return "???"
			end,
			Size = UDim2.fromScale(0.9, 0.15),
			Position = UDim2.fromScale(0.5, 0.05),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {},
			DropShadow = {}
		})
	})
end

return function(t2: {[any]: any}) -- line: 98
	-- upvalues: Slimes (copy), IndexEntry (copy), ImageLabel (copy), ImageIds (copy), rect (copy), ScrollingFrame (copy), UIPadding (copy), UIGridLayout (copy)
	local t3 = {}

	for _, v21 in Slimes.getSortedSlimes() do
		table.insert(t3, IndexEntry({
			CategoryId = t2.CategoryId,
			SelectedSlimeId = t2.SelectedSlimeId,
			IndexData = t2.IndexData,
			SlimeInfo = v21,
			OnSelected = t2.OnSelected
		}))
	end

	return ImageLabel({
		Name = "IndexListFrame",
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromScale(0.69, 0.78),
		Position = UDim2.fromOffset(0, 8),
		BackgroundTransparency = 1,
		ScrollingFrame({
			Name = "IndexEntries",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.94, 0.89),
			Position = UDim2.fromScale(0.5, 0.47),
			AnchorPoint = Vector2.new(0.5, 0.5),
			CanvasSize = UDim2.fromOffset(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 0,
			UIPadding({
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4)
			}),
			UIGridLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.fromOffset(0, 0),
				CellSize = UDim2.fromOffset(114.84, 120.06)
			}),
			t3
		})
	})
end
