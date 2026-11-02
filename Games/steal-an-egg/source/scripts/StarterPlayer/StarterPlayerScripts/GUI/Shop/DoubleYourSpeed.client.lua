-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Flash = require(ReplicatedStorage.Library.Client.GUIFX.Flash)
local GUI = require(ReplicatedStorage.Library.Client.GUI)

require(ReplicatedStorage.Library.Types.GUI)

local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local Products = require(ReplicatedStorage.Directory.Products)

require(ReplicatedStorage.Directory.Products.Types.Interface)

local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Library.Client.Save)
local ScreenResolution = require(ReplicatedStorage.Library.Client.ScreenResolution)
local Shake = require(ReplicatedStorage.Library.Client.Shake)
local Shockwave = require(ReplicatedStorage.Library.Client.GUIFX.Shockwave)
local Sparkles = require(ReplicatedStorage.Library.Client.GUIFX.Sparkles)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	Products.Directory.SpeedBoostTier1,
	Products.Directory.SpeedBoostTier2,
	Products.Directory.SpeedBoostTier3,
	Products.Directory.SpeedBoostTier4,
	Products.Directory.SpeedBoostTier5,
	Products.Directory.SpeedBoostTier6,
	Products.Directory.SpeedBoostTier7,
	Products.Directory.SpeedBoostTier8,
	Products.Directory.SpeedBoostTier9,
	Products.Directory.SpeedBoostTier10,
	Products.Directory.SpeedBoostTier11,
	Products.Directory.SpeedBoostTier12
}
local v1 = ("ONLY ?%*"):format(Constants.ROBUX_ICON_STR)
local v2 = GUI.Shop()
local v3 = GUI.TreadmillSpeedShop()
local Pack = v2.Frame.Main.ScrollingFrame.DoubleYourSpeed.Pack
local Pack2 = v3.Frame.Main.ScrollingFrame.DoubleYourSpeed.Pack
local Button = GUI.SideButtonTools().DoubleYourSpeed.Button
local Multiplier = Button.Multiplier
local Text = Button.PriceTag.Text
local list = {
	{
		HasRendered = false,
		LastRenderedSpeedBoostTierIndex = 0,
		Buy = Pack.Buy,
		End = Pack.Multiplier.End,
		Max = Pack.Max,
		Multiplier = Pack.Multiplier,
		Root = v2,
		Start = Pack.Multiplier.Start
	},
	{
		HasRendered = false,
		AlwaysAnimate = true,
		LastRenderedSpeedBoostTierIndex = 0,
		Buy = Pack2.Buy,
		End = Pack2.Multiplier.End,
		Max = Pack2.Max,
		Multiplier = Pack2.Multiplier,
		Root = v3,
		Start = Pack2.Multiplier.Start
	}
}
local count = 0

local function resolveOwnedSpeedBoostTierIndex() --[[ resolveOwnedSpeedBoostTierIndex | Line: 107 | Upvalues: TreadmillUtil (copy), Save (copy) ]]
	return TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
end

local function resolveNextSpeedBoostProduct() --[[ resolveNextSpeedBoostProduct | Line: 111 | Upvalues: t (copy), TreadmillUtil (copy), Save (copy) ]]
	return t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
end

