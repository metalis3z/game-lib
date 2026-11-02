-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)
local BaseUpgradeClient = require(ReplicatedStorage.Library.Client.BaseUpgradeClient)
local Bases = require(ReplicatedStorage.Directory.Bases)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local ConsoleCmds = require(ReplicatedStorage.Library.Client.ConsoleCmds)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PetPenCapacityGuidanceController = require(script.PetPenCapacityGuidanceController)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Color3.fromRGB(255, 70, 70)
local v2 = Color3.fromRGB(85, 255, 85)
local v3 = Color3.new(0.760784, 0, 0)
local LocalPlayer = Players.LocalPlayer
local v4 = GUI.PetList()
local v5 = GUI.SideButtons()
local Frame = v4.Frame
local TextLabel = Frame.Header.TextLabel
local TextLabel2 = TextLabel.TextLabel
local MaxSlot = Frame.Header.MaxSlot
local TextLabel3 = MaxSlot.Purchase.TextLabel
local TextLabel4 = TextLabel3.TextLabel
local ScrollingFrame = Frame.Notepad.ScrollingFrame
local Template = ScrollingFrame.Template
local Close = Frame.Close
local EquipBest = Frame.EquipBest
local Pets = v5.Left.Tools.Pets
local BackgroundColor3 = MaxSlot.BackgroundColor3
local UIGradient = MaxSlot:FindFirstChildOfClass("UIGradient")
local v6 = if UIGradient == nil then false else UIGradient.Enabled
local v7 = Trove.new()
local v8 = 0
local v9 = false
local v10 = 0

assert(v4:IsA("ScreenGui"), "PlayerGui.PetList must be a ScreenGui")
assert(Frame:IsA("GuiObject"), "PetList.Frame must be a GuiObject")
assert(TextLabel:IsA("TextLabel"), "PetList.Frame.Header.TextLabel must be a TextLabel")
assert(TextLabel2:IsA("TextLabel"), "PetList.Frame.Header.TextLabel.TextLabel must be a TextLabel")
assert(MaxSlot:IsA("GuiButton"), "PetList.Frame.Header.MaxSlot must be a GuiButton")
assert(TextLabel3:IsA("TextLabel"), "PetList.Frame.Header.MaxSlot.Purchase.TextLabel must be a TextLabel")
assert(TextLabel4:IsA("TextLabel"), "PetList.Frame.Header.MaxSlot.Purchase.TextLabel.TextLabel must be a TextLabel")
assert(ScrollingFrame:IsA("ScrollingFrame"), "PetList.Frame.Notepad.ScrollingFrame must be a ScrollingFrame")
assert(Template:IsA("GuiObject"), "PetList.Frame.Notepad.ScrollingFrame.Template must be a GuiObject")
assert(Close:IsA("GuiButton"), "PetList.Frame.Close must be a GuiButton")
assert(EquipBest:IsA("GuiButton"), "PetList.Frame.EquipBest.TextButton must be a GuiButton")
assert(Pets:IsA("GuiButton"), "Elements.Tabs.Pets must be a GuiButton")
MaxSlot.AutoButtonColor = false
ConsoleCmds.RegisterCloseButton(Close)

local function setOpen(p1) --[[ setOpen | Line: 122 | Upvalues: v4 (copy), Pets (copy) ]]
	v4.Enabled = p1
	Pets.Visible = not p1
end

local function getCapacity(p1) --[[ getCapacity | Line: 127 | Upvalues: Bases (copy) ]]
	return Bases.GetAssetEquipCapacity(if p1 == nil then nil else p1.BaseUpgradeLevel)
end

local function setTextWithShadow(p1, p2, p3) --[[ setTextWithShadow | Line: 131 ]]
	p1.Text = p3
	p2.Text = p3
end

local function formatDisplayNameWithRate(p1) --[[ formatDisplayNameWithRate | Line: 136 | Upvalues: Simple (copy) ]]
	return p1.DisplayName .. " ($" .. Simple.FormatCompact(p1.Rate, ".#") .. "/s)"
end

