-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = script.Parent.Parent;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(script.CONSTANTS);
local l_TAU_0 = v3.TAU;
local l_EX_OFFSET_0 = v3.EX_OFFSET;
local v6 = {
    [Enum.KeyCode.ButtonA] = true
};
local v7 = {
    [Enum.UserInputType.MouseButton1] = true, 
    [Enum.UserInputType.MouseMovement] = true, 
    [Enum.UserInputType.Touch] = true
};
local v8 = {
    [Enum.UserInputType.Gamepad1] = true, 
    [Enum.UserInputType.Gamepad2] = true, 
    [Enum.UserInputType.Gamepad3] = true, 
    [Enum.UserInputType.Gamepad4] = true, 
    [Enum.UserInputType.Gamepad5] = true, 
    [Enum.UserInputType.Gamepad6] = true, 
    [Enum.UserInputType.Gamepad7] = true, 
    [Enum.UserInputType.Gamepad8] = true
};
local v9 = require(script.CreateRadial);
local v10 = {};
v10.__index = v10;
v10.__type = "RadialMenu";
v10.__tostring = function(_) --[[ Line: 99 ]] --[[ Name: __tostring ]]
    -- upvalues: v10 (copy)
    return v10.__type;
end;
v10.new = function(v12, v13, v14) --[[ Line: 105 ]] --[[ Name: new ]]
    -- upvalues: v10 (copy), v9 (copy)
    local v15 = setmetatable({}, v10);
    v15._Maid = require(script.Maid).new();
    v15._ClickedBind = Instance.new("BindableEvent");
    v15._HoverBind = Instance.new("BindableEvent");
    v15._LastHoverIndex = nil;
    v15.Frame = v9(v12, v13, v14);
    v15.Rotation = v14;
    v15.SubN = v12;
    v15.Enabled = true;
    v15.DeadZoneIn = 0;
    v15.DeadZoneOut = 1e999;
    v15.Clicked = v15._ClickedBind.Event;
    v15.Hover = v15._HoverBind.Event;
    init(v15);
    v15:SetDialProps({
        ImageColor3 = Color3.new(0, 0, 0)
    });
    v15:SetRadialProps({
        ImageColor3 = Color3.new(0, 0, 0), 
        ImageTransparency = 0.7
    });
    return v15;
end;
local function _(v16, v17) --[[ Line: 137 ]] --[[ Name: shortestDist ]]
    -- upvalues: l_TAU_0 (copy)
    local v18 = (v17 - v16) % l_TAU_0;
    local v19 = 3.141592653589793 - math.abs(math.abs(v18) - 3.141592653589793);
    if (v18 + l_TAU_0) % l_TAU_0 < 3.141592653589793 then
        return v19;
    else
        return -v19;
    end;
end;
function init(v21) --[[ Line: 147 ]] --[[ Name: init ]]
    -- upvalues: l_UserInputService_0 (copy), v7 (copy), v8 (copy), v6 (copy), l_RunService_0 (copy), l_EX_OFFSET_0 (copy), l_TAU_0 (copy)
    local _ = v21.SubN;
    local l_RadialDial_0 = v21.Frame.RadialDial;
    local l_MouseMovement_0 = Enum.UserInputType.MouseMovement;
    v21._Maid:Mark(v21._ClickedBind);
    v21._Maid:Mark(v21._HoverBind);
    v21._Maid:Mark(l_UserInputService_0.LastInputTypeChanged:Connect(function(v25) --[[ Line: 156 ]]
        -- upvalues: v7 (ref), v8 (ref), l_MouseMovement_0 (ref)
        if v7[v25] or v8[v25] then
            l_MouseMovement_0 = v25;
        end;
    end));
    local v26 = 0;
    v21._Maid:Mark(l_UserInputService_0.InputBegan:Connect(function(v27) --[[ Line: 164 ]]
        -- upvalues: v21 (copy), v8 (ref), v6 (ref), v26 (ref)
        if not v21.Enabled then
            return;
        else
            if v8[v27.UserInputType] then
                if not v6[v27.KeyCode] then
                    return;
                else
                    v21._ClickedBind:Fire(v21:PickIndex(v26));
                end;
            end;
            local l_v21_Theta_0 = v21:GetTheta(v27.UserInputType);
            if l_v21_Theta_0 then
                v21._ClickedBind:Fire(v21:PickIndex(l_v21_Theta_0));
            end;
            return;
        end;
    end));
    v21._Maid:Mark(l_RunService_0.RenderStepped:Connect(function(_) --[[ Line: 184 ]]
        -- upvalues: v21 (copy), l_MouseMovement_0 (ref), v26 (ref), l_EX_OFFSET_0 (ref), l_TAU_0 (ref), l_RadialDial_0 (copy)
        if not v21.Enabled then
            return;
        else
            local l_v21_Theta_1 = v21:GetTheta(l_MouseMovement_0);
            if l_v21_Theta_1 and v21:IsVisible() then
                v26 = l_v21_Theta_1;
                local v31 = math.rad(v21.Frame.Rotation);
                local v32 = math.deg(l_v21_Theta_1 - v21.Rotation + v31 + l_EX_OFFSET_0 + 2 * l_TAU_0) % 360 / (360 / v21.SubN) + 0.5;
                l_RadialDial_0.Rotation = math.deg((v21:GetRotation(v32)));
                local v33 = v21:PickIndex(l_v21_Theta_1);
                if v33 ~= v21._LastHoverIndex then
                    v21._HoverBind:Fire(v21._LastHoverIndex, v33);
                    v21._LastHoverIndex = v33;
                end;
            end;
            return;
        end;
    end));
