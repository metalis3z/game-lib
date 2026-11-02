-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Directory.Assets)
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local ConsoleCmds = require(ReplicatedStorage.Library.Client.ConsoleCmds)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)

require(ReplicatedStorage.Library.Client.Eggs.Types)

local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)

require(ReplicatedStorage.Library.Types.Eggs)

local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local GrowingEggListRow = require(ReplicatedStorage.Library.Client.Eggs.GrowingEggListRow)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PlacedEggRenderer = require(ReplicatedStorage.Library.Client.Eggs.PlacedEggRenderer)
local Products = require(ReplicatedStorage.Directory.Products)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local LocalPlayer = Players.LocalPlayer
local v1 = GUI.GrowingEggList()
local v2 = GUI.SideButtons()
local Frame = v1.Frame
local Close = Frame.Close
local GrowAll = Frame.Header.GrowAll
local ScrollingFrame = Frame.Notepad.ScrollingFrame
local Template = ScrollingFrame.Template
local GrowingEggs = v2.Left.Tools.GrowingEggs
local NightImage = GrowingEggs.NightImage
local NightText = GrowingEggs.NightText
local Notification = GrowingEggs.Notification
local InletTexture = Notification.InletTexture
local TextLabel = InletTexture.TextLabel
local Shadow = TextLabel.Shadow
local ReadyNotification = GrowingEggs.ReadyNotification
local InletTexture2 = ReadyNotification.InletTexture
local TextLabel2 = InletTexture2.TextLabel
local Shadow2 = TextLabel2.Shadow
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local v3 = 0
local v4 = 0
local v5 = 0

assert(v1:IsA("ScreenGui"), "PlayerGui.GrowingEggList must be a ScreenGui")
assert(Frame:IsA("GuiObject"), "GrowingEggList.Frame must be a GuiObject")
assert(Close:IsA("GuiButton"), "GrowingEggList.Frame.Close must be a GuiButton")
assert(GrowAll:IsA("GuiButton"), "GrowingEggList.Frame.Header.GrowAll must be a GuiButton")
assert(ScrollingFrame:IsA("ScrollingFrame"), "GrowingEggList.Frame.Notepad.ScrollingFrame must be a ScrollingFrame")
assert(Template:IsA("GuiObject"), "GrowingEggList.Frame.Notepad.ScrollingFrame.Template must be a GuiObject")
assert(GrowingEggs:IsA("GuiButton"), "Elements.Tabs.GrowingEggs must be a GuiButton")
assert(NightImage:IsA("ImageLabel"), "Elements.Tabs.GrowingEggs.NightImage must be an ImageLabel")
assert(NightText:IsA("TextLabel"), "Elements.Tabs.GrowingEggs.NightText must be a TextLabel")
ConsoleCmds.RegisterCloseButton(Close)
assert(Notification:IsA("GuiObject"), "Elements.Tabs.GrowingEggs.Notification must be a GuiObject")
assert(InletTexture:IsA("GuiObject"), "Elements.Tabs.GrowingEggs.Notification.InletTexture must be a GuiObject")
assert(TextLabel:IsA("TextLabel"), "Elements.Tabs.GrowingEggs.Notification.InletTexture.TextLabel must be a TextLabel")
assert(Shadow:IsA("TextLabel"), "Elements.Tabs.GrowingEggs.Notification.InletTexture.Shadow must be a TextLabel")
assert(ReadyNotification:IsA("GuiObject"), "Elements.Tabs.GrowingEggs.ReadyNotification must be a GuiObject")
assert(InletTexture2:IsA("GuiObject"), "Elements.Tabs.GrowingEggs.ReadyNotification.InletTexture must be a GuiObject")
assert(TextLabel2:IsA("TextLabel"), "Elements.Tabs.GrowingEggs.ReadyNotification.InletTexture.TextLabel must be a TextLabel")
assert(Shadow2:IsA("TextLabel"), "Elements.Tabs.GrowingEggs.ReadyNotification.InletTexture.Shadow must be a TextLabel")

local v23 = Log.new()

local function setOpen(p1) --[[ setOpen | Line: 148 | Upvalues: v1 (copy), GrowingEggs (copy) ]]
	v1.Enabled = p1
	GrowingEggs.Visible = not p1
