-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.MobileInputs = p2;
    v3.Frame = v3.MobileInputs.Frame:WaitForChild("JoystickArea");
    v3._hooked = false;
    v3._touch_gui = nil;
    v3._joystick_frame = nil;
    v3._joystick_original_position = nil;
    v3._joystick_original_anchor_point = nil;
    v3._joystick_left_handed_position = nil;
    v3._joystick_left_handed_anchor_point = nil;
    v3:_Init();

    return v3;
end;

function u1._Update(p4) -- Line: 40
    -- upvalues: PlayerDataController (copy), UILibrary (copy)
    p4.Frame.Visible = p4._hooked and p4.MobileInputs.EditorEnabled;

    if not p4.Frame.Visible then
        return;
    end;

    local Setting = PlayerDataController:GetSetting("Left Handed Touch Controls");
    p4._joystick_frame.Position = Setting and p4._joystick_left_handed_position or p4._joystick_original_position;
    p4._joystick_frame.AnchorPoint = Setting and p4._joystick_left_handed_anchor_point or p4._joystick_original_anchor_point;
    local Vector2_new_ret = Vector2.new(math.clamp(p4._joystick_frame.AbsolutePosition.X + (p4._touch_gui.AbsolutePosition.X - UILibrary.MainGui.AbsolutePosition.X), 0, p4.Frame.AbsoluteSize.X), (math.clamp(p4._joystick_frame.AbsolutePosition.Y + (p4._touch_gui.AbsolutePosition.Y - UILibrary.MainGui.AbsolutePosition.Y), 0, p4.Frame.AbsoluteSize.Y)));
    local Vector2_new_ret2 = Vector2.new(p4._joystick_frame.AbsolutePosition.X + p4._joystick_frame.AbsoluteSize.X - Vector2_new_ret.X, p4._joystick_frame.AbsolutePosition.Y + p4._joystick_frame.AbsoluteSize.Y - Vector2_new_ret.Y);
    p4.Frame.Position = UDim2.new(0, Vector2_new_ret.X, 0, Vector2_new_ret.Y);
    p4.Frame.Size = UDim2.new(0, Vector2_new_ret2.X, 0, Vector2_new_ret2.Y);
end;

function u1._HookTouchGui(u5) -- Line: 68
    -- upvalues: Utility (copy), Players (copy)
    local v6 = Utility:SilentWaitForChild(Players.LocalPlayer:WaitForChild("PlayerGui"), "TouchGui");
    local DynamicThumbstickFrame = v6:WaitForChild("TouchControlFrame"):WaitForChild("DynamicThumbstickFrame");
    u5._hooked = true;
    u5._touch_gui = v6;
    u5._joystick_frame = DynamicThumbstickFrame;
    u5._joystick_original_position = u5._joystick_frame.Position;
    u5._joystick_original_anchor_point = u5._joystick_frame.AnchorPoint;
    u5._joystick_left_handed_position = UDim2.new(1 - u5._joystick_original_position.X.Scale, -u5._joystick_original_position.X.Offset, u5._joystick_original_position.Y.Scale, u5._joystick_original_position.Y.Offset);
    u5._joystick_left_handed_anchor_point = Vector2.new(1 - u5._joystick_original_anchor_point.X, u5._joystick_original_anchor_point.Y);
    u5._touch_gui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 81
        -- upvalues: u5 (copy)
        u5:_Update();
    end);
    u5._joystick_frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 85
        -- upvalues: u5 (copy)
        u5:_Update();
    end);
    u5._joystick_frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 89
        -- upvalues: u5 (copy)
        u5:_Update();
    end);
    u5:_Update();
    task.spawn(function() -- Line: 97
        -- upvalues: DynamicThumbstickFrame (copy)
        local ThumbstickStart = DynamicThumbstickFrame:WaitForChild("ThumbstickStart");
        ThumbstickStart:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 100, Name: update
            -- upvalues: ThumbstickStart (copy)
            ThumbstickStart.Visible = false;
        end);
        ThumbstickStart.Visible = false;
    end);
end;

function u1._Setup(p7) -- Line: 109
    p7.Frame.AnchorPoint = Vector2.zero;
end;

function u1._Init(u8) -- Line: 113
    -- upvalues: UILibrary (copy), PlayerDataController (copy)
    u8.MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 114
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    u8.MobileInputs.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 118
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    u8.MobileInputs.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 122
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 126
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    PlayerDataController:GetSettingChangedSignal("Left Handed Touch Controls"):Connect(function() -- Line: 130
        -- upvalues: u8 (copy)
        u8:_Update();
    end);
    u8:_Setup();
    u8:_Update();
    task.defer(u8._HookTouchGui, u8);
end;

return u1;