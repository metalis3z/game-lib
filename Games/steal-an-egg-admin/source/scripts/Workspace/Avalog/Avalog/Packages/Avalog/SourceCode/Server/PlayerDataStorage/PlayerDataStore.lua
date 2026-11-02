-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent
local Squash = require(Parent.Parent.Squash)
local DataValidater = require(script.Parent.DataValidater)
local PlayerDataStore = require(Parent.SourceCode.Storage.Utils.PlayerDataStore)
local AvatarData = require(script.Parent.SerDes.AvatarData)
require(Parent.Parent.HumanoidDescriber)
local v1 = PlayerDataStore({
    name = "AvalogPlayerData",
    pull_delay = 120,
    migrations = {},
    default_data = function() -- default_data | line 17
        return {
            Avatar = { Data = nil }
        }
    end,
    schema = DataValidater
})
local v2 = {}

function v2.SetAvatarData(v3, v4) -- line 29 | captures: Squash, AvatarData
    local v5 = v4 ~= nil
    assert(v5, "Given AvatarData is nil")
    local v6 = Squash.cursor()
    AvatarData.ser(v6, v4)
    v3.Avatar.Data = Squash.tobuffer(v6)
    return v3
end

v1.Store:action(v2.SetAvatarData)
v1.Actions = v2
return v1
