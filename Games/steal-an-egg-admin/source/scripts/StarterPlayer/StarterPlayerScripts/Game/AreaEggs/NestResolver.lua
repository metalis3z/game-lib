-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local t = require(ReplicatedStorage.Packages.t)
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local GuardAreas = Areas.GuardAreas
local Folder_3 = GuardAreas:IsA("Folder")
assert(Folder_3, "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")
local v1 = {}

function v1.Resolve(v2) -- line 21 | captures: AreaEggSlotIdentity, t, GuardAreas
    t.strict(t.string)(v2.AreaId)
    t.strict(t.string)(v2.NestId)
    local v3 = GuardAreas[v2.AreaId]
    local Model = v3:IsA("Model")
    local v4 = ("Guard area %* must be a Model"):format(v2.AreaId)
    assert(Model, v4)
    return AreaEggSlotIdentity.NestFor(v3, v2.NestId)
end

return v1
