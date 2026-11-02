-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Save = require(ReplicatedStorage.Library.Client.Save)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(ReplicatedStorage.Library.Types.Currency)

local ItemUtil = require(ReplicatedStorage.Library.Util.ItemUtil)
local v1 = Log.new()
local v2 = GUI.BuyMultiple()
local Contents = v2.Frame.Contents
local Close = v2.Frame.Close
local Buy1 = Contents.Buy1
local BuyHalf = Contents.BuyHalf
local BuyMax = Contents.BuyMax
local Price1 = Contents.Price1
local PriceHalf = Contents.PriceHalf
local PriceMax = Contents.PriceMax
local Desc = Contents.Desc
local Icon = Contents.Icon
local GreenGradient = ReplicatedStorage.Assets.UI.Gradients.GreenGradient
local GreyGradient = ReplicatedStorage.Assets.UI.Gradients.GreyGradient
local v3 = false
local v4 = false
local t = {}

local function swapGradient(p1, p2) --[[ swapGradient | Line: 47 ]]
	if p1:FindFirstChild(p2.Name) then
		return
	end

	local UIGradient = p1:FindFirstChildOfClass("UIGradient")

	if UIGradient then
		UIGradient:Destroy()
	end

	p2:Clone().Parent = p1
end

local function getOwnedCurrencyAmount(p1) --[[ getOwnedCurrencyAmount | Line: 57 | Upvalues: ItemUtil (copy), Save (copy) ]]
	return ItemUtil:GetOwnedAmount(Save.Get() or {}, {
		Type = "Currency",
		Currency = p1
	})
end

