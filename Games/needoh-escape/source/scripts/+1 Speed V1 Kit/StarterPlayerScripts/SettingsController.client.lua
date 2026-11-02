--!strict
-- LOCATION: StarterPlayerScripts/SettingsController
local Players           = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local SoundService       = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local playerGui   = LocalPlayer:WaitForChild("PlayerGui")
local gui         = playerGui:WaitForChild("GUI")
local frames      = gui:WaitForChild("Frames")
local settingsFrame = frames:WaitForChild("Settings")
local mainFrame   = settingsFrame:WaitForChild("Main")

local templates   = ReplicatedStorage:WaitForChild("Templates")
local onOffTemplate  = templates:WaitForChild("OnAndOffTemplate")
local textBoxTemplate = templates:WaitForChild("TextBoxTemplate")

-- "List" under Main is a UIListLayout, not a container — rows get parented
-- directly into Main (the ScrollingFrame), and UIListLayout arranges them.
local list = mainFrame

local SettingConfiguration = require(ReplicatedStorage.Modules.SettingConfiguration)

local events = ReplicatedStorage:WaitForChild("Events")
local saveSetting: RemoteEvent = events:WaitForChild("SaveSetting")

-- Shared flags other LocalScripts can read.
-- SquishCubes / KeysClick check these tables to decide whether to play sounds.
local SettingsState = {
	CubesSoundOff    = false,
	KeyboardSoundOff = false,
	MusicOff         = false,
	Range            = 1.5,
	MaxRange         = 1.5,
}
_G.PlayerSettings = SettingsState

local hiddenStats = LocalPlayer:WaitForChild("HiddenStats")

------------------------------------------------------------------------
-- Sync from server-authoritative HiddenStats values on load + changes
------------------------------------------------------------------------
local function bindBoolStat(name: string)
	local stat = hiddenStats:WaitForChild(name) :: BoolValue
	SettingsState[name] = stat.Value
	stat.Changed:Connect(function(v)
		SettingsState[name] = v
	end)
	return stat
end

local cubesSoundStat    = bindBoolStat("CubesSoundOff")
local keyboardSoundStat = bindBoolStat("KeyboardSoundOff")
local musicOffStat      = bindBoolStat("MusicOff")

local rangeStat = hiddenStats:WaitForChild("Range") :: NumberValue
SettingsState.Range = rangeStat.Value

local maxRangeStat = hiddenStats:WaitForChild("MaxRange") :: NumberValue
SettingsState.MaxRange = maxRangeStat.Value

------------------------------------------------------------------------
-- Background music application
------------------------------------------------------------------------
local function applyMusicSetting(off: boolean)
	local bgm = SoundService:FindFirstChild("Background")
	if bgm and bgm:IsA("Sound") then
		bgm.Volume = off and 0 or 1
	end
end

applyMusicSetting(musicOffStat.Value)
musicOffStat.Changed:Connect(applyMusicSetting)

------------------------------------------------------------------------
-- Build the settings list UI
------------------------------------------------------------------------
-- Clear any pre-existing rows (besides layout objects)
for _, child in ipairs(list:GetChildren()) do
	if child:IsA("Frame") or child:IsA("ImageButton") or child:IsA("TextButton") then
		child:Destroy()
	end
end

local TOGGLE_ON_IMAGE  = "rbxassetid://138835265990110"
local TOGGLE_OFF_IMAGE = "rbxassetid://110859788740064"

