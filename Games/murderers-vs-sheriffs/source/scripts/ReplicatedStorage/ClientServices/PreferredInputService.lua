-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local v3 = game:GetService("RunService"):IsStudio();
local v4 = nil;
local v5 = nil;
local v6 = {
    Small = "Small", 
    Medium = "Medium", 
    Large = "Large"
};
local v7 = {
    KeyboardAndMouse = "KeyboardAndMouse", 
    Gamepad = "Gamepad", 
    Touch = "Touch"
};
v0.DeviceUpdated = Instance.new("BindableEvent");
v0.GetDeviceInfo = function(_) --[[ Line: 22 ]] --[[ Name: GetDeviceInfo ]]
    -- upvalues: v4 (ref), v5 (ref)
    return v4, v5;
end;
local function _() --[[ Line: 26 ]] --[[ Name: updateScreenSize ]]
    -- upvalues: l_GuiService_0 (copy), v5 (ref), v6 (copy)
    if l_GuiService_0:IsTenFootInterface() then
        v5 = v6.Large;
        return;
    elseif workspace.CurrentCamera.ViewportSize.Y >= 600 then
        v5 = v6.Medium;
        return;
    else
        v5 = v6.Small;
        return;
    end;
end;
local function v11() --[[ Line: 40 ]] --[[ Name: onPreferredInputChanged ]]
    -- upvalues: l_GuiService_0 (copy), v5 (ref), v6 (copy), l_UserInputService_0 (copy), v3 (copy), v4 (ref), v7 (copy), v0 (copy)
    if l_GuiService_0:IsTenFootInterface() then
        v5 = v6.Large;
    elseif workspace.CurrentCamera.ViewportSize.Y >= 600 then
        v5 = v6.Medium;
    else
        v5 = v6.Small;
    end;
    local l_PreferredInput_0 = l_UserInputService_0.PreferredInput;
    if v3 and l_UserInputService_0.TouchEnabled then
        v4 = v7.Touch;
    elseif l_PreferredInput_0 == Enum.PreferredInput.KeyboardAndMouse then
        v4 = v7.KeyboardAndMouse;
    elseif l_PreferredInput_0 == Enum.PreferredInput.Gamepad then
        v4 = v7.Gamepad;
    elseif l_PreferredInput_0 == Enum.PreferredInput.Touch then
        v4 = v7.Touch;
    end;
    v0.DeviceUpdated:Fire();
end;
local function _() --[[ Line: 58 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_UserInputService_0 (copy), v11 (copy)
    l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v11);
    v11();
end;
l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v11);
v11();
return v0;