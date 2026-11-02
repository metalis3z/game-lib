-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.optional(t.table))
local v2 = t.strict(t.string)
local v3 = t.strict(t.number)
local v4 = t.strict(t.callback)
local v5 = t.strict(t.intersection(t.integer, t.numberPositive))
local v6 = t.strict(t.optional(t.number))
local v7 = Log.new()
local v8 = {}

v8.__index = v8
v8.__class = "RenderBudget"

local function pick(v9, v10, v11) -- line 20
    local v12 = if v9 then v9[v10] else nil
    return v12 or v11
end

function v8.new(v13) -- line 29 | captures: v1, v2, v3, v5, v6, v8
    v1(v13)
    local MaxJobsPerStep, v14
    if v13 then
        if v13.Name then
            v14 = v13.Name
        end
        MaxJobsPerStep = v13.MaxJobsPerStep
    else
        v14 = "RenderBudget"
    end
    local v15 = MaxJobsPerStep or 4
    local v16 = if v13 then v13.MaxStepTime else nil
    local v17 = v16 or 0.004166666666666667
    local v18 = if v13 then v13.StepInterval else nil
    local v19 = v18 or 0.016666666666666666
    local v20 = if v13 then v13.SpreadMinJobs else nil
    local v21 = v20 or 2
    local v22 = if v13 then v13.TargetSpreadSeconds else nil
    v2(v14)
    v5(v15)
    v3(v17)
    v3(v19)
    v5(v21)
    v6(v22)
    local v23 = v17 > 0
    local v24 = ("%* was given a non-positive per-step time budget"):format(v14)
    assert(v23, v24)
    local v25 = v19 > 0
    local v26 = ("%* was given a non-positive step interval"):format(v14)
    assert(v25, v26)
    local v27 = if v22 == nil then true else v22 > 0
    local v28 = ("%* was given a non-positive spread target"):format(v14)
    assert(v27, v28)
    local v29 = {
        closed = false,
        head = 1,
        pumping = false,
        jobsPerStep = v15,
        label = v14,
        queue = {},
        slotByKey = {},
        spreadFloor = v21,
        spreadTarget = v22,
        stepBudget = v17,
        stepGap = v19
    }
    return (setmetatable(v29, v8))
end

local function outstanding(v30) -- line 93
    local v31 = #v30.queue - v30.head + 1
    return (math.max(0, v31))
end

local function retuneSpread(v32) -- line 97
    local spreadTarget = v32.spreadTarget
    local v33 = #v32.queue - v32.head + 1
    local v34 = math.max(0, v33)
    if spreadTarget == nil or v34 < v32.spreadFloor then
        return
    end
    local v35 = v34 / v32.jobsPerStep
    local v36 = math.ceil(v35)
    local v37 = spreadTarget / math.max(1, v36)
    if v32.spreadGap == nil or v37 < v32.spreadGap then
        v32.spreadGap = v37
    end
end

local function drainOneStep(v38) -- line 110 | captures: v7
    local v39 = os.clock()
    local v40 = 0
    while true do
        local v41, v42
        if v38.head <= #v38.queue then
            if v38.jobsPerStep <= v40 then
                v42 = true
            else
                local v43 = os.clock() - v39
                if v38.stepBudget <= v43 then
                    v42 = true
                else
                    local v44 = v38.queue[v38.head]
                    v38.queue[v38.head] = nil
                    v38.head += 1
                    v41 = v40 + 1
                    if not v44.dropped and v38.slotByKey[v44.key] == v44 then
                        v38.slotByKey[v44.key] = nil
                        local v45 = { pcall(v44.run) }
                        if not v45[1] then
                            v7:AtError():Log((("%* could not run %*: %*"):format(v38.label, v44.key, v45[2])))
                        end
                    end
                    v42 = false
                end
            end
        else
            v42 = true
        end
        if v42 then
            break
        end
        v40 = v41
    end
    if #v38.queue < v38.head then
        table.clear(v38.queue)
        v38.head = 1
    end
end

local v46

