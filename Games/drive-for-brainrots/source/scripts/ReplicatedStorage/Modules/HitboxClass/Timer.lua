-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- decompilation:
local l_RunService_0 = game:GetService("RunService");
local v1 = require(script.Parent.Signal);
local v2 = {};
v2.new = function(v3, v4) --[[ Line: 28 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v1 (copy), l_RunService_0 (copy)
    local v5 = setmetatable({}, {
        __index = v2
    });
    v5.TimeOut = v3;
    v5.Callback = v4;
    v5.TimeElapsed = 0;
    v5.Elapsed = v1.new();
    v5.Elapsed:Connect(v4);
    v5.HeartbeatConnection = l_RunService_0.Heartbeat:Connect(function(v6) --[[ Line: 40 ]]
        -- upvalues: v5 (copy)
        v5:_Interval(v6);
    end);
    return v5;
end;
v2._Interval = function(v7, v8) --[[ Line: 47 ]] --[[ Name: _Interval ]]
    v7.TimeElapsed = v7.TimeElapsed + v8;
    if v7.TimeElapsed >= v7.TimeOut * 10 then
        v7.TimeElapsed = v7.TimeElapsed - math.floor(v7.TimeElapsed / v7.TimeOut) * v7.TimeOut;
        return;
    else
        if v7.TimeElapsed >= v7.TimeOut then
            v7.TimeElapsed = v7.TimeElapsed - v7.TimeOut;
            v7.Elapsed:Fire();
        end;
        return;
    end;
end;
v2.On = function(v9) --[[ Line: 71 ]] --[[ Name: On ]]
    -- upvalues: l_RunService_0 (copy)
    if v9.HeartbeatConnection and v9.HeartbeatConnection.Connected then
        return;
    else
        v9.HeartbeatConnection = l_RunService_0.Heartbeat:Connect(function(v10) --[[ Line: 76 ]]
            -- upvalues: v9 (copy)
            v9:_Interval(v10);
        end);
        return;
    end;
end;
v2.Off = function(v11) --[[ Line: 82 ]] --[[ Name: Off ]]
    if not v11.HeartbeatConnection then
        return;
    else
        v11.HeartbeatConnection:Disconnect();
        return;
    end;
end;
v2.Destroy = function(v12) --[[ Line: 90 ]] --[[ Name: Destroy ]]
    v12:Off();
    v12.Elapsed:Destroy();
    table.clear(v12);
end;
return v2;
