-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Connections = {}
};
v0.Start = function(_) --[[ Line: 8 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local v4 = l_Character_0.PrimaryPart or l_Character_0:WaitForChild("HumanoidRootPart", 10);
    if not v4 then
        return;
    else
        local l_Customization_0 = l_LocalPlayer_0.PlayerData:WaitForChild("Settings"):WaitForChild("Customization");
        local l_TemporaryUI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("TemporaryUI");
        local l_TweenService_0 = game:GetService("TweenService");
        local v8 = require(game.ReplicatedStorage.Modules.Util);
        local v9 = require(game.ReplicatedStorage.Modules.Misc.CharacterHovering);
        local v25 = {
            ["Survivor Name"] = function(v10, v11, v12) --[[ Line: 26 ]]
                local v13 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v10)];
                v11.Text = v13 and v13.Config and v13.Config.DisplayName or v10.Name;
                v11.Size = v12 == 1 and UDim2.fromScale(1, 0.8) or UDim2.fromScale(1, 0.3);
                v11.TextColor3 = v12 == 1 and Color3.new(1, 1, 1) or Color3.new(0.75, 0.75, 0.75);
            end, 
            Username = function(v14, v15, v16) --[[ Line: 35 ]]
                v15.Text = v14:GetAttribute("Username") or "???";
                v15.Size = v16 == 1 and UDim2.fromScale(1, 0.8) or UDim2.fromScale(1, 0.3);
                v15.TextColor3 = v16 == 1 and Color3.new(1, 1, 1) or Color3.new(0.75, 0.75, 0.75);
            end, 
            Health = function(v17, v18, v19) --[[ Line: 41 ]]
                local v20 = v17:WaitForChild("Humanoid", 20);
                if v20 then
                    local function v24() --[[ Line: 45 ]] --[[ Name: healthUpdated ]]
                        -- upvalues: v18 (copy), v20 (copy)
                        if not v18.Parent then
                            return;
                        else
                            local v21 = v20.Health / v20.MaxHealth;
                            local v22 = Color3.fromHSV(v21 / 3, 0.4, 1);
                            local v23 = Color3.fromHSV(v21 / 3, 0.4, 0.25);
                            v18.Text = ("%*%%"):format((math.round(v21 * 100)));
                            v18.TextColor3 = v22;
                            v18.UIStroke.Color = v23;
                            return;
                        end;
                    end;
                    v24();
                    v20.HealthChanged:Connect(v24);
                    v18.Size = v19 == 1 and UDim2.fromScale(1, 0.8) or UDim2.fromScale(1, 0.5);
                end;
            end
        };
        local v26 = false;
        local function v35(v27) --[[ Line: 65 ]] --[[ Name: createTag ]]
            -- upvalues: l_LocalPlayer_0 (copy), l_TemporaryUI_0 (copy), l_Customization_0 (copy), v25 (copy), v26 (ref), v9 (copy)
            if v27 == l_LocalPlayer_0.Character then
                return;
            else
                local v28 = v27:WaitForChild("Head", 20);
                if not v28 then
                    return;
                else
                    local v29 = script.NametagTemplate:Clone();
                    v29.Name = "Nametag";
                    v29.Adornee = v28;
                    v29.Parent = l_TemporaryUI_0;
                    local v30 = 1;
                    for v31 = 1, 3 do
                        local l_l_Customization_0_FirstChild_0 = l_Customization_0:FindFirstChild((("NametagTitle%*"):format(v31)));
                        local v33 = l_l_Customization_0_FirstChild_0 and l_l_Customization_0_FirstChild_0.Value;
                        if v33 and v25[v33] then
                            local v34 = script.TitleTemplate:Clone();
                            v34.Name = ("Title%*"):format(v30);
                            v34.TextTransparency = 1;
                            v34.UIStroke.Transparency = 1;
                            v34.LayoutOrder = v30;
                            v34.Parent = v29;
                            v25[v33](v27, v34, v30);
                            v30 = v30 + 1;
                        end;
                    end;
                    if v26 then
                        v9:AddHoverableCharacter(v27);
                    end;
                    return;
                end;
            end;
        end;
        local function v39(v36) --[[ Line: 97 ]] --[[ Name: getNametag ]]
            -- upvalues: l_TemporaryUI_0 (copy)
            if not v36 then
                return;
            else
                for _, v38 in pairs(l_TemporaryUI_0:GetChildren()) do
                    if v38.Name == "Nametag" and v38.Adornee == v36 then
                        return v38;
                    end;
                end;
                return;
            end;
        end;
        local function v47(v40, v41) --[[ Line: 107 ]] --[[ Name: showNametag ]]
            -- upvalues: l_LocalPlayer_0 (copy), v39 (copy), l_TweenService_0 (copy), v9 (copy)
            if v40 == l_LocalPlayer_0.Character then
                return;
            else
                local v42 = v40 and v40:WaitForChild("Head", 10);
                local v43 = v39(v42);
                if not v43 then
                    warn((("[NameTags]: Could not properly display nametag for: %*."):format(v40)));
                    return;
                else
                    if v41 then
                        local l_Highlight_0 = Instance.new("Highlight");
                        l_Highlight_0.OutlineTransparency = 1;
                        l_Highlight_0.FillTransparency = 1;
                        l_Highlight_0.FillColor = Color3.new(1, 1, 1);
                        l_Highlight_0.Parent = v43;
                        l_Highlight_0.Adornee = v40;
                        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(v9.HighlightTweenTime), {
                            OutlineTransparency = 0.5, 
                            FillTransparency = 0.9
                        }):Play();
                    end;
                    for _, v46 in pairs(v43:GetChildren()) do
                        if v46:IsA("GuiObject") then
                            l_TweenService_0:Create(v46, TweenInfo.new(v9.HighlightTweenTime), {
                                TextTransparency = 0
                            }):Play();
                            l_TweenService_0:Create(v46.UIStroke, TweenInfo.new(v9.HighlightTweenTime), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                    return;
                end;
            end;
        end;
        local function v54(v48) --[[ Line: 139 ]] --[[ Name: hideNametag ]]
            -- upvalues: v39 (copy), l_TemporaryUI_0 (copy), l_TweenService_0 (copy), v9 (copy)
            local v49 = v48 and v48:WaitForChild("Head", 10);
            local v50 = v39(v49);
            if not v50 then
                return;
            else
                local l_Highlight_1 = v50:FindFirstChild("Highlight");
                if l_Highlight_1 then
                    l_Highlight_1.Name = "Disappearing";
                    l_Highlight_1.Parent = l_TemporaryUI_0;
                    l_TweenService_0:Create(l_Highlight_1, TweenInfo.new(v9.HighlightTweenTime), {
                        FillTransparency = 1, 
                        OutlineTransparency = 1
                    }):Play();
                    game.Debris:AddItem(l_Highlight_1, v9.HighlightTweenTime);
                end;
                for _, v53 in pairs(v50:GetChildren()) do
                    if v53:IsA("GuiObject") then
                        l_TweenService_0:Create(v53, TweenInfo.new(v9.HighlightTweenTime), {
                            TextTransparency = 1
                        }):Play();
                        l_TweenService_0:Create(v53.UIStroke, TweenInfo.new(v9.HighlightTweenTime), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
                return;
            end;
        end;
        local function v78() --[[ Line: 164 ]] --[[ Name: toggleNametagFunctionality ]]
            -- upvalues: v0 (ref), l_Character_0 (copy), l_Customization_0 (copy), v9 (copy), v4 (copy), v8 (copy), v54 (copy), v47 (copy), v26 (ref), v35 (copy)
            if v0.Connections then
                for _, v56 in pairs(v0.Connections) do
                    v56:Disconnect();
                end;
                table.clear(v0.Connections);
            end;
            local l_Parent_0 = l_Character_0.Parent;
            if l_Character_0 and l_Parent_0 and l_Parent_0 ~= workspace.Players.Spectating and l_Customization_0:FindFirstChild("NametagsEnabled") and l_Customization_0.NametagsEnabled.Value then
                local v58 = l_Customization_0:FindFirstChild("NametagDisplayType") and l_Customization_0.NametagDisplayType.Value or "Distance Dependent";
                local v59 = v9.HoverRange or 30;
                if v58 == "Distance Dependent" then
                    local v60 = {};
                    local v61 = 0;
                    do
                        local l_v60_0, l_v61_0 = v60, v61;
                        v0.Connections.DistanceConnection = game["Run Service"].RenderStepped:Connect(function(v64) --[[ Line: 186 ]]
                            -- upvalues: l_v61_0 (ref), l_Parent_0 (copy), v4 (ref), v59 (copy), l_Character_0 (ref), v8 (ref), l_v60_0 (ref), v54 (ref), v47 (ref)
                            l_v61_0 = l_v61_0 + v64;
                            if l_v61_0 <= 0.125 then
                                return;
                            else
                                l_v61_0 = 0;
                                local v65 = {};
                                for _, v67 in pairs(l_Parent_0:GetChildren()) do
                                    local v68 = v67.PrimaryPart and (v67.PrimaryPart.Position - v4.Position).Magnitude;
                                    local l_Humanoid_0 = v67:FindFirstChild("Humanoid");
                                    if v68 and l_Humanoid_0 and l_Humanoid_0.Health > 0 and v59 >= v68 and v67 ~= l_Character_0 then
                                        v65[v67] = true;
                                    end;
                                end;
                                for v70, _ in pairs(v65) do
                                    if not v8:IsOnScreen(v70) then
                                        v65[v70] = nil;
                                    end;
                                end;
                                for v72, _ in pairs(l_v60_0) do
                                    if not v65[v72] then
                                        v54(v72);
                                    end;
                                end;
                                for v74, _ in pairs(v65) do
                                    if not l_v60_0[v74] then
                                        v47(v74);
                                    end;
                                end;
                                l_v60_0 = v65;
                                return;
                            end;
                        end);
                    end;
                else
                    v26 = true;
                    v0.Connections.HoverBeganConnection = v9.Hovered:Connect(v47);
                    v0.Connections.HoverEndedConnection = v9.HoverEnded:Connect(v54);
                end;
                v0.Connections.CharacterAdded = l_Parent_0.ChildAdded:Connect(v35);
                for _, v77 in pairs(l_Parent_0:GetChildren()) do
                    v35(v77);
                end;
            end;
        end;
        v78();
        l_Character_0:GetPropertyChangedSignal("Parent"):Connect(v78);
        return;
    end;
end;
return v0;