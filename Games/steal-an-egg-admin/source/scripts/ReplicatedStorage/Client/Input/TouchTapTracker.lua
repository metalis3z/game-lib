-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

v1.__index = v1
v1.__class = "TouchTapTracker"

local v2 = t.strict(t.optional(t.table))
local v3 = t.strict(t.optional(t.number))
local v4 = Log.new()

local function requireTouch(v5) -- line 15
    local v6 = v5.UserInputType == Enum.UserInputType.Touch
    assert(v6)
end

local function travelled(v7, v8) -- line 19
    local origin = v7.origin
    if origin then
        return (v8.Position - origin).Magnitude
    end
    return nil
end

function v1.new(v9) -- line 26 | captures: v1, v2, v3, v4
    v2(v9)
    local v10
    if v9 then
        v3(v9.MaxMovement)
        v3(v9.MaxDuration)
        v10 = v9
    else
        v10 = {}
    end
    local v11 = {}
    local v12 = setmetatable(v11, v1)
    v12.slop = v10.MaxMovement or 16
    v12.holdLimit = v10.MaxDuration or 0.35
    v12.claimed = nil
    v12.pressedAt = 0
    v12.origin = nil
    v12.aborted = false
    v4:AtDebug():Log("tap tracker ready")
    return v12
end

local function Reset(v13) -- line 46
    v13.claimed = nil
    v13.pressedAt = 0
    v13.origin = nil
    v13.aborted = false
end

v1.Reset = Reset

local function IsTrackingInput(v14, v15) -- line 52
    return v14.claimed == v15
end

v1.IsTrackingInput = IsTrackingInput

local function IsCancelled(v16) -- line 56
    return v16.aborted
end

v1.IsCancelled = IsCancelled

local function Begin(v17, v18) -- line 59
    local v19 = v18.UserInputType == Enum.UserInputType.Touch
    assert(v19)
    v17.claimed = v18
    v17.pressedAt = os.clock()
    v17.origin = v18.Position
    v17.aborted = false
end

v1.Begin = Begin

local function Update(v20, v21) -- line 67
    local v22 = v21.UserInputType == Enum.UserInputType.Touch
    assert(v22)
    local Magnitude, v23
    if v20.claimed == v21 then
        if v20.aborted then
            v23 = true
        else
            local origin = v20.origin
            if origin then
                Magnitude = (v21.Position - origin).Magnitude
            end
            v23 = false
        end
    else
        v23 = true
    end
    if v23 then
        return false
    end
    local v24 = if Magnitude == nil then true else v20.slop < Magnitude
    v20.aborted = v24
    return not v24
end

v1.Update = Update

local function Evaluate(v25, v26, v27) -- line 84
    local v28 = v26.UserInputType == Enum.UserInputType.Touch
    assert(v28)
    local origin = v25.origin
    local v29 = if origin then (v26.Position - origin).Magnitude else nil
    local pressedAt = v25.pressedAt
    local v30 = not v27
    if v30 then
        if v25.claimed == v26 then
            v30 = not v25.aborted
            if v30 then
                if v29 == nil then
                    v30 = false
                elseif pressedAt > 0 and os.clock() - pressedAt <= v25.holdLimit then
                    v30 = v29 <= v25.slop
                else
                    v30 = false
                end
            end
        else
            v30 = false
        end
    end
    v25:Reset()
    return v30
end

v1.Evaluate = Evaluate
return v1
