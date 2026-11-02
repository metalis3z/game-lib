-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TweenService = game:GetService("TweenService")
local Sine = Enum.EasingStyle.Sine
local InOut = Enum.EasingDirection.InOut
local v1 = {
    1,
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
}
local v2 = { expo = Enum.EasingStyle.Exponential }
local v3 = {}
local v4 = {
    property = "Scale",
    valueClass = "NumberValue",
    read = function(v5) -- read | line 15
        return v5:GetScale()
    end,
    write = function(v6, v7) -- write | line 18
        v6:ScaleTo(v7)
    end
}
local v8 = {
    property = "CFrame",
    valueClass = "CFrameValue",
    read = function(v9) -- read | line 25
        return v9:GetPivot()
    end,
    write = function(v10, v11) -- write | line 28
        v10:PivotTo(v11)
    end
}
local v12 = {
    property = "Position",
    valueClass = "Vector3Value",
    read = function(v13) -- read | line 35
        return v13:GetPivot().Position
    end,
    write = function(v14, v15) -- write | line 38
        local v16 = v14:GetPivot()
        v14:PivotTo(v16 - v16.Position + v15)
    end
}

v3[1] = v4
v3[2] = v8
v3[3] = v12

local v17 = {
    Is = function(v18, v19) -- Is | line 47
        if typeof(v18) == "Instance" and typeof(v19) == "string" then
            return (v18:IsA(v19))
        end
        return false
    end,
    Weld = function(v20, v21, v22) -- Weld | line 51
        if v20.Anchored then
            local new = Instance.new
            local v23 = if v20.Anchored or v21.Anchored then "Motor6D" else "ManualWeld"
            local v24 = new(v23)
            v24.Part0 = v20
            v24.Part1 = v21
            v24.C0 = v20.CFrame:Inverse() * v21.CFrame
            v24.Parent = v20
            return v24
        end
        if v21.Anchored or v22 then
            return
        end
        local WeldConstraint = Instance.new("WeldConstraint")
        WeldConstraint.Part0 = v20
        WeldConstraint.Part1 = v21
        WeldConstraint.Parent = v20
        return WeldConstraint
    end
}

local function animatorFor(v25) -- line 78
    if v25:IsA("Animator") then
        return v25
    end
    local v26 = if v25:IsA("Player") then v25.Character else nil
    for v27, v28 in { "Humanoid", "AnimationController" } do
        local v29 = v26 and v26:FindFirstChildOfClass(v28)
        local v30 = v29 and v29:FindFirstChildOfClass("Animator")
        if v30 then
            return v30
        end
    end
    if v25:IsA("Humanoid") or v25:IsA("AnimationController") then
        local Animator = v25:FindFirstChildOfClass("Animator")
        local v31 = Animator ~= nil
        local v32 = ("%* has no Animator beneath it"):format((v25:GetFullName()))
        assert(v31, v32)
        return Animator
    end
    local Animator = v25:FindFirstChildOfClass("Animator")
    if Animator then
        return Animator
    end
    local AnimationController = v25:FindFirstChildOfClass("AnimationController")
    local v33 = AnimationController ~= nil
    local v34 = ("%* offers no way to play an animation"):format((v25:GetFullName()))
    assert(v33, v34)
    local Animator_2 = AnimationController:FindFirstChildOfClass("Animator")
    local v35 = Animator_2 ~= nil
    local v36 = ("%* has no Animator beneath it"):format((AnimationController:GetFullName()))
    assert(v35, v36)
    return Animator_2
end

function v17.PlayAnimation(v37, v38, v39, v40, v41, v42) -- line 123 | captures: animatorFor
    local v43 = animatorFor(v38)
    local Animation
    if typeof(v37) == "number" then
        Animation = Instance.new("Animation")
        if typeof(v37) == "string" then
            Animation.AnimationId = v37
        else
            Animation.AnimationId = "rbxassetid://" .. tostring(v37)
        end
    elseif typeof(v37) == "string" then
    else
        Animation = v37
    end
    local v44 = v43:LoadAnimation(Animation)
    if v40 ~= nil then
        v44.Looped = v40 == true
    end
    v44:Play(v41, v42, v39 or 1)
    return v44
end

local function settleEasing(v45) -- line 145 | captures: Sine, InOut, v2
    if v45[2] then
        local v46 = v45[2]
        if type(v46) == "string" then
            local v47 = v2[string.lower(v45[2])]
            if not v47 then
                local v48 = Enum.EasingStyle[v45[2]]
                local v49 = ("\"%*\" is not an easing style"):format(v45[2])
                v47 = assert(v48, v49)
            end
            v45[2] = v47
        end
    else
        v45[2] = Sine
    end
    if v45[3] then
        local v50 = v45[3]
        if typeof(v50) == "string" then
            local v51 = Enum.EasingDirection[v45[3]]
            local v52 = ("\"%*\" is not an easing direction"):format(v45[3])
            v45[3] = assert(v51, v52)
        end
    else
        v45[3] = InOut
    end
end

local function proxyFor(v53, v54) -- line 163 | captures: v3
    for v55, v56 in v3 do
        if v54[v56.property] then
            local v57 = Instance.new(v56.valueClass)
            v57.Value = v56.read(v53)
            local Changed = v57.Changed
            local v58 = v56
            Changed:Connect(function() -- line 172 | captures: v53, v57, v58
                if v53.Parent then
                    v58.write(v53, v57.Value)
                end
            end)
            v54.Value = v54[v56.property]
            v54[v56.property] = nil
            return v57
        end
    end
    return nil
end

function v17.Tween(v59, v60, v61, v62) -- line 184 | captures: TweenService, v1, settleEasing, proxyFor
    local v63 = {}
    local v64 = if type(v59) == "table" then v59 else { v59 }
    local v65 = {}
    for v66, v67 in ipairs(v64) do
        local v68
        if v61 then
            v68 = v61
            settleEasing(v61)
        else
            v68 = v1
        end
        v63[1] = nil
        local v69
        if v67:IsA("Model") then
            v69 = proxyFor(v67, v60)
            v63[1] = v69
        end
        local v70 = TweenInfo.new(table.unpack(v68))
        local v71 = TweenService:Create(v69 or v67, v70, v60)
        if v69 then
            v71.Completed:Once(((function(v72)
                return function() -- line 209 | captures: v72
                    v72[1]:Destroy()
                end
            end)(v63)))
        end
        if v62 then
            task.delay(v62, function() -- line 216 | captures: v71
                v71:Play()
            end)
        else
            v71:Play()
        end
        table.insert(v65, v71)
        local v73 = v63[1]
        local v74 = {}
        v74[1] = v73
        v63 = v74
    end
    return table.unpack(v65)
end

function v17.TweenOnce(v75, v76, v77, v78) -- line 224 | captures: TweenService
    local v79 = TweenService:Create(v75, v76, v77)
    v79.Completed:Once(function() -- line 226 | captures: v79
        v79:Destroy()
    end)
    if v78 ~= false then
        v79:Play()
    end
    return v79
end

return table.freeze(v17)
