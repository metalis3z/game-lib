-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = require(game.ReplicatedStorage.GlobalTypes);
local v1 = {
    Hurt = true, 
    Default = true, 
    Happy = true, 
    Dead = true
};
return {
    onExpressionChanged = function(_, v3, v4, _) --[[ Line: 11 ]] --[[ Name: onExpressionChanged ]]
        -- upvalues: v1 (copy)
        v4 = v4 == "Injured" and "Hurt" or v1[v4] and v4 or "Default";
        local l_Rig_0 = v3.Rig;
        if l_Rig_0 and l_Rig_0.Parent then
            local l_Goggles_0 = l_Rig_0.FakeHead:FindFirstChild("Goggles");
            if not l_Goggles_0 then
                return;
            else
                local v8 = l_Goggles_0.EyeInstance:GetChildren() or {};
                for _, v10 in v8 do
                    v10.Transparency = v10.Name == v4 and 0 or 1;
                end;
            end;
        end;
    end
};