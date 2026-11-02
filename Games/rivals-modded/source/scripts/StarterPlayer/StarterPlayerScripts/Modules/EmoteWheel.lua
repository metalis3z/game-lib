-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EmoteWheelSlot = require(script:WaitForChild("EmoteWheelSlot"));
local EmoteWheel = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmoteWheel");
local u1 = 6.283185307179586 / CONSTANTS.MAX_EQUIPPABLE_EMOTES;
local u2 = u1 * -0.5;
local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 22
    -- upvalues: u3 (copy), Signal (copy), EmoteWheel (copy)
    local v4 = setmetatable({}, u3);
    v4.EmoteKeyPicked = Signal.new();
    v4.EmoteWheelSlotHighlighted = Signal.new();
    v4.Frame = EmoteWheel:Clone();
    v4._is_enabled = false;
    v4._connections = {};
    v4._input_connections = {};
    v4._emote_wheel_slots = {};
    v4._finish_picking_bindable = nil;
    v4._last_highlighted_wheel_slot = nil;
    v4._generate_hash = 0;
    v4:_Init();

    return v4;
end;

function u3.GetLastHighlightedSlot(p5) -- Line: 47
    return p5._last_highlighted_wheel_slot;
end;

function u3.GetEmoteWheelSlot(p6, p7) -- Line: 51
    return p6._emote_wheel_slots[p7];
end;

function u3.GetEmoteSlotFromScreenPosition(p8, p9, p10) -- Line: 55
    -- upvalues: UILibrary (copy), u1 (copy), u2 (copy)
    local v11 = p9 or UILibrary:GetMouseLocation();
    local v12 = p8.Frame.AbsolutePosition + p8.Frame.AbsoluteSize / 2;

    if (v11 - v12).Magnitude <= p8.Frame.AbsoluteSize.X * 0.1 then
        return;
    end;

    local v13 = math.atan2(v11.Y - v12.Y, v11.X - v12.X) + 1.5707963267948966;
    local v14 = { v13 - 6.283185307179586, v13, v13 + 6.283185307179586 };

    for i, v in pairs(p8._emote_wheel_slots) do
        if v.EquippedData or p10 then
            local v15 = v;
            local v16 = i;

            for _, v2 in pairs(v14) do
                local v17 = tonumber(v16);

                if u1 * (v17 - 1) + u2 <= v2 and v2 < u1 * v17 + u2 then
                    return v15, v16;
                end;
            end;
        end;
    end;
end;

function u3.SetEnabled(u18, p19) -- Line: 83
    -- upvalues: PlayerDataController (copy)
    u18:_Clear();
    u18._is_enabled = p19;

    if not u18._is_enabled then
        return;
    end;

    local _connections = u18._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("EquippedEmotes");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 92
        -- upvalues: u18 (copy)
        u18:_Generate();
    end));
    task.spawn(u18._Generate, u18, true);
end;

function u3.HighlightSlot(p20, p21) -- Line: 99
    p20._last_highlighted_wheel_slot = p21;

    for _, v in pairs(p20._emote_wheel_slots) do
        v:SetHighlighted(v == p20._last_highlighted_wheel_slot);
    end;

    p20.EmoteWheelSlotHighlighted:Fire();
end;

function u3.StopInputs(p22) -- Line: 109
    for _, v in pairs(p22._input_connections) do
        v:Disconnect();
    end;

    p22._input_connections = {};

    if p22._finish_picking_bindable then
        p22._finish_picking_bindable:Destroy();
        p22._finish_picking_bindable = nil;
    end;

    p22:HighlightSlot(nil);
end;

function u3.FinishInputs(p23) -- Line: 124
    if p23._finish_picking_bindable then
        p23._finish_picking_bindable:Fire();
    end;
end;