local function updateHeader(p1, p2) --[[ updateHeader | Line: 140 | Upvalues: Bases (copy), TextLabel (copy), TextLabel2 (copy), BaseUpgradeClient (copy), Simple (copy), TextLabel3 (copy), TextLabel4 (copy), MaxSlot (copy), BackgroundColor3 (copy), v3 (copy), UIGradient (copy), v6 (copy) ]]
	local v5 = ("%*/%* Active"):format(p2, (Bases.GetAssetEquipCapacity(if p1 == nil then nil else p1.BaseUpgradeLevel)))

	TextLabel.Text = v5
	TextLabel2.Text = v5

	local v62

	if p1 == nil then
		v62 = nil
	else
		local _, v7 = BaseUpgradeClient.GetNextConfig(p1)

		v62 = if v7 == nil then nil else v7.Cost
	end

	local v8 = if v62 == nil then "MAX EQUIP" else ("+1 EQUIP [$%*]"):format((Simple.FormatCompact(math.floor(v62), ".#")))

	TextLabel3.Text = v8
	TextLabel4.Text = v8
	MaxSlot.Active = if v62 == nil then false else true

	local v12 = if v62 == nil or p1 == nil then false else v62 <= p1.Money

	MaxSlot.BackgroundColor3 = if v12 then BackgroundColor3 else v3

	if UIGradient == nil then
		return
	end

	UIGradient.Enabled = if v12 then v6 else v12
end

local function compareEntries(p1, p2) --[[ compareEntries | Line: 161 ]]
	if p1.RarityNumber == p2.RarityNumber then
		if p1.Rate == p2.Rate then
			return p1.UID < p2.UID
		end

		return p1.Rate > p2.Rate
	end

	return p1.RarityNumber > p2.RarityNumber
end

local function buildEntries(p1) --[[ buildEntries | Line: 171 | Upvalues: AssetItemSerialization (copy), Assets (copy), AssetGenerationUtil (copy), compareEntries (copy) ]]
	if p1 == nil then
		return {}
	end

	local t = {}

	for i, v in ipairs(p1.EquippedAssets) do
		local v1 = p1.Inventory[v]

		if v1 ~= nil then
			local v2 = AssetItemSerialization.Deserialize(v1)
			local v3 = Assets.Directory[v2.Category]
			local Rarity = v3.Rarity
			local t2 = {
				UID = v
			}

			t2.DisplayName = if v3.DisplayName == "" then v2.Category else v3.DisplayName
			t2.Icon = v3.Icon
			t2.Rate = AssetGenerationUtil.GetRate(v2, p1.Rebirth, p1.Gamepasses, p1.Products)
			t2.RarityNumber = Rarity.RarityNumber
			t2.RarityGradient = Rarity.Gradient
			table.insert(t, t2)
		end
	end

	table.sort(t, compareEntries)

	return t
end

local function requestUnequip(p1) --[[ requestUnequip | Line: 200 | Upvalues: AssetCmds (copy), Message (copy), v1 (copy) ]]
	local v12, v2 = AssetCmds.RequestUnequipAsset(p1)

	if v12 or v2 == nil then
		return
	end

	Message.Bottom({
		Time = 2,
		PreventDuplicateText = true,
		Message = v2,
		Color = v1
	})
end

local function mountRow(p1, p2) --[[ mountRow | Line: 212 | Upvalues: Trove (copy), v7 (copy), Template (copy), Simple (copy), AssetCmds (copy), Message (copy), v1 (copy), ScrollingFrame (copy) ]]
	local v12 = Trove.new()

	v7:Add(v12)

	local v2 = Template:Clone()

	v2.Name = ("Pet_%*"):format(p1.UID)
	v2.LayoutOrder = p2
	v2.Visible = true
	v2:SetAttribute("PetListRowClone", true)
	v12:Add(v2)

	local Main_Frame = v2.Main_Frame
	local TextLabel = Main_Frame.TextLabel
	local TextLabel2 = TextLabel.TextLabel

	if p1.RarityGradient ~= nil then
		p1.RarityGradient:Clone().Parent = TextLabel2
	end

	local v3 = p1.DisplayName .. " ($" .. Simple.FormatCompact(p1.Rate, ".#") .. "/s)"

	TextLabel.Text = v3
	TextLabel2.Text = v3
	Main_Frame.PetImage.Image = p1.Icon or ""
	v12:Connect(Main_Frame.Unequip.Activated, function() --[[ Line: 235 | Upvalues: p1 (copy), AssetCmds (ref), Message (ref), v1 (ref) ]]
		local v12, v2 = AssetCmds.RequestUnequipAsset(p1.UID)

		if v12 or v2 == nil then
			return
		end

		Message.Bottom({
			Time = 2,
			PreventDuplicateText = true,
			Message = v2,
			Color = v1
		})
	end)
	v2.Parent = ScrollingFrame
end

