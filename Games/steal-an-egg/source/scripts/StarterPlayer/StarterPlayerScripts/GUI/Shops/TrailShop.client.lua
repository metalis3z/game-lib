-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local MonetizationGamepassUtil = require(ReplicatedStorage.Library.Util.MonetizationGamepassUtil)
local Products = require(ReplicatedStorage.Directory.Products)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trails = require(ReplicatedStorage.Directory.Trails)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)
local Trails2 = Constants.NETWORK_MAP.Trails
local v1 = Color3.fromRGB(9, 255, 0)
local ScrollingFrame = GUI.TrailShop().Main.ShopContent.List.ScrollingFrame
local Template = ScrollingFrame.Template
local t = {}
local t2 = {}

local function refreshEntry(p1, p2) --[[ refreshEntry | Line: 55 | Upvalues: Save (copy), Simple (copy), Trails (copy), Products (copy) ]]
	local v1 = Save.Get()

	assert(if v1 == nil then false else true, "Expected local save data")

	local Label = p1.Buttons.CashBuy.Label

	if v1.TrailInventory[p2] then
		Label.Text = if v1.EquippedTrail == p2 then "Unequip" else "Equip"
	else
		Label.Text = ("$%*"):format((Simple.FormatCompact(Trails.Directory[p2].Price, ".#")))
	end

	local ProductId = Trails.Directory[p2].ProductId

	p1.Buttons.RobuxBuy.Visible = if ProductId == nil or Products.DataByProductId[ProductId] == nil then false else not v1.TrailInventory[p2]
end

local function showFailure(p1) --[[ showFailure | Line: 72 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Time = 3,
		Message = p1,
		Color = Color3.fromRGB(255, 64, 64)
	})
end

local function bindShopEntry(p1, p2) --[[ bindShopEntry | Line: 80 | Upvalues: Trails (copy), Template (copy), ScrollingFrame (copy), GradientSwap (copy), v1 (copy), TreadmillUtil (copy), t (copy), ButtonFX (copy), Save (copy), Network (copy), Trails2 (copy), Message (copy), refreshEntry (copy), Products (copy), PromptPurchase (copy), Constants (copy), t2 (copy), MonetizationGamepassUtil (copy), Simple (copy) ]]
	local v12 = Trails.Directory[p1]
	local v2 = Template:Clone()

	v2.Name = p1
	v2.LayoutOrder = p2
	v2.Visible = true
	v2.Parent = ScrollingFrame
	v2.Title.Text = v12.DisplayName
	v2.Rarity.Text = v12.Rarity.DisplayName
	v12.Rarity.Gradient:Clone().Parent = v2.Rarity
	GradientSwap(v2.Background, v12.Rarity.Gradient)
	v2.Icon.Image = v12.Icon
	v2.Data.Boosts.RichText = true
	v2.Data.Boosts.Text = ("<font color=\"#%*\">%*</font> Speed"):format(v1:ToHex(), (TreadmillUtil.FormatSpeedMultiplierValue(v12.SpeedMultiplier)))

	local RobuxBuy = v2.Buttons.RobuxBuy

	t[p1] = {
		RobuxPrice = nil,
		Frame = v2
	}
	ButtonFX(v2.Buttons.CashBuy, 1.05, function() --[[ Line: 102 | Upvalues: Save (ref), p1 (copy), Network (ref), Trails2 (ref), Message (ref), refreshEntry (ref), v2 (copy) ]]
		local v1 = Save.Get()

		assert(v1 ~= nil, "Expected local save data")

		local v3, v4

		if v1.TrailInventory[p1] then
			if v1.EquippedTrail == p1 then
				local v5, v6 = Network.Invoke(Trails2.REQUEST_UNEQUIP)

				v3 = v5
				v4 = v6
			else
				local v7, v8 = Network.Invoke(Trails2.REQUEST_SELECT, p1)

				v3 = v7
				v4 = v8
			end
		else
			local v9, v10 = Network.Invoke(Trails2.REQUEST_PURCHASE, p1)

			v3 = v9
			v4 = v10
		end

		if v3 then
			refreshEntry(v2, p1)

			return
		end

		Message.Bottom({
			Time = 3,
			Message = v4 or "Trail request failed",
			Color = Color3.fromRGB(255, 64, 64)
		})
		refreshEntry(v2, p1)
	end)
	ButtonFX(RobuxBuy, 1.05, function() --[[ Line: 121 | Upvalues: v12 (copy), Products (ref), Message (ref), PromptPurchase (ref) ]]
		local ProductId = v12.ProductId

		if ProductId == nil or Products.DataByProductId[ProductId] == nil then
			Message.Bottom({
				Message = "This trail Robux product is not configured yet",
				Time = 3,
				Color = Color3.fromRGB(255, 64, 64)
			})
		else
			PromptPurchase.Prompt(ProductId, true)
		end
	end)

	if v12.ProductId ~= nil and Products.DataByProductId[v12.ProductId] ~= nil then
		RobuxBuy.Label.Text = Constants.ROBUX_ICON_STR

		if not t2[v12.ProductId] then
			t2[v12.ProductId] = true
			task.spawn(function() --[[ Line: 133 | Upvalues: MonetizationGamepassUtil (ref), v12 (copy), t (ref), p1 (copy), RobuxBuy (copy), Constants (ref), Simple (ref) ]]
				local v1 = MonetizationGamepassUtil.GetProductPriceInRobux(v12.ProductId)
				local v2 = t[p1]

				if v2 == nil or not (v1 > 0) then
					return
				end

				v2.RobuxPrice = v1
				RobuxBuy.Label.Text = ("%* %*"):format(Constants.ROBUX_ICON_STR, (Simple.FormatCompact(v1, ".#")))
			end)
		end
	end

	refreshEntry(v2, p1)
end

Template.Visible = false
Template.Parent = script

if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

local list = {}

for k, v in pairs(Trails.Directory) do
	if v.DisplayInShop then
		list[#list + 1] = k
	end
end

table.sort(list, function(p1, p2) --[[ Line: 162 | Upvalues: Trails (copy) ]]
	return Trails.Directory[p1].Price < Trails.Directory[p2].Price
end)

for i, v in ipairs(list) do
	bindShopEntry(v, i)
end

Save.ConnectForDataChanged({ "TrailInventory", "EquippedTrail" }, function() --[[ Line: 169 | Upvalues: list (copy), ScrollingFrame (copy), refreshEntry (copy) ]]
	for i, v in ipairs(list) do
		local v1 = ScrollingFrame:FindFirstChild(v)
		local v2 = if v1 == nil then false else v1:IsA("Frame")

		assert(v2, (("Missing trail shop entry \"%*\""):format(v)))
		refreshEntry(v1, v)
	end
end)

return {}