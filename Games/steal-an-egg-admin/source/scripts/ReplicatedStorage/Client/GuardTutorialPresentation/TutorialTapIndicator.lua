-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TutorialProp = require(script.Parent.TutorialProp)
local t = require(ReplicatedStorage.Packages.t)
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v2 = t.strict(t.instanceIsA("GuiButton"))
local v3 = t.strict(t.optional(t.boolean))
local v4 = t.strict(t.optional(t.UDim))
local v5 = t.strict(t.optional(t.UDim2))
local v6 = {}

local function reshapeCorner(v7, v8) -- line 16
    local Frame = v7.Frame
    local Frame_2 = Frame:IsA("Frame")
    assert(Frame_2, "the tap template has no inner Frame")
    local UICorner = Frame.UICorner
    local UICorner_2 = UICorner:IsA("UICorner")
    assert(UICorner_2, "the tap template has no UICorner")
    UICorner.CornerRadius = v8
end

function v6.Attach(v9, v10, v11, v12) -- line 25 | captures: TweenService, TutorialProp, v1, v2, v3, v4, v5
    v2(v9)
    v3(v10)
    v4(v11)
    v5(v12)
    local v13 = v10 == true
    local v14
    if v13 then
        v14 = v9
    else
        local Parent = v9.Parent
        v14 = assert(Parent, "a tap prop outside its button needs a parent")
    end
    local GuardTutorialTap, GuardTutorialTap_2 = TutorialProp.Clone("TutorialTap", "GuardTutorialTap")
    GuardTutorialTap.Active = false
    if v13 then
        GuardTutorialTap.Position = UDim2.new(0, 0, 0, 0)
    else
        GuardTutorialTap.Position = v9.Position
    end
    if v12 then
        GuardTutorialTap.Size = v12
    elseif v13 then
        GuardTutorialTap.Size = UDim2.fromScale(1, 1)
    else
        GuardTutorialTap.Size = v9.Size
    end
    if v13 then
        GuardTutorialTap.AnchorPoint = Vector2.zero
    else
        GuardTutorialTap.AnchorPoint = v9.AnchorPoint
    end
    if v11 ~= nil then
        local Frame = GuardTutorialTap.Frame
        local Frame_2 = Frame:IsA("Frame")
        assert(Frame_2, "the tap template has no inner Frame")
        local UICorner = Frame.UICorner
        local UICorner_2 = UICorner:IsA("UICorner")
        assert(UICorner_2, "the tap template has no UICorner")
        UICorner.CornerRadius = v11
    end
    GuardTutorialTap.ZIndex = v9.ZIndex + 1
    GuardTutorialTap.Parent = v14
    local Arrow = GuardTutorialTap.Arrow
    local ImageLabel = Arrow:IsA("ImageLabel")
    assert(ImageLabel, "the tap template has no Arrow image")
    local Position = Arrow.Position
    Arrow.Position = UDim2.new(1, Position.X.Offset, Position.Y.Scale, Position.Y.Offset)
    local v15 = TweenService:Create(Arrow, v1, { Position = UDim2.new(1.2, Position.X.Offset, Position.Y.Scale, Position.Y.Offset) })
    v15:Play()
    GuardTutorialTap_2:Add(function() -- line 78 | captures: v15
        v15:Cancel()
        v15:Destroy()
    end)
    return TutorialProp.Teardown("Removing the tutorial tap prop", GuardTutorialTap_2)
end

return v6
