-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = game:GetService("ServerStorage");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local v10 = require(game.ReplicatedStorage.Modules.Util);
v0.OnIntroduction = function(_, v12, v13, v14) --[[ Line: 15 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v10 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    v10:CreateFOVMultiplier(l_LocalPlayer_0, 0.8571428571428571, "DivaIntro", v14);
    task.delay(3.1333333333333333, function() --[[ Line: 22 ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        local v16 = Instance.new("ScreenGui", l_LocalPlayer_0.PlayerGui);
        v16.Name = "DivaOverlayThingy";
        game.Debris:AddItem(v16, 0.5666666666666667);
        local v17 = Instance.new("Frame", v16);
        v17.Size = UDim2.new(2, 0, 2, 0);
        v17.AnchorPoint = Vector2.new(0.5, 0.5);
        v17.Position = UDim2.new(0.5, 0, 0.5, 0);
        v17.BackgroundColor3 = Color3.new(0, 0, 0);
    end);
    task.delay(0.2, function() --[[ Line: 35 ]]
        -- upvalues: v14 (copy)
        local v18 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 2);
        if not v18 then
            return;
        else
            for _, v20 in ipairs(v18.Dummies.Real.Door:GetChildren()) do
                if v20.Name == "Frame" then
                    v20.Anchored = false;
                    v20.CanCollide = false;
                    v20.AssemblyLinearVelocity = v18.Dummies.Real.PrimaryPart.CFrame.LookVector * math.random(1, 4);
                    v20.AssemblyAngularVelocity = Vector3.new(math.random(-1.3, 1.3), math.random(-1.3, 1.3), math.random(-1.3, 1.3));
                    game.Debris:AddItem(v20, v14 - 0.2);
                end;
            end;
            return;
        end;
    end);
    v13:SetPrimaryPartCFrame(CFrame.new(0, 10000, 10));
    v10:PlayDummyCutsceneAnimations(v12, v14, "Introduction");
end;
v0.OnVictory = function(_, v22, v23, v24, v25) --[[ Line: 57 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_RunService_0 (copy), v10 (copy)
    if v22 == "Start" then
        local _ = tick();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v27 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 62 ]]
            workspace.CurrentCamera.FieldOfView = 53;
        end);
        task.delay(v25, function() --[[ Line: 66 ]]
            -- upvalues: v27 (copy)
            v27:Disconnect();
        end);
        v24:SetPrimaryPartCFrame(CFrame.new(0, 10000, 10));
        v10:PlayDummyCutsceneAnimations(v23, v25, "Victory");
        return;
    else
        if v22 == "End" then
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
return v0;