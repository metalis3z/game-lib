-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = game:GetService("ServerStorage");
local _ = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local v8 = require(game.ReplicatedStorage.Modules.Sounds);
local v9 = require(game.ReplicatedStorage.Modules.Util);
v0.ToggleTendril = function(v10, v11) --[[ Line: 14 ]] --[[ Name: ToggleTendril ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_Shovel_0 = v10.Rig["Right Arm"]:FindFirstChild("Shovel");
    local v13 = v11 and 0 or 1;
    for _, v15 in ipairs({
        l_Shovel_0, 
        table.unpack(l_Shovel_0:GetChildren())
    }) do
        if v15:IsA("BasePart") then
            l_TweenService_0:Create(v15, TweenInfo.new(v11 and 0.1 or 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = v13
            }):Play();
        end;
    end;
end;
v0.EnableVoidstar = function(v16) --[[ Line: 25 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v9 (copy), v8 (copy)
    assert(v16, "must pass killerInfo as argument");
    if v16.Behavior.VoidstarEnabled then
        return;
    else
        v16.Behavior.VoidstarEnabled = true;
        local l_Rig_0 = v16.Rig;
        local v18 = l_Rig_0 and l_Rig_0:FindFirstChild("Voidstar");
        if v18 then
            v18.Transparency = 0;
            v18.Main.Main.Enabled = true;
            v9:EmitParticles(v9:MergeTables({
                v18.Appear1, 
                v18.Appear2
            }, v18.AppearT:GetChildren()));
            for _, v20 in ipairs(v18:GetChildren()) do
                if v20.Name == "Decal" then
                    v20.Transparency = 0;
                end;
            end;
            v8:Play(v16.Config.Sounds.VoidstarEnable, {
                Parent = v18
            });
        end;
        return;
    end;
end;
v0.DisableVoidstar = function(v21) --[[ Line: 48 ]] --[[ Name: DisableVoidstar ]]
    assert(v21, "must pass killerInfo as argument");
    if not v21.Behavior.VoidstarEnabled then
        return;
    else
        v21.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v21.Rig;
        local v23 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v23 then
            v23.Transparency = 1;
            v23.Main.Main.Enabled = false;
            v23.Main.Main:Clear();
            for _, v25 in ipairs(v23:GetChildren()) do
                if v25.Name == "Decal" then
                    v25.Transparency = 1;
                end;
            end;
        end;
        return;
    end;
end;
return v0;