local function resolveSpeedBoostMultiplierForTierIndex(p1) --[[ resolveSpeedBoostMultiplierForTierIndex | Line: 115 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		return 1
	end

	return v1.SpeedBoostMultiplier
end

local function resolveCurrentAndNextSpeedBoostMultipliers() --[[ resolveCurrentAndNextSpeedBoostMultipliers | Line: 120 | Upvalues: TreadmillUtil (copy), Save (copy), t (copy) ]]
	local v1 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
	local v2 = t[v1]
	local v3 = if v2 == nil then 1 else v2.SpeedBoostMultiplier
	local v4 = t[v1 + 1]

	return v3, if v4 == nil then v3 else v4.SpeedBoostMultiplier, v4 == nil
end

local function formatSpeedBoostMultiplier(p1) --[[ formatSpeedBoostMultiplier | Line: 129 | Upvalues: Asserts (copy), Simple (copy) ]]
	Asserts.number(p1)

	return ("x%*"):format((Simple.FormatCompact(p1, ".#")))
end

local function updateProductPrice(p1, p2) --[[ updateProductPrice | Line: 134 | Upvalues: GetPrice (copy), Constants (copy) ]]
	p1.Visible = true

	if p2 == nil then
		p1.Text = "MAX"
		p1.Visible = false

		return
	end

	local ProductId = p2.ProductId

	if ProductId <= 0 then
		p1.Text = "???"
		p1.Visible = false
	else
		task.spawn(function() --[[ Line: 149 | Upvalues: GetPrice (ref), ProductId (copy), p1 (copy), Constants (ref) ]]
			local v1, v2 = GetPrice(ProductId, true)

			p1.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
		end)
	end
end

local function updateSideButtonPrice(p1) --[[ updateSideButtonPrice | Line: 155 | Upvalues: count (ref), Text (copy), v1 (copy), GetPrice (copy), Constants (copy) ]]
	count = count + 1

	local v12 = count

	if p1 == nil then
		Text.Text = "MAX"
	else
		Text.Text = v1

		local ProductId = p1.ProductId

		task.spawn(function() --[[ Line: 165 | Upvalues: GetPrice (ref), ProductId (copy), v12 (copy), count (ref), Text (ref), Constants (ref), v1 (ref) ]]
			local v13, v2 = GetPrice(ProductId, true)

			if v12 ~= count then
				return
			end

			Text.Text = if v2 then ("ONLY %*%*"):format(v13, Constants.ROBUX_ICON_STR) else v1
		end)
	end
end

local function updateDoubleYourSpeedTool() --[[ updateDoubleYourSpeedTool | Line: 177 | Upvalues: t (copy), TreadmillUtil (copy), Save (copy), Button (copy), Text (copy), Multiplier (copy), count (ref), v1 (copy), GetPrice (copy), Constants (copy) ]]
	local v12 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
	local v2 = v12 ~= nil

	Button.Interactable = v2
	Text.Visible = v2

	if v12 == nil then
		Multiplier.Text = "MAX"
		count = count + 1
		Text.Text = "MAX"

		return
	end

	Multiplier.Text = TreadmillUtil.FormatSpeedMultiplier(v12.SpeedBoostMultiplier)
	count = count + 1

	local v3 = count

	if v12 == nil then
		Text.Text = "MAX"
	else
		Text.Text = v1

		local ProductId = v12.ProductId

		task.spawn(function() --[[ Line: 165 | Upvalues: GetPrice (ref), ProductId (copy), v3 (copy), count (ref), Text (ref), Constants (ref), v1 (ref) ]]
			local v13, v2 = GetPrice(ProductId, true)

			if v3 ~= count then
				return
			end

			Text.Text = if v2 then ("ONLY %*%*"):format(v13, Constants.ROBUX_ICON_STR) else v1
		end)
	end
end

local function updateDoubleYourSpeedText(p1, p2, p3) --[[ updateDoubleYourSpeedText | Line: 192 | Upvalues: Asserts (copy), Simple (copy) ]]
	Asserts.number(p2)
	p1.Start.Text = ("x%*"):format((Simple.FormatCompact(p2, ".#")))
	Asserts.number(p3)
	p1.End.Text = ("x%*"):format((Simple.FormatCompact(p3, ".#")))
	Asserts.number(p2)
	p1.Max.Text = ("%* MAX"):format((("x%*"):format((Simple.FormatCompact(p2, ".#")))))
end

local function updateDoubleYourSpeedVisibility(p1, p2) --[[ updateDoubleYourSpeedVisibility | Line: 198 ]]
	p1.Multiplier.Visible = not p2
	p1.Max.Visible = p2
	p1.Buy.Visible = not p2
	p1.Buy.Interactable = not p2
end

local function playDoubleYourSpeedAnimation(p1, p2, p3) --[[ playDoubleYourSpeedAnimation | Line: 205 | Upvalues: ScreenResolution (copy), Audio (copy), Tween (copy), Asserts (copy), Simple (copy), Shake (copy), Flash (copy), Shockwave (copy), Sparkles (copy) ]]
	p1.Start.TextWrapped = false
	p1.End.TextWrapped = false
	p1.Start.TextScaled = false
	p1.End.TextScaled = false
	p1.Start.TextSize = 130 * ScreenResolution.GetScale()
	p1.End.TextSize = 130 * ScreenResolution.GetScale()

	local v1 = p1.End:GetAttribute("OriginalScale")
	local v2 = p1.End:GetAttribute("OriginalThickness")

	assert(if typeof(v1) == "number" then true else false, "DoubleYourSpeed.Pack.Multiplier.End.OriginalScale must be a number")
	assert(if typeof(v2) == "number" then true else false, "DoubleYourSpeed.Pack.Multiplier.End.OriginalThickness must be a number")
	task.delay(0.6, function() --[[ Line: 231 | Upvalues: Audio (ref) ]]
		Audio.Play("rbxassetid://91650233387983", script, 1, 1.5)
	end)
	Tween(p1.End.UIStroke, {
		Thickness = v2 * 0.15
	}, { 0.6, "Back", "In" })
	Tween(p1.End.UIScale, {
		Scale = v1 * 4
	}, { 0.6, "Back", "In" }).Completed:Wait()
	Tween(p1.End.UIStroke, {
		Thickness = v2 * 0.1
	}, { 0.3, "Sine", "Out" })
	Tween(p1.End.UIScale, {
		Scale = v1 * 6
	}, { 0.3, "Sine", "Out" }).Completed:Wait()
	task.spawn(function() --[[ Line: 265 | Upvalues: p3 (copy), p2 (copy), p1 (copy), Asserts (ref), Simple (ref) ]]
		local v1 = p3 - p2
		local v3 = math.clamp(math.abs(v1), 1, 15)
		local v4 = math.round(v1 / v3)

		for i = 1, v3 do
			local v5 = p2 + v4 * i

			Asserts.number(v5)
			p1.End.Text = ("x%*"):format((Simple.FormatCompact(v5, ".#")))
			task.wait(0.025)
		end

		local v6 = p3

		Asserts.number(v6)
		p1.End.Text = ("x%*"):format((Simple.FormatCompact(v6, ".#")))
	end)
	Asserts.number(p2)
	p1.Start.Text = ("x%*"):format((Simple.FormatCompact(p2, ".#")))
	task.delay(0.075, function() --[[ Line: 280 | Upvalues: Shake (ref), Flash (ref), Shockwave (ref), p1 (copy), Sparkles (ref) ]]
		Shake.Create(1, 6, 0.25, false)
		Flash(0, 0.25, Color3.new(255/255, 255/255, 255/255), 0.25)
		Shockwave(p1.End, 1.5, 0.7, 6)
		task.delay(10, (Sparkles(p1.End)))
	end)
	Tween(p1.End.UIStroke, {
		Thickness = v2
	}, { 0.075, "Quad", "In" })
	Tween(p1.End.UIScale, {
		Scale = v1
	}, { 0.075, "Quad", "In" }).Completed:Wait()
	p1.End.UIScale.Scale = v1
	p1.End.UIStroke.Thickness = v2
end

local function v4(p1, p2) --[[ updateDoubleYourSpeedPack | Line: 307 | Upvalues: TreadmillUtil (copy), Save (copy), t (copy), GetPrice (copy), Constants (copy), v4 (copy), playDoubleYourSpeedAnimation (copy), Asserts (copy), Simple (copy) ]]
	local v1 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
	local v2 = t[v1]
	local v3 = if v2 == nil then 1 else v2.SpeedBoostMultiplier
	local v42 = t[v1 + 1]
	local v6 = v3
	local v7 = if v42 == nil then v3 else v42.SpeedBoostMultiplier
	local v8 = if v42 == nil then true else false

	p1.Multiplier.Visible = not v8
	p1.Max.Visible = v8
	p1.Buy.Visible = not v8
	p1.Buy.Interactable = not v8

	local Price = p1.Buy.Price
	local v9 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]

	Price.Visible = true

	if v9 == nil then
		Price.Text = "MAX"
		Price.Visible = false
	else
		local ProductId = v9.ProductId

		if ProductId <= 0 then
			Price.Text = "???"
			Price.Visible = false
		else
			task.spawn(function() --[[ Line: 149 | Upvalues: GetPrice (ref), ProductId (copy), Price (copy), Constants (ref) ]]
				local v1, v2 = GetPrice(ProductId, true)

				Price.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
			end)
		end
	end

	if p2 and (p1.HasRendered and not v8) then
		local v10 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())

		task.delay(1.2, function() --[[ Line: 314 | Upvalues: p1 (copy), TreadmillUtil (ref), Save (ref), v10 (copy), v4 (ref), playDoubleYourSpeedAnimation (ref), v6 (copy), v7 (copy) ]]
			if (p1.AlwaysAnimate or p1.Root.Enabled) and TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) == v10 then
				playDoubleYourSpeedAnimation(p1, v6, v7)
			else
				v4(p1, false)
			end
		end)
	else
		Asserts.number(v6)
		p1.Start.Text = ("x%*"):format((Simple.FormatCompact(v6, ".#")))
		Asserts.number(v7)
		p1.End.Text = ("x%*"):format((Simple.FormatCompact(v7, ".#")))
		Asserts.number(v6)
		p1.Max.Text = ("%* MAX"):format((("x%*"):format((Simple.FormatCompact(v6, ".#")))))
	end

	p1.LastRenderedSpeedBoostTierIndex = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
	p1.HasRendered = true
