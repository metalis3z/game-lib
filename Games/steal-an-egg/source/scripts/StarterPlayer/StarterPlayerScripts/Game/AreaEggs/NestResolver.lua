-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

require(ReplicatedStorage.Library.Types.AreaEggs)

local AreaEggSlotIdentity = require(ReplicatedStorage.Library.Util.AreaEggSlotIdentity)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local GuardAreas = Areas.GuardAreas

assert(GuardAreas:IsA("Folder"), "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")

return {
	Resolve = function(p1) --[[ Resolve | Line: 41 | Upvalues: Asserts (copy), GuardAreas (copy), AreaEggSlotIdentity (copy) ]]
		Asserts.string(p1.AreaId)
		Asserts.string(p1.NestId)

		local v1 = GuardAreas[p1.AreaId]
		local v2 = v1:IsA("Model")

		assert(v2, (("Guard area %* must be a Model"):format(p1.AreaId)))

		return AreaEggSlotIdentity.ResolveNest(v1, p1.NestId)
	end
}