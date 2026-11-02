-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_TweenEvent_0 = script:WaitForChild("TweenEvent");
local l_HttpService_0 = game:GetService("HttpService");
local v4 = {};
local v5 = {};
local function v7(v6) --[[ Line: 62 ]] --[[ Name: TweenInfo_To_Table ]]
    return {
        [1] = v6.Time or 1, 
        [2] = v6.EasingStyle or Enum.EasingStyle.Quad, 
        [3] = v6.EasingDirection or Enum.EasingDirection.Out, 
        [4] = v6.RepeatCount or 0, 
        [5] = v6.Reverses or false, 
        [6] = v6.DelayTime or 0
    };
end;
local function _(v8) --[[ Line: 74 ]] --[[ Name: Table_To_TweenInfo ]]
    return TweenInfo.new(unpack(v8));
end;
local function _(v10, v11) --[[ Line: 79 ]] --[[ Name: serverAssignProperties ]]
    for v12, v13 in pairs(v11) do
        v10[v12] = v13;
    end;
end;
local _ = function(v15, v16) --[[ Line: 87 ]] --[[ Name: getInstanceCurrentSimulatedState ]]
    local v17 = {};
    for v18, _ in pairs(v16) do
        v17[v18] = v15[v18];
    end;
    return v17;
end;
v4.Create = function(_, v22, v23, v24, v25) --[[ Line: 95 ]] --[[ Name: Create ]]
    -- upvalues: l_HttpService_0 (copy), v7 (copy), l_TweenService_0 (copy), v5 (copy), l_TweenEvent_0 (copy)
    local v26 = {
        DontUpdate = {}, 
        _SafeTweenInfo = v23, 
        _TweenID = l_HttpService_0:GenerateGUID(false), 
        HasFinished = false
    };
    v23 = v7(v23);
    if v25 then
        v26._SimulateTween = true;
        local l_SimulatedTweensFolder_0 = script:FindFirstChild("SimulatedTweensFolder");
        if not l_SimulatedTweensFolder_0 then
            l_SimulatedTweensFolder_0 = Instance.new("Folder");
            l_SimulatedTweensFolder_0.Name = "SimulatedTweensFolder";
            l_SimulatedTweensFolder_0.Parent = script;
        end;
        v26.SimulatedInstance = v22:Clone();
        v26.SimulatedInstance.Parent = l_SimulatedTweensFolder_0;
        v26.SimulatedTween = l_TweenService_0:Create(v26.SimulatedInstance, v26._SafeTweenInfo, v24);
    end;
    local function v43(v28, v29, v30) --[[ Line: 121 ]] --[[ Name: Play ]]
        -- upvalues: v23 (ref), v5 (ref), v22 (copy), v26 (copy), l_TweenEvent_0 (ref), v24 (copy)
        local v31 = v23[1] * (v23[4] ~= 0 and v23[4] or 1) * (v23[5] and 2 or 1);
        local v32 = os.time() + v31;
        v5[v22] = v5[v22] or os.time();
        v30 = v30 or false;
        v26.Paused = false;
        if v29 == nil and not v30 then
            v5[v22] = v32;
            l_TweenEvent_0:FireAllClients("RunTween", v22, v23, v24, v26._TweenID, nil, workspace:GetServerTimeNow());
        elseif v30 and v29 == nil then
            v31 = v31 + (v5[v22] - os.time());
            v5[v22] = v32 + (v5[v22] - os.time());
            l_TweenEvent_0:FireAllClients("QueueTween", v22, v23, v24, v26._TweenID, nil, workspace:GetServerTimeNow());
        elseif v30 and v29 then
            l_TweenEvent_0:FireClient(v29, "QueueTween", v22, v23, v24, v26._TweenID, nil, workspace:GetServerTimeNow());
        elseif v29 then
            l_TweenEvent_0:FireClient(v29, "RunTween", v22, v23, v24, v26._TweenID, nil, workspace:GetServerTimeNow());
        end;
        if v26._SimulateTween then
            v26.SimulatedTween:Play();
            v26._PauseSimulatedTween = function() --[[ Line: 146 ]]
                -- upvalues: v26 (ref)
                v26.SimulatedTween:Pause();
            end;
            v26._StopSimulatedTween = function() --[[ Line: 150 ]]
                -- upvalues: v26 (ref)
                v26.SimulatedTween:Cancel();
            end;
            v26._ResumeSimulatedTween = function() --[[ Line: 154 ]]
                -- upvalues: v26 (ref)
                v26.SimulatedTween:Play();
            end;
            task.spawn(function() --[[ Line: 158 ]]
                -- upvalues: v26 (ref)
                v26.SimulatedTween.Completed:Wait();
                v26.SimulatedInstance:Destroy();
            end);
        end;
        if v28 and v29 == nil then
            local v33 = 0;
            local v34 = v5[v22];
            repeat
                task.wait(0.05);
                v33 = v33 + 0.05;
            until v31 <= v33 or v26.Stopped;
            if v5[v22] == v34 then
                v5[v22] = nil;
            end;
            if v26.Paused == nil or v26.Paused == false then
                local l_v22_0 = v22;
                for v36, v37 in pairs(v24) do
                    l_v22_0[v36] = v37;
                end;
                v26.HasFinished = true;
            end;
        elseif v29 == nil then
            task.spawn(function() --[[ Line: 177 ]]
                -- upvalues: v5 (ref), v22 (ref), v31 (ref), v26 (ref), v24 (ref)
                local v38 = 0;
                local v39 = v5[v22];
                repeat
                    task.wait(0.05);
                    v38 = v38 + 0.05;
                until v31 <= v38 or v26.Stopped;
                if v5[v22] == v39 then
                    v5[v22] = nil;
                end;
                if v26.Paused == nil or v26.Paused == false then
                    local l_v22_1 = v22;
                    for v41, v42 in pairs(v24) do
                        l_v22_1[v41] = v42;
                    end;
                    v26.HasFinished = true;
                end;
            end);
        end;
    end;
    v26.Play = function(_, v45, v46) --[[ Line: 192 ]] --[[ Name: Play ]]
        -- upvalues: v43 (copy)
        v43(v45, v46);
    end;
    v26.QueuePlay = function(_, v48, v49) --[[ Line: 196 ]] --[[ Name: QueuePlay ]]
        -- upvalues: v43 (copy)
        v43(v48, v49, true);
    end;
    v26.Pause = function(_, v51) --[[ Line: 200 ]] --[[ Name: Pause ]]
        -- upvalues: v26 (copy), v24 (copy), l_TweenEvent_0 (ref), v22 (copy)
        if v26._SimulateTween then
            local l_v26_0 = v26;
            local l_SimulatedInstance_0 = v26.SimulatedInstance;
            local l_v24_0 = v24;
            local v55 = {};
            for v56, _ in pairs(l_v24_0) do
                v55[v56] = l_SimulatedInstance_0[v56];
            end;
            l_v26_0._CurrentExpectedState = v55;
        end;
        if v26._SimulateTween then
            v26._PauseSimulatedTween();
        end;
        if v51 == nil then
            v26.Paused = true;
            l_TweenEvent_0:FireAllClients("PauseTween", v22, nil, nil, v26._TweenID, v26._CurrentExpectedState, workspace:GetServerTimeNow());
            return;
        else
            table.insert(v26.DontUpdate, v51);
            l_TweenEvent_0:FireClient(v51, "PauseTween", v22, nil, nil, v26._TweenID, v26._CurrentExpectedState, workspace:GetServerTimeNow());
            return;
        end;
    end;
    v26.Stop = function(_, v59) --[[ Line: 219 ]] --[[ Name: Stop ]]
        -- upvalues: v26 (copy), v24 (copy), l_TweenEvent_0 (ref), v22 (copy)
        if v26._SimulateTween then
            local l_v26_1 = v26;
            local l_SimulatedInstance_1 = v26.SimulatedInstance;
            local l_v24_1 = v24;
            local v63 = {};
            for v64, _ in pairs(l_v24_1) do
                v63[v64] = l_SimulatedInstance_1[v64];
            end;
            l_v26_1._CurrentExpectedState = v63;
        end;
        if v26._SimulateTween then
            v26._StopSimulatedTween();
        end;
        if v59 == nil then
            v26.Stopped = true;
            l_TweenEvent_0:FireAllClients("StopTween", v22, nil, nil, v26._TweenID, v26._CurrentExpectedState, workspace:GetServerTimeNow());
            return;
        else
            l_TweenEvent_0:FireClient(v59, "StopTween", v22, nil, nil, v26._TweenID, v26._CurrentExpectedState, workspace:GetServerTimeNow());
            return;
        end;
    end;
    return v26;
