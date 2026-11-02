-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local VoteBanFrame = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("VoteBanFrame");
local Color3_fromRGB_ret = Color3.fromRGB(255, 50, 50);
local Color3_fromRGB_ret2 = Color3.fromRGB(127, 25, 25);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 15
    -- upvalues: u1 (copy), Signal (copy), VoteBanFrame (copy)
    local v4 = setmetatable({}, u1);
    v4.CreateSound = Signal.new();
    v4.Frame = VoteBanFrame:Clone();
    v4.Icon = v4.Frame:WaitForChild("Icon");
    v4.Outline = v4.Frame:WaitForChild("Outline");
    v4.Background = v4.Frame:WaitForChild("Background");
    v4._parent = p2;
    v4._size = p3 or UDim2.new(1, 0, 1, 0);
    v4._played = false;
    v4:_Init();

    return v4;
end;

function u1.Play(p5, p6, p7) -- Line: 38
    -- upvalues: Color3_fromRGB_ret (copy), DuelLibrary (copy), Color3_fromRGB_ret2 (copy), TweenService (copy)
    if p5._played then
        return;
    end;

    p5._played = true;
    local v8 = not p6 and Color3_fromRGB_ret or DuelLibrary:GetTeamColor(p6);
    local Color3_new_ret = Color3.new(v8.R * 0.5, v8.G * 0.5, v8.B * 0.5);
    local v9 = p7 and v8 and v8 or Color3_fromRGB_ret;
    local v10 = p7 and Color3_new_ret and Color3_new_ret or Color3_fromRGB_ret2;

    if p7 then
        v8 = Color3_fromRGB_ret or v8;
    end;

    if p7 then
        Color3_new_ret = Color3_fromRGB_ret2 or Color3_new_ret;
    end;

    p5.Icon.ImageColor3 = v9;
    p5.Icon.Size = UDim2.new(1, -16, 1, -16);
    p5.Icon.Position = UDim2.new(0.5, 0, 0.4, 0);
    p5.Icon.Rotation = -45;
    p5.Outline.ImageColor3 = v9;
    p5.Outline.SliceScale = 0;
    p5.Background.ImageColor3 = v10;
    p5.Frame.Visible = true;
    TweenService:Create(p5.Icon, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Rotation = 0,
        Size = UDim2.new(0.75, -16, 0.75, -16),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play();
    TweenService:Create(p5.Icon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
        ImageColor3 = v8
    }):Play();
    TweenService:Create(p5.Outline, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        SliceScale = 0.375
    }):Play();
    TweenService:Create(p5.Outline, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
        ImageColor3 = v8
    }):Play();
    TweenService:Create(p5.Background, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
        ImageColor3 = Color3_new_ret
    }):Play();
    p5.CreateSound:Fire("rbxassetid://115599786018668", 0.75, 1.5, script, true, 5);
    p5.CreateSound:Fire("rbxassetid://101678983789054", 0.5, 1, script, true, 5);
end;

function u1.Destroy(p11) -- Line: 72
    p11._played = true;
    p11.Frame:Destroy();
end;

function u1._Setup(p12) -- Line: 81
    p12.Frame.Visible = false;
    p12.Frame.Size = p12._size;
    p12.Frame.Parent = p12._parent;
end;

function u1._Init(p13) -- Line: 87
    p13:_Setup();
end;

return u1;