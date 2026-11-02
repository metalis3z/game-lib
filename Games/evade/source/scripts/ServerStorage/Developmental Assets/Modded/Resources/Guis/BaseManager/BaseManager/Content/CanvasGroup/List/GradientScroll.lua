-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = {};
return function(v2, v3) --[[ Line: 12 ]]
	-- upvalues: v1 (copy), l_RunService_0 (copy)
    local v4 = v3 or 1;
    local v5 = nil;
    if v1[v2] then
        v5 = v1[v2];
    else
        v5 = {};
        for _, v7 in ipairs(v2.Color.Keypoints) do
            table.insert(v5, {
                Color = v7.Value, 
                Time = v7.Time
            });
        end;
        v1[v2] = v5;
    end;
    local v8 = false;
    local function v9() --[[ Line: 36 ]]
        -- upvalues: v8 (ref)
        if v8 then
            return;
        else
            v8 = true;
            return;
        end;
    end;
    task.spawn(function() --[[ Line: 43 ]]
        -- upvalues: v8 (ref), v4 (copy), v5 (ref), v2 (copy), l_RunService_0 (ref)
        local v10 = tick();
        while not v8 do
            local v11 = {};
            local v12 = (tick() - v10) / v4;
            for _, v14 in v5 do
                table.insert(v11, ColorSequenceKeypoint.new(math.fmod(v14.Time + v12, 1), v14.Color));
            end;
            table.sort(v11, function(v15, v16) --[[ Line: 51 ]]
                return v15.Time < v16.Time;
            end);
            local v17 = 1 - v11[#v11].Time;
            local v18 = v17 + v11[1].Time;
            local v19 = v11[#v11].Value:Lerp(v11[1].Value, v17 / v18);
            table.insert(v11, 1, ColorSequenceKeypoint.new(0, v19));
            table.insert(v11, ColorSequenceKeypoint.new(1, v19));
            v2.Color = ColorSequence.new(v11);
            l_RunService_0.RenderStepped:Wait();
        end;
    end);
    v2.Destroying:Connect(v9);
    return v9;
end;