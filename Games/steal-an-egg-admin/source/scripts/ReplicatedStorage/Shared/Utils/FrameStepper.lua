-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local v1 = 0
local v2 = {}

local function create(v3, v4, v5, v6, v7) -- line 9
    if v5 ~= nil then
        local v8 = if v5 > 0 then v5 == v5 else false
        assert(v8, "step duration must be a positive number")
    end
    local v9 = v5 or (1/0)
    local v10 = 0
    local v11 = "Running"
    local v12
    local v13 = {}
    local v14 = {}

    local function stop(v15) -- line 20 | captures: v11, v12, v13
        if v11 ~= "Running" then
            return
        end
        if v15 then
            v11 = "Completed"
        else
            v11 = "Cancelled"
        end
        local v16 = v12
        v12 = nil
        if v16 then
            v16()
        end
        if v15 then
            local v17 = v13
            v13 = {}
            for v18, v19 in ipairs(v17) do
                task.spawn(v19)
            end
        else
            table.clear(v13)
        end
    end

    function v14.Cancel(v20) -- line 46 | captures: v11, v12, v13
        if v11 ~= "Running" then
            return
        end
        v11 = "Cancelled"
        local v21 = v12
        v12 = nil
        if v21 then
            v21()
        end
        table.clear(v13)
    end

    function v14.Destroy(v22) -- line 58 | captures: v11, v12, v13, v14
        if v11 == "Running" then
            v11 = "Cancelled"
            local v23 = v12
            v12 = nil
            if v23 then
                v23()
            end
            table.clear(v13)
        end
        table.clear(v14)
    end

    function v14.IsRunning(v24) -- line 70 | captures: v11
        return v11 == "Running"
    end

    function v14.OnComplete(v25, v26) -- line 74 | captures: v11, v13, v14
        local v27 = type(v26) == "function"
        assert(v27, "completion callback must be a function")
        if v11 == "Completed" then
            task.spawn(v26)
        elseif v11 == "Running" then
            local v28 = v13
            table.insert(v28, v26)
        end
        return v14
    end

    function v14.Wait(v29) -- line 84 | captures: v11
        while v11 == "Running" do
            task.wait()
        end
        return v11 == "Completed"
    end

    v12 = v3(function(v30) -- line 91 | captures: v10, v11, v4, v9, stop
        if v11 ~= "Running" then
            return
        end
        v10 += v30
        local v31
        if v9 == (1/0) then
            v31 = 0
        else
            local v32 = v10 / v9
            v31 = math.clamp(v32, 0, 1)
        end
        if v4(v30, v31) == true then
            stop(true)
        else
            local v33 = v10
            if v9 <= v33 then
                stop(true)
            end
        end
    end)
    return v14
end

function v2.OnHeartbeat(v34, v35, v36, v37) -- line 113 | captures: RunService, create
    return (create(function(v38) -- line 114 | captures: RunService
        local v39 = RunService.Heartbeat:Connect(v38)
        return function() -- line 117 | captures: v39
            v39:Disconnect()
        end
    end, v34, v35, v36, v37))
end

function v2.OnRender(v40, v41, v42, v43, v44) -- line 124 | captures: v1, RunService, create
    v1 += 1
    local v45 = string.format("FrameStepper.%d", v1)
    return (create(function(v46) -- line 127 | captures: v44, v45, RunService
        local v47 = v44 or Enum.RenderPriority.Last.Value
        RunService:BindToRenderStep(v45, v47, v46)
        return function() -- line 134 | captures: v45, RunService
            RunService:UnbindFromRenderStep(v45)
        end
    end, v40, v41, v42, v43))
end

return table.freeze(v2)
