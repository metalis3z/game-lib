-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
v0.DeepCopy = function(v1) --[[ Line: 3 ]] --[[ Name: DeepCopy ]]
    -- upvalues: v0 (copy)
    local v2 = {};
    for v3, v4 in v1 do
        if typeof(v4) == "table" then
            v2[v3] = v0.DeepCopy(v4);
        else
            v2[v3] = v4;
        end;
    end;
    return v2;
end;
v0.CommaNumber = function(_, _) --[[ Line: 18 ]] --[[ Name: CommaNumber ]]
    local _ = nil;
    local v8 = nil;
    repeat
        local v9, v10 = string.gsub(v8, "^(-?%d+)(%d%d%d)", "%1,%2");
        v8 = v9;
    until v10 == 0;
    return v8;
end;
v0.IsTestingServer = function(_) --[[ Line: 31 ]] --[[ Name: IsTestingServer ]]
    return game.GameId == 119460199;
end;
return v0;