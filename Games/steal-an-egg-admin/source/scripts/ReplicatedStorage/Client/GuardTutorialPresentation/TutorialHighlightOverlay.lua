-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GUI = require(ReplicatedStorage.Client.GUI)
local TutorialProp = require(script.Parent.TutorialProp)
local t = require(ReplicatedStorage.Packages.t)
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v2 = UDim2.fromScale(0.01, 0.01)
local v3 = { "AbsolutePosition", "AbsoluteSize" }
local v4 = t.strict(t.instanceIsA("GuiObject"))
local v5 = {}

local function ringGoal(v6, v7) -- line 16
    local AbsoluteSize = v6.AbsoluteSize
    local v8 = v6.AbsolutePosition + AbsoluteSize * 0.5 - v7.AbsolutePosition
    return {
        Size = UDim2.new(0, AbsoluteSize.X * 1.15, 0, AbsoluteSize.Y * 1.15),
        Position = UDim2.new(0, v8.X, 0, v8.Y)
    }
end

local function tutorialLayerHost() -- line 21 | captures: GUI
    local v9 = GUI.TutorialInstructions()
    local ScreenGui = v9:IsA("ScreenGui")
    assert(ScreenGui, "the tutorial instruction layer is not a ScreenGui")
    local Parent = v9.Parent
    local v10 = Parent and Parent:IsA("PlayerGui")
    assert(v10, "the tutorial instruction layer sits outside PlayerGui")
    return Parent
end

function v5.Attach(v11) -- line 33 | captures: TweenService, GUI, TutorialProp, v1, v2, v3, v4, ringGoal
    v4(v11)
    local GuardTutorialHighlight, GuardTutorialHighlight_2 = TutorialProp.Clone("ClickTarget", "GuardTutorialHighlight")
    GuardTutorialHighlight.Enabled = true
    local v12 = GUI.TutorialInstructions()
    local ScreenGui = v12:IsA("ScreenGui")
    assert(ScreenGui, "the tutorial instruction layer is not a ScreenGui")
    local Parent = v12.Parent
    local v13 = Parent and Parent:IsA("PlayerGui")
    assert(v13, "the tutorial instruction layer sits outside PlayerGui")
    GuardTutorialHighlight.Parent = Parent
    local Container = GuardTutorialHighlight.Container
    local Frame = Container:IsA("Frame")
    assert(Frame, "the highlight template has no Container frame")
    Container.Size = v2
    local v14

    local function reseat() -- line 53 | captures: v14, v11, GuardTutorialHighlight, Container, TweenService, v1, ringGoal
        local v15 = ringGoal(v11, GuardTutorialHighlight)
        if v14 then
            v14:Cancel()
            v14:Destroy()
        end
        local v16 = TweenService:Create(Container, v1, v15)
        v14 = v16
        v16:Play()
    end

    local v17 = ringGoal(v11, GuardTutorialHighlight)
    if v14 then
        v14:Cancel()
        v14:Destroy()
    end
    TweenService:Create(Container, v1, v17):Play()
    for v18, v19 in v3 do
        GuardTutorialHighlight_2:Add(v11:GetPropertyChangedSignal(v19):Connect(reseat))
    end
    GuardTutorialHighlight_2:Add(GuardTutorialHighlight:GetPropertyChangedSignal("AbsolutePosition"):Connect(reseat))
    GuardTutorialHighlight_2:Add(function() -- line 79 | captures: v14
        if v14 then
            v14:Cancel()
            v14:Destroy()
        end
    end)
    return TutorialProp.Teardown("Removing the tutorial highlight ring", GuardTutorialHighlight_2)
end

return v5
