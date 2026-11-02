-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Network);
v0.Enable = function(_, v3, v4) --[[ Line: 7 ]] --[[ Name: Enable ]]
    if v3:GetAttribute("CantRagdoll") then
        return;
    elseif v3:GetAttribute("Ragdolling") then
        return;
    else
        v3:SetAttribute("Ragdolling", true);
        v3.Archivable = true;
        local l_v3_0 = v3;
        if v4 then
            local function v10() --[[ Line: 18 ]] --[[ Name: hideOriginalChar ]]
                -- upvalues: v3 (copy)
                for _, v7 in pairs(v3:GetDescendants()) do
                    local v8 = v7:IsA("BasePart");
                    local v9 = v7:IsA("Decal");
                    if v8 or v9 then
                        if v8 then
                            v7.CollisionGroup = "DeadPlayers";
                        end;
                        v7.Transparency = 1;
                    end;
                end;
            end;
            local l_Ragdolls_0 = workspace:FindFirstChild("Ragdolls");
            if not l_Ragdolls_0 then
                return;
            else
                local v12 = require(game.ReplicatedStorage.Initializer);
                local l_RagdollLimit_0 = v12.PlayerSettings.RagdollLimit;
                local l_RagdollSillies_0 = v12.PlayerSettings.RagdollSillies;
                if #l_Ragdolls_0:GetChildren() >= l_RagdollLimit_0.Value then
                    v10();
                    return;
                else
                    l_v3_0 = v3:Clone();
                    l_v3_0.Parent = l_Ragdolls_0;
                    if l_v3_0.PrimaryPart then
                        l_v3_0.PrimaryPart.Anchored = false;
                    end;
                    v10();
                    for _, v16 in pairs(l_v3_0:GetDescendants()) do
                        if v16:IsA("Sound") or v16:IsA("ParticleEmitter") or v16:IsA("Light") or v16:IsA("Beam") or v16:IsA("Highlight") then
                            v16:Destroy();
                        end;
                    end;
                    for v17, v18 in pairs({
                        "BodyVelocity", 
                        "LinearVelocity", 
                        "PlayerAura"
                    }) do
                        local l_l_v3_0_FirstChild_0 = l_v3_0:FindFirstChild(v18, true);
                        while l_l_v3_0_FirstChild_0 and (v17 > 2 or not l_RagdollSillies_0.Value) do
                            l_l_v3_0_FirstChild_0.Name = "ded";
                            l_l_v3_0_FirstChild_0:Destroy();
                            l_l_v3_0_FirstChild_0 = l_v3_0:FindFirstChild(v18, true);
                        end;
                    end;
                    local l_l_v3_0_FirstChild_1 = l_v3_0:FindFirstChild("PlayerAura", true);
                    while l_l_v3_0_FirstChild_1 do
                        l_l_v3_0_FirstChild_1.Name = "ded";
                        l_l_v3_0_FirstChild_1:Destroy();
                        l_l_v3_0_FirstChild_1 = l_v3_0:FindFirstChild("PlayerAura", true);
                    end;
                    task.spawn(function() --[[ Line: 74 ]]
                        -- upvalues: l_v3_0 (ref), v3 (copy)
                        local v21 = l_v3_0:WaitForChild("Humanoid", 5);
                        if v21 then
                            v21.Health = 1;
                            v21.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
                            if game["Run Service"]:IsClient() and game.Players.LocalPlayer.Character == v3 then
                                local l_Humanoid_0 = v3:FindFirstChild("Humanoid");
                                if l_Humanoid_0 and l_Humanoid_0.BreakJointsOnDeath then
                                    workspace.CurrentCamera.CameraSubject = l_v3_0:FindFirstChild("Head") or v21;
                                    return;
                                else
                                    workspace.CurrentCamera.CameraSubject = v21;
                                end;
                            end;
                        end;
                    end);
                    task.delay(30, function() --[[ Line: 90 ]]
                        -- upvalues: l_v3_0 (ref)
                        if not l_v3_0.Parent then
                            return;
                        else
                            game.Debris:AddItem(l_v3_0, 10);
                            for _, v24 in pairs(l_v3_0:GetDescendants()) do
                                if v24:IsA("BasePart") or v24:IsA("Decal") then
                                    game.TweenService:Create(v24, TweenInfo.new(10, Enum.EasingStyle.Linear), {
                                        Transparency = 1
                                    }):Play();
                                end;
                            end;
                            return;
                        end;
                    end);
                end;
            end;
        end;
        for _, v26 in pairs(l_v3_0:GetDescendants()) do
            if v26:IsA("Motor6D") and v26.Parent.Name ~= "HumanoidRootPart" and v26.Parent.Name ~= "Head" then
                local l_BallSocketConstraint_0 = Instance.new("BallSocketConstraint");
                l_BallSocketConstraint_0.Name = "TemporaryRagdollInstance";
                local l_Attachment_0 = Instance.new("Attachment");
                l_Attachment_0.Name = "TemporaryRagdollInstance";
                local l_Attachment_1 = Instance.new("Attachment");
                l_Attachment_1.Name = "TemporaryRagdollInstance";
                l_Attachment_0.Parent = v26.Part0;
                l_Attachment_1.Parent = v26.Part1;
                l_BallSocketConstraint_0.Parent = v26.Parent;
                l_BallSocketConstraint_0.Attachment0 = l_Attachment_0;
                l_BallSocketConstraint_0.Attachment1 = l_Attachment_1;
                l_Attachment_0.CFrame = v26.C0;
                l_Attachment_1.CFrame = v26.C1;
                l_BallSocketConstraint_0.LimitsEnabled = true;
                l_BallSocketConstraint_0.TwistLimitsEnabled = true;
                v26.Enabled = false;
            end;
        end;
        local l_Humanoid_1 = l_v3_0:FindFirstChild("Humanoid");
        if l_Humanoid_1 then
            local v31 = "OriginalJumpInfo";
            local v32 = ("%*|%*"):format(l_Humanoid_1.JumpPower, l_Humanoid_1.JumpHeight);
            l_v3_0:SetAttribute(v31, v32);
            l_Humanoid_1.RequiresNeck = false;
            l_Humanoid_1.PlatformStand = true;
            l_Humanoid_1.JumpPower = 0;
            l_Humanoid_1.JumpHeight = 0;
        end;
        for _, v34 in pairs(l_v3_0:GetDescendants()) do
            if v34:IsA("BasePart") then
                if not v34:GetAttribute("OriginalCollision") then
                    v34:SetAttribute("OriginalCollision", v34.CanCollide);
                end;
                v34.CanCollide = false;
            end;
        end;
        local function v39(v35, v36) --[[ Line: 139 ]] --[[ Name: makeFakeLimb ]]
            -- upvalues: l_v3_0 (ref)
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Transparency = 1;
            l_Part_0.CFrame = v35.CFrame * CFrame.new(0, v36, 0);
            l_Part_0.Size = v35.Size - Vector3.new(0.05, 0.05 + v36, 0.05);
            l_Part_0.Name = "RagdollPart";
            l_Part_0.CollisionGroup = "Ragdolls";
            l_Part_0.Shape = Enum.PartType.Ball;
            l_Part_0.Parent = l_v3_0;
            local l_WeldConstraint_0 = Instance.new("WeldConstraint");
            l_WeldConstraint_0.Parent = l_Part_0;
            l_WeldConstraint_0.Part1 = l_Part_0;
            l_WeldConstraint_0.Part0 = v35;
        end;
        local v40 = {
            Head = true, 
            Torso = true, 
            ["Left Arm"] = true, 
            ["Left Leg"] = true, 
            ["Right Arm"] = true, 
            ["Right Leg"] = true
        };
        for _, v42 in pairs(l_v3_0:GetChildren()) do
            if v42:IsA("BasePart") and (v40[v42.Name] or v42.Transparency < 0.25 and v42.Name ~= "HumanoidRootPart" and v42.Name ~= "CollisionHitbox") then
                task.delay(0.125, function() --[[ Line: 167 ]]
                    -- upvalues: v42 (copy)
                    v42.CanCollide = false;
                end);
                if v42.Name == "Head" then
                    v39(v42, 0);
                else
                    v39(v42, -0.3);
                    v39(v42, 0.3);
                end;
            end;
        end;
        task.delay(0.25, function() --[[ Line: 181 ]]
            -- upvalues: l_v3_0 (ref)
            require(game.ReplicatedStorage.Modules.Sounds):Play("ragdolledLol", {
                Parent = l_v3_0.PrimaryPart
            });
        end);
        return l_v3_0;
    end;
