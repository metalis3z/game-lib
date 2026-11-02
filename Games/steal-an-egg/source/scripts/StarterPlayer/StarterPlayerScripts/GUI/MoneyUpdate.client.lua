-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Commas = require(ReplicatedStorage.Library.Functions.Commas)
local Network = require(ReplicatedStorage.Library.Client.Network)
local SettingsCmds = require(ReplicatedStorage.Library.Client.SettingsCmds)
local UpdateTextAndShadow = require(ReplicatedStorage.Library.Functions.UpdateTextAndShadow)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local v1 = 0
local v2 = 0
local v3 = 1
local v4 = nil
local v5 = nil
local v6 = 0
local CashCollect = SoundService.CashCollect
local MoneyChange = ReplicatedStorage.Assets.MoneyChange
local LocalPlayer = Players.LocalPlayer
local Money = GUI.Money().Bottom.Frame.Money
local Money2 = Money.Money
local Frame = Money.Changes.Frame

local function playCashCollectSound() --[[ playCashCollectSound | Line: 47 | Upvalues: SettingsCmds (copy), v2 (ref), v3 (ref), CashCollect (copy) ]]
	if not SettingsCmds.IsEnabled("SFX") then
		return
	end

	if tick() - v2 > 2 or v3 >= 3 then
		v3 = 1
	end

	v2 = tick()
	CashCollect.TimePosition = 0
	CashCollect.PlaybackSpeed = v3
	CashCollect:Play()
	v3 = v3 + 0.07
end

local function createMoneyChangeClone() --[[ createMoneyChangeClone | Line: 64 | Upvalues: MoneyChange (copy) ]]
	local v1 = MoneyChange:Clone()
	local Label = v1.Label
	local UIScale = v1.UIScale
	local UIStroke = Label.UIStroke
	local More = Label.More
	local Less = Label.Less
	local Icon = v1.Icon

	Label.TextTransparency = 1
	UIStroke.Transparency = 1
	UIScale.Scale = 0
	Icon.ImageTransparency = 1

	return v1, Label, UIScale, UIStroke, Icon, More, Less
end

local function getTransparencyProperty(p1) --[[ getTransparencyProperty | Line: 81 ]]
	if p1:IsA("ImageLabel") or p1:IsA("ImageButton") then
		return "ImageTransparency"
	end

	if p1:IsA("TextLabel") or p1:IsA("TextButton") then
		return "TextTransparency"
	end

	if p1:IsA("UIStroke") then
		return "Transparency"
	end

	return nil
end

local function animateNotification(p1, p2, p3, p4, p5) --[[ animateNotification | Line: 93 | Upvalues: Tween (copy), getTransparencyProperty (copy), Debris (copy) ]]
	Tween(p2, {
		TextTransparency = 0.25
	}, { 0.5 })
	Tween(p4, {
		Transparency = 0.25
	}, { 0.5 })
	Tween(p3, {
		Scale = 1
	}, { 0.5, Enum.EasingStyle.Back })

	for i, v in ipairs(p5) do
		local v1 = getTransparencyProperty(v)

		if v1 then
			if v1 == "ImageTransparency" then
				v.ImageTransparency = 1
			elseif v1 == "TextTransparency" then
				v.TextTransparency = 1
			elseif v1 == "Transparency" then
				v.Transparency = 1
			end

			Tween(v, {
				[v1] = 0
			}, { 0.5 })
		end
	end

	task.delay(1, function() --[[ Line: 119 | Upvalues: Tween (ref), p2 (copy), p4 (copy), p5 (copy), getTransparencyProperty (ref), Debris (ref), p1 (copy) ]]
		Tween(p2, {
			TextTransparency = 1
		}, { 0.75 })
		Tween(p4, {
			Transparency = 1
		}, { 0.75 })

		for i, v in ipairs(p5) do
			local v1 = getTransparencyProperty(v)

			if v1 then
				Tween(v, {
					[v1] = 1
				}, { 0.75 })
			end
		end

		Debris:AddItem(p1, 0.75)
	end)
