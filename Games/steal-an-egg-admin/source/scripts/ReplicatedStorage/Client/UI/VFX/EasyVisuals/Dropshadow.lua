-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local v1 = Color3.new()
local v2 = UDim2.new(1, 0, 1, 0)
local v3 = Vector2.new(-4, 4)
local v4 = Vector2.new()
local v5 = {
    TextLabel = true,
    TextBox = true,
    TextButton = true
}
local v6 = {}

v6.__index = v6

local GuiObject = t.instanceIsA("GuiObject")
local v7 = t.strict(t.union(GuiObject, t.instanceIsA("UIStroke")))
local v8 = t.strict(t.number)
local v9 = t.strict(t.Color3)
local v10 = t.strict(t.Vector2)

local function aim(v11, v12, v13) -- line 22
    v11.goal = v12
    v11.response = math.clamp(v13, 0, 1)
end

local function stepLerpable(v14) -- line 26
    v14.now = v14.now:Lerp(v14.goal, v14.response)
    return v14.now
end

local function stepNumber(v15) -- line 30
    v15.now += (v15.goal - v15.now) * v15.response
    return v15.now
end

local function asPlacement(v16) -- line 34
    return UDim2.new(0, v16.X, 0, v16.Y)
end

local function release(v17) -- line 37
    v17.driver:Disconnect()
    if v17.shadow then
        v17.shadow:Destroy()
        v17.shadow = nil
    end
end

local function advance(v18) -- line 44
    local tint = v18.tint
    tint.now = tint.now:Lerp(tint.goal, tint.response)
    local now = tint.now
    local offset = v18.offset
    offset.now = offset.now:Lerp(offset.goal, offset.response)
    local now_2 = offset.now
    local v19 = UDim2.new(0, now_2.X, 0, now_2.Y)
    local alpha = v18.alpha
    alpha.now += (alpha.goal - alpha.now) * alpha.response
    local now_3 = alpha.now
    local shadow = v18.shadow
    shadow.Position = v19
    if v18.isTextHost then
        shadow.Text = v18.host.Text
        shadow.TextTransparency = now_3
        shadow.TextColor3 = now
    end
    shadow.ZIndex = v18.host.ZIndex - 1
end

function v6.new(v20, v21, v22, v23) -- line 64 | captures: Heartbeat, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, advance
    v7(v20)
    if v21 then
        v9(v21)
    end
    if v22 then
        v8(v22)
    end
    if v23 then
        v10(v23)
    end
    local v24 = {
        isPaused = false,
        host = v20,
        shadow = v20:Clone()
    }
    v24.isTextHost = v5[v20.ClassName] == true
    local v25 = { response = 1 }
    v25.now = v21 or v1
    v25.goal = v21 or v1
    v24.tint = v25
    v24.alpha = {
        response = 1,
        now = v22 or 0,
        goal = v22 or 0
    }
    local v26 = { response = 1 }
    v26.now = v23 or v3
    v26.goal = v23 or v4
    v24.offset = v26
    local v27 = setmetatable(v24, v6)
    local shadow = v27.shadow
    shadow.Size = v2
    shadow:ClearAllChildren()
    local now = v27.offset.now
    shadow.Position = UDim2.new(0, now.X, 0, now.Y)
    if v27.isTextHost then
        shadow.TextColor3 = v27.tint.now
    end
    shadow.Parent = v27.host
    v27.driver = Heartbeat:Connect(function() -- line 113 | captures: v27, advance
        debug.profilebegin("EasyVisuals/shadow")
        if not v27.isPaused then
            if v27.host then
                if v27.host.Parent == nil then
                    v27.driver:Disconnect()
                    if v27.shadow then
                        v27.shadow:Destroy()
                        v27.shadow = nil
                    end
                else
                    advance(v27)
                    debug.profileend()
                end
            else
                v27.driver:Disconnect()
                if v27.shadow then
                    v27.shadow:Destroy()
                    v27.shadow = nil
                end
            end
        end
    end)
    return v27
end

local function Destroy(v28) -- line 142
    v28.driver:Disconnect()
    if v28.shadow then
        v28.shadow:Destroy()
        v28.shadow = nil
    end
end

v6.Destroy = Destroy

local function Suspend(v29) -- line 149
    v29.isPaused = true
end

v6.Suspend = Suspend

local function Wake(v30) -- line 152
    v30.isPaused = false
end

v6.Wake = Wake

function v6.EaseOffset(v31, v32, v33) -- line 155 | captures: v8, v10
    v10(v32)
    v8(v33)
    local offset = v31.offset
    offset.goal = v32
    offset.response = math.clamp(v33, 0, 1)
end

function v6.EaseAlpha(v34, v35, v36) -- line 162 | captures: v8
    v8(v35)
    v8(v36)
    local alpha = v34.alpha
    alpha.goal = v35
    alpha.response = math.clamp(v36, 0, 1)
end

function v6.EaseTint(v37, v38, v39) -- line 169 | captures: v8, v9
    v9(v38)
    v8(v39)
    local tint = v37.tint
    tint.goal = v38
    tint.response = math.clamp(v39, 0, 1)
end

return table.freeze(v6)
