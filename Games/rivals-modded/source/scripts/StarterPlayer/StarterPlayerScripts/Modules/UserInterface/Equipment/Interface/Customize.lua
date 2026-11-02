-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local NameDisplay = require(script:WaitForChild("NameDisplay"));
local Description = require(script:WaitForChild("Description"));
local Cosmetics = require(script:WaitForChild("Cosmetics"));
local Actions = require(script:WaitForChild("Actions"));
local Options = require(script:WaitForChild("Options"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), Options (copy), Actions (copy), Cosmetics (copy), NameDisplay (copy), Description (copy)
    local v3 = setmetatable({}, u1);
    v3.Interface = p2;
    v3.Frame = v3.Interface.Frame:WaitForChild("Customize");
    v3.TopFrame = v3.Frame:WaitForChild("Top");
    v3.BottomFrame = v3.Frame:WaitForChild("Bottom");
    v3.BottomContainer = v3.BottomFrame:WaitForChild("Container");
    v3.Options = Options.new(v3);
    v3.Actions = Actions.new(v3);
    v3.Cosmetics = Cosmetics.new(v3);
    v3.NameDisplay = NameDisplay.new(v3);
    v3.Description = Description.new(v3);
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 33
    p4.BottomFrame:TweenPosition(p5 and UDim2.new(0.5, 0, 1, 0) or UDim2.new(0.5, 0, 1.5, 0), "Out", "Quint", 0.25, true);
    p4.TopFrame:TweenPosition(p5 and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, -0.5, 0), "Out", "Quint", 0.25, true);
end;

function u1.OnCustomizingStateChanged(p6, ...) -- Line: 38
    p6.Options:OnCustomizingStateChanged(...);
    p6.Actions:OnCustomizingStateChanged(...);
    p6.Cosmetics:OnCustomizingStateChanged(...);
    p6.Description:OnCustomizingStateChanged(...);
    p6.NameDisplay:OnCustomizingStateChanged(...);
end;

function u1.OnStateChanged(p7, ...) -- Line: 46
    p7.Cosmetics:OnStateChanged(...);
    p7.Actions:OnStateChanged(...);
    p7.Options:OnStateChanged(...);
end;

function u1._Setup(p8) -- Line: 56
    p8.Frame.Visible = true;
end;

function u1._Init(p9) -- Line: 60
    p9:_Setup();
end;

return u1;