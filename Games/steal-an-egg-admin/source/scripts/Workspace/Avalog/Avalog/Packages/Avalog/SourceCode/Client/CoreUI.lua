-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local Parent = script.Parent.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Config = require(Parent.Config)
local v1 = {
    Backpack = Enum.CoreGuiType.Backpack,
    PlayerList = Enum.CoreGuiType.PlayerList,
    Emotes = Enum.CoreGuiType.EmotesMenu,
    Captures = Enum.CoreGuiType.Captures,
    Chat = Enum.CoreGuiType.Chat
}

function v1.TouchControls(v2) -- line 15 | captures: GuiService
    GuiService.TouchControlsEnabled = v2
end

local v3 = Fusion.scoped(Fusion)
local v4 = {}
v3:Observer(States.Open):onChange(function() -- line 24 | captures: StarterGui, Fusion, States, Config, v1
    local v5 = Fusion.peek(States.Open)
    for v6, v7 in ipairs(Config:Get().HiddenCoreGui) do
        local v8 = v1[v7]
        if typeof(v8) == "EnumItem" then
            StarterGui:SetCoreGuiEnabled(v8, not v5)
        elseif typeof(v8) == "function" then
            v8(not v5)
        end
    end
end)
return v4
