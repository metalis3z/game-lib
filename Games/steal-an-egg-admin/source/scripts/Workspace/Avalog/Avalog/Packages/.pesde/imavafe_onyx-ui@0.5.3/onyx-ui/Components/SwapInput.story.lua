-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local v1 = {
    SwapInput = require(Parent.Components.SwapInput),
    Frame = require(Parent.Components.Frame)
}
local v2 = {}

function v2.story(v3) -- line 15 | captures: Fusion, Util, Themer, scoped, Children, v1
    local v4 = scoped(Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = { Parent = v3.target }
    v6.Size = v4:Computed(function(v7) -- line 21 | captures: v5
        return UDim2.fromOffset(v7(v5.Spacing["16"]), 0)
    end)
    v6.AutomaticSize = Enum.AutomaticSize.Y
    v6.Padding = v4:Computed(function(v8) -- line 25 | captures: v5
        return UDim.new(0, v8(v5.StrokeThickness["1"]))
    end)
    v6.ListEnabled = true
    v6.ListPadding = v4:Computed(function(v9) -- line 29 | captures: v5
        return UDim.new(0, v9(v5.Spacing["0.5"]))
    end)
    v6.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v6[Children] = {
        v4:SwapInput({ Options = { "Hamburger", "Pizza", "Ice Cream" } }),
        v4:SwapInput({
            Disabled = true,
            Options = { "Disabled" }
        }),
        v4:SwapInput({
            Options = { "Cats", "Dogs", "Zebras" },
            Color = v5.Colors.Primary.Main
        })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