function v46(v47) -- line 140 | captures: v46, drainOneStep
    if v47.pumping or v47.closed then
        return
    end
    v47.pumping = true
    task.defer(function() -- line 145 | captures: v47, v46, drainOneStep
        local v48 = 0
        while true do
            local v49
            if v47.closed then
                v49 = true
            else
                local head = v47.head
                if #v47.queue < head then
                    v49 = true
                else
                    local spreadTarget = v47.spreadTarget
                    local v50 = #v47.queue - v47.head + 1
                    local v51 = math.max(0, v50)
                    if spreadTarget ~= nil and v47.spreadFloor <= v51 then
                        local v52 = v51 / v47.jobsPerStep
                        local v53 = math.ceil(v52)
                        local v54 = spreadTarget / math.max(1, v53)
                        if v47.spreadGap == nil then
                            v47.spreadGap = v54
                        elseif v47.spreadGap <= v54 then
                        end
                    end
                    v49 = false
                end
            end
            if v49 then
                break
            end
            local v55 = v48 - os.clock()
            if v55 > 0 then
                task.wait(v55)
            end
            drainOneStep(v47)
            v48 = os.clock() + (v47.spreadGap or v47.stepGap)
        end
        v47.spreadGap = nil
        v47.pumping = false
        if not v47.closed and v47.head <= #v47.queue then
            v46(v47)
        end
    end)
end

function v8.Submit(v56, v57, v58) -- line 181 | captures: v46, v2, v4, drainOneStep
    v2(v57)
    v4(v58)
    local v59 = v57 ~= ""
    local v60 = ("%* was handed a job with an empty key"):format(v56.label)
    assert(v59, v60)
    local label = v56.label
    local v61 = not v56.closed
    local v62 = ("%* has been destroyed and cannot take more work"):format(label)
    assert(v61, v62)
    local v63 = v56.slotByKey[v57]
    if v63 ~= nil then
        v63.dropped = true
    end
    local v64 = {
        dropped = false,
        key = v57,
        run = v58
    }
    v56.slotByKey[v57] = v64
    local queue = v56.queue
    table.insert(queue, v64)
    if v56.pumping or v56.closed then
        return
    end
    v56.pumping = true
    task.defer(function() -- line 200 | captures: v56, v46, drainOneStep
        local v65 = 0
        while true do
            local v66
            if v56.closed then
                v66 = true
            else
                local head = v56.head
                if #v56.queue < head then
                    v66 = true
                else
                    local spreadTarget = v56.spreadTarget
                    local v67 = #v56.queue - v56.head + 1
                    local v68 = math.max(0, v67)
                    if spreadTarget ~= nil and v56.spreadFloor <= v68 then
                        local v69 = v68 / v56.jobsPerStep
                        local v70 = math.ceil(v69)
                        local v71 = spreadTarget / math.max(1, v70)
                        if v56.spreadGap == nil then
                            v56.spreadGap = v71
                        elseif v56.spreadGap <= v71 then
                        end
                    end
                    v66 = false
                end
            end
            if v66 then
                break
            end
            local v72 = v65 - os.clock()
            if v72 > 0 then
                task.wait(v72)
            end
            drainOneStep(v56)
            v65 = os.clock() + (v56.spreadGap or v56.stepGap)
        end
        v56.spreadGap = nil
        v56.pumping = false
        if not v56.closed and v56.head <= #v56.queue then
            v46(v56)
        end
    end)
end

function v8.Drop(v73, v74) -- line 236 | captures: v2
    v2(v74)
    local v75 = v73.slotByKey[v74]
    if v75 ~= nil then
        v75.dropped = true
        v73.slotByKey[v74] = nil
    end
end

local function DropAll(v76) -- line 244
    for v77, v78 in v76.slotByKey do
        v78.dropped = true
        v76.slotByKey[v77] = nil
    end
end

v8.DropAll = DropAll

function v8.Drain(v79) -- line 253 | captures: drainOneStep
    while v79.head <= #v79.queue do
        drainOneStep(v79)
    end
end

local function Destroy(v80) -- line 258
    if v80.closed then
        return
    end
    v80:DropAll()
    v80.closed = true
    v80.pumping = false
    table.clear(v80.queue)
    v80.head = 1
end

v8.Destroy = Destroy
return v8
