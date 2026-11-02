-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local RankGraphSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RankGraphSlot");
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 18
    -- upvalues: Prompt (copy), u1 (copy)
    local v4 = Prompt.new(script.Name);
    local v5 = setmetatable(v4, u1);
    v5.CloseButton = v5.PromptFrame:WaitForChild("Close");
    v5.List = v5.PromptFrame:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.Layout = v5.Container:WaitForChild("Layout");
    v5.ELOShieldMaxELOAllowedText = v5.Container:WaitForChild("ELOShieldMaxELOAllowed");
    v5.ELODecayPeriodText = v5.Container:WaitForChild("ELODecayPeriod");
    v5.ELODecayAmountText = v5.Container:WaitForChild("ELODecayAmount");
    v5.RanksFrame = v5.Container:WaitForChild("Ranks");
    v5.RanksContainer = v5.RanksFrame:WaitForChild("Container");
    v5._rank_icons = {};
    v5:_Init();

    return v5;
end;

function u1.Destroy(p6) -- Line: 42
    -- upvalues: Prompt (copy)
    for _, v in pairs(p6._rank_icons) do
        v:Destroy();
    end;

    Prompt.Destroy(p6);
end;

function u1._UpdateList(p7) -- Line: 54
    p7.List.CanvasSize = UDim2.new(0, 0, 0, p7.Layout.AbsoluteContentSize.Y);
    p7.List.ClipsDescendants = true;
end;

function u1._GetELORange(p8, p9) -- Line: 59
    -- upvalues: SeasonLibrary (copy), Utility (copy)
    local RequiredELOLeaderboardRanking = SeasonLibrary.CurrentSeason.RankProfile.Ranks[SeasonLibrary.CurrentSeason.RankProfile.Groups[p9].Ranks[1]].RequiredELOLeaderboardRanking;

    if RequiredELOLeaderboardRanking then
        return "Top " .. Utility:PrettyNumber(RequiredELOLeaderboardRanking);
    end;

    local v10 = nil;
    local v11 = nil;

    for _, v in pairs(SeasonLibrary.CurrentSeason.RankProfile.RanksOrder) do
        local v12 = SeasonLibrary.CurrentSeason.RankProfile.Ranks[v];

        if v10 or v12.RankGroupName ~= p9 then
            if v10 and v12.RankGroupName ~= p9 then
                v11 = v12.RequiredELO - 1;
                break;
            end;
        else
            v10 = v12.RequiredELO;
        end;
    end;

    if not v10 then
        return "";
    end;

    if v11 then
        return Utility:PrettyNumber(v10) .. "+";
    end;

    return Utility:PrettyNumber(v10) .. "+";
end;

function u1._Setup(p13) -- Line: 89
    -- upvalues: SeasonLibrary (copy), RankGraphSlot (copy), RankIcon (copy), Utility (copy)
    local v14 = #SeasonLibrary.CurrentSeason.RankProfile.GroupsOrder - 1;

    for i, v in pairs(SeasonLibrary.CurrentSeason.RankProfile.GroupsOrder) do
        if i ~= 1 then
            local v15 = SeasonLibrary.CurrentSeason.RankProfile.Groups[v];
            local Color = v15.Color;
            local SecondaryColor = v15.SecondaryColor;
            local v16 = v15.SecondaryColor ~= Color3.fromRGB(0, 0, 0);
            local v17 = RankGraphSlot:Clone();
            v17.Bar.Title.Text = v;

            if not v16 then
                SecondaryColor = Color;
            end;

            v17.Bar.Background.ImageColor3 = SecondaryColor;
            v17.Bar.BackgroundStriped.ImageColor3 = Color;
            v17.Bar.BackgroundStriped.Visible = v16;
            v17.Bar.Rank.ELO.UIStroke.Color = Color3.new(v15.Color.R * 0.25, v15.Color.G * 0.25, v15.Color.B * 0.25);
            v17.Bar.Rank.ELO.Text = p13:_GetELORange(v);
            v17.Bar.Size = UDim2.new(0.9, 0, 0.3 + 0.5 * (i - 2) / (v14 - 1), 0);
            v17.Size = UDim2.new(1 / v14, 0, 1, 0);
            v17.LayoutOrder = i;
            v17.ZIndex = i;
            v17.Parent = p13.RanksContainer;
            local v18 = SeasonLibrary.CurrentSeason.RankProfile.Ranks[v15.Ranks[#v15.Ranks]];
            local v19 = RankIcon.new(v18.RequiredELO, nil, v18.RequiredELOLeaderboardRanking or (1 / 0));
            v19:SetParent(v17.Bar.Rank);
            table.insert(p13._rank_icons, v19);
        end;
    end;

    p13.ELOShieldMaxELOAllowedText.Visible = SeasonLibrary.CurrentSeason.ELOShieldMaxELOAllowed or false;
    p13.ELOShieldMaxELOAllowedText.Text = not p13.ELOShieldMaxELOAllowedText.Visible and "" or string.format(" • Players with %s+ ELO do not receive ELO Shields", Utility:PrettyNumber(SeasonLibrary.CurrentSeason.ELOShieldMaxELOAllowed));
    p13.ELODecayPeriodText.Visible = SeasonLibrary.CurrentSeason.ELODecayThreshold or false;
    p13.ELODecayPeriodText.Text = not p13.ELODecayPeriodText.Visible and "" or string.format(" • Players with %s+ ELO must play Ranked atleast once every %s to avoid ELO Decay", Utility:PrettyNumber(SeasonLibrary.CurrentSeason.ELODecayThreshold), Utility:TimeFormat2(SeasonLibrary.CurrentSeason.ELODecayInactivePeriodDays * 24 * 60 * 60, true));
    p13.ELODecayAmountText.Visible = SeasonLibrary.CurrentSeason.ELODecayThreshold or false;
    p13.ELODecayAmountText.Text = not p13.ELODecayAmountText.Visible and "" or string.format(" • ELO Decay makes you lose %s ELO for every day you remain inactive", Utility:PrettyNumber((math.abs(SeasonLibrary.CurrentSeason.ELODecayPerInactiveDay))));
end;

function u1._Init(u20) -- Line: 129
    -- upvalues: ButtonEffect (copy)
    u20.CloseButton.MouseButton1Click:Connect(function() -- Line: 130
        -- upvalues: u20 (copy)
        u20:CloseRequest();
    end);
    u20.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 134
        -- upvalues: u20 (copy)
        u20:_UpdateList();
    end);
    u20.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 138
        -- upvalues: u20 (copy)
        u20:_UpdateList();
    end);
    u20:_Setup();
    u20:_UpdateList();
    ButtonEffect:Add(u20.CloseButton);
end;

return u1;