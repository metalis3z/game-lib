-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:03 2025 ]]
local v0 = {};
local _ = game:GetService("ServerStorage");
local _ = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local v8 = require(game.ReplicatedStorage.Modules.Sounds);
local v9 = require(game.ReplicatedStorage.Modules.Util);
v0.EnableVoidstar = function(v10) --[[ Line: 15 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v9 (copy), v8 (copy)
    assert(v10, "must pass killerInfo as argument");
    if v10.Behavior.VoidstarEnabled then
        return;
    else
        v10.Behavior.VoidstarEnabled = true;
        local l_Rig_0 = v10.Rig;
        local v12 = l_Rig_0 and l_Rig_0:FindFirstChild("Voidstar");
        if v12 then
            v12.Pumpkin1.Transparency = 0;
            v12.Pumpkin1.Pumpkin2.Transparency = 0;
            v12.Pumpkin1.Flames.ParticleEmitter.Enabled = true;
            v12.Main.Main.Enabled = true;
            v9:EmitParticles(v9:MergeTables({
                v12.Appear1, 
                v12.Appear2
            }, v12.AppearT:GetChildren()));
            v8:Play(v10.Config.Sounds.VoidstarEnable, {
                Parent = v12
            });
        end;
        return;
    end;
end;
v0.DisableVoidstar = function(v13) --[[ Line: 35 ]] --[[ Name: DisableVoidstar ]]
    assert(v13, "must pass killerInfo as argument");
    if not v13.Behavior.VoidstarEnabled then
        return;
    else
        v13.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v13.Rig;
        local v15 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v15 then
            v15.Main.Main.Enabled = false;
            v15.Main.Main:Clear();
            v15.Pumpkin1.Transparency = 1;
            v15.Pumpkin1.Pumpkin2.Transparency = 1;
            v15.Pumpkin1.Flames.ParticleEmitter.Enabled = false;
        end;
        return;
    end;
end;
return v0;