-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local v1 = {
    Frame = require(Parent.Components.Frame),
    Image = require(Parent.Components.Image)
}
local v2 = {}

function v2.story(v3) -- line 17 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        AutomaticSize = Enum.AutomaticSize.XY,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 26 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.75"]))
    end)
    v6[Children] = {
        v4:Image({ Image = "rbxassetid://15307540148" }),
        v4:Image({}),
        v4:Image({ FallbackImage = "rbxassetid://13193902400" })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
