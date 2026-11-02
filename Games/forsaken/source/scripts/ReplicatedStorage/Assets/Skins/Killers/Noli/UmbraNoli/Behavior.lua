-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
            for _, v14 in ipairs(v12.Main:GetChildren()) do
                v14.Enabled = true;
            end;
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
v0.DisableVoidstar = function(v15) --[[ Line: 36 ]] --[[ Name: DisableVoidstar ]]
    assert(v15, "must pass killerInfo as argument");
    if not v15.Behavior.VoidstarEnabled then
        return;
    else
        v15.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v15.Rig;
        local v17 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v17 then
            for _, v19 in ipairs(v17.Main:GetChildren()) do
                v19:Clear();
                v19.Enabled = false;
            end;
        end;
        return;
    end;
end;
return v0;