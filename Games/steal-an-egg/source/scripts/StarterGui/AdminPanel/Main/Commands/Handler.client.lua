-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local exoremotes = game:GetService("ReplicatedStorage"):WaitForChild("exoremotes")
local v1 = script.Parent
local AddCash = v1:WaitForChild("AddCash")
local AddSpeed = v1:WaitForChild("AddSpeed")
local SetCash = v1:WaitForChild("SetCash")
local SetSpeed = v1:WaitForChild("SetSpeed")
local GivePet = v1:WaitForChild("GivePet")
local GiveEgg = v1:WaitForChild("GiveEgg")

local function findthebuttonbro(p1) --[[ findthebuttonbro | Line: 12 ]]
	return p1:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
end

local Button = AddCash:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
local Button2 = AddSpeed:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
local Button3 = SetCash:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
local Button4 = SetSpeed:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
local Button5 = GivePet:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")
local Button6 = GiveEgg:WaitForChild("SendBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button")

-- ===== Pet Selector UI =====
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetViewport = require(ReplicatedStorage.Library.Client.AssetViewport)
local Directory = Assets.Directory

local PetSelector = v1.Parent.Parent:WaitForChild("PetSelector")
local Panel = PetSelector:WaitForChild("Panel")
local Grid = Panel:WaitForChild("Grid")
local Template = Grid:WaitForChild("PetTemplate")
local CloseBtn = Panel:WaitForChild("CloseBtn")
local SelectPetBtn = GivePet:WaitForChild("SelectPetBtn")

local selectedSlot = nil

local function clearSelection()
	if selectedSlot then
		local stroke = selectedSlot:FindFirstChild("SelectionStroke")
		if stroke then
			stroke.Thickness = 0
		end
		selectedSlot = nil
	end
end

local function selectSlot(slot, petName)
	clearSelection()
	selectedSlot = slot
	GivePet.NameBox.Text = petName
	local stroke = slot:FindFirstChild("SelectionStroke")
	if stroke then
		stroke.Thickness = 2
	end
	PetSelector.Visible = false
end

-- Build the list of all pets from the Assets directory
local petNames = {}
for name in pairs(Directory) do
	table.insert(petNames, name)
end
table.sort(petNames)

for _, petName in ipairs(petNames) do
	local slot = Template:Clone()
	slot.Name = petName
	slot.LayoutOrder = _
	slot.Visible = true
	slot.Parent = Grid

	local viewport = slot:WaitForChild("Viewport")
	local _, _, model = AssetViewport.AttachOnViewport(petName, viewport, false)

	if model == nil then
		slot:Destroy()
	else
		local config = Directory[petName]
		local nameLabel = slot:WaitForChild("Name")
		nameLabel.Text = if config and config.DisplayName then config.DisplayName else petName

		slot.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				selectSlot(slot, petName)
			end
		end)
	end
end

SelectPetBtn.MouseButton1Click:Connect(function()
	PetSelector.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
	PetSelector.Visible = false
end)

GivePet:WaitForChild("InfoBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button").MouseButton1Click:Connect(function() --[[ Line: 24 | Upvalues: v1 (copy) ]]
	v1.Parent.Info.Visible = true
end)
GiveEgg:WaitForChild("InfoBtnFrame"):WaitForChild("BtnFrame"):WaitForChild("Button").MouseButton1Click:Connect(function() --[[ Line: 28 | Upvalues: v1 (copy) ]]
	v1.Parent.Info.Visible = true
end)
Button.MouseButton1Click:Connect(function() --[[ Line: 32 | Upvalues: AddCash (copy), exoremotes (copy) ]]
	local TextBox = AddCash.TextBox

	if TextBox.Text == "" or TextBox.Text == "Cash..." then
		return
	end

	local v1 = tonumber(TextBox.Text)

	if not v1 then
		return
	end

	exoremotes.AddCash:FireServer(v1)
end)
Button2.MouseButton1Click:Connect(function() --[[ Line: 42 | Upvalues: AddSpeed (copy), exoremotes (copy) ]]
	local TextBox = AddSpeed.TextBox

	if TextBox.Text == "" or TextBox.Text == "Speed..." then
		return
	end

	local v1 = tonumber(TextBox.Text)

	if not v1 then
		return
	end

	exoremotes.SetSpeed:FireServer(v1)
end)
Button3.MouseButton1Click:Connect(function() --[[ Line: 52 | Upvalues: SetCash (copy), exoremotes (copy) ]]
	local TextBox = SetCash.TextBox

	if TextBox.Text == "" or TextBox.Text == "Cash..." then
		return
	end

	local v1 = tonumber(TextBox.Text)

	if not v1 then
		return
	end

	exoremotes.SetCash:FireServer(v1)
end)
Button4.MouseButton1Click:Connect(function() --[[ Line: 62 | Upvalues: SetSpeed (copy), exoremotes (copy) ]]
	local TextBox = SetSpeed.TextBox

	if TextBox.Text == "" or TextBox.Text == "Speed..." then
		return
	end

	local v1 = tonumber(TextBox.Text)

	if not v1 then
		return
	end

	exoremotes.SetSpeed:FireServer(v1)
end)
Button5.MouseButton1Click:Connect(function() --[[ Line: 72 | Upvalues: GivePet (copy), exoremotes (copy) ]]
	local SizeBox = GivePet.SizeBox
	local NameBox = GivePet.NameBox

	if NameBox.Text == "" or SizeBox.Text == "" then
		return
	end

	local v1 = tonumber(SizeBox.Text)

	if not v1 then
		return
	end

	exoremotes.GivePet:FireServer(NameBox.Text, v1)
end)
Button6.MouseButton1Click:Connect(function() --[[ Line: 83 | Upvalues: GiveEgg (copy), exoremotes (copy) ]]
	local Amount = GiveEgg.Amount
	local NameBox = GiveEgg.NameBox

	if NameBox.Text == "" or Amount.Text == "" then
		return
	end

	local v1 = tonumber(Amount.Text)

	if not v1 then
		return
	end

	exoremotes.GiveEgg:FireServer(NameBox.Text, v1)
end)