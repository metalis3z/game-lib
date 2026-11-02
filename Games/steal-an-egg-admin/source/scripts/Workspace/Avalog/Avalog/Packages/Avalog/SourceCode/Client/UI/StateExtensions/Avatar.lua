-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local States = require(script.Parent.Parent.States)
local Fusion = require(Parent.Parent.Fusion)
local CatalogItems = require(Parent.SourceCode.Client.UI.StateExtensions.CatalogItems)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
require(Parent.Parent.HumanoidDescriber)
local DeepEquals = require(Parent.SourceCode.Shared.Utils.DeepEquals)
local v1 = {
    _Connections = {}
}

function v1._LogHistoryEntry(v2, v3) -- line 15 | captures: States, Fusion, DeepEquals
    local v4 = Fusion.peek(States.Avatar.DataHistory)
    local v5 = false
    for v6, v7 in ipairs(v4) do
        if DeepEquals(v7, v3) then
            v5 = true
            break
        end
        v5 = false
    end
    if v5 == false then
        table.insert(v4, v3)
        States.Avatar.UndoHistory:set({})
    end
    States.Avatar.DataHistory:set(v4)
end

function v1._UpdateEquippedBundles(v8) -- line 34 | captures: States, Fusion, CatalogItems
    local v9 = Fusion.peek(States.Avatar.EquippedAssetIds)
    local v10 = {}
    for v11, v12 in ipairs(v9) do
        local v13 = CatalogItems:GetBundleIdFromAsset(v12)
        if v13 and table.find(v10, v13) == nil then
            table.insert(v10, v13)
        end
    end
    States.Avatar.EquippedBundleIds:set(v10)
end

function v1._UpdateEquippedAssetIds(v14) -- line 48 | captures: States, Fusion, CatalogItems, ServiceProvider
    local v15 = ServiceProvider:GetAvatarManager()
    local v16 = Fusion.peek(States.Avatar.AssetIds)
    local v17 = {}
    States.Avatar.EquippedAssetIds:set(v16)
    for v18, v19 in ipairs(v16) do
        local v20 = CatalogItems:GetItem(v19, Enum.InfoType.Asset)
        if v20 and v20.AssetType == Enum.AvatarAssetType.EmoteAnimation and v15.HumanoidDescriber:GetEquippedEmote(v20.Name) == nil then
            table.insert(v17, v19)
        end
    end
    for v21, v22 in ipairs(v17) do
        local v23 = table.find(v16, v22)
        if v23 ~= nil then
            table.remove(v16, v23)
        end
    end
    States.Avatar.EquippedAssetIds:set(v16)
end

function v1._HandleAvatar(v24) -- line 74 | captures: States, ServiceProvider
    local v25 = ServiceProvider:GetAvatarManager()
    if v25.Character == nil then
        States.Avatar.Character:set(nil)
        States.Avatar.Loaded:set(false)
        States.Avatar.Data:set(nil)
        States.Avatar.DataHistory:set({})
        States.Avatar.UndoHistory:set({})
        States.Avatar.AssetIds:set({})
        States.Avatar.EquippedAssetIds:set({})
        States.Avatar.EquippedBundleIds:set({})
    else
        States.Avatar.Loaded:set(false)
        local v26 = v25.HumanoidDescriber:GetData()

        local function Update(v27) -- line 94 | captures: v24, v25, States
            States.Avatar.Data:set(v27)
            v24:_LogHistoryEntry(v27)
            States.Avatar.AssetIds:set(v25.HumanoidDescriber:GetAssets())
            v24:_UpdateEquippedAssetIds()
            v24:_UpdateEquippedBundles()
            v25:GetUnownedItems()
        end

        States.Avatar.Character:set(v25.Character)
        v25.HumanoidDescriber.Updated:Connect(function(v28, v29) -- line 107 | captures: Update
            Update(v29)
        end)
        task.spawn(function() -- line 110 | captures: v26, Update
            Update(v26)
        end)
        States.Avatar.Loaded:set(true)
    end
end

local function Stop(v30) -- line 117
    for v31, v32 in ipairs(v30._Connections) do
        v32:Disconnect()
    end
end

v1.Stop = Stop

function v1.Start(v33) -- line 123 | captures: ServiceProvider, v1
    local function v34(v35, ...)
        table.insert(v35, ...)
    end

    local v36 = ServiceProvider:GetAvatarManager()
    v34(v1._Connections, v36.Updated:Connect(function() -- line 127 | captures: v1
        v1:_HandleAvatar()
    end))
    v1:_HandleAvatar()
end

return v1
