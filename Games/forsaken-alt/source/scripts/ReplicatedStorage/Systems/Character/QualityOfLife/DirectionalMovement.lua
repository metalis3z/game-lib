-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 9 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 10 ]]
        -- upvalues: v0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        if l_Character_0:GetAttribute("CustomRig") then
            return;
        else
            local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
            local l_HumanoidRootPart_0 = l_Character_0:WaitForChild("HumanoidRootPart");
            local l_Torso_0 = l_Character_0:WaitForChild("Torso");
            local l_Head_0 = l_Character_0:WaitForChild("Head");
            local l_RootJoint_0 = l_HumanoidRootPart_0:WaitForChild("RootJoint");
            local l_Neck_0 = l_Torso_0:WaitForChild("Neck");
            local v10 = l_Torso_0:WaitForChild("Right Shoulder");
            local v11 = l_Torso_0:WaitForChild("Left Shoulder");
            local v12 = l_Torso_0:WaitForChild("Right Hip");
            local v13 = l_Torso_0:WaitForChild("Left Hip");
            local l_C0_0 = l_RootJoint_0.C0;
            local l_C0_1 = l_Neck_0.C0;
            local l_C0_2 = v10.C0;
            local l_C0_3 = v11.C0;
            local l_C0_4 = v12.C0;
            local l_C0_5 = v13.C0;
            local v20 = CFrame.new();
            local v21 = CFrame.new();
            local v22 = CFrame.new();
            local v23 = CFrame.new();
            local v24 = CFrame.new();
            local v25 = CFrame.new();
            local v26 = CFrame.new();
            local v27 = 0;
            local v28 = false;
            local l_SpeedMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(l_LocalPlayer_0, 1, "DirectionalMovement");
            local v30 = {
                Forwards = 1, 
                ForwardsRight = 0.975, 
                Right = 0.925, 
                BackwardsRight = 0.8, 
                Backwards = 0.7, 
                BackwardsLeft = 0.8, 
                Left = 0.925, 
                ForwardsLeft = 0.975
            };
            local function v33() --[[ Line: 71 ]] --[[ Name: UpdateDirectionalMovement ]]
                -- upvalues: l_Humanoid_0 (copy), l_HumanoidRootPart_0 (copy), l_Character_0 (copy), v28 (ref), l_RootJoint_0 (copy), l_C0_0 (copy), l_Neck_0 (copy), l_C0_1 (copy), v10 (copy), l_C0_2 (copy), v11 (copy), l_C0_3 (copy), v12 (copy), l_C0_4 (copy), v13 (copy), l_C0_5 (copy), l_SpeedMultiplier_0 (copy), v27 (ref), v20 (ref), v21 (ref), v22 (ref), v23 (ref), v24 (ref), v25 (ref), v30 (copy)
                if l_Humanoid_0.WalkSpeed <= 0.1 or l_HumanoidRootPart_0.Anchored or l_Character_0:GetAttribute("DirectionalMovementDisabled") or l_Character_0:GetAttribute("Ragdolling") then
                    if v28 then
                        v28 = false;
                        l_RootJoint_0.C0 = l_C0_0;
                        l_Neck_0.C0 = l_C0_1;
                        v10.C0 = l_C0_2;
                        v11.C0 = l_C0_3;
                        v12.C0 = l_C0_4;
                        v13.C0 = l_C0_5;
                        l_SpeedMultiplier_0.Value = 1;
                    end;
                    return;
                else
                    v28 = true;
                    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                    if l_workspace_ServerTimeNow_0 - v27 >= 0.016666666666666666 then
                        v27 = l_workspace_ServerTimeNow_0;
                        local v32 = l_HumanoidRootPart_0.CFrame:VectorToObjectSpace(l_Humanoid_0.MoveDirection);
                        if v32:Dot(Vector3.new(1, 0, -1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 5, 0, math.rad(-v32.X) * 15), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 5, 0, math.rad(v32.X) * 15), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.ForwardsRight;
                            return;
                        elseif v32:Dot(Vector3.new(1, 0, 1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 5, 0, math.rad(v32.X) * 15), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 5, 0, math.rad(-v32.X) * 15), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(v32.X) * 25, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(v32.X) * 25, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.BackwardsRight;
                            return;
                        elseif v32:Dot(Vector3.new(-1, 0, 1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 5, 0, math.rad(v32.X) * 15), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 5, 0, math.rad(-v32.X) * 15), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(v32.X) * 25, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(v32.X) * 25, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.BackwardsLeft;
                            return;
                        elseif v32:Dot(Vector3.new(-1, 0, -1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 5, 0, math.rad(-v32.X) * 15), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 5, 0, math.rad(v32.X) * 15), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 10, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.ForwardsLeft;
                            return;
                        elseif v32:Dot(Vector3.new(0, 0, -1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 0, 0, 0), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 0, 0, 0), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.Forwards;
                            return;
                        elseif v32:Dot(Vector3.new(1, 0, 0, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(0, 0, math.rad(-v32.X) * 35), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(0, 0, math.rad(v32.X) * 35), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 15, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 15, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 30, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.Right;
                            return;
                        elseif v32:Dot(Vector3.new(0, 0, 1, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(math.rad(-v32.Z) * 15, 0, 0), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(math.rad(v32.Z) * 15, 0, 0), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.Backwards;
                            return;
                        elseif v32:Dot(Vector3.new(-1, 0, 0, 0).Unit) > 0.95 then
                            v20 = v20:Lerp(CFrame.Angles(0, 0, math.rad(-v32.X) * 35), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(0, 0, math.rad(v32.X) * 35), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, math.rad(v32.X) * 15, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, math.rad(v32.X) * 15, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 30, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, math.rad(-v32.X) * 25, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = v30.Left;
                            return;
                        elseif v32 == Vector3.new(0, 0, 0, 0) then
                            v20 = v20:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            l_RootJoint_0.C0 = l_C0_0 * v20;
                            v21 = v21:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v22 = v22:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v10.C0 = l_C0_2 * v22;
                            v23 = v23:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v11.C0 = l_C0_3 * v23;
                            v24 = v24:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v12.C0 = l_C0_4 * v24;
                            v25 = v25:Lerp(CFrame.Angles(0, 0, 0), 0.25);
                            v13.C0 = l_C0_5 * v25;
                            l_SpeedMultiplier_0.Value = 1;
                        end;
                    end;
                    return;
                end;
            end;
            local function v42() --[[ Line: 288 ]] --[[ Name: UpdateNeckDirection ]]
                -- upvalues: v28 (ref), l_Torso_0 (copy), l_Head_0 (copy), v26 (ref), l_Neck_0 (copy), l_C0_1 (copy)
                if v28 then
                    local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
                    local l_lookVector_0 = l_Torso_0.CFrame.lookVector;
                    local l_p_0 = l_Head_0.CFrame.p;
                    local v37 = l_p_0 + l_LookVector_0 * 10;
                    local l_magnitude_0 = (l_Head_0.CFrame.p - v37).magnitude;
                    local v39 = l_Head_0.CFrame.Y - v37.Y;
                    local v40 = (l_p_0 - v37).Unit:Cross(l_lookVector_0).Y * -1;
                    local v41 = math.atan(v39 / l_magnitude_0) * 0.5;
                    v26 = v26:Lerp(CFrame.Angles(v41, 0, -v40), 0.05);
                    l_Neck_0.C0 = l_C0_1 * v26;
                end;
            end;
            v0.Connection = game["Run Service"].RenderStepped:Connect(function(_) --[[ Line: 308 ]]
                -- upvalues: v33 (copy), v42 (copy)
                v33();
                v42();
            end);
            return;
        end;
    end);
end;
v0.Destroy = function(_) --[[ Line: 315 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.Connection then
        v0.Connection:Disconnect();
        v0.Connection = nil;
    end;
end;
return v0;