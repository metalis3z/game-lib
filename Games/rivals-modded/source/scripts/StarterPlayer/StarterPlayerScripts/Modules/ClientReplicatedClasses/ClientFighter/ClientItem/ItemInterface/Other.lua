-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ItemInterface = p2;
    v3.AimingVignette = v3.ItemInterface.Frame:WaitForChild("AimingVignette");
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6, p7) -- Line: 21
    p4.AimingVignette.ImageTransparency = 1 - p4.ItemInterface.ClientItem.ViewModel.CurrentAimValue;
end;

function u1.Destroy(p8) -- Line: 25
end;

function u1._Setup(p9) -- Line: 33
    -- upvalues: GuiService (copy)
    p9.AimingVignette.Size = UDim2.new(1, 0, 1, GuiService:GetGuiInset().Y);
end;

function u1._Init(p10) -- Line: 37
    p10:_Setup();
end;

return u1;