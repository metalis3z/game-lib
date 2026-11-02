local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

local Gui = script.Parent
local Template = Gui:WaitForChild("Slot")
Template.Visible = false

local Slots = {}
local Connections = {}
local OwnedTools = {}

local function Bounce(slot)
	if not slot:GetAttribute("BaseSize") then
		slot:SetAttribute("BaseSize", slot.Size)
	end

	local original = slot:GetAttribute("BaseSize")

	local grow = TweenService:Create(
		slot,
		TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{
			Size = UDim2.new(
				original.X.Scale,
				original.X.Offset + 8,
				original.Y.Scale,
				original.Y.Offset + 8
			)
		}
	)

	local shrink = TweenService:Create(
		slot,
		TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
		{
			Size = original
		}
	)

	grow:Play()
	grow.Completed:Wait()
	shrink:Play()
end

local function ClearSlots()
	for _, slot in pairs(Slots) do
		slot:Destroy()
	end

	for _, connection in pairs(Connections) do
		connection:Disconnect()
	end

	table.clear(Slots)
	table.clear(Connections)
end

local function GetCurrentTools()
	local currentTools = {}

	for _, v in ipairs(Backpack:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(currentTools, v)
		end
	end

	if Player.Character then
		for _, v in ipairs(Player.Character:GetChildren()) do
			if v:IsA("Tool") then
				table.insert(currentTools, v)
			end
		end
	end

	return currentTools
end

local function SyncTools()
	local currentTools = GetCurrentTools()
	local changed = false

	for i = #OwnedTools, 1, -1 do
		if not table.find(currentTools, OwnedTools[i]) then
			table.remove(OwnedTools, i)
			changed = true
		end
	end

	for _, tool in ipairs(currentTools) do
		if not table.find(OwnedTools, tool) then
			table.insert(OwnedTools, tool)
			changed = true
		end
	end

	return changed
end

local function HighlightSlots()
	for i, slot in ipairs(Slots) do
		local tool = OwnedTools[i]

		if tool and tool.Parent == Player.Character then
			slot.BackgroundTransparency = 1
		else
			slot.BackgroundTransparency = 1 
		end
	end
end

local function Refresh()
	ClearSlots()

	for i, tool in ipairs(OwnedTools) do
		local slot = Template:Clone()
		slot.Visible = true
		slot.Parent = Gui

		slot.Number.Text = tostring(i)

		if tool.TextureId ~= "" then
			slot.Itemimage.Image = tool.TextureId
		end

		slot.BackgroundTransparency = 1
		table.insert(Slots, slot)

		table.insert(Connections,
			tool.Equipped:Connect(function()
				HighlightSlots()
				Bounce(slot)
			end)
		)

		table.insert(Connections,
			tool.Unequipped:Connect(function()
				HighlightSlots()
			end)
		)

		slot.MouseButton1Click:Connect(function()
			local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
			if not humanoid then return end

			if tool.Parent == Player.Character then
				humanoid:UnequipTools()
			else
				humanoid:EquipTool(tool)
			end
		end)
	end

	HighlightSlots()
end

local function HandleToolChange(child)
	if child:IsA("Tool") then
		task.defer(function()
			if SyncTools() then
				Refresh()
			else
				HighlightSlots()
			end
		end)
	end
end

local function EquipSlot(index)
	local tool = OwnedTools[index]
	if not tool then return end

	local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if tool.Parent == Player.Character then
		humanoid:UnequipTools()
	else
		humanoid:EquipTool(tool)
	end
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	local keys = {
		[Enum.KeyCode.One] = 1,
		[Enum.KeyCode.Two] = 2,
		[Enum.KeyCode.Three] = 3,
		[Enum.KeyCode.Four] = 4,
		[Enum.KeyCode.Five] = 5,
		[Enum.KeyCode.Six] = 6,
		[Enum.KeyCode.Seven] = 7,
		[Enum.KeyCode.Eight] = 8,
		[Enum.KeyCode.Nine] = 9,
		[Enum.KeyCode.Zero] = 10
	}

	local index = keys[input.KeyCode]
	if index then
		EquipSlot(index)
	end
end)

Backpack.ChildAdded:Connect(HandleToolChange)
Backpack.ChildRemoved:Connect(HandleToolChange)

Player.CharacterAdded:Connect(function(character)
	character.ChildAdded:Connect(HandleToolChange)
	character.ChildRemoved:Connect(HandleToolChange)

	task.defer(function()
		SyncTools()
		Refresh()
	end)
end)

if Player.Character then
	Player.Character.ChildAdded:Connect(HandleToolChange)
	Player.Character.ChildRemoved:Connect(HandleToolChange)
end

task.wait(0.1)
SyncTools()
Refresh()