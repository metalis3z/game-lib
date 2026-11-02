-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:11:09 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
return {
    OnThrowPizza = function(_, v2) --[[ Line: 5 ]] --[[ Name: OnThrowPizza ]]
        local l_Rig_0 = v2.Rig;
        if l_Rig_0 and l_Rig_0.Parent then
            local l_Pizza_0 = l_Rig_0:FindFirstChild("Pizza");
            if not l_Pizza_0 then
                return;
            else
                for _, v6 in (l_Pizza_0:GetDescendants()) do
                    if v6:IsA("BasePart") and v6.Name ~= "Hitbox" then
                        v6.Transparency = 0;
                    elseif v6:IsA("ParticleEmitter") then
                        v6.Enabled = true;
                    elseif v6:IsA("Sound") then
                        v6:Play();
                    end;
                end;
            end;
        end;
    end
};