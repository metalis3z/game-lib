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
    v3:_Init();

    return v3;
end;

function u1.SetDividerSpacing(p4, p5) -- Line: 20
    p4:ResizeYSize(p5);
    p4.Background.Size = UDim2.new(1, 0, 1 / p5, 0);
end;

function u1._Setup(p6) -- Line: 29
    p6.Background.ImageTransparency = 0.25;
    p6.BackgroundGradient.Enabled = false;
    p6.DetailsDisplayTitleText.FontFace = Font.fromId(12187365977, Enum.FontWeight.ExtraBold);
    p6.Container.Position = UDim2.new(0, 0, 1, 0);
    p6.Container.AnchorPoint = Vector2.new(0, 1);
    p6.DetailsDisplayTitleContainer.Size = UDim2.new(p6.DetailsDisplayTitleContainer.Size.X.Scale, p6.DetailsDisplayTitleContainer.Size.X.Offset, p6.DetailsDisplayTitleContainer.Size.Y.Scale * 1.5, p6.DetailsDisplayTitleContainer.Size.Y.Offset * 1.5);
    p6.SettingFrame.Size = UDim2.new(p6.SettingFrame.Size.X.Scale, p6.SettingFrame.Size.X.Offset, p6.SettingFrame.Size.Y.Scale * 0.84, p6.SettingFrame.Size.Y.Offset * 0.84);
    p6.DetailsDisplayTitleContainer.Position = UDim2.new(0.0125, 0, 0.5, 0);
end;

function u1._Init(p7) -- Line: 40
    p7:_Setup();
end;

return u1;