end

local function bindDoubleYourSpeedButton(p1) --[[ bindDoubleYourSpeedButton | Line: 332 | Upvalues: ButtonFX (copy), t (copy), TreadmillUtil (copy), Save (copy), PromptPurchase (copy) ]]
	ButtonFX(p1.Buy, nil, function() --[[ Line: 333 | Upvalues: t (ref), TreadmillUtil (ref), Save (ref), PromptPurchase (ref) ]]
		local v1 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]

		if v1 ~= nil then
			PromptPurchase.Prompt(v1.ProductId, true)
		end
	end)
end

local function updateSpeedBoostProducts() --[[ updateSpeedBoostProducts | Line: 343 | Upvalues: TreadmillUtil (copy), Save (copy), list (copy), v4 (copy), t (copy), Button (copy), Text (copy), Multiplier (copy), count (ref), v1 (copy), GetPrice (copy), Constants (copy) ]]
	local v12 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())

	for i, v in ipairs(list) do
		v4(v, v.Root.Enabled and (if v12 == v.LastRenderedSpeedBoostTierIndex then false else true))
	end

	local v42 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
	local v5 = v42 ~= nil

	Button.Interactable = v5
	Text.Visible = v5

	if v42 == nil then
		Multiplier.Text = "MAX"
		count = count + 1
		Text.Text = "MAX"

		return
	end

	Multiplier.Text = TreadmillUtil.FormatSpeedMultiplier(v42.SpeedBoostMultiplier)
	count = count + 1

	local v6 = count

	if v42 == nil then
		Text.Text = "MAX"
	else
		Text.Text = v1

		local ProductId = v42.ProductId

		task.spawn(function() --[[ Line: 165 | Upvalues: GetPrice (ref), ProductId (copy), v6 (copy), count (ref), Text (ref), Constants (ref), v1 (ref) ]]
			local v13, v2 = GetPrice(ProductId, true)

			if v6 ~= count then
				return
			end

			Text.Text = if v2 then ("ONLY %*%*"):format(v13, Constants.ROBUX_ICON_STR) else v1
		end)
	end
