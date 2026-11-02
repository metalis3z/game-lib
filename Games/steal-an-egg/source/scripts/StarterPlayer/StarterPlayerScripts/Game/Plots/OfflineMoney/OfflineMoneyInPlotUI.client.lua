-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local HideImportantUI = require(ReplicatedStorage.Library.Client.HideImportantUI)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Player = require(ReplicatedStorage.Library.Player)
local PlayerMoneyPerSecondUtil = require(ReplicatedStorage.Library.Util.PlayerMoneyPerSecondUtil)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local OFFLINE_ASSETS = Constants.OFFLINE_ASSETS
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

assert(PlayerGui:IsA("PlayerGui"), "Expected PlayerGui")

local OfflineMoneyInPlot = PlayerGui:WaitForChild("OfflineMoneyInPlot")

assert(OfflineMoneyInPlot:IsA("ScreenGui"), "OfflineMoneyInPlot must be a ScreenGui")

local TopBar = OfflineMoneyInPlot:WaitForChild("TopBar")

assert(TopBar:IsA("GuiObject"), "OfflineMoneyInPlot.TopBar must be a GuiObject")

local InPlot = TopBar:WaitForChild("InPlot")

assert(InPlot:IsA("GuiObject"), "OfflineMoneyInPlot.TopBar.InPlot must be a GuiObject")

local TextLabel = InPlot:WaitForChild("TextLabel")

assert(TextLabel:IsA("TextLabel"), "OfflineMoneyInPlot.TopBar.InPlot.TextLabel must be a TextLabel")

local v6 = Trove.new()
local v7 = nil

local function formatOfflineAmount(p1) --[[ formatOfflineAmount | Line: 47 | Upvalues: Simple (copy) ]]
	return Simple.FormatCompact((math.max(p1, 0)))
end

local function getOfflinePreviewAmountFromTotalRate(p1) --[[ getOfflinePreviewAmountFromTotalRate | Line: 51 | Upvalues: OFFLINE_ASSETS (copy) ]]
	return math.max(p1, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER
end

local v8, _

_ = function() --[[ updateText | Line: 57 | Upvalues: TextLabel (copy), formatOfflineAmount (copy), v8 (ref), OFFLINE_ASSETS (copy) ]]
	TextLabel.RichText = true
	TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(math.max(v8, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
end

local function isWorldPositionInsideScaledPetAreaXZ(p1) --[[ isWorldPositionInsideScaledPetAreaXZ | Line: 65 | Upvalues: AssetCmds (copy), LocalPlayer (copy) ]]
	local v1 = AssetCmds.ResolveAssetArea(LocalPlayer)

	if v1 == nil then
		return false
	end

	local v2 = v1.CFrame:PointToObjectSpace(p1)

	return if math.abs(v2.X) <= v1.Size.X * 0.74 * 0.5 then math.abs(v2.Z) <= v1.Size.Z * 0.74 * 0.5 else false
end

local function refreshRateFromSave() --[[ refreshRateFromSave | Line: 78 | Upvalues: Save (copy), v8 (ref), PlayerMoneyPerSecondUtil (copy), LocalPlayer (copy), TextLabel (copy), formatOfflineAmount (copy), OFFLINE_ASSETS (copy), v7 (ref) ]]
	local v1 = Save.Get()

	v8 = if v1 == nil then 0 else PlayerMoneyPerSecondUtil.GetTotalForProfile(LocalPlayer, v1)
	TextLabel.RichText = true
	TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(math.max(v8, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
	v7()
end

v7 = function() --[[ updateVisibility | Line: 87 | Upvalues: Player (copy), LocalPlayer (copy), HideImportantUI (copy), v8 (ref), isWorldPositionInsideScaledPetAreaXZ (copy), OfflineMoneyInPlot (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	OfflineMoneyInPlot.Enabled = not HideImportantUI:IsLocked() and (if v8 > 1000 and v1 ~= nil then isWorldPositionInsideScaledPetAreaXZ(v1.Position) else false)
end
TextLabel.RichText = true
OfflineMoneyInPlot.Enabled = false

local v9 = Save.Get()

v8 = if v9 == nil then 0 else PlayerMoneyPerSecondUtil.GetTotalForProfile(LocalPlayer, v9)
TextLabel.RichText = true

local v10 = v8

TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(math.max(v10, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
v7()
v7()
v6:Add(Save.ConnectForDataChanged({ "EquippedAssets", "Inventory", "Rebirth", "Gamepasses", "Products" }, refreshRateFromSave))
v6:Add(Save.LoadedStats:Connect(function(p1) --[[ Line: 112 | Upvalues: LocalPlayer (copy), Save (copy), v8 (ref), PlayerMoneyPerSecondUtil (copy), TextLabel (copy), formatOfflineAmount (copy), OFFLINE_ASSETS (copy), v7 (ref) ]]
	if p1 ~= LocalPlayer then
		return
	end

	local v1 = Save.Get()

	v8 = if v1 == nil then 0 else PlayerMoneyPerSecondUtil.GetTotalForProfile(LocalPlayer, v1)
	TextLabel.RichText = true
	TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(math.max(v8, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
	v7()
end))
v6:Add(PlotCmds.OnLocalPlotUpdated:Connect(v7))
v6:Connect(RunService.Heartbeat, v7)