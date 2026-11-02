-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Config = require(Parent.Config)
local States = require(Parent.SourceCode.Client.UI.States)
local Categories = require(Parent.SourceCode.Shared.Categories)
local Children = Fusion.Children
local CatalogItemsTab = require(script.Parent.CatalogItemsTab)
local SkinTab = require(script.Parent.SkinTab)
local BuildTab = require(script.Parent.BuildTab)
local EquippedItemsTab = require(script.Parent.EquippedItemsTab)
local InventoryItemsTab = require(script.Parent.InventoryItemsTab)
local PrimaryItemsTab = require(script.Parent.PrimaryItemsTab)
local v1 = {
    CatalogItemsTab = CatalogItemsTab,
    SkinTab = SkinTab,
    BuildTab = BuildTab,
    EquippedItemsTab = EquippedItemsTab,
    InventoryItemsTab = InventoryItemsTab,
    PrimaryItemsTab = PrimaryItemsTab
}
return function(v2, v3) -- line 28 | captures: OnyxUI, Fusion, Config, States, Categories, Children, CatalogItemsTab, SkinTab, BuildTab, EquippedItemsTab, InventoryItemsTab, PrimaryItemsTab, v1
    local v4 = Fusion.innerScope(v2, Fusion, OnyxUI.Util, OnyxUI.Components, {
        CatalogItemsTab = CatalogItemsTab,
        SkinTab = SkinTab,
        BuildTab = BuildTab,
        EquippedItemsTab = EquippedItemsTab,
        InventoryItemsTab = InventoryItemsTab,
        PrimaryItemsTab = PrimaryItemsTab
    })
    local v5 = OnyxUI.Themer.Theme:now()
    local EditModes = Config:Get().EditModes
    local v6 = v4:Computed(function(v7) -- line 40 | captures: EditModes, States
        local v8 = v7(States.Catalog.Mode)
        return EditModes[v8]
    end)
    local v9 = v4:Computed(function(v10) -- line 44 | captures: v6, States, Categories
        local v11 = v10(v6)
        local v12 = v10(States.Catalog.Category)
        return Categories[v11][v12]
    end)
    local v13 = v4:Computed(function(v14) -- line 50 | captures: v6, v9
        local v15 = v14(v6)
        local v16 = v14(v9)
        if v15 == "Marketplace" then
            if v16.Name == "Featured" then
                return "PrimaryItemsTab"
            end
            return "CatalogItemsTab"
        end
        if v15 == "Inventory" then
            return "InventoryItemsTab"
        end
        if v15 == "Customize" and v16 and v16.Name then
            if v16.Name == "Skin" then
                return "SkinTab"
            end
            if v16.Name == "Build" then
                return "BuildTab"
            end
            if v16.Name == "Equipped" then
                return "EquippedItemsTab"
            end
        end
        return nil
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v17 = {
        Name = "Tab",
        FlexMode = Enum.UIFlexMode.Fill
    }
    v17.Padding = v4:Computed(function(v18) -- line 80 | captures: v5
        return UDim.new(0, v18(v5.Spacing["0.75"]))
    end)
    v17.ListEnabled = true
    v17.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v17.ListVerticalFlex = Enum.UIFlexAlignment.Fill
    v17.ClipsDescendants = true
    v17[Children] = {
        v4:Computed(function(v19, v20) -- line 90 | captures: v13, v1
            local v21 = v1[v19(v13)]
            if v21 then
                return v21(v20, { Shown = true })
            end
        end)
    }
    return v4:Frame(CombineProps(v3, v17))
end