end

local function getGrowthAlpha(p1) --[[ getGrowthAlpha | Line: 153 | Upvalues: Workspace (copy), EggItemUtil (copy) ]]
	local v1 = Workspace:GetServerTimeNow()

	return EggItemUtil.GetGrowthAlpha(p1, v1, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v1, p1.GrowthSpeedMultiplier))
end

local function isReady(p1) --[[ isReady | Line: 163 | Upvalues: Workspace (copy), EggItemUtil (copy) ]]
	local v1 = Workspace:GetServerTimeNow()

	return EggItemUtil.GetGrowthAlpha(p1, v1, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v1, p1.GrowthSpeedMultiplier)) >= 1
end

local function getRemainingSeconds(p1) --[[ getRemainingSeconds | Line: 167 | Upvalues: Workspace (copy), EggItemUtil (copy) ]]
	if p1.Placement == nil then
		return 0
	end

	local v1 = Workspace:GetServerTimeNow()

	if EggItemUtil.GetGrowthAlpha(p1, v1, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v1, p1.GrowthSpeedMultiplier)) >= 1 then
		return 0
	end

	local v3 = Workspace:GetServerTimeNow()

	return EggItemUtil.GetRemainingGrowthSeconds(p1, v3, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v3, p1.GrowthSpeedMultiplier))
end

local function getRemainingText(p1) --[[ getRemainingText | Line: 182 | Upvalues: Workspace (copy), EggItemUtil (copy), FormatDurationSymbol (copy) ]]
	local Placement = p1.Placement

	if Placement == nil or Placement.ReadyAt ~= nil then
		return "Ready!"
	end

	local v1

	if p1.Placement == nil then
		v1 = 0
	else
		local v2 = Workspace:GetServerTimeNow()

		if EggItemUtil.GetGrowthAlpha(p1, v2, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v2, p1.GrowthSpeedMultiplier)) >= 1 then
			v1 = 0
		else
			local v4 = Workspace:GetServerTimeNow()

			v1 = EggItemUtil.GetRemainingGrowthSeconds(p1, v4, p1.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p1, v4, p1.GrowthSpeedMultiplier))
		end
	end

	if v1 <= 0 then
		return "Ready!"
	end

	return FormatDurationSymbol(v1)
end

local function updateRow(p1) --[[ updateRow | Line: 192 | Upvalues: Assets (copy), Workspace (copy), EggItemUtil (copy), Products (copy), getRemainingSeconds (copy), GrowingEggListRow (copy), FormatDurationSymbol (copy) ]]
	local Record = p1.Record
	local v2 = Workspace:GetServerTimeNow()
	local v3 = EggItemUtil.GetGrowthAlpha(Record, v2, Record.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record, v2, Record.GrowthSpeedMultiplier))
	local v4 = v3 >= 1
	local v5 = not v4 and (if Products.GetEggSkipGrowthProduct(getRemainingSeconds(Record)) == nil then false else true)
	local Placement = Record.Placement
	local v6, v7, v8

	if Placement == nil or Placement.ReadyAt ~= nil then
		v6 = p1
		v7 = v3
		v8 = "Ready!"
	else
		local v9

		if Record.Placement == nil then
			v6 = p1
			v7 = v3
			v9 = 0
		else
			local v10 = Workspace:GetServerTimeNow()

			if EggItemUtil.GetGrowthAlpha(Record, v10, Record.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record, v10, Record.GrowthSpeedMultiplier)) >= 1 then
				v6 = p1
				v7 = v3
				v9 = 0
			else
				local v12 = Workspace:GetServerTimeNow()

				v9, v6, v7 = EggItemUtil.GetRemainingGrowthSeconds(Record, v12, Record.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record, v12, Record.GrowthSpeedMultiplier)), p1, v3
			end
		end

		v8 = if v9 <= 0 then "Ready!" else FormatDurationSymbol(v9)
	end

	GrowingEggListRow.Update(v6, Assets.Directory[Record.AssetCategory].Egg.Icon, v7, v8, v4, v5)
end

