-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Message = nil;
    v2.ButtonAppearDelay = nil;
    v2.Buttons = {};
    v2.DelayedContinue = nil;
    v2:_Init();

    return v2;
end;

function u1.SetMessage(p3, p4, p5, p6) -- Line: 21
    p3.Message = {
        Picture = p4,
        Text = p5,
        SoundID = p6
    };
end;

function u1.SetButtonAppearDelay(p7, p8) -- Line: 29
    p7.ButtonAppearDelay = p8;
end;

function u1.ContinueAfterDelay(p9, p10, p11) -- Line: 33
    p9.DelayedContinue = {
        Delay = p10,
        NextDialog = p11
    };
end;

function u1.AddButton(p12, p13, p14, p15) -- Line: 40
    local Buttons = p12.Buttons;
    local v16 = {
        Text = p13,
        NextDialog = p14
    };
    local v17;

    if p14 then
        v17 = nil;
    else
        v17 = not p15 or nil;
    end;

    v16.IsCloseButton = v17;
    v16.DialogActionKey = p15;
    table.insert(Buttons, v16);
end;

function u1.AddCloseButton(p18, p19) -- Line: 49
    p18:AddButton(p19 or "Goodbye", nil);
end;

function u1.IsDialogActionAvailable(p20, u21) -- Line: 53
    if not u21 then
        return false;
    end;

    local function search(p22) -- Line: 58
        -- upvalues: u21 (copy), search (copy)
        for _, v in pairs(p22.Buttons or {}) do
            if v.DialogActionKey == u21 then
                return true;
            end;

            if v.NextDialog and search(v.NextDialog) then
                return true;
            end;
        end;

        local v23 = p22.DelayedContinue and p22.DelayedContinue.NextDialog and search(p22.DelayedContinue.NextDialog);

        return v23;
    end;

    return search(p20);
end;

function u1._Init(p24) -- Line: 81
end;

return u1;