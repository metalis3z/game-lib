-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.Event)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Save = require(ReplicatedStorage.Library.Client.Save)

require(script.Types.Interface)

local Variables = require(ReplicatedStorage.Library.Shared.Variables)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Settings = Network.NET_MAP.Settings

assert(Settings, "Settings network map is not configured")

local SettingsInfo = Variables.SettingsInfo
local LocalPlayer = Players.LocalPlayer
local t = {}
local v2 = v1.new()
local t2 = {}

local function getDefault(p1) --[[ getDefault | Line: 37 | Upvalues: SettingsInfo (copy) ]]
	local v1 = SettingsInfo[p1]
	local v2 = if v1 then v1.default else v1

	if typeof(v2) == "boolean" then
		return v2
	end

	return true
end

local function sanitizeValue(p1, p2) --[[ sanitizeValue | Line: 46 | Upvalues: SettingsInfo (copy) ]]
	if typeof(p2) == "boolean" then
		return p2
	end

	local v1 = SettingsInfo[p1]
	local v2 = if v1 then v1.default else v1

	if typeof(v2) == "boolean" then
		return v2
	end

	return true
end

local function applySetting(p1, p2) --[[ applySetting | Line: 53 | Upvalues: SettingsInfo (copy), t (copy), v2 (copy) ]]
	local v1

	if typeof(p2) == "boolean" then
		v1 = p2
	else
		local v22 = SettingsInfo[p1]
		local v3 = if v22 then v22.default else v22

		v1 = if typeof(v3) == "boolean" then v3 else true
	end

	local v4 = t[p1]

	t[p1] = v1

	if v4 ~= v1 then
		v2:FireAsync(p1, v1)
	end
end

local function applySettingsMap(p1) --[[ applySettingsMap | Line: 63 | Upvalues: SettingsInfo (copy), t (copy), v2 (copy) ]]
	local v1 = if p1 then p1 else {}

	for k in pairs(SettingsInfo) do
		local v22
		local v3 = v1[k]

		if typeof(v3) == "boolean" then
			v22 = v3
		else
			local v4 = SettingsInfo[k]
			local v5 = if v4 then v4.default else v4

			v22 = if typeof(v5) == "boolean" then v5 else true
		end

		local v6 = t[k]

		t[k] = v22

		if v6 ~= v22 then
			v2:FireAsync(k, v22)
		end
	end
end

local function hydrateFromSave() --[[ hydrateFromSave | Line: 70 | Upvalues: Save (copy), applySettingsMap (copy) ]]
	local v1 = Save.Get()

	if not v1 then
		return
	end

	local Settings = v1.Settings

	if typeof(Settings) == "table" then
		applySettingsMap(Settings)
	else
		applySettingsMap(nil)
	end
end

local function validateSettingKey(p1) --[[ validateSettingKey | Line: 85 | Upvalues: Asserts (copy), SettingsInfo (copy) ]]
	Asserts.string(p1)

	if SettingsInfo[p1] then
		return
	end

	error(("Unknown setting key \'%*\'"):format(p1), 3)
end

function t2.GetValue(p1) --[[ GetValue | Line: 96 | Upvalues: Asserts (copy), SettingsInfo (copy), t (copy) ]]
	Asserts.string(p1)

	if not SettingsInfo[p1] then
		error(("Unknown setting key \'%*\'"):format(p1), 3)
	end

	local v1 = t[p1]

	if v1 ~= nil then
		return v1
	end

	local v2 = SettingsInfo[p1]
	local v3 = if v2 then v2.default else v2

	if typeof(v3) == "boolean" then
		return v3
	end

	return true
end
function t2.IsEnabled(p1) --[[ IsEnabled | Line: 105 | Upvalues: t2 (copy) ]]
	return t2.GetValue(p1) ~= false
end
function t2.Get(p1) --[[ Get | Line: 109 | Upvalues: Asserts (copy), SettingsInfo (copy), t2 (copy) ]]
	Asserts.string(p1)

	if not SettingsInfo[p1] then
		error(("Unknown setting key \'%*\'"):format(p1), 3)
	end

	local v2 = t2.GetValue(p1)
	local options = SettingsInfo[p1].options

	if typeof(options) == "table" then
		return options[v2]
	end

	return v2
