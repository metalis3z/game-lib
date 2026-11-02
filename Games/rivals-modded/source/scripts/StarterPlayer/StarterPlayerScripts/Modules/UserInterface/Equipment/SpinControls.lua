-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.MouseDownChanged = Signal.new();
    v3.Equipment = p2;
    v3._connections = {};
    v3._frame = Instance.new("ImageButton");
    v3._is_mouse_down = nil;
    v3._last_position = nil;
    v3._velocity = Vector2.zero;
    v3._rad = Vector2.zero;
    v3._last_state = nil;
    v3._start_resetting = nil;
    v3:_Init();

    return v3;
end;

function u1.IsMouseDown(p4) -- Line: 40
    return p4._is_mouse_down;
end;

function u1.GetCFrame(p5) -- Line: 44
    return CFrame.Angles(0, p5._rad.X, 0) * CFrame.Angles(p5._rad.Y, 0, 0);
end;

function u1.Update(p6, p7) -- Line: 48
    if p6._velocity.Magnitude > 0.001 or p6._is_mouse_down then
        p6._start_resetting = tick() + 0;
        p6._velocity = p6._velocity * 0.975;
        p6:_Increment(p6._velocity);

        return;
    end;

    if p6._start_resetting and tick() <= p6._start_resetting then
        return;
    end;

    if p6._rad.X < -3.141592653589793 then
        p6._rad = Vector2.new(p6._rad.X + 6.283185307179586, p6._rad.Y);
    elseif p6._rad.X > 3.141592653589793 then
        p6._rad = Vector2.new(p6._rad.X - 6.283185307179586, p6._rad.Y);
    end;

    if p6._rad.Y < -3.141592653589793 then
        p6._rad = Vector2.new(p6._rad.X, p6._rad.Y + 6.283185307179586);
    elseif p6._rad.Y > 3.141592653589793 then
        p6._rad = Vector2.new(p6._rad.X, p6._rad.Y - 6.283185307179586);
    end;

    local v8;

    if p6._start_resetting then
        local v9 = ((tick() - p6._start_resetting) / 4) ^ 2;
        v8 = math.clamp(v9, 0, 1);
    else
        v8 = 1;
    end;

    p6._rad = p6._rad * (1 - v8 * 0.05);
end;

function u1.OnStateChanged(p10) -- Line: 77
    p10:_CheckResetSpin();
end;

function u1.OnOpen(p11) -- Line: 81
    -- upvalues: UILibrary (copy)
    p11._frame.Parent = p11.Equipment.IsOpen and UILibrary.MainGui or nil;
    p11:_VerifyControls();
end;

function u1._CheckResetSpin(p12) -- Line: 90
    local StateID = p12.Equipment:GetStateID();

    if StateID == p12._last_state then
        return;
    end;

    p12._last_state = StateID;
    p12._velocity = Vector2.zero;
    p12._rad = Vector2.zero;
end;

function u1._IsDisabled(p13) -- Line: 102
    -- upvalues: PlayerDataController (copy)
    local SelectedWeapon = p13.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if SelectedWeapon then
        SelectedWeapon = not WeaponData;
    end;

    return SelectedWeapon;
end;

function u1._GetMouseLocation(p14) -- Line: 109
    -- upvalues: UILibrary (copy)
    return UILibrary:GetMouseLocation();
end;

function u1._Increment(p15, p16) -- Line: 113
    p15._rad = p15._rad + p16;
    p15._rad = Vector2.new(p15._rad.X % 6.283185307179586, p15._rad.Y % 6.283185307179586);
end;

function u1._VerifyControls(u17) -- Line: 118
    -- upvalues: ControlsController (copy), UserInputService (copy)
    for _, v in pairs(u17._connections) do
        v:Disconnect();
    end;

    u17._connections = {};

    if not u17.Equipment.IsOpen then
        return;
    end;

    u17._last_position = nil;
    u17._velocity = Vector2.zero;
    u17._is_mouse_down = nil;
    u17.MouseDownChanged:Fire();

    local function sanity_check(p18) -- Line: 134
        -- upvalues: ControlsController (ref), u17 (copy)
        if ControlsController.CurrentControls == "Touch" then
            return p18 ~= u17._is_mouse_down;
        end;

        return not u17._is_mouse_down;
    end;

    table.insert(u17._connections, u17._frame.InputBegan:Connect(function(p19) -- Line: 142
        -- upvalues: u17 (copy)
        if u17:_IsDisabled() or u17._is_mouse_down then
            return;
        end;

        if p19.UserInputType == Enum.UserInputType.MouseButton1 or (p19.UserInputType == Enum.UserInputType.MouseButton2 or p19.UserInputType == Enum.UserInputType.Touch) then
            u17._last_position = nil;
            u17._velocity = Vector2.zero;
            u17._is_mouse_down = p19;
            u17.MouseDownChanged:Fire();
        end;
    end));
    table.insert(u17._connections, UserInputService.InputEnded:Connect(function(p20) -- Line: 155
        -- upvalues: ControlsController (ref), u17 (copy)
        local v21;

        if ControlsController.CurrentControls == "Touch" then
            v21 = p20 ~= u17._is_mouse_down;
        else
            v21 = not u17._is_mouse_down;
        end;

        if v21 then
            return;
        end;

        if p20.UserInputType == Enum.UserInputType.MouseButton1 or (p20.UserInputType == Enum.UserInputType.MouseButton2 or p20.UserInputType == Enum.UserInputType.Touch) then
            u17._is_mouse_down = nil;
            u17.MouseDownChanged:Fire();

            if u17._last_position then
                u17._velocity = (u17:_GetMouseLocation() - u17._last_position) / 400;
            end;
        end;
    end));
    table.insert(u17._connections, UserInputService.InputChanged:Connect(function(p22) -- Line: 170
        -- upvalues: ControlsController (ref), u17 (copy)
        local v23;

        if ControlsController.CurrentControls == "Touch" then
            v23 = p22 ~= u17._is_mouse_down;
        else
            v23 = not u17._is_mouse_down;
        end;

        if v23 then
            return;
        end;

        local v24 = u17:_GetMouseLocation();

        if u17._last_position then
            u17:_Increment((v24 - u17._last_position) / 800 * (ControlsController.CurrentControls == "Touch" and 3 or 1));
        end;

        u17._last_position = v24;
    end));
end;

function u1._Setup(p25) -- Line: 185
    p25._frame.Name = "EquipmentSpinControls";
    p25._frame.AnchorPoint = Vector2.new(0.5, 0.5);
    p25._frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    p25._frame.Size = UDim2.new(1, 0, 1, 0);
    p25._frame.Image = "";
    p25._frame.BackgroundTransparency = 1;
    p25._frame.ZIndex = -1000;
    p25._frame.Visible = true;
end;

function u1._Init(p26) -- Line: 196
    p26:_Setup();
end;

return u1;