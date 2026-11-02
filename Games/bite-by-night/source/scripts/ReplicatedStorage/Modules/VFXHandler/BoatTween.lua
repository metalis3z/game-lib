-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local RunService = game:GetService("RunService")
local m_TweenFunctions = require(script.TweenFunctions)
local m_Lerps = require(script.Lerps)
local Heartbeat = RunService.Heartbeat
local v5 = {}
local v_u_6 = {
    ["Heartbeat"] = true,
    ["Stepped"] = true,
    ["RenderStepped"] = true
}
if not RunService:IsClient() then
    v_u_6.RenderStepped = nil
end
local v_u_7 = {
    ["FabricAccelerate"] = {
        ["In"] = m_TweenFunctions.InFabricAccelerate,
        ["Out"] = m_TweenFunctions.OutFabricAccelerate,
        ["InOut"] = m_TweenFunctions.InOutFabricAccelerate,
        ["OutIn"] = m_TweenFunctions.OutInFabricAccelerate
    },
    ["UWPAccelerate"] = {
        ["In"] = m_TweenFunctions.InUWPAccelerate,
        ["Out"] = m_TweenFunctions.OutUWPAccelerate,
        ["InOut"] = m_TweenFunctions.InOutUWPAccelerate,
        ["OutIn"] = m_TweenFunctions.OutInUWPAccelerate
    },
    ["Circ"] = {
        ["In"] = m_TweenFunctions.InCirc,
        ["Out"] = m_TweenFunctions.OutCirc,
        ["InOut"] = m_TweenFunctions.InOutCirc,
        ["OutIn"] = m_TweenFunctions.OutInCirc
    },
    ["RevBack"] = {
        ["In"] = m_TweenFunctions.InRevBack,
        ["Out"] = m_TweenFunctions.OutRevBack,
        ["InOut"] = m_TweenFunctions.InOutRevBack,
        ["OutIn"] = m_TweenFunctions.OutInRevBack
    },
    ["Spring"] = {
        ["In"] = m_TweenFunctions.InSpring,
        ["Out"] = m_TweenFunctions.OutSpring,
        ["InOut"] = m_TweenFunctions.InOutSpring,
        ["OutIn"] = m_TweenFunctions.OutInSpring
    },
    ["Standard"] = {
        ["In"] = m_TweenFunctions.InStandard,
        ["Out"] = m_TweenFunctions.OutStandard,
        ["InOut"] = m_TweenFunctions.InOutStandard,
        ["OutIn"] = m_TweenFunctions.OutInStandard
    },
    ["StandardExpressive"] = {
        ["In"] = m_TweenFunctions.InStandardExpressive,
        ["Out"] = m_TweenFunctions.OutStandardExpressive,
        ["InOut"] = m_TweenFunctions.InOutStandardExpressive,
        ["OutIn"] = m_TweenFunctions.OutInStandardExpressive
    },
    ["Linear"] = {
        ["In"] = m_TweenFunctions.InLinear,
        ["Out"] = m_TweenFunctions.OutLinear,
        ["InOut"] = m_TweenFunctions.InOutLinear,
        ["OutIn"] = m_TweenFunctions.OutInLinear
    },
    ["ExitProductive"] = {
        ["In"] = m_TweenFunctions.InExitProductive,
        ["Out"] = m_TweenFunctions.OutExitProductive,
        ["InOut"] = m_TweenFunctions.InOutExitProductive,
        ["OutIn"] = m_TweenFunctions.OutInExitProductive
    },
    ["Deceleration"] = {
        ["In"] = m_TweenFunctions.InDeceleration,
        ["Out"] = m_TweenFunctions.OutDeceleration,
        ["InOut"] = m_TweenFunctions.InOutDeceleration,
        ["OutIn"] = m_TweenFunctions.OutInDeceleration
    },
    ["Smoother"] = {
        ["In"] = m_TweenFunctions.InSmoother,
        ["Out"] = m_TweenFunctions.OutSmoother,
        ["InOut"] = m_TweenFunctions.InOutSmoother,
        ["OutIn"] = m_TweenFunctions.OutInSmoother
    },
    ["FabricStandard"] = {
        ["In"] = m_TweenFunctions.InFabricStandard,
        ["Out"] = m_TweenFunctions.OutFabricStandard,
        ["InOut"] = m_TweenFunctions.InOutFabricStandard,
        ["OutIn"] = m_TweenFunctions.OutInFabricStandard
    },
    ["RidiculousWiggle"] = {
        ["In"] = m_TweenFunctions.InRidiculousWiggle,
        ["Out"] = m_TweenFunctions.OutRidiculousWiggle,
        ["InOut"] = m_TweenFunctions.InOutRidiculousWiggle,
        ["OutIn"] = m_TweenFunctions.OutInRidiculousWiggle
    },
    ["MozillaCurve"] = {
        ["In"] = m_TweenFunctions.InMozillaCurve,
        ["Out"] = m_TweenFunctions.OutMozillaCurve,
        ["InOut"] = m_TweenFunctions.InOutMozillaCurve,
        ["OutIn"] = m_TweenFunctions.OutInMozillaCurve
    },
    ["Expo"] = {
        ["In"] = m_TweenFunctions.InExpo,
        ["Out"] = m_TweenFunctions.OutExpo,
        ["InOut"] = m_TweenFunctions.InOutExpo,
        ["OutIn"] = m_TweenFunctions.OutInExpo
    },
    ["Sine"] = {
        ["In"] = m_TweenFunctions.InSine,
        ["Out"] = m_TweenFunctions.OutSine,
        ["InOut"] = m_TweenFunctions.InOutSine,
        ["OutIn"] = m_TweenFunctions.OutInSine
    },
    ["Cubic"] = {
        ["In"] = m_TweenFunctions.InCubic,
        ["Out"] = m_TweenFunctions.OutCubic,
        ["InOut"] = m_TweenFunctions.InOutCubic,
        ["OutIn"] = m_TweenFunctions.OutInCubic
    },
    ["EntranceExpressive"] = {
        ["In"] = m_TweenFunctions.InEntranceExpressive,
        ["Out"] = m_TweenFunctions.OutEntranceExpressive,
        ["InOut"] = m_TweenFunctions.InOutEntranceExpressive,
        ["OutIn"] = m_TweenFunctions.OutInEntranceExpressive
    },
    ["Elastic"] = {
        ["In"] = m_TweenFunctions.InElastic,
        ["Out"] = m_TweenFunctions.OutElastic,
        ["InOut"] = m_TweenFunctions.InOutElastic,
        ["OutIn"] = m_TweenFunctions.OutInElastic
    },
    ["Quint"] = {
        ["In"] = m_TweenFunctions.InQuint,
        ["Out"] = m_TweenFunctions.OutQuint,
        ["InOut"] = m_TweenFunctions.InOutQuint,
        ["OutIn"] = m_TweenFunctions.OutInQuint
    },
    ["EntranceProductive"] = {
        ["In"] = m_TweenFunctions.InEntranceProductive,
        ["Out"] = m_TweenFunctions.OutEntranceProductive,
        ["InOut"] = m_TweenFunctions.InOutEntranceProductive,
        ["OutIn"] = m_TweenFunctions.OutInEntranceProductive
    },
    ["Bounce"] = {
        ["In"] = m_TweenFunctions.InBounce,
        ["Out"] = m_TweenFunctions.OutBounce,
        ["InOut"] = m_TweenFunctions.InOutBounce,
        ["OutIn"] = m_TweenFunctions.OutInBounce
    },
    ["Smooth"] = {
        ["In"] = m_TweenFunctions.InSmooth,
        ["Out"] = m_TweenFunctions.OutSmooth,
        ["InOut"] = m_TweenFunctions.InOutSmooth,
        ["OutIn"] = m_TweenFunctions.OutInSmooth
    },
    ["Back"] = {
        ["In"] = m_TweenFunctions.InBack,
        ["Out"] = m_TweenFunctions.OutBack,
        ["InOut"] = m_TweenFunctions.InOutBack,
        ["OutIn"] = m_TweenFunctions.OutInBack
    },
    ["Quart"] = {
        ["In"] = m_TweenFunctions.InQuart,
        ["Out"] = m_TweenFunctions.OutQuart,
        ["InOut"] = m_TweenFunctions.InOutQuart,
        ["OutIn"] = m_TweenFunctions.OutInQuart
    },
    ["StandardProductive"] = {
        ["In"] = m_TweenFunctions.InStandardProductive,
        ["Out"] = m_TweenFunctions.OutStandardProductive,
        ["InOut"] = m_TweenFunctions.InOutStandardProductive,
        ["OutIn"] = m_TweenFunctions.OutInStandardProductive
    },
    ["Quad"] = {
        ["In"] = m_TweenFunctions.InQuad,
        ["Out"] = m_TweenFunctions.OutQuad,
        ["InOut"] = m_TweenFunctions.InOutQuad,
        ["OutIn"] = m_TweenFunctions.OutInQuad
    },
    ["FabricDecelerate"] = {
        ["In"] = m_TweenFunctions.InFabricDecelerate,
        ["Out"] = m_TweenFunctions.OutFabricDecelerate,
        ["InOut"] = m_TweenFunctions.InOutFabricDecelerate,
        ["OutIn"] = m_TweenFunctions.OutInFabricDecelerate
    },
    ["Acceleration"] = {
        ["In"] = m_TweenFunctions.InAcceleration,
        ["Out"] = m_TweenFunctions.OutAcceleration,
        ["InOut"] = m_TweenFunctions.InOutAcceleration,
        ["OutIn"] = m_TweenFunctions.OutInAcceleration
    },
    ["SoftSpring"] = {
        ["In"] = m_TweenFunctions.InSoftSpring,
        ["Out"] = m_TweenFunctions.OutSoftSpring,
        ["InOut"] = m_TweenFunctions.InOutSoftSpring,
        ["OutIn"] = m_TweenFunctions.OutInSoftSpring
    },
    ["ExitExpressive"] = {
        ["In"] = m_TweenFunctions.InExitExpressive,
        ["Out"] = m_TweenFunctions.OutExitExpressive,
        ["InOut"] = m_TweenFunctions.InOutExitExpressive,
        ["OutIn"] = m_TweenFunctions.OutInExitExpressive
    },
    ["Sharp"] = {
        ["In"] = m_TweenFunctions.InSharp,
        ["Out"] = m_TweenFunctions.OutSharp,
        ["InOut"] = m_TweenFunctions.InOutSharp,
        ["OutIn"] = m_TweenFunctions.OutInSharp
    }
}
local function v_u_11(p8)
    local v9 = math.max(p8 or 0.03, 0)
    local v10 = v9
    while v9 > 0 do
        v9 = v9 - Heartbeat:Wait()
    end
    return v10 - v9
