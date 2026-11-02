-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local ScaledSize = Enum.StrokeSizingMode.ScaledSize
local v1 = Color3.new(1, 1, 1)
local v2 = {
    TextLabel = true,
    TextBox = true,
    TextButton = true
}
local v3 = {}

v3.__index = v3

local GuiObject = t.instanceIsA("GuiObject")
local v4 = t.strict(t.union(GuiObject, t.instanceIsA("UIStroke")))
local v5 = t.strict(t.number)
local v6 = t.strict(t.Color3)

local function track(v7) -- line 19
    return {
        response = 1,
        now = v7,
        goal = v7
    }
end

local function aim(v8, v9, v10) -- line 22
    v8.goal = v9
    v8.response = math.clamp(v10, 0, 1)
end

local function stepNumber(v11, v12) -- line 26
    v11.now += (v11.goal - v11.now) * v11.response * v12
    return v11.now
end

local function stepColor(v13, v14) -- line 30
    v13.now = v13.now:Lerp(v13.goal, v13.response * v14)
    return v13.now
end

local function borrowOutline(v15) -- line 34
    local UIStroke = v15:FindFirstChildWhichIsA("UIStroke")
    if UIStroke then
        return UIStroke
    end
    return Instance.new("UIStroke")
end

local function release(v16) -- line 41
    v16.driver:Disconnect()
    if v16.outline then
        v16.outline:Destroy()
        v16.outline = nil
    end
end

local function advance(v17, v18) -- line 48 | captures: ScaledSize
    local outline = v17.outline
    local tint = v17.tint
    tint.now = tint.now:Lerp(tint.goal, tint.response * v18)
    outline.Color = tint.now
    local alpha = v17.alpha
    alpha.now += (alpha.goal - alpha.now) * alpha.response * v18
    outline.Transparency = alpha.now
    local width = v17.width
    width.now += (width.goal - width.now) * width.response * v18
    local now = width.now
    if outline.StrokeSizingMode ~= ScaledSize then
        outline.Thickness = now
    end
end

function v3.new(v19, v20, v21, v22) -- line 63 | captures: Heartbeat, ScaledSize, v1, v2, v3, v4, v5, v6
    v4(v19)
    v5(v20)
    if v21 then
        v6(v21)
    end
    if v22 then
        v5(v22)
    end
    local v23 = {
        isPaused = false,
        host = v19
    }
    v23.outline = v19:FindFirstChildWhichIsA("UIStroke") or Instance.new("UIStroke")
    v23.isTextHost = v2[v19.ClassName] == true
    local v24 = v21 or v1
    v23.tint = {
        response = 1,
        now = v24,
        goal = v24
    }
    local v25 = v22 or 0
    v23.alpha = {
        response = 1,
        now = v25,
        goal = v25
    }
    v23.width = {
        response = 1,
        now = v20,
        goal = v20
    }
    local v26 = setmetatable(v23, v3)
    v26.outline.Parent = v26.host
    v26.driver = Heartbeat:Connect(function(v27) -- line 93 | captures: v26, ScaledSize
        debug.profilebegin("EasyVisuals/outline")
        if v26.isPaused then
            return
        end
        local v28
        if v26.host then
            if v26.host.Parent == nil then
                v28 = true
            else
                local outline = v26.outline
                local tint = v26.tint
                tint.now = tint.now:Lerp(tint.goal, tint.response * v27)
                outline.Color = tint.now
                local alpha = v26.alpha
                alpha.now += (alpha.goal - alpha.now) * alpha.response * v27
                outline.Transparency = alpha.now
                local width = v26.width
                width.now += (width.goal - width.now) * width.response * v27
                local now = width.now
                if outline.StrokeSizingMode ~= ScaledSize then
                    outline.Thickness = now
                end
                v28 = false
            end
        else
            v28 = true
        end
        if not v28 then
            debug.profileend()
        else
            v26.driver:Disconnect()
            if v26.outline then
                v26.outline:Destroy()
                v26.outline = nil
            end
        end
    end)
    return v26
end

local function Destroy(v29) -- line 126
    v29.driver:Disconnect()
    if v29.outline then
        v29.outline:Destroy()
        v29.outline = nil
    end
end

v3.Destroy = Destroy

local function Suspend(v30) -- line 133
    v30.isPaused = true
end

v3.Suspend = Suspend

local function Wake(v31) -- line 136
    v31.isPaused = false
end

v3.Wake = Wake

function v3.EaseWidth(v32, v33, v34) -- line 139 | captures: v5
    v5(v33)
    v5(v34)
    local width = v32.width
    width.goal = v33
    width.response = math.clamp(v34, 0, 1)
end

function v3.EaseAlpha(v35, v36, v37) -- line 146 | captures: v5
    v5(v36)
    v5(v37)
    local alpha = v35.alpha
    alpha.goal = v36
    alpha.response = math.clamp(v37, 0, 1)
end

function v3.EaseTint(v38, v39, v40) -- line 153 | captures: v5, v6
    v6(v39)
    v5(v40)
    local tint = v38.tint
    tint.goal = v39
    tint.response = math.clamp(v40, 0, 1)
end

return table.freeze(v3)
