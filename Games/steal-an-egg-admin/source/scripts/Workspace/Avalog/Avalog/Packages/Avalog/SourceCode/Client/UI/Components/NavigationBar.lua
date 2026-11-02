-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Config = require(Parent.Config)
local States = require(Parent.SourceCode.Client.UI.States)
local IconSwap = require(script.Parent.IconSwap)
local Tabs = require(script.Parent.Tabs)
local CategoryBar = require(script.Parent.CategoryBar)
local Sift = require(Parent.Parent.Sift)
local Children = Fusion.Children
local v1 = Config:Get()
local v2 = {
    Marketplace = "rbxassetid://13850201307",
    Inventory = "rbxassetid://13846287045",
    Customize = "rbxassetid://13845862177"
}
return function(v3, v4) -- line 23 | captures: OnyxUI, Fusion, Config, States, IconSwap, Tabs, CategoryBar, Sift, Children, v1, v2
    local v5 = Fusion.innerScope(v3, Fusion, OnyxUI.Util, OnyxUI.Components, {
        Tabs = Tabs,
        CategoryBar = CategoryBar,
        IconSwap = IconSwap
    })
    local v6 = OnyxUI.Themer.Theme:now()
    local EditModes = Config:Get().EditModes
    local v7 = v5:Value("")
    local CombineProps = OnyxUI.Util.CombineProps
    local v8 = {
        Name = script.Name,
        BackgroundColor3 = v6.Colors.Base.Main,
        BackgroundTransparency = 0,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    local v9 = {
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v9.ListPadding = v5:Computed(function(v10) -- line 48 | captures: v6
        return UDim.new(0, v10(v6.Spacing["0.5"]))
    end)
    v9.AutomaticSize = Enum.AutomaticSize.Y
    v9.Padding = v5:Computed(function(v11) -- line 52 | captures: v6
        return UDim.new(0, v11(v6.Spacing["0.25"]))
    end)
    v9.PaddingTop = v5:Computed(function(v12) -- line 55 | captures: v6
        return UDim.new(0, v12(v6.Spacing["0.75"]))
    end)
    local v13 = v5:IconSwap({
        Options = Sift.Array.map(v1.EditModes, function(v14) -- line 61 | captures: v2
            return v2[v14]
        end),
        Selection = States.Catalog.Mode,
        ContentSize = v6.TextSize["1.5"],
        Color = v6.Colors.NeutralContent.Main
    })
    local v15 = {
        PlaceholderText = "Search",
        TextTransparency = 0,
        Color = v6.Colors.NeutralContent.Main
    }
    v15.MaxSize = v5:Computed(function(v16) -- line 71 | captures: v6
        return Vector2.new(v16(v6.Spacing["16"]), (1/0))
    end)
    v15.FlexMode = Enum.UIFlexMode.Fill
    v15.AutomaticSize = Enum.AutomaticSize.XY
    v15.Text = v7
    v15.CornerRadius = v5:Computed(function(v17) -- line 77 | captures: v6
        return UDim.new(0, v17(v6.CornerRadius["1.5"]))
    end)

    function v15.OnFocusLost() -- line 83 | captures: v7, Fusion, States
        States.Catalog.SearchQuery:set(Fusion.peek(v7))
    end

    v9[Children] = {
        v13,
        v5:TextInput(v15)
    }
    v8[Children] = { v5:Frame(v9) }
    return v5:Frame(CombineProps(v4, v8))
end
