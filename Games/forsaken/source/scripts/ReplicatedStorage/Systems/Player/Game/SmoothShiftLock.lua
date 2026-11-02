-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Maid_0 = require(script:WaitForChild("Maid"));
local l_Spring_0 = require(script:WaitForChild("Spring"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v10 = {
    SMOOTH_CHARACTER_ROTATION = true, 
    CHARACTER_ROTATION_SPEED = 3, 
    TRANSITION_SPRING_DAMPER = 0.75, 
    CAMERA_TRANSITION_IN_SPEED = 15, 
    CAMERA_TRANSITION_OUT_SPEED = 25, 
    LOCKED_CAMERA_OFFSET = Vector3.new(1.75, 0.5, 0, 0), 
    LOCKED_MOUSE_ICON = "rbxasset://textures/MouseLockedCursor.png"
};
v0.Start = function(v11) --[[ Line: 51 ]] --[[ Name: Start ]]
    -- upvalues: l_Maid_0 (copy), l_Spring_0 (copy), v10 (copy), l_LocalPlayer_0 (copy)
    v11._runtimeMaid = l_Maid_0.new();
    v11._shiftlockMaid = l_Maid_0.new();
    v11._cameraOffsetSpring = l_Spring_0.new((Vector3.new(0, 0, 0, 0)));
    v11._cameraOffsetSpring.Damper = v10.TRANSITION_SPRING_DAMPER;
    v11.Enabled = false;
    v11.ShiftlockBinded = false;
    v11:Enable();
    l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 66 ]]
        -- upvalues: v11 (copy)
        if v11.MobileButton then
            v11.MobileButton.Size = script.ShiftLockButton.Size;
            v11.MobileButton.Position = script.ShiftLockButton.Position;
            v11.MobileButton.AnchorPoint = script.ShiftLockButton.AnchorPoint;
        end;
    end);
end;
v0.BindKeybinds = function(v12) --[[ Line: 75 ]] --[[ Name: BindKeybinds ]]
    -- upvalues: l_ContextActionService_0 (copy), l_LocalPlayer_0 (copy)
    l_ContextActionService_0:UnbindAction("ShiftLockSwitchAction");
    local v13 = {};
    local l_Keybinds_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Settings"):WaitForChild("Keybinds");
    for _, v16 in pairs({
        l_Keybinds_0:WaitForChild("ShiftLock").Value, 
        l_Keybinds_0:WaitForChild("ShiftLock~Console").Value
    }) do
        for _, v18 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v18.Name == v16 then
                table.insert(v13, v18);
                break;
            end;
        end;
        for _, v20 in pairs(Enum.UserInputType:GetEnumItems()) do
            if v20.Name == v16 then
                table.insert(v13, v20);
                break;
            end;
        end;
    end;
    l_ContextActionService_0:BindActionAtPriority("ShiftLockSwitchAction", function(v21, v22, v23) --[[ Line: 94 ]]
        -- upvalues: v12 (copy)
        return v12:_doShiftLockSwitch(v21, v22, v23);
    end, false, Enum.ContextActionPriority.Medium.Value, unpack(v13));
    if not v12.MobileButton then
        local v24 = script.ShiftLockButton:Clone();
        v24.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
        v12.MobileButton = v24;
        v24.MouseButton1Down:Connect(function() --[[ Line: 106 ]]
            -- upvalues: v24 (copy), v12 (copy)
            v24.ImageColor3 = Color3.new(0.75, 0.75, 0.75);
            v12:_doShiftLockSwitch(nil, Enum.UserInputState.Begin);
        end);
        v24.MouseButton1Up:Connect(function() --[[ Line: 111 ]]
            -- upvalues: v24 (copy)
            v24.ImageColor3 = Color3.new(1, 1, 1);
        end);
        local v25 = require(game.ReplicatedStorage.Modules.Device);
        local function v26() --[[ Line: 117 ]] --[[ Name: toggleButton ]]
            -- upvalues: v25 (copy), v24 (copy)
            v24.Visible = v25:GetPlayerDevice() == "Mobile";
        end;
        v24.Visible = v25:GetPlayerDevice() == "Mobile";
        v25.Changed:Connect(v26);
    end;
end;
v0.Enable = function(v27) --[[ Line: 129 ]] --[[ Name: Enable ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy), l_RunService_0 (copy), l_CurrentCamera_0 (copy), l_UserInputService_0 (copy)
    v27:_refreshCharacterVariables();
    v27._runtimeMaid:GiveTask(l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 131 ]]
        -- upvalues: v27 (copy)
        v27:_refreshCharacterVariables();
    end));
    v0:BindKeybinds();
    v27._runtimeMaid:GiveTask(l_RunService_0.RenderStepped:Connect(function() --[[ Line: 139 ]]
        -- upvalues: v27 (copy), l_CurrentCamera_0 (ref), l_UserInputService_0 (ref)
        if not v27.Character:GetAttribute("CustomRig") and v27.Head.LocalTransparencyModifier > 0.6 then
            return;
        elseif l_CurrentCamera_0.CameraType ~= Enum.CameraType.Custom then
            return;
        else
            local l_CoordinateFrame_0 = l_CurrentCamera_0.CoordinateFrame;
            if (v27.Head.Position - l_CoordinateFrame_0.p).magnitude > 1 then
                l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v27._cameraOffsetSpring.Position);
                if v27.Enabled and l_UserInputService_0.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                    v27:_updateMouseState();
                end;
            end;
            return;
        end;
    end));
