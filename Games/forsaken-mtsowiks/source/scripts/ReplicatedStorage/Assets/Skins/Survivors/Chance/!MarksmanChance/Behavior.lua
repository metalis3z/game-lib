-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:56 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
v0.ShootStart = function(v3) --[[ Line: 6 ]] --[[ Name: ShootStart ]]
    local l_Rig_0 = v3.Rig;
    if not l_Rig_0 then
        return;
    else
        local l_HumanoidRootPart_0 = l_Rig_0:FindFirstChild("HumanoidRootPart");
        if not l_HumanoidRootPart_0 then
            return;
        else
            for v6 = 1, 2 do
                local l_l_HumanoidRootPart_0_FirstChild_0 = l_HumanoidRootPart_0:FindFirstChild((tostring(v6)));
                if l_l_HumanoidRootPart_0_FirstChild_0 then
                    for _, v9 in ipairs(l_l_HumanoidRootPart_0_FirstChild_0:GetDescendants()) do
                        if v9.Name == "Circle" and v9:IsA("ParticleEmitter") then
                            v9:Emit(10);
                        end;
                    end;
                    for _, v11 in ipairs(l_l_HumanoidRootPart_0_FirstChild_0:GetDescendants()) do
                        if v11.Name == "Flame1" and v11:IsA("ParticleEmitter") then
                            v11:Emit(50);
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
v0.ShootSuccess = function(v12) --[[ Line: 31 ]] --[[ Name: ShootSuccess ]]
    local l_Rig_1 = v12.Rig;
    if not l_Rig_1 then
        return;
    else
        local l_HumanoidRootPart_1 = l_Rig_1:FindFirstChild("HumanoidRootPart");
        if not l_HumanoidRootPart_1 then
            return;
        else
            local l_1_0 = l_HumanoidRootPart_1:FindFirstChild("1");
            if not l_1_0 then
                return;
            elseif not l_1_0:FindFirstChild("Beam") then
                return;
            else
                for _, v17 in ipairs(l_1_0:GetDescendants()) do
                    if v17:IsA("Beam") then
                        v17.Enabled = true;
                        task.delay(0.15, function() --[[ Line: 47 ]]
                            -- upvalues: v17 (copy)
                            v17.Enabled = false;
                        end);
                    end;
                end;
                for v18 = 2, 6 do
                    local l_l_1_0_FirstChild_0 = l_1_0:FindFirstChild("Lament" .. v18, true);
                    if l_l_1_0_FirstChild_0 and l_l_1_0_FirstChild_0:IsA("ParticleEmitter") then
                        l_l_1_0_FirstChild_0:Emit(50);
                    end;
                end;
                return;
            end;
        end;
    end;
end;
v0.ShootFail = function(v20) --[[ Line: 61 ]] --[[ Name: ShootFail ]]
    -- upvalues: v0 (copy)
    local l_Rig_2 = v20.Rig;
    if not l_Rig_2 then
        return;
    else
        v0.removecirclesnstuff(l_Rig_2);
        local l_Burst_0 = l_Rig_2.Head.Burst;
        for _, v24 in ipairs(l_Burst_0:GetDescendants()) do
            if v24:IsA("ParticleEmitter") then
                v24:Emit(10);
            end;
        end;
        return;
    end;
end;
v0.ShootExplode = function(v25) --[[ Line: 74 ]] --[[ Name: ShootExplode ]]
    -- upvalues: v0 (copy), v2 (copy)
    local l_Rig_3 = v25.Rig;
    if not l_Rig_3 then
        return;
    else
        task.delay(0.4, function() --[[ Line: 78 ]]
            -- upvalues: v0 (ref), l_Rig_3 (copy), v2 (ref), v25 (copy)
            v0.removecirclesnstuff(l_Rig_3);
            v2:Play(v25.Config.Sounds.OWOWSFX, {
                Parent = l_Rig_3.PrimaryPart, 
                Volume = 0.4
            });
            local l_Burst_1 = l_Rig_3.Head.Burst;
            for _, v29 in ipairs(l_Burst_1:GetDescendants()) do
                if v29:IsA("ParticleEmitter") then
                    v29:Emit(50);
                end;
            end;
            local l_HumanoidRootPart_2 = l_Rig_3:FindFirstChild("HumanoidRootPart");
            if not l_HumanoidRootPart_2 then
                return;
            else
                local l_3_0 = l_HumanoidRootPart_2:FindFirstChild("3");
                if not l_3_0 then
                    return;
                elseif not l_3_0:FindFirstChild("Beam") then
                    return;
                else
                    for _, v33 in ipairs(l_3_0:GetDescendants()) do
                        if v33:IsA("Beam") then
                            v33.Enabled = true;
                            task.delay(0.15, function() --[[ Line: 100 ]]
                                -- upvalues: v33 (copy)
                                v33.Enabled = false;
                            end);
                        end;
                    end;
                    for v34 = 2, 6 do
                        local l_l_3_0_FirstChild_0 = l_3_0:FindFirstChild("Lament" .. v34, true);
                        if l_l_3_0_FirstChild_0 and l_l_3_0_FirstChild_0:IsA("ParticleEmitter") then
                            l_l_3_0_FirstChild_0:Emit(50);
                        end;
                    end;
                    return;
                end;
            end;
        end);
        return;
    end;
end;
v0.removecirclesnstuff = function(v36) --[[ Line: 116 ]] --[[ Name: removecirclesnstuff ]]
    local l_HumanoidRootPart_3 = v36:FindFirstChild("HumanoidRootPart");
    if not l_HumanoidRootPart_3 then
        return;
    else
        for v38 = 1, 4 do
            local l_l_HumanoidRootPart_3_FirstChild_0 = l_HumanoidRootPart_3:FindFirstChild((tostring(v38)));
            if l_l_HumanoidRootPart_3_FirstChild_0 then
                for _, v41 in ipairs(l_l_HumanoidRootPart_3_FirstChild_0:GetDescendants()) do
                    if v41.Name == "Circle" then
                        v41.Enabled = false;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
v0.HatFix = function(v42) --[[ Line: 132 ]] --[[ Name: HatFix ]]
    -- upvalues: v2 (copy)
    local l_Rig_4 = v42.Rig;
    if not l_Rig_4 then
        return;
    else
        task.delay(0.15, function() --[[ Line: 136 ]]
            -- upvalues: l_Rig_4 (copy), v2 (ref), v42 (copy)
            l_Rig_4.lowpolychance.p.Attachment.ParticleEmitter:Emit(5);
            v2:Play(v42.Config.Sounds.PstSFX, {
                Parent = l_Rig_4.PrimaryPart, 
                Volume = 0.3
            });
        end);
        task.delay(1, function() --[[ Line: 140 ]]
            -- upvalues: v2 (ref), v42 (copy), l_Rig_4 (copy)
            v2:Play(v42.Config.Sounds.SighSFX, {
                Parent = l_Rig_4.PrimaryPart, 
                Volume = 0.3
            });
        end);
        return;
    end;
end;
return v0;