local function updateNotification(p1, p2, p3, p4) --[[ updateNotification | Line: 201 ]]
	local v1 = if p4 > 0 then true else false

	p1.Visible = v1

	if not v1 then
		return
	end

	local v2 = tostring(p4)

	p2.Text = v2
	p3.Text = v2
end

local function updatePlacedNotification() --[[ updatePlacedNotification | Line: 211 | Upvalues: Notification (copy), TextLabel (copy), Shadow (copy), v3 (ref) ]]
	local v4 = v3
	local v5 = v4 > 0

	Notification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v4)

	TextLabel.Text = v6
	Shadow.Text = v6
end

local function updateReadyNotification() --[[ updateReadyNotification | Line: 220 | Upvalues: ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy), v4 (ref) ]]
	local v42 = v4
	local v5 = v42 > 0

	ReadyNotification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v42)

	TextLabel2.Text = v6
	Shadow2.Text = v6
end

local function clearPlacedNotification() --[[ clearPlacedNotification | Line: 224 | Upvalues: v3 (ref), t5 (copy), Notification (copy), TextLabel (copy), Shadow (copy) ]]
	v3 = 0
	table.clear(t5)

	local v4 = v3
	local v5 = v4 > 0

	Notification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v4)

	TextLabel.Text = v6
	Shadow.Text = v6
end

local function clearReadyNotification() --[[ clearReadyNotification | Line: 230 | Upvalues: v4 (ref), t6 (copy), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy) ]]
	v4 = 0
	table.clear(t6)

	local v42 = v4
	local v5 = v42 > 0

	ReadyNotification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v42)

	TextLabel2.Text = v6
	Shadow2.Text = v6
end

local function incrementPlacedNotification(p1) --[[ incrementPlacedNotification | Line: 236 | Upvalues: v1 (copy), t5 (copy), v3 (ref), Notification (copy), TextLabel (copy), Shadow (copy) ]]
	if v1.Enabled or t5[p1] then
		return
	end

	t5[p1] = true
	v3 = v3 + 1

	local v4 = v3
	local v5 = v4 > 0

	Notification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v4)

	TextLabel.Text = v6
	Shadow.Text = v6
end

local function incrementReadyNotification(p1) --[[ incrementReadyNotification | Line: 246 | Upvalues: v1 (copy), t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy) ]]
	if v1.Enabled or t6[p1] then
		return
	end

	t6[p1] = true
	v4 = v4 + 1

	local v42 = v4
	local v5 = v42 > 0

	ReadyNotification.Visible = v5

	if not v5 then
		return
	end

	local v6 = tostring(v42)

	TextLabel2.Text = v6
	Shadow2.Text = v6
end

local function consumePlacedNotification(p1) --[[ consumePlacedNotification | Line: 256 | Upvalues: t5 (copy), v3 (ref), Notification (copy), TextLabel (copy), Shadow (copy) ]]
	if not t5[p1] then
		return
	end

	t5[p1] = nil
	v3 = math.max(v3 - 1, 0)

	local v5 = v3
	local v6 = v5 > 0

	Notification.Visible = v6

	if not v6 then
		return
	end

	local v7 = tostring(v5)

	TextLabel.Text = v7
	Shadow.Text = v7
end

local function consumeReadyNotification(p1) --[[ consumeReadyNotification | Line: 266 | Upvalues: t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy) ]]
	if not t6[p1] then
		return
	end

	t6[p1] = nil
	v4 = math.max(v4 - 1, 0)

	local v5 = v4
	local v6 = v5 > 0

	ReadyNotification.Visible = v6

	if not v6 then
		return
	end

	local v7 = tostring(v5)

	TextLabel2.Text = v7
	Shadow2.Text = v7
end

