-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Categories = require(Parent.SourceCode.Shared.Categories)
local CategoriesToNames = require(Parent.SourceCode.Shared.Categories.CategoriesToNames)
local Navigation = require(Parent.SourceCode.Client.UI.StateExtensions.Navigation)
local Children = Fusion.Children
return function(v1, v2) -- line 13 | captures: OnyxUI, Fusion, States, Categories, CategoriesToNames, Navigation, Children
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { Tabs = require(script.Parent.Tabs) })
    local v4 = OnyxUI.Themer.Theme:now()
    v3:Observer(States.Catalog.Mode):onChange(function() -- line 19 | captures: States
        States.Catalog.Category:set(1)
        States.Catalog.SubCategory:set(1)
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v5 = {
        Name = script.Name,
        ListEnabled = true
    }
    v5.ListPadding = v3:Computed(function(v6) -- line 27 | captures: v4
        return UDim.new(0, v6(v4.Spacing["0"]))
    end)
    v5.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    local v7 = {
        Name = "Categories",
        Options = v3:Computed(function(v8) -- line 35 | captures: Categories, CategoriesToNames, Navigation
            local v9 = v8(Navigation.Mode)
            local v10 = CategoriesToNames(Categories[v9])
            if v9 == "Marketplace" and v10[1] ~= "Featured" then
                table.insert(v10, 1, "Featured")
            end
            return v10
        end),
        Selection = States.Catalog.Category
    }
    v7.Padding = v3:Computed(function(v11) -- line 47 | captures: v4
        return UDim.new(0, v11(v4.Spacing["0.5"]))
    end)
    v7.AutomaticSize = Enum.AutomaticSize.Y
    local v12 = v3:Tabs(v7)
    local v13 = {
        Name = "SubCategories",
        BackgroundTransparency = 0,
        Options = v3:Computed(function(v14) -- line 54 | captures: CategoriesToNames, Navigation
            local v15 = v14(Navigation.Category)
            return CategoriesToNames(v15.SubCategories or {})
        end),
        Selection = States.Catalog.SubCategory
    }
    v13.Padding = v3:Computed(function(v16) -- line 60 | captures: v4
        return UDim.new(0, v16(v4.Spacing["0.5"]))
    end)
    v13.BackgroundColor3 = v4.Colors.Neutral.Main
    v13.AutomaticSize = Enum.AutomaticSize.Y
    v13.Visible = v3:Computed(function(v17) -- line 66 | captures: CategoriesToNames, Navigation
        local v18 = v17(Navigation.Category)
        return #CategoriesToNames(v18.SubCategories or {}) > 0
    end)
    v5[Children] = {
        v12,
        v3:Tabs(v13)
    }
    return v3:Frame(CombineProps(v2, v5))
end
