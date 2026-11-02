-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local CatalogSearch = require(Parent.SourceCode.Client.UI.StateExtensions.CatalogSearch)
local Navigation = require(Parent.SourceCode.Client.UI.StateExtensions.Navigation)
local States = require(Parent.SourceCode.Client.UI.States)
local Sift = require(Parent.Parent.Sift)
return function(v1, v2) -- line 15 | captures: OnyxUI, Fusion, CatalogSearch, Navigation, States, Sift
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { ItemsTab = require(script.Parent.ItemsTab) })
    local v4 = OnyxUI.Util.Fallback(v2.Shown, false)
    local v5 = OnyxUI.Util.Fallback(v2.PrefixItems, {})
    local v6 = OnyxUI.Util.Fallback(v2.LoadItems, true)
    local v7 = v3:Computed(function(v8) -- line 24 | captures: Navigation
        local v9 = v8(Navigation.Category)
        local v10 = v8(Navigation.SubCategory)
        if v10 == nil then
            return v9
        end
        return v10
    end)
    local v11 = v3:Computed(function(v12) -- line 34 | captures: v7
        local v13 = v12(v7)
        if not (v13 and v13.BundleTypes) then
            return {}
        end
        return v13.BundleTypes
    end)
    local v14 = v3:Computed(function(v15) -- line 43 | captures: v7
        local v16 = v15(v7)
        if not (v16 and v16.AssetTypes) then
            return {}
        end
        return v16.AssetTypes
    end)
    local v17 = v3:Value(nil)
    local v18 = v3:Value({})

    local function UpdateSearch() -- line 56 | captures: v4, v6, v7, v11, v14, v17, v18, Fusion, CatalogSearch, States
        if not (Fusion.peek(v4) and Fusion.peek(v6)) then
            return
        end
        local v19 = Fusion.peek(v11)
        local v20 = Fusion.peek(v14)
        local v21 = Fusion.peek(States.Catalog.SearchQuery)
        local v22 = Fusion.peek(v7)
        local v23 = v21 or ""
        local v24 = string.len(v23) == 0
        local Search = CatalogSearch.Search
        local v25 = {
            BundleTypes = v19,
            AssetTypes = v20,
            SearchKeyword = v21
        }
        v25.CategoryFilter = v24 and v22.CategoryFilter or nil
        local v26 = Search(v25)
        v26.Updated:Connect(function() -- line 78 | captures: v26, v18
            v18:set(v26.Results)
        end)
        v17:set(v26)
        v18:set(v26.Results)
    end

    v3:Observer(v11):onChange(function() -- line 85 | captures: UpdateSearch
        UpdateSearch()
    end)
    v3:Observer(v14):onChange(function() -- line 88 | captures: UpdateSearch
        UpdateSearch()
    end)
    v3:Observer(States.Catalog.SearchQuery):onChange(function() -- line 91 | captures: UpdateSearch
        UpdateSearch()
    end)
    UpdateSearch()
    local v27 = v3:Computed(function(v28) -- line 96 | captures: v5, v18, States, Sift
        local v29 = v28(v18)
        local v30 = v28(v5)
        local v31 = v28(States.Catalog.SearchQuery)
        if v31 == nil or v31 == "" then
            return Sift.Array.concat(v30, v29)
        end
        return v29
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v32 = { Name = script.Name }
    v32.Items = v3:ForValues(v27, function(v33, v34, v35) -- line 110
        local ItemType = v35.ItemType
        if typeof(ItemType) == "string" then
            v35.ItemType = Enum.AvatarItemType[v35.ItemType]
        end
        return {
            Id = v35.Id,
            Type = v35.ItemType,
            Featured = v35.Featured
        }
    end)

    function v32.OnReachedEnd() -- line 122 | captures: v17, Fusion
        local v36 = Fusion.peek(v17)
        if v36 ~= nil then
            v36:LoadNextPage()
        end
    end

    return v3:ItemsTab(CombineProps(v2, v32))
end
