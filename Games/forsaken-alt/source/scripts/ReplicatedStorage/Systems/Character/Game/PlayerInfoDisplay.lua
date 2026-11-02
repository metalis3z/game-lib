-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Show = function(_) --[[ Line: 6 ]] --[[ Name: Show ]]
    -- upvalues: v0 (copy)
    if v0.UI and v0.UI.Parent then
        v0.UI.Visible = true;
    end;
end;
local v2 = {
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
v0.Start = function(_) --[[ Line: 36 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), v2 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
    local l_TemporaryUI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("TemporaryUI");
    local l_TweenService_0 = game:GetService("TweenService");
    local v9 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting);
    local v10 = require(game.ReplicatedStorage.Modules.Util);
    local v11 = script.PlayerInfo:Clone();
    local l_PlayerIcon_0 = v11.PlayerIcon;
    v11.Visible = false;
    v11.Parent = l_TemporaryUI_0;
    v0.UI = v11;
    task.spawn(function() --[[ Line: 55 ]]
        -- upvalues: l_LocalPlayer_0 (copy), l_PlayerIcon_0 (copy)
        local l_UserId_0 = l_LocalPlayer_0.UserId;
        l_PlayerIcon_0.Image = game.Players:GetUserThumbnailAsync(l_UserId_0, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    end);
    local l_Stamina_0 = v11.Bars.Stamina;
    local l_Health_0 = v11.Bars.Health;
    local function v22(v16, v17, v18, v19) --[[ Line: 66 ]] --[[ Name: updateBar ]]
        -- upvalues: l_TweenService_0 (copy)
        if not v16.Parent then
            return;
        else
            local v20 = math.clamp(v17 / v18, 0, 1);
            local v21 = v20 == 0 and 0 or 1 / v20;
            if v19 then
                v16.Bar.Clipping.Size = UDim2.fromScale(v20, 1);
                v16.Bar.Clipping.Top.Size = UDim2.fromScale(v21, 1);
            else
                l_TweenService_0:Create(v16.Bar.Clipping, TweenInfo.new(1), {
                    Size = UDim2.fromScale(v20, 1)
                }):Play();
                l_TweenService_0:Create(v16.Bar.Clipping.Top, TweenInfo.new(1), {
                    Size = UDim2.fromScale(v21, 1)
                }):Play();
            end;
            v16.Amount.Text = ("%*/%*"):format(math.round(v17), (math.round(v18)));
            return;
        end;
    end;
    local l_Health_1 = l_Humanoid_0.Health;
    local function v30(v24) --[[ Line: 90 ]] --[[ Name: addDamageEffect ]]
        -- upvalues: l_Humanoid_0 (copy), l_Health_1 (ref), v10 (copy)
        if not v24 then
            v24 = 0;
        end;
        local v25 = l_Humanoid_0.Health + v24;
        local v26 = l_Humanoid_0.MaxHealth + v24;
        if v25 < l_Health_1 then
            local v27 = l_Health_1 - v25;
            if v24 == 0 or v27 >= 0.2 then
                local v28 = math.clamp(v27 / (v26 / 2), 0.1, 1);
                local v29 = math.clamp(v27 / (v26 / 2), 0.1, 0.75);
                v10:ApplyCameraShake(v28, v29);
            end;
        end;
        l_Health_1 = v25;
    end;
    local function v31() --[[ Line: 107 ]] --[[ Name: updateHealthBar ]]
        -- upvalues: v22 (copy), l_Health_0 (copy), l_Humanoid_0 (copy), v30 (copy)
        v22(l_Health_0, l_Humanoid_0.Health, l_Humanoid_0.MaxHealth);
        v30();
    end;
    local function v32() --[[ Line: 112 ]] --[[ Name: updateStaminaBar ]]
        -- upvalues: v22 (copy), l_Stamina_0 (copy), v9 (copy)
        v22(l_Stamina_0, math.clamp(v9.Stamina, v9.MinStamina, v9.MaxStamina), v9.MaxStamina, true);
    end;
    local function v34() --[[ Line: 116 ]] --[[ Name: updateOverheal ]]
        -- upvalues: l_Humanoid_0 (copy), l_Health_0 (copy), v30 (copy), l_TweenService_0 (copy), l_Health_1 (ref)
        local v33 = tonumber(l_Humanoid_0:GetAttribute("Overheal"));
        if v33 and v33 <= 0 then
            v33 = nil;
        end;
        if v33 then
            l_Health_0.Overheal.Text = v33 and ("+ %*"):format((math.round(v33))) or "";
            v30(v33);
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
        elseif not v33 and l_Health_0.Overheal.Visible then
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
            task.delay(0.1, function() --[[ Line: 135 ]]
                -- upvalues: l_Health_1 (ref), l_Humanoid_0 (ref)
                l_Health_1 = l_Humanoid_0.Health;
            end);
        end;
    end;
    v9.StaminaChanged:Connect(v32);
    l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(v31);
    l_Humanoid_0:GetPropertyChangedSignal("MaxHealth"):Connect(v31);
    l_Humanoid_0:GetAttributeChangedSignal("Overheal"):Connect(v34);
    local l_Settings_0 = l_LocalPlayer_0.PlayerData.Settings;
    local v36 = v2[l_Settings_0.Customization.SurvivorInfoDisplayType.Value] or v2.Side;
    for v37, v38 in pairs(v36) do
        if v37 ~= "NamesVisible" then
            v11.CurrentSurvivors.UIGridLayout[v37] = v38;
        else
            v11.CurrentSurvivors:SetAttribute("NamesVisible", v38);
        end;
    end;
    local v39 = nil;
    local function v60(v40) --[[ Line: 162 ]] --[[ Name: addSurvivor ]]
        -- upvalues: v11 (copy), v39 (ref), l_Character_0 (copy), l_LocalPlayer_0 (copy)
        if not v40:IsA("Model") then
            return;
        elseif not v40:FindFirstChild("Humanoid") then
            return;
        elseif not v11.Parent then
            v39:Disconnect();
            v39 = nil;
            return;
        elseif not v11:FindFirstChild("CurrentSurvivors") then
            return;
        else
            local v41 = script.SurvivorFrame:Clone();
            v41.Name = v40.Name;
            v41.SurvivorName.Text = v40.Name;
            v41.Username.Text = v40:GetAttribute("Username") or "";
            v41.Parent = v11.CurrentSurvivors;
            if not v11.CurrentSurvivors:GetAttribute("NamesVisible") then
                v41.SurvivorName.Visible = false;
                v41.Username.Visible = false;
            end;
            if l_Character_0 == v40 then
                v41.Username.Text = ("%* (You)"):format(l_LocalPlayer_0.Name);
                v41.SurvivorName.TextColor3 = Color3.new(1, 1, 0.75);
                v41.Outline.ImageColor3 = Color3.new(1, 1, 0.25);
                v41.Health.Visible = false;
            end;
            local l_FirstChild_0 = game.ReplicatedStorage.Assets.Survivors:FindFirstChild(v40.Name);
            local v43 = l_FirstChild_0 and require(l_FirstChild_0.Config);
            if v43 and v43.RenderImage then
                v41.SurvivorName.Text = v43.DisplayName or v41.SurvivorName.Text;
                v41.Icon.Image = v43.RenderImage;
            end;
            local l_FirstChild_1 = game.ReplicatedStorage.Assets.Skins.Survivors:FindFirstChild(v40.Name);
            local v45 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild((tostring(v40:GetAttribute("SkinName"))));
            local v46 = v45 and require(v45.Config);
            if v46 and v46.RenderImage then
                v41.Icon.Image = v46.RenderImage;
            end;
            local v47 = v40:WaitForChild("Humanoid", 5);
            if v47 then
                local function v51() --[[ Line: 209 ]] --[[ Name: updateHP ]]
                    -- upvalues: v41 (copy), v47 (copy)
                    local l_Health_2 = v41:FindFirstChild("Health");
                    if l_Health_2 then
                        local v49 = v47.Health / v47.MaxHealth;
                        local v50 = Color3.fromHSV(v49 / 3, 0.4, 1);
                        l_Health_2.Text = ("%*%%"):format((math.round(v49 * 100)));
                        l_Health_2.TextColor3 = v50;
                    end;
                end;
                local l_Health_3 = v41:FindFirstChild("Health");
                if l_Health_3 then
                    local v53 = v47.Health / v47.MaxHealth;
                    local v54 = Color3.fromHSV(v53 / 3, 0.4, 1);
                    l_Health_3.Text = ("%*%%"):format((math.round(v53 * 100)));
                    l_Health_3.TextColor3 = v54;
                end;
                v47:GetPropertyChangedSignal("Health"):Connect(v51);
            end;
            local v55 = false;
            local function v56() --[[ Line: 223 ]] --[[ Name: kill ]]
                -- upvalues: v55 (ref), v41 (copy)
                if not v55 and v41.Parent then
                    v55 = true;
                    v41.Health.Visible = false;
                    v41.Outline.ImageColor3 = Color3.new(0.75, 0, 0);
                    v41.Icon.ImageColor3 = Color3.new(1, 0, 0);
                    v41.Username.TextColor3 = Color3.new(1, 0, 0);
                    v41.SurvivorName.TextColor3 = Color3.new(1, 0.5, 0);
                end;
            end;
            v40.AncestryChanged:Connect(function(_, v58) --[[ Line: 235 ]]
                -- upvalues: v56 (copy)
                if not v58 then
                    v56();
                end;
            end);
            local v59 = v40:WaitForChild("Humanoid", 15);
            if v59 then
                v59.Died:Connect(v56);
            end;
            return;
        end;
    end;
    v39 = workspace.Players.Survivors.ChildAdded:Connect(v60);
    for _, v62 in workspace.Players.Survivors:GetChildren() do
        v60(v62);
    end;
    local function v68(v63) --[[ Line: 250 ]] --[[ Name: toggleInfo ]]
        -- upvalues: l_Character_0 (copy), v11 (copy), l_Settings_0 (copy)
        local v64 = require(game.ReplicatedStorage.Initializer);
        local l_SidebarHandler_0 = v64.PlayerSystems.SidebarHandler;
        local l_PlayerList_0 = v64.Modules.PlayerList;
        if (v63 or l_Character_0.Parent) ~= workspace.Players.Spectating then
            v11.Visible = true;
            l_SidebarHandler_0:ToggleSidebarButtons(false);
            l_PlayerList_0:TogglePlayerList(false, true);
        else
            v11.Visible = false;
            l_SidebarHandler_0:ToggleSidebarButtons(true);
            l_PlayerList_0:TogglePlayerList(true, true);
        end;
        local l_SurvivorInfoEnabled_0 = l_Settings_0.Customization.SurvivorInfoEnabled;
        v11.CurrentSurvivors.Visible = l_SurvivorInfoEnabled_0.Value;
    end;
    v68();
    l_Character_0.AncestryChanged:Connect(function(_, v70) --[[ Line: 273 ]]
        -- upvalues: v68 (copy)
        v68(v70);
    end);
    task.spawn(function() --[[ Line: 278 ]]
        -- upvalues: v22 (copy), l_Health_0 (copy), l_Humanoid_0 (copy), v30 (copy), l_Stamina_0 (copy), v9 (copy)
        v22(l_Health_0, l_Humanoid_0.Health, l_Humanoid_0.MaxHealth);
        v30();
        v22(l_Stamina_0, math.clamp(v9.Stamina, v9.MinStamina, v9.MaxStamina), v9.MaxStamina, true);
    end);
end;
v0.Destroy = function(_) --[[ Line: 286 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.UI then
        v0.UI:Destroy();
    end;
end;
return v0;