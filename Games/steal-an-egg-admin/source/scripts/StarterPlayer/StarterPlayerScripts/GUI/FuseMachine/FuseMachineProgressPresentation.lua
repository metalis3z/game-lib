-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "FuseMachineProgressPresentation"

local v3 = { "LeftBar", "MiddleBar", "RightBar" }
local v4 = Color3.new(1, 1, 1)
local v5 = Color3.new(0, 0, 0)
local v6 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v8 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

function v2.new(v9, v10) -- line 22 | captures: t, Trove, v2, v3
    t.strict(t.instanceIsA("Frame"))(v9)
    t.strict(t.instanceIsA("Frame"))(v10)
    local v11 = {}
    local v12 = setmetatable(v11, v2)
    v12._barFills = {}
    v12._barFilled = {}
    v12._barLitTransparencies = {}
    v12._barOriginalVisible = {}
    v12._barTroves = {}
    local v13 = v10:GetAttribute("FillFadeSeconds") or 0.25
    v12._barTweenInfo = TweenInfo.new(v13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    for v14, v15 in ipairs(v3) do
        local v16 = v10:FindFirstChild(v15)
        local v17 = v16 ~= nil
        local v18 = ("PetFuse.FuseMain.DesignBars.%* is missing"):format(v15)
        assert(v17, v18)
        local Fill = v16:FindFirstChild("Fill")
        local v19
        if Fill == nil then
            v19 = false
        else
            v19 = Fill:IsA("ImageLabel")
        end
        local v20 = ("PetFuse.FuseMain.DesignBars.%*.Fill must be an ImageLabel"):format(v15)
        assert(v19, v20)
        v12._barFills[v14] = Fill
        v12._barLitTransparencies[v14] = Fill.ImageTransparency
        v12._barOriginalVisible[v14] = Fill.Visible
        v12._barTroves[v14] = Trove.new()
    end
    v12._icon = v9.OutputEgg
    t.strict(t.instanceIsA("ImageLabel"))(v12._icon)
    v12._iconOriginalBackgroundColor = v12._icon.BackgroundColor3
    v12._iconOriginalColor = v12._icon.ImageColor3
    v12._iconOriginalImage = v12._icon.Image
    v12._iconOriginalTransparency = v12._icon.ImageTransparency
    v12._iconScale = Instance.new("UIScale")
    v12._iconScale.Name = "FuseProgressScale"
    v12._iconScale.Parent = v12._icon
    v12._iconOriginalScale = v12._iconScale.Scale
    v12._iconTrove = Trove.new()
    v12._outputFill = v9.Fill
    t.strict(t.instanceIsA("Frame"))(v12._outputFill)
    v12._outputOriginalPosition = v12._outputFill.Position
    v12._outputOriginalSize = v12._outputFill.Size
    v12._outputAnchorY = v12._outputFill.AnchorPoint.Y
    v12._outputBottomScale = v12._outputOriginalPosition.Y.Scale + (1 - v12._outputAnchorY) * v12._outputOriginalSize.Y.Scale
    v12._outputBottomOffset = v12._outputOriginalPosition.Y.Offset + (1 - v12._outputAnchorY) * v12._outputOriginalSize.Y.Offset
    v12._outputTrove = Trove.new()
    v12._selectedCount = nil
    v12._trove = Trove.new()
    v12._trove:Add(v12._iconScale)
    v12._trove:Add(v12._iconTrove)
    v12._trove:Add(v12._outputTrove)
    for v21, v22 in ipairs(v12._barTroves) do
        v12._trove:Add(v22)
    end
    return v12
end

function v2._setBarFilled(v23, v24, v25, v26) -- line 80 | captures: TweenService
    if v23._barFilled[v24] == v25 then
        return
    end
    v23._barFilled[v24] = v25
    local v27 = v23._barTroves[v24]
    v27:Clean()
    local v28 = v23._barFills[v24]
    local v29 = if v25 then v23._barLitTransparencies[v24] else 1
    if v26 then
        if v25 and not v28.Visible then
            v28.ImageTransparency = 1
            v28.Visible = true
        end
        local v30 = TweenService:Create(v28, v23._barTweenInfo, { ImageTransparency = v29 })
        v27:Add(function() -- line 104 | captures: v30
            v30:Cancel()
            v30:Destroy()
        end)
        v27:Add(v30.Completed:Connect(function(v31) -- line 108 | captures: v23, v24, v28
            if v31 == Enum.PlaybackState.Completed then
                v28.Visible = v23._barFilled[v24]
            end
        end))
        v30:Play()
    else
        v28.ImageTransparency = v29
        v28.Visible = v25
    end
end

function v2._setOutputProgress(v32, v33, v34) -- line 116 | captures: TweenService, v6
    v32._outputTrove:Clean()
    local v35 = v33 / 3
    local v36 = UDim2.new(v32._outputOriginalSize.X.Scale, v32._outputOriginalSize.X.Offset, v35, 0)
    local v37 = UDim2.new(v32._outputOriginalPosition.X.Scale, v32._outputOriginalPosition.X.Offset, v32._outputBottomScale - (1 - v32._outputAnchorY) * v35, v32._outputBottomOffset)
    if v34 then
        local v38 = TweenService:Create(v32._outputFill, v6, {
            Position = v37,
            Size = v36
        })
        v32._outputTrove:Add(function() -- line 127 | captures: v38
            v38:Cancel()
            v38:Destroy()
        end)
        v38:Play()
    else
        v32._outputFill.Size = v36
        v32._outputFill.Position = v37
    end
end

function v2._setIncompleteIcon(v39) -- line 133 | captures: v5
    v39._iconTrove:Clean()
    v39._icon.ImageTransparency = 0.1
    v39._icon.ImageColor3 = v5
    v39._icon.BackgroundColor3 = v5
    v39._iconScale.Scale = v39._iconOriginalScale
end

function v2._setReadyIcon(v40, v41) -- line 140 | captures: TweenService, v4, v7, v8
    v40._iconTrove:Clean()
    v40._icon.ImageTransparency = 0
    v40._icon.ImageColor3 = v4
    v40._icon.BackgroundColor3 = v4
    v40._iconScale.Scale = v40._iconOriginalScale
    if not v41 then
        return
    end
    v40._iconScale.Scale = 0.8
    local v42 = TweenService:Create(v40._iconScale, v7, { Scale = v40._iconOriginalScale * 1.2 })
    v40._iconTrove:Add(function() -- line 151 | captures: v42
        v42:Cancel()
        v42:Destroy()
    end)
    v40._iconTrove:Add(v42.Completed:Connect(function(v43) -- line 155 | captures: v40, TweenService, v8
        if not (v43 == Enum.PlaybackState.Completed and v40._selectedCount == 3) then
            return
        end
        local v44 = TweenService:Create(v40._iconScale, v8, { Scale = v40._iconOriginalScale })
        v40._iconTrove:Add(function() -- line 160 | captures: v44
            v44:Cancel()
            v44:Destroy()
        end)
        v44:Play()
    end))
    v42:Play()
end

function v2.Update(v45, v46, v47) -- line 168 | captures: t
    t.strict(t.array(t.boolean))(v46)
    local v48 = #v46 == 3
    assert(v48, "Fuse progress needs one flag per input slot")
    t.strict(t.optional(t.string))(v47)
    local v49 = 0
    for v50, v51 in ipairs(v46) do
        if v51 then
            v49 += 1
        end
    end
    if v49 == 0 then
        v45._icon.Image = v45._iconOriginalImage
    else
        local v52 = if v47 == nil then false else v47 ~= ""
        assert(v52, "Selected FuseMachine category requires an egg icon")
        v45._icon.Image = v47
    end
    local _selectedCount = v45._selectedCount
    local v53 = _selectedCount ~= nil
    v45:_setBarFilled(1, v46[1], v53)
    local v54 = _selectedCount ~= nil
    v45:_setBarFilled(2, v46[2], v54)
    local v55 = _selectedCount ~= nil
    v45:_setBarFilled(3, v46[3], v55)
    if _selectedCount ~= v49 then
        v45._selectedCount = v49
        if _selectedCount == nil then
            v45:_setOutputProgress(v49, false)
            if v49 == 3 then
                v45:_setReadyIcon(false)
            else
                v45:_setIncompleteIcon()
            end
        else
            v45:_setOutputProgress(v49, true)
            if v49 == 3 then
                v45:_setReadyIcon(true)
            else
                v45:_setIncompleteIcon()
            end
        end
    end
end

function v2.Destroy(v56) -- line 215 | captures: v1
    v56._trove:Destroy()
    for v57, v58 in ipairs(v56._barFills) do
        v58.ImageTransparency = v56._barLitTransparencies[v57]
        v58.Visible = v56._barOriginalVisible[v57]
    end
    v56._outputFill.Position = v56._outputOriginalPosition
    v56._outputFill.Size = v56._outputOriginalSize
    v56._icon.Image = v56._iconOriginalImage
    v56._icon.ImageTransparency = v56._iconOriginalTransparency
    v56._icon.ImageColor3 = v56._iconOriginalColor
    v56._icon.BackgroundColor3 = v56._iconOriginalBackgroundColor
    v1:AtTrace():Log("Destroyed FuseMachine progress presentation")
end

return v2