local function syncReadyState(p1, p2, p3) --[[ syncReadyState | Line: 276 | Upvalues: Workspace (copy), EggItemUtil (copy), t4 (copy), v1 (copy), t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy) ]]
	local v12 = Workspace:GetServerTimeNow()
	local v2 = if EggItemUtil.GetGrowthAlpha(p2, v12, p2.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(p2, v12, p2.GrowthSpeedMultiplier)) >= 1 then true else false

	if v2 and not t4[p1] then
		t4[p1] = true

		if p3 and not v1.Enabled then
			if t6[p1] then
				return v2
			end

			t6[p1] = true
			v4 = v4 + 1

			local v42 = TextLabel2
			local v5 = Shadow2
			local v6 = v4
			local v7 = v6 > 0

			ReadyNotification.Visible = v7

			if v7 then
				local v8 = tostring(v6)

				v42.Text = v8
				v5.Text = v8

				return v2
			end
		end
	elseif not v2 and t4[p1] then
		t4[p1] = nil

		if not t6[p1] then
			return v2
		end

		t6[p1] = nil
		v4 = math.max(v4 - 1, 0)

		local v11 = TextLabel2
		local v122 = Shadow2
		local v13 = v4
		local v14 = v13 > 0

		ReadyNotification.Visible = v14

		if v14 then
			local v15 = tostring(v13)

			v11.Text = v15
			v122.Text = v15
		end
	end

	return v2
end

local function compareRows(p1, p2) --[[ compareRows | Line: 291 | Upvalues: Workspace (copy), EggItemUtil (copy) ]]
	local Record = p1.Record
	local v1 = Workspace:GetServerTimeNow()
	local v2 = if EggItemUtil.GetGrowthAlpha(Record, v1, Record.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record, v1, Record.GrowthSpeedMultiplier)) >= 1 then true else false
	local Record2 = p2.Record
	local v3 = Workspace:GetServerTimeNow()

	if v2 ~= (if EggItemUtil.GetGrowthAlpha(Record2, v3, Record2.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record2, v3, Record2.GrowthSpeedMultiplier)) >= 1 then true else false) then
		return v2
	end

	local Record3 = p1.Record
	local v5

	if Record3.Placement == nil then
		v5 = 0
	else
		local v6 = Workspace:GetServerTimeNow()

		if EggItemUtil.GetGrowthAlpha(Record3, v6, Record3.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record3, v6, Record3.GrowthSpeedMultiplier)) >= 1 then
			v5 = 0
		else
			local v8 = Workspace:GetServerTimeNow()

			v5 = EggItemUtil.GetRemainingGrowthSeconds(Record3, v8, Record3.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record3, v8, Record3.GrowthSpeedMultiplier))
		end
	end

	local Record4 = p2.Record
	local v10

	if Record4.Placement == nil then
		v10 = 0
	else
		local v11 = Workspace:GetServerTimeNow()

		if EggItemUtil.GetGrowthAlpha(Record4, v11, Record4.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record4, v11, Record4.GrowthSpeedMultiplier)) >= 1 then
			v10 = 0
		else
			local v13 = Workspace:GetServerTimeNow()

			v10 = EggItemUtil.GetRemainingGrowthSeconds(Record4, v13, Record4.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record4, v13, Record4.GrowthSpeedMultiplier))
		end
	end

	if v5 == v10 then
		local v15 = tostring(p1.Uid)

		return v15 < tostring(p2.Uid)
	end

	return v5 < v10
end

local function relayoutRows() --[[ relayoutRows | Line: 307 | Upvalues: t (copy), compareRows (copy) ]]
	local list = {}

	for k, v in pairs(t) do
		table.insert(list, v)
	end

	table.sort(list, compareRows)

	for i, v in ipairs(list) do
		v.Root.LayoutOrder = i
	end
end

local function destroyRow(p1) --[[ destroyRow | Line: 319 | Upvalues: t (copy), GrowingEggListRow (copy) ]]
	local v1 = t[p1]

	if v1 ~= nil then
		t[p1] = nil
		GrowingEggListRow.Destroy(v1)
	end
end

local function requestGrow(p1) --[[ requestGrow | Line: 329 | Upvalues: PlacedEggRenderer (copy), v23 (copy) ]]
	local v1, v2 = PlacedEggRenderer.RequestSkipGrowthForLocalEgg(p1)

	if v1 then
		return
	end

	v23:AtWarning():Log((("Failed to request egg growth skip from list for %*: %*"):format(p1, v2 or "unknown")))
end

local function showNoGrowingEggs(p1) --[[ showNoGrowingEggs | Line: 336 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Time = 2,
		Message = p1 or "You have no growing eggs!",
		Color = Color3.fromRGB(255, 80, 80)
	})
end

