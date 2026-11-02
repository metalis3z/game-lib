-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Children = Fusion.Children
local scoped = Fusion.scoped
local MenuFrame = require(script.Parent.MenuFrame)
local Frame = require(script.Parent.Frame)
local v1 = {
    MenuFrame = MenuFrame,
    Text = require(script.Parent.Text),
    Frame = Frame
}
local v2 = {}

function v2.story(v3) -- line 19 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = { Parent = v3.target }
    v6.Padding = v4:Computed(function(v7) -- line 25 | captures: v5
        return UDim.new(0, v7(v5.StrokeThickness["1"]))
    end)
    v6.ListEnabled = true
    v6.ListFillDirection = Enum.FillDirection.Horizontal
    local v8 = {
        Parent = v3.target,
        Size = UDim2.fromOffset(300, 200),
        AutomaticSize = Enum.AutomaticSize.None
    }
    v8[Children] = { v4:Text({ Text = "Here's a MenuFrame with some text in it." }) }
    v6[Children] = { v4:MenuFrame(v8) }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