end;
v0.Disable = function(v29) --[[ Line: 158 ]] --[[ Name: Disable ]]
    -- upvalues: l_ContextActionService_0 (copy)
    v29._runtimeMaid:DoCleaning();
    v29._shiftlockMaid:DoCleaning();
    l_ContextActionService_0:UnbindAction("ShiftLockSwitchAction");
end;
v0._refreshCharacterVariables = function(v30) --[[ Line: 167 ]] --[[ Name: _refreshCharacterVariables ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v30.Character = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    v30.RootPart = v30.Character:WaitForChild("HumanoidRootPart");
    v30.Humanoid = v30.Character:WaitForChild("Humanoid");
    v30.Head = v30.Character:WaitForChild("Head");
end;
v0._doShiftLockSwitch = function(v31, _, v33) --[[ Line: 175 ]] --[[ Name: _doShiftLockSwitch ]]
    if v33 == Enum.UserInputState.Begin then
        v31:ToggleShiftLock();
        return Enum.ContextActionResult.Sink;
    else
        return Enum.ContextActionResult.Pass;
    end;
end;
v0._updateMouseState = function(v34) --[[ Line: 185 ]] --[[ Name: _updateMouseState ]]
    -- upvalues: l_UserInputService_0 (copy)
    l_UserInputService_0.MouseBehavior = v34.Enabled and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default;
end;
v0._updateMouseIcon = function(v35) --[[ Line: 190 ]] --[[ Name: _updateMouseIcon ]]
    -- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), v10 (copy)
    l_l_LocalPlayer_0_Mouse_0.Icon = v35.Enabled and v10.LOCKED_MOUSE_ICON or "";
end;
v0._transitionLockOffset = function(v36) --[[ Line: 195 ]] --[[ Name: _transitionLockOffset ]]
    -- upvalues: v10 (copy)
    if v36.Enabled then
        v36._cameraOffsetSpring.Speed = v10.CAMERA_TRANSITION_IN_SPEED;
        v36._cameraOffsetSpring.Target = v10.LOCKED_CAMERA_OFFSET;
        return;
    else
        v36._cameraOffsetSpring.Speed = v10.CAMERA_TRANSITION_OUT_SPEED;
        v36._cameraOffsetSpring.Target = Vector3.new(0, 0, 0, 0);
        return;
    end;
end;
v0.IsEnabled = function(v37) --[[ Line: 206 ]] --[[ Name: IsEnabled ]]
    return v37.Enabled;
end;
v0.ToggleShiftLock = function(v38, v39) --[[ Line: 211 ]] --[[ Name: ToggleShiftLock ]]
    -- upvalues: l_RunService_0 (copy), v10 (copy), l_CurrentCamera_0 (copy)
    if v39 ~= nil then
        v38.Enabled = v39;
    else
        v38.Enabled = not v38.Enabled;
    end;
    v38:_updateMouseState();
    v38:_updateMouseIcon();
    v38:_transitionLockOffset();
    if v38.Enabled then
        v38._shiftlockMaid:GiveTask(l_RunService_0.RenderStepped:Connect(function(v40) --[[ Line: 222 ]]
            -- upvalues: v38 (copy), v10 (ref), l_CurrentCamera_0 (ref)
            if v38.Humanoid and v38.RootPart then
                v38.Humanoid.AutoRotate = not v38.Enabled;
            end;
            if v38.Humanoid.Sit then
                return;
            elseif v38.RootPart.Anchored then
                return;
            elseif v38.Character:GetAttribute("Ragdolling") then
                return;
            elseif v10.SMOOTH_CHARACTER_ROTATION then
                local _, v42, _ = l_CurrentCamera_0.CFrame:ToOrientation();
                v38.RootPart.CFrame = v38.RootPart.CFrame:Lerp(CFrame.new(v38.RootPart.Position) * CFrame.Angles(0, v42, 0), v40 * 5 * v10.CHARACTER_ROTATION_SPEED);
                return;
            else
                local _, v45, _ = l_CurrentCamera_0.CFrame:ToOrientation();
                v38.RootPart.CFrame = CFrame.new(v38.RootPart.Position) * CFrame.Angles(0, v45, 0);
                return;
            end;
        end));
        return;
    else
        v38.Humanoid.AutoRotate = true;
        v38._shiftlockMaid:DoCleaning();
        return;
    end;
end;
return v0;