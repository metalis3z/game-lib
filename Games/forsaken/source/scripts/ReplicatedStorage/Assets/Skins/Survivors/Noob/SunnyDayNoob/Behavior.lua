-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local v1 = {};
local function v7(v2, v3) --[[ Line: 5 ]] --[[ Name: __changeTransparency ]]
    local l_Rig_0 = v2.Rig;
    if l_Rig_0 and l_Rig_0.Parent then
        for _, v6 in (l_Rig_0.BloxyCola:GetChildren()) do
            if v6:IsA("BasePart") then
                v6.Transparency = v3 and 1 or v6:GetAttribute("OriginalTransparency") or 0;
            end;
        end;
    end;
end;
v1.CreatedPost = function(_, v9) --[[ Line: 16 ]] --[[ Name: CreatedPost ]]
    local l_Rig_1 = v9.Rig;
    if l_Rig_1 and l_Rig_1.Parent then
        for _, v12 in (l_Rig_1.BloxyCola:GetChildren()) do
            if v12:IsA("BasePart") then
                v12:SetAttribute("OriginalTransparency", v12.Transparency);
                v12.Transparency = 1;
            end;
        end;
    end;
end;
v1.OnBloxyBegin = function(_, v14) --[[ Line: 28 ]] --[[ Name: OnBloxyBegin ]]
    -- upvalues: v7 (copy)
    v7(v14, false);
end;
v1.OnBloxyConsumed = function(_, v16) --[[ Line: 32 ]] --[[ Name: OnBloxyConsumed ]]
    -- upvalues: v7 (copy)
    v7(v16, true);
end;
return v1;