end;
v10.SetRadialProps = function(v34, v35) --[[ Line: 210 ]] --[[ Name: SetRadialProps ]]
    for _, v37 in next, v34.Frame.Radial:GetChildren() do
        for v38, v39 in next, v35 do
            v37[v38] = v39;
        end;
    end;
end;
v10.SetDialProps = function(v40, v41) --[[ Line: 218 ]] --[[ Name: SetDialProps ]]
    local l_RadialDial_1 = v40.Frame.RadialDial;
    for v43, v44 in next, v41 do
        l_RadialDial_1[v43] = v44;
    end;
end;
v10.GetTheta = function(v45, v46) --[[ Line: 225 ]] --[[ Name: GetTheta ]]
    -- upvalues: v7 (copy), l_UserInputService_0 (copy), v8 (copy)
    local v47 = nil;
    if v7[v46] then
        local l_Frame_0 = v45.Frame;
        local v49 = l_Frame_0.AbsoluteSize.y / 2;
        local v50 = l_Frame_0.AbsolutePosition + l_Frame_0.AbsoluteSize / 2;
        v47 = (l_UserInputService_0:GetMouseLocation() + Vector2.new(0, -36) - v50) / v49;
    elseif v8[v46] then
        local l_l_UserInputService_0_GamepadState_0 = l_UserInputService_0:GetGamepadState(v46);
        for _, v53 in next, l_l_UserInputService_0_GamepadState_0 do
            l_l_UserInputService_0_GamepadState_0[v53.KeyCode] = v53;
        end;
        v47 = l_l_UserInputService_0_GamepadState_0[Enum.KeyCode.Thumbstick2].Position * Vector3.new(1, -1, 1, 0);
    end;
    if v47 then
        local l_Magnitude_0 = v47.Magnitude;
        if v45.DeadZoneIn <= l_Magnitude_0 and l_Magnitude_0 <= v45.DeadZoneOut then
            return (math.atan2(v47.y, -v47.x));
        end;
    end;
end;
v10.PickIndex = function(v55, v56) --[[ Line: 250 ]] --[[ Name: PickIndex ]]
    -- upvalues: l_EX_OFFSET_0 (copy), l_TAU_0 (copy)
    local v57 = math.rad(v55.Frame.Rotation);
    return math.floor(math.deg(v56 - v55.Rotation + v57 + l_EX_OFFSET_0 + 2 * l_TAU_0) % 360 / (360 / v55.SubN)) + 1;
end;
v10.GetRotation = function(v58, v59) --[[ Line: 257 ]] --[[ Name: GetRotation ]]
    -- upvalues: l_TAU_0 (copy)
    return -l_TAU_0 * ((v59 - 1) / v58.SubN);
end;
v10.GetRadial = function(v60, v61) --[[ Line: 261 ]] --[[ Name: GetRadial ]]
    return v60.Frame.Radial[v61];
end;
v10.GetAttachment = function(v62, v63) --[[ Line: 265 ]] --[[ Name: GetAttachment ]]
    return v62.Frame.Attach[v63];
end;
v10.IsVisible = function(v64) --[[ Line: 269 ]] --[[ Name: IsVisible ]]
    local l_Frame_1 = v64.Frame;
    while true do
        if l_Frame_1 and l_Frame_1:IsA("GuiObject") and l_Frame_1.Visible then
            l_Frame_1 = l_Frame_1.Parent;
            if l_Frame_1 and l_Frame_1:IsA("ScreenGui") and l_Frame_1.Enabled then
                return true;
            end;
        else
            return false;
        end;
    end;
end;
v10.Destroy = function(v66) --[[ Line: 280 ]] --[[ Name: Destroy ]]
    if v66._Maid then
        v66._Maid:Sweep();
    end;
    if v66.Frame then
        v66.Frame:Destroy();
    end;
    v66.Clicked = nil;
    v66.Hover = nil;
    v66.Frame = nil;
end;
return v10;