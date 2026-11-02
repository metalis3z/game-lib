local v1 = script.Parent.Parent
local PurchaseCurrency = v1:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("PurchaseCurrency")
local MainRewards = v1:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("MainRewards")
local WindowService = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService01"))
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local ExtraRewards = v1:WaitForChild("Container"):WaitForChild("EventFrames"):WaitForChild("ExtraRewards")
local MysteryBox = ExtraRewards:WaitForChild("MysteryBox")
local Contents = MysteryBox:WaitForChild("BoxFrame"):WaitForChild("Contents")
local BuyFrame = MysteryBox:WaitForChild("BuyFrame")
local BoxIcon = MysteryBox:WaitForChild("BoxFrame"):WaitForChild("BoxIcon")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local t = {}
local Sync = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
local ProfileData = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local Button = require(script.Parent.Button)
local Item = script.Item
local v6 = Button.createButton(MysteryBox:WaitForChild("Info"):WaitForChild("Back"))

local function v22() --[[ v22 | Line: 23 | Upvalues: ExtraRewards (copy), PurchaseCurrency (copy) ]]
	ExtraRewards.Visible = false
	PurchaseCurrency.Visible = true
	PurchaseCurrency:SetAttribute("ReturnFrame", "MysteryBox")
end

local function v36(p1) --[[ v36 | Line: 28 | Upvalues: Sync (copy), v4 (ref), v5 (ref), Item (copy), Contents (copy), MysteryBox (copy), t (copy) ]]
	local v2 = Sync.NewShop[p1]

	for k, v in pairs(Sync.MysteryBox[p1].Contents) do
		local v52 = Sync.Weapons[v]
		local v6 = Item:Clone()

		v6.Name = v
		v6.LayoutOrder = k
		v6.Container.ItemName.Text = v52.ItemName
		v6.Container.ItemName.TextColor3 = Sync.Rarity[v52.Rarity]
		v6.Container.Icon.Image = v52.Image
		v6.Parent = Contents

		if not v6.Container.ItemName.TextFits then
			v6.Container.ItemName.TextWrapped = true
			v6.Container.ItemName.TextScaled = true
		end
	end

	MysteryBox.BuyFrame.Currency.Container.Container.TextLabel.Text = v2.Price[v4]
	MysteryBox.BuyFrame.Keys.Container.Container.TextLabel.Text = v2.Price[v5]
	t.Update()
end

local function v43(p1, p2) --[[ v43 | Line: 55 | Upvalues: Sync (copy), ProfileData (copy), WindowService (copy) ]]
	local v1 = Sync.NewShop[p1].Price[p2]

	if not (v1 <= (ProfileData.Materials.Owned[p2] or 0)) then
		return
	end

	ProfileData.Materials.Owned[p2] = ProfileData.Materials.Owned[p2] - v1
	WindowService:GetFrame("CurrentEvent").Visible = false
	_G.Process("Unboxing")

	local v2 = time()
	local v3 = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(p1, "MysteryBox", p2)

	wait(0.75 - (time() - v2))
	_G.Process()

	if not v3 then
		return
	end

	game.ReplicatedStorage.Remotes.Shop.BoxController:Fire({
		{
			MysteryBoxId = p1,
			RewardedItemId = v3
		}
	})
end

function t.Open() --[[ Line: 75 | Upvalues: BoxIcon (copy) ]]
	BoxIcon.ChancesFrame.Visible = false
end
function t.Update() --[[ Line: 78 | Upvalues: Contents (copy), ProfileData (copy), MysteryBox (copy) ]]
	for k, v in pairs(Contents:GetChildren()) do
		if v:IsA("Frame") then
			local v1 = v.Name

			v.Container.Owned.Visible = if ProfileData.Weapons.Owned[v1] == nil then false else ProfileData.Weapons.Owned[v1] > 0
		end
	end

	MysteryBox.Info.Currency.Container.Amount.Text = ProfileData.Materials.Owned.BeachBalls2024_Box or 0
	MysteryBox.Info.Keys.Container.Amount.Text = ProfileData.Materials.Owned.SummerKey2024 or 0
end
function t.Initialize(p1, p2, p3, p4, p5) --[[ Line: 93 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), v36 (copy), Button (copy), BuyFrame (copy), v43 (copy), v6 (copy), ExtraRewards (copy), MainRewards (copy), MysteryBox (copy), BoxIcon (copy), v22 (copy), ProfileData (copy), Remotes (copy), t (copy) ]]
	v2 = p1
	v3 = p2
	v4 = p4
	v5 = p5

	local v1 = p3

	v36(v1)
	Button.createButton(BuyFrame.Currency, function()
		v43(v1, v4)
	end)
	Button.createButton(BuyFrame.Keys, function()
		v43(v1, v5)
	end)
	function v6.clickEnd() --[[ Line: 106 | Upvalues: ExtraRewards (ref), MainRewards (ref) ]]
		ExtraRewards.Visible = false
		MainRewards.Visible = true
	end
	MysteryBox.BoxFrame.BoxIcon.ChancesButton.Button.Activated:Connect(function() --[[ Line: 110 | Upvalues: BoxIcon (ref) ]]
		BoxIcon.ChancesFrame.Visible = not BoxIcon.ChancesFrame.Visible
	end)
	MysteryBox.Info.Plus.Button.Activated:Connect(v22)
	MysteryBox.Info.Currency.Container.Amount.Text = ProfileData.Materials.Owned.BeachBalls2024_Box or 0
	MysteryBox.Info.Keys.Container.Amount.Text = ProfileData.Materials.Owned.SummerKey2024 or 0
	Remotes:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(t.Update)

	return t
end

return t