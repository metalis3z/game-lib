-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local LockedMapSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LockedMapSlot");
local u1 = {
    ReleaseRatio = 1.025,
    HoverRatio = 1.025
};
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 13
    -- upvalues: u2 (copy), LockedMapSlot (copy)
    local v5 = setmetatable({}, u2);
    v5.Name = p3;
    v5.Frame = LockedMapSlot:Clone();
    v5._ignore_button_effect = p4;
    v5:_Init();

    return v5;
end;

function u2.SetParent(p6, p7) -- Line: 30
    p6.Frame.Parent = p7;
end;

function u2.Destroy(p8) -- Line: 34
    p8.Frame:Destroy();
end;

function u2._Setup(p9) -- Line: 42
    -- upvalues: DuelLibrary (copy), ButtonEffect (copy), u1 (copy)
    local v10 = DuelLibrary.MapDifficulties[DuelLibrary.Maps[p9.Name].Difficulty];
    local _, _, v11 = v10.Color:ToHSV();
    p9.Frame.Button.Background.ImageColor3 = v11 < 0.1 and Color3.fromRGB(31, 31, 31) or Color3.fromRGB(0, 0, 0);
    p9.Frame.Button.Background.Texture.ImageColor3 = v10.Color;
    p9.Frame.Button.Difficulty.BackgroundColor3 = v10.Color;
    p9.Frame.Button.Difficulty.ImageColor3 = v10.Color;
    p9.Frame.Button.Difficulty.UIStroke.Color = v10.Color;
    p9.Frame.Button.DifficultyVignette.ImageColor3 = v10.Color;

    if not p9._ignore_button_effect then
        ButtonEffect:Add(p9.Frame.Button, nil, u1);
    end;
end;

function u2._Init(p12) -- Line: 59
    p12:_Setup();
end;

return u2;