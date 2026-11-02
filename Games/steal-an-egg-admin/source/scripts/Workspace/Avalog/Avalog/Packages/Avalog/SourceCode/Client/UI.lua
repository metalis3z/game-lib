-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local StateExtensions = require(Parent.SourceCode.Client.UI.StateExtensions)
local OnyxUI = require(Parent.Parent.OnyxUI)
local States = require(script.States)
local Config = require(Parent.Config)
local AvalogMenu = require(script.ScreenGuis.AvalogMenu)
local v1 = { Scope = Fusion.scoped(Fusion) }

function v1.Start(v2) -- line 16 | captures: Players, Fusion, StateExtensions, OnyxUI, States, Config, AvalogMenu
    StateExtensions:Initialize()
    StateExtensions:Start()
    States.Theme:set(Config:Get().Theme)
    OnyxUI.Themer.Theme:is(Fusion.peek(States.Theme)):during(function() -- line 22 | captures: v2, Players, AvalogMenu
        AvalogMenu(v2.Scope, { Parent = Players.LocalPlayer:WaitForChild("PlayerGui") })
    end)
end

return v1
