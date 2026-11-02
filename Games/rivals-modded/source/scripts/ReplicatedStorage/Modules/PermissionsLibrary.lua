-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local TestAttribute = require(ReplicatedStorage.Modules.TestLibrary):GetTestAttribute("StudioPermissionsRoleTest");
local u1 = {
    USE_GROUP_ROLES_INSTEAD_OF_DATASTORES = true
};
u1.ALWAYS_AUTHORIZED_TO_USE_COMMANDS = not TestAttribute and (CONSTANTS.IS_STUDIO or CONSTANTS.IS_TESTING_SERVER);
u1.ALWAYS_HAS_PERMISSION = not TestAttribute and CONSTANTS.IS_STUDIO;
u1.PermissionsOrder = {};
u1.Permissions = {};
u1.Teams = {};
u1.Roles = {};

function u1.GetPermissionsRoleNameFromDisplayName(p2, p3) -- Line: 18
    for i, v in pairs(p2.Roles) do
        if v.DisplayName == p3 then
            return i;
        end;
    end;
end;

function u1.IsAdministrator(p4, p5) -- Line: 26
    if p4.ALWAYS_HAS_PERMISSION then
        return true;
    end;

    for _, v in pairs(p5) do
        local v6 = p4.Roles[v];

        for _, v2 in pairs(v6 and v6.PermissionNames or {}) do
            local v7 = p4.Permissions[v2];

            if v7 and v7.ExtraInformation.IsAdministrator then
                return true;
            end;
        end;
    end;

    return false;
end;

function u1.HasPermission(p8, p9, p10) -- Line: 46
    if p8:IsAdministrator(p10) then
        return true;
    end;

    for _, v in pairs(p10) do
        local v11 = p8.Roles[v];

        if v11 and table.find(v11.PermissionNames, p9) then
            return true;
        end;
    end;

    return false;
end;

function u1.CanViewPermissionsPage(p12, p13) -- Line: 62
    return p12:HasPermission("permission_permissions_page_access", p13);
end;

function u1.CanManageRole(p14, p15, p16) -- Line: 66
    if p14:IsAdministrator(p16) then
        return true;
    end;

    for _, v in pairs(p16) do
        local v17 = p14.Roles[v];

        for _, v2 in pairs(v17 and v17.PermissionNames or {}) do
            local v18 = p14.Permissions[v2];

            if v18 and (v18.ExtraInformation.ManageableRoles and table.find(v18.ExtraInformation.ManageableRoles, p15)) then
                return true;
            end;
        end;
    end;

    return false;
end;

function u1.GetManageableRoles(p19, p20) -- Line: 86
    local v21 = {};

    for i, _ in pairs(p19.Roles) do
        if p19:CanManageRole(i, p20) then
            table.insert(v21, i);
        end;
    end;

    return v21;
end;

local function add_permission(p22, p23, p24, p25) -- Line: 98
    -- upvalues: u1 (copy)
    assert(not u1.Permissions[p22]);
    local v26 = {
        Name = p22,
        DisplayName = p23,
        Description = p24,
        ExtraInformation = p25 or {},
        PermissionValue = -#u1.PermissionsOrder
    };
    u1.Permissions[v26.Name] = v26;
    table.insert(u1.PermissionsOrder, v26.Name);
end;

