-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Modules = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Modules")
local FFlags = require(Modules.FFlags)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	Options = FFlags.Options,
	Keys = FFlags.Keys,
	currentData = {},
	currentDataSaved = {}
}
local t2 = {}

function t.BulkGet(p1, p2, p3) --[[ BulkGet | Line: 21 ]]
	return true
end
function t.Get(p1) --[[ Get | Line: 48 | Upvalues: FFlags (copy), t (copy) ]]
	local v1 = assert(p1.Key, "Key must be provided to FastFlags.Get()")

	if typeof(v1) ~= "string" then
		error("Key must be string (was \'" .. typeof(v1) .. "\')")
	end

	local v2 = FFlags.Options[v1]

	if not v2 then
		error("Missing Key: " .. v1)
	end

	local v3 = t.currentData[v1]

	if v3 == nil and not v2.Nullable then
		v3 = v2.Default
	end

	return v3
end
function t.CanBypass(p1) --[[ CanBypass | Line: 64 | Upvalues: t (copy), Players (copy), Asserts (copy), t2 (copy), FFlags (copy) ]]
	if not t.Keys.AdminFFlagBypass and t.Get(t.Keys.AdminFFlagBypass) then
		return false
	end

	local v1 = if p1 then p1 else Players.LocalPlayer

	Asserts.Player(v1)
	assert(v1, "luau")

	if t2[v1] ~= nil then
		return t2[v1]
	end

	local v2 = FFlags.Admins[v1.UserId] and true or false

	t2[v1] = v2

	return v2
end

return t