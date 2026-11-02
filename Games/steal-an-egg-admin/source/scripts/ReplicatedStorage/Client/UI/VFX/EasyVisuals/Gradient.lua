-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local StopRamp = require(script.Parent.StopRamp)
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local v1 = {
    TextLabel = true,
    TextBox = true,
    TextButton = true
}
local v2 = {}

v2.__index = v2
v2.__class = "Gradient"

local GuiObject = t.instanceIsA("GuiObject")
local v3 = t.strict(t.union(GuiObject, t.instanceIsA("UIStroke")))
local v4 = t.strict(t.number)
local v5 = t.strict(t.ColorSequence)
local v6 = t.strict(t.union(t.number, t.NumberSequence))

local function flatAlpha(v7) -- line 21
    local v8 = {}
    v8[1] = NumberSequenceKeypoint.new(0, v7)
    v8[2] = NumberSequenceKeypoint.new(1, v7)
    return NumberSequence.new(v8)
end

local function settle(v9) -- line 28
    return (math.clamp(v9, 0, 1))
end

local function newSweep(v10) -- line 31
    return {
        now = 0,
        rate = 0,
        rateGoal = 0,
        response = v10
    }
end

local function holdAt(v11, v12, v13) -- line 34
    v11.goal = v12
    v11.rate = 0
    v11.rateGoal = 0
    v11.response = math.clamp(v13, 0, 1)
end

local function driftAt(v14, v15, v16) -- line 40
    v14.rateGoal = v15
    v14.goal = nil
    v14.response = math.clamp(v16, 0, 1)
end

local function step(v17, v18) -- line 45
    local goal = v17.goal
    if goal then
        v17.now += (goal - v17.now) * v17.response
    else
        v17.rate += (v17.rateGoal - v17.rate) * v17.response * v18
        v17.now += v17.rate * v18
    end
    return v17.now
end

local function borrowGradient(v19) -- line 55
    local UIGradient = v19:FindFirstChildWhichIsA("UIGradient")
    if UIGradient then
        return UIGradient
    end
    return Instance.new("UIGradient")
end

local function release(v20) -- line 62
    v20.driver:Disconnect()
    if v20.gradient then
        v20.gradient:Destroy()
        v20.gradient = nil
    end
end

local function resolvePalette(v21) -- line 69 | captures: StopRamp
    local v22 = StopRamp.Drift(v21.palette.Keypoints, StopRamp.Colour, v21.phase.now, 5, 100)
    v21.paletteResolved = ColorSequence.new(v22)
    return v21.paletteResolved
end

