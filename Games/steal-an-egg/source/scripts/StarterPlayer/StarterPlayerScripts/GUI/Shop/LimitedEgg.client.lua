-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local HoverInfoSession = require(script.HoverInfoSession)
local LimitedEgg = require(ReplicatedStorage.Directory.LimitedEgg)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Products = require(ReplicatedStorage.Directory.Products)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Types.Interface)

local ViewportSession = require(script.ViewportSession)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local v1 = Log.new()
local v2 = Lock()
local v3 = nil
local LocalPlayer = Players.LocalPlayer
local LimitedEgg2 = GUI.Shop().Frame.Main.ScrollingFrame.LimitedEgg

assert(LimitedEgg2:IsA("GuiObject"), "Shop LimitedEgg must be a GuiObject")

local Main = LimitedEgg2.Main

assert(Main:IsA("GuiObject"), "Shop LimitedEgg.Main must be a GuiObject")

local InfoButton = Main.InfoButton

assert(InfoButton:IsA("GuiObject"), "Shop LimitedEgg.Main.InfoButton must be a GuiObject")

local Info = InfoButton.Info

assert(Info:IsA("CanvasGroup"), "Shop LimitedEgg.Main.InfoButton.Info must be a CanvasGroup")

local AssetViewports = Main.AssetViewports
local Buttons = Main.Buttons

assert(Buttons:IsA("GuiObject"), "Shop LimitedEgg.Main.Buttons must be a GuiObject")

local v9 = Buttons["1"]
local Price = v9.Price
local v10 = Buttons["3"]
local Price2 = v10.Price
local v11 = Buttons["10"]
local Price3 = v11.Price
local v12 = Buttons["50"]
local Price4 = v12.Price

assert(v9:IsA("GuiObject"), "LimitedEgg Buttons.1 must be a GuiObject")
assert(Price:IsA("TextLabel"), "LimitedEgg Buttons.1.Price must be a TextLabel")
assert(v10:IsA("GuiObject"), "LimitedEgg Buttons.3 must be a GuiObject")
assert(Price2:IsA("TextLabel"), "LimitedEgg Buttons.3.Price must be a TextLabel")
assert(v11:IsA("GuiObject"), "LimitedEgg Buttons.10 must be a GuiObject")
assert(Price3:IsA("TextLabel"), "LimitedEgg Buttons.10.Price must be a TextLabel")
assert(v12:IsA("GuiObject"), "LimitedEgg Buttons.50 must be a GuiObject")
assert(Price4:IsA("TextLabel"), "LimitedEgg Buttons.50.Price must be a TextLabel")

local v21 = AssetViewports["1"]
local Chance = v21.Chance
local v22 = AssetViewports["2"]
local Chance2 = v22.Chance
local v23 = AssetViewports["3"]
local Chance3 = v23.Chance
local v24 = AssetViewports["4"]
local Chance4 = v24.Chance
local v25 = AssetViewports["5"]
local Chance5 = v25.Chance
local v26 = AssetViewports["6"]
local Chance6 = v26.Chance

assert(v21:IsA("GuiObject"), "LimitedEgg AssetViewports.1 must be a GuiObject")
assert(Chance:IsA("TextLabel"), "LimitedEgg AssetViewports.1.Chance must be a TextLabel")
assert(v22:IsA("GuiObject"), "LimitedEgg AssetViewports.2 must be a GuiObject")
assert(Chance2:IsA("TextLabel"), "LimitedEgg AssetViewports.2.Chance must be a TextLabel")
assert(v23:IsA("GuiObject"), "LimitedEgg AssetViewports.3 must be a GuiObject")
assert(Chance3:IsA("TextLabel"), "LimitedEgg AssetViewports.3.Chance must be a TextLabel")
assert(v24:IsA("GuiObject"), "LimitedEgg AssetViewports.4 must be a GuiObject")
assert(Chance4:IsA("TextLabel"), "LimitedEgg AssetViewports.4.Chance must be a TextLabel")
assert(v25:IsA("GuiObject"), "LimitedEgg AssetViewports.5 must be a GuiObject")
assert(Chance5:IsA("TextLabel"), "LimitedEgg AssetViewports.5.Chance must be a TextLabel")
assert(v26:IsA("GuiObject"), "LimitedEgg AssetViewports.6 must be a GuiObject")
assert(Chance6:IsA("TextLabel"), "LimitedEgg AssetViewports.6.Chance must be a TextLabel")

local t = {
	{
		Frame = v21,
		Chance = Chance
	},
	{
		Frame = v22,
		Chance = Chance2
	},
	{
		Frame = v23,
		Chance = Chance3
	},
	{
		Frame = v24,
		Chance = Chance4
	},
	{
		Frame = v25,
		Chance = Chance5
	},
	{
		Frame = v26,
		Chance = Chance6
	}
}
local t2 = {
	[1] = {
		Button = v9,
		Price = Price
	},
	[3] = {
		Button = v10,
		Price = Price2
	},
	[10] = {
		Button = v11,
		Price = Price3
	},
	[50] = {
		Button = v12,
		Price = Price4
	}
}

