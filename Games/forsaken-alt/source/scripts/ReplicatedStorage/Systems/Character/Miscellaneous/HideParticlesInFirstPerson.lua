-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        task.spawn(function() --[[ Line: 6 ]]
            local _ = workspace.CurrentCamera;
            local l_Character_0 = game.Players.LocalPlayer.Character;
            local _ = l_Character_0:WaitForChild("Humanoid");
            local v4 = {};
            local function v6(v5) --[[ Line: 15 ]] --[[ Name: addParticle ]]
                -- upvalues: v4 (copy)
                if v5:IsA("ParticleEmitter") or v5:IsA("Beam") or v5:IsA("Trail") then
                    table.insert(v4, v5);
                end;
            end;
            for _, v8 in pairs(l_Character_0:GetDescendants()) do
                if v8:IsA("ParticleEmitter") or v8:IsA("Beam") or v8:IsA("Trail") then
                    table.insert(v4, v8);
                end;
            end;
            l_Character_0.DescendantAdded:Connect(v6);
            local v9 = l_Character_0:WaitForChild("Head", 10);
            if v9 then
                v9:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() --[[ Line: 28 ]]
                    -- upvalues: v9 (copy), v4 (copy)
                    local l_LocalTransparencyModifier_0 = v9.LocalTransparencyModifier;
                    for _, v12 in pairs(v4) do
                        v12.LocalTransparencyModifier = l_LocalTransparencyModifier_0;
                    end;
                end);
            end;
        end);
    end
};