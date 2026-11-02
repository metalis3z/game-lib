-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {};
local v2 = false;
local function v8(v3) --[[ Line: 12 ]] --[[ Name: getAllSounds ]]
    local v4 = v3 or game;
    local v5 = {};
    for _, v7 in ipairs(v4:GetDescendants()) do
        if v7:IsA("Sound") then
            table.insert(v5, v7);
        end;
    end;
    return v5;
end;
v0.MuteAllExcept = function(v9, v10) --[[ Line: 25 ]] --[[ Name: MuteAllExcept ]]
    -- upvalues: v2 (ref), v1 (ref), v8 (copy)
    if v2 then
        return;
    else
        local v11 = {};
        local l_ipairs_0 = ipairs;
        local v13 = v9 or {};
        for _, v15 in l_ipairs_0(v13) do
            v11[v15] = true;
        end;
        v1 = {};
        for _, v17 in ipairs((v8(v10))) do
            v1[v17] = {
                Sound = v17, 
                Volume = v17.Volume, 
                Playing = v17.IsPlaying
            };
            if not v11[v17] then
                v17.Volume = 0;
            end;
        end;
        v2 = true;
        return;
    end;
end;
v0.RestoreAll = function() --[[ Line: 52 ]] --[[ Name: RestoreAll ]]
    -- upvalues: v2 (ref), v1 (ref)
    if not v2 then
        return;
    else
        for v18, v19 in pairs(v1) do
            if v18 and v18.Parent then
                v18.Volume = v19.Volume;
            end;
        end;
        v1 = {};
        v2 = false;
        return;
    end;
end;
v0.PlaySolo = function(v20, v21) --[[ Line: 67 ]] --[[ Name: PlaySolo ]]
    -- upvalues: v0 (copy)
    if not v20 then
        return;
    else
        v0.MuteAllExcept({
            v20
        }, v21);
        v20:Play();
        return;
    end;
end;
return v0;