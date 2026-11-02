-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage").Library
local t = require(Library.Modules.Packages.t)
local InstanceCheck = require(Library.Functions.InstanceCheck)
local CoreProfileManager = require(Library.Modules.CoreProfileManager)
local v1 = t.tuple(t.table, t.optional(t.table))

local function GetIndexMethod(p1, p2, p3, p4) --[[ GetIndexMethod | Line: 29 | Upvalues: CoreProfileManager (copy), InstanceCheck (copy) ]]
	local _profileManager = p1._profileManager

	if _profileManager and CoreProfileManager.is(_profileManager) then
		return _profileManager:Get(p3)
	end

	if InstanceCheck(p3, "Player") then
		local UserId = p3.UserId
		local v1 = if p4.GetPlayerInstance and p3 then p3 else p4.StringUserId and tostring(UserId) or UserId

		return if v1 then p2[v1] else v1
	end

	if typeof(p3) ~= "number" and typeof(p3) ~= "string" then
		return
	end

	return p2[p3]
end

return function(p1, p2) --[[ Line: 48 | Upvalues: v1 (copy), GetIndexMethod (copy) ]]
	if v1(p1, p2) then
		return function(p12, p22, ...) --[[ Line: 53 | Upvalues: p2 (copy), GetIndexMethod (ref), p1 (copy) ]]
			local v1 = if p2.AutoDestroyIfNoIndex and not p22 then "Destroy" else p22

			if typeof(v1) ~= "string" then
				return
			end

			local v2 = GetIndexMethod(p1, p2.ProfileContainer, p12, p2)

			if typeof(v2) == "table" then
				return v2[v1](v2, ...)
			end

			return
		end
	end
end