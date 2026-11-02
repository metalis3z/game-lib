-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("RunService");
local v1 = {};
v1.Show = function(_) --[[ Line: 8 ]] --[[ Name: Show ]]
    -- upvalues: v1 (copy)
    if v1.UI and v1.UI.Parent then
        v1.UI.Visible = true;
    end;
end;
local v3 = {
    Side = {
        CellPadding = UDim2.new(0, 0, 0.15, 0), 
        CellSize = UDim2.new(0.1, 0, 0.49, 0), 
        FillDirectionMaxCells = 1, 
        NamesVisible = true
    }, 
    Stacked = {
        CellPadding = UDim2.new(0.375, 0, 0.15, 0), 
        CellSize = UDim2.new(0.125, 0, 0.54, 0), 
        FillDirectionMaxCells = 2, 
        NamesVisible = true
    }, 
    Icons = {
        CellPadding = UDim2.new(0.01, 0, 0.25, 0), 
        CellSize = UDim2.new(0.2, 0, 1, 0), 
        FillDirectionMaxCells = 4, 
        NamesVisible = false
    }
};
v1.Start = function(_) --[[ Line: 38 ]] --[[ Name: Start ]]
    -- upvalues: v1 (copy), v3 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
    local l_TemporaryUI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("TemporaryUI");
    local l_TweenService_0 = game:GetService("TweenService");
    local v10 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
    local v11 = require(game.ReplicatedStorage.Modules.Util);
    local v12 = script.PlayerInfo:Clone();
    local l_PlayerIcon_0 = v12.PlayerIcon;
    v12.Visible = false;
    v12.Parent = l_TemporaryUI_0;
    v1.UI = v12;
    task.spawn(function() --[[ Line: 57 ]]
        -- upvalues: l_LocalPlayer_0 (copy), l_PlayerIcon_0 (copy)
        local l_UserId_0 = l_LocalPlayer_0.UserId;
        l_PlayerIcon_0.Image = game.Players:GetUserThumbnailAsync(l_UserId_0, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    end);
    local l_Stamina_0 = v12.Bars.Stamina;
    local l_Health_0 = v12.Bars.Health;
    local function v23(v17, v18, v19, v20) --[[ Line: 68 ]] --[[ Name: updateBar ]]
        -- upvalues: l_TweenService_0 (copy)
        if not v17.Parent then
            return;
        else
            local v21 = math.clamp(v18 / v19, 0, 1);
            local v22 = v21 == 0 and 0 or 1 / v21;
            if v20 then
                v17.Bar.Clipping.Size = UDim2.fromScale(v21, 1);
                v17.Bar.Clipping.Top.Size = UDim2.fromScale(v22, 1);
            else
                l_TweenService_0:Create(v17.Bar.Clipping, TweenInfo.new(1), {
                    Size = UDim2.fromScale(v21, 1)
                }):Play();
                l_TweenService_0:Create(v17.Bar.Clipping.Top, TweenInfo.new(1), {
                    Size = UDim2.fromScale(v22, 1)
                }):Play();
            end;
            v17.Amount.Text = ("%*/%*"):format(math.round(v18), (math.round(v19)));
            return;
        end;
    end;
    local l_Health_1 = l_Humanoid_0.Health;
    local function v32(v25) --[[ Line: 92 ]] --[[ Name: addDamageEffect ]]
        -- upvalues: l_Humanoid_0 (copy), l_Health_1 (ref), v11 (copy)
        if not v25 then
            v25 = 0;
        end;
        local v26 = l_Humanoid_0:GetAttribute("FakeDamage") or 0;
        local v27 = l_Humanoid_0.MaxHealth + v25;
        local v28 = math.clamp(l_Humanoid_0.Health + v25 - v26, 0, v27);
        if v28 < l_Health_1 then
            local v29 = l_Health_1 - v28;
            if v25 == 0 or v29 >= 0.2 then
                local v30 = math.clamp(v29 / (v27 / 2), 0.1, 1);
                local v31 = math.clamp(v29 / (v27 / 2), 0.1, 0.75);
                v11:ApplyCameraShake(v30, v31);
            end;
        end;
        l_Health_1 = v28;
    end;
    local function v35() --[[ Line: 110 ]] --[[ Name: updateHealthBar ]]
        -- upvalues: l_Humanoid_0 (copy), v23 (copy), l_Health_0 (copy), v32 (copy)
        local v33 = l_Humanoid_0:GetAttribute("FakeDamage") or 0;
        local v34 = math.clamp(l_Humanoid_0.Health - v33, 0, l_Humanoid_0.MaxHealth);
        v23(l_Health_0, v34, l_Humanoid_0.MaxHealth);
        v32();
    end;
    local function v36() --[[ Line: 118 ]] --[[ Name: updateStaminaBar ]]
        -- upvalues: v23 (copy), l_Stamina_0 (copy), v10 (copy)
        v23(l_Stamina_0, math.clamp(v10.Stamina, v10.MinStamina, v10.MaxStamina), v10.MaxStamina, true);
    end;
    local function v38() --[[ Line: 122 ]] --[[ Name: updateHardDamage ]]
        -- upvalues: l_Humanoid_0 (copy), l_TweenService_0 (copy), l_Health_0 (copy)
        local v37 = l_Humanoid_0:GetAttribute("HardDamage") or 0;
        if v37 > 0 then
            l_TweenService_0:Create(l_Health_0.HardDamage.Clipping.Top, TweenInfo.new(1), {
                Size = UDim2.fromScale(v37 / l_Humanoid_0.MaxHealth, 1), 
                ImageTransparency = 0.3
            }):Play();
            return;
        else
            l_TweenService_0:Create(l_Health_0.HardDamage.Clipping.Top, TweenInfo.new(1), {
                Size = UDim2.fromScale(0, 1), 
                ImageTransparency = 1
            }):Play();
            return;
        end;
    end;
    local function v40() --[[ Line: 132 ]] --[[ Name: updateOverheal ]]
        -- upvalues: l_Humanoid_0 (copy), l_Health_0 (copy), v32 (copy), l_TweenService_0 (copy), l_Health_1 (ref)
        local v39 = tonumber(l_Humanoid_0:GetAttribute("Overheal"));
        if v39 and v39 <= 0 then
            v39 = nil;
        end;
        if v39 then
            l_Health_0.Overheal.Text = v39 and ("+ %*"):format((math.round(v39))) or "";
            v32(v39);
            if not l_Health_0.Overheal.Visible then
                l_Health_0.Overheal.Visible = true;
                l_TweenService_0:Create(l_Health_0.Icon, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(155, 155, 255)
                }):Play();
                l_TweenService_0:Create(l_Health_0.Amount, TweenInfo.new(0.2), {
                    TextColor3 = Color3.fromRGB(155, 155, 255)
                }):Play();
                l_TweenService_0:Create(l_Health_0.Bar, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(63, 63, 145)
                }):Play();
                l_TweenService_0:Create(l_Health_0.Bar.Clipping.Top, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(155, 155, 255)
                }):Play();
                return;
            end;
        elseif not v39 and l_Health_0.Overheal.Visible then
            l_Health_0.Overheal.Visible = false;
            l_TweenService_0:Create(l_Health_0.Icon, TweenInfo.new(0.2), {
                ImageColor3 = script.PlayerInfo.Bars.Health.Icon.ImageColor3
            }):Play();
            l_TweenService_0:Create(l_Health_0.Amount, TweenInfo.new(0.2), {
                TextColor3 = script.PlayerInfo.Bars.Health.Amount.TextColor3
            }):Play();
            l_TweenService_0:Create(l_Health_0.Bar, TweenInfo.new(0.2), {
                ImageColor3 = script.PlayerInfo.Bars.Health.Bar.ImageColor3
            }):Play();
            l_TweenService_0:Create(l_Health_0.Bar.Clipping.Top, TweenInfo.new(0.2), {
                ImageColor3 = script.PlayerInfo.Bars.Health.Bar.Clipping.Top.ImageColor3
            }):Play();
            task.delay(0.1, function() --[[ Line: 151 ]]
                -- upvalues: l_Health_1 (ref), l_Humanoid_0 (ref)
                l_Health_1 = l_Humanoid_0.Health;
            end);
        end;
    end;
    v10.StaminaChanged:Connect(v36);
    l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(v35);
    l_Humanoid_0:GetPropertyChangedSignal("MaxHealth"):Connect(v35);
    l_Humanoid_0:GetAttributeChangedSignal("FakeDamage"):Connect(v35);
    l_Humanoid_0:GetAttributeChangedSignal("HardDamage"):Connect(v38);
    l_Humanoid_0:GetAttributeChangedSignal("Overheal"):Connect(v40);
    local l_Settings_0 = l_LocalPlayer_0.PlayerData.Settings;
    local v42 = v3[l_Settings_0.Customization.SurvivorInfoDisplayType.Value] or v3.Side;
    for v43, v44 in pairs(v42) do
        if v43 ~= "NamesVisible" then
            v12.CurrentSurvivors.UIGridLayout[v43] = v44;
        else
            v12.CurrentSurvivors:SetAttribute("NamesVisible", v44);
        end;
    end;
    local v45 = nil;
    local function v66(v46) --[[ Line: 180 ]] --[[ Name: addSurvivor ]]
        -- upvalues: v12 (copy), v45 (ref), l_Character_0 (copy), l_LocalPlayer_0 (copy)
        if not v46:IsA("Model") then
            return;
        elseif not v46:FindFirstChild("Humanoid") then
            return;
        elseif not v12.Parent then
            v45:Disconnect();
            v45 = nil;
            return;
        elseif not v12:FindFirstChild("CurrentSurvivors") then
            return;
        else
            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v46);
            local v48 = l_PlayerFromCharacter_0 and l_PlayerFromCharacter_0.Name;
            local v49 = script.SurvivorFrame:Clone();
            v49.Name = v46.Name;
            v49.SurvivorName.Text = v46.Name;
            v49.Username.Text = v46:GetAttribute("Username") or "";
            v49.Parent = v12.CurrentSurvivors;
            if not v12.CurrentSurvivors:GetAttribute("NamesVisible") then
                v49.SurvivorName.Visible = false;
                v49.Username.Visible = false;
            end;
            if l_Character_0 == v46 then
                v49.Username.Text = ("%* (You)"):format(l_LocalPlayer_0.Name);
                v49.SurvivorName.TextColor3 = Color3.new(1, 1, 0.75);
                v49.Outline.ImageColor3 = Color3.new(1, 1, 0.25);
                v49.Health.Visible = false;
            end;
            local l_FirstChild_0 = game.ReplicatedStorage.Assets.Survivors:FindFirstChild(v46.Name);
            local v51 = l_FirstChild_0 and require(l_FirstChild_0.Config);
            if v51 and v51.RenderImage then
                v49.SurvivorName.Text = v51.DisplayName or v49.SurvivorName.Text;
                v49.Icon.Image = v51.RenderImage;
            end;
            local l_FirstChild_1 = game.ReplicatedStorage.Assets.Skins.Survivors:FindFirstChild(v46.Name);
            local v53 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild((tostring(v46:GetAttribute("SkinName"))));
            local v54 = v53 and require(v53.Config);
            if v54 and v54.RenderImage then
                v49.Icon.Image = v54.RenderImage;
            end;
            local v55 = nil;
            local v56 = false;
            local function v57() --[[ Line: 230 ]] --[[ Name: kill ]]
                -- upvalues: v56 (ref), v49 (copy), v48 (copy), v55 (ref)
                if not v56 and v49.Parent then
                    v56 = true;
                    if v48 and not game.Players:FindFirstChild(v48) then
                        v49.Health.Text = "LOST";
                        v49.Health.Position = UDim2.fromScale(0.469, 0.735);
                        v49.Health.TextColor3 = Color3.new(0.5, 0.5, 0.5);
                        v49.Outline.ImageColor3 = Color3.new(0.439216, 0.439216, 0.439216);
                        v49.Icon.ImageColor3 = Color3.new(0.2, 0.2, 0.2);
                        v49.Username.TextColor3 = Color3.new(0.2, 0.2, 0.2);
                        v49.SurvivorName.TextColor3 = Color3.new(0.760784, 0.760784, 0.760784);
                    else
                        v49.Health.Text = "DEAD";
                        v49.Health.Position = UDim2.fromScale(0.465, 0.735);
                        v49.Outline.ImageColor3 = Color3.new(0.75, 0, 0);
                        v49.Icon.ImageColor3 = Color3.new(1, 0, 0);
                        v49.Username.TextColor3 = Color3.new(1, 0, 0);
                        v49.SurvivorName.TextColor3 = Color3.new(1, 0.5, 0);
                    end;
                    if v55 then
                        v55:Disconnect();
                    end;
                    v55 = nil;
                end;
            end;
            local v58 = v46:WaitForChild("Humanoid", 5);
            if v58 then
                local function v62() --[[ Line: 261 ]] --[[ Name: updateHP ]]
                    -- upvalues: v58 (copy), v57 (copy), v49 (copy)
                    if not v58 or not v58.Parent then
                        return v57();
                    else
                        local l_Health_2 = v49:FindFirstChild("Health");
                        if l_Health_2 then
                            local v60 = v58.Health / v58.MaxHealth;
                            local v61 = Color3.fromHSV(v60 / 3, 0.4, 1);
                            l_Health_2.Text = ("%*%%"):format((math.round(v60 * 100)));
                            l_Health_2.TextColor3 = v61;
                            if v58.Health <= 0 then
                                v57();
                            end;
                        end;
                        return;
                    end;
                end;
                v62();
                v55 = v58:GetPropertyChangedSignal("Health"):Connect(v62);
            end;
            v46.AncestryChanged:Connect(function(_, v64) --[[ Line: 281 ]]
                -- upvalues: v57 (copy)
                if not v64 then
                    v57();
                end;
            end);
            local v65 = v46:WaitForChild("Humanoid", 15);
            if v65 then
                v65.Died:Once(v57);
            end;
            return;
        end;
    end;
    v45 = workspace.Players.Survivors.ChildAdded:Connect(v66);
    for _, v68 in workspace.Players.Survivors:GetChildren() do
        v66(v68);
    end;
    local function v75(v69) --[[ Line: 296 ]] --[[ Name: toggleInfo ]]
        -- upvalues: l_LocalPlayer_0 (copy), l_Character_0 (copy), v12 (copy), v11 (copy), l_Settings_0 (copy)
        local v70 = require(game.ReplicatedStorage.Initializer);
        local l_SidebarHandler_0 = v70.PlayerSystems.SidebarHandler;
        local l_PlayerList_0 = v70.Modules.PlayerList;
        local l_EventBar_0 = l_LocalPlayer_0.PlayerGui.MainUI:FindFirstChild("EventBar");
        if (v69 or l_Character_0.Parent) ~= workspace.Players.Spectating then
            v12.Visible = true;
            l_EventBar_0.Visible = false;
            v11:CreateTooltip();
            l_SidebarHandler_0:ToggleSidebarButtons(false);
            l_PlayerList_0:TogglePlayerList(false, true);
        else
            v12.Visible = false;
            l_EventBar_0.Visible = true;
            l_SidebarHandler_0:ToggleSidebarButtons(true);
            l_PlayerList_0:TogglePlayerList(true, true);
        end;
        local l_SurvivorInfoEnabled_0 = l_Settings_0.Customization.SurvivorInfoEnabled;
        v12.CurrentSurvivors.Visible = l_SurvivorInfoEnabled_0.Value;
    end;
    v75();
    l_Character_0.AncestryChanged:Connect(function(_, v77) --[[ Line: 323 ]]
        -- upvalues: v75 (copy)
        v75(v77);
    end);
    task.spawn(function() --[[ Line: 328 ]]
        -- upvalues: l_Humanoid_0 (copy), v23 (copy), l_Health_0 (copy), v32 (copy), l_Stamina_0 (copy), v10 (copy)
        local v78 = l_Humanoid_0:GetAttribute("FakeDamage") or 0;
        local v79 = math.clamp(l_Humanoid_0.Health - v78, 0, l_Humanoid_0.MaxHealth);
        v23(l_Health_0, v79, l_Humanoid_0.MaxHealth);
        v32();
        v23(l_Stamina_0, math.clamp(v10.Stamina, v10.MinStamina, v10.MaxStamina), v10.MaxStamina, true);
    end);
end;
v1.Destroy = function(_) --[[ Line: 336 ]] --[[ Name: Destroy ]]
    -- upvalues: v1 (copy)
    if v1.UI then
        v1.UI:Destroy();
    end;
end;
return v1;