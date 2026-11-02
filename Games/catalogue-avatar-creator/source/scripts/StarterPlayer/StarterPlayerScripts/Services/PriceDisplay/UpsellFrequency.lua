-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = nil;

local function getRobloxPlusController() -- Line: 17
    -- upvalues: u1 (ref)
    if u1 then
        return u1;
    end;

    u1 = require(script.Parent.Parent.Parent.Controllers.RobloxPlusController);

    return u1;
end;

return {
    none = function(p2, p3) -- Line: 26
        return false;
    end,

    always = function(p4, p5) -- Line: 31
        return true;
    end,

    onceDismissed = function(p6, p7) -- Line: 35
        return not p6.dismissed;
    end,

    onceDismissedPersistent = function(p8, p9) -- Line: 44
        -- upvalues: u1 (ref)
        local v10;

        if u1 then
            v10 = u1;
        else
            u1 = require(script.Parent.Parent.Parent.Controllers.RobloxPlusController);
            v10 = u1;
        end;

        local v11 = v10.GetPersistedDismissedAt();

        return (typeof(v11) ~= "number" or v11 <= 0) and true or (v10.Config and v10.Config.DismissTTLSeconds or 172800) <= workspace:GetServerTimeNow() - v11;
    end,

    cooldown60 = function(p12, p13) -- Line: 52
        return os.time() - (p12.lastShown or 0) >= 60;
    end,

    cooldown300 = function(p14, p15) -- Line: 56
        return os.time() - (p14.lastShown or 0) >= 300;
    end,

    firstOnly = function(p16, p17) -- Line: 60
        return (p16.count or 0) == 0;
    end,

    highSavings100 = function(p18, p19) -- Line: 64
        -- upvalues: u1 (ref)
        local v20;

        if u1 then
            v20 = u1;
        else
            u1 = require(script.Parent.Parent.Parent.Controllers.RobloxPlusController);
            v20 = u1;
        end;

        return (v20.Config and v20.Config.HighSavingsThreshold or 100) <= (p19.savings or 0);
    end,

    highSavings500 = function(p21, p22) -- Line: 72
        return (p22.savings or 0) >= 500;
    end
};