local function resolveAlpha(v23) -- line 74 | captures: StopRamp
    local Keypoints = v23.alphaStopsGoal.Keypoints
    if #Keypoints == 2 then
        if Keypoints[1].Value == Keypoints[2].Value then
            v23.alphaResolved = v23.alphaStopsGoal
            return v23.alphaStopsGoal
        end
        local Keypoints_2 = v23.alphaStops.Keypoints
        local v24 = StopRamp.Drift(Keypoints_2, StopRamp.Alpha, v23.alphaPhase.now, #Keypoints_2 + 1, (1/0))
        v23.alphaResolved = NumberSequence.new(v24)
    else
        local Keypoints = v23.alphaStops.Keypoints
        local v25 = StopRamp.Drift(Keypoints, StopRamp.Alpha, v23.alphaPhase.now, #Keypoints + 1, (1/0))
        v23.alphaResolved = NumberSequence.new(v25)
    end
    return v23.alphaResolved
end

local function advance(v26, v27) -- line 92 | captures: StopRamp, resolveAlpha
    if v26.paletteBlend == 1 then
        v26.palette = v26.paletteGoal
    else
        v26.palette = ColorSequence.new(StopRamp.Restripe(v26.paletteGoal.Keypoints, v26.palette.Keypoints, v26.paletteBlend, StopRamp.Colour))
    end
    if v26.alphaBlend == 1 then
        v26.alphaStops = v26.alphaStopsGoal
    end
    local gradient = v26.gradient
    local angle = v26.angle
    local goal = angle.goal
    if goal then
        angle.now += (goal - angle.now) * angle.response
    else
        angle.rate += (angle.rateGoal - angle.rate) * angle.response * v27
        angle.now += angle.rate * v27
    end
    gradient.Rotation = angle.now
    local phase = v26.phase
    local goal_2 = phase.goal
    if goal_2 then
        phase.now += (goal_2 - phase.now) * phase.response
    else
        phase.rate += (phase.rateGoal - phase.rate) * phase.response * v27
        phase.now += phase.rate * v27
    end
    local alphaPhase = v26.alphaPhase
    local goal_3 = alphaPhase.goal
    if goal_3 then
        alphaPhase.now += (goal_3 - alphaPhase.now) * alphaPhase.response
    else
        alphaPhase.rate += (alphaPhase.rateGoal - alphaPhase.rate) * alphaPhase.response * v27
        alphaPhase.now += alphaPhase.rate * v27
    end
    local v28 = StopRamp.Drift(v26.palette.Keypoints, StopRamp.Colour, v26.phase.now, 5, 100)
    v26.paletteResolved = ColorSequence.new(v28)
    gradient.Color = v26.paletteResolved
    gradient.Transparency = resolveAlpha(v26)
end

function v2.new(v29, v30, v31) -- line 135 | captures: Constants, Heartbeat, v1, v2, v3, v5, v6, flatAlpha, advance
    v3(v29)
    v5(v30)
    v6(v31)
    local v32 = #v30.Keypoints <= 19
    local v33 = ("a wash accepts at most %* colour stops"):format(19)
    assert(v32, v33)
    if typeof(v31) == "NumberSequence" then
        local v34 = #v31.Keypoints <= 19
        local v35 = ("a wash accepts at most %* alpha stops"):format(19)
        assert(v34, v35)
    end
    local v36
    if typeof(v31) == "number" then
        v36 = flatAlpha(v31)
    else
        v36 = v31
    end
    local v37 = {
        isPaused = false,
        frameDebt = 0.05,
        paletteBlend = 1,
        alphaBlend = 1,
        host = v29
    }
    v37.gradient = v29:FindFirstChildWhichIsA("UIGradient") or Instance.new("UIGradient")
    v37.isTextHost = v1[v29.ClassName] == true
    v37.palette = v30
    v37.paletteGoal = v30
    v37.alphaStops = v36
    v37.alphaStopsGoal = v36
    v37.phase = {
        now = 0,
        rate = 0,
        rateGoal = 0,
        response = 1
    }
    v37.alphaPhase = {
        now = 0,
        rate = 0,
        rateGoal = 0,
        response = 1
    }
    v37.angle = {
        now = 0,
        rate = 0,
        rateGoal = 0,
        response = 0
    }
    local v38 = setmetatable(v37, v2)
    v38.driver = Heartbeat:Connect(function(v39) -- line 177 | captures: v38, Constants, advance
        if not v38.isPaused then
            if Constants.IS_MOBILE then
                v38.frameDebt += v39
                if not (v38.frameDebt < 0.05) then
                    local frameDebt = v38.frameDebt
                    v38.frameDebt = 0
                end
            else
                debug.profilebegin("EasyVisuals/wash")
                if v38.host then
                    if v38.host.Parent == nil then
                        v38.driver:Disconnect()
                        if v38.gradient then
                            v38.gradient:Destroy()
                            v38.gradient = nil
                        end
                    else
                        advance(v38, v39)
                        debug.profileend()
                    end
                else
                    v38.driver:Disconnect()
                    if v38.gradient then
                        v38.gradient:Destroy()
                        v38.gradient = nil
                    end
                end
            end
        end
    end)
    v38.gradient.Parent = v38.host
    return v38
end

local function Destroy(v40) -- line 219
    v40.driver:Disconnect()
    if v40.gradient then
        v40.gradient:Destroy()
        v40.gradient = nil
    end
end

v2.Destroy = Destroy

local function Suspend(v41) -- line 226
    v41.isPaused = true
end

v2.Suspend = Suspend

local function Wake(v42) -- line 229
    v42.isPaused = false
end

v2.Wake = Wake

function v2.SetRotation(v43, v44, v45) -- line 232 | captures: v4
    v4(v44)
    v4(v45)
    local angle = v43.angle
    angle.goal = v44
    angle.rate = 0
    angle.rateGoal = 0
    angle.response = math.clamp(v45, 0, 1)
end

function v2.Spin(v46, v47, v48) -- line 241 | captures: v4
    v4(v47)
    v4(v48)
    local angle = v46.angle
    angle.rateGoal = v47
    angle.goal = nil
    angle.response = math.clamp(v48, 0, 1)
end

function v2.PhaseTo(v49, v50, v51) -- line 249 | captures: v4
    v4(v50)
    v4(v51)
    local phase = v49.phase
    phase.goal = v50
    phase.rate = 0
    phase.rateGoal = 0
    phase.response = math.clamp(v51, 0, 1)
end

function v2.Drift(v52, v53, v54) -- line 258 | captures: v4
    v4(v53)
    v4(v54)
    local phase = v52.phase
    phase.rateGoal = v53
    phase.goal = nil
    phase.response = math.clamp(v54, 0, 1)
end

function v2.AlphaPhaseTo(v55, v56, v57) -- line 266 | captures: v4
    v4(v56)
    v4(v57)
    local alphaPhase = v55.alphaPhase
    alphaPhase.goal = v56
    alphaPhase.rate = 0
    alphaPhase.rateGoal = 0
    alphaPhase.response = math.clamp(v57, 0, 1)
end

function v2.AlphaDrift(v58, v59, v60) -- line 275 | captures: v4
    v4(v59)
    v4(v60)
    local alphaPhase = v58.alphaPhase
    alphaPhase.rateGoal = v59
    alphaPhase.goal = nil
    alphaPhase.response = math.clamp(v60, 0, 1)
end

function v2.Recolor(v61, v62, v63) -- line 283 | captures: v5
    v5(v62)
    v61.paletteBlend = v63 or 1
    v61.paletteGoal = v62
    return v61.paletteGoal
end

function v2.Refade(v64, v65, v66) -- line 289 | captures: v4, flatAlpha
    assert(v65, "a wash needs alpha stops to fade toward")
    v4(v66)
    if typeof(v65) == "number" then
        v64.strandedAlphaGoal = flatAlpha(v65)
    elseif typeof(v65) == "NumberSequence" then
        v64.strandedAlphaGoal = v65
    else
        warn("a wash was handed alpha stops that were neither a number nor a NumberSequence")
    end
    v64.strandedAlphaResponse = math.clamp(v66, 0, 1)
end

return table.freeze(v2)
