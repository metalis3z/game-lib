-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserService = game:GetService("UserService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local ModerationLibrary = require(ReplicatedStorage.Modules.ModerationLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local BanLibrary = require(ReplicatedStorage.Modules.BanLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = {
    { "permission_moderation_modpanel_access" },
    { "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_viewdata_limited", "permission_moderation_modpanel_viewdata_most", "permission_moderation_modpanel_viewdata_full" },
    { "permission_moderation_modpanel_teleport_full" },
    { "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom" },
    { "permission_moderation_modpanel_evict_limited", "permission_moderation_modpanel_evict_full" },
    { "permission_moderation_modpanel_moderate_limited", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_moderate_full", "permission_moderation_modpanel_unban" },
    { "permission_moderation_modpanel_restrict" },
    { "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_investigate_full" },
    { "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_pardon_full" },
    { "permission_moderation_modpanel_lock" }
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 66
    -- upvalues: Page (copy), u2 (copy), PromptSystem (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.PromptsFrame = v4.PageFrame:WaitForChild("Prompts");
    v4.PageContainer = v4.PageFrame:WaitForChild("Container");
    v4.CloseButton = v4.PageContainer:WaitForChild("Close");
    v4.List = v4.PageContainer:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.HeaderFrame = v4.Container:WaitForChild("Header");
    v4.InfoButton = v4.HeaderFrame:WaitForChild("Info");
    v4.InfoButtonBubble = v4.InfoButton:WaitForChild("Bubble");
    v4.InfoButtonBubbleTitle = v4.InfoButtonBubble:WaitForChild("Title");
    v4.InfoButtonBubbleBackground = v4.InfoButtonBubble:WaitForChild("Background");
    v4.PowersButton = v4.HeaderFrame:WaitForChild("Powers");
    v4.PowersButtonBubble = v4.PowersButton:WaitForChild("Bubble");
    v4.PowersButtonBubbleTitle = v4.PowersButtonBubble:WaitForChild("Container"):WaitForChild("Title");
    v4.LookupFrame = v4.Container:WaitForChild("Lookup");
    v4.LookupBox = v4.LookupFrame:WaitForChild("Box");
    v4.LookupButton = v4.LookupFrame:WaitForChild("Button");
    v4.LookupDropdownButton = v4.LookupFrame:WaitForChild("Dropdown");
    v4.DropdownReferenceFrame = v4.LookupFrame:WaitForChild("DropdownReference");
    v4.InvestigateFrame = v4.Container:WaitForChild("Investigate");
    v4.InvestigateContainer = v4.InvestigateFrame:WaitForChild("Container");
    v4.InvestigateWinStreaksFrame = v4.InvestigateContainer:WaitForChild("Top100WinStreaks");
    v4.InvestigateWinStreaksButton = v4.InvestigateWinStreaksFrame:WaitForChild("Button");
    v4.InvestigateTrueWinStreaksFrame = v4.InvestigateContainer:WaitForChild("Top100TrueWinStreaks");
    v4.InvestigateTrueWinStreaksButton = v4.InvestigateTrueWinStreaksFrame:WaitForChild("Button");
    v4.PlayerFrame = v4.Container:WaitForChild("Player");
    v4.PlayerWaitingFrame = v4.PlayerFrame:WaitForChild("Waiting");
    v4.PlayerWaitingDotsFrame = v4.PlayerWaitingFrame:WaitForChild("Dots");
    v4.PlayerLoadedFrame = v4.PlayerFrame:WaitForChild("Loaded");
    v4.PlayerLoadedActionsFrame = v4.PlayerLoadedFrame:WaitForChild("Actions");
    v4.PlayerLoadedInformationFrame = v4.PlayerLoadedFrame:WaitForChild("Information");
    v4.PlayerLoadedInformationPicture = v4.PlayerLoadedInformationFrame:WaitForChild("Picture"):WaitForChild("Picture");
    v4.PromptSystem = PromptSystem.new(v4.PromptsFrame);
    v4._ban_data = nil;
    v4._result_data = nil;
    v4._player_data = nil;
    v4._player_metadata = nil;
    v4._is_this_dude_banned = false;
    v4._ban_data_hash = 0;
    v4._lookup_disabled = false;
    v4._player_data_debounce = false;
    v4._last_rank_icon = nil;
    v4._dropdown_slot = nil;
    v4._cached_players = {};
    v4:_Init();

    return v4;
end;

function u2.SetBanData(u5, p6, p7) -- Line: 126
    -- upvalues: BanLibrary (copy), ServerOsTime (copy), SeasonLibrary (copy), CONSTANTS (copy), Utility (copy), RankIcon (copy), UserService (copy)
    local v8 = not p6 or typeof(p6) == "table";
    local v9 = "Argument 1 invalid, expected a table or nil, got " .. tostring(p6);
    assert(v8, v9);
    local v10 = not p7 or typeof(p7) == "table";
    local v11 = "Argument 2 invalid, expected a table or nil, got " .. tostring(p7);
    assert(v10, v11);
    u5._ban_data = p6;
    u5._result_data = p7;
    local v12;

    if u5._result_data then
        v12 = u5._result_data.RawData or nil;
    else
        v12 = nil;
    end;

    u5._player_data = v12;
    local v13;

    if u5._result_data then
        v13 = u5._result_data.Metadata or nil;
    else
        v13 = nil;
    end;

    u5._player_metadata = v13;
    u5._is_this_dude_banned = nil;
    u5._ban_data_hash = u5._ban_data_hash + 1;
    u5.PlayerLoadedFrame.Visible = u5._ban_data ~= nil;

    if u5._last_rank_icon then
        u5._last_rank_icon:Destroy();
        u5._last_rank_icon = nil;
    end;

    if not u5._ban_data then
        return;
    end;

    local _ban_data_hash = u5._ban_data_hash;
    local v14 = BanLibrary:IsBanned(u5._ban_data);
    local v15;

    if v14 then
        local v16 = v14.EndTime - ServerOsTime:GetRounded();
        v15 = math.max(0, v16);
    else
        v15 = v14;
    end;

    local v17 = u5._player_data and u5._player_data.RedFlags and u5._player_data.RedFlags[#u5._player_data.RedFlags];
    local v18 = u5._player_data and u5._player_data.SessionID ~= nil;
    local v19 = u5._player_data and u5._player_data.Level;
    local v20 = u5._player_data and u5._player_data.StatisticDuelsWinStreak;
    local v21 = u5._player_data and u5._player_data.LastKnownControls;
    local v22 = u5._player_data and (u5._player_data.Seasons and u5._player_data.Seasons[SeasonLibrary.CurrentSeason.Name]) and u5._player_data.Seasons[SeasonLibrary.CurrentSeason.Name].RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    local v23;

    if v22 then
        v23 = v22.CurrentELO;
    else
        v23 = v22;
    end;

    local v24;

    if v22 then
        v24 = SeasonLibrary:GetHighestELOLeaderboardRanking(v23, u5._ban_data.UserID);
    else
        v24 = v22;
    end;

    local v25;

    if v22 then
        v25 = SeasonLibrary:GetRank(v23, u5._ban_data.UserID, v24);
    else
        v25 = v22;
    end;

    if v25 then
        v25 = SeasonLibrary.CurrentSeason.RankProfile.Ranks[v25];
    end;

    local v26 = u5._ban_data.BanLocked and "🔒" or "";
    local v27 = u5._ban_data.Restrictions and u5._ban_data.Restrictions.RestrictedFromCasualLeaderboards;
    local v28 = u5._ban_data.Restrictions and u5._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards;
    local v29 = 0;
    local v30 = 0;

    for _, v in pairs(u5._ban_data.BanHistory) do
        if BanLibrary:IsBanLogAWarning(v) then
            v29 = v29 + 1;
        end;

        if BanLibrary:IsBanLogABan(v) then
            v30 = v30 + 1;
        end;
    end;

    u5._is_this_dude_banned = v14 ~= nil;
    u5.PlayerLoadedInformationPicture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, (tostring(u5._ban_data.UserID)));
    u5:_SetInformationFrameVisible("ELO", v22);
    u5:_SetInformationFrameText("ELO", (v23 and (Utility:PrettyNumber(v23) or "N/A") or "N/A") .. " " .. (v25 and v25.DisplayName or "N/A") .. " " .. (v24 and " #" .. v24 or ""));
    u5:_SetInformationFrameVisible("Level", v19);
    u5:_SetInformationFrameText("Level", v19 and Utility:PrettyNumber(v19) or "");
    local v31;

    if v20 then
        v31 = v20 > 0;
    else
        v31 = v20;
    end;

    u5:_SetInformationFrameVisible("WinStreak", v31);
    u5:_SetInformationFrameText("WinStreak", v20 and (v20 > 0 and Utility:PrettyNumber(v20)) or "");
    u5:_SetInformationFrameVisible("Controls", v21);
    u5:_SetInformationFrameText("Controls", v21 or "");
    u5:_SetInformationFrameText("Username", "@" .. u5._ban_data.Name);
    u5:_SetInformationFrameText("DisplayName", "• • •");
    u5:_SetInformationFrameText("UserID", "#" .. tostring(u5._ban_data.UserID));
    u5:_SetInformationFrameText("Online", v18 and "🟢 Online" or "🔴 Offline");
    u5:_SetInformationFrameText("Lock", u5._ban_data.BanLocked and "Locked" or "Not locked", u5._ban_data.BanLocked and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("Status", v26 .. (v14 and ("Banned [" .. (v14.Duration and v14.Duration >= BanLibrary.PERMANENT_BAN_DURATION and "Permanent" or Utility:TimeFormat2(v15)) .. "]" or "Not banned") or "Not banned"), v14 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("History", v26 .. (v14 and "🚨 " .. v14.Reason or (v30 > 0 and ("Banned " .. v30 .. " time" .. (v30 == 1 and "" or "s") or "No ban history") or "No ban history")), v14 and Color3.fromRGB(255, 50, 50) or (v30 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50)));
    u5:_SetInformationFrameText("Flags", v26 .. (v17 and (tostring(v17.Reason) or "Not flagged") or "Not flagged"), v17 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("CasualLBs", v26 .. (v27 and "Restricted" or "Not restricted"), v27 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("CompLBs", v26 .. (v28 and "Restricted" or "Not restricted"), v28 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("Warnings", v26 .. (v29 > 0 and (v29 .. " warning" .. (v29 == 1 and "" or "s") or "No warnings") or "No warnings"), v29 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50));

    if v22 then
        u5._last_rank_icon = RankIcon.new(v23, u5._ban_data.UserID);
        u5._last_rank_icon:SetParent(u5.PlayerRank);
    end;

    task.spawn(function() -- Line: 206
        -- upvalues: UserService (ref), u5 (copy), _ban_data_hash (copy)
        local UserInfosByUserIdsAsync = UserService:GetUserInfosByUserIdsAsync({ u5._ban_data.UserID });

        if _ban_data_hash ~= u5._ban_data_hash then
            return;
        end;

        if not (UserInfosByUserIdsAsync[1] and UserInfosByUserIdsAsync[1].DisplayName) then
            return;
        end;

        u5:_SetInformationFrameText("DisplayName", UserInfosByUserIdsAsync[1].DisplayName);
    end);
    u5:_UpdatePermissions();
end;

function u2.Open(u32, ...) -- Line: 223
    -- upvalues: Page (copy), ReplicatedStorage (copy)
    Page.Open(u32, ...);
    task.spawn(function() -- Line: 226
        -- upvalues: u32 (copy), ReplicatedStorage (ref)
        u32._cached_players = ReplicatedStorage.Remotes.Moderator.RequestCachedPlayers:InvokeServer() or u32._cached_players;
    end);
end;

function u2._SetActionButtonVisible(p33, p34, p35) -- Line: 235
    p33.PlayerLoadedActionsFrame:WaitForChild(p34).Visible = p35;
end;

function u2._SetInformationFrameText(p36, p37, p38, p39) -- Line: 239
    p36.PlayerLoadedInformationFrame:WaitForChild(p37):WaitForChild("Value").Text = p38;
    p36.PlayerLoadedInformationFrame:WaitForChild(p37):WaitForChild("Value").TextColor3 = p39 or Color3.fromRGB(255, 255, 255);
end;

function u2._SetInformationFrameVisible(p40, p41, p42) -- Line: 244
    p40.PlayerLoadedInformationFrame:WaitForChild(p41).Visible = p42;
end;

function u2._UpdatePowersButtonBubble(p43) -- Line: 248
    -- upvalues: PlayerDataController (copy), u1 (copy), PermissionsLibrary (copy)
    local v44 = PlayerDataController:Get("PermissionsRoles");
    local v45 = "";

    for i, v in pairs(u1) do
        if i > 1 then
            v45 = v45 .. "\n\n";
        end;

        for i2, v2 in pairs(v) do
            if i2 > 1 then
                v45 = v45 .. "\n";
            end;

            v45 = v45 .. string.format("%s %s", PermissionsLibrary:HasPermission(v2, v44) and "✅" or "🟥", PermissionsLibrary.Permissions[v2].Description);
        end;
    end;

    p43.PowersButtonBubbleTitle.Text = v45;
end;

function u2._UpdatePermissions(p46) -- Line: 269
    -- upvalues: PlayerDataController (copy), ModerationLibrary (copy)
    local v47 = PlayerDataController:Get("PermissionsRoles");
    local v48 = p46._ban_data and p46._ban_data.BanLocked;

    for _, v in pairs({ "Status", "CasualLBs", "CompLBs", "Flags", "History" }) do
        p46:_SetInformationFrameVisible(v, ModerationLibrary:CanViewBanStatusAndLogs(v47));
    end;

    p46.InvestigateFrame.Visible = ModerationLibrary:CanUseInvestigativeCommands(v47);
    p46:_SetActionButtonVisible("ViewLogs", ModerationLibrary:CanViewBanStatusAndLogs(v47));
    p46:_SetActionButtonVisible("ViewData", ModerationLibrary:CanViewData(v47));
    p46:_SetActionButtonVisible("ViewActions", ModerationLibrary:CanViewActionHistory(v47));
    p46:_SetActionButtonVisible("Lock", ModerationLibrary:CanManageBanLocks(v47));
    local v49 = not v48 and ModerationLibrary:CanEvict(v47);
    p46:_SetActionButtonVisible("Kick", v49);
    local v50 = not v48;

    if v50 then
        if p46._is_this_dude_banned then
            v50 = ModerationLibrary:CanUnban(v47);
        else
            v50 = ModerationLibrary:CanBan(v47);
        end;
    end;

    p46:_SetActionButtonVisible("Moderate", v50);
    local v51 = not v48 and ModerationLibrary:CanRemoveFromLeaderboards(v47);
    p46:_SetActionButtonVisible("Wipe", v51);
    local v52 = not v48 and ModerationLibrary:CanPardon(v47) and (p46._player_data and p46._player_data.RedFlags) and p46._player_data.RedFlags[#p46._player_data.RedFlags];
    p46:_SetActionButtonVisible("Pardon", v52);
    local v53 = not v48 and ModerationLibrary:CanRestrict(v47);
    p46:_SetActionButtonVisible("Restrict", v53);
    local v54 = not v48 and ModerationLibrary:CanWarnCustom(v47);
    p46:_SetActionButtonVisible("Warn", v54);
    p46:_UpdatePowersButtonBubble();
end;

function u2._UpdateLayouts(p55) -- Line: 292
    p55.InfoButtonBubbleBackground.Size = UDim2.new(0.0375, p55.InfoButtonBubbleTitle.TextBounds.X, 1, 0);
    p55.CloseButton.Position = UDim2.new(0.9, 0, 0.0225, p55.PageFrame.AbsoluteSize.Y * 0.125);
    p55.List.Position = UDim2.new(0.5, 9, 0, p55.PageFrame.AbsoluteSize.Y * 0.125);
    p55.List.Size = UDim2.new(0.7, 0, 0, p55.PageFrame.AbsoluteSize.Y * 0.75);
    p55.List.CanvasSize = UDim2.new(0, 0, 0, p55.Layout.AbsoluteContentSize.Y);
end;

function u2._PlayersLookupDropdown(u56) -- Line: 300
    -- upvalues: Utility (copy), Players (copy), DropdownSlot (copy)
    if u56._dropdown_slot then
        u56._dropdown_slot:Cancel();
        u56._dropdown_slot = nil;
    end;

    local v57 = Utility:CloneTable(u56._cached_players);

    for _, v in pairs(Players:GetPlayers()) do
        local v58 = string.upper(v.DisplayName) .. " (@" .. string.upper(v.Name) .. ")";

        if not table.find(v57, v58) then
            table.insert(v57, v58);
        end;
    end;

    table.sort(v57, function(p59, p60) -- Line: 316
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p59, p60);
    end);
    u56._dropdown_slot = DropdownSlot.new(u56.DropdownReferenceFrame, v57);
    u56._dropdown_slot.Selected:Connect(function(p61) -- Line: 322
        -- upvalues: u56 (copy)
        u56._dropdown_slot = nil;

        if not p61 then
            return;
        end;

        local LookupBox = u56.LookupBox;
        local v62 = string.find(p61, "@") + 1;
        LookupBox.Text = string.sub(p61, v62, #p61 - 1);
        task.defer(u56._FetchBanData, u56);
    end);
end;

function u2._FetchPlayerData(u63) -- Line: 334
    -- upvalues: ReplicatedStorage (copy)
    if u63._player_data_debounce then
        return;
    end;

    u63._player_data_debounce = true;
    local success, result = pcall(function() -- Line: 341
        -- upvalues: ReplicatedStorage (ref), u63 (copy)
        return ReplicatedStorage.Remotes.Moderator.RequestPlayerData:InvokeServer(u63._ban_data.Name);
    end);
    u63._player_data_debounce = false;

    if not success then
        u63.PromptSystem:Open("ErrorMessage", "Whoops!", "Something went wrong while fetching their data, error:", (tostring(result)));

        return;
    end;

    if result then
        u63.PromptSystem:Open("ViewPlayerData", u63._ban_data.Name, result);

        return;
    end;

    u63.PromptSystem:Open("ErrorMessage", "Whoops!", "This player has never played RIVALS before!");
end;

function u2._RawFetchBanData(p64, p65) -- Line: 356
    -- upvalues: ReplicatedStorage (copy)
    if p64._lookup_disabled then
        return;
    end;

    p64:SetBanData(nil);

    if not p65 or #p65 == 0 then
        return;
    end;

    p64._lookup_disabled = true;
    p64.PlayerWaitingFrame.Visible = true;
    p64.PlayerWaitingDotsFrame:AddTag("UILoadingDots");
    local v66 = ReplicatedStorage.Remotes.Moderator.RequestPlayer:InvokeServer(p65) or {};
    p64:SetBanData(table.unpack(v66));
    p64._lookup_disabled = false;
    p64.PlayerWaitingFrame.Visible = false;
    p64.PlayerWaitingDotsFrame:RemoveTag("UILoadingDots");
end;

function u2._FetchBanData(p67) -- Line: 378
    p67:_RawFetchBanData(p67.LookupBox.Text);
end;

function u2._SetupActionButton(p68, p69, p70) -- Line: 382
    -- upvalues: ButtonEffect (copy)
    local Button = p68.PlayerLoadedActionsFrame:WaitForChild(p69):WaitForChild("Button");
    local Title = Button:WaitForChild("Title");
    local Description = Button:WaitForChild("Description");
    local Icon = Button:WaitForChild("Icon");
    local Background = Button:WaitForChild("Background");
    local UIGradient = Background:WaitForChild("UIGradient");
    local ImageColor3 = Background.ImageColor3;
    Button.MouseEnter:Connect(function() -- Line: 393, Name: enter
        -- upvalues: Background (copy), Title (copy), Description (copy), Icon (copy), UIGradient (copy)
        Background.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Background.ImageTransparency = 0;
        Background.Size = UDim2.new(0.725, 0, 1, 0);
        Title.TextColor3 = Color3.fromRGB(0, 0, 0);
        Description.TextColor3 = Color3.fromRGB(0, 0, 0);
        Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
        UIGradient.Enabled = false;
    end);

    local function leave() -- Line: 405
        -- upvalues: Background (copy), ImageColor3 (copy), Title (copy), Description (copy), Icon (copy), UIGradient (copy)
        Background.ImageColor3 = ImageColor3;
        Background.ImageTransparency = 0.5;
        Background.Size = UDim2.new(1, 0, 1, 0);
        Title.TextColor3 = Color3.fromRGB(255, 255, 255);
        Description.TextColor3 = Color3.fromRGB(255, 255, 255);
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
        UIGradient.Enabled = true;
    end;

    Button.MouseLeave:Connect(leave);
    leave();
    Button.MouseButton1Click:Connect(p70);
    ButtonEffect:Add(Button, true);
end;

function u2._Init(u71) -- Line: 422
    -- upvalues: ReplicatedStorage (copy), PlayerDataController (copy), ButtonEffect (copy)
    u71.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 423
        -- upvalues: u71 (copy)
        u71:_UpdateLayouts();
    end);
    u71.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 427
        -- upvalues: u71 (copy)
        u71:_UpdateLayouts();
    end);
    u71.InfoButtonBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 431
        -- upvalues: u71 (copy)
        u71:_UpdateLayouts();
    end);
    u71.CloseButton.MouseButton1Click:Connect(function() -- Line: 435
        -- upvalues: u71 (copy)
        u71:CloseRequest();
    end);
    u71.InvestigateWinStreaksButton.MouseButton1Click:Connect(function() -- Line: 439
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Moderator.CheckTop100Streaks:FireServer();
    end);
    u71.InvestigateTrueWinStreaksButton.MouseButton1Click:Connect(function() -- Line: 443
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Moderator.CheckTop100TrueStreaks:FireServer();
    end);
    u71.LookupButton.MouseButton1Click:Connect(function() -- Line: 447
        -- upvalues: u71 (copy)
        u71:_FetchBanData();
    end);
    u71.LookupDropdownButton.MouseButton1Click:Connect(function() -- Line: 451
        -- upvalues: u71 (copy)
        u71:_PlayersLookupDropdown();
    end);
    u71.InfoButton.MouseButton1Click:Connect(function() -- Line: 455
        -- upvalues: u71 (copy)
        u71.InfoButtonBubble.Visible = not u71.InfoButtonBubble.Visible;
    end);
    u71.PowersButton.MouseButton1Click:Connect(function() -- Line: 459
        -- upvalues: u71 (copy)
        u71.PowersButtonBubble.Visible = not u71.PowersButtonBubble.Visible;
    end);
    u71:_SetupActionButton("Moderate", function() -- Line: 463
        -- upvalues: u71 (copy)
        if u71._is_this_dude_banned then
            u71.PromptSystem:Open("Unban", u71._ban_data);

            return;
        end;

        u71.PromptSystem:Open("Ban", u71._ban_data);
    end);
    u71:_SetupActionButton("ViewLogs", function() -- Line: 471
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("InspectBanLogs", u71._ban_data);
    end);
    u71:_SetupActionButton("Join", function() -- Line: 475
        -- upvalues: ReplicatedStorage (ref), u71 (copy)
        ReplicatedStorage.Remotes.Moderator.Join:FireServer(u71._ban_data.Name);
    end);
    u71:_SetupActionButton("Kick", function() -- Line: 479
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("Kick", u71._ban_data);
    end);
    u71:_SetupActionButton("ViewData", function() -- Line: 483
        -- upvalues: u71 (copy)
        if u71._result_data then
            u71.PromptSystem:Open("ViewPlayerData", u71._ban_data.Name, u71._result_data);

            return;
        end;

        u71:_FetchPlayerData();
    end);
    u71:_SetupActionButton("Pardon", function() -- Line: 491
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("Pardon", u71._ban_data);
    end);
    u71:_SetupActionButton("Lock", function() -- Line: 495
        -- upvalues: ReplicatedStorage (ref), u71 (copy)
        ReplicatedStorage.Remotes.Moderator.LockBans:FireServer(u71._ban_data.Name);
    end);
    u71:_SetupActionButton("ViewActions", function() -- Line: 499
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("InspectActionLogs", u71._ban_data);
    end);
    u71:_SetupActionButton("Wipe", function() -- Line: 503
        -- upvalues: ReplicatedStorage (ref), u71 (copy)
        ReplicatedStorage.Remotes.Moderator.RemoveFromLeaderboards:FireServer(u71._ban_data.Name);
    end);
    u71:_SetupActionButton("Restrict", function() -- Line: 507
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("Restrict", u71._ban_data);
    end);
    u71:_SetupActionButton("Warn", function() -- Line: 511
        -- upvalues: u71 (copy)
        u71.PromptSystem:Open("Warn", u71._ban_data);
    end);
    PlayerDataController:GetDataChangedSignal("PermissionsRoles"):Connect(function() -- Line: 515
        -- upvalues: u71 (copy)
        u71:_UpdatePermissions();
    end);
    ReplicatedStorage.Remotes.Moderator.UpdateBanData.OnClientEvent:Connect(function(p72) -- Line: 519
        -- upvalues: u71 (copy)
        u71:SetBanData(p72, u71._result_data);
    end);
    u71:_UpdateLayouts();
    u71:_UpdatePermissions();
    u71:SetBanData(nil);
    ButtonEffect:Add(u71.CloseButton);
    ButtonEffect:Add(u71.InvestigateWinStreaksButton);
    ButtonEffect:Add(u71.InvestigateTrueWinStreaksButton);
    ButtonEffect:Add(u71.LookupButton);
    ButtonEffect:Add(u71.LookupDropdownButton);
    ButtonEffect:Add(u71.InfoButton);
    ButtonEffect:Add(u71.PowersButton);
end;

return u2._new();