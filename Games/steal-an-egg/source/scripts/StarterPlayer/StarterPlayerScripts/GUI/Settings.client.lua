-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local SettingsCmds = require(ReplicatedStorage.Library.Client.SettingsCmds)

require(ReplicatedStorage.Library.Client.SettingsCmds.Types.Interface)

local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local TopBarPlus = require(ReplicatedStorage.Library.Modules.Packages.TopBarPlus)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = Color3.fromRGB(255, 17, 0)
local v2 = Color3.fromRGB(0, 255, 8)
local v3 = TopBarPlus.new()
local ScrollingFrame = GUI.Settings().Frame.Frame.ScrollingFrame

assert(ScrollingFrame:IsA("ScrollingFrame"), "Settings scrolling frame must be a ScrollingFrame")

local t = {}
local t2 = {}
local t3 = {}

local function registerConfiguredSettingRow(p1, p2, p3) --[[ registerConfiguredSettingRow | Line: 42 | Upvalues: ScrollingFrame (copy) ]]
	local v1 = ScrollingFrame:FindFirstChild(p1)

	if v1 and v1:IsA("Frame") then
		return
	end

	local SFX = ScrollingFrame:FindFirstChild("SFX")

	if not (SFX and SFX:IsA("Frame")) then
		return
	end

	local v2 = SFX:Clone()

	v2.Name = p1
	v2.LayoutOrder = p3

	for i, v in ipairs(v2:GetDescendants()) do
		if v:IsA("TextLabel") and v.Name ~= "Status" then
			v.Text = p2

			break
		end
	end

	v2.Parent = ScrollingFrame
end

local function applyVisuals(p1, p2, p3) --[[ applyVisuals | Line: 67 | Upvalues: v2 (copy), v1 (copy) ]]
	p1.BackgroundColor3 = if p3 then v2 else v1
	p2.Text = if p3 then "On" else "Off"
end

local function refresh(p1) --[[ refresh | Line: 72 | Upvalues: SettingsCmds (copy), t2 (copy), v2 (copy), v1 (copy) ]]
	local v12 = SettingsCmds.IsEnabled(p1)
	local v22 = t2[p1]

	if not v22 then
		return
	end

	v22.Button.BackgroundColor3 = if v12 then v2 else v1
	v22.Status.Text = if v12 then "On" else "Off"
end

local function attemptToggle(p1) --[[ attemptToggle | Line: 80 | Upvalues: t (copy), SettingsCmds (copy), t2 (copy), v2 (copy), v1 (copy) ]]
	if t[p1] then
		return
	end

	t[p1] = true

	local v12 = SettingsCmds.Toggle(p1)

	t[p1] = nil

	if v12 then
		return
	end

	local v22 = SettingsCmds.IsEnabled(p1)
	local v3 = t2[p1]

	if not v3 then
		return
	end

	v3.Button.BackgroundColor3 = if v22 then v2 else v1
	v3.Status.Text = if v22 then "On" else "Off"
end

local function registerSettingRow(p1) --[[ registerSettingRow | Line: 94 | Upvalues: ScrollingFrame (copy), t2 (copy), t (copy), SettingsCmds (copy), v2 (copy), v1 (copy) ]]
	local v12 = ScrollingFrame:FindFirstChild(p1)

	if not v12 then
		return
	end

	local Button = v12:FindFirstChild("Button")

	if not (Button and Button:IsA("GuiButton")) then
		return
	end

	local Status = Button:FindFirstChild("Status")

	if Status and Status:IsA("TextLabel") then
		t2[p1] = {
			Button = Button,
			Status = Status
		}
		Button.Activated:Connect(function() --[[ Line: 115 | Upvalues: p1 (copy), t (ref), SettingsCmds (ref), t2 (ref), v2 (ref), v1 (ref) ]]
			local v12 = p1

			if t[v12] then
				return
			end

			t[v12] = true

			local v22 = SettingsCmds.Toggle(v12)

			t[v12] = nil

			if v22 then
				return
			end

			local v3 = SettingsCmds.IsEnabled(v12)
			local v4 = t2[v12]

			if not v4 then
				return
			end

			v4.Button.BackgroundColor3 = if v3 then v2 else v1
			v4.Status.Text = if v3 then "On" else "Off"
		end)
	end
end

local function toggleUI() --[[ toggleUI | Line: 120 | Upvalues: Audio (copy), Constants (copy), TabController (copy) ]]
	Audio.Play(Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND, script, math.random(95, 105) / 100, 1.8)
	TabController.ToggleTab("Settings")
end

local function updateIconEnabled() --[[ updateIconEnabled | Line: 125 | Upvalues: v3 (copy), Variables (copy) ]]
	v3:setEnabled(Variables.Locks.HideUI:IsUnlocked())
end

function t3.Init() --[[ Init | Line: 133 | Upvalues: registerConfiguredSettingRow (copy), registerSettingRow (copy), SettingsCmds (copy), t2 (copy), v2 (copy), v1 (copy), v3 (copy), toggleUI (copy), Variables (copy), updateIconEnabled (copy) ]]
	registerConfiguredSettingRow("Trading", "Trading", 4)
	registerSettingRow("Music")
	registerSettingRow("Trading")
	registerSettingRow("HideOtherPets")
	registerSettingRow("DisableVideos")
	SettingsCmds.Changed:Connect(function(p1, p2) --[[ Line: 142 | Upvalues: t2 (ref), v2 (ref), v1 (ref) ]]
		local v12 = t2[p1]

		if not v12 then
			return
		end

		local v22 = p2 ~= false

		v12.Button.BackgroundColor3 = if v22 then v2 else v1
		v12.Status.Text = if v22 then "On" else "Off"
	end)

	local v12 = SettingsCmds.IsEnabled("Music")
	local Music = t2.Music

	if Music then
		Music.Button.BackgroundColor3 = if v12 then v2 else v1
		Music.Status.Text = if v12 then "On" else "Off"
	end

	local v4 = SettingsCmds.IsEnabled("Trading")
	local Trading = t2.Trading

	if Trading then
		Trading.Button.BackgroundColor3 = if v4 then v2 else v1
		Trading.Status.Text = if v4 then "On" else "Off"
	end

	local v7 = SettingsCmds.IsEnabled("HideOtherPets")
	local HideOtherPets = t2.HideOtherPets

	if HideOtherPets then
		HideOtherPets.Button.BackgroundColor3 = if v7 then v2 else v1
		HideOtherPets.Status.Text = if v7 then "On" else "Off"
	end

	local v10 = SettingsCmds.IsEnabled("DisableVideos")
	local DisableVideos = t2.DisableVideos

	if not DisableVideos then
		v3:setImage(101403250204482):modifyTheme({ "IconImage", "ScaleType", Enum.ScaleType.Fit }):setImageScale(0.8):bindEvent("toggled", toggleUI)
		Variables.Locks.HideUI.Modified:Connect(updateIconEnabled)
		v3:setEnabled(Variables.Locks.HideUI:IsUnlocked())

		return
	end

	DisableVideos.Button.BackgroundColor3 = if v10 then v2 else v1
	DisableVideos.Status.Text = if v10 then "On" else "Off"
	v3:setImage(101403250204482):modifyTheme({ "IconImage", "ScaleType", Enum.ScaleType.Fit }):setImageScale(0.8):bindEvent("toggled", toggleUI)
	Variables.Locks.HideUI.Modified:Connect(updateIconEnabled)
	v3:setEnabled(Variables.Locks.HideUI:IsUnlocked())
end
t3.Init()