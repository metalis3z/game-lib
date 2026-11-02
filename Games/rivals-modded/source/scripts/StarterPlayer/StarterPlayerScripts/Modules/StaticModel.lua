-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Model = p2;
    v3._destroyed = false;
    v3._original_scale = v3.Model:GetScale();
    v3:_Init();

    return v3;
end;

function u1.GetPivot(p4) -- Line: 21
    return p4.Model:GetPivot();
end;

function u1.SetParent(p5, p6) -- Line: 25
    p5.Model.Parent = p6;
end;

function u1.SetArchivable(p7, p8) -- Line: 29
    for _, descendant in pairs(p7.Model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Archivable = p8;
        end;
    end;
end;

function u1.ScaleTo(p9, p10) -- Line: 37
    p9.Model:ScaleTo(p9._original_scale * p10);
end;

function u1.PivotTo(p11, p12, p13) -- Line: 41
    p11.Model.WorldPivot = p13 or p11.Model.WorldPivot;
    p11.Model:PivotTo(p12);
    p11:Update(0);
end;

function u1.Update(p14, p15) -- Line: 47
end;

function u1.Destroy(p16) -- Line: 51
    p16._destroyed = true;
    p16.Model:Destroy();
end;

function u1._Init(p17) -- Line: 60
end;

return u1;