end

local function spawnFloatingMoney(p1, p2) --[[ spawnFloatingMoney | Line: 134 | Upvalues: MoneyChange (copy), Simple (copy), Frame (copy), animateNotification (copy) ]]
	local v1 = p1 < 0
	local v3 = MoneyChange:Clone()
	local Label = v3.Label
	local UIScale = v3.UIScale
	local UIStroke = Label.UIStroke
	local More = Label.More
	local Less = Label.Less
	local Icon = v3.Icon

	Label.TextTransparency = 1
	UIStroke.Transparency = 1
	UIScale.Scale = 0
	Icon.ImageTransparency = 1

	if More and More:IsA("UIGradient") then
		More.Enabled = not v1
	end

	local v4, v5

	if Less and Less:IsA("UIGradient") then
		Less.Enabled = v1
	end

	v4 = Simple.FormatCompact
	v5 = math.abs(p1)
	Label.Text = (if v1 then "-" else "+") .. "$" .. v4(math.round(v5), ".#")
	Icon.Visible = false
	v3.Parent = Frame
	animateNotification(v3, Label, UIScale, UIStroke, {})
end

local function displayMoneyChange(p1, p2, p3) --[[ displayMoneyChange | Line: 158 | Upvalues: playCashCollectSound (copy), spawnFloatingMoney (copy) ]]
	if p1 == 0 then
		return
	end

	if not (p1 > 0) or p3 == false then
		spawnFloatingMoney(p1, p2)

		return
	end

	playCashCollectSound()
	spawnFloatingMoney(p1, p2)
end

local function updateMoneyLabels(p1) --[[ updateMoneyLabels | Line: 170 | Upvalues: Asserts (copy), UpdateTextAndShadow (copy), Money2 (copy) ]]
	Asserts.string(p1)
	UpdateTextAndShadow(Money2, p1)
end

local function formatMoneyText(p1) --[[ formatMoneyText | Line: 175 | Upvalues: Simple (copy), Commas (copy) ]]
	if p1 > 99999 then
		return "$" .. Simple.FormatCompact(math.round(p1), ".#")
	end

	return "$" .. Commas((math.round(p1)))
end

local function cancelMoneyLabelTween() --[[ cancelMoneyLabelTween | Line: 183 | Upvalues: v4 (ref), v5 (ref) ]]
	if v4 then
		v4:Cancel()
		v4 = nil
	end

	if not v5 then
		return
	end

	v5:Destroy()
	v5 = nil
end

local function setMoneyLabelValue(p1) --[[ setMoneyLabelValue | Line: 195 | Upvalues: Simple (copy), Commas (copy), Asserts (copy), UpdateTextAndShadow (copy), Money2 (copy) ]]
	local v1 = if p1 > 99999 then "$" .. Simple.FormatCompact(math.round(p1), ".#") else "$" .. Commas((math.round(p1)))

	Asserts.string(v1)
	UpdateTextAndShadow(Money2, v1)
end

