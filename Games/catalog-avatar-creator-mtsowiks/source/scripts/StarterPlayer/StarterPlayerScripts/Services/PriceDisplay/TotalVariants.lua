-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local PlusIcon = require(script.Parent.Theme).PlusIcon;

return {
    chipSuffix = function(p1) -- Line: 13
        return string.format("%s%s <font color=\"%s\">-%d%%</font>", p1.prefix, p1.format(p1.eff), p1.color, p1.pct);
    end,

    chipSuffixSaved = function(p2) -- Line: 21
        local v3 = p2.base - p2.eff;

        return string.format("%s%s <font color=\"%s\">-%d%% (saved %s)</font>", p2.prefix, p2.format(p2.eff), p2.color, p2.pct, p2.format(v3));
    end,

    strikethrough = function(p4) -- Line: 30
        return string.format("%s<s>%s</s> %s", p4.prefix, p4.format(p4.base), p4.format(p4.eff));
    end,

    strikeAndPercent = function(p5) -- Line: 38
        return string.format("%s<s>%s</s> %s <font color=\"%s\">-%d%%</font>", p5.prefix, p5.format(p5.base), p5.format(p5.eff), p5.color, p5.pct);
    end,

    arrow = function(p6) -- Line: 46
        return string.format("%s%s → %s", p6.prefix, p6.format(p6.base), p6.format(p6.eff));
    end,

    minimalist = function(p7) -- Line: 54
        return string.format("%s<font color=\"%s\">%s</font>", p7.prefix, p7.color, p7.format(p7.eff));
    end,

    saved = function(p8) -- Line: 62
        local v9 = p8.base - p8.eff;

        return string.format("%s%s <font color=\"%s\">-%s</font>", p8.prefix, p8.format(p8.eff), p8.color, p8.format(v9));
    end,

    savedParen = function(p10) -- Line: 71
        local v11 = p10.base - p10.eff;

        return string.format("%s%s <font color=\"%s\">(-%s)</font>", p10.prefix, p10.format(p10.eff), p10.color, p10.format(v11));
    end,

    plusPct = function(p12) -- Line: 80
        -- upvalues: PlusIcon (copy)
        return string.format("%s%s <font color=\"%s\">%s-%d%%</font>", p12.prefix, p12.format(p12.eff), p12.color, PlusIcon, p12.pct);
    end,

    plusSave = function(p13) -- Line: 88
        -- upvalues: PlusIcon (copy)
        local v14 = p13.base - p13.eff;

        return string.format("%s%s <font color=\"%s\">%s-%s</font>", p13.prefix, p13.format(p13.eff), p13.color, PlusIcon, p13.format(v14));
    end,

    plusBadge = function(p15) -- Line: 97
        -- upvalues: PlusIcon (copy)
        return string.format("%s%s <font color=\"%s\">%s</font>", p15.prefix, p15.format(p15.eff), p15.color, PlusIcon);
    end
};