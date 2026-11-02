-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local AreaEggResetCycle = require(ReplicatedStorage.Directory.AreaEggResetCycle)
local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = GUI.GameResetTimer()
local v3 = GUI.TutorialInstructions()

assert(v3:IsA("ScreenGui"), "TutorialInstructions must be a ScreenGui")

local TimeLeft = v2.TimeLeft
local EndingSoon = v2.EndingSoon
local TextLabel = TimeLeft.Main.TextLabel
local TextLabel2 = EndingSoon.Main.TextLabel
local ImageLabel = TimeLeft.Main.Frame.ImageLabel
local ImageLabel2 = EndingSoon.Main.Frame.ImageLabel
local TextColor3 = TextLabel.TextColor3
local TextColor32 = TextLabel2.TextColor3
local v5 = -1
local v6 = AreaEggResetTimeUtil.GetPeriodIndex(Workspace:GetServerTimeNow())
local v7 = false
local v8 = false
local Enabled = v3.Enabled
local v9 = false
local v10 = false
local Enabled2 = v3.Enabled

if Constants.IS_MOBILE then
	TimeLeft.Position = UDim2.fromScale(0.89, TimeLeft.Position.Y.Scale)
end

local function getBlinkColor(p1, p2, p3) --[[ getBlinkColor | Line: 64 | Upvalues: AreaEggResetTimeUtil (copy), v1 (copy) ]]
	if p2 or not (AreaEggResetTimeUtil.IsFinalBlinkWindow(p1) and AreaEggResetTimeUtil.IsBlinkRed(p1)) then
		return p3
	end

	return v1
end

local function setNormalTimer(p1, p2, p3) --[[ setNormalTimer | Line: 76 | Upvalues: TimeLeft (copy), EndingSoon (copy), TextLabel (copy), TextColor3 (copy), AreaEggResetTimeUtil (copy), v1 (copy), TextLabel2 (copy), TextColor32 (copy) ]]
	TimeLeft.Visible = true
	EndingSoon.Visible = false
	TextLabel.Text = p3
	TextLabel.TextColor3 = if p2 or not (AreaEggResetTimeUtil.IsFinalBlinkWindow(p1) and AreaEggResetTimeUtil.IsBlinkRed(p1)) then TextColor3 else v1
	TextLabel2.TextColor3 = TextColor32
end

local function setEndingSoonTimer(p1, p2, p3) --[[ setEndingSoonTimer | Line: 84 | Upvalues: TimeLeft (copy), EndingSoon (copy), TextLabel2 (copy), TextLabel (copy), TextColor3 (copy), TextColor32 (copy), AreaEggResetTimeUtil (copy), v1 (copy) ]]
	TimeLeft.Visible = false
	EndingSoon.Visible = true
	TextLabel2.Text = p3
	TextLabel.TextColor3 = TextColor3
	TextLabel2.TextColor3 = if p2 or not (AreaEggResetTimeUtil.IsFinalBlinkWindow(p1) and AreaEggResetTimeUtil.IsBlinkRed(p1)) then TextColor32 else v1
end

local function refreshTimer(p1) --[[ refreshTimer | Line: 92 | Upvalues: Workspace (copy), AreaEggResetTimeUtil (copy), v5 (ref), v6 (ref), v9 (ref), v7 (ref), v10 (ref), v8 (ref), Enabled2 (ref), Enabled (ref), AreaEggResetCycle (copy), ImageLabel (copy), ImageLabel2 (copy), FormatDurationSymbol (copy), TimeLeft (copy), EndingSoon (copy), TextLabel2 (copy), TextLabel (copy), TextColor3 (copy), TextColor32 (copy), v1 (copy) ]]
	local v12 = Workspace:GetServerTimeNow()
	local v2 = AreaEggResetTimeUtil.GetActivePeriodIndex(v12)
	local v3 = AreaEggResetTimeUtil.IsNight(v12)
	local v52 = math.ceil((AreaEggResetTimeUtil.GetPhaseTimeLeft(v12)))

	if not p1 and (v52 == v5 and (v2 == v6 and (v9 == v7 and (v10 == v8 and Enabled2 == Enabled)))) then
		return
	end

	v5 = v52
	v6 = v2
	v7 = v9
	v8 = v10
	Enabled = Enabled2

	local v62 = if v3 then AreaEggResetCycle.SunIcon else AreaEggResetCycle.MoonIcon

	ImageLabel.Image = v62
	ImageLabel2.Image = v62

	local v72 = "in " .. FormatDurationSymbol(v52)

	if v3 or (not AreaEggResetTimeUtil.IsEndingSoon(v52) or (v9 or (v10 or Enabled2))) then
		TimeLeft.Visible = true
		EndingSoon.Visible = false
		TextLabel.Text = v72
		TextLabel.TextColor3 = if v3 or not (AreaEggResetTimeUtil.IsFinalBlinkWindow(v52) and AreaEggResetTimeUtil.IsBlinkRed(v52)) then TextColor3 else v1
		TextLabel2.TextColor3 = TextColor32
	else
		TimeLeft.Visible = false
		EndingSoon.Visible = true
		TextLabel2.Text = v72
		TextLabel.TextColor3 = TextColor3
		TextLabel2.TextColor3 = if v3 or not (AreaEggResetTimeUtil.IsFinalBlinkWindow(v52) and AreaEggResetTimeUtil.IsBlinkRed(v52)) then TextColor32 else v1
	end
end

refreshTimer()
EggCmds.AreaEggCarryStateChanged:Connect(function(p1) --[[ Line: 136 | Upvalues: v9 (ref), refreshTimer (copy) ]]
	v9 = p1.IsCarrying
	refreshTimer(true)
end)
Network.Fired(Constants.NETWORK_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(p1) --[[ Line: 141 | Upvalues: v10 (ref), refreshTimer (copy) ]]
	v10 = p1 ~= nil
	refreshTimer(true)
end)
v3:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 146 | Upvalues: Enabled2 (ref), v3 (copy), refreshTimer (copy) ]]
	Enabled2 = v3.Enabled
	refreshTimer(true)
end)
RunService.Heartbeat:Connect(function(p1) --[[ Line: 151 | Upvalues: refreshTimer (copy) ]]
	refreshTimer()
end)