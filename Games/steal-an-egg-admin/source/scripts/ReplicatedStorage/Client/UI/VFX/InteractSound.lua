-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage:WaitForChild("Shared").Audio)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    pointer = Enum.UserInputType.MouseButton1,
    touch = Enum.UserInputType.Touch,
    gamepad = Enum.KeyCode.ButtonA
}
local v2 = {
    flat = 1,
    low = 95,
    high = 105,
    divisor = 100
}

local function matchesPhase(v3, v4) -- line 11 | captures: v1
    local UserInputType = v3.UserInputType
    if UserInputType ~= v1.pointer then
        if UserInputType == v1.touch then
            if v3.UserInputState ~= v4 then
                return v3.KeyCode == v1.gamepad
            end
        else
            return v3.KeyCode == v1.gamepad
        end
    end
    return true
end

local function wirePhase(v5, v6, v7) -- line 23 | captures: v1
    return v5:Connect(function(v8) -- line 24 | captures: v6, v7, v1
        local UserInputType = v8.UserInputType
        local v9
        if UserInputType == v1.pointer then
            v9 = true
        elseif UserInputType == v1.touch then
            if v8.UserInputState == v6 then
            end
            v9 = true
        else
            v9 = v8.KeyCode == v1.gamepad
        end
        if v9 then
            v7()
        end
    end)
end

local v10 = {}

function v10.mousedown(v11, v12, v13) -- line 41 | captures: wirePhase
    return wirePhase(v11.InputBegan, Enum.UserInputState.Begin, v13)
end

function v10.mouseup(v14, v15, v16) -- line 44 | captures: wirePhase
    return wirePhase(v14.InputEnded, Enum.UserInputState.End, v16)
end

local function mouseenter(v17, v18, v19) -- line 47
    return v17.MouseEnter:Connect(v18)
end

v10.mouseenter = mouseenter

local function mouseleave(v20, v21, v22) -- line 50
    return v20.MouseLeave:Connect(v21)
end

v10.mouseleave = mouseleave

local function mouseclick(v23, v24, v25) -- line 53
    return v23.Activated:Connect(v24)
end

v10.mouseclick = mouseclick
return function(v26, v27, v28, v29, v30) -- line 57 | captures: Audio, t, v10
    t.strict(t.instanceIsA("GuiButton"))(v26)
    t.strict(t.string)(v27)
    t.strict(t.string)(v28)
    t.strict(t.optional(t.number))(v29)
    t.strict(t.optional(t.boolean))(v30)
    local v31 = v29 or 0.15
    local v32
    if v30 == nil then
        v32 = false
    else
        v32 = v30
        if not v30 then
            v32 = false
        end
    end

    local function nextPitch() -- line 78 | captures: v32
        if v32 then
            return math.random(95, 105) / 100
        end
        return 1
    end

    local function play(v33) -- line 84 | captures: v32, v28, Audio
        local v34 = {}
        if v32 then
            v34.PlaybackSpeed = math.random(95, 105) / 100
        else
            v34.PlaybackSpeed = 1
        end
        v34.Volume = v33
        Audio.Play(v28, script, v34)
    end

    local v35 = v10[string.lower(v27)]
    local v36
    if v35 then
        v36 = v35(v26, function() -- line 101 | captures: v32, v28, v31, Audio
            local v37 = {}
            if v32 then
                v37.PlaybackSpeed = math.random(95, 105) / 100
            else
                v37.PlaybackSpeed = 1
            end
            v37.Volume = v31
            Audio.Play(v28, script, v37)
        end, function() -- line 113 | captures: v32, v28, v31, Audio
            local v38 = {}
            if v32 then
                v38.PlaybackSpeed = math.random(95, 105) / 100
            else
                v38.PlaybackSpeed = 1
            end
            v38.Volume = v31 * 2
            Audio.Play(v28, script, v38)
        end)
    end
    local v39 = false
    return function() -- line 128 | captures: v36, v39
        if not v39 then
            v39 = false
            if v36 then
                v36:Disconnect()
            end
        end
    end
end