local function refresh() --[[ refresh | Line: 242 | Upvalues: v7 (copy), ScrollingFrame (copy), Save (copy), LocalPlayer (copy), buildEntries (copy), v10 (ref), mountRow (copy), updateHeader (copy) ]]
	v7:Clean()

	for i, v in ipairs(ScrollingFrame:GetChildren()) do
		if v:GetAttribute("PetListRowClone") == true then
			v:Destroy()
		end
	end

	local v1 = Save.Get(LocalPlayer, false)
	local v2 = buildEntries(v1)

	v10 = #v2

	for i, v in ipairs(v2) do
		mountRow(v, i)
	end

	updateHeader(v1, v10)
end

local function refreshUpgradeHeader() --[[ refreshUpgradeHeader | Line: 260 | Upvalues: updateHeader (copy), Save (copy), LocalPlayer (copy), v10 (ref) ]]
	updateHeader(Save.Get(LocalPlayer, false), v10)
end

local function showEquipBestDebounceNotification() --[[ showEquipBestDebounceNotification | Line: 264 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Message = "Please wait a bit before equipping bests again!",
		Time = 2,
		PreventDuplicateText = true,
		Color = Color3.fromRGB(255, 170, 0)
	})
end

local function requestEquipBest() --[[ requestEquipBest | Line: 273 | Upvalues: v9 (ref), v8 (ref), Message (copy), Network (copy), Constants (copy), refresh (copy), v1 (copy) ]]
	local v12 = workspace:GetServerTimeNow()

	if v9 or v12 - v8 < 5 then
		Message.Bottom({
			Message = "Please wait a bit before equipping bests again!",
			Time = 2,
			PreventDuplicateText = true,
			Color = Color3.fromRGB(255, 170, 0)
		})

		return
	end

	v8 = v12
	v9 = true

	local v2, v3 = Network.Invoke(Constants.NETWORK_MAP.Backpack.EQUIP_BEST)

	v9 = false

	if v2 == true then
		refresh()

		return
	end

	local t = {
		Time = 2,
		PreventDuplicateText = true
	}

	t.Message = if typeof(v3) == "string" then v3 else "Please wait a bit before equipping bests again!"
	t.Color = v1
	Message.Bottom(t)
end

local function requestBaseUpgrade() --[[ requestBaseUpgrade | Line: 297 | Upvalues: BaseUpgradeClient (copy) ]]
	BaseUpgradeClient.RequestCashUpgrade()
end

Template.Visible = false
v4.Enabled = false
Pets.Visible = true
refresh()
PetPenCapacityGuidanceController.Initialize()
GUI.ButtonActivated(Pets, function() --[[ Line: 310 | Upvalues: PetPenCapacityGuidanceController (copy), v4 (copy), Pets (copy), refresh (copy) ]]
	PetPenCapacityGuidanceController.AcknowledgePetsBadge()
	v4.Enabled = true
	Pets.Visible = false
	refresh()
end)
GUI.ButtonActivated(Close, function() --[[ Line: 315 | Upvalues: v4 (copy), Pets (copy) ]]
	v4.Enabled = false
	Pets.Visible = true
end)
GUI.ButtonActivated(MaxSlot, requestBaseUpgrade)
GUI.ButtonActivated(EquipBest, function() --[[ Line: 319 | Upvalues: PetPenCapacityGuidanceController (copy), requestEquipBest (copy) ]]
	PetPenCapacityGuidanceController.AcknowledgeEquipBestBadge()
	requestEquipBest()
end)
Save.ConnectForDataChanged({ "Inventory", "EquippedAssets", "BaseUpgradeLevel", "Rebirth", "Gamepasses", "Products" }, refresh)
Save.GetStatChangedSignal("Money"):Connect(refreshUpgradeHeader)
AssetCmds.RuntimeSnapshotUpdated:Connect(refresh)
AssetCmds.RuntimeOwnerUpdated:Connect(function(p1) --[[ Line: 330 | Upvalues: LocalPlayer (copy), refresh (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	refresh()
end)
AssetCmds.RuntimeOwnerCleared:Connect(function(p1) --[[ Line: 335 | Upvalues: LocalPlayer (copy), refresh (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	refresh()
end)
Network.Fired(Constants.NETWORK_MAP.Plots.ON_BASE_UPGRADED):Connect(function() --[[ Line: 340 | Upvalues: Message (copy), v2 (copy), refresh (copy) ]]
	Message.Bottom({
		Message = "Successfully upgraded your base!",
		Time = 0.7,
		PreventDuplicateText = true,
		Color = v2
	})
	refresh()
end)