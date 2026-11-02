-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: SettingSlot (copy), u1 (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.DropdownContainer = v3.ControlsSettingFrame:WaitForChild("Container");
    v3.DropdownButton = v3.DropdownContainer:WaitForChild("Button");
    v3.DropdownText = v3.DropdownButton:WaitForChild("Title");
    v3._dropdown_slot = nil;
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 31
    -- upvalues: WeaponStatusHandler (copy), SettingSlot (copy)
    if p4._dropdown_slot then
        p4._dropdown_slot:Destroy();
    end;

    WeaponStatusHandler:ClearStatusElements(p4.DropdownText);
    SettingSlot.Destroy(p4);
end;

function u1._Update(p5) -- Line: 45
    -- upvalues: WeaponStatusHandler (copy), ItemLibrary (copy)
    p5.DropdownText.Text = p5.Value;
    p5.DropdownText.Position = UDim2.new(0.05, 0, 0.5, 0);
    WeaponStatusHandler:ClearStatusElements(p5.DropdownText);
    WeaponStatusHandler:ApplyItemStatusToText(p5.DropdownText, ItemLibrary.Items[p5.Value] and ItemLibrary.Items[p5.Value].Status);
end;

function u1._Init(u6) -- Line: 52
    -- upvalues: DropdownSlot (copy), ButtonEffect (copy)
    u6.Changed:Connect(function() -- Line: 53
        -- upvalues: u6 (copy)
        u6:_Update();
    end);
    u6.DropdownButton.MouseButton1Click:Connect(function() -- Line: 57
        -- upvalues: u6 (copy), DropdownSlot (ref)
        u6.DropdownButton.Visible = false;

        if u6._dropdown_slot then
            u6._dropdown_slot:Cancel();
            u6._dropdown_slot = nil;
        end;

        u6._dropdown_slot = DropdownSlot.new(u6.DropdownContainer, u6.SettingsInfo.Options);
        u6._dropdown_slot.Selected:Connect(function(p7) -- Line: 67
            -- upvalues: u6 (ref)
            u6.DropdownButton.Visible = true;

            if p7 then
                u6:InputValue(p7);
            end;

            u6._dropdown_slot = nil;
        end);
    end);
    u6:_Update();
    ButtonEffect:Add(u6.DropdownButton, nil, {
        ReleaseRatio = 1.025,
        HoverRatio = 1.025
    });
end;

return u1;