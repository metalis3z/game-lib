-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.Vignette = v3.FighterInterface.Frame:WaitForChild("FrozenVignette");
    v3.VignetteTexture = v3.Vignette:WaitForChild("Texture");
    v3:_Init();

    return v3;
end;

function u1.Refresh(p4) -- Line: 20
    local v5 = p4.FighterInterface.ClientFighter and (p4.FighterInterface.ClientFighter.Entity and p4.FighterInterface.ClientFighter:IsAlive()) and p4.FighterInterface.ClientFighter.Entity:Get("IsFrozen");
    local IsDisableOnly = (typeof(v5) == "table" and v5 and v5 or {}).IsDisableOnly;
    p4.Vignette.ImageColor3 = IsDisableOnly and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(35, 149, 255);
    p4.Vignette.ImageTransparency = v5 and 0 or 1;
    p4.VignetteTexture.ImageTransparency = p4.Vignette.ImageTransparency;
end;

function u1.Destroy(p6) -- Line: 30
end;

function u1._Init(p7) -- Line: 38
end;

return u1;