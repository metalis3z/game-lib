-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
require(script.Parent.ItemsTab)
return function(v1, v2) -- line 10 | captures: OnyxUI, Fusion, States
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, {
        ItemButton = require(script.Parent.ItemButton),
        ItemsTab = require(script.Parent.ItemsTab)
    })
    OnyxUI.Util.Fallback(v2.Shown, false)
    local v4 = v3:Value({})

    local function UpdateAssetIds() -- line 20 | captures: v4, Fusion, States
        local v5 = Fusion.peek(States.Avatar.EquippedAssetIds)
        v4:set(v5)
    end

    v4:set((Fusion.peek(States.Avatar.EquippedAssetIds)))
    v3:Observer(States.Avatar.Loaded):onChange(function() -- line 27 | captures: v4, Fusion, States
        local v6 = Fusion.peek(States.Avatar.EquippedAssetIds)
        v4:set(v6)
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v7 = { Name = script.Name }
    v7.Items = v3:ForValues(v4, function(v8, v9, v10) -- line 33
        return {
            Id = v10,
            Type = Enum.AvatarItemType.Asset
        }
    end)
    return v3:ItemsTab(CombineProps(v2, v7))
end
