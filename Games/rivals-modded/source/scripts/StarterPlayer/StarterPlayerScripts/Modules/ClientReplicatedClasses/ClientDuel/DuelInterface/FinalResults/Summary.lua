-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local ELOBar = require(Players.LocalPlayer.PlayerScripts.Modules.ELOBar);
local UDim2_new_ret = UDim2.new(0.8, 0, 0.8, 0);
local UDim2_new_ret2 = UDim2.new(0.5, 0, 0.5, 0);
local UDim2_new_ret3 = UDim2.new(0.5, 0, 0.5, 0);
local UDim2_new_ret4 = UDim2.new(0.5, 0, 0.375, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy), ELOBar (copy)
    local v3 = setmetatable({}, u1);
    v3.FinalResults = p2;
    v3.ELOBar = ELOBar.new();
    v3.Frame = v3.FinalResults.Frame:WaitForChild("Summary");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.CardFrame = v3.Container:WaitForChild("Card");
    v3.BarContainer = v3.CardFrame:WaitForChild("BarContainer");
    v3.RankFrame = v3.CardFrame:WaitForChild("Rank");
    v3.RankHeaderFrame = v3.RankFrame:WaitForChild("Header");
    v3.RankHeaderText = v3.RankHeaderFrame:WaitForChild("Title");
    v3.RankHeaderTextLeftIcon = v3.RankHeaderText:WaitForChild("Left");
    v3.RankHeaderTextRightIcon = v3.RankHeaderText:WaitForChild("Right");
    v3.RankHeaderBackground = v3.RankHeaderFrame:WaitForChild("Background");
    v3._last_rank_icon = nil;
    v3._summary_details_hash = 0;
    v3._summary_details = nil;
    v3:_Init();

    return v3;
end;

function u1.GetLocalPlayerPreviousELO(p4) -- Line: 60
    -- upvalues: Players (copy)
    if not p4._summary_details then
        return Players.LocalPlayer:GetAttribute("DisplayELO");
    end;

    if p4._summary_details.SummaryType == "RankedELOChanged" then
        return p4._summary_details.PreviousELO;
    end;

    return nil;
end;

function u1.HasDetailsReady(p5) -- Line: 70
    return p5._summary_details ~= nil;
end;

function u1.SetDetails(p6, p7) -- Line: 74
    p6._summary_details = p7;
    p6._summary_details_hash = p6._summary_details_hash + 1;
end;

function u1.SetVisible(p8, p9) -- Line: 79
    p8.Frame.Visible = p9;
    p8._summary_details_hash = p8._summary_details_hash + 1;

    if p9 then
        p8:DisplaySummaryDetails();
    end;
end;

