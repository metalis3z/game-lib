-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Sift = require(script.Parent.Parent.Sift)
local v1 = {
    Data = {
        DataStoreEnabled = true,
        AvatarSavingAllowed = true,
        Theme = require(script.Parent.SourceCode.Client.UI.Themes.Dark),
        Featured = {
            Items = {}
        },
        Limits = { Accessories = 10 },
        HiddenCoreGui = { "PlayerList", "Captures", "Emotes", "TouchControls" },
        EditModes = { "Marketplace", "Inventory", "Customize" }
    }
}

function v1.Update(v2, v3) -- line 69 | captures: Sift, v1
    v1.Data = Sift.Dictionary.merge(v1.Data, v3)
end

function v1.Get(v4) -- line 73 | captures: Sift, v1
    return Sift.Dictionary.copyDeep(v1.Data)
end

return v1