local function requestGrowAll() --[[ requestGrowAll | Line: 344 | Upvalues: EggCmds (copy), Message (copy), PromptPurchase (copy), Products (copy) ]]
	local v1, v2 = EggCmds.CanPurchaseGrowAll()

	if v1 then
		EggCmds.ClearSelectedSkipGrowthUid()
		PromptPurchase.Prompt(Products.Directory.EggGrowAll.ProductId, true)
	else
		Message.Bottom({
			Time = 2,
			Message = v2 or "You have no growing eggs!",
			Color = Color3.fromRGB(255, 80, 80)
		})
	end
end

local function requestHatch(p1) --[[ requestHatch | Line: 355 | Upvalues: PlacedEggRenderer (copy), v23 (copy) ]]
	local v1, v2 = PlacedEggRenderer.ActivateLocalEgg(p1)

	if v1 then
		return
	end

	v23:AtWarning():Log((("Failed to hatch egg from list for %*: %*"):format(p1, v2 or "unknown")))
end

local function removeHatchingRow(p1) --[[ removeHatchingRow | Line: 362 | Upvalues: t2 (copy), t5 (copy), v3 (ref), Notification (copy), TextLabel (copy), Shadow (copy), t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy), t (copy), GrowingEggListRow (copy) ]]
	t2[p1] = true

	if t5[p1] then
		t5[p1] = nil
		v3 = math.max(v3 - 1, 0)

		local v32 = TextLabel
		local v42 = Shadow
		local v5 = v3
		local v6 = v5 > 0

		Notification.Visible = v6

		if v6 then
			local v7 = tostring(v5)

			v32.Text = v7
			v42.Text = v7
		end
	end

	if t6[p1] then
		t6[p1] = nil
		v4 = math.max(v4 - 1, 0)

		local v10 = TextLabel2
		local v11 = Shadow2
		local v12 = v4
		local v13 = v12 > 0

		ReadyNotification.Visible = v13

		if v13 then
			local v14 = tostring(v12)

			v10.Text = v14
			v11.Text = v14
		end
	end

	local v15 = t[p1]

	if v15 ~= nil then
		t[p1] = nil
		GrowingEggListRow.Destroy(v15)
	end
end

local function mountRow(p1, p2) --[[ mountRow | Line: 369 | Upvalues: GrowingEggListRow (copy), Template (copy), ScrollingFrame (copy), requestGrow (copy), requestHatch (copy), t (copy), updateRow (copy) ]]
	local v1 = GrowingEggListRow.Mount(Template, ScrollingFrame, p1, requestGrow, requestHatch)

	v1.Record = p2
	t[p1] = v1
	updateRow(v1)

	return v1
end

