-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Customize = p2;
    v3.Frame = v3.Customize.TopFrame:WaitForChild("Description");
    v3.Background = v3.Frame:WaitForChild("Background");
    v3.Arrow = v3.Frame:WaitForChild("Arrow");
    v3.Title = v3.Frame:WaitForChild("Title");
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 26
    p4:_Update();
end;

function u1._UpdateArrow(p5) -- Line: 34
    local v6 = p5.Background.AbsolutePosition.X + p5.Background.AbsoluteSize.X / 2 - (p5.Customize.NameDisplay.SlotContainer.AbsolutePosition.X + p5.Customize.NameDisplay.SlotContainer.AbsoluteSize.X / 2);
    local math_abs_ret = math.abs(v6);
    local v7 = math.min(math_abs_ret, p5.Background.AbsoluteSize.X / 2 - p5.Arrow.AbsoluteSize.X - 8) * math.sign(v6);
    p5.Arrow.Position = UDim2.new(0.5, -v7, 0, 2);
end;

function u1._Update(p8) -- Line: 41
    -- upvalues: CosmeticLibrary (copy)
    local SelectedCosmetic = p8.Customize.Interface.Equipment:GetSelectedCosmetic();
    local v9 = CosmeticLibrary.Cosmetics[SelectedCosmetic];
    local v10 = SelectedCosmetic == "RANDOM_COSMETIC" and "Equips a random cosmetic every time you spawn" or (v9 and v9.GetDescription(true) or nil);
    p8.Frame.Visible = v10 ~= nil;
    p8.Title.Text = v10 or "";

    if p8.Frame.Visible then
        p8.Frame.Size = UDim2.new(0.5, 0.03125, 0);
        p8.Frame:TweenSize(UDim2.new(1, 0, 0.0625, 0), "Out", "Back", 0.25, true);
    end;
end;

function u1._UpdateBackground(p11) -- Line: 57
    p11.Background.Size = UDim2.new(0, p11.Title.TextBounds.X + p11.Frame.AbsoluteSize.Y, 1, 0);
end;

function u1._Init(u12) -- Line: 61
    u12.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 62
        -- upvalues: u12 (copy)
        u12:_UpdateBackground();
    end);
    u12.Background:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 66
        -- upvalues: u12 (copy)
        u12:_UpdateArrow();
    end);
    u12.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 70
        -- upvalues: u12 (copy)
        u12:_UpdateArrow();
    end);
    u12.Arrow:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 74
        -- upvalues: u12 (copy)
        u12:_UpdateArrow();
    end);
    u12.Customize.NameDisplay.SlotContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 78
        -- upvalues: u12 (copy)
        u12:_UpdateArrow();
    end);
    u12.Customize.NameDisplay.SlotContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 82
        -- upvalues: u12 (copy)
        u12:_UpdateArrow();
    end);
    u12:_UpdateBackground();
    u12:_UpdateArrow();
end;

return u1;