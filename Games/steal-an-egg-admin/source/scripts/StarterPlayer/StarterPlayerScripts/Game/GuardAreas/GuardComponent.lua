-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local GuardWakeLookAt = require(script.Parent.GuardWakeLookAt)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "GuardComponent"

local v3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true)

function v2.new(v4) -- line 20 | captures: t, GuardWakeLookAt, Trove, WaitFor, v1, v2
    t.strict(t.instanceIsA("Model"))(v4)
    local v5 = {}
    local v6 = setmetatable(v5, v2)
    local Guard = v4:WaitForChild("Guard")
    local Model = Guard:IsA("Model")
    local v7 = ("%*.Guard must be a Model"):format((v4:GetFullName()))
    assert(Model, v7)
    local v8, v9 = WaitFor.Descendant(Guard, "Head"):await()
    if v8 and v9 ~= nil then
        local BasePart = v9:IsA("BasePart")
        local v10 = ("%* must be a BasePart"):format((v9:GetFullName()))
        assert(BasePart, v10)
        local HumanoidRootPart
        if v4.Name == "Forest" then
            HumanoidRootPart = Guard:WaitForChild("HumanoidRootPart")
            local v11 = ("%* requires a HumanoidRootPart descendant for Forest shake effects"):format((Guard:GetFullName()))
            assert(HumanoidRootPart, v11)
            local BasePart = HumanoidRootPart:IsA("BasePart")
            local v12 = ("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))
            assert(BasePart, v12)
        end
        local v13, v14 = WaitFor.Descendant(v9, "AlertGui"):await()
        if v13 and v14 and v14:IsA("BillboardGui") then
            v6._sleepVfxAttachment = nil
            v6._alertGuiTemplate = v14
            v6._alertGui = nil
            v6._guardModel = Guard
            v6._head = v9
            v6._lastAlertAt = (-1/0)
            v6._root = HumanoidRootPart
            v6._sleepColorTrove = Trove.new()
            v6._trove = Trove.new()
            if not Guard:GetAttribute("HeadLookAtDisabled") then
                v6._wakeLookAt = GuardWakeLookAt.new(Guard)
            end
            v6._trove:Add(v6._sleepColorTrove)
            v6._trove:Add(Guard:GetAttributeChangedSignal("TargetPlayer"):Connect(function() -- line 78 | captures: v6
                v6:_updateTargetAlert()
            end))
            v6._trove:Add(Guard:GetAttributeChangedSignal("Sleeping"):Connect(function() -- line 83 | captures: v6, Guard
                v6:_applySleepVfx()
                if Guard:GetAttribute("Sleeping") == true then
                    v6:_clearAlert()
                end
            end))
            v6._trove:Add(Guard:GetAttributeChangedSignal("GuardState"):Connect(function() -- line 91 | captures: v6
                v6:_applySleepVfx()
                v6:_applyGuardStatePresentation()
            end))
            v6._trove:Add(Guard:GetAttributeChangedSignal("WakeTargetPlayer"):Connect(function() -- line 97 | captures: v6
                v6:_applyGuardStatePresentation()
            end))
            v6._trove:Add(Guard:GetAttributeChangedSignal("Hidden"):Connect(function() -- line 102 | captures: v6
                v6:_applySleepVfx()
            end))
            v6:_applySleepVfx()
            v6:_applyGuardStatePresentation()
            v6:_updateTargetAlert()
            local v15 = false
            v6._trove:Add(Guard.DescendantAdded:Connect(function(v16) -- line 109 | captures: v15, v6
                if v16:IsA("BasePart") then
                    task.delay(1, function() -- line 113 | captures: v15, v6
                        if v15 then
                            return
                        end
                        v15 = true
                        v6:_applyGuardStatePresentation()
                        task.wait(1)
                        v15 = false
                    end)
                end
            end))
            return v6
        end
        v1:AtWarning():Log((("%* has no AlertGui BillboardGui descendant (%*)"):format(v9:GetFullName(), (tostring(v14)))))
    else
        v1:AtWarning():Log((("%* has no Head descendant for the alert GUI (%*)"):format(Guard:GetFullName(), (tostring(v9)))))
    end
    return nil
end

local function _updateTargetAlert(v17) -- line 124
    local TargetPlayer = v17._guardModel:GetAttribute("TargetPlayer")
    if typeof(TargetPlayer) == "string" and TargetPlayer ~= "" then
        local v18 = os.clock()
        if not (v18 - v17._lastAlertAt < 3) then
            v17._lastAlertAt = v18
            v17:_showAlert()
        end
    end
end

v2._updateTargetAlert = _updateTargetAlert

function v2._applySleepVfx(v19) -- line 137 | captures: WaitFor, v1
    if v19._guardModel:GetAttribute("GuardState") == "Sleeping" and v19._guardModel:GetAttribute("Hidden") == true then
    end
    local _sleepVfxAttachment = v19._sleepVfxAttachment
    local v20
    if _sleepVfxAttachment == nil or _sleepVfxAttachment.Parent == nil then
        local v21 = v19._guardModel:FindFirstChild("SleepVFXAttachment", true)
        if v21 == nil then
            local v22
            v22, v21 = WaitFor.Descendant(v19._guardModel, "SleepVFXAttachment"):await()
            if not v22 then
                v21 = nil
            end
        end
        v19._sleepVfxAttachment = v21
        v20 = v21
    else
        v20 = _sleepVfxAttachment
    end
    if v20 then
        local v23 = if v19._guardModel:GetAttribute("GuardState") == "Sleeping" then v19._guardModel:GetAttribute("Hidden") ~= true else false
        for v24, v25 in ipairs(v20:GetDescendants()) do
            if v25:IsA("ParticleEmitter") then
                v25.Enabled = v23
                if not v23 then
                    v25:Clear()
                end
            end
        end
    else
        v1:AtWarning():Log((("Guard model %* is missing SleepVFXAttachment"):format((v19._guardModel:GetFullName()))))
    end
end

function v2._applyGuardStatePresentation(v26) -- line 164 | captures: t
    local GuardState = v26._guardModel:GetAttribute("GuardState")
    local WakeTargetPlayer = v26._guardModel:GetAttribute("WakeTargetPlayer")
    t.strict(t.optional(t.string))(WakeTargetPlayer)
    if v26._wakeLookAt then
        local v27 = GuardState == "Waking"
        if WakeTargetPlayer == "" then
            WakeTargetPlayer = nil
        end
        v26._wakeLookAt:SetWaking(v27, WakeTargetPlayer)
    end
    if GuardState == "Sleeping" then
        v26:_applySleepDetailColors()
    elseif GuardState == "Waking" then
        v26:_animateSleepDetailColorsToOriginal()
    end
end

local function _applySleepDetailColors(v28) -- line 188
    v28._sleepColorTrove:Clean()
    for v29, v30 in ipairs(v28._guardModel:GetDescendants()) do
        if v30:IsA("BasePart") then
            local SleepColor = v30:GetAttribute("SleepColor")
            if SleepColor then
                if v30:GetAttribute("OriginalColor") == nil then
                    v30:SetAttribute("OriginalColor", v30.Color)
                end
                v30.Color = SleepColor
            end
        end
    end
end

v2._applySleepDetailColors = _applySleepDetailColors

local function _animateSleepDetailColorsToOriginal(v31) -- line 203
    v31._sleepColorTrove:Clean()
    for v32, v33 in ipairs(v31._guardModel:GetDescendants()) do
        if v33:IsA("BasePart") and v33:GetAttribute("SleepColor") then
            local OriginalColor = v33:GetAttribute("OriginalColor")
            if OriginalColor == nil then
                v33:SetAttribute("OriginalColor", v33.Color)
            end
            assert(OriginalColor, "luau")
            v33.Color = OriginalColor
        end
    end
end

v2._animateSleepDetailColorsToOriginal = _animateSleepDetailColorsToOriginal

local function _clearAlert(v34) -- line 217
    local _alertGui = v34._alertGui
    if _alertGui ~= nil then
        v34._alertGui = nil
        _alertGui:Destroy()
    end
end

v2._clearAlert = _clearAlert

function v2._showAlert(v35) -- line 225 | captures: Tween, v1
    local function v36(...)
        return (assert(...))
    end

    if v35._alertGui ~= nil then
        return
    end
    local v37 = v35._alertGuiTemplate:Clone()
    local v38 = v36(v37:FindFirstChildWhichIsA("ImageLabel"))
    v38.Transparency = 1
    v37.AlwaysOnTop = true
    v37.Enabled = true
    v37.Parent = v35._head
    v35._alertGui = v37
    v35._trove:Add(v37)
    Tween(v38, { ImageTransparency = 0 }, {
        0.4,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    })
    local v39 = {}
    local StudsOffset = v37.StudsOffset
    local v40 = Vector3.new(0, 1, 0)
    local v41 = v37.StudsOffset.Y * 0.6
    v39.StudsOffset = StudsOffset + v40 * math.max(v41, 1)
    Tween(v37, v39, {
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    }).Completed:Once(function() -- line 238 | captures: v38, Tween
        task.wait(1)
        Tween(v38, { ImageTransparency = 1 }, {
            0.3,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        })
    end)
    task.delay(3, function() -- line 242 | captures: v35, v37
        if v37.Parent ~= nil then
            if v35._alertGui == v37 then
                v35._alertGui = nil
            end
            v37:Destroy()
        end
    end)
    v1:AtTrace():Log((("Guard alert shown for %*"):format((v35._guardModel:GetFullName()))))
end

local function Destroy(v42) -- line 253
    if v42._wakeLookAt then
        v42._wakeLookAt:Destroy()
    end
    v42._trove:Destroy()
end

v2.Destroy = Destroy

local function GetGuardModel(v43) -- line 259
    return v43._guardModel
end

v2.GetGuardModel = GetGuardModel

function v2.PlayWakeUp(v44) -- line 262 | captures: Debris, TweenService, v3
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "GuardWakeHighlight"
    Highlight.FillColor = Color3.fromRGB(255, 0, 0)
    Highlight.OutlineColor = Color3.fromRGB(132, 0, 0)
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = v44._guardModel
    TweenService:Create(Highlight, v3, {
        FillTransparency = 0.35,
        OutlineTransparency = 0
    }):Play()
    Debris:AddItem(Highlight, v3.Time * 2 + 0.05)
end

return v2