function t.NewGeneric(p1, p2, p3, p4, p5) --[[ NewGeneric | Line: 68 | Upvalues: v4 (ref), TabController (copy), Buy1 (copy), BuyHalf (copy), BuyMax (copy), Price1 (copy), PriceHalf (copy), PriceMax (copy), Desc (copy), getOwnedCurrencyAmount (copy), GreenGradient (copy), GreyGradient (copy), Icon (copy), v2 (copy), Audio (copy), Trove (copy), GUI (copy), v3 (ref), Close (copy) ]]
	if v4 or TabController.IsOpen("BuyMultiple") then
		return
	end

	v4 = true

	if #p3 <= 1 then
		Buy1.Visible = true
		BuyHalf.Visible = false
		BuyMax.Visible = false
		Price1.Visible = true
		PriceHalf.Visible = false
		PriceMax.Visible = false
		Buy1.Size = UDim2.new(0.32, 0, 0.15, 25)
		Buy1.Position = UDim2.fromScale(0.5, 0.88)
		Price1.Position = UDim2.new(0.5, 0, 0.8, -10)
	elseif #p3 == 2 then
		Buy1.Visible = true
		BuyHalf.Visible = true
		BuyMax.Visible = false
		Price1.Visible = true
		PriceHalf.Visible = true
		PriceMax.Visible = false
		Buy1.Size = UDim2.new(0.48, 0, 0.15, 25)
		Buy1.Position = UDim2.fromScale(0.25, 0.88)
		Price1.Position = UDim2.new(0.25, 0, 0.8, -10)
		BuyHalf.Size = UDim2.new(0.48, 0, 0.15, 25)
		BuyHalf.Position = UDim2.fromScale(0.75, 0.88)
		PriceHalf.Position = UDim2.new(0.75, 0, 0.8, -10)
	else
		Buy1.Visible = true
		BuyHalf.Visible = true
		BuyMax.Visible = true
		Price1.Visible = true
		PriceHalf.Visible = true
		PriceMax.Visible = true
		Buy1.Size = UDim2.new(0.32, 0, 0.15, 25)
		Buy1.Position = UDim2.fromScale(0.175, 0.88)
		Price1.Position = UDim2.new(0.175, 0, 0.8, -10)
		BuyHalf.Size = UDim2.new(0.32, 0, 0.15, 25)
		BuyHalf.Position = UDim2.fromScale(0.5, 0.88)
		PriceHalf.Position = UDim2.new(0.5, 0, 0.8, -10)
		BuyMax.Size = UDim2.new(0.32, 0, 0.15, 25)
		BuyMax.Position = UDim2.fromScale(0.825, 0.88)
		PriceMax.Position = UDim2.new(0.825, 0, 0.8, -10)
	end

	Desc.Text = p1
	Buy1.TextLabel.Text = tostring(p3[1])
	BuyHalf.TextLabel.Text = tostring(p3[2])
	BuyMax.TextLabel.Text = tostring(p3[3])

	if p4 and p5 then
		local v42 = getOwnedCurrencyAmount(p4)
		local v5 = Buy1
		local v6 = (p5[1] or 0) <= v42 and GreenGradient or GreyGradient

		if not v5:FindFirstChild(v6.Name) then
			local UIGradient = v5:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v6:Clone().Parent = v5
		end

		local v7 = BuyHalf
		local v8 = (p5[2] or 0) <= v42 and GreenGradient or GreyGradient

		if not v7:FindFirstChild(v8.Name) then
			local UIGradient = v7:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v8:Clone().Parent = v7
		end

		local v9 = BuyMax
		local v10 = (p5[3] or 0) <= v42 and GreenGradient or GreyGradient

		if not v9:FindFirstChild(v10.Name) then
			local UIGradient = v9:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v10:Clone().Parent = v9
		end

		Icon.Size = UDim2.fromScale(0.8, 0.3)
	else
		local v11 = Buy1
		local v12 = GreenGradient

		if not v11:FindFirstChild(v12.Name) then
			local UIGradient = v11:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v12:Clone().Parent = v11
		end

		local v13 = BuyHalf
		local v14 = GreenGradient

		if not v13:FindFirstChild(v14.Name) then
			local UIGradient = v13:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v14:Clone().Parent = v13
		end

		local v15 = BuyMax
		local v16 = GreenGradient

		if not v15:FindFirstChild(v16.Name) then
			local UIGradient = v15:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Destroy()
			end

			v16:Clone().Parent = v15
		end

		PriceHalf.Visible = false
		PriceMax.Visible = false
		Price1.Visible = false
		Icon.Size = UDim2.fromScale(0.8, 0.42)
	end

	v2.Frame.Contents.Icon.Image = p2
	Audio.PlayQuestion()

	if not TabController.OpenTab(v2.Name) then
		v4 = false

		return
	end

	local v17 = Trove.new()

	local function connectActivated(p1, p2) --[[ connectActivated | Line: 156 | Upvalues: GUI (ref), v17 (copy) ]]
		local v1 = GUI.ButtonActivated(p1, p2)

		v17:Add(v1.Default)
		v17:Add(v1.Signal)
	end

	local v18 = nil

	v3 = true

	local function onClose() --[[ onClose | Line: 165 | Upvalues: v3 (ref), v18 (ref), TabController (ref) ]]
		if not v3 then
			return
		end

		v18 = nil
		v3 = false
		TabController.CloseTab()
	end

	local v20 = GUI.ButtonActivated(Close, onClose)

	v17:Add(v20.Default)
	v17:Add(v20.Signal)

	local function onBuy1() --[[ onBuy1 | Line: 174 | Upvalues: p4 (copy), p5 (copy), getOwnedCurrencyAmount (ref), v3 (ref), v18 (ref), TabController (ref) ]]
		if p4 and (p5 and getOwnedCurrencyAmount(p4) < (p5[1] or 0)) then
			return
		end

		if not v3 then
			return
		end

		v18 = 1
		v3 = false
		TabController.CloseTab()
	end

	local v222 = GUI.ButtonActivated(Buy1, onBuy1)

	v17:Add(v222.Default)
	v17:Add(v222.Signal)

	local function onBuyHalf() --[[ onBuyHalf | Line: 185 | Upvalues: p4 (copy), p5 (copy), getOwnedCurrencyAmount (ref), v3 (ref), v18 (ref), TabController (ref) ]]
		if p4 and (p5 and getOwnedCurrencyAmount(p4) < (p5[2] or 0)) then
			return
		end

		if not v3 then
			return
		end

		v18 = 2
		v3 = false
		TabController.CloseTab()
	end

	local v24 = GUI.ButtonActivated(BuyHalf, onBuyHalf)

	v17:Add(v24.Default)
	v17:Add(v24.Signal)

	local function onBuyMax() --[[ onBuyMax | Line: 196 | Upvalues: p4 (copy), p5 (copy), getOwnedCurrencyAmount (ref), v3 (ref), v18 (ref), TabController (ref) ]]
		if p4 and (p5 and getOwnedCurrencyAmount(p4) < (p5[3] or 0)) then
			return
		end

		if not v3 then
			return
		end

		v18 = 3
		v3 = false
		TabController.CloseTab()
	end

	local v26 = GUI.ButtonActivated(BuyMax, onBuyMax)

	v17:Add(v26.Default)
	v17:Add(v26.Signal)

	while v3 do
		task.wait()
	end

	v17:Destroy()

	return v18
end
function t.New(p1, p2, p3, p4, p5) --[[ New | Line: 219 | Upvalues: t (copy) ]]
	local list = {}

	if p4 > 0 and not table.find(list, 1) then
		table.insert(list, 1)
	end

	local v1 = math.ceil(p4 / 2)

	if v1 > 0 and not table.find(list, v1) then
		table.insert(list, v1)
	end

	if p4 > 0 and not table.find(list, p4) then
		table.insert(list, p4)
	end

	local t2 = {}
	local t3 = {}

	for i, v in ipairs(list) do
		if #list == 1 and v == 1 then
			table.insert(t2, "Buy")
		else
			table.insert(t2, (("Buy %d"):format(v)))
		end

		table.insert(t3, v * p5)
	end

	local v3 = t.NewGeneric(p1, p2, t2, p3, t3)

	if v3 then
		return list[v3]
	end

	return nil
end
TabController.AddCloseListener(function(p1) --[[ Line: 269 | Upvalues: v3 (ref), v4 (ref) ]]
	if p1 ~= "BuyMultiple" then
		return
	end

	v3 = false
	v4 = false
end)
ButtonFX(Buy1)
ButtonFX(BuyHalf)
ButtonFX(BuyMax)
ButtonFX(Close)
v1:AtInfo():Log("Buy multiple UI initialized")

return t