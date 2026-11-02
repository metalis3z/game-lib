-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = time();
local v1 = nil;
while true do
    task.wait();
    if game.Players.LocalPlayer.Character then
        break;
    end;
end;
while true do
    task.wait();
    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        break;
    end;
end;
local l_InteractGUI_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("InteractGUI");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v5 = nil;
local v6 = nil;
local v7 = false;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v10 = UDim2.new(1.2, 0, 1.3, 0);
local function v17()
    local v11 = false;
    local v12 = {
        game.Players.LocalPlayer.Backpack, 
        game.Players.LocalPlayer.Character
    };
    for _, v14 in pairs(v12) do
        for _, v16 in pairs(v14:GetChildren()) do
            if v16:IsA("Tool") and v16:FindFirstChild("Stab") and v16:FindFirstChild("KnifeClient") then
                v11 = true;
            end;
        end;
    end;
    return v11;
end;
local l_TouchInteractButtons_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchInteractButtons");
local _ = l_TouchInteractButtons_0:WaitForChild("Phone");
local _ = l_TouchInteractButtons_0:WaitForChild("Tablet");
local v21 = nil;
local v22 = nil;
game:GetService("RunService").PreSimulation:Connect(function()
    if time() - v0 < 0.1 then
        return;
    elseif game.Players.LocalPlayer.Character == nil then
        return;
    else
        local l_Character_0 = game.Players.LocalPlayer.Character;
        local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
        if not l_HumanoidRootPart_0 then
            return;
        else
            l_InteractGUI_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("InteractGUI");
            if l_InteractGUI_0 == nil then
                v5 = nil;
                v6 = nil;
                return;
            else
                local v25 = l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Gamepad1;
                local v26 = l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Touch;
                l_InteractGUI_0.Gamepad.Visible = false;
                l_InteractGUI_0.Keyboard.Visible = false;
                l_InteractGUI_0.Mobile.Visible = false;
                local v27 = v25 and l_InteractGUI_0.Gamepad or v26 and l_InteractGUI_0.Mobile or l_InteractGUI_0.Keyboard;
                v27.Visible = true;
                local l_Use_0 = v27.Use;
                local l_Cooldown_0 = v27.Cooldown;
                l_TouchInteractButtons_0.Enabled = v26;
                if v26 and _G.MobileDevice ~= nil then
                    v21 = l_TouchInteractButtons_0:FindFirstChild(_G.MobileDevice).TouchInteract;
                    v22 = l_TouchInteractButtons_0:FindFirstChild(_G.MobileDevice).TouchInteractKnife;
                end;
                if v5 == nil then
                    v5 = l_TweenService_0:Create(l_InteractGUI_0, v4, {
                        Size = v10, 
                        Enabled = true
                    });
                    v6 = l_TweenService_0:Create(l_InteractGUI_0, v4, {
                        Size = UDim2.new(0, 0, 0, 0), 
                        Enabled = false
                    });
                end;
                local v30 = {};
                for _, v32 in l_CollectionService_0:GetTagged("InteractiveBox") do
                    table.insert(v30, v32);
                end;
                local v33 = 1000;
                local v34 = nil;
                local v35 = {};
                for _, v37 in pairs(v30) do
                    if (v37.Position - l_HumanoidRootPart_0.Position).magnitude <= 6 then
                        table.insert(v35, v37);
                    end;
                end;
                for _, v39 in pairs(v35) do
                    local l_magnitude_0 = (v39.Position - l_HumanoidRootPart_0.Position).magnitude;
                    if l_magnitude_0 < v33 then
                        local v41 = false;
                        if v39:FindFirstChild("KnifeBox") ~= nil then
                            v41 = v39.KnifeBox.Value == true;
                        end;
                        local v42 = Ray.new(l_HumanoidRootPart_0.CFrame.p, (v39.CFrame.p - l_HumanoidRootPart_0.CFrame.p).unit * l_magnitude_0);
                        local l_PartOnRay_0 = game.Workspace:FindPartOnRay(v42, l_Character_0);
                        local v44 = {
                            BoxDisabled = v39:FindFirstChild("IsDisabled") and v39.IsDisabled.Value == false or v39:FindFirstChild("IsDisabled") == nil, 
                            KeyDoorInnocents = v39:FindFirstChild("KeyToPickupColor") and not v17() or v39:FindFirstChild("KeyToPickupColor") == nil, 
                            GunSafe = v39:FindFirstChild("PerPlayerUse") and not v17() or v39:FindFirstChild("PerPlayerUse") == nil, 
                            PerUseUsedAlready = v39:FindFirstChild("PerPlayerUse") and not v39.PerPlayerUse:FindFirstChild(game.Players.LocalPlayer.Name) or v39:FindFirstChild("PerPlayerUse") == nil, 
                            MurdererOnlyInteract = v41 == true and v17() == true or v41 == false, 
                            RequiresVision = v39:FindFirstChild("RequireVision") and (v39:FindFirstChild("RequireVision").Value == true and l_PartOnRay_0 == v39 or v39.RequireVision.Value == false) or v39:FindFirstChild("RequireVision") == nil
                        };
                        local v45 = true;
                        for _, v47 in pairs(v44) do
                            if not v47 then
                                v45 = false;
                            end;
                        end;
                        if v45 then
                            v33 = l_magnitude_0;
                            v34 = v39;
                        end;
                    end;
                end;
                if v34 then
                    local l_Value_0 = v34.InUse.Value;
                    l_InteractGUI_0.Adornee = v34;
                    v1 = v34;
                    local v49 = v34:FindFirstChild("KnifeBox") and v34.KnifeBox.Value == true;
                    if v49 then
                        l_Use_0 = v27.KnifeUse;
                        l_Cooldown_0 = v27.KnifeCooldown;
                    end;
                    for _, v51 in pairs(v27:GetChildren()) do
                        v51.Visible = false;
                    end;
                    local l_KeyRequired_0 = v34:FindFirstChild("KeyRequired");
                    if l_KeyRequired_0 then
                        l_Cooldown_0 = v27.KeyRequired;
                        local l_Value_1 = l_KeyRequired_0.KeyType.Value;
                        local l_Value_2 = l_KeyRequired_0.KeyColor.Value;
                        l_Cooldown_0.UseText.Text = "Need " .. l_Value_1 .. "!";
                        local v55 = false;
                        local l_FirstChild_0 = game.Players.LocalPlayer.Character:FindFirstChild(l_Value_1);
                        if l_FirstChild_0 and l_FirstChild_0.KeyColor.Value == l_Value_2 then
                            v55 = true;
                        end;
                        l_Value_0 = not v55;
                    end;
                    l_Use_0.Visible = not l_Value_0;
                    l_Cooldown_0.Visible = l_Value_0;
                    if not v26 and not v49 then
                        if v34:FindFirstChild("UseName") then
                            l_Use_0.UseText.Text = v34.UseName.Value;
                        else
                            l_Use_0.UseText.Text = "Activate";
                        end;
                    elseif v21 ~= nil then
                        v21.Visible = not v49;
                        v21.Use.Visible = not l_Value_0;
                        v21.Cooldown.Visible = l_Value_0;
                        v22.Visible = v49;
                    end;
                    if v7 == false then
                        l_InteractGUI_0.Enabled = true;
                        v6:Cancel();
                        v5:Play();
                    end;
                else
                    v1 = nil;
                    if v7 == true then
                        v6:Play();
                        v5:Cancel();
                    end;
                    if v21 ~= nil then
                        v21.Visible = false;
                        v22.Visible = false;
                    end;
                end;
                v7 = l_InteractGUI_0.Enabled;
                return;
            end;
        end;
    end;
end);
local v57 = time();
local function v61(_, v59, _)
    if (l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Keyboard or l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Gamepad1 or l_UserInputService_0:GetLastInputType() == Enum.UserInputType.Gamepad2) and v59 ~= Enum.UserInputState.Begin then
        return;
    else
        if v1 and time() - v57 >= 0.1 then
            if v1:FindFirstChild("KnifeBox") and v1.KnifeBox.Value == true then
                return;
            else
                v1.Interact:FireServer();
                v57 = time();
                if v1:FindFirstChild("InteractClient") then
                    v1.InteractClient:Fire();
                end;
            end;
        end;
        return;
    end;
end;
game:GetService("ContextActionService"):BindAction("InteractKey", v61, false, Enum.KeyCode.F);
game:GetService("ContextActionService"):BindAction("InteractGamepadButton", v61, false, Enum.KeyCode.ButtonY);
l_TouchInteractButtons_0.Phone.TouchInteract.Activated:connect(v61);
l_TouchInteractButtons_0.Tablet.TouchInteract.Activated:connect(v61);