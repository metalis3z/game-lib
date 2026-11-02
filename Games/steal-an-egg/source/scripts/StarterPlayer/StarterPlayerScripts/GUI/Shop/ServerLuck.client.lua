-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Network = require(ReplicatedStorage.Library.Client.Network)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Products = require(ReplicatedStorage.Directory.Products)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local ServerLuck = require(ReplicatedStorage.Library.Types.ServerLuck)
local ServerLuck2 = require(ReplicatedStorage.Library.Globals.Constants).NETWORK_MAP.ServerLuck
local FormatDuration = require(ReplicatedStorage.Library.Functions.FormatDuration)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)

if Constants.IS_STUDIO then
	assert(Products.Directory.ServerLuck_X2, "ServerLuck_X2 product not found in Products directory")
	assert(Products.Directory.ServerLuck_X4, "ServerLuck_X4 product not found in Products directory")
	assert(Products.Directory.ServerLuck_X8, "ServerLuck_X8 product not found in Products directory")
end

local v1 = GUI.ServerLuck()
local ExpiresIn = v1:WaitForChild("ExpiresIn")
local BuyButton = v1:WaitForChild("BuyButton")
local Price = BuyButton:WaitForChild("Price")
local Available = v1:WaitForChild("Available")
local v2 = Available:WaitForChild("1")
local v3 = Available:WaitForChild("2")
local ButtonsWithExtension = v1:WaitForChild("ButtonsWithExtension")
local List = ButtonsWithExtension:WaitForChild("List")
local v4 = List:WaitForChild("15Min")
local v5 = List:WaitForChild("30Min")
local t = {
	Multiplier = 1
}

local function getNextMultiplier(p1) --[[ getNextMultiplier | Line: 43 ]]
	if p1 < 2 then
		return 2
	end

	if p1 < 4 then
		return 4
	end

	return 8
end

local function updateLuckTimer(p1) --[[ updateLuckTimer | Line: 53 | Upvalues: FormatDuration (copy), ExpiresIn (copy) ]]
	ExpiresIn.Text = if p1 > 0 then ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((FormatDuration(p1))) else "<font color=\"rgb(255, 0, 0)\">15 mins</font>"
end

local function updateUI() --[[ updateUI | Line: 65 | Upvalues: t (ref), FormatDuration (copy), ExpiresIn (copy), v1 (copy), ButtonsWithExtension (copy), v2 (copy), v3 (copy), Products (copy), GetPrice (copy), Price (copy), v4 (copy), v5 (copy) ]]
	local v12 = if t.ExpiresAt then math.max(0, t.ExpiresAt - workspace:GetServerTimeNow()) else 0

	ExpiresIn.Text = if v12 > 0 then ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((FormatDuration(v12))) else "<font color=\"rgb(255, 0, 0)\">15 mins</font>"
	v1.Available.Visible = t.Multiplier ~= 8
	v1.MaxedOut.Visible = t.Multiplier == 8
	ButtonsWithExtension.Visible = t.Multiplier > 1

	if t.Multiplier < 8 then
		local Multiplier = t.Multiplier
		local v8 = if Multiplier < 2 then 2 elseif Multiplier < 4 then 4 else 8

		v2.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\">%*<font color=\"rgb(56, 232, 57)\"></font></stroke>x"):format(t.Multiplier)
		v3.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(56, 232, 57)\">%*</font></stroke>x"):format(v8)

		local v9 = Products.Directory[("ServerLuck_X%*"):format(v8)]

		if v9 then
			Price.Text = ("\238\128\130%*"):format((GetPrice(v9.ProductId, true)))
		end

		if not ButtonsWithExtension.Visible then
			return
		end

		local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15

		if ServerLuck_Extend15 then
			v4.Text = ("\238\128\130%*"):format((GetPrice(ServerLuck_Extend15.ProductId, true)))
		end

		local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30

		if ServerLuck_Extend30 then
			v5.Text = ("\238\128\130%*"):format((GetPrice(ServerLuck_Extend30.ProductId, true)))
		end
	else
		Price.Text = "Maxed"
	end
end

ButtonFX(BuyButton, nil, function() --[[ Line: 105 | Upvalues: t (ref), Products (copy), PromptPurchase (copy) ]]
	if not (t.Multiplier < 8) then
		return
	end

	local Multiplier = t.Multiplier
	local v2 = Products.Directory[("ServerLuck_X%*"):format(if Multiplier < 2 then 2 elseif Multiplier < 4 then 4 else 8)]

	if not v2 then
		return
	end

	PromptPurchase.Prompt(v2.ProductId, true)
end)
ButtonFX(v4, nil, function() --[[ Line: 115 | Upvalues: t (ref), Products (copy), PromptPurchase (copy) ]]
	if not (t.Multiplier > 1) then
		return
	end

	local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15

	if not ServerLuck_Extend15 then
		return
	end

	PromptPurchase.Prompt(ServerLuck_Extend15.ProductId, true)
end)
ButtonFX(v5, nil, function() --[[ Line: 124 | Upvalues: t (ref), Products (copy), PromptPurchase (copy) ]]
	if not (t.Multiplier > 1) then
		return
	end

	local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30

	if not ServerLuck_Extend30 then
		return
	end

	PromptPurchase.Prompt(ServerLuck_Extend30.ProductId, true)
end)
Network.Fired(ServerLuck2.STATE_UPDATED):Connect(function(p1) --[[ Line: 133 | Upvalues: ServerLuck (copy), t (ref), updateUI (copy) ]]
	if not ServerLuck.State(p1) then
		return
	end

	t = p1
	updateUI()
end)

local ok, result = pcall(function() --[[ Line: 140 | Upvalues: Network (copy), ServerLuck2 (copy) ]]
	return Network.Invoke(ServerLuck2.GET_STATE)
end)

if ok and (type(result) == "table" and ServerLuck.State(result)) then
	t = result
	updateUI()
end

RunService.Heartbeat:Connect(function() --[[ Line: 148 | Upvalues: t (ref), updateUI (copy) ]]
	if not t.ExpiresAt then
		return
	end

	updateUI()
end)