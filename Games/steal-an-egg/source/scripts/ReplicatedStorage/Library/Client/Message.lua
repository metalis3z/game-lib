-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local CircularBar = require(ReplicatedStorage.Library.Client.GUIFX.CircularBar)
local ItemUI = require(ReplicatedStorage.Library.Client.UI.ItemUI)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Functions = require(ReplicatedStorage.Library.Functions)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = Log.new()
local GreenGradient = ReplicatedStorage.Assets.UI.Gradients.GreenGradient
local GreyGradient = ReplicatedStorage.Assets.UI.Gradients.GreyGradient
local v2 = GUI.Message()
local Contents = v2.Frame.Contents
local Close = v2.Frame.Close
local No = Contents.No
local Yes = Contents.Yes
local CircularBar2 = Yes.CircularBar
local Ok = Contents.Ok
local Option1 = Contents.Option1
local Option2 = Contents.Option2
local Desc = Contents.Desc
local CustomDesc = Contents.CustomDesc
local CustomHolder = Contents.CustomHolder
local Title = v2.Frame.Top.Title
local CustomIcon = Contents.CustomIcon
local CurrencyCoins = Contents.CurrencyCoins
local v3 = false
local v4 = false
local t = {}

Desc.RichText = true
CustomDesc.RichText = true
function t.New(p1, p2, p3, p4) --[[ New | Line: 103 | Upvalues: Save (copy), v3 (ref), TabController (copy), Variables (copy), Audio (copy), Close (copy), Yes (copy), No (copy), Ok (copy), Option1 (copy), Option2 (copy), CustomHolder (copy), CustomIcon (copy), CustomDesc (copy), Desc (copy), CurrencyCoins (copy), Title (copy), Functions (copy), ItemUI (copy), Trove (copy), Signal (copy), GUI (copy), v2 (copy), CircularBar2 (copy), GreenGradient (copy), GreyGradient (copy), v4 (ref), CircularBar (copy) ]]
	if not Save.Get() or (v3 or TabController.IsOpen("Message")) then
		return
	end

	v3 = true

	local v1 = if p2 == nil then true elseif type(p2) == "table" then true else false
	local v22 = if p2 == true then true else false
	local v32 = if type(p2) == "string" then true else false
	local v42 = v1 and p2 or (v22 and p3 or (v32 and p4 or {}))
	local v5 = if v42.title == nil then if v42.err == true then true else false else true
	local v6 = if v42.icon == nil then if v42.err == true then true else false else true
	local v7 = if v42.item == nil then if v42.items == nil then false else true else true
	local v8 = if v42.timedLock == nil then false else true
	local timedLock = v42.timedLock
	local v9 = if v42.err == true then "Oops!" else v42.title or ""
	local v10 = (not v42.err or v42.icon) and v42.icon or ""
	local v11 = v42.iconColor or Color3.fromRGB(255, 255, 255)
	local v12 = v42.reopen and v42.reopen() or nil
	local currencyData = v42.currencyData
	local sound = v42.sound
	local soundVolume = v42.soundVolume
	local closeOnSuccess = v42.closeOnSuccess
	local tradeAllowed = v42.tradeAllowed
	local v13 = tick()
	local v14 = nil

	if v42.items then
		v14 = v42.items
	elseif v42.item then
		v14 = { v42.item }
	end

	if v8 and not v22 then
		error("timedLock can only be used on yes/no messages")
	end

	if Variables.Trading and not tradeAllowed then
		v3 = false

		return
	end

	if not sound and v1 then
		Audio.PlayStatement()
	elseif not sound then
		Audio.PlayQuestion()
	end

	if sound then
		Audio.Play(sound, script, 1, soundVolume or 1)
	end

	Close.Visible = v1 or v22
	Yes.Visible = v22
	No.Visible = v22
	Ok.Visible = v1
	Option1.Visible = v32
	Option2.Visible = v32
	CustomHolder.Visible = v7
	CustomIcon.Visible = v6
	CustomDesc.Visible = if v6 then v6 elseif currencyData then currencyData else v7
	Desc.Visible = not v6 and not currencyData and not v7
	CurrencyCoins.Visible = currencyData
	CustomIcon.ImageColor3 = v11
	CustomIcon.Image = if v6 and v10 then v10 else ""
	Desc.Text = p1
	CustomDesc.Text = p1
	Title.Text = if v5 and v9 then v9 else "Hey!"

	local list = {}

	if v7 and v14 then
		CustomHolder.ClipsDescendants = #v14 > 3
		Functions.CleanupGuiChildren(CustomHolder)

		for i, v in ipairs(v14) do
			local t = {
				NoButtonFX = true,
				NoActionMenu = true,
				ShowCurrencyBag = true
			}

			t.HideQuantity = if (v42.quantityOverride or v:GetAmount()) == 1 then true else false
			t.QuantityOverride = v42.quantityOverride

			local v28 = ItemUI.Create(v, t)

			Instance.new("UIAspectRatioConstraint").Parent = v28
			v28.Parent = CustomHolder
			table.insert(list, v28)
		end

		if #list > 3 then
			CustomHolder.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		else
			CustomHolder.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		end

		Functions.AutomaticCanvasSize(CustomHolder)
	end

	local v29 = TabController.Get()

	if not TabController.OpenTab("Message", nil, nil, Variables.Trading and tradeAllowed == true) then
		v3 = false

		return
	end

	local v31 = nil
	local v322 = true
	local v33 = false
	local v34 = Trove.new()
	local v35 = v34:Add(Signal.new())

	local function complete(p1, p2) --[[ complete | Line: 233 | Upvalues: v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if v322 then
			v31 = p1
			v33 = p2
			v322 = false
			v35:Fire()
		end
	end

	local function connectActivated(p1, p2) --[[ connectActivated | Line: 242 | Upvalues: GUI (ref), v34 (copy) ]]
		local v1 = GUI.ButtonActivated(p1, p2)

		v34:Add(v1.Default)
		v34:Add(v1.Signal)
	end

	local function f37() --[[ Line: 248 | Upvalues: v22 (copy), v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		local v1 = if v22 then false else nil

		if v322 then
			v31 = v1
			v33 = false
			v322 = false
			v35:Fire()
		end
	end

	local v38 = GUI.ButtonActivated(Close, f37)

	v34:Add(v38.Default)
	v34:Add(v38.Signal)
	v34:Add(v2.Changed:Connect(function(p1) --[[ Line: 251 | Upvalues: v2 (ref), v22 (copy), v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if p1 ~= "Enabled" or v2.Enabled then
			return
		end

		if not v322 then
			return
		end

		v31 = if v22 then false else nil
		v33 = false
		v322 = false
		v35:Fire()
	end))

	local function f40() --[[ Line: 256 | Upvalues: v42 (copy), v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		local v1 = if v42.confirmOnOk == true then true else nil

		if v322 then
			v31 = v1
			v33 = true
			v322 = false
			v35:Fire()
		end
	end

	local v41 = GUI.ButtonActivated(Ok, f40)

	v34:Add(v41.Default)
	v34:Add(v41.Signal)

	local v422 = Yes

	local function f43() --[[ Line: 259 | Upvalues: v8 (copy), timedLock (copy), v13 (copy), v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if v8 and not (timedLock < tick() - v13) then
			return
		end

		if not v322 then
			return
		end

		v31 = true
		v33 = true
		v322 = false
		v35:Fire()
	end

	local v44 = GUI.ButtonActivated(v422, f43)

	v34:Add(v44.Default)
	v34:Add(v44.Signal)

	local function f46() --[[ Line: 264 | Upvalues: v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if v322 then
			v31 = false
			v33 = false
			v322 = false
			v35:Fire()
		end
	end

	local v47 = GUI.ButtonActivated(No, f46)

	v34:Add(v47.Default)
	v34:Add(v47.Signal)

	local function f49() --[[ Line: 267 | Upvalues: v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if v322 then
			v31 = 1
			v33 = false
			v322 = false
			v35:Fire()
		end
	end

	local v50 = GUI.ButtonActivated(Option1, f49)

	v34:Add(v50.Default)
	v34:Add(v50.Signal)

	local function f52() --[[ Line: 270 | Upvalues: v322 (ref), v31 (ref), v33 (ref), v35 (copy) ]]
		if v322 then
			v31 = 2
			v33 = false
			v322 = false
			v35:Fire()
		end
	end

	local v53 = GUI.ButtonActivated(Option2, f52)

	v34:Add(v53.Default)
	v34:Add(v53.Signal)

	if v8 then
		Functions.GradientSwap(Yes, GreyGradient)
		task.spawn(function() --[[ Line: 278 | Upvalues: v4 (ref), CircularBar (ref), CircularBar2 (ref), v322 (ref), v13 (copy), timedLock (copy), v8 (copy), Functions (ref), Yes (ref), GreenGradient (ref) ]]
			if not v4 then
				CircularBar(CircularBar2)
				v4 = true
			end

			CircularBar2.Visible = true

			while v322 do
				CircularBar2:SetAttribute("Progress", 1 - math.clamp(tick() - v13, 0, timedLock) / timedLock)

				if v8 and timedLock < tick() - v13 then
					break
				end

				task.wait()
			end

			CircularBar2.Visible = false
			Functions.GradientSwap(Yes, GreenGradient)
		end)
	else
		CircularBar2.Visible = false
		Functions.GradientSwap(Yes, GreenGradient)
	end

	v35:Wait()
	v34:Destroy()

	for i, v in ipairs(list) do
		v:Destroy()
	end

	if v29 and not v42.dontRestore then
		if v33 and closeOnSuccess then
			TabController.CloseTab()
		else
			TabController.OpenTab(v29, true)
		end
	elseif v12 then
		TabController.OpenTab(v12, true)
	else
		TabController.CloseTab()
	end

	v3 = false

	return v31
end
function t.StandardError() --[[ StandardError | Line: 331 | Upvalues: t (copy) ]]
	return t.New("Something went wrong.", {
		title = "Oops!",
		err = true
	})
end
function t.StandardSuccess() --[[ StandardSuccess | Line: 342 | Upvalues: t (copy) ]]
	return t.New("Success!")
end
function t.Error(p1) --[[ Error | Line: 351 | Upvalues: t (copy) ]]
	if p1 then
		return t.New(p1, {
			err = true
		})
	end

	return t.StandardError()
end
ButtonFX(Ok)
ButtonFX(Yes)
ButtonFX(No)
ButtonFX(Option1)
ButtonFX(Option2)
ButtonFX(Close)
Network.Fired("Message"):Connect(function(...) --[[ Line: 372 | Upvalues: t (copy) ]]
	t.New(...)
end)
Network.Invoked(Constants.NETWORK_MAP.Backpack.PROMPT_FULL_INVENTORY_SELL).OnInvoke = function(p1) --[[ Line: 376 | Upvalues: t (copy) ]]
	return t.New(p1, true) == true
end
v1:AtInfo():Log("Message UI initialized")

return t