-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local AvatarEditorService = game:GetService("AvatarEditorService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Navigation = require(Parent.SourceCode.Client.UI.StateExtensions.Navigation)
local States = require(Parent.SourceCode.Client.UI.States)
local Inventory = require(Parent.SourceCode.Client.UI.StateExtensions.Inventory)
return function(v1, v2) -- line 14 | captures: AvatarEditorService, OnyxUI, Fusion, Navigation, States, Inventory
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { ItemsTab = require(script.Parent.ItemsTab) })
    local v4 = OnyxUI.Util.Fallback(v2.Shown, false)
    local v5 = v3:Computed(function(v6) -- line 21 | captures: Navigation
        local v7 = v6(Navigation.Category)
        local v8 = v6(Navigation.SubCategory)
        if v8 == nil then
            return v7
        end
        return v8
    end)
    local v9 = v3:Computed(function(v10) -- line 31 | captures: v5
        local v11 = v10(v5)
        if not (v11 and v11.AssetTypes) then
            return {}
        end
        return v11.AssetTypes
    end)
    local v12 = v3:Value(nil)
    local v13 = v3:Value({})

    local function UpdateSearch() -- line 44 | captures: v4, v9, v12, v13, Fusion, States, Inventory
        if not (Fusion.peek(v4) and Fusion.peek(States.Inventory.AccessAllowed)) then
            return
        end
        local v14 = Fusion.peek(v9)
        local v15 = Inventory.Search(v14)
        v15.Updated:Connect(function() -- line 56 | captures: v15, v13
            v13:set(v15.Results)
        end)
        v12:set(v15)
        v13:set(v15.Results)
    end

    v3:Observer(v9):onChange(function() -- line 63 | captures: UpdateSearch
        UpdateSearch()
    end)
    v3:Observer(States.Inventory.AccessAllowed):onChange(function() -- line 66 | captures: UpdateSearch
        UpdateSearch()
    end)
    UpdateSearch()
    local v16 = v3:ForValues(v13, function(v17, v18, v19) -- line 71 | captures: States
        local v20 = v17(States.Catalog.SearchQuery)
        if not (utf8.len(v20) > 0 and string.find(string.lower(v19.Name), string.lower(v20), 1, true) == nil) then
            return v19
        end
        return nil
    end)

    local function CheckInventoryAccess() -- line 84 | captures: v4, AvatarEditorService, Fusion, States
        local v21 = Fusion.peek(v4)
        local v22 = Fusion.peek(States.Inventory.AccessAllowed)
        if v21 and not v22 then
            AvatarEditorService:PromptAllowInventoryReadAccess()
        end
    end

    local v23 = Fusion.peek(v4)
    local v24 = Fusion.peek(States.Inventory.AccessAllowed)
    if v23 and not v24 then
        AvatarEditorService:PromptAllowInventoryReadAccess()
    end
    AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Connect(function(v25) -- line 95 | captures: v4, Fusion, States
        local v26 = Fusion.peek(v4)
        local v27 = Fusion.peek(States.Catalog.Mode)
        if v26 and v25 ~= Enum.AvatarPromptResult.Success then
            States.Catalog.Mode:set(v27 + 1)
        end
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v28 = { Name = script.Name }
    v28.Items = v3:ForValues(v16, function(v29, v30, v31) -- line 106
        return {
            Owned = true,
            Id = v31.AssetId,
            Type = Enum.AvatarItemType.Asset
        }
    end)

    function v28.OnReachedEnd() -- line 113 | captures: v12, Fusion
        local v32 = Fusion.peek(v12)
        if v32 ~= nil then
            v32:LoadNextPage()
        end
    end

    return v3:ItemsTab(CombineProps(v2, v28))
end
