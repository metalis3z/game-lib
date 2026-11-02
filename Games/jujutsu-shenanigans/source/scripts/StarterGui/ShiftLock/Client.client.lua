local _ = Enum.KeyCode.ButtonR2;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_GuiService_0 = game:GetService("GuiService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_TouchEnabled_0 = l_UserInputService_0.TouchEnabled;
local v6 = l_GuiService_0:IsTenFootInterface();
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local v8 = CFrame.new(1.75, 0, 0);
--local l_BillboardGui_0 = script.BillboardGui;
--l_BillboardGui_0.Parent = workspace.Cutscenes.Billboard;
--l_BillboardGui_0.Enabled = true;
local v10 = nil;
local _ = l_LocalPlayer_0:GetMouse();
local function v25()
    local v12 = nil;
    local v13 = 100;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_PrimaryPart_0 = l_Character_0.PrimaryPart;
    if not l_Character_0 then
        return ;
    else
        local v17 = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2);
        for _, v19 in pairs(workspace.Live:children()) do
            if v19 ~= l_Character_0 then
                local l_PrimaryPart_1 = v19.PrimaryPart;
                if v19 and v19:FindFirstChild("Humanoid") and v19.Humanoid.Health ~= 0 and l_PrimaryPart_1 then
                    local v21 = l_CurrentCamera_0:WorldToViewportPoint(v19.HumanoidRootPart.Position);
                    local l_magnitude_0 = (Vector2.new(v21.X, v21.Y) - v17).magnitude;
                    local l_magnitude_1 = (l_PrimaryPart_1.Position - l_PrimaryPart_0.Position).magnitude;
                    local _ = (l_PrimaryPart_0.Position - l_PrimaryPart_1.Position).magnitude;
                    if l_magnitude_0 < v13 and l_magnitude_1 <= 100 then
                        v12 = v19;
                        v13 = l_magnitude_0;
                    end;
                end;
            end;
        end;
        return v12;
    end;
end;
if not (not l_TouchEnabled_0 and not v6) or l_UserInputService_0.GamepadEnabled then
    local _ = script.ImageLabel;
    if v6 or l_UserInputService_0.GamepadEnabled then
        l_UserInputService_0.InputBegan:Connect(function(v27, v28)
            if v28 then
                return ;
            else
                if v27.KeyCode == Enum.KeyCode.ButtonL3 then
                    local v29 = v25();
                    local v30 = v29 and v29.PrimaryPart;
                    if v10 or not v30 then
                        v10 = nil;
                     --   l_BillboardGui_0.Adornee = nil;
                        return ;
                    else
                        v10 = v29;
                    --    l_BillboardGui_0.Adornee = v30;
                    end;
                end;
                return ;
            end;
        end);
        local v31 = "Xbox";
        if l_UserInputService_0:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" then
            v31 = "PS";
        end;
        script[v31].Parent = script.Parent;
    end;
    local function v41()
        local l_CurrentCamera_1 = workspace.CurrentCamera;
        if l_CurrentCamera_1 and l_CurrentCamera_1.CameraType ~= Enum.CameraType.Scriptable and not l_LocalPlayer_0:GetAttribute("NoShiftlock") then
            if (l_CurrentCamera_1.Focus.Position - l_CurrentCamera_1.CFrame.Position).Magnitude >= 0.99 then
                local l_CFrame_0 = l_CurrentCamera_1.CFrame;
                local v34 = false;
                if v10 and v10.Parent then
                    local l_PrimaryPart_2 = v10.PrimaryPart;
                    if l_PrimaryPart_2 then
                        if (l_PrimaryPart_2.Position - l_CurrentCamera_1.CFrame.Position).magnitude > 165 then
                            v10 = nil;
                       --     l_BillboardGui_0.Adornee = nil;
                        elseif not v10:FindFirstChild("BeingGrabbed") then
                            v34 = true;
                            l_CFrame_0 = CFrame.new(l_CFrame_0.Position + Vector3.new(0, 0.75, 0, 0), l_PrimaryPart_2.Position) * CFrame.new(0.35, 0, 0);
                        end;
                    else
                     --   l_BillboardGui_0.Adornee = nil;
                        v10 = nil;
                    end;
                else
                    v10 = nil;
                --    l_BillboardGui_0.Adornee = nil;
                end;
                if l_LocalPlayer_0:GetAttribute("S_ShiftLock") or v34 then
                    l_UserGameSettings_0.RotationType = Enum.RotationType.CameraRelative;
                    local v36 = l_CFrame_0 * v8;
                    local v37 = CFrame.fromMatrix(l_CurrentCamera_1.Focus.Position, l_CurrentCamera_1.CFrame.RightVector, l_CurrentCamera_1.CFrame.UpVector) * v8;
                    local v38 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.PrimaryPart;
                    local l_Magnitude_0 = (v38.Position - v36.Position).Magnitude;
                    local l_Magnitude_1 = (v38.Position - v37.Position).Magnitude;
                    if l_Magnitude_0 ~= l_Magnitude_0 then
                        l_Magnitude_0 = 2000000000;
                    end;
                    if l_Magnitude_1 ~= l_Magnitude_1 then
                        l_Magnitude_1 = 2000000000;
                    end;
                    if v36 == v36 and v37 == v37 and (not v38 or l_Magnitude_0 < 2000 and l_Magnitude_1 < 2000) then
                        l_CurrentCamera_1.CFrame = v36;
                        l_CurrentCamera_1.Focus = v37;
                        return ;
                    end;
                else
                    l_UserGameSettings_0.RotationType = Enum.RotationType.MovementRelative;
                    return ;
                end;
            end;
        else
            l_UserGameSettings_0.RotationType = Enum.RotationType.MovementRelative;
        end;
    end;
    l_RunService_0:BindToRenderStep("ShiftlockMobile", Enum.RenderPriority.Camera.Value + 1, v41);
else
 --   l_BillboardGui_0.Enabled = false;
end;