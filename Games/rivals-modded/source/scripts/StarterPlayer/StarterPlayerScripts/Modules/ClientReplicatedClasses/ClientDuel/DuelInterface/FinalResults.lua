-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local Buttons = require(script:WaitForChild("Buttons"));
local Summary = require(script:WaitForChild("Summary"));
local Winners = require(script:WaitForChild("Winners"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), Signal (copy), Summary (copy), Winners (copy), Buttons (copy)
    local v3 = setmetatable({}, u1);
    v3.Activated = Signal.new();
    v3.PageChanged = Signal.new();
    v3.CurrentPage = nil;
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("FinalResults");
    v3.Summary = Summary.new(v3);
    v3.Winners = Winners.new(v3);
    v3.Buttons = Buttons.new(v3);
    v3._is_active = false;
    v3:_Init();

    return v3;
end;

function u1.IsActive(p4) -- Line: 35
    return p4._is_active;
end;

function u1.SetPage(p5, p6) -- Line: 39
    p5.CurrentPage = p6;
    p5.PageChanged:Fire();
    p5.Winners:SetVisible(p5.CurrentPage == "Winners");
    p5.Summary:SetVisible(p5.CurrentPage == "Summary");
end;

function u1.Play(p7, ...) -- Line: 47
    p7._is_active = true;
    p7.Activated:Fire();

    return p7.Winners:Play(...);
end;

function u1.UpdateVisibility(p8) -- Line: 54
    local Frame = p8.Frame;
    local v9 = p8:IsActive() and not p8.DuelInterface:IsPageOpen();
    Frame.Visible = v9;
end;

function u1.Destroy(p10) -- Line: 58
    p10.Activated:Destroy();
    p10.PageChanged:Destroy();
    p10.Summary:Destroy();
    p10.Winners:Destroy();
    p10.Buttons:Destroy();
end;

function u1._Setup(p11) -- Line: 71
    p11.Frame.Visible = false;
end;

function u1._Init(u12) -- Line: 75
    u12.Activated:Connect(function() -- Line: 76
        -- upvalues: u12 (copy)
        u12:UpdateVisibility();
    end);
    u12:_Setup();
    u12:SetPage("Winners");
end;

return u1;