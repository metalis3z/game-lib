-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    AudioConnection = nil, 
    Updated = function(v0, v1) --[[ Line: 5 ]] --[[ Name: Updated ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        if v1 then
            local l_ScreenGui_0 = Instance.new("ScreenGui");
            l_ScreenGui_0.Name = "IndicatorGui";
            l_ScreenGui_0.IgnoreGuiInset = true;
            l_ScreenGui_0.ResetOnSpawn = false;
            l_ScreenGui_0.DisplayOrder = 499;
            l_ScreenGui_0.Parent = l_LocalPlayer_0:WaitForChild("PlayerGui");
            v0.AudioUI = l_ScreenGui_0;
            local v4 = {};
            v0.AudioConnections = {
                workspace.DescendantAdded:Connect(function(v5) --[[ Line: 24 ]]
                    -- upvalues: l_LocalPlayer_0 (copy), l_ScreenGui_0 (copy), v4 (copy)
                    local l_Parent_0 = v5.Parent;
                    if v5:IsA("Sound") and not v5:IsDescendantOf(l_LocalPlayer_0.Character or game.Players) and l_Parent_0 and l_Parent_0:IsA("BasePart") then
                        local l_Attachment_0 = Instance.new("Attachment");
                        l_Attachment_0.Name = "Indicator";
                        l_Attachment_0.Parent = l_Parent_0;
                        local v8 = script.Indicator:Clone();
                        v8.Parent = l_ScreenGui_0;
                        local v9 = {
                            [1] = l_Parent_0, 
                            [2] = v8, 
                            [3] = v5
                        };
                        table.insert(v4, v9);
                        game.TweenService:Create(v8, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0
                        }):Play();
                        game.TweenService:Create(v8.IconImage, TweenInfo.new(0.2), {
                            ImageTransparency = 0
                        }):Play();
                        game.TweenService:Create(v8.ArrowFrame.ArrowImage, TweenInfo.new(0.2), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                end), 
                game["Run Service"].RenderStepped:Connect(function(_) --[[ Line: 47 ]]
                    -- upvalues: v4 (copy)
                    local l_CurrentCamera_0 = workspace.CurrentCamera;
                    local l_X_0 = l_CurrentCamera_0.ViewportSize.X;
                    local l_Y_0 = l_CurrentCamera_0.ViewportSize.Y;
                    if not v4[1] then
                        return;
                    else
                        local l_X_1 = v4[1][2].AbsoluteSize.X;
                        local v15 = l_X_0 - l_X_1 * 2;
                        local v16 = l_Y_0 - l_X_1 * 2;
                        local l_CFrame_0 = l_CurrentCamera_0.CFrame;
                        local v18 = math.sqrt((v15 / 2) ^ 2 + (v16 / 2) ^ 2);
                        local v19 = nil;
                        local l_LookVector_0 = l_CurrentCamera_0.CFrame.LookVector;
                        v19 = Vector2.new(l_LookVector_0.X, l_LookVector_0.Z).Unit;
                        for v21 = #v4, 1, -1 do
                            local v22 = v4[v21];
                            if v22 then
                                if not v22[3].Parent or not v22[1].Parent then
                                    if v22[2] then
                                        game.TweenService:Create(v22[2], TweenInfo.new(0.04), {
                                            BackgroundTransparency = 1
                                        }):Play();
                                        game.TweenService:Create(v22[2].IconImage, TweenInfo.new(0.04), {
                                            ImageTransparency = 1
                                        }):Play();
                                        game.TweenService:Create(v22[2].ArrowFrame.ArrowImage, TweenInfo.new(0.04), {
                                            ImageTransparency = 1
                                        }):Play();
                                        game.Debris:AddItem(v22[2], 0.04);
                                    end;
                                    table.remove(v4, v21);
                                else
                                    local v23 = v22[2];
                                    if v22[1] and (v22[1].Position - l_CFrame_0.Position).Magnitude > v22[3].RollOffMaxDistance then
                                        if not v23:GetAttribute("Hidden") then
                                            v23:SetAttribute("Hidden", true);
                                            game.TweenService:Create(v23, TweenInfo.new(0.2), {
                                                BackgroundTransparency = 1
                                            }):Play();
                                            game.TweenService:Create(v23.IconImage, TweenInfo.new(0.2), {
                                                ImageTransparency = 1
                                            }):Play();
                                            game.TweenService:Create(v23.ArrowFrame.ArrowImage, TweenInfo.new(0.2), {
                                                ImageTransparency = 1
                                            }):Play();
                                        end;
                                    elseif v23:GetAttribute("Hidden") then
                                        v23:SetAttribute("Hidden", nil);
                                        game.TweenService:Create(v23, TweenInfo.new(0.2), {
                                            BackgroundTransparency = 0
                                        }):Play();
                                        game.TweenService:Create(v23.IconImage, TweenInfo.new(0.2), {
                                            ImageTransparency = 0
                                        }):Play();
                                        game.TweenService:Create(v23.ArrowFrame.ArrowImage, TweenInfo.new(0.2), {
                                            ImageTransparency = 0
                                        }):Play();
                                    end;
                                    local l_Position_0 = v22[1].Position;
                                    local v25, v26 = l_CurrentCamera_0:WorldToViewportPoint(l_Position_0);
                                    local v27 = math.clamp(v25.X, l_X_1, l_X_0 - l_X_1);
                                    local v28 = math.clamp(v25.Y, l_X_1, l_Y_0 - l_X_1);
                                    if v27 == v25.X and v28 == v25.Y and v26 then
                                        v23.ArrowFrame.Visible = false;
                                    else
                                        v23.ArrowFrame.Visible = true;
                                        local v29 = l_CFrame_0:VectorToObjectSpace(l_Position_0 - l_CFrame_0.Position);
                                        local l_Unit_0 = Vector2.new(v29.X, v29.Y).Unit;
                                        local v31 = l_Unit_0 * v18;
                                        local v32 = math.atan2(l_Unit_0.X, l_Unit_0.Y);
                                        local v33 = nil;
                                        v33 = if math.abs(v31.Y) > v16 / 2 then l_Unit_0 * math.abs(v16 / 2 / l_Unit_0.Y) else l_Unit_0 * math.abs(v15 / 2 / l_Unit_0.X);
                                        v27 = l_X_0 / 2 + v33.X;
                                        v28 = l_Y_0 / 2 - v33.Y;
                                        v23.ArrowFrame.Rotation = math.deg(v32);
                                    end;
                                    v23.Position = UDim2.fromOffset(v27, v28);
                                end;
                            end;
                        end;
                        return;
                    end;
                end)
            };
            return;
        else
            if v0.AudioUI then
                v0.AudioUI:Destroy();
                v0.AudioUI = nil;
            end;
            if v0.AudioConnections then
                for _, v35 in pairs(v0.AudioConnections) do
                    v35:Disconnect();
                end;
                v0.AudioConnections = nil;
            end;
            return;
        end;
    end
};