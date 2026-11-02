-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules.CosmeticSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Customize = p2;
    v3.Frame = v3.Customize.TopFrame:WaitForChild("NameDisplay");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.ElementsFrame = v3.Frame:WaitForChild("Elements");
    v3.Layout = v3.ElementsFrame:WaitForChild("Layout");
    v3.SlotContainer = v3.ElementsFrame:WaitForChild("Slot"):WaitForChild("Container");
    v3.TitleContainer = v3.ElementsFrame:WaitForChild("TitleContainer");
    v3.Title = v3.TitleContainer:WaitForChild("Title");
    v3._cosmetic_slot = nil;
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 31
    p4:_Update();
end;

function u1._Update(p5) -- Line: 39
    -- upvalues: CosmeticSlot (copy)
    if p5._cosmetic_slot then
        p5._cosmetic_slot:Destroy();
        p5._cosmetic_slot = nil;
    end;

    local SelectedCosmetic = p5.Customize.Interface.Equipment:GetSelectedCosmetic();
    p5.Frame.Visible = SelectedCosmetic ~= nil;
    p5.Title.Text = SelectedCosmetic == "RANDOM_COSMETIC" and "Random" or (SelectedCosmetic or "");

    if SelectedCosmetic then
        p5._cosmetic_slot = CosmeticSlot.new(SelectedCosmetic);
        p5._cosmetic_slot:SetWeapon(nil);
        p5._cosmetic_slot:OverrideNameText("");
        p5._cosmetic_slot:SetInteractable(false);
        p5._cosmetic_slot.Frame.Parent = p5.SlotContainer;
    end;
end;

function u1._UpdateLayout(p6) -- Line: 59
    p6.TitleContainer.Size = UDim2.new(0, p6.Title.TextBounds.X, 0.75, 0);
    p6.Background.Size = UDim2.new(0, p6.Layout.AbsoluteContentSize.X + p6.TitleContainer.AbsoluteSize.Y * 0.5, 1, 0);
end;

function u1._Init(u7) -- Line: 64
    u7.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 65
        -- upvalues: u7 (copy)
        u7:_UpdateLayout();
    end);
    u7.TitleContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 69
        -- upvalues: u7 (copy)
        u7:_UpdateLayout();
    end);
    u7.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 73
        -- upvalues: u7 (copy)
        u7:_UpdateLayout();
    end);
    u7:_UpdateLayout();
end;

return u1;