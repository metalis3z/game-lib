-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AreaNotificationTracker = require(script.Parent.Parent.Game.GuardAreas.AreaNotificationTracker)
require(ReplicatedStorage.Data.Areas)
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.Layout).SwapGradient
local GuiTransitionGroup = require(ReplicatedStorage.Client.UI.VFX.GuiTransitionGroup)
local v1 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v3 = GUI.AreaGui()
local Frame = v3.Frame
local Main = Frame.Texts.Main
local Emoji = Frame.Texts.Emoji
local v4 = {}
local v5 = 0
local v6

local function applyRarityGradient(v7) -- line 18 | captures: SwapGradient, Main
    SwapGradient(Main, v7.Rarity.RarityGradient)
end

local function renderArea(v8) -- line 21 | captures: SwapGradient, Main, Emoji
    Main.Text = ("%*"):format(v8.DisplayName)
    Emoji.Text = ("%*"):format(v8.Emoji)
    SwapGradient(Main, v8.Rarity.RarityGradient)
end

local function showArea(v9) -- line 26 | captures: v5, v6, SwapGradient, v1, v2, v3, Main, Emoji
    v5 += 1
    local v10 = v5
    if workspace:GetAttribute("Event_DragonEggEvent") then
        return
    end
    local v11 = v6
    local v12 = v11 ~= nil
    assert(v12, "AreaGui transition group must be initialized before show")
    v11:Halt()
    Main.Text = ("%*"):format(v9.DisplayName)
    Emoji.Text = ("%*"):format(v9.Emoji)
    SwapGradient(Main, v9.Rarity.RarityGradient)
    v11:SnapHidden()
    v3.Enabled = true
    v11:Reveal(v1)
    task.delay(1, function() -- line 42 | captures: v10, v11, v5, v2, v3
        if v10 ~= v5 then
            return
        end
        v11:Halt()
        v11:Conceal(v2)
        task.delay(v2.Time, function() -- line 48 | captures: v10, v11, v5, v3
            if v10 == v5 then
                v3.Enabled = false
                v11:Rehome()
            end
        end)
    end)
end

local function start() -- line 57 | captures: v6, AreaNotificationTracker, GuiTransitionGroup, v3, showArea
    v6 = GuiTransitionGroup.new(v3, v3, 0.02)
    v3.Enabled = false
    AreaNotificationTracker.Start(showArea)
end

function v4.Start() -- line 62 | captures: v6, AreaNotificationTracker, GuiTransitionGroup, v3, showArea
    v6 = GuiTransitionGroup.new(v3, v3, 0.02)
    v3.Enabled = false
    AreaNotificationTracker.Start(showArea)
end

v4.Start()
