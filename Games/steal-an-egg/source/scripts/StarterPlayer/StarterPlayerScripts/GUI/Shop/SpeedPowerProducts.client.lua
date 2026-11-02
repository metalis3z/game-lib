-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GUI = require(ReplicatedStorage.Library.Client.GUI)

require(ReplicatedStorage.Library.Types.GUI)

local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local Products = require(ReplicatedStorage.Directory.Products)

require(ReplicatedStorage.Directory.Products.Types.Interface)

local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local t = {
	Products.Directory.SpeedPower_150000,
	Products.Directory.SpeedPower_1000000,
	Products.Directory.SpeedPower_10000000,
	Products.Directory.SpeedPower_50000000,
	Products.Directory.SpeedPower_500000000,
	Products.Directory.SpeedPower_1000000000
}
local t2 = { Products.Directory.TemporarySpeedBoost_10Minutes, Products.Directory.TemporarySpeedBoost_30Minutes, Products.Directory.TemporarySpeedBoost_1Hour }
local v1 = GUI.Shop()
local v2 = GUI.TreadmillSpeedShop()
local ScrollingFrame = v1.Frame.Main.ScrollingFrame
local ScrollingFrame2 = v2.Frame.Main.ScrollingFrame

local function updateProductPrice(p1, p2) --[[ updateProductPrice | Line: 70 | Upvalues: GetPrice (copy), Constants (copy) ]]
	if p2 == nil then
		p1.Text = "???"

		return
	end

	local ProductId = p2.ProductId

	if ProductId <= 0 then
		p1.Text = "???"
	else
		task.spawn(function() --[[ Line: 82 | Upvalues: GetPrice (ref), ProductId (copy), p1 (copy), Constants (ref) ]]
			local v1, v2 = GetPrice(ProductId, true)

			p1.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
		end)
	end
end

local function bindSpeedPowerProductFrame(p1, p2, p3) --[[ bindSpeedPowerProductFrame | Line: 88 | Upvalues: GetPrice (copy), Constants (copy), Simple (copy), ButtonFX (copy), PromptPurchase (copy) ]]
	local Price = p1.Buy.Price

	if p2 == nil then
		Price.Text = "???"
	else
		local ProductId = p2.ProductId

		if ProductId <= 0 then
			Price.Text = "???"
		else
			task.spawn(function() --[[ Line: 82 | Upvalues: GetPrice (ref), ProductId (copy), Price (copy), Constants (ref) ]]
				local v1, v2 = GetPrice(ProductId, true)

				Price.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
			end)
		end
	end

	p1.Title.Text = ("<font color=\"#%*\">+%*</font> SPEED"):format(p3:ToHex(), (Simple.FormatCompact(p2.SpeedPowerReward, ".#")))
	ButtonFX(p1.Buy, nil, function() --[[ Line: 98 | Upvalues: PromptPurchase (ref), p2 (copy) ]]
		PromptPurchase.Prompt(p2.ProductId, true)
	end)
end

local function bindTemporarySpeedBoostProductFrame(p1, p2) --[[ bindTemporarySpeedBoostProductFrame | Line: 103 | Upvalues: GetPrice (copy), Constants (copy), TreadmillUtil (copy), ButtonFX (copy), PromptPurchase (copy) ]]
	local Price = p1.Buy.Price

	if p2 == nil then
		Price.Text = "???"
	else
		local ProductId = p2.ProductId

		if ProductId <= 0 then
			Price.Text = "???"
		else
			task.spawn(function() --[[ Line: 82 | Upvalues: GetPrice (ref), ProductId (copy), Price (copy), Constants (ref) ]]
				local v1, v2 = GetPrice(ProductId, true)

				Price.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
			end)
		end
	end

	p1.Title.Text = TreadmillUtil.FormatTemporarySpeedBoostProductDuration(p2.TemporarySpeedBoostDurationSeconds)
	ButtonFX(p1.Buy, nil, function() --[[ Line: 111 | Upvalues: PromptPurchase (ref), p2 (copy) ]]
		PromptPurchase.Prompt(p2.ProductId, true)
	end)
end

if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

for i, v in ipairs({
	{
		ScrollingFrame.SpeedTop["1"],
		ScrollingFrame.SpeedTop["2"],
		ScrollingFrame.SpeedTop["3"],
		ScrollingFrame.SpeedBottom["1"],
		ScrollingFrame.SpeedBottom["2"],
		ScrollingFrame.SpeedBottom["3"]
	},
	{
		ScrollingFrame2.SpeedTop["1"],
		ScrollingFrame2.SpeedTop["2"],
		ScrollingFrame2.SpeedTop["3"],
		ScrollingFrame2.SpeedBottom["1"],
		ScrollingFrame2.SpeedBottom["2"],
		ScrollingFrame2.SpeedBottom["3"]
	}
}) do
	for i2, v4 in ipairs(v) do
		local v3

		v3 = i2 <= 3 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 200, 0)

		local v5, v6 = bindSpeedPowerProductFrame, v4

		v5(v6, t[i2], v3)
	end
end

for i, v in ipairs({ ScrollingFrame.TemporarySpeedBoosts["1"], ScrollingFrame.TemporarySpeedBoosts["2"], ScrollingFrame.TemporarySpeedBoosts["3"] }) do
	bindTemporarySpeedBoostProductFrame(v, t2[i])
end