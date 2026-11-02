-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(v2, ...)
    table.insert(v2, ...)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local DeepCopy = require(ReplicatedStorage.Shared.Utils.DeepCopy)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local GUI = require(ReplicatedStorage.Client.GUI)
local RoundDeferral = require(script.Parent.RoundDeferral)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v3 = Vector2.new(0.5, 0.5)
local v4 = { 0.35, "Back", "Out" }
local v5 = {
    Time = 3,
    Force = false,
    DelayInRound = false,
    PreventDuplicateText = false
}
local v6 = {
    Locations = {
        Bottom = 2,
        Message = 5
    }
}

v6._pumpConnections = {}

local Locations = v6.Locations
local v7 = t.interface({
    Time = t.optional(t.number),
    Force = t.optional(t.boolean),
    DelayInRound = t.optional(t.boolean),
    PreventDuplicateText = t.optional(t.boolean),
    DuplicateKey = t.optional(t.string)
})
local v8 = GUI.Notifications()
local v9 = 0
local v10 = {}

v10[Locations.Bottom] = {
    maxVisible = 3,
    queue = {},
    active = {},
    parentGui = v8:WaitForChild("Bottom")
}
v10[Locations.Message] = {
    maxVisible = 3,
    topArea = true,
    queue = {},
    active = {},
    parentGui = v8:WaitForChild("MessageTop")
}

local function alreadyQueued(v11) -- line 41 | captures: v10
    if v11 ~= nil then
        for v12, v13 in pairs(v10) do
            for v14, v15 in {
                    v13.queue,
                    v13.active
                } do
                for v16, v17 in v15 do
                    if v17.config.DuplicateKey == v11 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function admit(v18) -- line 64 | captures: v10, alreadyQueued
    if alreadyQueued(v18.config.DuplicateKey) then
        return
    end
    local v19 = v10[v18.location]
    local v20 = assert(v19)
    if #v20.queue < 20 then
        local queue = v20.queue
        table.insert(queue, v18)
    end
end

local function wipeOut(v21, v22) -- line 74 | captures: RunService, Ease
    local function v23(...)
        return (assert(...))
    end

    local v24 = v23(v21:FindFirstChildOfClass("UIGradient"))
    v24.Rotation = 45
    local v25 = tick()
    local v26 = if v22 then 0.1 else 0.35
    while v21 do
        if v21.Parent then
            local v27 = (tick() - v25) / v26
            local v28 = math.clamp(v27, 0, 1)
            local v29 = {}
            local v30 = NumberSequenceKeypoint.new(0, Ease(v28, "Sine", "InOut"))
            local v31 = NumberSequenceKeypoint.new(1 - v28 * 0.99, Ease(v28, "Sine", "Out"))
            v29[1] = v30
            v29[2] = v31
            v29[3] = NumberSequenceKeypoint.new(1, Ease(v28, "Sine", "Out"))
            v24.Transparency = NumberSequence.new(v29)
            RunService.RenderStepped:Wait()
            if v28 >= 1 then
                break
            end
            continue
        end
        break
    end
end

local function retireInline(v32, v33) -- line 103 | captures: wipeOut
    v33.tweening = true
    task.spawn(function() -- line 105 | captures: v32, v33, wipeOut
        wipeOut(v33.frame)
        for v34, v35 in v33.completed do
            task.spawn(v35, v33.frame)
        end
        v33.frame:Destroy()
        for v36, v37 in v32.active do
            if v33 == v37 then
                table.remove(v32.active, v36)
            end
        end
    end)
end

local function showInline(v38, v39, v40) -- line 124 | captures: Tween, v3, v4
    v39.created = tick()
    local active = v38.active
    table.insert(active, v39)
    local v41 = v39.frame:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    v41.Parent = v39.frame
    v41.Scale = 1.35
    Instance.new("UIGradient").Parent = v39.frame
    v39.frame.AnchorPoint = v3
    v39.frame.LayoutOrder = v40
    v39.frame.Parent = v38.parentGui
    Tween(v41, { Scale = 1 }, v4)
    for v42, v43 in v39.started do
        task.spawn(v43, v39.frame)
    end
end

function v6.ReserveTop() -- line 146 | captures: v9
    v9 += 1
    local v44 = false
    return function() -- line 149 | captures: v44, v9
        if not v44 then
            v44 = true
            v9 -= 1
        end
    end
end

function v6.IsTopContended() -- line 156 | captures: Locations, v10
    return #v10[Locations.Message].active > 0
end

function v6.InlineBottomRenders() -- line 161 | captures: Locations, v10
    return v10[Locations.Bottom].active
end

function v6.Enqueue(v45, v46, v47, v48, v49) -- line 164 | captures: DeepCopy, v5, v6, v7, v10, alreadyQueued
    local function v50(...)
        assert(...)
    end

    local v51 = DeepCopy(v5)
    local v52, v53
    if typeof(v48) == "function" then
        v53 = v48
        v52 = {}
    else
        v53 = v49
        v52 = v48 or {}
    end
    v50(v7(v52))
    for v54, v55 in pairs(v52) do
        v51[v54] = v55
    end
    local v56 = {
        location = v45,
        frame = v46,
        config = v51
    }
    local v57 = {}
    v57[1] = v47 or function() -- v7 | line 189
    end
    v56.started = v57
    local v58 = {}
    v58[1] = v53 or function() -- v7 | line 196
    end
    v56.completed = v58
    local v59 = { __index = v6 }
    local v60 = setmetatable(v56, v59)
    if not alreadyQueued(v60.config.DuplicateKey) then
        local v61 = v10[v60.location]
        local v62 = assert(v61)
        if #v62.queue < 20 then
            local queue = v62.queue
            table.insert(queue, v60)
        end
    end
    return v60
end

for v63, v64 in pairs(v10) do
    local _pumpConnections = v6._pumpConnections

    local v65 = function(v66) -- line 213 | captures: v9, RunService, RoundDeferral, wipeOut, showInline
        local v67 = 0
        local v68
        return RunService.RenderStepped:Connect(function() -- line 216 | captures: v67, v68, v66, v9, RoundDeferral, wipeOut, showInline
            local v69 = tick()
            local v70 = #v66.active
            for v71 = v70, 1, -1 do
                local v72 = v66.active[v71]
                local v73 = v69 - v72.created
                if v72.config.Time < v73 and not v72.tweening then
                    v72.tweening = true
                    task.spawn(function() -- line 227 | captures: v72, v66, wipeOut
                        wipeOut(v72.frame)
                        for v74, v75 in v72.completed do
                            task.spawn(v75, v72.frame)
                        end
                        v72.frame:Destroy()
                        for v76, v77 in v66.active do
                            if v72 == v77 then
                                table.remove(v66.active, v76)
                            end
                        end
                    end)
                end
            end
            while true do
                local v78 = #v66.active
                if not (v66.maxVisible <= v78 or v66.topArea and v9 > 0) then
                    local v79 = workspace:GetServerTimeNow()
                    local v80 = v68
                    local v81
                    if v80 then
                        local v82 = v68 - v79
                        v81 = math.abs(v82) < 0.1
                    end
                    if not v80 or not v81 then
                        local v83 = RoundDeferral.TakeAdmissible(v66.queue)
                        if v83 then
                            v68 = v79
                            v67 += 1
                            showInline(v66, v83, v67)
                            continue
                        end
                    end
                end
                break
            end
        end)
    end

    v1(_pumpConnections, v65(v64))
end
return v6
