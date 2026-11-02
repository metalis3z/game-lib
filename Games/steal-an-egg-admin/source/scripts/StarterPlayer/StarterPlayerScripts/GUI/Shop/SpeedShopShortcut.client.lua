-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ScrollingFrame = GUI.Shop().Frame.ScrollingFrame
local Speed = ScrollingFrame.Speed
local SpeedShopButton = Hud.Every("SpeedShopButton")

local function centerShopScrollingFrameAt(v1, v2) -- line 16 | captures: t, ScrollingFrame
    t.strict(t.number)(v2)
    local v3 = v1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y + v2 - ScrollingFrame.AbsoluteWindowSize.Y / 2
    local v4 = ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y
    local v5 = math.max(0, v4)
    ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X, (math.clamp(v3, 0, v5)))
end

local function centerSpeedRow() -- line 23 | captures: Speed, centerShopScrollingFrameAt
    centerShopScrollingFrameAt(Speed, Speed.AbsoluteSize.Y / 2)
end

local function openShopThenCenter(v6) -- line 26 | captures: Tabs
    task.spawn(function() -- line 27 | captures: v6, Tabs
        Tabs.Show("Shop")
        task.wait()
        task.wait()
        v6()
    end)
end

for v7, v8 in SpeedShopButton do
    local GuiButton = v8:IsA("GuiButton")
    assert(GuiButton, "HUD Speed.ShopBTN must be a GuiButton")
    ButtonFX(v8, 1.08, function() -- line 40 | captures: Tabs, Speed, centerShopScrollingFrameAt
        task.spawn(function() -- line 42 | captures: Tabs, Speed, centerShopScrollingFrameAt
            Tabs.Show("Shop")
            task.wait()
            task.wait()
            centerShopScrollingFrameAt(Speed, Speed.AbsoluteSize.Y / 2)
        end)
    end)
end
