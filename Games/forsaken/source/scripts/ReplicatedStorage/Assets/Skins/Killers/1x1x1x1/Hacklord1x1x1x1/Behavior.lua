-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
local l_TweenService_0 = game:GetService("TweenService");
v0.SummonZombie = function(_, v9) --[[ Line: 13 ]] --[[ Name: SummonZombie ]]
    if not v9 then
        return;
    else
        if v9.PrimaryPart then
            if not v9.PrimaryPart:FindFirstChild("Radius") then
                return;
            else
                v9.PrimaryPart.Radius:Play();
            end;
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, v11, _, v13) --[[ Line: 22 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v6 (copy), l_TweenService_0 (copy)
    local _ = game.Players.LocalPlayer;
    v6:SetCustomLighting(v11.Config.IntroLighting);
    task.spawn(function() --[[ Line: 27 ]]
        -- upvalues: l_TweenService_0 (ref)
        local v15 = script.IntroScreen:Clone();
        v15.Parent = game.Players.LocalPlayer.PlayerGui;
        game.TweenService:Create(v15.Main.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            ImageTransparency = 0
        }):Play();
        game.Debris:AddItem(v15, 2);
        task.delay(0.92, function() --[[ Line: 32 ]]
            -- upvalues: v15 (copy)
            game.TweenService:Create(v15.Main.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quart), {
                ImageTransparency = 1
            }):Play();
        end);
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        l_CurrentCamera_0.FieldOfView = 30;
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        task.wait(0.92);
        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1.2), {
            FieldOfView = 50
        }):Play();
        task.wait(1.2);
        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1.38), {
            FieldOfView = 25
        }):Play();
        task.wait(1.38);
        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1.03, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 60
        }):Play();
        task.wait(1.03);
        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 0
        }):Play();
    end);
    task.delay(v13, function() --[[ Line: 54 ]]
        -- upvalues: v6 (ref)
        v6:SetAsCurrentLighting();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
    end);
end;
v0.OnExecution = function(_, v18, v19) --[[ Line: 60 ]] --[[ Name: OnExecution ]]
    local l_Sword_0 = v19:FindFirstChild("Sword");
    local l_Humanoid_0 = v19:FindFirstChild("Humanoid");
    local _ = v19:FindFirstChild("Head");
    local v23 = require(game.ReplicatedStorage.Modules.Ragdolls);
    if v19.Name == "Shedletsky" then
        l_Sword_0.Transparency = 0;
        local _ = workspace:GetServerTimeNow() + 4.17;
        task.delay(4.17, function() --[[ Line: 70 ]]
            -- upvalues: l_Humanoid_0 (copy), v23 (copy), v19 (copy), v18 (copy)
            if l_Humanoid_0 then
                v23.AddProfile(v19, {
                    Velocity = v18.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
                });
                l_Humanoid_0.Health = 0;
            end;
        end);
        return;
    else
        local _ = workspace:GetServerTimeNow() + 1.89;
        task.delay(1.89, function() --[[ Line: 78 ]]
            -- upvalues: l_Humanoid_0 (copy), v23 (copy), v19 (copy), v18 (copy)
            if l_Humanoid_0 then
                v23.AddProfile(v19, {
                    Velocity = v18.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
                });
                l_Humanoid_0.Health = 0;
            end;
        end);
        return;
    end;
end;
return v0;