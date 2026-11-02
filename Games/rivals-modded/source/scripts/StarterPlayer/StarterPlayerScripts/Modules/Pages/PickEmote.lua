-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local EmoteController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"));
local EmoteWheel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteWheel"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 19
    -- upvalues: Page (copy), u1 (copy), EmoteWheel (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.EmoteWheelSlotsFrame = v3.PageFrame:WaitForChild("EmoteWheelSlots");
    v3.EmoteWheelSlotsButton = v3.EmoteWheelSlotsFrame:WaitForChild("AllEmotes");
    v3.EmoteWheelSlotsButtonMouseKeyboardKeybindFrame = v3.EmoteWheelSlotsButton:WaitForChild("Inputs"):WaitForChild("MouseKeyboard"):WaitForChild("Keybind");
    v3.EmoteWheelSlotsButtonGamepadKeybindFrame = v3.EmoteWheelSlotsButton:WaitForChild("Inputs"):WaitForChild("Gamepad"):WaitForChild("Keybind");
    v3.AllEmotesFrame = v3.PageFrame:WaitForChild("AllEmotes");
    v3.AllEmotesList = v3.AllEmotesFrame:WaitForChild("List");
    v3.AllEmotesContainer = v3.AllEmotesList:WaitForChild("Container");
    v3.AllEmotesLayout = v3.AllEmotesContainer:WaitForChild("Layout");
    v3.AllEmotesCentererFrame = v3.AllEmotesContainer:WaitForChild("Centerer");
    v3.AllEmotesHeaderFrame = v3.AllEmotesContainer:WaitForChild("Header");
    v3.AllEmotesHeaderIcon = v3.AllEmotesHeaderFrame:WaitForChild("Icon");
    v3.AllEmotesHeaderCloseButton = v3.AllEmotesHeaderFrame:WaitForChild("Close");
    v3.AllEmotesSlotsFrame = v3.AllEmotesContainer:WaitForChild("Slots");
    v3.AllEmotesSlotsContainer = v3.AllEmotesSlotsFrame:WaitForChild("Container");
    v3.AllEmotesSlotsLayout = v3.AllEmotesSlotsContainer:WaitForChild("Layout");
    v3.HidePartyDisplay = true;
    v3.EmoteWheel = EmoteWheel.new();
    v3._all_emotes_open = false;
    v3._cosmetic_slots = {};
    v3:_Init();

    return v3;
end;

function u1.GetDefaultElement(p4) -- Line: 53
    return nil;
end;

function u1.SetAllEmotesOpen(p5, p6) -- Line: 57
    -- upvalues: ControlsController (copy), GamepadService (copy)
    p5._all_emotes_open = p5._is_open and p6;
    p5.AllEmotesFrame.Visible = p5._all_emotes_open;
    p5.EmoteWheelSlotsFrame.Visible = not p5._all_emotes_open;
    p5:_VerifyEmoteWheel();
    p5:_VerifyAllEmotes();

    if p5._all_emotes_open and ControlsController.CurrentControls == "Gamepad" then
        GamepadService:EnableGamepadCursor(p5.AllEmotesSlotsFrame);
    end;
end;

function u1.PickEarly(p7) -- Line: 70
    -- upvalues: ControlsController (copy)
    if p7._all_emotes_open then
        if ControlsController.CurrentControls == "MouseKeyboard" then
            p7:_PickHoveredCosmeticSlot();
        end;
    else
        p7.EmoteWheel:FinishInputs();
    end;
end;

function u1.Open(u8, ...) -- Line: 82
    -- upvalues: Page (copy), UserInputService (copy), ControlsController (copy)
    Page.Open(u8, ...);
    u8.EmoteWheelSlotsButtonMouseKeyboardKeybindFrame:AddTag("UIKeybindContainer");
    u8.EmoteWheelSlotsButtonGamepadKeybindFrame:AddTag("UIKeybindContainer");
    u8:SetAllEmotesOpen(false);
    local u9 = 0;
    table.insert(u8._open_connections, UserInputService.InputChanged:Connect(function(p10, p11) -- Line: 91
        -- upvalues: u8 (copy), ControlsController (ref), u9 (ref)
        if u8._all_emotes_open or ControlsController.CurrentControls ~= "MouseKeyboard" then
            return;
        end;

        u9 = u9 + p10.Position.Z;

        if math.abs(u9) >= 1 then
            u8:SetAllEmotesOpen(true);
        end;
    end));
end;

function u1._UpdateCenterer(p12) -- Line: 108
end;

function u1._Update(p13) -- Line: 122
    p13.AllEmotesList.CanvasSize = UDim2.new(0, 0, 0, p13.AllEmotesLayout.AbsoluteContentSize.Y);
    p13.AllEmotesSlotsFrame.Size = UDim2.new(1, 0, 0, p13.AllEmotesSlotsLayout.AbsoluteContentSize.Y);
end;

function u1._PickByKey(p14, p15) -- Line: 127
    -- upvalues: EmoteController (copy)
    if not p14._is_open then
        return;
    end;

    EmoteController:UseEmote(p15);
    p14:CloseRequest();
end;

function u1._PickByName(p16, p17) -- Line: 136
    -- upvalues: EmoteController (copy)
    if not p16._is_open then
        return;
    end;

    EmoteController:UseEmoteByName(p17);
    p16:CloseRequest();
end;

function u1._PickHoveredCosmeticSlot(p18) -- Line: 145
    -- upvalues: UILibrary (copy)
    for _, v in pairs(p18._cosmetic_slots) do
        if UILibrary:IsMouseWithinBounds(v.Frame.AbsolutePosition, v.Frame.AbsoluteSize) then
            p18:_PickByName(v.Name);

            return;
        end;
    end;
end;

function u1._VerifyAllEmotes(u19) -- Line: 154
    -- upvalues: CosmeticLibrary (copy), PlayerDataController (copy), CosmeticSlot (copy)
    for _, v in pairs(u19._cosmetic_slots) do
        v:Destroy();
    end;

    u19._cosmetic_slots = {};

    if not (u19._is_open and u19._all_emotes_open) then
        return;
    end;

    local v20 = {};

    for i, v in pairs(CosmeticLibrary.CosmeticsAlphabetized) do
        table.insert(v20, {
            Name = v,
            AlphabeticalValue = i
        });
    end;

    table.sort(v20, function(p21, p22) -- Line: 176
        -- upvalues: CosmeticLibrary (ref)
        local Value = CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p21.Name].Rarity].Value;
        local Value2 = CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p22.Name].Rarity].Value;

        if Value == Value2 then
            return p21.AlphabeticalValue < p22.AlphabeticalValue;
        end;

        return Value2 < Value;
    end);

    for i, v in pairs(v20) do
        local Name = v.Name;

        if CosmeticLibrary.Cosmetics[Name].Type == "Emote" and CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), Name) then
            local v23 = CosmeticSlot.new(Name);
            v23.Frame.LayoutOrder = i;
            v23.Frame.Parent = u19.AllEmotesSlotsContainer;
            table.insert(u19._cosmetic_slots, v23);
            v23.Frame.Button.MouseButton1Click:Connect(function() -- Line: 200
                -- upvalues: u19 (copy), Name (copy)
                u19:_PickByName(Name);
            end);
        end;
    end;
