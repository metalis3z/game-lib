-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local VoteBanFrame = require(Players.LocalPlayer.PlayerScripts.Modules.VoteBanFrame);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local VoterSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("VoterSlot");
local MapSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MapSlot");
local u1 = {
    ReleaseRatio = 1.025,
    HoverRatio = 1.025
};
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 19
    -- upvalues: u2 (copy), Signal (copy), MapSlot (copy), VoteBanFrame (copy)
    local v5 = setmetatable({}, u2);
    v5.CreateSound = Signal.new();
    v5.Name = p3;
    v5.Frame = MapSlot:Clone();
    v5.VoteBanFrame = VoteBanFrame.new(v5.Frame.Button);
    v5._ignore_button_effect = p4;
    v5._voter_slots = {};
    v5._is_banned = false;
    v5._tag_background = v5.Frame.Button.Tag.Background;
    v5._tag_title = v5.Frame.Button.Tag.Title;
    v5:_Init();

    return v5;
end;

function u2.SetParent(p6, p7) -- Line: 43
    p6.Frame.Parent = p7;
end;

function u2.UpdateVotes(p8, p9, p10, p11, p12, p13, p14) -- Line: 47
    -- upvalues: VoterSlot (copy), CONSTANTS (copy), DuelLibrary (copy)
    local v15 = {};

    for _, v in pairs(p11 or {}) do
        v15[tostring(v)] = true;

        if not p8._voter_slots[tostring(v)] then
            local v16 = VoterSlot:Clone();
            v16.Headshot.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, v);
            v16.Background.ImageColor3 = DuelLibrary:GetTeamColor(p12[tostring(v)]);
            v16.Parent = p8.Frame.Button.Votes;
            p8._voter_slots[tostring(v)] = v16;
        end;
    end;

    local v17 = {};

    for i, v in pairs(p8._voter_slots) do
        if not v15[i] then
            v17[i] = true;
            v:Destroy();
        end;
    end;

    for i in pairs(v17) do
        p8._voter_slots[i] = nil;
    end;

    p8.Frame.Button.Votes.Visible = p9 ~= nil;
    p8.Frame.Button.Title.Text = p8.Name .. ((p14 ~= "Chance" or (not p9 or p9 <= 0)) and "" or " [" .. math.floor(p9 / p10 * 100) .. "%]");
    p8.Frame.Button.Title.TextColor3 = p13 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p8.Frame.Button.Background.ImageColor3 = p13 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p8.Frame.Button.Votes.Chance.Visible = false;
end;

function u2.Destroy(p18) -- Line: 89
    p18.CreateSound:Destroy();
    p18.VoteBanFrame:Destroy();
    p18.Frame:Destroy();
end;

function u2._Update(p19) -- Line: 99
    p19._tag_background.Size = UDim2.new(0.5, p19._tag_title.TextBounds.X, 1, 0);
end;

function u2._Setup(p20) -- Line: 103
    -- upvalues: DuelLibrary (copy), ServerOsTime (copy), ButtonEffect (copy), u1 (copy)
    local v21 = p20.Name == "Random";
    local v22 = DuelLibrary.Maps[p20.Name];
    local v23 = v21 and "" or v22.Image;
    local v24 = DuelLibrary.MapDifficulties[v21 and "None" or v22.Difficulty];
    local v25;

    if v21 then
        v25 = false;
    else
        v25 = ServerOsTime:Get() < v22.ReleaseTime + DuelLibrary.NEW_MAP_RELEASE_DURATION;
    end;

    if v25 then
        v22 = "tag_newrelease";
    elseif v22 then
        v22 = v22.MapTag;
    end;

    local v26 = DuelLibrary.MapTags[v22];
    p20.Frame.Button.Picture.Image = v23;
    p20.Frame.Button.Random.Visible = v21;
    p20.Frame.Button.Background.Texture.ImageColor3 = v24.Color;
    p20.Frame.Button.Difficulty.BackgroundColor3 = v24.Color;
    p20.Frame.Button.Difficulty.UIStroke.Color = v24.Color;
    p20.Frame.Button.DifficultyVignette.ImageColor3 = v24.Color;
    p20.Frame.Button.DifficultyVignette.ImageTransparency = v24.Value >= DuelLibrary.MapDifficulties.Hard.Value and 0 or 0.5;
    p20.Frame.Button.Tag.Visible = v22;
    p20._tag_title.Text = v26 and (v26.DisplayName or "") or "";
    p20._tag_title.TextColor3 = v26 and v26.SecondaryColor or Color3.fromRGB(255, 255, 255);
    p20._tag_background.ImageColor3 = v26 and v26.Color or Color3.fromRGB(0, 0, 0);

    if not p20._ignore_button_effect then
        ButtonEffect:Add(p20.Frame.Button, nil, u1);
    end;
end;

function u2._Init(u27) -- Line: 129
    u27.VoteBanFrame.CreateSound:Connect(function(...) -- Line: 130
        -- upvalues: u27 (copy)
        u27.CreateSound:Fire(...);
    end);
    u27._tag_title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 134
        -- upvalues: u27 (copy)
        u27:_Update();
    end);
    u27:_Setup();
    u27:_Update();
    u27:UpdateVotes();
end;

return u2;