local function setupOnOffRow(setting)
	local row = onOffTemplate:Clone()
	row.Name = setting.Id
	row.Visible = true

	local titleLabel = row:FindFirstChild("Title")
	if titleLabel and titleLabel:IsA("TextLabel") then
		titleLabel.Text = setting.Title
	end

	local descLabel = row:FindFirstChild("Desc")
	if descLabel and descLabel:IsA("TextLabel") then
		descLabel.Text = setting.Desc
	end

	local button = row:FindFirstChild("Button")
	local background = button and button:FindFirstChild("Background")
	local textLabel = button and button:FindFirstChild("Text")
	row.Parent = list

	local function getCurrentValue(): boolean
		return SettingsState[setting.Id] == true
	end

	local function refreshVisual()
		local isOff = getCurrentValue()
		if background and (background:IsA("ImageLabel") or background:IsA("ImageButton")) then
			background.Image = isOff and TOGGLE_OFF_IMAGE or TOGGLE_ON_IMAGE
		end
		if textLabel and textLabel:IsA("TextLabel") then
			textLabel.Text = isOff and "OFF" or "ON"
		end
		if button then
			button:SetAttribute("IsOff", isOff)
		end
	end

	refreshVisual()

	if button and (button:IsA("ImageButton") or button:IsA("TextButton")) then
		(button :: any).MouseButton1Click:Connect(function()
			local newValue = not getCurrentValue()
			SettingsState[setting.Id] = newValue
			refreshVisual()
			saveSetting:FireServer(setting.Id, newValue)
		end)
	end

	-- Keep visual synced if server pushes a change (e.g. settings changed elsewhere)
	if setting.Id == "CubesSoundOff" then
		cubesSoundStat.Changed:Connect(refreshVisual)
	elseif setting.Id == "KeyboardSoundOff" then
		keyboardSoundStat.Changed:Connect(refreshVisual)
	elseif setting.Id == "MusicOff" then
		musicOffStat.Changed:Connect(refreshVisual)
	end

	return row
end

local function setupRangeRow(setting)
	local row = textBoxTemplate:Clone()
	row.Name = setting.Id
	row.Visible = true

	local titleLabel = row:FindFirstChild("Title")
	if titleLabel and titleLabel:IsA("TextLabel") then
		titleLabel.Text = setting.Title
	end

	local descLabel = row:FindFirstChild("Desc")
	if descLabel and descLabel:IsA("TextLabel") then
		descLabel.Text = setting.Desc
	end

	local minLabel = row:FindFirstChild("Min") :: TextLabel?
	local maxLabel = row:FindFirstChild("Max") :: TextLabel?

	local function refreshBoundsLabels()
		if minLabel then minLabel.Text = tostring(setting.Min) end
		if maxLabel then maxLabel.Text = tostring(SettingsState.MaxRange) end
	end
	refreshBoundsLabels()

	local amountFrame = row:FindFirstChild("Amount")
	local amountBox = amountFrame and amountFrame:FindFirstChild("TextBox")
	if amountBox and amountBox:IsA("TextBox") then
		amountBox.Text = tostring(SettingsState.Range)

		local function commit()
			local num = tonumber(amountBox.Text)
			if not num then
				amountBox.Text = tostring(SettingsState.Range)
				return
			end
			local minV = setting.Min
			local maxV = SettingsState.MaxRange
			num = math.clamp(num, minV, maxV)
			num = math.floor(num * 100 + 0.5) / 100 -- round to 2 decimals
			amountBox.Text = tostring(num)
			SettingsState.Range = num
			saveSetting:FireServer("EditRange", num)
		end

		amountBox.FocusLost:Connect(function(enterPressed)
			commit()
		end)

		rangeStat.Changed:Connect(function(v)
			SettingsState.Range = v
			if not amountBox:IsFocused() then
				amountBox.Text = tostring(v)
			end
		end)

		-- When the equipped trail changes, MaxRange updates on the server.
		-- Reflect the new bounds in the UI and re-clamp the current value/text.
		maxRangeStat.Changed:Connect(function(v)
			SettingsState.MaxRange = v
			refreshBoundsLabels()
			if not amountBox:IsFocused() then
				local current = tonumber(amountBox.Text) or SettingsState.Range
				local clamped = math.clamp(current, setting.Min, v)
				amountBox.Text = tostring(clamped)
			end
		end)
	end

	row.Parent = list
	return row
end

for _, setting in ipairs(SettingConfiguration.Settings) do
	if setting.Template == "OnAndOffTemplate" then
		setupOnOffRow(setting)
	elseif setting.Template == "TextBoxTemplate" then
		setupRangeRow(setting)
	end
end