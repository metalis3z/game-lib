-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ColorWheel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ColorPicker"):WaitForChild("ColorWheel"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: SettingSlot (copy), u1 (copy), Signal (copy), ColorWheel (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.SliderChanged = Signal.new();
    v3.EditButton = v3.ControlsSettingFrame:WaitForChild("Edit");
    v3.EditButtonBackground = v3.EditButton:WaitForChild("Background");
    v3.ColorWheelFrame = v3.ControlsSettingFrame:WaitForChild("ColorWheel");
    v3.ColorWheel = ColorWheel.new(v3.ColorWheelFrame);
    v3._close_connection = nil;
    v3._open_time = 0;
    v3._is_open = false;
    v3:_Init();

    return v3;
end;

function u1.SetOpen(u4, p5) -- Line: 40
    -- upvalues: UserInputService (copy), UILibrary (copy)
    local v6 = typeof(p5) == "boolean";
    assert(v6, "Argument 1 invalid, expected a boolean");
    u4._is_open = p5;
    u4.ColorWheelFrame.Visible = u4._is_open;
    u4.SettingFrame.ZIndex = u4._is_open and 999 or 1;
    u4.EditButton.Interactable = not u4._is_open;

    if u4._close_connection then
        u4._close_connection:Disconnect();
        u4._close_connection = nil;
    end;

    if u4._is_open then
        u4._open_time = tick();
        u4._close_connection = UserInputService.InputEnded:Connect(function(p7, p8) -- Line: 56
            -- upvalues: u4 (copy), UILibrary (ref)
            if tick() - u4._open_time < 0.25 or p7.UserInputType ~= Enum.UserInputType.MouseButton1 and (p7.UserInputType ~= Enum.UserInputType.Touch and p7.KeyCode ~= Enum.KeyCode.ButtonA) then
                return;
            end;

            if not UILibrary:IsMouseWithinBounds(u4.ColorWheelFrame.AbsolutePosition, u4.ColorWheelFrame.AbsoluteSize) then
                u4:SetOpen(false);
            end;
        end);
    end;
end;

function u1.SetAlwaysOpen(p9) -- Line: 68
    p9:SetOpen(true);
    p9.ColorWheelFrame.Position = UDim2.new(0.325, 0, 0, 0);
end;

function u1.Destroy(p10) -- Line: 73
    -- upvalues: SettingSlot (copy)
    p10.ColorWheel:Destroy();
    p10.SliderChanged:Destroy();
    SettingSlot.Destroy(p10);
end;

function u1._Update(p11) -- Line: 84
    -- upvalues: Utility (copy)
    p11.ColorWheel:SetStartingColor(p11.Value);
    p11.EditButtonBackground.ImageColor3 = Utility:Color3FromHex(p11.Value);
end;

function u1._Init(u12) -- Line: 89
    -- upvalues: ButtonEffect (copy)
    u12.Changed:Connect(function() -- Line: 90
        -- upvalues: u12 (copy)
        u12:_Update();
    end);
    u12.ColorWheel.Updated:Connect(function(p13, p14) -- Line: 94
        -- upvalues: u12 (copy)
        if p14 then
            u12:StoreValue(p13);
        else
            u12:SetValue(p13);
        end;

        u12.SliderChanged:Fire(p13);
    end);
    u12.EditButton.MouseButton1Click:Connect(function() -- Line: 104
        -- upvalues: u12 (copy)
        u12:SetOpen(not u12._is_open);
    end);
    u12:_Update();
    ButtonEffect:Add(u12.EditButton);
end;

return u1;