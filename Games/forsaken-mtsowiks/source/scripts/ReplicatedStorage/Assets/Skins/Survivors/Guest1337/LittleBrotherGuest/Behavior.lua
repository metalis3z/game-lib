-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:19 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Util);
v0.CreatedPost = function(_, v3) --[[ Line: 5 ]] --[[ Name: CreatedPost ]]
    if game["Run Service"]:IsServer() then
        local l_Rig_0 = v3.Rig;
        if not (l_Rig_0.PrimaryPart or l_Rig_0:WaitForChild("HumanoidRootPart", 1)) then
            return;
        else
            l_Rig_0:GetAttributeChangedSignal("Parried"):Connect(function() --[[ Line: 11 ]]
                -- upvalues: v3 (copy)
                for _, v6 in pairs(v3.Rig["Right Arm"].Flare:GetChildren()) do
                    if v6:IsA("ParticleEmitter") then
                        v6:Emit(0.4);
                    end;
                end;
                for _, v8 in pairs(v3.Rig["Right Arm"].Flare:GetChildren()) do
                    if v8:IsA("ParticleEmitter") then
                        v8:Emit(0);
                    end;
                end;
                for _, v10 in pairs(v3.Rig.HumanoidRootPart.Effect:GetChildren()) do
                    if v10:IsA("ParticleEmitter") then
                        v10:Emit(1);
                    end;
                end;
                for _, v12 in pairs(v3.Rig.HumanoidRootPart.Effect:GetChildren()) do
                    if v12:IsA("ParticleEmitter") then
                        v12:Emit(0);
                    end;
                end;
            end);
        end;
    end;
end;
return v0;