local function refreshRows(p1, p2) --[[ refreshRows | Line: 378 | Upvalues: EggCmds (copy), LocalPlayer (copy), t3 (copy), v1 (copy), t5 (copy), v3 (ref), Notification (copy), TextLabel (copy), Shadow (copy), Workspace (copy), EggItemUtil (copy), t4 (copy), t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy), t2 (copy), t (copy), GrowingEggListRow (copy), Template (copy), ScrollingFrame (copy), requestGrow (copy), requestHatch (copy), updateRow (copy), relayoutRows (copy) ]]
	local t7 = {}
	local t8 = {}

	for k, v in pairs((EggCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId))) do
		if v.Placement ~= nil then
			t7[k] = true

			if not t3[k] then
				t3[k] = true

				if p1 and not (v1.Enabled or t5[k]) then
					t5[k] = true
					v3 = v3 + 1

					local v32 = TextLabel
					local v42 = Shadow
					local v5 = v3
					local v6 = v5 > 0

					Notification.Visible = v6

					if v6 then
						local v7 = tostring(v5)

						v32.Text = v7
						v42.Text = v7
					end
				end
			end

			local v8 = Workspace:GetServerTimeNow()
			local v9 = if EggItemUtil.GetGrowthAlpha(v, v8, v.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(v, v8, v.GrowthSpeedMultiplier)) >= 1 then true else false

			if v9 and not t4[k] then
				t4[k] = true

				if p2 and not (v1.Enabled or t6[k]) then
					t6[k] = true
					v4 = v4 + 1

					local v11 = TextLabel2
					local v122 = Shadow2
					local v13 = v4
					local v14 = v13 > 0

					ReadyNotification.Visible = v14

					if v14 then
						local v15 = tostring(v13)

						v11.Text = v15
						v122.Text = v15
					end
				end
			elseif not v9 and t4[k] then
				t4[k] = nil

				if t6[k] then
					t6[k] = nil
					v4 = math.max(v4 - 1, 0)

					local v18 = TextLabel2
					local v19 = Shadow2
					local v20 = v4
					local v21 = v20 > 0

					ReadyNotification.Visible = v21

					if v21 then
						local v22 = tostring(v20)

						v18.Text = v22
						v19.Text = v22
					end
				end
			end

			if t2[k] then
				local v23 = t[k]

				if v23 ~= nil then
					t[k] = nil
					GrowingEggListRow.Destroy(v23)
				end

				continue
			end

			t8[k] = true

			local v24 = t[k]

			if v24 == nil then
				local v25 = GrowingEggListRow.Mount(Template, ScrollingFrame, k, requestGrow, requestHatch)

				v25.Record = v
				t[k] = v25
				updateRow(v25)

				continue
			end

			v24.Record = v
			updateRow(v24)
		end
	end

	for k in pairs(t) do
		if not t8[k] then
			local v26 = t[k]

			if v26 ~= nil then
				t[k] = nil
				GrowingEggListRow.Destroy(v26)
			end
		end
	end

	for k in pairs(t3) do
		if not t7[k] then
			if t5[k] then
				t5[k] = nil
				v3 = math.max(v3 - 1, 0)

				local v29 = TextLabel
				local v30 = Shadow
				local v31 = v3
				local v32 = v31 > 0

				Notification.Visible = v32

				if v32 then
					local v33 = tostring(v31)

					v29.Text = v33
					v30.Text = v33
				end
			end

			if t6[k] then
				t6[k] = nil
				v4 = math.max(v4 - 1, 0)

				local v36 = TextLabel2
				local v37 = Shadow2
				local v38 = v4
				local v39 = v38 > 0

				ReadyNotification.Visible = v39

				if v39 then
					local v40 = tostring(v38)

					v36.Text = v40
					v37.Text = v40
				end
			end

			t3[k] = nil
			t4[k] = nil
			t2[k] = nil
		end
	end

	relayoutRows()
end

local function updateVisibleRows() --[[ updateVisibleRows | Line: 429 | Upvalues: Workspace (copy), v5 (ref), AreaEggResetTimeUtil (copy), NightImage (copy), NightText (copy), t (copy), t4 (copy), EggItemUtil (copy), v1 (copy), t6 (copy), v4 (ref), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy), updateRow (copy), relayoutRows (copy) ]]
	local v12 = Workspace:GetServerTimeNow()

	if v12 - v5 < 0.25 then
		return
	end

	v5 = v12

	local v2 = AreaEggResetTimeUtil.IsNight(v12)

	NightImage.Visible = v2
	NightText.Visible = v2

	local v3 = false

	for k, v in pairs(t) do
		local v42 = t4[v.Uid] == true
		local Uid = v.Uid
		local Record = v.Record
		local v52 = Workspace:GetServerTimeNow()
		local v6 = if EggItemUtil.GetGrowthAlpha(Record, v52, Record.GrowthSpeedMultiplier, EggItemUtil.GetCurrentNightGrowthCreditSeconds(Record, v52, Record.GrowthSpeedMultiplier)) >= 1 then true else false

		if v6 and not t4[Uid] then
			t4[Uid] = true

			if not (v1.Enabled or t6[Uid]) then
				t6[Uid] = true
				v4 = v4 + 1

				local v8 = TextLabel2
				local v9 = Shadow2
				local v10 = v4
				local v11 = v10 > 0

				ReadyNotification.Visible = v11

				if v11 then
					local v122 = tostring(v10)

					v8.Text = v122
					v9.Text = v122
				end
			end
		elseif not v6 and t4[Uid] then
			t4[Uid] = nil

			if t6[Uid] then
				t6[Uid] = nil
				v4 = math.max(v4 - 1, 0)

				local v15 = TextLabel2
				local v16 = Shadow2
				local v17 = v4
				local v18 = v17 > 0

				ReadyNotification.Visible = v18

				if v18 then
					local v19 = tostring(v17)

					v15.Text = v19
					v16.Text = v19
				end
			end
		end

		if v6 ~= v42 then
			v3 = true
		end

		updateRow(v)
	end

	if not v3 then
		return
	end

	relayoutRows()
