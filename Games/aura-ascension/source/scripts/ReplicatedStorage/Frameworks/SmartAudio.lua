-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = setmetatable({}, {
    __mode = "k"
});
local v2 = {};
local l_clock_0 = os.clock;
local function v9(v4, v5) --[[ Line: 11 ]] --[[ Name: getPool ]]
    -- upvalues: v1 (copy)
    local v6 = v1[v4];
    if v6 then
        if v5 and v5 > 0 then
            v6.max = v5;
        end;
        return v6;
    else
        v6 = {
            free = {}, 
            max = v5 or 6
        };
        v1[v4] = v6;
        for _ = 1, math.min(3, v6.max) do
            local v8 = v4:Clone();
            v8.Looped = false;
            v8.Parent = v4.Parent;
            v6.free[#v6.free + 1] = v8;
        end;
        return v6;
    end;
end;
v0.Play = function(v10, v11, v12, v13, v14) --[[ Line: 31 ]] --[[ Name: Play ]]
    -- upvalues: v9 (copy), l_clock_0 (copy), v2 (copy)
    if not v10 then
        return;
    else
        local v15 = v9(v10, v14 or 6);
        local v16 = v15.free[#v15.free];
        if v16 then
            v15.free[#v15.free] = nil;
        else
            v16 = v10:Clone();
            v16.Looped = false;
            v16.Parent = v10.Parent;
        end;
        v16.Volume = v10.Volume;
        v16.SoundGroup = v10.SoundGroup;
        v16.RollOffMaxDistance = v10.RollOffMaxDistance;
        v16.RollOffMinDistance = v10.RollOffMinDistance;
        v16.TimePosition = 0;
        local v17 = v12 or 0.98;
        local v18 = v13 or 1.17;
        local v19 = typeof(v11);
        if v19 == "Random" then
            v16.PlaybackSpeed = v10.PlaybackSpeed - 1 + v11:NextNumber(v17, v18);
        elseif v19 == "function" then
            v16.PlaybackSpeed = v11(v17, v18);
        else
            v16.PlaybackSpeed = Random.new():NextNumber(v17, v18);
        end;
        v16:Play();
        local l_TimeLength_0 = v16.TimeLength;
        if not l_TimeLength_0 or l_TimeLength_0 <= 0 then
            l_TimeLength_0 = 0.25;
        end;
        local v21 = l_clock_0() + l_TimeLength_0 / v16.PlaybackSpeed + 0.03;
        v2[#v2 + 1] = {
            S = v16, 
            E = v21, 
            T = v10
        };
        return;
    end;
end;
v0.Update = function(v22) --[[ Line: 75 ]] --[[ Name: Update ]]
    -- upvalues: v2 (copy), v1 (copy)
    for v23 = #v2, 1, -1 do
        local v24 = v2[v23];
        if v24.E <= v22 then
            local l_S_0 = v24.S;
            local l_T_0 = v24.T;
            if l_S_0 then
                l_S_0:Stop();
                l_S_0.TimePosition = 0;
                local v27 = l_T_0 and v1[l_T_0];
                if v27 and #v27.free < v27.max then
                    v27.free[#v27.free + 1] = l_S_0;
                else
                    l_S_0:Destroy();
                end;
            end;
            v2[v23] = v2[#v2];
            v2[#v2] = nil;
        end;
    end;
end;
return v0;