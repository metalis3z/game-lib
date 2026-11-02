-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = {
    Color3.fromRGB(243, 229, 171), 
    Color3.fromRGB(223, 178, 178), 
    Color3.fromRGB(132, 86, 60), 
    Color3.fromRGB(121, 156, 208), 
    Color3.fromRGB(171, 255, 227), 
    Color3.fromRGB(244, 187, 68), 
    Color3.fromRGB(137, 77, 189)
};
return {
    CreatedPost = function(_, v3) --[[ Line: 17 ]] --[[ Name: CreatedPost ]]
        -- upvalues: l_RunService_0 (copy), v1 (copy)
        if l_RunService_0:IsServer() then
            local l_Rig_0 = v3.Rig;
            if l_Rig_0 then
                l_Rig_0.Hair.Color = v1[math.random(#v1)];
            end;
        end;
    end
};