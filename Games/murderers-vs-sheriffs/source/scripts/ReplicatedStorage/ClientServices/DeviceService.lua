-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = Vector2.new(768, 1024);
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("RunService");
local l_GuiService_0 = game:GetService("GuiService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_KeybindImages_0 = require(script:WaitForChild("KeybindImages"));
local v8 = {
    Large = "Large", 
    Medium = "Medium", 
    Small = "Small"
};
local v9 = {};
local l_Medium_0 = v8.Medium;
local l_KeyboardAndMouse_0 = Enum.PreferredInput.KeyboardAndMouse;
local v12 = nil;
local function _() --[[ Line: 23 ]] --[[ Name: GetScreenSize ]]
    if l_GuiService_0:IsTenFootInterface() then
        return v8.Large;
    elseif l_l_LocalPlayer_0_Mouse_0.ViewSizeX >= v0.X and l_l_LocalPlayer_0_Mouse_0.ViewSizeY >= v0.Y then
        return v8.Medium;
    else
        return v8.Small;
    end;
end;
local function v18() --[[ Line: 33 ]] --[[ Name: onPreferredInputChanged ]]
    l_KeyboardAndMouse_0 = l_UserInputService_0.PreferredInput;
    if l_KeyboardAndMouse_0 == Enum.PreferredInput.Touch and v12 == nil then
        task.spawn(function() --[[ Line: 37 ]]
            v12 = l_LocalPlayer_0.PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton").Size == UDim2.new(0, 120, 0, 120);
        end);
    end;
    if l_KeyboardAndMouse_0 == Enum.PreferredInput.KeyboardAndMouse then
        for _, v15 in (l_CollectionService_0:GetTagged("KeybindIcon")) do
            v15.Image = l_KeybindImages_0.KeyboardButton;
            v15.TextLabel.Visible = true;
        end;
        return;
    else
        if l_KeyboardAndMouse_0 == Enum.PreferredInput.Gamepad then
            for _, v17 in (l_CollectionService_0:GetTagged("KeybindIcon")) do
                v17.Image = l_KeybindImages_0[l_UserInputService_0:GetStringForKeyCode(v17:GetAttribute("Keybind_Gamepad"))];
                v17.TextLabel.Visible = false;
            end;
        end;
        return;
    end;
end;
v9.IsMobileDevice = function(_) --[[ Line: 62 ]] --[[ Name: IsMobileDevice ]]
    return l_KeyboardAndMouse_0 == Enum.PreferredInput.Touch;
end;
v9.GetDeviceInfo = function(_) --[[ Line: 66 ]] --[[ Name: GetDeviceInfo ]]
    return l_KeyboardAndMouse_0, l_Medium_0;
end;
local function _() --[[ Line: 70 ]] --[[ Name: onInitialize ]]
    l_Medium_0 = if l_GuiService_0:IsTenFootInterface() then v8.Large else if l_l_LocalPlayer_0_Mouse_0.ViewSizeX >= v0.X and l_l_LocalPlayer_0_Mouse_0.ViewSizeY >= v0.Y then v8.Medium else v8.Small;
    v18();
    l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v18);
end;
l_Medium_0 = if l_GuiService_0:IsTenFootInterface() then v8.Large else if l_l_LocalPlayer_0_Mouse_0.ViewSizeX >= v0.X and l_l_LocalPlayer_0_Mouse_0.ViewSizeY >= v0.Y then v8.Medium else v8.Small;
v18();
l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v18);
return v9;