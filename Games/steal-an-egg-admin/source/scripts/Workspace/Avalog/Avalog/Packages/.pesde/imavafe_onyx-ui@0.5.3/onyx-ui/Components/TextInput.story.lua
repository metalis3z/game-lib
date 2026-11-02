-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local scoped = Fusion.scoped
local TextInput = require(script.Parent.TextInput)
local v1 = {
    Frame = require(script.Parent.Frame),
    TextInput = TextInput
}
local v2 = {}

function v2.story(v3) -- line 17 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        Size = UDim2.fromOffset(250, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ListEnabled = true
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 26 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.5"]))
    end)
    v6.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v6.Padding = v4:Computed(function(v8) -- line 30 | captures: v5
        return UDim.new(0, v8(v5.StrokeThickness["1"]))
    end)
    v6[Children] = {
        v4:TextInput({}),
        v4:TextInput({
            PlaceholderText = "Disabled TextInput.",
            Disabled = true
        }),
        v4:TextInput({
            PlaceholderText = "Twenty characters only!",
            CharacterLimit = 20
        }),
        v4:TextInput({
            PlaceholderText = "Something dangerous!",
            Color = v5.Colors.Error.Main
        })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