end

if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

for i, v in ipairs(list) do
	ButtonFX(v.Buy, nil, function() --[[ Line: 333 | Upvalues: t (copy), TreadmillUtil (copy), Save (copy), PromptPurchase (copy) ]]
		local v1 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]

		if v1 ~= nil then
			PromptPurchase.Prompt(v1.ProductId, true)
		end
	end)

	local v5 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
	local v6 = t[v5]
	local v7 = if v6 == nil then 1 else v6.SpeedBoostMultiplier
	local v8 = t[v5 + 1]
	local v9 = if v8 == nil then v7 else v8.SpeedBoostMultiplier
	local v10 = if v8 == nil then true else false

	v.Multiplier.Visible = not v10
	v.Max.Visible = v10
	v.Buy.Visible = not v10
	v.Buy.Interactable = not v10

	local Price = v.Buy.Price
	local v11 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]

	Price.Visible = true

	if v11 == nil then
		Price.Text = "MAX"
		Price.Visible = false
	else
		local ProductId = v11.ProductId

		if ProductId <= 0 then
			Price.Text = "???"
			Price.Visible = false
		else
			task.spawn(function() --[[ Line: 149 | Upvalues: GetPrice (copy), ProductId (copy), Price (copy), Constants (copy) ]]
				local v1, v2 = GetPrice(ProductId, true)

				Price.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v2 then tostring(v1) else "???")
			end)
		end
	end

	local v12, v13 = v7, v9

	Asserts.number(v12)
	v.Start.Text = ("x%*"):format((Simple.FormatCompact(v12, ".#")))
	Asserts.number(v13)
	v.End.Text = ("x%*"):format((Simple.FormatCompact(v13, ".#")))
	Asserts.number(v12)
	v.Max.Text = ("%* MAX"):format((("x%*"):format((Simple.FormatCompact(v12, ".#")))))
	v.LastRenderedSpeedBoostTierIndex = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
	v.HasRendered = true
end

ButtonFX(Button, nil, function() --[[ Line: 364 | Upvalues: t (copy), TreadmillUtil (copy), Save (copy), PromptPurchase (copy) ]]
	local v1 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]

	if v1 ~= nil then
		PromptPurchase.Prompt(v1.ProductId, true)
	end
end)

local v14 = t[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
local v15 = if v14 == nil then false else true

Button.Interactable = v15
Text.Visible = v15
count = count + 1

if v14 == nil then
	Multiplier.Text = "MAX"
	Text.Text = "MAX"
else
	Multiplier.Text = TreadmillUtil.FormatSpeedMultiplier(v14.SpeedBoostMultiplier)

	local v16 = count

	if v14 == nil then
		Text.Text = "MAX"
	else
		Text.Text = v1

		local ProductId = v14.ProductId

		task.spawn(function() --[[ Line: 165 | Upvalues: GetPrice (copy), ProductId (copy), v16 (copy), count (ref), Text (copy), Constants (copy), v1 (copy) ]]
			local v13, v2 = GetPrice(ProductId, true)

			if v16 ~= count then
				return
			end

			Text.Text = if v2 then ("ONLY %*%*"):format(v13, Constants.ROBUX_ICON_STR) else v1
		end)
	end
end

Save.ConnectForDataChanged("SpeedBoostTierIndex", updateSpeedBoostProducts)