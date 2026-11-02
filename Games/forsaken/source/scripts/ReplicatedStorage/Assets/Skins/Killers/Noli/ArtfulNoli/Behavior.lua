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
v0.OnIntroduction = function(_, _, v23, v24) --[[ Line: 59 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v9 (copy)
    local function v27() --[[ Line: 60 ]] --[[ Name: addWand ]]
        -- upvalues: v23 (copy)
        local v25 = v23:WaitForChild("Right Arm", 1);
        if not v25 then
            return;
        else
            local v26 = script["BAGUETTE MAGIIIIQUE"]:Clone();
            v26.Parent = v23;
            v26.CFrame = v25.CFrame;
            v26["BAGUETTE MAGIIIIQUE"].Part0 = v25;
            return;
        end;
    end;
    local function v28() --[[ Line: 72 ]] --[[ Name: doFOV ]]
        -- upvalues: v9 (ref), v24 (copy)
        v9:CreateFOVMultiplier(game.Players.LocalPlayer.Character, 0.8571428571428571, "ArtfulIntro", v24);
    end;
    local function v35() --[[ Line: 76 ]] --[[ Name: throwBananas ]]
        local v29 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
        if v29 then
            local l_BananaSpawns_0 = v29:FindFirstChild("BananaSpawns");
            local l_Banana_0 = v29:FindFirstChild("Banana");
            if l_BananaSpawns_0 and l_Banana_0 then
                local v32 = os.clock();
                l_BananaSpawns_0 = l_BananaSpawns_0:GetChildren();
                while os.clock() - v32 < 1.5 and v29 and v29.Parent do
                    local v33 = l_BananaSpawns_0[math.random(1, #l_BananaSpawns_0)];
                    local v34 = l_Banana_0:Clone();
                    v34.CFrame = v33.CFrame;
                    v34.Parent = v29;
                    v34.AssemblyLinearVelocity = (v29.PrimaryPart.Position - v33.Position).Unit * math.random(30, 125);
                    game.Debris:AddItem(v34, 1.7);
                    task.wait(0.015);
                end;
            else
                warn("[ArtfulNoli/Behavior]: BAD BANANAS??");
            end;
        end;
    end;
    task.spawn(v27);
    task.spawn(v28);
    task.delay(2.8, v35);
end;
return v0;