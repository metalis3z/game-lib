-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = {
    fps = 8, 
    animated = {}
};
local function v8(v2) --[[ Line: 8 ]] --[[ Name: createAnimateable ]]
    -- upvalues: v1 (copy)
    local v3 = 1;
    local l_v2_Children_0 = v2:GetChildren();
    local v7 = task.spawn(function() --[[ Line: 12 ]]
        -- upvalues: v1 (ref), v3 (ref), l_v2_Children_0 (copy)
        while true do
            task.wait(1 / v1.fps);
            v3 = v3 + 1;
            if v3 > #l_v2_Children_0 then
                v3 = 1;
            end;
            for v5, v6 in pairs(l_v2_Children_0) do
                v6.Transparency = v5 == v3 and 0 or 1;
            end;
        end;
    end);
    return function() --[[ Line: 27 ]]
        -- upvalues: v7 (copy)
        task.cancel(v7);
    end;
end;
v1.CreatedPost = function(_, v10) --[[ Line: 32 ]] --[[ Name: CreatedPost ]]
    -- upvalues: l_RunService_0 (copy), v1 (copy), v8 (copy)
    if l_RunService_0:IsServer() then
        table.insert(v1.animated, (v8(v10.Rig.Skirt)));
        table.insert(v1.animated, (v8(v10.Rig.Ribbon)));
        table.insert(v1.animated, (v8(v10.Rig.HatRib)));
    end;
end;
v1.KillerRemoved = function(_) --[[ Line: 40 ]] --[[ Name: KillerRemoved ]]
    -- upvalues: l_RunService_0 (copy), v1 (copy)
    if l_RunService_0:IsServer() then
        for _, v13 in pairs(v1.animated) do
            v13();
        end;
    end;
end;
return v1;