add_permission(
    "permission_administrator",
    "Administrator",
    "All permissions are granted",
    {
        IsAdministrator = true
    }
);
add_permission(
    "permission_permissions_page_access",
    "Permissions Page",
    "Grants access to view the Permissions page"
);
add_permission(
    "permission_leaders_management",
    "Manage Leaders",
    "Add, remove, promote, & demote Team Leads",
    {
        ManageableRoles = { "role_leadtester", "role_leadgamemod" }
    }
);
add_permission("permission_freecamaccess", "Freecam Access", "Grants access to using Freecam mode any time");
add_permission("permission_funcommands", "Fun Commands", "Grants access to using fun commands in all servers");
add_permission(
    "permission_moderation_modpanel_access",
    "Moderation Page",
    "Grants access to view the Moderation page"
);
add_permission(
    "permission_moderation_modpanel_investigate_full",
    "Investigative Tools",
    "Allows you use tools to investigate top leaderboard players"
);
add_permission(
    "permission_moderation_modpanel_viewbanned_full",
    "View Ban Status & Logs",
    "Allows you to view the ban status & ban logs of any player"
);
add_permission(
    "permission_moderation_modpanel_viewactions_full",
    "View Action History",
    "Allows you to view the action history of any other Moderator"
);
add_permission(
    "permission_moderation_modpanel_teleport_full",
    "Join Any Player",
    "Allows you to teleport to anyone\'s server (except Private Servers)"
);
add_permission("permission_moderation_modpanel_unban", "Unban Any Player", "Allows you to unban any player");
add_permission(
    "permission_moderation_modpanel_moderate_limited",
    "Ban Average Players",
    "Allows you to ban players under 10,000 Robux spent / 1,000 historic peak Win Streak / 3,600 historic peak ELO",
    {
        UnderThisELO = 3600,
        UnderThisStreak = 1000,
        UnderThisRobuxSpent = 10000
    }
);
add_permission(
    "permission_moderation_modpanel_moderate_most",
    "Ban Most Players",
    "Allows you to ban any player, except high ranking Nosniy Games group members"
);
add_permission("permission_moderation_modpanel_moderate_full", "Ban Any Player", "Allows you to ban any player");
add_permission(
    "permission_moderation_modpanel_evict_limited",
    "Evict From Hub & Arcade",
    "Allows you to kick players from hub duels & arcade servers only (affects bans)"
);
add_permission(
    "permission_moderation_modpanel_evict_full",
    "Evict From Anywhere",
    "Allows you to kick players from anywhere (affects bans)"
);
add_permission(
    "permission_moderation_modpanel_viewdata_limited",
    "View Necessary Player Data",
    "Allows you to view player data that is only relevant to obvious moderation purposes"
);
add_permission(
    "permission_moderation_modpanel_viewdata_most",
    "View Most Player Data",
    "Allows you to view everything in someone\'s player data, except total robux spent"
);
add_permission(
    "permission_moderation_modpanel_viewdata_full",
    "View All Player Data",
    "Allows you to view everything in someone\'s player data"
);
add_permission(
    "permission_moderation_modpanel_pardon_limited",
    "Pardon Some Anticheat Bans",
    "Allows you to pardon anticheat bans from a strict whitelist"
);
add_permission(
    "permission_moderation_modpanel_pardon_full",
    "Pardon Any Anticheat Ban",
    "Allows you to pardon any anticheat ban"
);
add_permission(
    "permission_moderation_modpanel_lock",
    "Ban Lock Powers",
    "Allows you to lock a player from being banned, unbanned, kicked, etc"
);
add_permission(
    "permission_moderation_modpanel_removelbs_limited",
    "Remove From Leaderboards",
    "Allows you to wipe players from all leaderboards (only works for banned / restricted players)"
);
add_permission(
    "permission_moderation_modpanel_warn_template",
    "Warn Players On Ban",
    "Allows you to send a template warning message to any player during a ban"
);
add_permission(
    "permission_moderation_modpanel_warn_custom",
    "Warn Any Player",
    "Allows you to send a custom warning message to any player"
);
add_permission(
    "permission_moderation_modpanel_restrict",
    "Restrict Any Player",
    "Allows you to restrict players from features such as casual & competitive leaderboards"
);
add_permission(
    "permission_moderation_management",
    "Manage Moderators",
    "Add, remove, promote, & demote anyone related to the Moderation Team",
    {
        ManageableRoles = { "role_trialgamemod", "role_jrgamemod", "role_gamemod", "role_srgamemod" }
    }
);
add_permission("permission_testing_zfaccess", "ZF Access", "Grants access to the testing server");
add_permission(
    "permission_testing_publiccommands_safe",
    "Helpful Commands",
    "Gives access to a few helpful debug commands in public servers"
);
add_permission(
    "permission_testing_publiccommands_bugrewards",
    "Bug Rewarder Command",
    "Gives access to the command to hand out bug rewards"
);
add_permission(
    "permission_testing_management",
    "Manage Testers",
    "Add, remove, promote, & demote anyone related to the Testing Team",
    {
        ManageableRoles = { "role_backuptester", "role_tester" }
    }
);

local function add_team(p27, p28, p29, p30, p31) -- Line: 147
    -- upvalues: u1 (copy)
    assert(not u1.Teams[p28]);
    local v32 = {
        TeamValue = p27,
        Name = p28,
        DisplayName = p29,
        Icon = p30,
        Color = p31,
        RoleNames = {}
    };
    u1.Teams[v32.Name] = v32;
    table.sort(v32.RoleNames, function(p33, p34) -- Line: 161
        -- upvalues: u1 (ref)
        return u1.Permissions[p33].PermissionValue > u1.Permissions[p34].PermissionValue;
    end);
end;

add_team(4, "team_leadership", "Leadership", "rbxassetid://111377968573170", Color3.fromRGB(191, 0, 255));
add_team(3, "team_moderation", "Moderation", "rbxassetid://118920750856778", Color3.fromRGB(230, 126, 34));
add_team(2, "team_testing", "Testing", "rbxassetid://18223601855", Color3.fromRGB(241, 196, 15));
add_team(1, "team_other", "Other", "rbxassetid://17548980857", Color3.fromRGB(127, 127, 127));

