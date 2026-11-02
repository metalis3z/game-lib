-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    UNBANNED_TOKEN = "Unbanned",
    PERMANENT_BAN_DURATION = 999999999,

    IsBanLogANote = function(p1, p2) -- Line: 6, Name: IsBanLogANote
        return p2.IsNote;
    end,

    IsBanLogABan = function(p3, p4) -- Line: 10, Name: IsBanLogABan
        local v5 = not p3:IsBanLogANote(p4) and p4.Reason ~= p3.UNBANNED_TOKEN;

        return v5;
    end,

    IsBanLogAnActiveBan = function(p6, p7) -- Line: 14, Name: IsBanLogAnActiveBan
        local v8 = p6:IsBanLogABan(p7) and p7.EndTime and os.time() < p7.EndTime;

        return v8;
    end,

    IsBanLogAWarning = function(p9, p10) -- Line: 18, Name: IsBanLogAWarning
        local v11 = p9:IsBanLogANote(p10) and p10.Reason and string.sub(p10.Reason, 1, 9) == "Warned - ";

        return v11;
    end,

    IsBanned = function(p12, p13) -- Line: 23, Name: IsBanned
        for _, v in pairs(p13.BanHistory) do
            if not p12:IsBanLogANote(v) then
                if p12:IsBanLogAnActiveBan(v) then
                    return v;
                end;

                break;
            end;
        end;

        return nil;
    end
};