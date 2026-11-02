-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    XPTable = {}
};
local function _(v1) --[[ Line: 17 ]] --[[ Name: GetTotalXP ]]
    return (1000 + 225 * v1) * v1 - 225 * (v1 * (0.5 * (v1 - 1))) - 1000 - 225;
end;
(function(v3) --[[ Line: 22 ]] --[[ Name: GenerateXPTable ]]
    local v4 = 0;
    for v5 = 1, 100 do
        local v6 = v5 - 1;
        local v7 = (1000 + 225 * v6) * v6 - 225 * (v6 * (0.5 * (v6 - 1))) - 1000 - 225;
        v4 = v4 + ((1000 + 225 * v5) * v5 - 225 * (v5 * (0.5 * (v5 - 1))) - 1000 - 225 - v7);
        v0.XPTable[v5] = v4;
        if v3 then
            print("Level: ", v5, " XP: ", v5, (1000 + 225 * v5) * v5 - 225 * (v5 * (0.5 * (v5 - 1))) - 1000 - 225);
        end;
    end;
end)();
v0.GetLevel = function(_) --[[ Line: 44 ]]
    return 100, v0.XPTable[100];
end;
v0.GetXP = function(v12) --[[ Line: 68 ]]
    v12 = v12 or 1;
    if v12 < 1 then
        v12 = 1;
    end;
    local l_v12_0 = v12;
    return (1000 + 225 * l_v12_0) * l_v12_0 - 225 * (l_v12_0 * (0.5 * (l_v12_0 - 1))) - 1000 - 225;
end;
v0.GetProgressToNextLevel = function(_) --[[ Line: 77 ]]
    return 1;
end;
return v0;