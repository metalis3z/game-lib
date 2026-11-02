-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:59 2025 ]]
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
v0.OnIntroduction = function(_, v11, v12, v13) --[[ Line: 14 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v9 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Value_0 = l_LocalPlayer_0.PlayerData.Settings.Accessibility.EpilepsyMode.Value;
    local _ = v9:CreateFOVMultiplier(l_LocalPlayer_0, 0.7857142857142857, "YAAIIntro", v13);
    local l_VoidstarCrown_0 = v12:FindFirstChild("VoidstarCrown");
    if l_VoidstarCrown_0 then
        local v18 = v12.VoidstarCrown:Clone();
        v18.Name = "FakeCrown";
        v18.Parent = v12;
        local v19 = Instance.new("Motor6D", v18);
        v19.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
        v19.Part0 = v12.Head;
        v19.Part1 = v18;
        l_VoidstarCrown_0:Destroy();
    end;
    v12.Voidstar:Destroy();
    if not l_Value_0 then
        task.spawn(function() --[[ Line: 38 ]]
            -- upvalues: v11 (copy)
            local v20 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 1);
            if not v20 then
                return;
            else
                for v21, v22 in ipairs(v20:GetChildren()) do
                    if v22.Name == "IDIOT" then
                        local l_ImageLabel_0 = v22:FindFirstChildOfClass("SurfaceGui"):FindFirstChildOfClass("ImageLabel");
                        l_ImageLabel_0:SetAttribute("FrameOffset", v21);
                        l_ImageLabel_0:SetAttribute("Spritesheet", v11.Config.ScreamerSpritesheet);
                        l_ImageLabel_0:AddTag("Spritesheet");
                    end;
                end;
                return;
            end;
        end);
    end;
end;
v0.EnableVoidstar = function(v24) --[[ Line: 56 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v9 (copy), v8 (copy)
    assert(v24, "must pass killerInfo as argument");
    if v24.Behavior.VoidstarEnabled then
        return;
    else
        v24.Behavior.VoidstarEnabled = true;
        local l_Rig_0 = v24.Rig;
        local v26 = l_Rig_0 and l_Rig_0:FindFirstChild("Voidstar");
        if v26 then
            v26.Beam.Enabled = true;
            v26.Main.Main.Enabled = true;
            v9:EmitParticles(v9:MergeTables({
                v26.Appear1, 
                v26.Appear2
            }, v26.AppearT:GetChildren()));
            v8:Play(v24.Config.Sounds.VoidstarEnable, {
                Parent = v26
            });
        end;
        return;
    end;
end;
v0.DisableVoidstar = function(v27) --[[ Line: 74 ]] --[[ Name: DisableVoidstar ]]
    assert(v27, "must pass killerInfo as argument");
    if not v27.Behavior.VoidstarEnabled then
        return;
    else
        v27.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v27.Rig;
        local v29 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v29 then
            v29.Main.Main.Enabled = false;
            v29.Main.Main:Clear();
            v29.Beam.Enabled = false;
        end;
        return;
    end;
end;
return v0;