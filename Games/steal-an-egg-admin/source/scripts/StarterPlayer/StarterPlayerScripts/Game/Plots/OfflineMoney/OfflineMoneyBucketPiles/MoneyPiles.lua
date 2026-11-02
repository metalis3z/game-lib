-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMin(0), t.numberMaxExclusive((1/0)))
local Emit = require(ReplicatedStorage.Shared.Utils.VFX).Emit
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v2 = {}

v2.__index = v2
v2.__class = "OfflineGeneratedMoney"

local v3 = Color3.new(1, 1, 1)
local v4 = Log.new()
local BuckPiles = ReplicatedStorage.Assets.Models.BuckPiles
local Folder = BuckPiles:IsA("Folder")
assert(Folder, "ReplicatedStorage.Assets.Models.BuckPiles must be a Folder")
local MoneyCollect = ReplicatedStorage.Assets.VFX.MoneyCollect
local Folder_2 = MoneyCollect:IsA("Folder")
assert(Folder_2, "ReplicatedStorage.Assets.VFX.MoneyCollect must be a Folder")

function v2.new(v5, v6) -- line 27 | captures: t, Signal, Trove, v2, BuckPiles
    t.strict(t.instanceIsA("BasePart"))(v5)
    t.strict(t.Instance)(v6)
    local v7 = {}
    local v8 = setmetatable(v7, v2)
    local Folder = Instance.new("Folder")
    Folder.Name = "LocalOfflineGeneratedMoneyPiles"
    Folder.Parent = v6
    local v9 = Trove.new()
    v8._trove = v9
    v8._animationTrove = Trove.new()
    v8._bucketRoot = v5
    v8._runtimeFolder = Folder
    v8._stages = {}
    v8._currentStageIndex = 0
    v8._lastStageCenterCFrame = nil
    v8._destroyed = false
    v8._lastAdornee = nil
    v8.BillboardAdorneeChanged = Signal.new()
    v9:Add(Folder)
    v9:Add(v8._animationTrove)
    v9:Add(v5:GetPropertyChangedSignal("CFrame"):Connect(function() -- line 52 | captures: v5, v8, v2
        for v10, v11 in ipairs(v8._stages) do
            v2._pivotRootToBucket(v11.model, v11.rootPart, v5)
        end
    end))
    local v12 = {}
    for v13, v14 in ipairs(BuckPiles:GetChildren()) do
        if v14:IsA("Model") then
            v12[#v12 + 1] = v14
        end
    end
    table.sort(v12, function(v15, v16) -- line 63 | captures: v2
        return v2._getStageSortIndex(v15) < v2._getStageSortIndex(v16)
    end)
    local v17 = #v12 == 3
    assert(v17, "BuckPiles must contain exactly three stage models")
    for v18, v19 in ipairs(v12) do
        v8._stages[#v8._stages + 1] = v8:_buildStage(v19)
    end
    v8:_hideAllStages()
    return v8
end

local function _getStageSortIndex(v20) -- line 77
    local Name = v20.Name
    local v21 = tonumber(Name)
    local v22 = ("BuckPiles stage %* must be numerically named"):format(v20.Name)
    assert(v21, v22)
    return v21
end

v2._getStageSortIndex = _getStageSortIndex

function v2._readVector3Attribute(v23, v24) -- line 82 | captures: t
    local v25 = v23:GetAttribute(v24)
    t.strict(t.Vector3)(v25)
    return v25
end

function v2._readCFrameAttribute(v26, v27) -- line 88 | captures: t
    local v28 = v26:GetAttribute(v27)
    t.strict(t.CFrame)(v28)
    return v28
end

local function _getVisibleTransparency(v29) -- line 94
    if v29.Transparency >= 1 then
        return 0
    end
    return v29.Transparency
end

v2._getVisibleTransparency = _getVisibleTransparency

local function _pivotRootToBucket(v30, v31, v32) -- line 100
    v30:PivotTo(v32.CFrame * v31.CFrame:Inverse() * v30:GetPivot())
end

v2._pivotRootToBucket = _pivotRootToBucket

function v2._createTopAttachment(v33) -- line 103 | captures: t
    local GeneratedMoneyTopAttachment = v33:FindFirstChild("GeneratedMoneyTopAttachment")
    if GeneratedMoneyTopAttachment then
        t.strict(t.instanceIsA("Attachment"))(GeneratedMoneyTopAttachment)
        return GeneratedMoneyTopAttachment
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "GeneratedMoneyTopAttachment"
    Attachment.Parent = v33
    return Attachment
end

function v2._createHighlight(v34) -- line 115 | captures: v3
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "OfflineMoneyBucketHighlight"
    Highlight.Adornee = v34
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = 1
    Highlight.OutlineColor = v3
    Highlight.OutlineTransparency = 0
    Highlight.Enabled = false
    Highlight.Parent = v34
    return Highlight
end

local function _syncTopAttachment(v35) -- line 127
    local v36, v37 = v35.model:GetBoundingBox()
    v35.topAttachment.Position = v35.mainPart.CFrame:PointToObjectSpace(v36.Position + v36.UpVector * (v37.Y * 0.5))
end

v2._syncTopAttachment = _syncTopAttachment

function v2._collectAnimatedParts(v38, v39) -- line 132 | captures: v2, v4
    local v40 = {}
    for v41, v42 in ipairs(v38:GetDescendants()) do
        if v42:IsA("BasePart") and v42 ~= v39 then
            local v43 = v42:GetAttribute("OriginalSize") ~= nil
            local v44 = v42:GetAttribute("TargetSize") ~= nil
            local v45 = v42:GetAttribute("OriginalCFrame") ~= nil
            local v46 = v42:GetAttribute("TargetCFrame") ~= nil
            if v43 then
                v40[#v40 + 1] = {
                    part = v42,
                    originalSize = v2._readVector3Attribute(v42, "OriginalSize"),
                    targetSize = v2._readVector3Attribute(v42, "TargetSize"),
                    originalCFrame = v2._readCFrameAttribute(v42, "OriginalCFrame"),
                    targetCFrame = v2._readCFrameAttribute(v42, "TargetCFrame"),
                    visibleTransparency = v2._getVisibleTransparency(v42)
                }
            end
        end
    end
    if #v40 == 0 then
        v4:AtWarning():Log((("BuckPiles stage %* has no animated part attributes"):format(v38.Name)))
    end
    return v40
end

local function _setStageVisible(v47, v48) -- line 160
    local v49
    for v50, v51 in ipairs(v47.model:GetDescendants()) do
        if v51:IsA("BasePart") then
            if v51 == v47.rootPart then
                v51.Transparency = 1
            else
                local _OfflineGeneratedMoneyVisibleTransparency = v51:GetAttribute("_OfflineGeneratedMoneyVisibleTransparency")
                if v48 then
                    if typeof(_OfflineGeneratedMoneyVisibleTransparency) == "number" then
                        v49 = _OfflineGeneratedMoneyVisibleTransparency
                    end
                else
                    v49 = 1
                end
                v51.Transparency = v49
            end
        end
    end
    v47.highlight.Enabled = v48
end

v2._setStageVisible = _setStageVisible

function v2._resetStageParts(v52) -- line 180 | captures: v2
    for v53, v54 in ipairs(v52.animatedParts) do
        v54.part.Size = v54.originalSize
        v54.part.CFrame = v52.rootPart.CFrame * v54.originalCFrame
    end
    v2._syncTopAttachment(v52)
end

function v2._applyStageAlpha(v55, v56) -- line 187 | captures: v2
    local v57 = math.clamp(v56, 0, 1)
    for v58, v59 in ipairs(v55.animatedParts) do
        v59.part.Size = v59.originalSize:Lerp(v59.targetSize, v57)
        v59.part.CFrame = v55.rootPart.CFrame * v59.originalCFrame:Lerp(v59.targetCFrame, v57)
        v59.part.Transparency = v59.visibleTransparency
    end
    v2._syncTopAttachment(v55)
end

function v2._buildStage(v60, v61) -- line 196 | captures: t, v2
    local v62 = v61:Clone()
    v62.Name = ("OfflineGeneratedMoneyStage%*"):format(v61.Name)
    v62.Parent = v60._runtimeFolder
    local RootPart = v62:FindFirstChild("RootPart")
    t.strict(t.instanceIsA("BasePart"))(RootPart)
    local Main = v62:FindFirstChild("Main")
    t.strict(t.instanceIsA("BasePart"))(Main)
    v62.PrimaryPart = RootPart
    v2._pivotRootToBucket(v62, RootPart, v60._bucketRoot)
    for v63, v64 in ipairs(v62:GetDescendants()) do
        if v64:IsA("BasePart") then
            v64:SetAttribute("_OfflineGeneratedMoneyVisibleTransparency", v2._getVisibleTransparency(v64))
            if v64 == RootPart then
                v64.Transparency = 1
            end
            v64.CanCollide = false
            v64.CanTouch = false
            v64.CanQuery = false
        end
    end
    local v65 = {
        index = v2._getStageSortIndex(v61),
        model = v62,
        rootPart = RootPart,
        mainPart = Main,
        highlight = v2._createHighlight(v62),
        topAttachment = v2._createTopAttachment(Main),
        animatedParts = v2._collectAnimatedParts(v62, RootPart)
    }
    v2._resetStageParts(v65)
    v2._setStageVisible(v65, false)
    return v65
end

function v2._hideAllStages(v66) -- line 232 | captures: v2
    for v67, v68 in ipairs(v66._stages) do
        v2._resetStageParts(v68)
        v2._setStageVisible(v68, false)
    end
    v66._currentStageIndex = 0
    if v66._lastAdornee ~= nil then
        v66._lastAdornee = nil
        v66.BillboardAdorneeChanged:Fire(nil)
    end
end

function v2._fadeOutStages(v69, v70) -- line 243 | captures: TweenService
    local v71
    if typeof(v70) == "number" then
        v71 = math.max(v70, 0)
    else
        v71 = 0.3
    end
    local v72 = false
    for v73, v74 in ipairs(v69._stages) do
        v74.highlight.Enabled = false
        local v75 = v72
        for v76, v77 in ipairs(v74.model:GetDescendants()) do
            if v77:IsA("BasePart") and v77 ~= v74.rootPart and v77.Transparency < 1 then
                local v78 = TweenInfo.new(v71, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v79 = TweenService:Create(v77, v78, { Transparency = 1 })
                v69._animationTrove:Add(v79)
                v79:Play()
                v75 = true
            end
            v72 = v75
        end
    end
    return v72
end

local function _getCollectAllEffectCFrame(v80) -- line 261
    local _currentStageIndex
    if v80._currentStageIndex <= 0 then
    else
        _currentStageIndex = v80._currentStageIndex
    end
    local v81 = if _currentStageIndex then v80._stages[_currentStageIndex] else nil
    if v81 then
        return v81.mainPart.CFrame
    end
    return v80._lastStageCenterCFrame or v80._bucketRoot.CFrame
end

v2._getCollectAllEffectCFrame = _getCollectAllEffectCFrame

function v2._emitCollectAllCash(v82) -- line 282 | captures: Emit, MoneyCollect
    Emit(v82, nil, MoneyCollect:GetChildren())
end

function v2._setProgress(v83, v84) -- line 285 | captures: v2
    local v85 = math.clamp(v84, 0, 1)
    local _stages = v83._stages
    local v86 = #_stages
    if not (v86 <= 0) then
        if v85 <= 0 then
            v83:_hideAllStages()
        else
            local v87 = v85 * v86
            local v88 = math.floor(v87) + 1
            local v89 = math.clamp(v88, 1, v86)
            local v90 = if v85 < 1 then v87 - (v89 - 1) else 1
            for v91, v92 in ipairs(_stages) do
                local v93 = v91 == v89
                v2._setStageVisible(v92, v93)
                if v93 then
                    v2._applyStageAlpha(v92, v90)
                else
                    v2._resetStageParts(v92)
                end
            end
            v83._currentStageIndex = v89
            v83._lastStageCenterCFrame = _stages[v89].mainPart.CFrame
            local topAttachment = _stages[v89].topAttachment
            if v83._lastAdornee ~= topAttachment then
                v83._lastAdornee = topAttachment
                v83.BillboardAdorneeChanged:Fire(topAttachment)
            end
        end
    end
end

function v2.UpdateInstant(v94, v95, v96) -- line 323 | captures: t, v1
    t.strict(v1)(v95)
    t.strict(t.boolean)(v96)
    if not v96 or v95 <= 0 then
        v94:_hideAllStages()
    else
        local v97 = v95 - 1
        local v98 = math.max(v97, 0) / 999999999
        v94:_setProgress((math.clamp(v98, 0, 1)))
    end
end

function v2.PlayCollectReset(v99) -- line 334 | captures: Trove, v2
    v99._animationTrove:Destroy()
    v99._animationTrove = Trove.new()
    v99._trove:Add(v99._animationTrove)
    if v99:_fadeOutStages(0.3) then
        v2._emitCollectAllCash(v99:_getCollectAllEffectCFrame())
    end
    v99._animationTrove:Add(task.delay(0.3, function() -- line 341 | captures: v99
        if not v99._destroyed then
            v99:_hideAllStages()
        end
    end))
end

local function GetBillboardAdornee(v100) -- line 348
    return v100._lastAdornee
end

v2.GetBillboardAdornee = GetBillboardAdornee

local function Destroy(v101) -- line 351
    v101._destroyed = true
    v101._trove:Destroy()
end

v2.Destroy = Destroy
return v2
