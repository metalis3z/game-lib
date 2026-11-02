-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Workspace")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = {}
local v2 = {}
for v3, v4 in ipairs(script.Events:GetChildren()) do
    if v4:IsA("ModuleScript") then
        local xpcall_2 = xpcall
        local v5 = v4
        local v6, v7 = xpcall_2(function() -- line 13 | captures: v5
            return require(v5)
        end, debug.traceback)
        if v6 and type(v7) == "table" then
            local StartEvent = v7.StartEvent
            if type(StartEvent) == "function" then
                local StopEvent = v7.StopEvent
                if type(StopEvent) == "function" then
                    v1[v4.Name] = v7
                    script:SetAttribute("Loaded_" .. v4.Name, true)
                else
                    script:SetAttribute("Loaded_" .. v4.Name, false)
                    warn(("[AdminAbuseClient] %s failed to load: %s"):format(v4.Name, (tostring(v7))))
                end
            else
                script:SetAttribute("Loaded_" .. v4.Name, false)
                warn(("[AdminAbuseClient] %s failed to load: %s"):format(v4.Name, (tostring(v7))))
            end
        else
            script:SetAttribute("Loaded_" .. v4.Name, false)
            warn(("[AdminAbuseClient] %s failed to load: %s"):format(v4.Name, (tostring(v7))))
        end
    end
end

local function stopEvent(v8) -- line 28 | captures: v1, v2
    v2[v8] = nil
    local v9 = v1[v8]
    if not v9 then
        return
    end
    local v10, v11 = xpcall(function() -- line 34 | captures: v9
        v9:StopEvent()
    end, debug.traceback)
    if not v10 then
        warn(("[AdminAbuseClient] %s StopEvent failed: %s"):format(v8, (tostring(v11))))
    end
end

local function startEvent(v12, v13, v14) -- line 42 | captures: v1, v2, stopEvent
    local v15 = v13
    local v16 = v1[v12]
    if v16 then
        stopEvent(v12)
        local v17 = tonumber(v13) or 0
        v15 = math.max(0, v17)
        local v18 = {}
        v2[v12] = v18
        local v19, v20 = xpcall(function() -- line 54 | captures: v15, v14, v16
            v16:StartEvent(v15, v14)
        end, debug.traceback)
        if v19 then
            script:SetAttribute("LastStartedEvent", v12)
            task.delay(v15, function() -- line 64 | captures: v12, v18, v2, stopEvent
                if v2[v12] == v18 then
                    stopEvent(v12)
                end
            end)
        else
            v2[v12] = nil
            warn(("[AdminAbuseClient] %s StartEvent failed: %s"):format(v12, (tostring(v20))))
        end
    else
        warn(("[AdminAbuseClient] no client module named %s"):format((tostring(v12))))
    end
end

Remotes.LiveEvents.Began.OnClientEvent:Connect(startEvent)
Remotes.LiveEvents.Ended.OnClientEvent:Connect(stopEvent)
task.spawn(function() -- line 74 | captures: Remotes, startEvent
    local v21, v22, v23 = pcall(function() -- line 75 | captures: Remotes
        return Remotes.LiveEvents.FetchRunning:InvokeServer()
    end)
    if v21 then
        if type(v22) == "table" then
            for v24, v25 in pairs(v22) do
                local v26 = tonumber(v25) and v25 - os.time() or 0
                if v26 > 0 then
                    local spawn = task.spawn
                    local v27 = type(v23) == "table" and v23[v24] or nil
                    spawn(startEvent, v24, v26, v27)
                end
            end
        end
    else
        warn("[AdminAbuseClient] FetchRunning failed:", v22)
    end
end)
script:SetAttribute("Ready", true)
local script_2 = script
local v28 = 0
for v29 in pairs(v1) do
    v28 += 1
end
script_2:SetAttribute("LoadedModuleCount", v28)