function u1.DisplaySummaryDetails(u10) -- Line: 88
    -- upvalues: UDim2_new_ret (copy), UDim2_new_ret2 (copy), Utility (copy), SeasonLibrary (copy), Players (copy), UDim2_new_ret3 (copy), UDim2_new_ret4 (copy)
    u10._summary_details_hash = u10._summary_details_hash + 1;
    local _summary_details_hash = u10._summary_details_hash;
    u10:_PlayCountingSound(0);
    u10:_PlayPromoteSound(0);
    u10:_PlayDemoteSound(0);
    u10:_PlayShieldSound(0);
    u10.BarContainer.Visible = false;
    u10.RankFrame.Size = UDim2.new(0, 0, 0, 0);
    u10.RankFrame.Position = UDim2.new(0.5, 0, 1, 0);
    u10.RankFrame:TweenSizeAndPosition(UDim2_new_ret, UDim2_new_ret2, "Out", "Quint", 0.5, true);
    u10.RankHeaderText.Text = "";
    u10.RankHeaderTextLeftIcon.Visible = false;
    u10.RankHeaderTextRightIcon.Visible = false;

    if u10._summary_details.SummaryType == "RankedPlacementsProgress" then
        u10:_CreateRankIcon(nil):SetParent(u10.RankFrame);
        wait(0.5);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;
    elseif u10._summary_details.SummaryType == "RankedPlacementsComplete" then
        local u11 = u10:_CreateRankIcon(nil);
        u11:SetLabelFromELOEvent(nil, nil, 0);
        u11:SetParent(u10.RankFrame);
        wait(0.5);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        u10:_PlayCountingSound();
        Utility:RenderstepForLoop(0, 100, 2, function(p12) -- Line: 128
            -- upvalues: _summary_details_hash (copy), u10 (copy), u11 (copy), SeasonLibrary (ref)
            if _summary_details_hash ~= u10._summary_details_hash then
                return true;
            end;

            u11:SetLabelFromELOEvent(nil, nil, (math.floor(SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels * (p12 / 100))));
        end);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        wait(1);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        u10.RankHeaderText.Text = "Congratulations! You\'ve placed " .. SeasonLibrary:GetRank(u10._summary_details.PlacementELO, Players.LocalPlayer.UserId);
        u10:_PlayPromoteSound();
        u10:_CreateRankIcon(u10._summary_details.PlacementELO):SetParent(u10.RankFrame);
        u10.RankFrame.Size = UDim2_new_ret + UDim2.new(0.4, 0, 0.4, 0);
        u10.RankFrame:TweenSize(UDim2_new_ret, "Out", "Back", 0.25, true);
        wait(1);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;
    elseif u10._summary_details.SummaryType == "RankedELOChanged" then
        local u13 = u10:_CreateRankIcon(u10._summary_details.PreviousELO);
        u13:SetParent(u10.RankFrame);
        wait(0.5);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        u10:_PlayCountingSound();
        local v14 = u10._summary_details.CurrentELO - u10._summary_details.PreviousELO;
        local u15 = u10._summary_details.ELOSaved or v14;
        Utility:RenderstepForLoop(0, 100, 2, function(p16) -- Line: 177
            -- upvalues: _summary_details_hash (copy), u10 (copy), u13 (copy), u15 (copy), SeasonLibrary (ref)
            if _summary_details_hash ~= u10._summary_details_hash then
                return true;
            end;

            u13:SetLabelFromELOEvent(math.floor(u15 * (p16 / 100)), u10._summary_details.PreviousELO, SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels);
        end);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        wait(1);

        if _summary_details_hash ~= u10._summary_details_hash then
            return;
        end;

        local Rank = SeasonLibrary:GetRank(u10._summary_details.PreviousELO, Players.LocalPlayer.UserId);
        local Rank2 = SeasonLibrary:GetRank(u10._summary_details.CurrentELO, Players.LocalPlayer.UserId);

        if u10._summary_details.ELOSaved then
            u13:SetLabelFromELOEvent(v14, u10._summary_details.PreviousELO, SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels);
            u10.RankFrame.Position = UDim2_new_ret2 + UDim2.new(0, 0, 0.15, 0);
            u10.RankFrame:TweenPosition(UDim2_new_ret2, "Out", "Quint", 0.25, true);
            u10.RankHeaderText.Text = string.format("Your ELO Shield saved you from <font color=\"rgb(255,50,50)\">%s ELO</font>", u10._summary_details.ELOSaved);
            u10.RankHeaderTextLeftIcon.Visible = true;
            u10.RankHeaderTextRightIcon.Visible = true;
            u10.RankHeaderTextLeftIcon.Image = "rbxassetid://118920750856778";
            u10.RankHeaderTextRightIcon.Image = "rbxassetid://118920750856778";
            u10:_PlayShieldSound();
            wait(1);

            if _summary_details_hash ~= u10._summary_details_hash then
                return;
            end;
        elseif Rank ~= Rank2 then
            local v17 = u10:_CreateRankIcon(u10._summary_details.CurrentELO);
            v17:SetLabelFromELOEvent(u15, u10._summary_details.CurrentELO, SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels);
            v17:SetParent(u10.RankFrame);
            u10.RankFrame.Size = UDim2_new_ret + UDim2.new(0.4, 0, 0.4, 0);
            u10.RankFrame:TweenSize(UDim2_new_ret, "Out", "Back", 0.25, true);

            if u10._summary_details.CurrentELO > u10._summary_details.PreviousELO then
                u10.RankHeaderText.Text = "Congratulations! You\'ve promoted to " .. Rank2;
                u10:_PlayPromoteSound();
            else
                u10.RankHeaderText.Text = "You\'ve demoted to " .. Rank2;
                u10:_PlayDemoteSound();
            end;

            wait(1);

            if _summary_details_hash ~= u10._summary_details_hash then
                return;
            end;
        end;
    else
        assert(false, u10._summary_details.SummaryType);
    end;

    u10.RankFrame:TweenSizeAndPosition(UDim2_new_ret3, UDim2_new_ret4, "Out", "Quint", 0.5, true);
    wait(0.1);

    if _summary_details_hash ~= u10._summary_details_hash then
        return;
    end;

    u10.BarContainer.Visible = true;
    u10.ELOBar:Update(true);
