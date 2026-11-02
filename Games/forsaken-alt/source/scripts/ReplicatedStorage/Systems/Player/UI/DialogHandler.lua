-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    INTERACTION_DISTANCE = 16, 
    DEFAULT_IDLE_IDS = {
        R6 = "rbxassetid://180435571", 
        R15 = "rbxassetid://507766388"
    }
};
local v1 = {};
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.RichText);
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local function v11(v7, v8) --[[ Line: 28 ]] --[[ Name: LoadAnimationFromID ]]
    if not v7 then
        warn("no rig found while loading animation from ID!");
        return;
    elseif not v8 then
        warn("no ID found while loading animation onto rig!");
        return;
    else
        local l_v7_FirstChild_0 = v7:FindFirstChild(v8);
        if l_v7_FirstChild_0 then
            return v7.Humanoid:LoadAnimation(l_v7_FirstChild_0);
        else
            local l_Animation_0 = Instance.new("Animation");
            l_Animation_0.Name = v8;
            l_Animation_0.AnimationId = v8;
            l_Animation_0.Parent = v7;
            return (v7.Humanoid:LoadAnimation(l_Animation_0));
        end;
    end;
end;
v1.new = function(v12) --[[ Line: 44 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), l_LocalPlayer_0 (copy), l_TweenService_0 (copy), v1 (copy), v11 (copy), v3 (copy), v2 (copy), l_Debris_0 (copy)
    local v13 = {};
    local l_Parent_0 = v12.Parent;
    local l_Humanoid_0 = l_Parent_0:FindFirstChild("Humanoid");
    local v16 = require(v12);
    local v17 = v16.Config or {};
    if l_Humanoid_0 then
        if not v17.Poses then
            v17.Poses = {};
        end;
        if not v17.Poses.Idle then
            v17.Poses.Idle = v0.DEFAULT_IDLE_IDS[l_Parent_0.Humanoid.RigType.Name] or v0.DEFAULT_IDLE_IDS.R6;
        end;
        if not v17.Actions then
            v17.Actions = {};
        end;
    end;
    local l_Sidebar_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI"):FindFirstChild("Sidebar");
    if l_Sidebar_0 then
        l_TweenService_0:Create(l_Sidebar_0, TweenInfo.new(0.4), {
            Position = UDim2.fromScale(-0.2, 0.5)
        }):Play();
    end;
    local v19 = script.DialogMain:Clone();
    v19.Background.Size = UDim2.fromScale(0, 1);
    v19.Background.BackgroundTransparency = 1;
    v19.NameFrame.Back.ImageTransparency = 1;
    v19.NameFrame.Front.ImageTransparency = 1;
    v19.NameFrame.Label.TextTransparency = 1;
    v19.Dialog.Text = "";
    v19.Parent = v1.UI;
    v19.Dialog.TextSize = v19.Dialog.AbsoluteSize.Y / 6;
    v19.NameFrame.Label.TextSize = v19.NameFrame.AbsoluteSize.Y / 1.5;
    v19.NameFrame.Label.Text = l_Parent_0.Name;
    while not v19.NameFrame.Label.TextFits and v19.NameFrame.Size.X.Scale < 0.6 do
        local l_NameFrame_0 = v19.NameFrame;
        l_NameFrame_0.Size = l_NameFrame_0.Size + UDim2.fromScale(0.05, 0);
    end;
    if not v19.NameFrame.Label.TextFits then
        v19.NameFrame.Label.TextScaled = true;
    end;
    v1.Character.Archivable = true;
    for _, v22 in pairs(v19.Viewports:GetChildren()) do
        task.delay(v22.Name == "Player" and 0.25 or 0, function() --[[ Line: 90 ]]
            -- upvalues: v22 (copy), v1 (ref), l_Parent_0 (copy)
            v22.ImageTransparency = 1;
            v22.ImageColor3 = Color3.new(0.2, 0.2, 0.2);
            local l_WorldModel_0 = Instance.new("WorldModel");
            l_WorldModel_0.Parent = v22;
            local v24 = v22.Name == "Player" and v1.Character:Clone() or l_Parent_0:Clone();
            v24:SetPrimaryPartCFrame(CFrame.new());
            v24.Name = "Rig";
            v24.Parent = l_WorldModel_0;
            local l_v24_BoundingBox_0, v26 = v24:GetBoundingBox();
            local l_Camera_0 = Instance.new("Camera");
            l_Camera_0.Parent = v22;
            l_Camera_0.FieldOfView = 30;
            l_Camera_0.CFrame = l_v24_BoundingBox_0 * CFrame.Angles(0, math.rad(180 + (v22.Name == "NPC" and -10 or 10)), 0) * CFrame.new(0, math.clamp(v26.magnitude / 8, 1, 20) * 1.25, math.clamp(v26.magnitude / 8, 1, 20) * 10) * CFrame.Angles(-0.1308996938995747, 0, 0) * CFrame.new(v22.Name == "NPC" and 0.25 or -0.25, 0.75, 0);
            v22.CurrentCamera = l_Camera_0;
        end);
    end;
    l_TweenService_0:Create(v19.Background, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
        Size = UDim2.fromScale(1.95, 1), 
        BackgroundTransparency = 0
    }):Play();
    l_TweenService_0:Create(v19.ContinueButton.ContinueNotice, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        ImageTransparency = 0.5
    }):Play();
    local v28 = task.delay(0.2, function() --[[ Line: 112 ]]
        -- upvalues: l_TweenService_0 (ref), v19 (copy)
        l_TweenService_0:Create(v19.NameFrame.Back, TweenInfo.new(0.5), {
            ImageTransparency = 0
        }):Play();
        l_TweenService_0:Create(v19.NameFrame.Front, TweenInfo.new(0.5), {
            ImageTransparency = 0
        }):Play();
        l_TweenService_0:Create(v19.NameFrame.Label, TweenInfo.new(0.5), {
            TextTransparency = 0
        }):Play();
    end);
    local l_Humanoid_1 = v1.Humanoid;
    local l_SpeedMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(l_LocalPlayer_0, 0, "DialogMultiplier");
    v13.Connections = {
        l_Humanoid_1.Died:Connect(function() --[[ Line: 125 ]]
            -- upvalues: v13 (copy)
            v13:Cleanup();
        end), 
        l_Humanoid_1:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 129 ]]
            -- upvalues: v13 (copy)
            v13:Cleanup();
        end)
    };
    v13.CreateDialog = function(_, v32) --[[ Line: 135 ]] --[[ Name: CreateDialog ]]
        -- upvalues: v19 (copy), l_TweenService_0 (ref), l_Humanoid_0 (copy), v13 (copy), v17 (copy), v11 (ref), v3 (ref), v2 (ref)
        if not v19.Parent then
            return;
        else
            v32.Text = v32.Text or "Uhhhhhhh";
            v32.Pose = v32.Pose or "Idle";
            v19.ContinueButton.Interactable = true;
            l_TweenService_0:Create(v19.Viewports.NPC, TweenInfo.new(0.3), {
                ImageTransparency = 0, 
                ImageColor3 = Color3.new(1, 1, 1)
            }):Play();
            if l_Humanoid_0 then
                for _, v34 in pairs({
                    "Action", 
                    "Pose"
                }) do
                    if not v13[("Current%*"):format(v34)] then
                        v13[("Current%*"):format(v34)] = {};
                    end;
                    if v13[("Current%*"):format(v34)].Name ~= v32[v34] then
                        local v35 = v17[("%*s"):format(v34)][v32[v34]];
                        if v35 then
                            if v13[("Current%*"):format(v34)].Track then
                                v13[("Current%*"):format(v34)].Track:Stop(0);
                            end;
                            v13[("Current%*"):format(v34)] = {};
                            v13[("Current%*"):format(v34)].Name = v32.Pose;
                            v13[("Current%*"):format(v34)].Track = v11(v19.Viewports.NPC:WaitForChild("WorldModel"):WaitForChild("Rig"), v35);
                            v13[("Current%*"):format(v34)].Track:Play(0);
                            v13[("Current%*"):format(v34)].Track.Looped = v34 == "Pose";
                            v13[("Current%*"):format(v34)].Track.Priority = Enum.AnimationPriority[v34 == "Pose" and "Idle" or "Action"];
                        end;
                    end;
                end;
            end;
            v13.CurrentTextObject = v3:New(v19.Dialog, v32.Text, {
                Font = v19.Dialog.Font
            });
            local v36 = v19.ContinueButton.MouseButton1Click:Connect(function() --[[ Line: 196 ]]
                -- upvalues: v13 (ref), v2 (ref)
                if not v13.CurrentTextObject.TextFinished then
                    v2:Play("dialogSkip");
                    v13.CurrentTextObject.TextFinished = true;
                    v13.CurrentTextObject:Show();
                    return;
                else
                    v2:Play("dialogSkip");
                    v13.CurrentTextObject.FinishedReading = true;
                    return;
                end;
            end);
            v13.CurrentTextObject:Animate(true, v17.VoiceSFX or v32.VoiceSFX or "dialogDefaultVoice");
            v13.CurrentTextObject.TextFinished = true;
            v19.ContinueButton.ContinueNotice.Visible = true;
            repeat
                task.wait();
            until v13.CurrentTextObject.FinishedReading or not v19.Parent;
            if v13.Destroyed or not v19.Parent then
                return;
            else
                v36:Disconnect();
                v36 = nil;
                v19.ContinueButton.ContinueNotice.Visible = false;
                v19.ContinueButton.Interactable = false;
                return;
            end;
        end;
    end;
    v13.GetUserResponse = function(_, v38) --[[ Line: 222 ]] --[[ Name: GetUserResponse ]]
        -- upvalues: v19 (copy), v1 (ref), l_TweenService_0 (ref), v2 (ref), v13 (copy), l_Debris_0 (ref)
        if not v19.Parent then
            return;
        else
            local v39 = game.HttpService:JSONEncode(v38);
            if not v1.NPCData[v39] then
                v1.NPCData[v39] = {
                    ResponsesChosen = {}
                };
            end;
            local v40 = nil;
            local v41 = {};
            for v42, v43 in v38 do
                if v43.ViewRequirement then
                    if typeof(v43.ViewRequirement) == "string" then
                        local v44 = v43.ViewRequirement:split(" ");
                        local v45 = v44[1];
                        local v46 = v44[2];
                        if v45 == "After" then
                            if not v1.NPCData[v39].ResponsesChosen[v46] then
                                continue;
                            end;
                        elseif v45 == "NoChoicesAvailable" then
                            local v47 = 0;
                            for _, _ in pairs(v41) do
                                v47 = v47 + 1;
                            end;
                            if v47 ~= 0 then
                                continue;
                            end;
                        end;
                    elseif typeof(v43.ViewRequirement) == "function" and not v43.ViewRequirement() then
                        continue;
                    end;
                end;
                if not v43.HideWhenChosen or not v1.NPCData[v39].ResponsesChosen[("Choice%*"):format(v42)] then
                    v41[v42] = v43;
                end;
            end;
            l_TweenService_0:Create(v19.Viewports.Player, TweenInfo.new(0.3), {
                ImageTransparency = 0, 
                ImageColor3 = Color3.new(1, 1, 1)
            }):Play();
            local v50 = script.UserResponseMain:Clone();
            v50.Background.Size = UDim2.fromScale(0, 0);
            v50.Parent = v1.UI;
            local v51 = {};
            for v52, v53 in pairs(v41) do
                local v54 = script.ResponseTemplate:Clone();
                v54.Name = v52;
                v54.Text = v53.Choice;
                v54.Parent = v50.Responses;
                v54.TextSize = v54.AbsoluteSize.Y;
                v54.TextTransparency = 1;
                table.insert(v51, v54);
                task.delay((#v51 - 1) * 0.15, function() --[[ Line: 294 ]]
                    -- upvalues: l_TweenService_0 (ref), v54 (copy)
                    l_TweenService_0:Create(v54, TweenInfo.new(0.2), {
                        TextTransparency = 0
                    }):Play();
                end);
                while not v54.TextFits do
                    v54.Size = v54.Size + UDim2.fromOffset(0, v54.TextSize);
                end;
                v54.MouseEnter:Connect(function() --[[ Line: 304 ]]
                    -- upvalues: v40 (ref), v2 (ref)
                    if not v40 then
                        v2:Play("hover");
                    end;
                end);
                v54.MouseButton1Click:Connect(function() --[[ Line: 311 ]]
                    -- upvalues: v40 (ref), v1 (ref), v39 (copy), v52 (copy), v2 (ref)
                    if not v40 then
                        v1.NPCData[v39].ResponsesChosen[("Choice%*"):format(v52)] = true;
                        v40 = v52;
                        v2:Play("click");
                    end;
                end);
            end;
            local v55 = {};
            for v56, v57 in pairs(v51) do
                v57.LayoutOrder = v56 * 5;
                if v56 ~= #v51 then
                    local l_Frame_0 = Instance.new("Frame");
                    l_Frame_0.Name = "Divider";
                    l_Frame_0.Size = UDim2.new(0, 0, 0, 2);
                    l_Frame_0.BackgroundColor3 = Color3.new(1, 1, 1);
                    l_Frame_0.BackgroundTransparency = 1;
                    l_Frame_0.BorderSizePixel = 0;
                    l_Frame_0.LayoutOrder = v57.LayoutOrder + 1;
                    l_Frame_0.Parent = v50.Responses;
                    table.insert(v55, l_Frame_0);
                    v50.Background.UIGradient:Clone().Parent = l_Frame_0;
                    task.delay((v56 - 1) * 0.15, function() --[[ Line: 342 ]]
                        -- upvalues: l_TweenService_0 (ref), l_Frame_0 (copy)
                        l_TweenService_0:Create(l_Frame_0, TweenInfo.new(0.5), {
                            BackgroundTransparency = 0, 
                            Size = UDim2.new(1, 0, 0, 2)
                        }):Play();
                    end);
                end;
            end;
            v50.Background.Size = UDim2.new(0, 0, 0.1, v50.Responses.UIListLayout.AbsoluteContentSize.Y);
            l_TweenService_0:Create(v50.Background, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
                Size = UDim2.new(1.95, 0, v50.Background.Size.Y.Scale, v50.Background.Size.Y.Offset), 
                BackgroundTransparency = 0
            }):Play();
            repeat
                task.wait();
            until v40 or not v19.Parent;
            if v13.Destroyed or not v19.Parent then
                return;
            else
                l_Debris_0:AddItem(v50, 0.5);
                l_TweenService_0:Create(v50.Background, TweenInfo.new(0.5), {
                    Size = UDim2.new(0, 0, v50.Background.Size.Y.Scale, v50.Background.Size.Y.Offset), 
                    BackgroundTransparency = 1
                }):Play();
                l_TweenService_0:Create(v19.Viewports.Player, TweenInfo.new(0.3), {
                    ImageTransparency = 1, 
                    ImageColor3 = Color3.new(0.2, 0.2, 0.2)
                }):Play();
                for _, v60 in pairs(v51) do
                    v60.Interactable = false;
                    l_TweenService_0:Create(v60, TweenInfo.new(0.225), {
                        TextTransparency = 1
                    }):Play();
                end;
                for _, v62 in pairs(v55) do
                    l_TweenService_0:Create(v62, TweenInfo.new(0.225), {
                        BackgroundTransparency = 1, 
                        Size = UDim2.new(0, 0, 0, 2)
                    }):Play();
                end;
                return v40;
            end;
        end;
    end;
    v13.ProcessResponse = function(_, v64, v65) --[[ Line: 372 ]] --[[ Name: ProcessResponse ]]
        -- upvalues: l_Parent_0 (copy)
        local v66 = v65[v64];
        if v66 then
            v66();
            return;
        else
            warn((("ResponseToChoice%* not found in %* dialog module! did you misspell something or forget to include a response?"):format(v64, (l_Parent_0:GetFullName()))));
            return;
        end;
    end;
    v13.ToggleInteractibility = function(_, v68) --[[ Line: 381 ]] --[[ Name: ToggleInteractibility ]]
        -- upvalues: l_Parent_0 (copy)
        l_Parent_0:SetAttribute("Noninteractive", not v68);
    end;
    v13.Cleanup = function(_) --[[ Line: 385 ]] --[[ Name: Cleanup ]]
        -- upvalues: v13 (copy), l_Debris_0 (ref), v19 (copy), l_TweenService_0 (ref), v28 (copy), v1 (ref), l_Sidebar_0 (copy), l_SpeedMultiplier_0 (copy)
        if not v13.Destroyed then
            v13.Destroyed = true;
            l_Debris_0:AddItem(v19, 1);
            l_TweenService_0:Create(v19.Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
                Size = UDim2.fromScale(0, 1), 
                BackgroundTransparency = 1
            }):Play();
            l_TweenService_0:Create(v19.NameFrame.Back, TweenInfo.new(0.3), {
                ImageTransparency = 1
            }):Play();
            l_TweenService_0:Create(v19.NameFrame.Front, TweenInfo.new(0.3), {
                ImageTransparency = 1
            }):Play();
            l_TweenService_0:Create(v19.NameFrame.Label, TweenInfo.new(0.3), {
                TextTransparency = 1
            }):Play();
            if v28 then
                task.cancel(v28);
            end;
            for _, v71 in pairs(v19.Viewports:GetChildren()) do
                l_TweenService_0:Create(v71, TweenInfo.new(0.3), {
                    ImageTransparency = 1, 
                    ImageColor3 = Color3.new(0.2, 0.2, 0.2)
                }):Play();
            end;
            local l_UserResponseMain_0 = v1.UI:FindFirstChild("UserResponseMain");
            while l_UserResponseMain_0 do
                l_Debris_0:AddItem(l_UserResponseMain_0, 0.5);
                l_TweenService_0:Create(l_UserResponseMain_0.Background, TweenInfo.new(0.5), {
                    Size = UDim2.new(0, 0, l_UserResponseMain_0.Background.Size.Y.Scale, l_UserResponseMain_0.Background.Size.Y.Offset), 
                    BackgroundTransparency = 1
                }):Play();
                l_TweenService_0:Create(v19.Viewports.Player, TweenInfo.new(0.3), {
                    ImageTransparency = 1, 
                    ImageColor3 = Color3.new(0.2, 0.2, 0.2)
                }):Play();
                for _, v74 in pairs(l_UserResponseMain_0.Responses:GetChildren()) do
                    if v74:IsA("TextButton") then
                        v74.Interactable = false;
                        l_TweenService_0:Create(v74, TweenInfo.new(0.225), {
                            TextTransparency = 1
                        }):Play();
                    elseif v74:IsA("Frame") then
                        l_TweenService_0:Create(v74, TweenInfo.new(0.225), {
                            BackgroundTransparency = 1, 
                            Size = UDim2.new(0, 0, 0, 2)
                        }):Play();
                    end;
                end;
                l_UserResponseMain_0.Name = "clearing...";
                l_UserResponseMain_0 = v1.UI:FindFirstChild("UserResponseMain");
            end;
            if v13.CurrentTextObject then
                v13.CurrentTextObject:Hide();
            end;
            if v13.Connections then
                for _, v76 in pairs(v13.Connections) do
                    v76:Disconnect();
                    v76 = nil;
                end;
            end;
            if l_Sidebar_0 then
                l_TweenService_0:Create(l_Sidebar_0, TweenInfo.new(0.25), {
                    Position = UDim2.fromScale(0, 0.5)
                }):Play();
            end;
            l_SpeedMultiplier_0:Destroy();
        end;
    end;
    v16.Interacted(v13);
    v13:Cleanup();