end
function t2.Set(p1, p2) --[[ Set | Line: 120 | Upvalues: Asserts (copy), SettingsInfo (copy), wcall (copy), Network (copy), Settings (copy), applySettingsMap (copy), t (copy), v2 (copy) ]]
	Asserts.string(p1)

	if not SettingsInfo[p1] then
		error(("Unknown setting key \'%*\'"):format(p1), 3)
	end

	Asserts.boolean(p2)

	local v1, v22, v3 = wcall(Network.Invoke, Settings.REQUEST_UPDATE, p1, p2)

	if not v1 then
		return false
	end

	if not v22 then
		return false
	end

	if typeof(v3) == "table" then
		applySettingsMap(v3)
	else
		local v4

		if typeof(p2) == "boolean" then
			v4 = p2
		else
			local v5 = SettingsInfo[p1]
			local v6 = if v5 then v5.default else v5

			v4 = if typeof(v6) == "boolean" then v6 else true
		end

		local v7 = t[p1]

		t[p1] = v4

		if v7 == v4 then
			return true
		end

		v2:FireAsync(p1, v4)
	end

	return true
end
function t2.Toggle(p1) --[[ Toggle | Line: 143 | Upvalues: t2 (copy) ]]
	return t2.Set(p1, not t2.IsEnabled(p1))
end
t2.Changed = v2
applySettingsMap(nil)

if LocalPlayer then
	Save.LoadedStats:Connect(function(p1) --[[ Line: 156 | Upvalues: LocalPlayer (copy), Save (copy), applySettingsMap (copy) ]]
		if p1 ~= LocalPlayer then
			return
		end

		local v1 = Save.Get()

		if not v1 then
			return
		end

		local Settings = v1.Settings

		if typeof(Settings) ~= "table" then
			applySettingsMap(nil)

			return
		end

		applySettingsMap(Settings)
	end)
end

Save.GetStatChangedSignal("Settings"):Connect(hydrateFromSave)

if not Save.IsLocalDataLoaded() then
	Network.Fired(Settings.SETTING_CHANGED):Connect(function(p1, p2) --[[ Line: 169 | Upvalues: SettingsInfo (copy), t (copy), v2 (copy) ]]
		if typeof(p1) ~= "string" then
			return
		end

		if not SettingsInfo[p1] then
			return
		end

		local v1

		if typeof(p2) == "boolean" then
			v1 = p2
		else
			local v22 = SettingsInfo[p1]
			local v3 = if v22 then v22.default else v22

			v1 = if typeof(v3) == "boolean" then v3 else true
		end

		local v4 = t[p1]

		t[p1] = v1

		if v4 ~= v1 then
			v2:FireAsync(p1, v1)
		end
	end)

	return t2
end

local v3 = Save.Get()

if not v3 then
	Network.Fired(Settings.SETTING_CHANGED):Connect(function(p1, p2) --[[ Line: 169 | Upvalues: SettingsInfo (copy), t (copy), v2 (copy) ]]
		if typeof(p1) ~= "string" then
			return
		end

		if not SettingsInfo[p1] then
			return
		end

		local v1

		if typeof(p2) == "boolean" then
			v1 = p2
		else
			local v22 = SettingsInfo[p1]
			local v3 = if v22 then v22.default else v22

			v1 = if typeof(v3) == "boolean" then v3 else true
		end

		local v4 = t[p1]

		t[p1] = v1

		if v4 ~= v1 then
			v2:FireAsync(p1, v1)
		end
	end)

	return t2
end

local Settings2 = v3.Settings

if typeof(Settings2) == "table" then
	applySettingsMap(Settings2)
else
	applySettingsMap(nil)
end

Network.Fired(Settings.SETTING_CHANGED):Connect(function(p1, p2) --[[ Line: 169 | Upvalues: SettingsInfo (copy), t (copy), v2 (copy) ]]
	if typeof(p1) ~= "string" then
		return
	end

	if not SettingsInfo[p1] then
		return
	end

	local v1

	if typeof(p2) == "boolean" then
		v1 = p2
	else
		local v22 = SettingsInfo[p1]
		local v3 = if v22 then v22.default else v22

		v1 = if typeof(v3) == "boolean" then v3 else true
	end

	local v4 = t[p1]

	t[p1] = v1

	if v4 ~= v1 then
		v2:FireAsync(p1, v1)
	end
end)

return t2