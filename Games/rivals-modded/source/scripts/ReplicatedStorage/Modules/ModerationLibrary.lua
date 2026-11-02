-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local u5 = {
    CanViewModerationPage = function(p1, p2) -- Line: 7, Name: CanViewModerationPage
        -- upvalues: PermissionsLibrary (copy)
        return PermissionsLibrary:HasPermission("permission_moderation_modpanel_access", p2);
    end,

    CanViewBanStatusAndLogs = function(p3, p4) -- Line: 11, Name: CanViewBanStatusAndLogs
        -- upvalues: PermissionsLibrary (copy)
        return PermissionsLibrary:HasPermission("permission_moderation_modpanel_viewbanned_full", p4);
    end
};

function u5.CanLookupPlayers(p6, p7) -- Line: 15
    -- upvalues: u5 (copy)
    return u5:CanViewModerationPage(p7);
end;

function u5.CanViewActionHistory(p8, p9) -- Line: 19
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_viewactions_full", p9);
end;

function u5.CanUseInvestigativeCommands(p10, p11) -- Line: 23
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_investigate_full", p11);
end;

function u5.CanPardonLimited(p12, p13) -- Line: 27
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_pardon_limited", p13);
end;

function u5.CanPardonAnyone(p14, p15) -- Line: 31
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_pardon_full", p15);
end;

function u5.CanPardon(p16, p17) -- Line: 35
    return p16:CanPardonLimited(p17) or p16:CanPardonAnyone(p17);
end;

function u5.CanViewDataLimited(p18, p19) -- Line: 39
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_viewdata_limited", p19);
end;

function u5.CanViewDataMost(p20, p21) -- Line: 43
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_viewdata_most", p21);
end;

function u5.CanViewDataFully(p22, p23) -- Line: 47
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_viewdata_full", p23);
end;

function u5.CanViewData(p24, p25) -- Line: 51
    return p24:CanViewDataLimited(p25) or (p24:CanViewDataMost(p25) or p24:CanViewDataFully(p25));
end;

function u5.CanUnban(p26, p27) -- Line: 55
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_unban", p27);
end;

function u5.CanJoinAnyone(p28, p29) -- Line: 59
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_teleport_full", p29);
end;

function u5.CanEvictLimited(p30, p31) -- Line: 63
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_evict_limited", p31);
end;

function u5.CanEvictAnyone(p32, p33) -- Line: 67
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_evict_full", p33);
end;

function u5.CanEvict(p34, p35) -- Line: 71
    return p34:CanEvictLimited(p35) or p34:CanEvictAnyone(p35);
end;

function u5.CanBanLimited(p36, p37) -- Line: 75
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_moderate_limited", p37);
end;

function u5.CanBanMost(p38, p39) -- Line: 79
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_moderate_most", p39);
end;

function u5.CanBanAnyone(p40, p41) -- Line: 83
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_moderate_full", p41);
end;

function u5.CanBan(p42, p43) -- Line: 87
    return p42:CanBanLimited(p43) or (p42:CanBanMost(p43) or p42:CanBanAnyone(p43));
end;

function u5.CanManageBanLocks(p44, p45) -- Line: 91
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_lock", p45);
end;

function u5.CanRemoveFromLeaderboards(p46, p47) -- Line: 95
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_removelbs_limited", p47);
end;

function u5.CanWarnTemplate(p48, p49) -- Line: 99
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_warn_template", p49);
end;

function u5.CanWarnCustom(p50, p51) -- Line: 103
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_warn_custom", p51);
end;

function u5.CanRestrict(p52, p53) -- Line: 107
    -- upvalues: PermissionsLibrary (copy)
    return PermissionsLibrary:HasPermission("permission_moderation_modpanel_restrict", p53);
end;

return u5;