end;
v1.TogglePrompts = function(v77, v78) --[[ Line: 442 ]] --[[ Name: TogglePrompts ]]
    for _, v80 in pairs(v77.ProximityPrompts) do
        v80.Enabled = v78;
    end;
end;
v1.ProcessDialogModule = function(v81, v82) --[[ Line: 449 ]] --[[ Name: ProcessDialogModule ]]
    -- upvalues: v0 (copy), v11 (copy), v2 (copy), l_LocalPlayer_0 (copy), l_TweenService_0 (copy), v1 (copy)
    local l_Parent_1 = v82.Parent;
    if v82:IsA("ModuleScript") and v82.Name == "Dialog" and l_Parent_1:IsA("Model") and l_Parent_1.PrimaryPart then
        local v84 = require(v82).Config or {};
        local l_Humanoid_2 = l_Parent_1:FindFirstChild("Humanoid");
        if v84.PlayIdleOutsideOfDialog and l_Humanoid_2 then
            local v86 = v84.Poses and v84.Poses.Idle or v0.DEFAULT_IDLE_IDS[l_Humanoid_2.RigType.Name] or v0.DEFAULT_IDLE_IDS.R6;
            local v87 = v11(l_Parent_1, v86);
            v87:Play(0);
            v87.Looped = true;
            v87.Priority = Enum.AnimationPriority.Idle;
        end;
        local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
        l_ProximityPrompt_0.RequiresLineOfSight = false;
        l_ProximityPrompt_0.Style = Enum.ProximityPromptStyle.Custom;
        l_ProximityPrompt_0.Parent = l_Parent_1.PrimaryPart;
        l_ProximityPrompt_0:SetAttribute("Theme", "Dialog");
        table.insert(v81.ProximityPrompts, l_ProximityPrompt_0);
        local l_CFrame_0 = l_Parent_1.PrimaryPart.CFrame;
        local v90 = 0;
        do
            local l_v90_0 = v90;
            l_ProximityPrompt_0.PromptShown:Connect(function() --[[ Line: 476 ]]
                -- upvalues: v2 (ref), l_Parent_1 (copy), v84 (copy), l_v90_0 (ref), l_LocalPlayer_0 (ref), l_ProximityPrompt_0 (copy), l_CFrame_0 (copy), l_TweenService_0 (ref)
                v2:Play("dialogPromptAppear", {
                    Parent = l_Parent_1.PrimaryPart
                });
                if v84.FacePlayer ~= false then
                    local l_l_v90_0_0 = l_v90_0;
                    while task.wait() and l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.PrimaryPart and l_Parent_1.PrimaryPart.Anchored and (l_v90_0 == l_l_v90_0_0 or not l_ProximityPrompt_0.Enabled) do
                        local v93 = CFrame.lookAt(l_Parent_1.PrimaryPart.Position, (Vector3.new(l_LocalPlayer_0.Character.PrimaryPart.Position.X, l_Parent_1.PrimaryPart.Position.Y, l_LocalPlayer_0.Character.PrimaryPart.Position.Z)));
                        if v93 ~= v93 then
                            v93 = l_CFrame_0;
                        end;
                        l_TweenService_0:Create(l_Parent_1.PrimaryPart, TweenInfo.new(0.1), {
                            CFrame = v93
                        }):Play();
                    end;
                    l_TweenService_0:Create(l_Parent_1.PrimaryPart, TweenInfo.new(0.3), {
                        CFrame = l_CFrame_0
                    }):Play();
                end;
            end);
            l_ProximityPrompt_0.PromptHidden:Connect(function() --[[ Line: 489 ]]
                -- upvalues: l_v90_0 (ref)
                l_v90_0 = l_v90_0 + 1;
            end);
            l_ProximityPrompt_0.Triggered:Connect(function() --[[ Line: 493 ]]
                -- upvalues: v81 (copy), l_Parent_1 (copy), v1 (ref), v82 (copy)
                if v81.Humanoid and v81.Humanoid.Health > 0 and not l_Parent_1:GetAttribute("Noninteractive") then
                    v1:TogglePrompts(false);
                    v1.new(v82);
                    v1:TogglePrompts(true);
                end;
            end);
        end;
    end;
end;
v1.Start = function(v94) --[[ Line: 506 ]] --[[ Name: Start ]]
    -- upvalues: l_LocalPlayer_0 (copy), v1 (copy)
    v94.Character = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    v94.Humanoid = v94.Character:WaitForChild("Humanoid");
    v94.UI = Instance.new("ScreenGui");
    v94.UI.Name = "Dialog";
    v94.UI.IgnoreGuiInset = true;
    v94.UI.ResetOnSpawn = false;
    v94.UI.Parent = l_LocalPlayer_0.PlayerGui;
    v94.ProximityPrompts = {};
    v94.NPCData = {};
    l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 521 ]]
        -- upvalues: v94 (copy), l_LocalPlayer_0 (ref)
        v94.Character = l_LocalPlayer_0.Character;
        v94.Humanoid = v94.Character:WaitForChild("Humanoid");
        v94.UI:ClearAllChildren();
    end);
    for _, v96 in pairs(workspace:GetDescendants()) do
        v1:ProcessDialogModule(v96);
    end;
    workspace.DescendantAdded:Connect(function(v97) --[[ Line: 531 ]]
        -- upvalues: v1 (ref)
        v1:ProcessDialogModule(v97);
    end);
end;
return v1;