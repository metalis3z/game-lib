-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = "#d5d7dd";
local u3 = utf8.char(57346);

function u1.Refresh(p4) -- Line: 10
    -- upvalues: u2 (ref), u1 (copy), u3 (copy)
    if p4 then
        u2 = p4("#d5d7dd");
    end;

    u1.creator = "<font color=\"" .. u2 .. "\">By</font> <b>%s</b>";
    u1.creatorHovered = "<font color=\"" .. u2 .. "\">By</font> <b><u>%s</u></b>";
    u1.price = u3 .. "%s";
    u1.free = "<b>Free</b>";
    u1.offsale = "<font color=\"" .. u2 .. "\">Off Sale</font>";
    u1.noResellers = "<font color=\"" .. u2 .. "\">No Resellers</font>";
    u1.date = "<font color=\"" .. u2 .. "\">%s</font>";
end;

u1.Refresh();

return u1;