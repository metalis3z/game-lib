-- EquippedSlimesFrame (Client ModuleScript) - PATCHED
-- FIXES:
--   1. #v29() returns 0 for dict tables — replaced with a helper that counts properly
--   2. Slot(n1) now correctly reads array-style equipped {[1]="uid"}
--   3. Unequip now sends slot number which InventoryService handles correctly

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local getSlimeDataFromUniqueIdSource = require(ReplicatedStorage.Source.Features.App.Sources.getSlimeDataFromUniqueIdSource)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

-- FIXED: Count equipped slots properly for both array-style {[1]="uid"} and dict-style {"uid"=true}
local function countEquipped(equipped)
	if type(equipped) ~= "table" then return 0 end
	local count = 0
	for k, v in pairs(equipped) do
		if (type(k) == "number" and type(v) == "string") or
			(type(k) == "string" and v == true) then
			count += 1
		end
	end
	return count
end

-- FIXED: Get the uniqueId at a given slot index for array-style equipped tables
local function getEquippedAtSlot(equipped, slotIndex)
	if type(equipped) ~= "table" then return nil end
	-- Array-style: {[1]="uid1", [2]="uid2"}
	if type(equipped[slotIndex]) == "string" then
		return equipped[slotIndex]
	end
	-- Dict-style fallback: collect all uids, sort by insertion order (best effort)
	local uids = {}
	for k, v in pairs(equipped) do
		if type(k) == "string" and v == true then
			table.insert(uids, k)
		end
	end
	table.sort(uids)
	return uids[slotIndex]
end

local function useOwnedGamepass(p1)
	local v20 = Vide.source(MonetizationServiceClient:ownsGamepass(p1))
	local connection = client:getChangedSignal({
		"__gamepasses",
		(tostring(p1.id))
	}):Connect(function()
		v20(MonetizationServiceClient:ownsGamepass(p1))
	end)

	Vide.cleanup(function()
		connection:Disconnect()
	end)

	return v20
end

local function Slot(n1: number, p2, p3)
	-- FIXED: use getEquippedAtSlot instead of p3()[n1] directly
	local v25 = Vide.derive(function()
		return getEquippedAtSlot(p3(), n1)
	end)
	local v26 = getDataSource("inventory")
	local v27 = getSlimeDataFromUniqueIdSource(v25)
	local v28 = Vide.derive(function()
		local v35 = v25()
		if v35 == nil then
			return false
		end
		return type((v26() or {})[v35]) == "table"
	end)

	return Frame({
		Visible = function()
			return n1 <= p2()
		end,
		LayoutOrder = function()
			local v36 = v27()
			if not v36 then
				return 0
			end
			return InventoryServiceUtils.getLayoutOrder(v36)
		end,
		Size = UDim2.fromOffset(110, 110),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		ImageLabel({
			Name = "EmptySlot",
			Visible = function()
				return not v27()
			end,
			Size = UDim2.fromOffset(87, 62),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Image = ImageIds.emptySlot
		}),
		Vide.show(v27, function(p4)
			return SlimeButton({
				SlimeData = p4,
				ShowLevel = v28,
				Size = UDim2.fromScale(1, 1),
				Activated = function()
					-- Send slot number — server's requestUnequip handles this
					InventoryServiceClient:unequipSlime(n1)
				end
			})
		end)
	})
end

return function()
	local v29 = getDataSource("equipped")
	local v30 = getDataSource("upgrades")
	local v31 = useOwnedGamepass(Products.extraEquip)
	local v32 = Vide.derive(function()
		return InventoryServiceUtils.getOwnedSlotCount(v30() or {}, not v31() and 0 or 1)
	end)
	local t1 = {}

	for i = 1, 8 do
		t1[i] = Slot(i, v32, v29)
	end

	return Frame({
		Name = "EquippedSlimesFrame",
		Size = UDim2.fromScale(1, 0.4),
		Position = UDim2.fromScale(0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		TextLabel({
			-- FIXED: use countEquipped() instead of #v29()
			Text = function()
				return `{ countEquipped(v29()) }/{ v32() } Equipped`
			end,
			Size = UDim2.fromOffset(200, 24),
			Position = UDim2.fromScale(0.5, 0.08),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2,
				Color = Color3.fromRGB(16, 17, 19)
			}
		}),
		ImageLabel({
			ImageTransparency = 0.6,
			Size = UDim2.fromOffset(100.8, 15.75),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(0.42, 0.11),
			Image = ImageIds.rollDivider
		}),
		ImageLabel({
			Rotation = 180,
			ImageTransparency = 0.6,
			Size = UDim2.fromOffset(100.8, 15.75),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.fromScale(0.58, 0.11),
			Image = ImageIds.rollDivider
		}),
		Frame({
			Name = "Container",
			Size = UDim2.fromScale(1, 0.72),
			Position = UDim2.fromScale(0.5, 0.95),
			AnchorPoint = Vector2.new(0.5, 1),
			UIListLayout({
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal
			}),
			t1
		}),
		ImageLabel({
			Name = "MenuDivider",
			Image = ImageIds.menuDivider,
			Size = UDim2.fromOffset(766, 40),
			Position = UDim2.fromScale(0.5, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageTransparency = 0.2,
			UIGradient({
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.33, 0),
					NumberSequenceKeypoint.new(0.66, 0),
					NumberSequenceKeypoint.new(1, 1)
				})
			})
		})
	})
end