function u3.StartInputs(u24, u25) -- Line: 130
    -- upvalues: UserInputService (copy), ControlsController (copy), RunService (copy), GamepadService (copy), UILibrary (copy)
    u24:StopInputs();
    u24._finish_picking_bindable = Instance.new("BindableEvent");
    local u26 = nil;
    local u27 = false;
    u24._finish_picking_bindable.Event:Connect(function() -- Line: 138, Name: finish
        -- upvalues: u24 (copy), u26 (ref), u25 (copy)
        local EmoteSlotFromScreenPosition, EmoteSlotFromScreenPosition = u24:GetEmoteSlotFromScreenPosition(u26, u25);

        if EmoteSlotFromScreenPosition then
            if not u25 then
                local EquippedData = EmoteSlotFromScreenPosition.EquippedData;

                if not EquippedData then
                    EmoteSlotFromScreenPosition = EquippedData;
                end;
            end;
        end;

        u24.EmoteKeyPicked:Fire(EmoteSlotFromScreenPosition);
    end);

    local function set_last_mouse_location(p28, p29) -- Line: 147
        -- upvalues: u24 (copy), u25 (copy), u26 (ref)
        local EmoteSlotFromScreenPosition, _ = u24:GetEmoteSlotFromScreenPosition(p28, u25);

        if not EmoteSlotFromScreenPosition and p29 then
            return;
        end;

        u26 = p28;
        u24:HighlightSlot(EmoteSlotFromScreenPosition);
    end;

    table.insert(u24._input_connections, UserInputService.InputBegan:Connect(function(p30) -- Line: 158
        -- upvalues: u27 (ref)
        if p30.UserInputType == Enum.UserInputType.MouseButton1 or (p30.UserInputType == Enum.UserInputType.Touch or p30.KeyCode == Enum.KeyCode.ButtonA) then
            u27 = true;
        end;
    end));
    table.insert(u24._input_connections, UserInputService.InputEnded:Connect(function(p31) -- Line: 164
        -- upvalues: u27 (ref), u24 (copy), u26 (ref), u25 (copy)
        if (p31.UserInputType == Enum.UserInputType.MouseButton1 or (p31.UserInputType == Enum.UserInputType.Touch or p31.KeyCode == Enum.KeyCode.ButtonA)) and u27 then
            local EmoteSlotFromScreenPosition, EmoteSlotFromScreenPosition = u24:GetEmoteSlotFromScreenPosition(u26, u25);

            if EmoteSlotFromScreenPosition then
                if not u25 then
                    local EquippedData = EmoteSlotFromScreenPosition.EquippedData;

                    if not EquippedData then
                        EmoteSlotFromScreenPosition = EquippedData;
                    end;
                end;
            end;

            u24.EmoteKeyPicked:Fire(EmoteSlotFromScreenPosition);
        end;
    end));
    table.insert(u24._input_connections, UserInputService.InputChanged:Connect(function(p32) -- Line: 172
        -- upvalues: ControlsController (ref), u24 (copy), u25 (copy), u26 (ref)
        if ControlsController.CurrentControls ~= "Gamepad" then
            return;
        end;

        if p32.KeyCode == Enum.KeyCode.Thumbstick1 or p32.KeyCode == Enum.KeyCode.Thumbstick2 then
            local v33 = u24:_ThumbstickPositionToScreenPosition(p32.Position);
            local EmoteSlotFromScreenPosition, _ = u24:GetEmoteSlotFromScreenPosition(v33, u25);

            if not EmoteSlotFromScreenPosition then
                return;
            end;

            u26 = v33;
            u24:HighlightSlot(EmoteSlotFromScreenPosition);
        end;
    end));
    table.insert(u24._input_connections, RunService.RenderStepped:Connect(function() -- Line: 182
        -- upvalues: ControlsController (ref), GamepadService (ref), UILibrary (ref), u24 (copy), u25 (copy), u26 (ref)
        if ControlsController.CurrentControls == "Gamepad" then
            if GamepadService.GamepadCursorEnabled then
                GamepadService:DisableGamepadCursor();
            end;

            return;
        end;

        local MouseLocation, v34 = UILibrary:GetMouseLocation();
        local EmoteSlotFromScreenPosition, _ = u24:GetEmoteSlotFromScreenPosition(MouseLocation, u25);

        if not EmoteSlotFromScreenPosition and v34 then
            return;
        end;

        u26 = MouseLocation;
        u24:HighlightSlot(EmoteSlotFromScreenPosition);
    end));
end;

function u3.Destroy(p35) -- Line: 195
    p35:_Clear();
    p35:SetEnabled(false);
    p35:StopInputs();
    p35.Frame:Destroy();
    p35.EmoteKeyPicked:Destroy();
    p35.EmoteWheelSlotHighlighted:Destroy();
end;

function u3._NormalizeAngle(p36, p37) -- Line: 209
    if p37 < 0 then
        return p37 + 6.283185307179586;
    end;

    if p37 > 6.283185307179586 then
        p37 = p37 - 6.283185307179586;
    end;

    return p37;
end;

function u3._ThumbstickPositionToScreenPosition(p38, p39) -- Line: 219
    local v40 = p38.Frame.AbsolutePosition + p38.Frame.AbsoluteSize / 2;

    if p39.Magnitude <= 0.5 then
        return v40;
    end;

    return v40 + Vector2.new(p39.X, -p39.Y) * 1000;
end;

function u3._ClearSlots(p41) -- Line: 229
    for _, v in pairs(p41._emote_wheel_slots) do
        v:Destroy();
    end;

    p41._emote_wheel_slots = {};
end;

function u3._Clear(p42) -- Line: 237
    for _, v in pairs(p42._connections) do
        v:Disconnect();
    end;

    p42._connections = {};
    p42:_ClearSlots();
end;

function u3._Generate(p43, p44) -- Line: 246
    -- upvalues: PlayerDataController (copy), CONSTANTS (copy), EmoteWheelSlot (copy), u2 (copy)
    p43._generate_hash = p43._generate_hash + 1;
    local _generate_hash = p43._generate_hash;
    local v45 = {};

    for i, v in pairs(p43._emote_wheel_slots) do
        v45[i] = v.EquippedData and v.EquippedData.Name or nil;
    end;

    p43:_ClearSlots();
    local v46 = PlayerDataController:Get("EquippedEmotes");
    local v47 = 360 / CONSTANTS.MAX_EQUIPPABLE_EMOTES;

    for i = 1, CONSTANTS.MAX_EQUIPPABLE_EMOTES do
        if _generate_hash ~= p43._generate_hash then
            return;
        end;

        local v48 = tostring(i);
        local v49 = EmoteWheelSlot.new(v46[v48]);
        v49:SetRotation(v47 * 0.5 + (i - 1) * v47 + math.deg(u2));
        v49.Frame.Parent = p43.Frame.Slots;
        p43._emote_wheel_slots[v48] = v49;
        local v50;

        if p44 then
            v50 = i;
        else
            local v51;

            if v49.EquippedData then
                v51 = v49.EquippedData.Name or nil;
            else
                v51 = nil;
            end;

            if v45[v48] == v51 then
                v50 = i;
            else
                v49:EquipBounceEffect();
                task.defer(p43.HighlightSlot, p43, v49);
                v50 = i;
            end;
        end;
    end;
end;

function u3._Init(p52) -- Line: 281
end;

return u3;