end

Template.Visible = false
v1.Enabled = false
GrowingEggs.Visible = true

local v24 = v3
local v25 = v24 > 0

Notification.Visible = v25

if v25 then
	local v26 = tostring(v24)

	TextLabel.Text = v26
	Shadow.Text = v26
end

local v27 = v4
local v28 = if v27 > 0 then true else false

ReadyNotification.Visible = v28

if v28 then
	local v29 = tostring(v27)

	TextLabel2.Text = v29
	Shadow2.Text = v29
end

local v30 = AreaEggResetTimeUtil.IsNight(Workspace:GetServerTimeNow())

NightImage.Visible = v30
NightText.Visible = v30
refreshRows(false, true)
GUI.ButtonActivated(GrowingEggs, function() --[[ Line: 466 | Upvalues: v1 (copy), GrowingEggs (copy), v3 (ref), t5 (copy), Notification (copy), TextLabel (copy), Shadow (copy), v4 (ref), t6 (copy), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy), refreshRows (copy) ]]
	v1.Enabled = true
	GrowingEggs.Visible = false
	v3 = 0
	table.clear(t5)

	local v2 = TextLabel
	local v32 = Shadow
	local v42 = v3
	local v5 = v42 > 0

	Notification.Visible = v5

	if v5 then
		local v6 = tostring(v42)

		v2.Text = v6
		v32.Text = v6
	end

	v4 = 0
	table.clear(t6)

	local v10 = v4
	local v11 = v10 > 0

	ReadyNotification.Visible = v11

	if not v11 then
		refreshRows(true, true)

		return
	end

	local v122 = tostring(v10)

	TextLabel2.Text = v122
	Shadow2.Text = v122
	refreshRows(true, true)
end)
GUI.ButtonActivated(Close, function() --[[ Line: 472 | Upvalues: v1 (copy), GrowingEggs (copy) ]]
	v1.Enabled = false
	GrowingEggs.Visible = true
end)
GUI.ButtonActivated(GrowAll, requestGrowAll)
EggCmds.RuntimeSnapshotUpdated:Connect(function() --[[ Line: 476 | Upvalues: refreshRows (copy) ]]
	refreshRows(true, true)
end)
EggCmds.RuntimeOwnerUpdated:Connect(function(p1) --[[ Line: 479 | Upvalues: LocalPlayer (copy), refreshRows (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	refreshRows(true, true)
end)
EggCmds.RuntimeOwnerCleared:Connect(function(p1) --[[ Line: 484 | Upvalues: LocalPlayer (copy), t (copy), GrowingEggListRow (copy), t2 (copy), t3 (copy), t4 (copy), v3 (ref), t5 (copy), Notification (copy), TextLabel (copy), Shadow (copy), v4 (ref), t6 (copy), ReadyNotification (copy), TextLabel2 (copy), Shadow2 (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	for k in pairs(t) do
		local v1 = t[k]

		if v1 ~= nil then
			t[k] = nil
			GrowingEggListRow.Destroy(v1)
		end
	end

	table.clear(t2)
	table.clear(t3)
	table.clear(t4)
	v3 = 0
	table.clear(t5)

	local v32 = TextLabel
	local v42 = Shadow
	local v5 = v3
	local v6 = v5 > 0

	Notification.Visible = v6

	if v6 then
		local v7 = tostring(v5)

		v32.Text = v7
		v42.Text = v7
	end

	v4 = 0
	table.clear(t6)

	local v11 = v4
	local v12 = v11 > 0

	ReadyNotification.Visible = v12

	if not v12 then
		return
	end

	local v13 = tostring(v11)

	TextLabel2.Text = v13
	Shadow2.Text = v13
end)
PlacedEggRenderer.LocalEggHatchStarted:Connect(removeHatchingRow)
RunService.Heartbeat:Connect(updateVisibleRows)