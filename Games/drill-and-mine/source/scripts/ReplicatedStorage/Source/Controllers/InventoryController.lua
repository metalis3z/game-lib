local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local SLOT_COUNT = 3
local EQUIPPED_COLOR = Color3.fromRGB(80, 220, 120)
local DEFAULT_COLOR = Color3.fromRGB(0, 0, 0)

local slotButtons = {}

local function refreshSlots(hotbar, equippedItem)
	for i = 1, SLOT_COUNT do
		local slot = slotButtons[i]
		if not slot then continue end

		local item = hotbar[i]
		local icon = slot:FindFirstChild("Icon")
		local stroke = slot:FindFirstChildOfClass("UIStroke")

		if item then
			slot:SetAttribute("ItemId", item.ItemId)
			if icon then
				icon.Image = item.ImageId or ""
				icon.ImageColor3 = item.ImageColor or Color3.new(1, 1, 1)
			end
		else
			slot:SetAttribute("ItemId", "")
			if icon then
				icon.Image = ""
				icon.ImageColor3 = Color3.new(1, 1, 1)
			end
		end

		if stroke then
			local itemId = item and item.ItemId or ""
			stroke.Color = (itemId ~= "" and itemId == equippedItem) and EQUIPPED_COLOR or DEFAULT_COLOR
		end
	end
end

local function onSummaryUpdate(payload)
	if not payload then return end
	refreshSlots(payload.Hotbar or {}, payload.EquippedItem or "")
end

function InventoryController.OnSelectionChanged(_callback)
end

function InventoryController.GetSelected()
	return nil
end

function InventoryController.Init()
end

return InventoryController