local function add_role(p35, p36, p37, p38, p39, p40, p41) -- Line: 171
    -- upvalues: u1 (copy)
    assert(u1.Teams[p36]);
    local v42 = not u1.Roles[p38] and not u1:GetPermissionsRoleNameFromDisplayName(p40);
    assert(v42);

    for _, v in pairs(p41) do
        assert(u1.Permissions[v], v);
    end;

    local v43 = {
        GroupRoleID = p35,
        TeamName = p36,
        RoleValue = p37,
        Name = p38,
        Color = p39,
        DisplayName = p40,
        PermissionNames = p41
    };
    u1.Roles[v43.Name] = v43;
    table.insert(u1.Teams[v43.TeamName].RoleNames, v43.Name);
end;

add_role(23832226, "team_leadership", 2, "role_administrator", Color3.fromRGB(191, 0, 255), "Administrator", { "permission_administrator" });
add_role(855122020, "team_leadership", 1, "role_director", Color3.fromRGB(113, 122, 254), "Director", { "permission_permissions_page_access", "permission_leaders_management", "permission_testing_management", "permission_moderation_management" });
add_role(855486017, "team_moderation", 5, "role_leadgamemod", Color3.fromRGB(156, 41, 0), "Lead Game Moderator", { "permission_moderation_modpanel_access", "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_moderate_full", "permission_moderation_modpanel_viewdata_full", "permission_moderation_modpanel_evict_full", "permission_moderation_modpanel_pardon_full", "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom", "permission_moderation_modpanel_restrict", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_investigate_full", "permission_moderation_modpanel_unban", "permission_moderation_modpanel_lock", "permission_permissions_page_access", "permission_moderation_management" });
add_role(855568028, "team_moderation", 4, "role_srgamemod", Color3.fromRGB(255, 68, 0), "Senior Game Moderator", { "permission_moderation_modpanel_access", "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_viewdata_most", "permission_moderation_modpanel_evict_full", "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom", "permission_moderation_modpanel_restrict", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_investigate_full", "permission_moderation_modpanel_unban" });
add_role(854242030, "team_moderation", 3, "role_gamemod", Color3.fromRGB(230, 126, 34), "Game Moderator", { "permission_moderation_modpanel_access", "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_viewdata_most", "permission_moderation_modpanel_evict_full", "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom", "permission_moderation_modpanel_restrict", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_investigate_full", "permission_moderation_modpanel_unban" });
add_role(854812013, "team_moderation", 2, "role_jrgamemod", Color3.fromRGB(230, 150, 80), "Junior Game Moderator", { "permission_moderation_modpanel_access", "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_viewdata_limited", "permission_moderation_modpanel_evict_limited", "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom", "permission_moderation_modpanel_restrict", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_investigate_full", "permission_moderation_modpanel_unban" });
add_role(853986021, "team_moderation", 1, "role_trialgamemod", Color3.fromRGB(230, 170, 118), "Trial Game Moderator", { "permission_moderation_modpanel_access", "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_viewdata_limited", "permission_moderation_modpanel_evict_limited", "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_restrict" });
add_role(855640022, "team_testing", 3, "role_leadtester", Color3.fromRGB(162, 130, 0), "Lead Tester", { "permission_testing_zfaccess", "permission_testing_publiccommands_safe", "permission_testing_publiccommands_bugrewards", "permission_permissions_page_access", "permission_testing_management", "permission_moderation_modpanel_access", "permission_moderation_modpanel_teleport_full", "permission_moderation_modpanel_viewdata_full" });
add_role(33929719, "team_testing", 2, "role_tester", Color3.fromRGB(241, 196, 15), "Tester", { "permission_testing_zfaccess", "permission_testing_publiccommands_safe" });
add_role(854386033, "team_testing", 1, "role_backuptester", Color3.fromRGB(252, 231, 145), "Backup Tester", { "permission_testing_zfaccess", "permission_testing_publiccommands_safe" });
add_role(854788035, "team_other", 2, "role_funcommands", Color3.fromRGB(127, 127, 127), "Fun Commands", { "permission_funcommands" });
add_role(854710017, "team_other", 1, "role_freecam", Color3.fromRGB(127, 127, 127), "Freecam", { "permission_freecamaccess" });
(function() -- Line: 209, Name: final_asserts
    -- upvalues: u1 (copy)
    for _, v in pairs(u1.Permissions) do
        for _, v2 in pairs(v.ExtraInformation.ManageableRoles or {}) do
            assert(u1.Roles[v2] ~= nil, v2);
        end;
    end;
end)();

return u1;