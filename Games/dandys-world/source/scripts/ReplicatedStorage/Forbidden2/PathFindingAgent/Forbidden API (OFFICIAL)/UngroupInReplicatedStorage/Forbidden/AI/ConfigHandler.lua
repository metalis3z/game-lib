--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
require(script.Parent.Types)

local Tables = require(script.Parent.Parent.Libraries.Tables)
local Defaults = require(script.Defaults)
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}

local function RemoveMetatable(p1) --[[ RemoveMetatable | Line: 29 | Upvalues: Tables (copy) ]]
	Tables.RemoveMetatable(p1)
end

local function AddMetatable(p1) --[[ AddMetatable | Line: 36 | Upvalues: Tables (copy) ]]
	Tables.LockKeyInTable(p1, "NPC")
end

local v1 = nil

local function InitializeConfig(p1) --[[ InitializeConfig | Line: 46 | Upvalues: t3 (copy), v1 (ref), t2 (copy), Tables (copy), t5 (copy) ]]
	if not t3[p1] then
		local v12 = v1(p1)

		t3[p1] = v12
		t2[p1] = Tables.DeepCopy(v12)
		t5[p1] = {}
	end
end

local function CreateCleanConfig(p1) --[[ CreateCleanConfig | Line: 59 | Upvalues: Tables (copy) ]]
	local v1 = Tables.DeepCopy(p1)

	Tables.RemoveMetatable(v1)
	v1.NPC = nil

	return v1
end

function RestoreDefaults(p1) --[[ RestoreDefaults | Line: 92 | Upvalues: Tables (copy), Defaults (copy) ]]
	Tables.RemoveMetatable(p1)
	Tables.DeepCopyPaste(Defaults, p1)
	p1.NPC = p1.NPC
	Tables.LockKeyInTable(p1, "NPC")
end
function RestoreActiveConfig(p1) --[[ RestoreActiveConfig | Line: 127 | Upvalues: t3 (copy), Tables (copy), t2 (copy) ]]
	Tables.RemoveMetatable(t3[p1.NPC])
	Tables.DeepCopyPaste(t2[p1.NPC], t3[p1.NPC])
	Tables.LockKeyInTable(t3[p1.NPC], "NPC")
end
function SavePreset(p1, p2, p3) --[[ SavePreset | Line: 163 | Upvalues: t (copy), Tables (copy), t5 (copy) ]]
	if p2 == "" or p2 == nil then
		warn("Preset name cannot be nil or empty.")

		return
	end

	if p3 then
		t.SaveGlobalPreset(p2, p1)

		return
	end

	local v1 = Tables.DeepCopy(p1)

	Tables.RemoveMetatable(v1)
	v1.NPC = nil

	if p3 then
		return
	end

	t5[p1.NPC][p2] = v1
end
function LoadPreset(p1, p2, p3) --[[ LoadPreset | Line: 213 | Upvalues: t5 (copy), t4 (copy), Tables (copy), t3 (copy) ]]
	if p2 == nil or p2 == "" then
		warn("Preset name cannot be nil or empty.")

		return
	end

	local v1 = t5[p1.NPC][p2]
	local v2 = t4[p2]
	local v3 = if p3 then if v2 then v2 else v1 else v1

	if not v1 then
		v3 = v2
	end

	if v3 then
		local v4 = Tables.DeepCopy(v3)

		v4.NPC = p1.NPC
		Tables.RemoveMetatable(t3[p1.NPC])
		Tables.DeepCopyPaste(v4, p1)
		Tables.LockKeyInTable(p1, "NPC")
	else
		warn((("Preset \'%*\' does not exist locally or globally."):format(p2)))
	end
end
function ApplyNow(p1) --[[ ApplyNow | Line: 280 | Upvalues: Tables (copy), t3 (copy), t2 (copy) ]]
	if not p1.NPC then
		error("Cannot apply config to NPC, NPC field is nil.")
	end

	Tables.DeepCopyPaste(t3[p1.NPC], t2[p1.NPC])
end
v1 = function(p1) --[[ Line: 291 | Upvalues: Tables (copy), Defaults (copy) ]]
	local v1 = Tables.DeepCopy(Defaults)

	v1.NPC = p1
	function v1.SavePreset(p1, p2, p3) --[[ SavePreset | Line: 298 ]]
		SavePreset(p1, p2, p3)
	end
	function v1.LoadPreset(p1, p2, p3) --[[ LoadPreset | Line: 299 ]]
		LoadPreset(p1, p2, p3)
	end
	function v1.RestoreDefaults(p1) --[[ RestoreDefaults | Line: 300 ]]
		RestoreDefaults(p1)
	end
	function v1.RestoreActiveConfig(p1) --[[ RestoreActiveConfig | Line: 301 ]]
		RestoreActiveConfig(p1)
	end
	function v1.ApplyNow(p1) --[[ ApplyNow | Line: 302 ]]
		ApplyNow(p1)
	end
	Tables.LockKeyInTable(v1, "NPC")

	return v1
end
function t.SaveGlobalPreset(p1, p2) --[[ Line: 339 | Upvalues: Tables (copy), t4 (copy) ]]
	if p1 == "" or p1 == nil then
		warn("Preset name cannot be nil or empty.")
	else
		local v1 = Tables.DeepCopy(p2)

		Tables.RemoveMetatable(v1)
		v1.NPC = nil
		t4[p1] = v1
	end
end
function t.GetConfig(p1) --[[ Line: 386 | Upvalues: t3 (copy), v1 (ref), t2 (copy), Tables (copy), t5 (copy) ]]
	if not (t3[p1] or t3[p1]) then
		local v12 = v1(p1)

		t3[p1] = v12
		t2[p1] = Tables.DeepCopy(v12)
		t5[p1] = {}
	end

	return t3[p1]
end
function t.GetActiveConfig(p1) --[[ Line: 421 | Upvalues: t2 (copy), t3 (copy), v1 (ref), Tables (copy), t5 (copy) ]]
	if not (t2[p1] or t3[p1]) then
		local v12 = v1(p1)

		t3[p1] = v12
		t2[p1] = Tables.DeepCopy(v12)
		t5[p1] = {}
	end

	return t2[p1]
end
function t.TriggerCleanup(p1) --[[ Line: 430 | Upvalues: t2 (copy), t3 (copy), t5 (copy) ]]
	t2[p1] = nil
	t3[p1] = nil
	t5[p1] = nil
end

return t