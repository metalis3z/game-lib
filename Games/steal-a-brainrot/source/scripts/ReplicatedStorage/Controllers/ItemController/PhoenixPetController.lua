-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local _ = game:GetService("Lighting");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = workspace.CurrentCamera;
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local _ = require(l_Controllers_0.CharacterController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v10 = require(l_Packages_0.Net):RemoteEvent("UseItem");
local v11 = {};
local v12 = {};
local function _(v13, v14) --[[ Line: 25 ]] --[[ Name: smoothAlpha ]]
    return 1 - math.exp(-math.clamp(v14, 0, 60) * v13);
end;
local function v42(v16) --[[ Line: 29 ]] --[[ Name: StartOrbitFor ]]
    -- upvalues: v11 (copy), l_Players_0 (copy), l_RunService_0 (copy), l_LocalPlayer_0 (copy)
    if v11[v16] then
        return;
    elseif not v16 or not v16.Parent then
        return;
    else
        local l_v16_Attribute_0 = v16:GetAttribute("OwnerUserId");
        local v18 = v16:GetAttribute("StartTime") or workspace:GetServerTimeNow();
        if not l_v16_Attribute_0 then
            return;
        else
            local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(l_v16_Attribute_0);
            if not l_l_Players_0_PlayerByUserId_0 or not l_l_Players_0_PlayerByUserId_0.Character then
                return;
            else
                local l_HumanoidRootPart_0 = l_l_Players_0_PlayerByUserId_0.Character:FindFirstChild("HumanoidRootPart");
                if not l_HumanoidRootPart_0 then
                    return;
                else
                    local l_v16_Pivot_0 = v16:GetPivot();
                    v11[v16] = l_RunService_0.RenderStepped:Connect(function(v22) --[[ Line: 54 ]]
                        -- upvalues: v16 (copy), v11 (ref), l_HumanoidRootPart_0 (ref), l_l_Players_0_PlayerByUserId_0 (copy), v18 (copy), l_v16_Pivot_0 (ref), l_Players_0 (ref), l_LocalPlayer_0 (ref)
                        if not v16.Parent then
                            v11[v16]:Disconnect();
                            v11[v16] = nil;
                            return;
                        else
                            l_HumanoidRootPart_0 = l_l_Players_0_PlayerByUserId_0.Character and l_l_Players_0_PlayerByUserId_0.Character:FindFirstChild("HumanoidRootPart") or l_HumanoidRootPart_0;
                            if not l_HumanoidRootPart_0 then
                                return;
                            else
                                local v23 = 0 + 1.0471975511965976 * (workspace:GetServerTimeNow() - v18);
                                local v24 = math.cos(v23) * 6;
                                local v25 = math.sin(v23) * 6;
                                local l_Position_0 = (l_HumanoidRootPart_0.CFrame * CFrame.new(v24, 4, v25)).Position;
                                local v27 = l_HumanoidRootPart_0.Position + Vector3.new(0, 4, 0, 0);
                                local v28 = CFrame.lookAt(l_Position_0, v27);
                                local v29 = 1 - math.exp(-14 * v22);
                                local v30 = 1 - math.exp(-18 * v22);
                                l_v16_Pivot_0 = l_v16_Pivot_0:Lerp(CFrame.new(v28.Position) * CFrame.fromMatrix(Vector3.new(0, 0, 0, 0), v28.RightVector, v28.UpVector), v29);
                                l_v16_Pivot_0 = l_v16_Pivot_0:Lerp(v28, v30);
                                v16:PivotTo(l_v16_Pivot_0);
                                local l_Position_1 = v16:GetPivot().Position;
                                local v32 = nil;
                                local v33 = nil;
                                local v34 = 1e999;
                                for _, v36 in l_Players_0:GetPlayers() do
                                    if v36 ~= l_LocalPlayer_0 and v36.Character then
                                        local l_HumanoidRootPart_1 = v36.Character:FindFirstChild("HumanoidRootPart");
                                        local l_Humanoid_0 = v36.Character:FindFirstChildOfClass("Humanoid");
                                        if l_HumanoidRootPart_1 and l_Humanoid_0 and l_Humanoid_0.Health > 0 then
                                            local l_Magnitude_0 = (l_HumanoidRootPart_1.Position - l_Position_1).Magnitude;
                                            if l_Magnitude_0 <= 25 and l_Magnitude_0 < v34 then
                                                v34 = l_Magnitude_0;
                                                v32 = l_HumanoidRootPart_1;
                                                v33 = l_Humanoid_0;
                                            end;
                                        end;
                                    end;
                                end;
                                if v32 then
                                    local v40 = Vector3.new(v32.Position.X, l_Position_1.Y, v32.Position.Z);
                                    local v41 = CFrame.lookAt(l_Position_1, v40);
                                    v16:PivotTo(v41);
                                end;
                                return;
                            end;
                        end;
                    end);
                    return;
                end;
            end;
        end;
    end;
end;
v10.OnClientEvent:Connect(function(v43, v44) --[[ Line: 103 ]]
    -- upvalues: v42 (copy)
    if v43 ~= "SpawnPhoenix" then
        return;
    else
        v42(v44);
        return;
    end;
end);
task.spawn(function() --[[ Line: 110 ]]
    -- upvalues: v42 (copy)
    for _, v46 in workspace:GetChildren() do
        if v46:IsA("Model") and v46:GetAttribute("OwnerUserId") and v46:GetAttribute("IsPhoenix") then
            v42(v46);
        end;
    end;
end);
return v12;