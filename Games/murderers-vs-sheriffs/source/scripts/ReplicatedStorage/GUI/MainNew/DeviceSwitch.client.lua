-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_Keyboard_0 = l_Parent_0:WaitForChild("Keyboard");
local l_Gamepad_0 = l_Parent_0:WaitForChild("Gamepad");
local l_UserInputService_0 = game:GetService("UserInputService");
local v4 = nil;
local v5 = {
    Keyboard = false, 
    Gamepad = false
};
local v6 = {
    [Enum.UserInputType.Keyboard] = "Keyboard", 
    [Enum.UserInputType.MouseMovement] = "Keyboard", 
    [Enum.UserInputType.Gamepad1] = "Gamepad", 
    [Enum.UserInputType.Gamepad2] = "Gamepad", 
    [Enum.UserInputType.Gamepad3] = "Gamepad", 
    [Enum.UserInputType.Gamepad4] = "Gamepad"
};
local function v8(_)

end;
local function _(v9)
    if not v5[v9] then
        v5[v9] = true;
    end;
end;
local function _(v11)
    if v4 ~= v11 and not v5[v11] then
        v5[v11] = true;
    end;
    v4 = v11;
end;
local function _()
    local l_l_UserInputService_0_LastInputType_0 = l_UserInputService_0:GetLastInputType();
    if v6[l_l_UserInputService_0_LastInputType_0] then
        local v14 = v6[l_l_UserInputService_0_LastInputType_0];
        if v4 ~= v14 and not v5[v14] then
            v5[v14] = true;
        end;
        v4 = v14;
    end;
end;
local function _()
    l_Keyboard_0.Visible = v4 == "Keyboard";
    l_Gamepad_0.Visible = v4 == "Gamepad";
end;
local function v19()
    local l_l_UserInputService_0_LastInputType_1 = l_UserInputService_0:GetLastInputType();
    if v6[l_l_UserInputService_0_LastInputType_1] then
        local v18 = v6[l_l_UserInputService_0_LastInputType_1];
        if v4 ~= v18 and not v5[v18] then
            v5[v18] = true;
        end;
        v4 = v18;
    end;
    l_Keyboard_0.Visible = v4 == "Keyboard";
    l_Gamepad_0.Visible = v4 == "Gamepad";
end;
local function _()
    local l_l_UserInputService_0_LastInputType_2 = l_UserInputService_0:GetLastInputType();
    if v6[l_l_UserInputService_0_LastInputType_2] then
        local v21 = v6[l_l_UserInputService_0_LastInputType_2];
        if v4 ~= v21 and not v5[v21] then
            v5[v21] = true;
        end;
        v4 = v21;
    end;
    l_Keyboard_0.Visible = v4 == "Keyboard";
    l_Gamepad_0.Visible = v4 == "Gamepad";
    l_UserInputService_0.LastInputTypeChanged:Connect(v19);
end;
local l_l_UserInputService_0_LastInputType_3 = l_UserInputService_0:GetLastInputType();
if v6[l_l_UserInputService_0_LastInputType_3] then
    local v24 = v6[l_l_UserInputService_0_LastInputType_3];
    if v4 ~= v24 and not v5[v24] then
        v8(v24);
        v5[v24] = true;
    end;
    v4 = v24;
end;
l_Keyboard_0.Visible = v4 == "Keyboard";
l_Gamepad_0.Visible = v4 == "Gamepad";
l_UserInputService_0.LastInputTypeChanged:Connect(v19);