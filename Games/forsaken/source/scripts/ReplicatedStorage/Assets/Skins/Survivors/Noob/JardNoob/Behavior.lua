-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local v1 = {};
local function v7(v2, v3) --[[ Line: 5 ]] --[[ Name: __changeTransparency ]]
    local l_Rig_0 = v2.Rig;
    if l_Rig_0 and l_Rig_0.Parent then
        for _, v6 in (l_Rig_0.Slateskin:GetDescendants()) do
            if v6:IsA("BasePart") then
                v6.Transparency = v3;
            elseif v6:IsA("ParticleEmitter") then
                v6.Enabled = v3 < 1;
            end;
        end;
    end;
end;
v1.OnSlateBegin = function(_, v9) --[[ Line: 18 ]] --[[ Name: OnSlateBegin ]]
    -- upvalues: v7 (copy)
    v7(v9, 0.011);
end;
v1.OnSlateConsumed = function(_, v11) --[[ Line: 22 ]] --[[ Name: OnSlateConsumed ]]
    -- upvalues: v7 (copy)
    v7(v11, 1);
end;
return v1;