local function applyPaidRandomItemPolicy() --[[ applyPaidRandomItemPolicy | Line: 132 | Upvalues: LimitedEgg2 (copy), wcall (copy), PolicyService (copy), LocalPlayer (copy), Asserts (copy) ]]
	LimitedEgg2.Visible = false

	local v1, v2 = wcall(function() --[[ Line: 135 | Upvalues: PolicyService (ref), LocalPlayer (ref) ]]
		return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer).ArePaidRandomItemsRestricted
	end)

	if not v1 then
		return
	end

	wcall(function() --[[ Line: 140 | Upvalues: Asserts (ref), v2 (copy), LimitedEgg2 (ref) ]]
		Asserts.boolean(v2)
		LimitedEgg2.Visible = not v2
	end)
end

local function closeSession() --[[ closeSession | Line: 147 | Upvalues: v3 (ref), v1 (copy) ]]
	local v12 = v3

	if v12 ~= nil then
		v3 = nil
		v12:Destroy()
		v1:AtTrace():Log("Limited egg shop session closed")
	end
end

local function bindOffer(p1, p2) --[[ bindOffer | Line: 158 | Upvalues: ButtonFX (copy), v2 (copy), PromptPurchase (copy), GetPrice (copy), v3 (ref) ]]
	p1:Add(ButtonFX(p2.Button, nil, function() --[[ Line: 159 | Upvalues: v2 (ref), PromptPurchase (ref), p2 (copy) ]]
		v2(function() --[[ Line: 160 | Upvalues: PromptPurchase (ref), p2 (ref) ]]
			PromptPurchase.Prompt(p2.ProductId, true)
		end)
	end))
	p1:Add((task.spawn(function() --[[ Line: 165 | Upvalues: GetPrice (ref), p2 (copy), v3 (ref), p1 (copy) ]]
		local v1, v2 = GetPrice(p2.ProductId, true)

		if v3 ~= p1 then
			return
		end

		if v2 then
			p2.Price.Text = "\238\128\130" .. tostring(v1)
		else
			p2.Price.Text = "Loading..."
		end
	end)))
end

local function openSession() --[[ openSession | Line: 179 | Upvalues: v3 (ref), v1 (copy), Trove (copy), wcall (copy), ViewportSession (copy), Main (copy), t (copy), LimitedEgg (copy), HoverInfoSession (copy), InfoButton (copy), Info (copy), t2 (copy), Products (copy), Asserts (copy), bindOffer (copy) ]]
	local v12 = v3

	if v12 ~= nil then
		v3 = nil
		v12:Destroy()
		v1:AtTrace():Log("Limited egg shop session closed")
	end

	local v2 = Trove.new()

	v3 = v2

	local v32, v4 = wcall(function() --[[ Line: 184 | Upvalues: ViewportSession (ref), v2 (copy), Main (ref), t (ref), LimitedEgg (ref), HoverInfoSession (ref), InfoButton (ref), Info (ref), t2 (ref), Products (ref), Asserts (ref), bindOffer (ref) ]]
		ViewportSession.Start(v2, Main, t, LimitedEgg.Entries)
		HoverInfoSession.Start(v2, InfoButton, Info, t, LimitedEgg.Entries)

		for i, v in ipairs(LimitedEgg.Offers) do
			local v1 = t2[v.Amount]

			assert(v1 ~= nil, (("LimitedEgg Buttons.%* must contain Price and TextButton"):format(v.Amount)))

			local v4 = Products.Directory[v.ProductName]

			Asserts.number(v4.ProductId)
			bindOffer(v2, {
				Button = v1.Button,
				Price = v1.Price,
				ProductId = v4.ProductId
			})
		end
	end)

	if v32 then
		v1:AtTrace():Log("Limited egg shop session opened")

		return
	end

	local v5 = v2

	if v5 ~= nil then
		v3 = nil
		v5:Destroy()
		v1:AtTrace():Log("Limited egg shop session closed")
	end

	error(v4)
end

task.spawn(applyPaidRandomItemPolicy)
TabController.Opened:Connect(function(p1) --[[ Line: 214 | Upvalues: openSession (copy) ]]
	if p1 ~= "Shop" then
		return
	end

	openSession()
end)
TabController.Closed:Connect(function(p1) --[[ Line: 220 | Upvalues: v3 (ref), v1 (copy) ]]
	if p1 ~= "Shop" then
		return
	end

	local v12 = v3

	if v12 == nil then
		return
	end

	v3 = nil
	v12:Destroy()
	v1:AtTrace():Log("Limited egg shop session closed")
end)

if TabController.Get() ~= "Shop" then
	return
end

openSession()