end;
if l_RunService_0:IsClient() then
    local v66 = {};
    local v67 = {};
    l_TweenEvent_0.OnClientEvent:Connect(function(v68, v69, v70, v71, v72, v73, v74) --[[ Line: 244 ]]
        -- upvalues: v5 (copy), v66 (copy), v67 (copy), l_TweenService_0 (copy)
        local l_v70_0 = v70;
        if v70 ~= nil then
            v70 = TweenInfo.new(unpack(v70));
        end;
        if v73 then
            for v76, v77 in pairs(v73) do
                v69[v76] = v77;
            end;
        end;
        local v78 = 0;
        if v74 and v70 then
            v78 = workspace:GetServerTimeNow() - v74;
            v70 = TweenInfo.new(l_v70_0[1] - v78, l_v70_0[2], l_v70_0[3], l_v70_0[4], l_v70_0[5], l_v70_0[6]);
        end;
        local function v84(v79) --[[ Line: 263 ]] --[[ Name: runTween ]]
            -- upvalues: v70 (ref), v5 (ref), v69 (copy), v66 (ref), v67 (ref), v72 (copy), l_TweenService_0 (ref), v71 (copy)
            local v80 = os.time() + v70.Time;
            v5[v69] = v5[v69] or os.time();
            local v81 = v5[v69];
            if v79 and v5[v69] >= os.time() then
                local v82 = v5[v69] - os.time();
                v5[v69] = v80 + v82;
                v81 = v5[v69];
                task.wait(v82);
            else
                v5[v69] = v80;
            end;
            if v66[v69] ~= nil and v66[v69].PlaybackState ~= Enum.PlaybackState.Paused and v67[v69] ~= v72 then
                v66[v69]:Cancel();
                warn(string.format("Cancelled a previously running tween for instance \"%s\" tor run a new requested one.", v69.Name));
            end;
            local v83 = nil;
            v83 = if v67[v69] == v72 then v66[v69] else l_TweenService_0:Create(v69, v70, v71);
            v66[v69] = v83;
            v83:Play();
            v67[v69] = v72;
            v83.Completed:Wait();
            if v5[v69] == v81 then
                v5[v69] = nil;
            end;
            if v66[v69] == v83 then
                v66[v69] = nil;
            end;
        end;
        if v68 == "RunTween" then
            v84();
        elseif v68 == "QueueTween" then
            v84(true);
        elseif v68 == "StopTween" then
            if v66[v69] ~= nil then
                v66[v69]:Cancel();
                v66[v69] = nil;
            else
                warn("Tween being stopped does not exist or the instance itself.");
            end;
        elseif v68 == "PauseTween" then
            if v66[v69] ~= nil then
                v66[v69]:Pause();
            else
                warn("Tween being paused does not exist.");
            end;
        end;
    end);
end;
return v4;