local function tweenMoneyLabelValue(p1, p2) --[[ tweenMoneyLabelValue | Line: 199 | Upvalues: v4 (ref), v5 (ref), Simple (copy), Commas (copy), Asserts (copy), UpdateTextAndShadow (copy), Money2 (copy), setMoneyLabelValue (copy), Tween (copy) ]]
	if v4 then
		v4:Cancel()
		v4 = nil
	end

	if v5 then
		v5:Destroy()
		v5 = nil
	end

	local v1 = Instance.new("NumberValue")

	v1.Value = p1
	v5 = v1

	local v2 = if p1 > 99999 then "$" .. Simple.FormatCompact(math.round(p1), ".#") else "$" .. Commas((math.round(p1)))

	Asserts.string(v2)
	UpdateTextAndShadow(Money2, v2)
	v1.Changed:Connect(setMoneyLabelValue)

	local v3 = Tween(v1, {
		Value = p2
	}, { 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

	v4 = v3
	v3.Completed:Once(function(p1) --[[ Line: 216 | Upvalues: v4 (ref), v3 (copy), v5 (ref), p2 (copy), Simple (ref), Commas (ref), Asserts (ref), UpdateTextAndShadow (ref), Money2 (ref), v1 (copy) ]]
		if v4 ~= v3 then
			return
		end

		v4 = nil
		v5 = nil

		if p1 == Enum.PlaybackState.Completed then
			local v12 = p2
			local v2 = if v12 > 99999 then "$" .. Simple.FormatCompact(math.round(v12), ".#") else "$" .. Commas((math.round(v12)))

			Asserts.string(v2)
			UpdateTextAndShadow(Money2, v2)
		end

		v1:Destroy()
	end)
end

local function updateMoney(p1) --[[ updateMoney | Line: 232 | Upvalues: Save (copy), v1 (ref), v5 (ref), tweenMoneyLabelValue (copy), v4 (ref), Simple (copy), Commas (copy), Asserts (copy), UpdateTextAndShadow (copy), Money2 (copy), v6 (ref), playCashCollectSound (copy), spawnFloatingMoney (copy) ]]
	local v12 = Save.Get()
	local mirroredMoney = LocalPlayer:GetAttribute("Money")
	local Money = if typeof(mirroredMoney) == "number"
		then mirroredMoney
		else tonumber(if v12 then v12.Money else nil) or 0
	local v2 = if p1 then p1.forceUpdate else p1

	if Money == v1 and not v2 then
		return
	end

	if not v2 and (if v1 < Money then true else false) then
		tweenMoneyLabelValue(if v5 then v5.Value else v1, Money)
	else
		if v4 then
			v4:Cancel()
			v4 = nil
		end

		if v5 then
			v5:Destroy()
			v5 = nil
		end

		local v52 = if Money > 99999 then "$" .. Simple.FormatCompact(math.round(Money), ".#") else "$" .. Commas((math.round(Money)))

		Asserts.string(v52)
		UpdateTextAndShadow(Money2, v52)
	end

	if not v2 then
		local sum = Money - v1

		if sum > 0 and v6 > 0 then
			local v7 = math.min(sum, v6)

			sum = sum - v7
			v6 = v6 - v7
		end

		if sum ~= 0 and ((not (if sum > 0 then true else false) or (if p1 and p1.allowPositiveAnimation ~= nil then p1.allowPositiveAnimation else true)) and sum ~= 0) then
			if sum > 0 then
				playCashCollectSound()
			end

			spawnFloatingMoney(sum, nil)
		end
	end

	v1 = Money
end

updateMoney({
	forceUpdate = true
})
Save.StatChanged:Connect(function(p1) --[[ Line: 281 | Upvalues: updateMoney (copy) ]]
	if p1 ~= "Money" then
		return
	end

	updateMoney({
		allowPositiveAnimation = false
	})
end)
LocalPlayer:GetAttributeChangedSignal("Money"):Connect(function()
	updateMoney({
		forceUpdate = true,
		allowPositiveAnimation = false,
	})
end)
Network.Fired(Network.NET_MAP.ActiveAssets.MONEY_COLLECTED_EVENT):Connect(function(p1, p2) --[[ Line: 288 | Upvalues: playCashCollectSound (copy), spawnFloatingMoney (copy), v6 (ref) ]]
	if not p1 or p2 then
		return
	end

	local sum = 0
	local v1 = false

	for i, v in ipairs(p1) do
		if v and typeof(v.amount) == "number" then
			sum = sum + math.max(v.amount, 0)

			local v2 = if v.playSound == false then false else true
			local v3 = if v2 then not v1 else v2
			local amount3 = v.amount
			local icon = v.icon

			if amount3 ~= 0 then
				if amount3 > 0 and v3 ~= false then
					playCashCollectSound()
				end

				spawnFloatingMoney(amount3, icon)
			end

			if v.amount > 0 and v3 then
				v1 = true
			end
		end
	end

	if not (sum > 0) then
		return
	end

	v6 = v6 + sum
end)