end;

function u1._VerifyEmoteWheel(p24) -- Line: 206
    local v25 = p24._is_open and not p24._all_emotes_open;
    p24.EmoteWheel:SetEnabled(v25);

    if v25 then
        p24.EmoteWheel:StartInputs();

        return;
    end;

    p24.EmoteWheel:StopInputs();
end;

function u1._Setup(p26) -- Line: 218
    -- upvalues: CosmeticLibrary (copy)
    p26.AllEmotesHeaderIcon.Image = CosmeticLibrary.Types.Emote.Image;
    p26.EmoteWheel.Frame.Parent = p26.EmoteWheelSlotsFrame;
end;

function u1._Init(u27) -- Line: 223
    -- upvalues: EmoteController (copy), ButtonEffect (copy)
    u27.AllEmotesHeaderCloseButton.MouseButton1Click:Connect(function() -- Line: 224
        -- upvalues: u27 (copy)
        u27:CloseRequest();
    end);
    u27.EmoteWheelSlotsButton.MouseButton1Click:Connect(function() -- Line: 228
        -- upvalues: u27 (copy)
        u27:SetAllEmotesOpen(true);
    end);
    u27.AllEmotesList:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 232
        -- upvalues: u27 (copy)
        u27:_Update();
    end);
    u27.AllEmotesSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 236
        -- upvalues: u27 (copy)
        u27:_Update();
    end);
    u27.AllEmotesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 240
        -- upvalues: u27 (copy)
        u27:_Update();
    end);
    u27.AllEmotesList:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 244
        -- upvalues: u27 (copy)
        u27:_UpdateCenterer();
    end);
    u27.AllEmotesList:GetPropertyChangedSignal("CanvasSize"):Connect(function() -- Line: 248
        -- upvalues: u27 (copy)
        u27:_UpdateCenterer();
    end);
    u27.OpenChanged:Connect(function() -- Line: 252
        -- upvalues: u27 (copy)
        u27:_VerifyEmoteWheel();
    end);
    u27.EmoteWheel.EmoteKeyPicked:Connect(function(p28) -- Line: 256
        -- upvalues: u27 (copy)
        u27:_PickByKey(p28);
    end);
    EmoteController.CanEmoteChanged:Connect(function() -- Line: 260
        -- upvalues: EmoteController (ref), u27 (copy)
        if not EmoteController:CanEmote(true) then
            u27:CloseRequest();
        end;
    end);
    u27:_Setup();
    u27:_Update();
    ButtonEffect:Add(u27.EmoteWheelSlotsButton);
    ButtonEffect:Add(u27.AllEmotesHeaderCloseButton);
end;

return u1._new();