end
function v5.Create(p_u_12, p13)
    if not p_u_12 or typeof(p_u_12) ~= "Instance" then
        return warn("Invalid object to tween:", p_u_12)
    end
    local v_u_14 = type(p13) == "table" and (p13 or {}) or {}
    local Stepped = v_u_6[v_u_14.StepType] and RunService[v_u_14.StepType] or RunService.Stepped
    local v_u_16 = v_u_7[v_u_14.EasingStyle or "Quad"][v_u_14.EasingDirection or "In"]
    local Time = v_u_14.Time
    local v18 = type(Time) == "number" and (v_u_14.Time or 1) or 1
    local v_u_19 = math.max(v18, 0.001)
    local Goal = v_u_14.Goal
    local v21 = type(Goal) == "table" and (v_u_14.Goal or {}) or {}
    local DelayTime = v_u_14.DelayTime
    local v_u_23
    if type(DelayTime) == "number" and v_u_14.DelayTime > 0.027 then
        v_u_23 = v_u_14.DelayTime
    else
        v_u_23 = false
    end
    local RepeatCount = v_u_14.RepeatCount
    local v25
    if type(RepeatCount) == "number" then
        local RepeatCount_0 = v_u_14.RepeatCount
        v25 = math.max(RepeatCount_0, -1) or 0
    else
        v25 = 0
    end
    local v_u_27 = v25 + 1
    local v_u_28 = {}
    for v29, v30 in pairs(v21) do
        v_u_28[v29] = m_Lerps[typeof(v30)](p_u_12[v29], v30)
    end
    local v_u_31 = Instance.new("BindableEvent")
    local v_u_32 = Instance.new("BindableEvent")
    local v_u_33 = Instance.new("BindableEvent")
    local v_u_34 = nil
    local v_u_35 = os.clock()
    local v_u_36 = 0
    local v_u_37 = {
        ["Instance"] = p_u_12,
        ["PlaybackState"] = Enum.PlaybackState.Begin,
        ["Completed"] = v_u_31.Event,
        ["Resumed"] = v_u_33.Event,
        ["Stopped"] = v_u_32.Event,
        ["Destroy"] = function()
            if v_u_34 then
                v_u_34:Disconnect()
                v_u_34 = nil
            end
            v_u_31:Destroy()
            v_u_32:Destroy()
            v_u_33:Destroy()
            v_u_37 = nil
        end
    }
    local v_u_38 = false
    local v_u_39 = 0
    local function v_u_51(p40, p_u_41)
        if v_u_34 then
            v_u_34:Disconnect()
            v_u_34 = nil
        end
        local v_u_42 = p40 or 1
        if v_u_27 == 0 or v_u_27 >= v_u_42 then
            v_u_39 = v_u_42
            if p_u_41 then
                v_u_38 = true
            end
            if v_u_23 then
                v_u_37.PlaybackState = Enum.PlaybackState.Delayed;
                (v_u_23 < 2 and v_u_11 or wait)(v_u_23)
            end
            v_u_35 = os.clock() - v_u_36
            v_u_34 = Stepped:Connect(function()
                v_u_36 = os.clock() - v_u_35
                if v_u_19 <= v_u_36 then
                    if p_u_41 then
                        for v43, v44 in pairs(v_u_28) do
                            p_u_12[v43] = v44(0)
                        end
                    else
                        for v45, v46 in pairs(v_u_28) do
                            p_u_12[v45] = v46(1)
                        end
                    end
                    v_u_34:Disconnect()
                    v_u_34 = nil
                    if p_u_41 then
                        v_u_36 = 0
                        v_u_51(v_u_42 + 1, false)
                        return
                    elseif v_u_14.Reverses then
                        v_u_36 = 0
                        v_u_51(v_u_42, true)
                    else
                        v_u_36 = 0
                        v_u_51(v_u_42 + 1, false)
                    end
                else
                    local v47 = v_u_16(p_u_41 and 1 - v_u_36 / v_u_19 or v_u_36 / v_u_19)
                    local v48 = math.clamp(v47, 0, 1)
                    for v49, v50 in pairs(v_u_28) do
                        p_u_12[v49] = v50(v48)
                    end
                    return
                end
            end)
            v_u_37.PlaybackState = Enum.PlaybackState.Playing
        else
            v_u_37.PlaybackState = Enum.PlaybackState.Completed
            v_u_31:Fire()
            v_u_38 = false
            v_u_39 = 1
        end
    end
    function v_u_37.Play()
        v_u_36 = 0
        v_u_51(1, false)
    end
    function v_u_37.Stop()
        if v_u_34 then
            v_u_34:Disconnect()
            v_u_34 = nil
            v_u_37.PlaybackState = Enum.PlaybackState.Cancelled
            v_u_32:Fire()
        end
    end
    function v_u_37.Resume()
        v_u_51(v_u_39, v_u_38)
        v_u_33:Fire()
    end
    return v_u_37
end
return v5