end;
v0.Disable = function(_, v44) --[[ Line: 190 ]] --[[ Name: Disable ]]
    if v44:GetAttribute("CantRagdoll") then
        return;
    elseif not v44.Parent then
        return;
    elseif not v44:FindFirstChild("Humanoid") then
        return;
    else
        v44:SetAttribute("Ragdolling", nil);
        for _, v46 in pairs(v44:GetDescendants()) do
            if v46.Name == "TemporaryRagdollInstance" then
                v46:Destroy();
            elseif v46:IsA("Motor6D") then
                v46.Enabled = true;
            end;
        end;
        for _, v48 in pairs(v44:GetChildren()) do
            if v48.Name == "RagdollPart" then
                v48:Destroy();
            elseif v48:GetAttribute("OriginalCollision") then
                v48.CanCollide = v48:GetAttribute("OriginalCollision");
                v48:SetAttribute("OriginalCollision", nil);
            end;
        end;
        local l_v44_Attribute_0 = v44:GetAttribute("OriginalJumpInfo");
        if l_v44_Attribute_0 then
            l_v44_Attribute_0 = string.split(l_v44_Attribute_0, "|");
            v44.Humanoid.JumpPower = l_v44_Attribute_0[1];
            v44.Humanoid.JumpHeight = l_v44_Attribute_0[2];
        elseif tostring(v44.Parent) == "Spectating" then
            v44.Humanoid.JumpPower = game.StarterPlayer.CharacterJumpPower;
            v44.Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight;
        else
            v44.Humanoid.JumpPower = 0;
            v44.Humanoid.JumpHeight = 0;
        end;
        v44.Humanoid.PlatformStand = false;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 239 ]] --[[ Name: Start ]]
    -- upvalues: v1 (copy), v0 (copy)
    if game["Run Service"]:IsServer() then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "Ragdolls";
        l_Folder_0.Parent = workspace;
        local function v54(v52) --[[ Line: 248 ]] --[[ Name: addHumRagdoll ]]
            local l_Parent_0 = v52.Parent;
            if l_Parent_0 and l_Parent_0:IsA("Model") and l_Parent_0.PrimaryPart and v52:IsA("Humanoid") then
                v52.Died:Connect(function() --[[ Line: 252 ]]
                    -- upvalues: l_Parent_0 (copy)
                    game.Debris:AddItem(l_Parent_0, 30);
                end);
            end;
        end;
        workspace.DescendantAdded:Connect(v54);
        for _, v56 in pairs(workspace:GetDescendants()) do
            v54(v56);
        end;
        return;
    else
        if game["Run Service"]:IsClient() then
            v1:SetConnection("Ragdoll", "REMOTE_EVENT", function(v57, v58, v59, v60) --[[ Line: 267 ]]
                -- upvalues: v0 (ref)
                if v58 then
                    repeat
                        task.wait();
                    until workspace:GetServerTimeNow() >= (tonumber(v58) or 0);
                end;
                local v61 = v0:Enable(v57, true);
                if v61 and v61.PrimaryPart then
                    if v60 then
                        v61:SetPrimaryPartCFrame(v60);
                    end;
                    if v59 then
                        local l_RagdollSillies_1 = game.Players.LocalPlayer.PlayerData.Settings.Advanced.RagdollSillies;
                        v59 = string.split(v59, "|");
                        v61.PrimaryPart.Velocity = Vector3.new(v59[1], v59[2], v59[3]) * (l_RagdollSillies_1.Value and 10 or 1);
                    end;
                end;
            end);
            local function v66(v63) --[[ Line: 290 ]] --[[ Name: addHumRagdoll ]]
                -- upvalues: v0 (ref)
                local l_Parent_1 = v63.Parent;
                local v65 = l_Parent_1 and l_Parent_1:IsA("Model") and l_Parent_1.PrimaryPart;
                if v65 and v63:IsA("Humanoid") then
                    v63.Died:Connect(function() --[[ Line: 294 ]]
                        -- upvalues: v65 (copy), v0 (ref), l_Parent_1 (copy)
                        task.wait();
                        if not v65.Anchored then
                            v0:Enable(l_Parent_1, true);
                        end;
                    end);
                end;
            end;
            workspace.DescendantAdded:Connect(v66);
            for _, v68 in pairs(workspace:GetDescendants()) do
                v66(v68);
            end;
        end;
        return;
    end;
end;
return v0;