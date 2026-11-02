-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local Frame = require(Parent.Components.Frame)
local Card = require(Parent.Components.Card)
local Text = require(Parent.Components.Text)
local v1 = {
    Frame = Frame,
    Divider = require(Parent.Components.Divider),
    Text = Text,
    Card = Card
}
local v2 = {}

function v2.story(v3) -- line 21 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        Size = UDim2.fromOffset(300, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Vertical
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 31 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.75"]))
    end)
    local v8 = v4:Card({
        Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 75)),
        AutomaticSize = Enum.AutomaticSize.None
    })
    local v9 = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ListEnabled = true
    }
    v9.ListPadding = v4:Computed(function(v10) -- line 44 | captures: v5
        return UDim.new(0, v10(v5.Spacing["0.25"]))
    end)
    local v11 = {
        Text = "Title",
        TextSize = v5.TextSize["1.25"]
    }
    v11.FontFace = v4:Computed(function(v12) -- line 52 | captures: v5
        return Font.new(v12(v5.Font.Heading), v12(v5.FontWeight.Heading))
    end)
    v9[Children] = {
        v4:Text(v11),
        v4:Divider({}),
        v4:Text({ Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." })
    }
    v6[Children] = {
        v8,
        v4:Card(v9)
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
