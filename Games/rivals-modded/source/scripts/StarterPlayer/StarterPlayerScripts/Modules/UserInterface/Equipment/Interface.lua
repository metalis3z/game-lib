-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local Customize = require(script:WaitForChild("Customize"));
local Right = require(script:WaitForChild("Right"));
local Left = require(script:WaitForChild("Left"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy), UILibrary (copy), Customize (copy), Right (copy), Left (copy)
    local v3 = setmetatable({}, u1);
    v3.Equipment = p2;
    v3.Frame = UILibrary:GetTo("MainFrame", "Equipment");
    v3.Customize = Customize.new(v3);
    v3.Right = Right.new(v3);
    v3.Left = Left.new(v3);
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4, ...) -- Line: 31
    p4.Customize:OnCustomizingStateChanged(...);
end;

function u1.OnStateChanged(p5, ...) -- Line: 35
    p5.Right:OnStateChanged(...);
    p5.Left:OnStateChanged(...);
    p5.Customize:OnStateChanged(...);
end;

function u1.OnOpen(p6, ...) -- Line: 41
    p6.Right:OnOpen(...);
    p6.Left:OnOpen(...);
    p6:_UpdateComponentsVisibility();
end;

function u1.Update(p7, ...) -- Line: 47
    p7.Left:Update(...);
end;

function u1._UpdateComponentsVisibility(p8) -- Line: 55
    -- upvalues: Pages (copy), GuiService (copy)
    local v9 = p8.Equipment.IsOpen and (p8.Equipment:IsOpenEffectDone() and not (p8.Equipment:IsUnlocking() or Pages.PageSystem.CurrentPage)) and not GuiService.MenuIsOpen;
    local v10 = p8.Equipment:IsCustomizing();
    local v11;

    if v9 then
        v11 = not v10 and true;
    else
        v11 = v9;
    end;

    p8.Right:SetVisible(v11);
    local v12;

    if v9 then
        v12 = not v10 and true;
    else
        v12 = v9;
    end;

    p8.Left:SetVisible(v12);

    if v9 then
        v9 = v10 and true;
    end;

    p8.Customize:SetVisible(v9);
end;

function u1._Init(u13) -- Line: 69
    -- upvalues: Pages (copy), GuiService (copy)
    u13.Equipment.CustomizingChanged:Connect(function() -- Line: 70
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    u13.Equipment.UnlockingChanged:Connect(function() -- Line: 74
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    u13.Equipment.FinishedOpenEffect:Connect(function() -- Line: 78
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    u13.Equipment.SpinControls.MouseDownChanged:Connect(function() -- Line: 82
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 86
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 90
        -- upvalues: u13 (copy)
        u13:_UpdateComponentsVisibility();
    end);
    u13:_UpdateComponentsVisibility();
end;

return u1;