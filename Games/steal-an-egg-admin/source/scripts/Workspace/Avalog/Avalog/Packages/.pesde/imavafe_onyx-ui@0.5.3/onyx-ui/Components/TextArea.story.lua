-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local scoped = Fusion.scoped
local v1 = {
    TextArea = require(script.Parent.TextArea),
    Frame = require(script.Parent.Frame)
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
    v6.Padding = v4:Computed(function(v8) -- line 29 | captures: v5
        return UDim.new(0, v8(v5.StrokeThickness["1"]))
    end)
    local v9 = {}
    v9.Size = v4:Computed(function(v10) -- line 35 | captures: v5
        return UDim2.new(UDim.new(1, 0), UDim.new(0, v10(v5.TextSize["1"]) * 2 + v10(v5.Spacing["0.5"]) * 2))
    end)
    v6[Children] = {
        v4:TextArea(v9),
        v4:TextArea({
            CharacterLimit = 60,
            PlaceholderText = "This TextArea has a character limit.",
            Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 100))
        }),
        v4:TextArea({
            PlaceholderText = "This one will expand as you type.",
            Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 0)),
            AutomaticSize = Enum.AutomaticSize.Y
        })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
