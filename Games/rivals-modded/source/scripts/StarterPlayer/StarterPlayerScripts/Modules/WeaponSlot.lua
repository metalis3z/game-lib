-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local VoteBanFrame = require(Players.LocalPlayer.PlayerScripts.Modules.VoteBanFrame);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local WeaponSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("WeaponSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy), WeaponSlot (copy)
    local v4 = setmetatable({}, u1);
    v4.PlayBanFrameSound = Signal.new();
    v4.Name = p2;
    v4.WeaponData = p3;
    v4.Frame = WeaponSlot:Clone();
    v4._destroyed = false;
    v4._vote_ban_frame = nil;
    v4:_Init();

    return v4;
end;

function u1.DisableButton(p5) -- Line: 37
    p5.Frame.Button.Interactable = false;
end;

function u1.ToggleBanned(u6, p7, p8) -- Line: 41
    -- upvalues: VoteBanFrame (copy)
    u6.Frame.Button.Icon.ClipsDescendants = true;
    u6.Frame.Button.Title.Visible = false;
    local v9 = VoteBanFrame.new(u6.Frame.Button, UDim2.new(0.75, 0, 0.75, 0));
    v9.CreateSound:Connect(function(...) -- Line: 47
        -- upvalues: u6 (copy)
        u6.PlayBanFrameSound:Fire(...);
    end);
    task.delay(p7, v9.Play, v9, p8, true);
end;

function u1.HideName(p10) -- Line: 54
    p10.Frame.Button.Title.Text = "???";
end;

function u1.Lock(p11) -- Line: 58
    p11.Frame.Button.Locked.Visible = true;
    p11.Frame.Button.Title.TextTransparency = 0.5;
    p11.Frame.Button.Icon.Picture.ImageColor3 = Color3.fromRGB(0, 0, 0);
    p11.Frame.Button.Icon.Picture.ImageTransparency = 0.5;
end;

function u1.Destroy(u12) -- Line: 65
    if u12._destroyed then
        return;
    end;

    u12._destroyed = true;
    u12.PlayBanFrameSound:Destroy();

    if u12._vote_ban_frame then
        u12._vote_ban_frame:Destroy();
    end;

    pcall(function() -- Line: 78
        -- upvalues: u12 (copy)
        u12.Frame:Destroy();
    end);
end;

function u1._Setup(p13) -- Line: 87
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    p13.Frame.Button.Title.Text = p13.Name;
    p13.Frame.Button.Icon.Picture.Image = p13.WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(p13.WeaponData) or (ItemLibrary:GetViewModelImage(p13.Name) or "");
    WeaponStatusHandler:ApplyItemStatusToBackground(p13.Frame.Button.Background, p13.Frame.Button.Background.UIStroke, ItemLibrary.Items[p13.Name].Status);
end;

function u1._Init(u14) -- Line: 93
    -- upvalues: ButtonEffect (copy)
    u14.Frame.Destroying:Connect(function() -- Line: 94
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
    u14:_Setup();
    ButtonEffect:Add(u14.Frame.Button);
end;

return u1;