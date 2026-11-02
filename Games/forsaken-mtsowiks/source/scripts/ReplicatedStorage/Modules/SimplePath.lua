-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Event_0 = script.Event;
local v1 = {
    TIME_VARIANCE = 0.1, 
    COMPARISON_CHECKS = 1, 
    JUMP_WHEN_STUCK = false
};
local l_PathfindingService_0 = game:GetService("PathfindingService");
local l_Players_0 = game:GetService("Players");
local function _(v4, v5) --[[ Line: 26 ]] --[[ Name: output ]]
    v4((v4 == error and "SimplePath Error: " or "SimplePath: ") .. v5);
end;
local v7 = {
    StatusType = {
        Idle = "Idle", 
        Active = "Active"
    }, 
    ErrorType = {
        LimitReached = "LimitReached", 
        TargetUnreachable = "TargetUnreachable", 
        ComputationError = "ComputationError", 
        AgentStuck = "AgentStuck"
    }
};
v7.__index = function(v8, v9) --[[ Line: 41 ]]
    -- upvalues: v7 (copy)
    if v9 == "Stopped" and not v8._humanoid then
        local l_error_0 = error;
        l_error_0((l_error_0 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to use Path.Stopped on a non-humanoid.");
    end;
    return v8._events[v9] and v8._events[v9].Event or v9 == "LastError" and v8._lastError or v9 == "Status" and v8._status or v7[v9];
end;
local l_Part_0 = Instance.new("Part");
l_Part_0.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896, 0);
l_Part_0.Anchored = true;
l_Part_0.CanCollide = false;
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Shape = Enum.PartType.Ball;
local function _(v12, v13) --[[ Line: 60 ]] --[[ Name: declareError ]]
    v12._lastError = v13;
    v12._events.Error:Fire(v13);
end;
local function v20(v15) --[[ Line: 66 ]] --[[ Name: createVisualWaypoints ]]
    -- upvalues: l_Part_0 (copy)
    local v16 = {};
    for _, v18 in ipairs(v15) do
        local v19 = l_Part_0:Clone();
        v19.Position = v18.Position;
        v19.Parent = workspace.Map.Ingame;
        v19.Color = v18 == v15[#v15] and Color3.fromRGB(0, 255, 0) or v18.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 139, 0);
        table.insert(v16, v19);
    end;
    return v16;
end;
local _ = function(v21) --[[ Line: 82 ]] --[[ Name: destroyVisualWaypoints ]]
    if v21 then
        for _, v23 in ipairs(v21) do
            v23:Destroy();
        end;
    end;
end;
local function v27(v25) --[[ Line: 92 ]] --[[ Name: getNonHumanoidWaypoint ]]
    for v26 = 2, #v25._waypoints do
        if (v25._waypoints[v26].Position - v25._waypoints[v26 - 1].Position).Magnitude > 0.1 then
            return v26;
        end;
    end;
    return 2;
end;
local function _(v28) --[[ Line: 103 ]] --[[ Name: setJumpState ]]
    pcall(function() --[[ Line: 104 ]]
        -- upvalues: v28 (copy)
        if v28._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and v28._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            v28._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        end;
    end);
end;
local function _(v30) --[[ Line: 112 ]] --[[ Name: move ]]
    if v30._waypoints[v30._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
        pcall(function() --[[ Line: 104 ]]
            -- upvalues: v30 (copy)
            if v30._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and v30._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                v30._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end;
        end);
    end;
    v30._humanoid:MoveTo(v30._waypoints[v30._currentWaypoint].Position);
end;
local function _(v32) --[[ Line: 120 ]] --[[ Name: disconnectMoveConnection ]]
    if v32._moveConnection then
        v32._moveConnection:Disconnect();
        v32._moveConnection = nil;
    end;
end;
local function _(v34) --[[ Line: 128 ]] --[[ Name: invokeWaypointReached ]]
    local v35 = v34._waypoints[v34._currentWaypoint - 1];
    local v36 = v34._waypoints[v34._currentWaypoint];
    v34._events.WaypointReached:Fire(v34._agent, v35, v36);
end;
local function v58(v38, v39) --[[ Line: 134 ]] --[[ Name: moveToFinished ]]
    -- upvalues: v7 (copy)
    if not getmetatable(v38) then
        return;
    elseif not v38._humanoid then
        if v39 and v38._currentWaypoint + 1 <= #v38._waypoints then
            local v40 = v38._waypoints[v38._currentWaypoint - 1];
            local v41 = v38._waypoints[v38._currentWaypoint];
            v38._events.WaypointReached:Fire(v38._agent, v40, v41);
            v38._currentWaypoint = v38._currentWaypoint + 1;
            return;
        elseif v39 then
            local l__visualWaypoints_0 = v38._visualWaypoints;
            if l__visualWaypoints_0 then
                for _, v44 in ipairs(l__visualWaypoints_0) do
                    v44:Destroy();
                end;
            end;
            v38._visualWaypoints = nil;
            v38._target = nil;
            v38._events.Reached:Fire(v38._agent, v38._waypoints[v38._currentWaypoint]);
            return;
        else
            local l__visualWaypoints_1 = v38._visualWaypoints;
            if l__visualWaypoints_1 then
                for _, v47 in ipairs(l__visualWaypoints_1) do
                    v47:Destroy();
                end;
            end;
            v38._visualWaypoints = nil;
            v38._target = nil;
            local l_TargetUnreachable_0 = v38.ErrorType.TargetUnreachable;
            v38._lastError = l_TargetUnreachable_0;
            v38._events.Error:Fire(l_TargetUnreachable_0);
            return;
        end;
    elseif v39 and v38._currentWaypoint + 1 <= #v38._waypoints then
        if v38._currentWaypoint + 1 < #v38._waypoints then
            local v49 = v38._waypoints[v38._currentWaypoint - 1];
            local v50 = v38._waypoints[v38._currentWaypoint];
            v38._events.WaypointReached:Fire(v38._agent, v49, v50);
        end;
        v38._currentWaypoint = v38._currentWaypoint + 1;
        if v38._waypoints[v38._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
            pcall(function() --[[ Line: 104 ]]
                -- upvalues: v38 (copy)
                if v38._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and v38._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    v38._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                end;
            end);
        end;
        v38._humanoid:MoveTo(v38._waypoints[v38._currentWaypoint].Position);
        return;
    elseif v39 then
        if v38._moveConnection then
            v38._moveConnection:Disconnect();
            v38._moveConnection = nil;
        end;
        v38._status = v7.StatusType.Idle;
        local l__visualWaypoints_2 = v38._visualWaypoints;
        if l__visualWaypoints_2 then
            for _, v53 in ipairs(l__visualWaypoints_2) do
                v53:Destroy();
            end;
        end;
        v38._visualWaypoints = nil;
        v38._events.Reached:Fire(v38._agent, v38._waypoints[v38._currentWaypoint]);
        return;
    else
        if v38._moveConnection then
            v38._moveConnection:Disconnect();
            v38._moveConnection = nil;
        end;
        v38._status = v7.StatusType.Idle;
        local l__visualWaypoints_3 = v38._visualWaypoints;
        if l__visualWaypoints_3 then
            for _, v56 in ipairs(l__visualWaypoints_3) do
                v56:Destroy();
            end;
        end;
        v38._visualWaypoints = nil;
        local l_TargetUnreachable_1 = v38.ErrorType.TargetUnreachable;
        v38._lastError = l_TargetUnreachable_1;
        v38._events.Error:Fire(l_TargetUnreachable_1);
        return;
    end;
end;
local function v61(v59) --[[ Line: 176 ]] --[[ Name: comparePosition ]]
    if v59._currentWaypoint == #v59._waypoints then
        return;
    else
        v59._position._count = (v59._agent.PrimaryPart.Position - v59._position._last).Magnitude <= 0.07 and v59._position._count + 1 or 0;
        v59._position._last = v59._agent.PrimaryPart.Position;
        if v59._position._count >= v59._settings.COMPARISON_CHECKS then
            if v59._settings.JUMP_WHEN_STUCK then
                pcall(function() --[[ Line: 104 ]]
                    -- upvalues: v59 (copy)
                    if v59._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and v59._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                        v59._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                    end;
                end);
            end;
            local l_AgentStuck_0 = v59.ErrorType.AgentStuck;
            v59._lastError = l_AgentStuck_0;
            v59._events.Error:Fire(l_AgentStuck_0);
        end;
        return;
    end;
end;
v7.GetNearestCharacter = function(v62) --[[ Line: 189 ]] --[[ Name: GetNearestCharacter ]]
    -- upvalues: l_Players_0 (copy)
    local v63 = nil;
    local v64 = 1e999;
    for _, v66 in ipairs(l_Players_0:GetPlayers()) do
        if v66.Character and (v66.Character.PrimaryPart.Position - v62).Magnitude < v64 then
            v63 = v66.Character;
            v64 = (v66.Character.PrimaryPart.Position - v62).Magnitude;
        end;
    end;
    return v63;
end;
v7.new = function(v67, v68, v69) --[[ Line: 200 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), l_Event_0 (copy), l_PathfindingService_0 (copy), v7 (copy)
    if not v67 or not v67:IsA("Model") or not v67.PrimaryPart then
        local l_error_1 = error;
        l_error_1((l_error_1 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.");
    end;
    local v71 = v68 or {};
    if v71.AgentRadius == nil then
        v71.AgentRadius = 5;
    end;
    if v71.AgentCanJump == nil then
        v71.AgentCanJump = false;
    end;
    if v71.AgentCanClimb == nil then
        v71.AgentCanClimb = false;
    end;
    if v71.WaypointSpacing == nil then
        v71.WaypointSpacing = 6;
    end;
    local v72 = setmetatable({
        _settings = v69 or v1, 
        _events = {
            Reached = l_Event_0:Clone(), 
            WaypointReached = l_Event_0:Clone(), 
            Blocked = l_Event_0:Clone(), 
            Error = l_Event_0:Clone(), 
            Stopped = l_Event_0:Clone()
        }, 
        _agent = v67, 
        _humanoid = v67:FindFirstChildOfClass("Humanoid"), 
        _path = l_PathfindingService_0:CreatePath(v71), 
        _status = "Idle", 
        _t = 0, 
        _position = {
            _last = Vector3.new(0, 0, 0, 0), 
            _count = 0
        }
    }, v7);
    for v73, v74 in pairs(v1) do
        v72._settings[v73] = v72._settings[v73] == nil and v74 or v72._settings[v73];
    end;
    v72._path.Blocked:Connect(function(...) --[[ Line: 237 ]]
        -- upvalues: v72 (copy)
        if v72._currentWaypoint <= ... and ... <= v72._currentWaypoint + 1 and v72._humanoid then
            local l_v72_0 = v72;
            pcall(function() --[[ Line: 104 ]]
                -- upvalues: l_v72_0 (copy)
                if l_v72_0._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and l_v72_0._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    l_v72_0._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                end;
            end);
            v72._events.Blocked:Fire(v72._agent, v72._waypoints[...]);
        end;
    end);
    return v72;
end;
v7.Destroy = function(v76) --[[ Line: 249 ]] --[[ Name: Destroy ]]
    for _, v78 in ipairs(v76._events) do
        v78:Destroy();
    end;
    v76._events = nil;
    if rawget(v76, "_visualWaypoints") then
        local l__visualWaypoints_4 = v76._visualWaypoints;
        if l__visualWaypoints_4 then
            for _, v81 in ipairs(l__visualWaypoints_4) do
                v81:Destroy();
            end;
        end;
        v76._visualWaypoints = nil;
    end;
    v76._path:Destroy();
    setmetatable(v76, nil);
    for v82, _ in pairs(v76) do
        v76[v82] = nil;
    end;
end;
v7.Stop = function(v84) --[[ Line: 264 ]] --[[ Name: Stop ]]
    -- upvalues: v7 (copy)
    if not v84._humanoid then
        local l_error_2 = error;
        l_error_2((l_error_2 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to call Path:Stop() on a non-humanoid.");
        return;
    elseif v84._status == v7.StatusType.Idle then
        local function v87(v86) --[[ Line: 270 ]]
            warn(debug.traceback(v86));
        end;
        v87((v87 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to run Path:Stop() in idle state");
        return;
    else
        if v84._moveConnection then
            v84._moveConnection:Disconnect();
            v84._moveConnection = nil;
        end;
        v84._status = v7.StatusType.Idle;
        local l__visualWaypoints_5 = v84._visualWaypoints;
        if l__visualWaypoints_5 then
            for _, v90 in ipairs(l__visualWaypoints_5) do
                v90:Destroy();
            end;
        end;
        v84._visualWaypoints = nil;
        v84._events.Stopped:Fire(v84._model);
        return;
    end;
end;
v7.Run = function(v91, v92) --[[ Line: 281 ]] --[[ Name: Run ]]
    -- upvalues: v58 (copy), v7 (copy), v61 (copy), v20 (copy), v27 (copy)
    if not v92 and not v91._humanoid and v91._target then
        v58(v91, true);
        return;
    else
        if not v92 or typeof(v92) ~= "Vector3" and not v92:IsA("BasePart") then
            local l_error_3 = error;
            l_error_3((l_error_3 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding target must be a valid Vector3 or BasePart.");
        end;
        if os.clock() - v91._t <= v91._settings.TIME_VARIANCE and v91._humanoid then
            task.wait(os.clock() - v91._t);
            local l_LimitReached_0 = v91.ErrorType.LimitReached;
            v91._lastError = l_LimitReached_0;
            v91._events.Error:Fire(l_LimitReached_0);
            return false;
        else
            if v91._humanoid then
                v91._t = os.clock();
            end;
            local l_status_0, _ = pcall(function() --[[ Line: 304 ]]
                -- upvalues: v91 (copy), v92 (copy)
                v91._path:ComputeAsync(v91._agent.PrimaryPart.Position, typeof(v92) == "Vector3" and v92 or v92.Position);
            end);
            if not l_status_0 or v91._path.Status == Enum.PathStatus.NoPath or #v91._path:GetWaypoints() < 2 or v91._humanoid and v91._humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                local l__visualWaypoints_6 = v91._visualWaypoints;
                if l__visualWaypoints_6 then
                    for _, v99 in ipairs(l__visualWaypoints_6) do
                        v99:Destroy();
                    end;
                end;
                v91._visualWaypoints = nil;
                task.wait();
                local l_ComputationError_0 = v91.ErrorType.ComputationError;
                v91._lastError = l_ComputationError_0;
                v91._events.Error:Fire(l_ComputationError_0);
                return false;
            else
                v91._status = v91._humanoid and v7.StatusType.Active or v7.StatusType.Idle;
                v91._target = v92;
                pcall(function() --[[ Line: 324 ]]
                    -- upvalues: v91 (copy)
                    v91._agent.PrimaryPart:SetNetworkOwner(nil);
                end);
                v91._waypoints = v91._path:GetWaypoints();
                v91._currentWaypoint = 2;
                if not v91._agent.PrimaryPart then
                    v91:Destroy();
                    return;
                else
                    if v91._humanoid then
                        v61(v91);
                    end;
                    local l__visualWaypoints_7 = v91._visualWaypoints;
                    if l__visualWaypoints_7 then
                        for _, v103 in ipairs(l__visualWaypoints_7) do
                            v103:Destroy();
                        end;
                    end;
                    v91._visualWaypoints = v91.Visualize and v20(v91._waypoints);
                    v91._moveConnection = v91._humanoid and (v91._moveConnection or v91._humanoid.MoveToFinished:Connect(function(...) --[[ Line: 345 ]]
                        -- upvalues: v58 (ref), v91 (copy)
                        v58(v91, ...);
                    end));
                    if v91._humanoid then
                        v91._humanoid:MoveTo(v91._waypoints[v91._currentWaypoint].Position);
                    elseif #v91._waypoints == 2 then
                        v91._target = nil;
                        local l__visualWaypoints_8 = v91._visualWaypoints;
                        if l__visualWaypoints_8 then
                            for _, v106 in ipairs(l__visualWaypoints_8) do
                                v106:Destroy();
                            end;
                        end;
                        v91._visualWaypoints = nil;
                        v91._events.Reached:Fire(v91._agent, v91._waypoints[2]);
                    else
                        v91._currentWaypoint = v27(v91);
                        v58(v91, true);
                    end;
                    return true;
                end;
            end;
        end;
    end;
end;
return v7;