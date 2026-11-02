-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local ELOBar = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ELOBar");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 14
    -- upvalues: u1 (copy), ELOBar (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = ELOBar:Clone();
    v2.ProgressBar = v2.Frame:WaitForChild("Progress"):WaitForChild("Bar");
    v2.ProgressBarTexture = v2.ProgressBar:WaitForChild("Texture");
    v2.LeftRankText = v2.Frame:WaitForChild("LeftRank");
    v2.LeftELOText = v2.Frame:WaitForChild("LeftELO");
    v2.CurrentELOTitle = v2.Frame:WaitForChild("CurrentELOTitle");
    v2.CurrentELOText = v2.Frame:WaitForChild("CurrentELO");
    v2.RightRankText = v2.Frame:WaitForChild("RightRank");
    v2.RightELOText = v2.Frame:WaitForChild("RightELO");
    v2.RankCurrentFrame = v2.Frame:WaitForChild("RankCurrent");
    v2.RankNextFrame = v2.Frame:WaitForChild("RankNext");
    v2._is_enabled = nil;
    v2._update_hash = 0;
    v2._current_rank_icon = nil;
    v2._next_rank_icon = nil;
    v2._preloaded_rank_icons = false;
    v2:_Init();

    return v2;
end;

function u1.SetParent(p3, p4) -- Line: 44
    p3.Frame.Parent = p4;
end;

function u1.Update(p5, p6) -- Line: 48
    p5._is_enabled = p6;
    p5._update_hash = p5._update_hash + 1;
    p5:_Update();
end;

function u1.Destroy(p7) -- Line: 54
    p7.Frame:Destroy();
end;

function u1._Update(u8) -- Line: 62
    -- upvalues: SeasonLibrary (copy), PlayerDataController (copy), Players (copy), Utility (copy), RankIcon (copy)
    if u8._current_rank_icon then
        u8._current_rank_icon:Destroy();
        u8._current_rank_icon = nil;
    end;

    if u8._next_rank_icon then
        u8._next_rank_icon:Destroy();
        u8._next_rank_icon = nil;
    end;

    u8.Frame.Visible = false;

    if not u8._is_enabled then
        return;
    end;

    local RankProfile = SeasonLibrary.CurrentSeason.RankProfile;
    local v9 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v9 then
        v9 = v9.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if not v9 then
        return;
    end;

    local Rank = SeasonLibrary:GetRank(v9.CurrentELO, Players.LocalPlayer.UserId);
    local v10 = RankProfile.Ranks[Rank];
    local RanksOrder = RankProfile.RanksOrder;
    local v11 = #RankProfile.RanksOrder;
    local v12 = table.find(RankProfile.RanksOrder, Rank) + 1;
    local v13 = RanksOrder[math.min(v11, v12)];
    local v14 = RankProfile.Ranks[v13];
    local v15 = v14.RequiredELO and v10.RequiredELO and v14.RequiredELO - v10.RequiredELO == 0;
    local v16;

    if v9.CurrentELO then
        v16 = v13 == Rank and 1 or (v15 and 0.5 or (v9.CurrentELO - v10.RequiredELO) / (v14.RequiredELO - v10.RequiredELO));
    else
        v16 = v9.DuelsPlayed / SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels;
    end;

    if v16 <= 0 then
        v16 = 0;
    elseif not v15 then
        v16 = math.clamp(v16, 0, 1) * 0.9 + 0.1;
    end;

    local v17 = RankProfile.Groups[v10.RankGroupName];

    if v15 then
        Rank = RankProfile.RanksOrder[table.find(RankProfile.RanksOrder, v13) - 1];
        v10 = RankProfile.Ranks[Rank];
        v17 = RankProfile.Groups[v14.RankGroupName];
    end;

    u8.ProgressBar.BackgroundColor3 = v17.Color;
    u8.ProgressBar.Size = UDim2.new(0, 0, 1, 0);
    u8.ProgressBarTexture.ImageColor3 = v17.SecondaryColor;
    u8.ProgressBar:TweenSize(UDim2.new(v16, 0, 1, 0), "InOut", "Quint", 0.5, true);
    u8.LeftRankText.Text = Rank;
    u8.LeftELOText.Text = not v9.CurrentELO and "" or Utility:PrettyNumber(v10.RequiredELO);
    u8.CurrentELOTitle.Text = v9.CurrentELO and "Your ELO" or "Play Ranked";
    local CurrentELOText = u8.CurrentELOText;
    local v18;

    if v9.CurrentELO then
        v18 = Utility:PrettyNumber(v9.CurrentELO);
    else
        v18 = v9.DuelsPlayed .. " / " .. SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels;
    end;

    CurrentELOText.Text = v18;
    u8.RightRankText.Text = not v9.CurrentELO and "Unlock your rank" or v13;
    local RightELOText = u8.RightELOText;
    local v19;

    if v9.CurrentELO then
        if v14.RequiredELOLeaderboardRanking then
            v19 = "Top " .. Utility:PrettyNumber(v14.RequiredELOLeaderboardRanking);
        else
            v19 = Utility:PrettyNumber(v14.RequiredELO);
        end;
    else
        v19 = "";
    end;

    RightELOText.Text = v19;
    local v20;

    if v9.CurrentELO then
        v20 = v9.CurrentELO;
    else
        v20 = nil;
    end;

    local v21;

    if v9.CurrentELO then
        v21 = v10.RequiredELOLeaderboardRanking;
    else
        v21 = nil;
    end;

    u8._current_rank_icon = RankIcon.new(v20, nil, v21 or (1 / 0));
    u8._current_rank_icon:SetParent(u8.RankCurrentFrame);

    if v9.CurrentELO then
        local v22;

        if v9.CurrentELO then
            v22 = v14.RequiredELO;
        else
            v22 = nil;
        end;

        local v23;

        if v9.CurrentELO then
            v23 = v14.RequiredELOLeaderboardRanking;
        else
            v23 = nil;
        end;

        u8._next_rank_icon = RankIcon.new(v22, nil, v23 or (1 / 0));
        u8._next_rank_icon:SetParent(u8.RankNextFrame);
    else
        if not u8._preloaded_rank_icons then
            u8._preloaded_rank_icons = true;

            for _, v in pairs(RankProfile.GroupsOrder) do
                local v24 = RankProfile.Groups[v];
                local v25 = RankProfile.Ranks[v24.Ranks[#v24.Ranks]];
                local v26 = RankIcon.new(v25.RequiredELO, nil, v25.RequiredELOLeaderboardRanking or (1 / 0));
                v26.Frame.Size = UDim2.new(0, 0, 0, 0);
                v26:SetParent(u8.RankNextFrame);
            end;
        end;

        task.spawn(function() -- Line: 144
            -- upvalues: u8 (copy), RankProfile (copy), RankIcon (ref)
            local _update_hash = u8._update_hash;

            while true do
                for i, v in pairs(RankProfile.GroupsOrder) do
                    if i ~= 1 then
                        if _update_hash ~= u8._update_hash then
                            return;
                        end;

                        if u8._next_rank_icon then
                            u8._next_rank_icon:Destroy();
                            u8._next_rank_icon = nil;
                        end;

                        local v27 = RankProfile.Groups[v];
                        local v28 = RankProfile.Ranks[v27.Ranks[#v27.Ranks]];
                        u8._next_rank_icon = RankIcon.new(v28.RequiredELO, nil, v28.RequiredELOLeaderboardRanking or (1 / 0));
                        u8._next_rank_icon:SetParent(u8.RankNextFrame);
                        wait(1);
                    end;
                end;
            end;
        end);
    end;

    u8.Frame.Visible = true;
end;

function u1._Init(p29) -- Line: 177
    p29:Update(false);
end;

return u1;