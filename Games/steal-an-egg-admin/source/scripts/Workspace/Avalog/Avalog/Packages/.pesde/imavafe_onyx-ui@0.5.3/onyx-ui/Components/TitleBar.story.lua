-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local scoped = Fusion.scoped
local TitleBar = require(Parent.Components.TitleBar)
local v1 = {
    Frame = require(Parent.Components.Frame),
    TitleBar = TitleBar
}
local v2 = {}

function v2.story(v3) -- line 17 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = { Parent = v3.target }
    v6.Padding = v4:Computed(function(v7) -- line 23 | captures: v5
        return UDim.new(0, v7(v5.StrokeThickness["1"]))
    end)
    v6.Size = v4:Computed(function(v8) -- line 26 | captures: v5
        return UDim2.fromOffset(v8(v5.Spacing["16"]), 0)
    end)
    v6.AutomaticSize = Enum.AutomaticSize.Y
    v6.ListEnabled = true
    v6.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v6[Children] = {
        v4:TitleBar({ Content = { "Title" } }),
        v4:TitleBar({ Content = { "rbxassetid://75029721407761", "Shop" } })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