end;

function u1.Destroy(p18) -- Line: 256
    p18._summary_details_hash = p18._summary_details_hash + 1;
    p18.ELOBar:Destroy();
end;

function u1._PlayCountingSound(p19, p20) -- Line: 265
    p19.FinalResults.DuelInterface:CreateSound("rbxassetid://99054764924747", 1 * (p20 or 1), 1, script, true, 10);
end;

function u1._PlayPromoteSound(p21, p22) -- Line: 271
    local v23 = p22 or 1;
    p21.FinalResults.DuelInterface:CreateSound("rbxassetid://138975587469438", 1 * v23, 1, script, true, 10);
    task.delay(0.125, p21.FinalResults.DuelInterface.CreateSound, p21.FinalResults.DuelInterface, "rbxassetid://70643163489676", 1 * v23, 1, script, true, 10);
end;

function u1._PlayDemoteSound(p24, p25) -- Line: 279
    local v26 = p25 or 1;
    p24.FinalResults.DuelInterface:CreateSound("rbxassetid://70643163489676", 1 * v26, 0.75, script, true, 10);
    p24.FinalResults.DuelInterface:CreateSound("rbxassetid://91547731028928", 1 * v26, 1, script, true, 10);
end;

function u1._PlayShieldSound(p27, p28) -- Line: 286
    local v29 = p28 or 1;
    p27.FinalResults.DuelInterface:CreateSound("rbxassetid://132313563275913", 0.75 * v29, 2, script, true, 10);
    p27.FinalResults.DuelInterface:CreateSound("rbxassetid://128864122802098", 1 * v29, 1.5, script, true, 10);
end;

function u1._CreateRankIcon(p30, p31) -- Line: 293
    -- upvalues: RankIcon (copy), Players (copy)
    if p30._last_rank_icon then
        p30._last_rank_icon:Destroy();
        p30._last_rank_icon = nil;
    end;

    p30._last_rank_icon = RankIcon.new(p31, Players.LocalPlayer.UserId);

    return p30._last_rank_icon;
end;

function u1._UpdateHeader(p32) -- Line: 304
    p32.RankHeaderBackground.Size = UDim2.new(0, p32.RankHeaderText.TextBounds.X + p32.RankHeaderText.TextBounds.Y * 1.5 + (not (p32.RankHeaderTextLeftIcon.Visible or p32.RankHeaderTextRightIcon.Visible) and 0 or p32.RankHeaderTextLeftIcon.AbsoluteSize.X + p32.RankHeaderTextRightIcon.AbsoluteSize.X), 1, 0);
    p32.RankHeaderBackground.Visible = p32.RankHeaderText.TextBounds.X > 0;
    p32.RankHeaderTextLeftIcon.Position = UDim2.new(0.5, -p32.RankHeaderText.TextBounds.X / 2, 0.5, 0);
    p32.RankHeaderTextRightIcon.Position = UDim2.new(0.5, p32.RankHeaderText.TextBounds.X / 2, 0.5, 0);
end;

function u1._Setup(p33) -- Line: 313
    p33.ELOBar:SetParent(p33.BarContainer);
end;

function u1._Init(u34) -- Line: 317
    u34.RankHeaderText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 318
        -- upvalues: u34 (copy)
        u34:_UpdateHeader();
    end);
    u34.RankHeaderTextLeftIcon:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 322
        -- upvalues: u34 (copy)
        u34:_UpdateHeader();
    end);
    u34.RankHeaderTextLeftIcon:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 326
        -- upvalues: u34 (copy)
        u34:_UpdateHeader();
    end);
    u34.RankHeaderTextRightIcon:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 330
        -- upvalues: u34 (copy)
        u34:_UpdateHeader();
    end);
    u34.RankHeaderTextRightIcon:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 334
        -- upvalues: u34 (copy)
        u34:_UpdateHeader();
    end);
    u34:_Setup();
    u34:_UpdateHeader();
end;

return u1;