-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local Frame = require(Parent.Components.Frame)
local Divider = require(Parent.Components.Divider)
local v1 = {
    Frame = Frame,
    Text = require(Parent.Components.Text),
    Divider = Divider
}
local v2 = {}

function v2.story(v3) -- line 19 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        Size = UDim2.fromOffset(300, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Vertical
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 29 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.5"]))
    end)
    v6[Children] = {
        v4:Text({ Text = "Some top content.." }),
        v4:Divider({ FillDirection = Enum.FillDirection.Horizontal }),
        v4:Text({ Text = "And some bottom content too." })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
