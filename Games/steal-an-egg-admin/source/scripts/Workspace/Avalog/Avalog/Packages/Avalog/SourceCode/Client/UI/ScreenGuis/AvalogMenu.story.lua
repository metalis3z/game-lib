-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local OnyxUI = require(Parent.Parent.OnyxUI)
local States = require(Parent.SourceCode.Client.UI.States)
local StateExtensions = require(Parent.SourceCode.Client.UI.StateExtensions)
local Dark = require(Parent.SourceCode.Client.UI.Themes.Dark)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local LocalAvatar = require(Parent.SourceCode.Client.Avatar.LocalAvatar)
local AvalogMenu = require(script.Parent.AvalogMenu)
return function(v1) -- line 12 | captures: Fusion, OnyxUI, States, StateExtensions, Dark, ServiceProvider, LocalAvatar, AvalogMenu
    local v2 = Fusion.scoped(Fusion, OnyxUI.Components, { AvalogMenu = AvalogMenu })
    local v3 = OnyxUI.Themer.Theme:now()
    StateExtensions:Initialize()
    ServiceProvider:Setup({ AvatarManager = LocalAvatar })
    States.Open:set(true)
    States.Theme:set(Dark)
    OnyxUI.Themer.Theme:is(Fusion.peek(States.Theme)):during(function() -- line 28 | captures: v1, v2
        return v2:AvalogMenu({ Parent = v1 })
    end)
    local v4 = {
        Content = { "Toggle" },
        Parent = v1,
        AnchorPoint = Vector2.new(0, 0)
    }
    v4.Position = v2:Computed(function(v5) -- line 38 | captures: v3
        return UDim2.new(0, v5(v3.Spacing["1"]), 0, v5(v3.Spacing["1"]))
    end)

    function v4.OnActivated() -- line 42 | captures: Fusion, States
        States.Open:set(not Fusion.peek(States.Open))
    end

    v2:Button(v4)
    return function() -- line 47 | captures: v2, StateExtensions
        v2:doCleanup()
        StateExtensions:Destroy()
    end
end
