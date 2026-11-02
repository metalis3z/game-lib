-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local Heading = require(script.Parent.Heading)
local Frame = require(script.Parent.Frame)
local v1 = {
    Heading = Heading,
    Text = require(script.Parent.Text),
    Frame = Frame
}
local v2 = {}

function v2.story(v3) -- line 19 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        ListEnabled = true
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 26 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.5"]))
    end)
    v6[Children] = {
        v4:Heading({
            Text = "Heading",
            Parent = v3.target
        }),
        v4:Text({ Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
