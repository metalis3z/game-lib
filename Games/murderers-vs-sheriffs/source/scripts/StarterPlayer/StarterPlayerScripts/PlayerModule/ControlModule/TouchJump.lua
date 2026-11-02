-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_GuiService_0 = game:GetService("GuiService");
local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local v3 = require(l_CommonUtils_0:WaitForChild("FlagUtil")).getUserFlag("UserUpdateTouchJump");
local v4 = nil;
local v5 = nil;
if v3 then
    v4 = require(l_CommonUtils_0:WaitForChild("ConnectionUtil"));
    v5 = require(l_CommonUtils_0:WaitForChild("CharacterUtil"));
end;
local v6 = {
    HUMANOID_STATE_ENABLED_CHANGED = "HUMANOID_STATE_ENABLED_CHANGED", 
    HUMANOID_JUMP_POWER = "HUMANOID_JUMP_POWER", 
    HUMANOID = "HUMANOID", 
    JUMP_INPUT_ENDED = "JUMP_INPUT_ENDED", 
    MENU_OPENED = "MENU_OPENED"
};
local l_BaseCharacterController_0 = require(script.Parent:WaitForChild("BaseCharacterController"));
local v8 = setmetatable({}, l_BaseCharacterController_0);
v8.__index = v8;
v8.new = function()
    local v9 = setmetatable(l_BaseCharacterController_0.new(), v8);
    v9.parentUIFrame = nil;
    v9.jumpButton = nil;
    if not v3 then
        v9.characterAddedConn = nil;
        v9.humanoidStateEnabledChangedConn = nil;
        v9.humanoidJumpPowerConn = nil;
        v9.humanoidParentConn = nil;
        v9.jumpPower = 0;
        v9.jumpStateEnabled = true;
        v9.humanoid = nil;
    end;
    v9.externallyEnabled = false;
    v9.isJumping = false;
    if v3 then
        v9._connectionUtil = v4.new();
    end;
    return v9;
end;
if v3 then
    v8._reset = function(v10)
        v10.isJumping = false;
        v10.touchObject = nil;
        if v10.jumpButton then
            v10.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
    end;
end;
v8.EnableButton = function(v11, v12)
    if v3 then
        if v12 then
            if not v11.jumpButton then
                v11:Create();
            end;
            v11.jumpButton.Visible = true;
            v11._connectionUtil:trackConnection(v6.JUMP_INPUT_ENDED, v11.jumpButton.InputEnded:Connect(function(v13)
                if v13 == v11.touchObject then
                    v11:_reset();
                end;
            end));
            v11._connectionUtil:trackConnection(v6.MENU_OPENED, l_GuiService_0.MenuOpened:Connect(function()
                if v11.touchObject then
                    v11:_reset();
                end;
            end));
        else
            if v11.jumpButton then
                v11.jumpButton.Visible = false;
            end;
            v11._connectionUtil:disconnect(v6.JUMP_INPUT_ENDED);
            v11._connectionUtil:disconnect(v6.MENU_OPENED);
        end;
        v11:_reset();
        return;
    else
        if v12 then
            if not v11.jumpButton then
                v11:Create();
            end;
            local v14 = l_Players_0.LocalPlayer.Character and l_Players_0.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
            if v14 and v11.externallyEnabled and v11.externallyEnabled and v14.JumpPower > 0 then
                v11.jumpButton.Visible = true;
                return;
            end;
        else
            v11.jumpButton.Visible = false;
            v11.touchObject = nil;
            v11.isJumping = false;
            v11.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
        return;
    end;
end;
v8.UpdateEnabled = function(v15)
    if v3 then
        local v16 = v5.getChild("Humanoid", "Humanoid");
        if v16 and v15.externallyEnabled and v16.JumpPower > 0 and v16:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
            v15:EnableButton(true);
            return;
        else
            v15:EnableButton(false);
            return;
        end;
    elseif v15.jumpPower > 0 and v15.jumpStateEnabled then
        v15:EnableButton(true);
        return;
    else
        v15:EnableButton(false);
        return;
    end;
end;
if v3 then
    v8._setupConfigurations = function(v17)
        local function v18()
            v17:UpdateEnabled();
        end;
        local v20 = v5.onChild("Humanoid", "Humanoid", function(v19)
            v17:UpdateEnabled();
            v17._connectionUtil:trackConnection(v6.HUMANOID_JUMP_POWER, v19:GetPropertyChangedSignal("JumpPower"):Connect(v18));
            v17._connectionUtil:trackConnection(v6.HUMANOID_STATE_ENABLED_CHANGED, v19.StateEnabledChanged:Connect(v18));
        end);
        v17._connectionUtil:trackConnection(v6.HUMANOID, v20);
    end;
