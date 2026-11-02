-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.SearchUpdated = Signal.new();
    v3.Customize = p2;
    v3.Frame = v3.Customize.BottomContainer:WaitForChild("Actions");
    v3.BackButton = v3.Frame:WaitForChild("Back");
    v3.EmoteButton = v3.Frame:WaitForChild("Emote");
    v3.EmoteButtonEquipFrame = v3.EmoteButton:WaitForChild("Equip");
    v3.EmoteButtonUnequipFrame = v3.EmoteButton:WaitForChild("Unequip");
    v3.SearchFrame = v3.Frame:WaitForChild("Search");
    v3.SearchBox = v3.SearchFrame:WaitForChild("Box");
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 36
    p4:_UpdateEmoteButton();
end;

function u1.OnStateChanged(p5) -- Line: 40
    p5:_UpdateEmoteButton();

    if not p5.Customize.Interface.Equipment:IsCustomizing() then
        p5.SearchBox.Text = "";
    end;
end;

function u1._UpdateEmoteButton(p6) -- Line: 52
    -- upvalues: CosmeticLibrary (copy), PlayerDataController (copy)
    local SelectedCosmetic = p6.Customize.Interface.Equipment:GetSelectedCosmetic();
    local v7 = CosmeticLibrary.Cosmetics[SelectedCosmetic];

    if v7 then
        v7 = v7.Type == "Emote";
    end;

    local v8;

    if v7 then
        v8 = CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), SelectedCosmetic, p6.Customize.Interface.Equipment:GetSelectedWeapon());
    else
        v8 = v7;
    end;

    if v7 then
        v7 = PlayerDataController:IsEmoteEquipped(SelectedCosmetic);
    end;

    p6.EmoteButton.Visible = v8;
    p6.EmoteButtonEquipFrame.Visible = not v7;
    p6.EmoteButtonUnequipFrame.Visible = v7;
    p6.SearchFrame.Size = v8 and UDim2.new(0.75, -10, 1, 0) or UDim2.new(0.875, -5, 1, 0);
end;

function u1._UpdateSearch(p9) -- Line: 65
    p9.Customize.Interface.Equipment:SetCosmeticSearchQuery(p9.SearchBox.Text);
end;

function u1._Init(u10) -- Line: 69
    -- upvalues: Pages (copy), PlayerDataController (copy), ButtonEffect (copy)
    u10.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 70
        -- upvalues: u10 (copy)
        u10:_UpdateSearch();
    end);
    u10.BackButton.MouseButton1Click:Connect(function() -- Line: 74
        -- upvalues: u10 (copy)
        u10.Customize.Interface.Equipment:CloseRequest();
    end);
    u10.EmoteButton.MouseButton1Click:Connect(function() -- Line: 78
        -- upvalues: Pages (ref), u10 (copy)
        Pages.PageSystem:OpenPage("EquipEmote");
        Pages.PageSystem:WaitForPage("EquipEmote"):SetEmoteName(u10.Customize.Interface.Equipment:GetSelectedCosmetic());
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 83
        -- upvalues: u10 (copy)
        u10:_UpdateEmoteButton();
    end);
    ButtonEffect:Add(u10.BackButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
    ButtonEffect:Add(u10.EmoteButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1;