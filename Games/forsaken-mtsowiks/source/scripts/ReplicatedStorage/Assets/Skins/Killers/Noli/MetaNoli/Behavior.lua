-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:04 2025 ]]
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
local function v14(v10, v11) --[[ Line: 14 ]] --[[ Name: toggleDescendants ]]
    for _, v13 in ipairs(v10:GetDescendants()) do
        if v13.Name == "MainVFX" then
            v13.Enabled = v11;
        elseif v13.Name == "MainImage" then
            v13.Transparency = v11 and 0 or 1;
        end;
    end;
end;
v0.EnableVoidstar = function(v15) --[[ Line: 23 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v14 (copy), v9 (copy), v8 (copy)
    assert(v15, "must pass killerInfo as argument");
    if v15.Behavior.VoidstarEnabled then
        return;
    else
        v15.Behavior.VoidstarEnabled = true;
        local l_Rig_0 = v15.Rig;
        local v17 = l_Rig_0 and l_Rig_0:FindFirstChild("Voidstar");
        if v17 then
            v17.Transparency = 0;
            v14(v17, true);
            v9:EmitParticles(v9:MergeTables({
                v17.Appear1, 
                v17.Appear2
            }, v17.AppearT:GetChildren()));
            v8:Play(v15.Config.Sounds.VoidstarEnable, {
                Parent = v17
            });
        end;
        return;
    end;
end;
v0.DisableVoidstar = function(v18) --[[ Line: 43 ]] --[[ Name: DisableVoidstar ]]
    -- upvalues: v14 (copy)
    assert(v18, "must pass killerInfo as argument");
    if not v18.Behavior.VoidstarEnabled then
        return;
    else
        v18.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v18.Rig;
        local v20 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v20 then
            v20.Transparency = 1;
            v14(v20, false);
        end;
        return;
    end;
end;
return v0;