-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local scoped = Fusion.scoped
local Children = Fusion.Children
local v1 = {
    IconButton = require(script.Parent.IconButton),
    Frame = require(script.Parent.Frame)
}
local v2 = {}

function v2.story(v3) -- line 18 | captures: Fusion, Themer, Util, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = { Parent = v3.target }
    v6.Padding = v4:Computed(function(v7) -- line 24 | captures: v5
        return UDim.new(0, v7(v5.StrokeThickness["1"]))
    end)
    v6.ListEnabled = true
    v6.ListFillDirection = Enum.FillDirection.Horizontal
    v6.ListPadding = v4:Computed(function(v8) -- line 29 | captures: v5
        return UDim.new(0, v8(v5.Spacing["0.5"]))
    end)
    v6[Children] = {
        v4:IconButton({ Image = "rbxassetid://10814531047" }),
        v4:IconButton({
            Image = "rbxassetid://10814531047",
            Color = v5.Colors.Primary.Main
        }),
        v4:IconButton({
            Image = "rbxassetid://11560341132",
            Color = Util.Colors.Amber["500"]
        }),
        v4:IconButton({
            Image = "rbxassetid://13405228418",
            Style = "Outlined",
            Color = Util.Colors.Red["500"]
        }),
        v4:IconButton({
            Image = "rbxassetid://13405228418",
            Style = "Ghost",
            Color = Util.Colors.Red["500"]
        }),
        v4:IconButton({
            Image = "rbxassetid://10814531047",
            Disabled = true
        }),
        v4:IconButton({
            Image = "rbxassetid://10814531047",
            Style = "Ghost",
            Disabled = true
        })
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
