-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Debris");
local v5 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v6 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v7 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v8 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local v10 = v8:RemoteEvent("PoleGameService/DestroyGear");
local v11 = v8:RemoteEvent("PoleGameService/SpawnGear");
local v12 = v8:RemoteEvent("PoleGameService/PickGear");
local v13 = v8:RemoteEvent("PoleGameService/Blink");
local v14 = v8:RemoteEvent("PoleGameService/Burst");
local v15 = RaycastParams.new();
v15.FilterType = Enum.RaycastFilterType.Include;
v15.FilterDescendantsInstances = {
    workspace.Map, 
    workspace.Plots
};
return {
    Start = function(_) --[[ Line: 26 ]] --[[ Name: Start ]]
        -- upvalues: l_ContentProvider_0 (copy), v13 (copy), v6 (copy), v14 (copy), v5 (copy), v11 (copy), v15 (copy), l_RunService_0 (copy), l_TweenService_0 (copy), v7 (copy), v12 (copy), v10 (copy)
        task.spawn(pcall, l_ContentProvider_0.PreloadAsync, l_ContentProvider_0, script:GetChildren());
        v13.OnClientEvent:Connect(function() --[[ Line: 29 ]]
            -- upvalues: v6 (ref)
            v6:Activate("Blink");
        end);
        v14.OnClientEvent:Connect(function(v17) --[[ Line: 33 ]]
            -- upvalues: v5 (ref)
            v5.playBurst(script.Burst, v17);
        end);
        local v18 = {};
        v11.OnClientEvent:Connect(function(v19, v20, v21, v22, v23, v24) --[[ Line: 39 ]]
            -- upvalues: v18 (copy), v15 (ref), l_RunService_0 (ref), l_TweenService_0 (ref), v7 (ref), v12 (ref)
            local v25 = script.GearVisuals[v20]:Clone();
            v25.Name = v19;
            v18[v19] = v25;
            local v26 = v25.PrimaryPart or v25:FindFirstChild("Handle");
            if v26 then
                v26.Anchored = true;
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Name = "Attachment0";
                l_Attachment_0.Position = Vector3.new(0, 1, 0, 0);
                l_Attachment_0.Parent = v26;
                local l_Attachment_1 = Instance.new("Attachment");
                l_Attachment_1.Name = "Attachment1";
                l_Attachment_1.Position = Vector3.new(0, -1, 0, 0);
                l_Attachment_1.Parent = v26;
                local l_Trail_0 = Instance.new("Trail");
                l_Trail_0.Name = "Trail";
                l_Trail_0.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 119, 248)), 
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 255, 243))
                });
                l_Trail_0.Attachment0 = l_Attachment_0;
                l_Trail_0.Attachment1 = l_Attachment_1;
                l_Trail_0.Lifetime = 0.35;
                l_Trail_0.LightInfluence = 1;
                l_Trail_0.Parent = v25;
            end;
            v25.Parent = workspace;
            local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
            l_ProximityPrompt_0.Name = "ProximityPrompt";
            l_ProximityPrompt_0.ActionText = "Grab";
            l_ProximityPrompt_0.RequiresLineOfSight = false;
            l_ProximityPrompt_0.Enabled = false;
            l_ProximityPrompt_0.Parent = v26;
            local l_v25_Scale_0 = v25:GetScale();
            local v32 = workspace:Raycast(v22 + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -30, -0, -0), v15);
            v22 = v32 and v32.Position or v22;
            local v33 = v21 + (v22 - v21) * 0.5;
            local v34 = v22 + Vector3.new(0, v25:GetExtentsSize().Y * 0.5, 0);
            local v35 = math.random(0, 10000);
            local v41 = l_RunService_0.PostSimulation:Connect(function(_) --[[ Line: 92 ]]
                -- upvalues: v23 (copy), v24 (copy), l_TweenService_0 (ref), v7 (ref), v21 (copy), v33 (copy), v34 (copy), v25 (copy), l_v25_Scale_0 (copy), v35 (copy), l_ProximityPrompt_0 (copy)
                local v37 = workspace:GetServerTimeNow() - v23;
                local v38 = v24 == 0 and 1 or math.clamp(l_TweenService_0:GetValue(v37 / v24, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 0, 1);
                local v39 = v7.quadBezier(v38, v21, v33, v34);
                v25:ScaleTo((math.lerp(l_v25_Scale_0 * 2, l_v25_Scale_0, v38)));
                local v40 = os.clock() + v35;
                v25:PivotTo(CFrame.new(v39 + Vector3.new(0, math.sin(v40 * 2) + 1.5, 0)) * CFrame.Angles(0, v40 % 6.283185307179586, 0));
                if v38 >= 1 then
                    l_ProximityPrompt_0.Enabled = true;
                end;
            end);
            v25.Destroying:Connect(function() --[[ Line: 107 ]]
                -- upvalues: v41 (copy)
                v41:Disconnect();
            end);
            l_ProximityPrompt_0.Triggered:Connect(function() --[[ Line: 111 ]]
                -- upvalues: v12 (ref), v19 (copy)
                v12:FireServer(v19);
            end);
        end);
        v10.OnClientEvent:Connect(function(v42) --[[ Line: 116 ]]
            -- upvalues: v18 (copy)
            local v43 = v18[v42];
            if not v43 then
                return;
            else
                v43:Destroy();
                v18[v42] = nil;
                return;
            end;
        end);
    end
};