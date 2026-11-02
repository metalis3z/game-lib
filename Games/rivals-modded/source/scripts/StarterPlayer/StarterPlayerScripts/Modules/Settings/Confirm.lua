-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local SettingSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"));
local u1 = setmetatable({}, SettingSlot);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: SettingSlot (copy), u1 (copy)
    local v2 = SettingSlot.new(...);
    local v3 = setmetatable(v2, u1);
    v3.GreenFrame = v3.ControlsConfirmButton:WaitForChild("Green");
    v3.RedFrame = v3.ControlsConfirmButton:WaitForChild("Red");
    v3:_Init();

    return v3;
end;

function u1.SetConfirmColor(p4, p5) -- Line: 23
    p4.GreenFrame.Visible = p5 == "Green";
    p4.RedFrame.Visible = p5 == "Red";
end;

function u1._Confirm(p6) -- Line: 32
    p6:SetValue(not p6.Value, nil, true);
end;

function u1._Setup(p7) -- Line: 36
    p7.ControlsConfirmButton.Size = UDim2.new(1.538, 0, 0.625, 0);
    p7.ControlsConfirmButton.Position = UDim2.new(-0.03, 0, 0.5, 0);
end;

function u1._Init(p8) -- Line: 41
    p8:_Setup();
end;

return u1;