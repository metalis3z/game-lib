-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: TeleporterMenu, time of decompilation: Sun May  3 10:11:54 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local ZonesServiceClient = require(ReplicatedStorage.Source.Features.Zones.ZonesServiceClient)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local rect = Rect.new(22, 52, 112, 52)

local function TeleportRow(t1: {[any]: any}) -- line: 25
	-- upvalues: Zones (copy), ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy), StylizedButton (copy), ZonesServiceClient (copy)
	local v18 = Zones.getZone(t1.ZoneId)

	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.new(0.95, 0, 0, 84),
		LayoutOrder = t1.ZoneId,
		Visible = function() --[[ Visible ]] -- line: 34
			-- upvalues: t1 (copy)
			return t1.ZoneId <= (t1.MaxZone() or 1)
		end,
		TextLabel({
			Text = tostring(t1.ZoneId),
			Size = UDim2.fromScale(0.14, 0.6),
			Position = UDim2.fromScale(0.06, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		}),
		TextLabel({
			Text = v18.name,
			Size = UDim2.fromScale(0.42, 0.6),
			Position = UDim2.fromScale(0.12, 0.45),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		}),
		StylizedButton({
			Theme = "Green",
			Text = "Teleport",
			Size = UDim2.fromOffset(150, 55),
			Position = UDim2.fromScale(0.88, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ Activated ]] -- line: 63
				-- upvalues: ZonesServiceClient (copy), t1 (copy)
				ZonesServiceClient:teleportToZone(t1.ZoneId)
			end
		})
	})
end
local function TeleporterPage() -- line: 70
	-- upvalues: getDataSource (copy), Zones (copy), TeleportRow (copy), Frame (copy), ScrollingFrame (copy), UIPadding (copy), UIListLayout (copy)
	local v19 = getDataSource("maxZone")
	local t2 = {}

	for i = 1, Zones.getMaxZone() do
		table.insert(t2, TeleportRow({
			ZoneId = i,
			MaxZone = v19
		}))
	end

	return Frame({
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ScrollingFrame({
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, -8),
			Position = UDim2.fromOffset(0, 8),
			CanvasSize = UDim2.fromOffset(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 6,
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			UIPadding({
				PaddingTop = UDim.new(0, 6),
				PaddingBottom = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 4)
			}),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 4)
			}),
			t2
		})
	})
end

return {
	menuId = "Teleporter",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 115
		-- upvalues: Menu (copy), TeleporterPage (copy)
		return Menu.Component({
			menuId = "Teleporter",
			Title = "Teleporter",
			TeleporterPage()
		})
	end
}
