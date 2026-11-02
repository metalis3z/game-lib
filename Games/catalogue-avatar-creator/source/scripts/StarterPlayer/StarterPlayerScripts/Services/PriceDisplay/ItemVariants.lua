-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Theme = require(script.Parent.Theme);
local RobuxIcon = Theme.RobuxIcon;
local PlusIcon = Theme.PlusIcon;

return {
    chipSuffix = function(p1) -- Line: 17
        -- upvalues: RobuxIcon (copy)
        return string.format("%s%s <font color=\"%s\">-%d%%</font>", RobuxIcon, p1.format(p1.eff), p1.color, p1.pct);
    end,

    chipSuffixSaved = function(p2) -- Line: 25
        -- upvalues: RobuxIcon (copy)
        local v3 = p2.base - p2.eff;

        return string.format("%s%s <font color=\"%s\">-%d%% (-%s)</font>", RobuxIcon, p2.format(p2.eff), p2.color, p2.pct, p2.format(v3));
    end,

    strikethrough = function(p4) -- Line: 34
        -- upvalues: RobuxIcon (copy)
        return string.format("<s>%s%s</s> %s%s", RobuxIcon, p4.format(p4.base), RobuxIcon, p4.format(p4.eff));
    end,

    strikeAndPercent = function(p5) -- Line: 42
        -- upvalues: RobuxIcon (copy)
        return string.format("<s>%s%s</s> %s%s <font color=\"%s\">-%d%%</font>", RobuxIcon, p5.format(p5.base), RobuxIcon, p5.format(p5.eff), p5.color, p5.pct);
    end,

    arrow = function(p6) -- Line: 50
        -- upvalues: RobuxIcon (copy)
        return string.format("%s%s → %s%s", RobuxIcon, p6.format(p6.base), RobuxIcon, p6.format(p6.eff));
    end,

    minimalist = function(p7) -- Line: 58
        -- upvalues: RobuxIcon (copy)
        return string.format("<font color=\"%s\">%s%s</font>", p7.color, RobuxIcon, p7.format(p7.eff));
    end,

    saved = function(p8) -- Line: 66
        -- upvalues: RobuxIcon (copy)
        local v9 = p8.base - p8.eff;

        return string.format("%s%s <font color=\"%s\">-%s%s</font>", RobuxIcon, p8.format(p8.eff), p8.color, RobuxIcon, p8.format(v9));
    end,

    savedParen = function(p10) -- Line: 75
        -- upvalues: RobuxIcon (copy)
        local v11 = p10.base - p10.eff;

        return string.format("%s%s <font color=\"%s\">(-%s%s)</font>", RobuxIcon, p10.format(p10.eff), p10.color, RobuxIcon, p10.format(v11));
    end,

    plusPct = function(p12) -- Line: 84
        -- upvalues: RobuxIcon (copy), PlusIcon (copy)
        return string.format("%s%s <font color=\"%s\">%s-%d%%</font>", RobuxIcon, p12.format(p12.eff), p12.color, PlusIcon, p12.pct);
    end,

    plusSave = function(p13) -- Line: 92
        -- upvalues: RobuxIcon (copy), PlusIcon (copy)
        local v14 = p13.base - p13.eff;

        return string.format("%s%s <font color=\"%s\">%s-%s%s</font>", RobuxIcon, p13.format(p13.eff), p13.color, PlusIcon, RobuxIcon, p13.format(v14));
    end,

    plusBadge = function(p15) -- Line: 101
        -- upvalues: RobuxIcon (copy), PlusIcon (copy)
        return string.format("%s%s <font color=\"%s\">%s</font>", RobuxIcon, p15.format(p15.eff), p15.color, PlusIcon);
    end
};