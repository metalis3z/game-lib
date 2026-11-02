-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"));
local EmoteWheel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteWheel"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: Page (copy), u1 (copy), EmoteWheel (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.EmoteWheelSlotsFrame = v3.PageFrame:WaitForChild("EmoteWheelSlots");
    v3.EmoteSlotContainer = v3.PageFrame:WaitForChild("EmoteSlotContainer");
    v3.HidePartyDisplay = true;
    v3.EmoteWheel = EmoteWheel.new();
    v3._emote_name = nil;
    v3._emote_slot = nil;
    v3._just_picked = nil;
    v3:_Init();

    return v3;
end;

function u1.GetDefaultElement(p4) -- Line: 38
    return nil;
end;

function u1.SetEmoteName(p5, p6) -- Line: 42
    -- upvalues: CosmeticSlot (copy)
    if p5._emote_slot then
        p5._emote_slot:Destroy();
        p5._emote_slot = nil;
    end;

    p5._emote_name = p6;

    if p5._emote_name then
        p5._emote_slot = CosmeticSlot.new(p5._emote_name);
        p5._emote_slot:SetInteractable(false);
        p5._emote_slot.Frame.Parent = p5.EmoteSlotContainer;
        p5:_UpdateEmoteSlotPosition();
    end;
end;

function u1.PickEmoteKey(p7, p8) -- Line: 58
    -- upvalues: PlayerDataController (copy), EmoteController (copy)
    if not p7._is_open or p7._just_picked then
        return;
    end;

    if not (p8 and p7._emote_name) then
        p7:CloseRequest();

        return;
    end;

    local v9 = PlayerDataController:Get("EquippedEmotes")[p8];
    local v10;

    if v9 and v9.Name == p7._emote_name then
        v10 = nil;
    else
        v10 = p7._emote_name;
    end;

    EmoteController:EquipEmote(p8, v10);
end;

function u1.Open(p11, ...) -- Line: 95
    -- upvalues: Page (copy)
    Page.Open(p11, ...);
    p11.EmoteWheel:SetEnabled(true);
    p11.EmoteWheel:StartInputs(true);
    p11._just_picked = nil;
end;

function u1.Close(p12, ...) -- Line: 102
    -- upvalues: Page (copy)
    p12._just_picked = nil;
    p12.EmoteWheel:StopInputs();
    p12.EmoteWheel:SetEnabled(false);
    Page.Close(p12, ...);
end;

function u1._UpdateEmoteSlotPosition(p13) -- Line: 113
    if not p13._emote_slot then
        return;
    end;

    local LastHighlightedSlot = p13.EmoteWheel:GetLastHighlightedSlot();
    local v14;

    if LastHighlightedSlot then
        v14 = (LastHighlightedSlot:GetContainerPosition() - (p13.EmoteSlotContainer.AbsolutePosition + p13.EmoteSlotContainer.AbsoluteSize / 2)).Unit;
    else
        v14 = Vector2.zero;
    end;

    p13._emote_slot.Frame:TweenPosition(UDim2.new(0.5 + v14.X, 0, 0.5 + v14.Y, 0), "Out", "Quint", 0.25, true);
end;

function u1._Setup(p15) -- Line: 125
    p15.EmoteWheel.Frame.Parent = p15.EmoteWheelSlotsFrame;
end;

function u1._Init(u16) -- Line: 129
    -- upvalues: ButtonEffect (copy)
    u16.CloseButton.MouseButton1Click:Connect(function() -- Line: 130
        -- upvalues: u16 (copy)
        u16:CloseRequest();
    end);
    u16.EmoteWheel.EmoteKeyPicked:Connect(function(p17) -- Line: 134
        -- upvalues: ButtonEffect (ref), u16 (copy)
        ButtonEffect:ClickSound();
        u16:PickEmoteKey(p17);
    end);
    u16.EmoteWheel.EmoteWheelSlotHighlighted:Connect(function(p18) -- Line: 139
        -- upvalues: u16 (copy)
        u16:_UpdateEmoteSlotPosition();
    end);
    u16:_Setup();
    u16:_UpdateEmoteSlotPosition();
    ButtonEffect:Add(u16.CloseButton);
end;

return u1._new();