end;
if not v3 then
    v8.HumanoidChanged = function(v21, v22)
        local v23 = l_Players_0.LocalPlayer.Character and l_Players_0.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        if v23 then
            if v22 == "JumpPower" then
                v21.jumpPower = v23.JumpPower;
                v21:UpdateEnabled();
                return;
            elseif v22 == "Parent" and not v23.Parent then
                v21.humanoidChangeConn:Disconnect();
            end;
        end;
    end;
    v8.HumanoidStateEnabledChanged = function(v24, v25, v26)
        if v25 == Enum.HumanoidStateType.Jumping then
            v24.jumpStateEnabled = v26;
            v24:UpdateEnabled();
        end;
    end;
    v8.CharacterAdded = function(v27, v28)
        if v27.humanoidChangeConn then
            v27.humanoidChangeConn:Disconnect();
            v27.humanoidChangeConn = nil;
        end;
        v27.humanoid = v28:FindFirstChildOfClass("Humanoid");
        while not v27.humanoid do
            v28.ChildAdded:wait();
            v27.humanoid = v28:FindFirstChildOfClass("Humanoid");
        end;
        v27.humanoidJumpPowerConn = v27.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
            v27.jumpPower = v27.humanoid.JumpPower;
            v27:UpdateEnabled();
        end);
        v27.humanoidParentConn = v27.humanoid:GetPropertyChangedSignal("Parent"):Connect(function()
            if not v27.humanoid.Parent then
                v27.humanoidJumpPowerConn:Disconnect();
                v27.humanoidJumpPowerConn = nil;
                v27.humanoidParentConn:Disconnect();
                v27.humanoidParentConn = nil;
            end;
        end);
        v27.humanoidStateEnabledChangedConn = v27.humanoid.StateEnabledChanged:Connect(function(v29, v30)
            v27:HumanoidStateEnabledChanged(v29, v30);
        end);
        v27.jumpPower = v27.humanoid.JumpPower;
        v27.jumpStateEnabled = v27.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping);
        v27:UpdateEnabled();
    end;
    v8.SetupCharacterAddedFunction = function(v31)
        v31.characterAddedConn = l_Players_0.LocalPlayer.CharacterAdded:Connect(function(v32)
            v31:CharacterAdded(v32);
        end);
        if l_Players_0.LocalPlayer.Character then
            v31:CharacterAdded(l_Players_0.LocalPlayer.Character);
        end;
    end;
end;
v8.Enable = function(v33, v34, v35)
    if v35 then
        v33.parentUIFrame = v35;
    end;
    v33.externallyEnabled = v34;
    if v3 then
        v33:UpdateEnabled();
        if v34 then
            v33:_setupConfigurations();
            return;
        else
            v33._connectionUtil:disconnectAll();
            return;
        end;
    else
        v33:EnableButton(v34);
        return;
    end;
end;
v8.Create = function(v36)
    if not v36.parentUIFrame then
        return;
    else
        if v36.jumpButton then
            v36.jumpButton:Destroy();
            v36.jumpButton = nil;
        end;
        if v36.absoluteSizeChangedConn then
            v36.absoluteSizeChangedConn:Disconnect();
            v36.absoluteSizeChangedConn = nil;
        end;
        v36.jumpButton = Instance.new("ImageButton");
        v36.jumpButton.Name = "JumpButton";
        v36.jumpButton.Visible = false;
        v36.jumpButton.BackgroundTransparency = 1;
        v36.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        v36.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        v36.jumpButton.ImageRectSize = Vector2.new(144, 144);
        local function v39()
            local v37 = math.min(v36.parentUIFrame.AbsoluteSize.x, v36.parentUIFrame.AbsoluteSize.y) <= 500;
            local v38 = v37 and 70 or 120;
            v36.jumpButton.Size = UDim2.new(0, v38, 0, v38);
            v36.jumpButton.Position = v37 and UDim2.new(1, -(v38 * 1.5 - 10), 1, -v38 - 20) or UDim2.new(1, -(v38 * 1.5 - 10), 1, -v38 * 1.75);
        end;
        v39();
        v36.absoluteSizeChangedConn = v36.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v39);
        v36.touchObject = nil;
        v36.jumpButton.InputBegan:connect(function(v40)
            if v36.touchObject or v40.UserInputType ~= Enum.UserInputType.Touch or v40.UserInputState ~= Enum.UserInputState.Begin then
                return;
            else
                v36.touchObject = v40;
                v36.jumpButton.ImageRectOffset = Vector2.new(146, 146);
                v36.isJumping = true;
                return;
            end;
        end);
        if not v3 then
            local function _()
                v36.touchObject = nil;
                v36.isJumping = false;
                v36.jumpButton.ImageRectOffset = Vector2.new(1, 146);
            end;
            v36.jumpButton.InputEnded:connect(function(v42)
                if v42 == v36.touchObject then
                    v36.touchObject = nil;
                    v36.isJumping = false;
                    v36.jumpButton.ImageRectOffset = Vector2.new(1, 146);
                end;
            end);
            l_GuiService_0.MenuOpened:connect(function()
                if v36.touchObject then
                    v36.touchObject = nil;
                    v36.isJumping = false;
                    v36.jumpButton.ImageRectOffset = Vector2.new(1, 146);
                end;
            end);
            if not v36.characterAddedConn then
                v36:SetupCharacterAddedFunction();
            end;
        end;
        v36.jumpButton.Parent = v36.parentUIFrame;
        return;
    end;
end;
return v8;