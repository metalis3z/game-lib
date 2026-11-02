-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)
local Network = require(ReplicatedStorage.Library.Client.Network)
local RecoveryEvent = require(ReplicatedStorage.Directory.RecoveryEvent)
local ServerLuck = require(ReplicatedStorage.Library.Types.ServerLuck)
local Signal = require(ReplicatedStorage.Library.Signal)
local Variables = require(ReplicatedStorage.Library.Variables)
local ServerLuck2 = Constants.NETWORK_MAP.ServerLuck
local v1 = GUI.BottomUI()
local BottomFrame = v1.BottomFrame
local Holder = BottomFrame.Holder
local List = Holder.List
local Luck = List.Luck
local Button = Luck.Button
local TextLabel = Button.Content.Value.TextLabel
local x2Luck = List.x2Luck
local Timer = x2Luck.Timer
local x2Growth = List.x2Growth
local Timer2 = x2Growth.Timer
local AnchorPoint = BottomFrame.AnchorPoint
local Position = BottomFrame.Position
local AnchorPoint2 = Holder.AnchorPoint
local Position2 = Holder.Position
local AnchorPoint3 = List.AnchorPoint
local Position3 = List.Position
local Size = List.Size
local t = {
	Multiplier = 1
}

local function escapeRichText(p1) --[[ escapeRichText | Line: 51 ]]
	return p1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
end

local function getMultiplierText() --[[ getMultiplierText | Line: 55 | Upvalues: t (ref) ]]
	return ("x%*"):format((math.max(1, (math.floor(t.Multiplier)))))
end

local function getBoosterText() --[[ getBoosterText | Line: 59 | Upvalues: t (ref) ]]
	local BoostedByDisplayName = t.BoostedByDisplayName

	if BoostedByDisplayName == nil or BoostedByDisplayName == "" then
		return "<font color=\"#38E839\">@Server</font>"
	end

	return ("<font color=\"#38E839\">@%*</font>"):format((BoostedByDisplayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")))
end

local function getOverlayBlocks() --[[ getOverlayBlocks | Line: 68 | Upvalues: t (ref) ]]
	local t2 = {}
	local t3 = {}
	local v1 = math.floor(t.Multiplier)

	t3[1] = "Title"
	t3[2] = ("<font color=\"#38E839\">%*</font> Server Luck!"):format((("x%*"):format((math.max(1, v1)))))

	local t5 = {}
	local BoostedByDisplayName = t.BoostedByDisplayName
	local v4 = if BoostedByDisplayName == nil or BoostedByDisplayName == "" then "<font color=\"#38E839\">@Server</font>" else ("<font color=\"#38E839\">@%*</font>"):format((BoostedByDisplayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")))

	t5[1] = "Title"
	t5[2] = ("Boosted by %*!"):format(v4)
	t2[1] = t3
	t2[2] = { "Div" }
	t2[3] = t5

	return t2
end

local function render(p1) --[[ render | Line: 76 | Upvalues: Workspace (copy), t (ref), RecoveryEvent (copy), FormatDurationSymbol (copy), Luck (copy), TextLabel (copy), x2Luck (copy), Timer (copy), x2Growth (copy), Timer2 (copy), v1 (copy) ]]
	local v12 = if p1 then p1 else Workspace:GetServerTimeNow()
	local v2 = if t.Multiplier > 1 then true else false
	local v3 = RecoveryEvent.GetActiveEventAt(v12)
	local v4 = if v3 == nil then false else true
	local v8 = FormatDurationSymbol(if v3 then math.max(0, (math.ceil(v3.EndsAt - v12))) else 0)

	Luck.Visible = v2
	TextLabel.Text = ("x%*"):format((math.max(1, (math.floor(t.Multiplier)))))
	x2Luck.Visible = v4
	Timer.Text = v8
	x2Growth.Visible = v4
	Timer2.Text = v8
	v1.Enabled = v2 or v4
end

local function renderPlatform(p1) --[[ renderPlatform | Line: 94 | Upvalues: Variables (copy), BottomFrame (copy), Holder (copy), List (copy), AnchorPoint (copy), Position (copy), AnchorPoint2 (copy), Position2 (copy), AnchorPoint3 (copy), Position3 (copy), Size (copy) ]]
	if Variables.Mobile then
		BottomFrame.AnchorPoint = Vector2.new(1, 0)
		BottomFrame.Position = UDim2.fromScale(0.98, 0.07)
		Holder.AnchorPoint = Vector2.new(1, 0)
		Holder.Position = UDim2.fromScale(1, 0)
		List.AnchorPoint = Vector2.new(0.5, 0)
		List.Position = UDim2.fromScale(0.5, 0)
		List.Size = UDim2.fromScale(0.975, 0.5)
	else
		BottomFrame.AnchorPoint = AnchorPoint
		BottomFrame.Position = Position
		Holder.AnchorPoint = AnchorPoint2
		Holder.Position = Position2
		List.AnchorPoint = AnchorPoint3
		List.Position = Position3
		List.Size = Size
	end
end

local function v2() --[[ scheduleRecoveryEventUpdate | Line: 115 | Upvalues: Workspace (copy), render (copy), RecoveryEvent (copy), v2 (copy) ]]
	local v1 = Workspace:GetServerTimeNow()

	render(v1)

	local v22 = RecoveryEvent.GetEventAtOrAfter(v1)

	if v22 == nil then
		return
	end

	if v1 < v22.StartsAt then
		task.delay(v22.StartsAt - v1, v2)
	else
		task.delay(math.min(v22.EndsAt - v1, (math.max(0.05, 1 - v1 % 1))), v2)
	end
end

local function applyState(p1) --[[ applyState | Line: 134 | Upvalues: t (ref), render (copy) ]]
	t = p1
	render()
end

InfoOverlay.DynamicHook(Button, getOverlayBlocks)
InfoOverlay.Hook(x2Luck.Icon, {
	{ "Title", "X2 LUCK" }
})
InfoOverlay.Hook(x2Growth.Icon, {
	{ "Title", "X2 EGG GROWTH SPEED" }
})
render()
renderPlatform()
v2()
Signal.Fired("Changed Platform"):Connect(renderPlatform)
Network.Fired(ServerLuck2.STATE_UPDATED):Connect(function(p1) --[[ Line: 152 | Upvalues: ServerLuck (copy), t (ref), render (copy) ]]
	if not ServerLuck.State(p1) then
		return
	end

	t = p1
	render()
end)

local v3 = Network.Invoke(ServerLuck2.GET_STATE)

if not ServerLuck.State(v3) then
	return
end

t = v3
render()