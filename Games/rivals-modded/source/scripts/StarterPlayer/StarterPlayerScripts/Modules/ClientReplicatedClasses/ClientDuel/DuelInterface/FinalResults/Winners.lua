-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local BundleSlot = require(Players.LocalPlayer.PlayerScripts.Modules.BundleSlot);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local FinalResultsCameraRig = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("FinalResultsCameraRig");
local FinalResultsPlayerSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("FinalResultsPlayerSlot");
local u1 = {
    ViewModelName = "Assault Rifle"
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 28
    -- upvalues: u2 (copy), Signal (copy), BundleSlot (copy)
    local v4 = setmetatable({}, u2);
    v4.Finished = Signal.new();
    v4.FinalResults = p3;
    v4.TopFrame = v4.FinalResults.DuelInterface.Frame:WaitForChild("Top");
    v4.Frame = v4.FinalResults.Frame:WaitForChild("Winners");
    v4.PlayersFrame = v4.Frame:WaitForChild("Players");
    v4.TeamFrame = v4.Frame:WaitForChild("Team");
    v4.TeamText = v4.TeamFrame:WaitForChild("Team");
    v4.TeamShineFrame = v4.TeamFrame:WaitForChild("Shine"):WaitForChild("Frame");
    v4.SuperStarterBundleFrame = v4.Frame:WaitForChild("SuperStarterBundle");
    v4._destroyed = false;
    v4._skipped = false;
    v4._animation_cleanup = {};
    v4._static_viewmodels = {};
    v4._renderstep_id = nil;
    v4._winning_dueler_ids = {};
    v4._displayed_duelers = {};
    v4._player_slots = {};
    v4._final_winning_animation_hash = 0;
    v4._outro_sound = nil;
    v4._superstarterbundle_slot = BundleSlot.new("superstarter_bundle");
    v4:_Init();

    return v4;
end;

function u2.IsFinished(p5) -- Line: 63
    return p5._skipped;
end;

function u2.Skip(p6) -- Line: 67
    p6._skipped = true;
    p6.Finished:Fire();
end;

function u2.SetVisible(u7, p8) -- Line: 72
    -- upvalues: Utility (copy)
    u7.Frame.Visible = p8;
    task.spawn(u7._PlayFinalWinningAnimation, u7);

    if not (p8 or (not u7._outro_sound or u7._outro_sound.Volume < 1.25)) then
        task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 2, function(p9) -- Line: 77
            -- upvalues: u7 (copy)
            u7._outro_sound.Volume = 1.25 + -0.75 * (p9 / 100);
        end);
    end;
end;

function u2.Play(u10, p11, p12, p13) -- Line: 85
    -- upvalues: u1 (copy), StaticViewModel (copy), PreloadController (copy), FinalResultsCameraRig (copy), TweenService (copy), RunService (copy), HttpService (copy), CameraController (copy), UserInputService (copy), DuelLibrary (copy), Utility (copy), FinalResultsPlayerSlot (copy), ComplianceController (copy), CONSTANTS (copy), RankIcon (copy)
    u10.TopFrame.Visible = false;
    u10._winning_dueler_ids = p12;
    local Random_new_ret = Random.new(p11);
    local v14 = #p12 == 0 and "Tie" or (u10.FinalResults.DuelInterface.ClientDuel.LocalDueler and (u10.FinalResults.DuelInterface.ClientDuel.LocalDueler and table.find(p12, u10.FinalResults.DuelInterface.ClientDuel.LocalDueler:Get("DuelerID")) and "Win" or "Lose") or "Win");

    for _, v in pairs({ p12, p13 }) do
        for _, v2 in pairs(v) do
            local v15 = v2;

            for i in pairs(u10.FinalResults.DuelInterface:GetLoggedClientDuelers()) do
                if i:Get("DuelerID") == v15 then
                    table.insert(u10._displayed_duelers, i);
                    break;
                end;
            end;

            if #u10._displayed_duelers >= 5 then
                break;
            end;
        end;

        if #u10._displayed_duelers >= 5 then
            break;
        end;
    end;

    local v16, v17 = u10:_GetWinnersLocation();
    local u18 = {};

    for i, v in pairs(u10._displayed_duelers) do
        local CharacterModelForCutscene = v:GetCharacterModelForCutscene();
        CharacterModelForCutscene.Name = "Dueler" .. i;
        CharacterModelForCutscene:SetPrimaryPartCFrame(v17);
        CharacterModelForCutscene.Parent = v16;
        table.insert(u10._animation_cleanup, CharacterModelForCutscene);
        local v19 = v:GetRandomPlayedViewModelDetails(Random_new_ret) or u1;
        local v20 = StaticViewModel.new(v19.ViewModelName);

        if v20:HasGripAttachment() then
            v20:DeleteAnimationContextSubModels();
            v20:SetWrap(v19.Wrap);
            v20:SetCharm(v19.Charm);
            v20:ScaleTo(i == 1 and 1.5 or 1.25);
            v20:InitializeGrip();
            v20:SetParent(CharacterModelForCutscene);
            u10._static_viewmodels[v20] = CharacterModelForCutscene;
        else
            v20:Destroy();
        end;

        local success, result = pcall(function() -- Line: 141
            -- upvalues: CharacterModelForCutscene (copy), PreloadController (ref), i (copy), u18 (copy), u10 (copy)
            local v21 = CharacterModelForCutscene.Humanoid:LoadAnimation(PreloadController:GetPreloadedAnimation("FinalResultsPlayer" .. i));
            v21:Play(0);
            table.insert(u18, v21);
            table.insert(u10._animation_cleanup, v21);
        end);

        if not success then
            warn("Player " .. i .. " failed to animate, error:", result);
            CharacterModelForCutscene.Parent = nil;
        end;
    end;

    local u22 = FinalResultsCameraRig:Clone();
    u22:PivotTo(v17);
    u22.Parent = u10.FinalResults.DuelInterface.ClientDuel.Map.Model:FindFirstChild("Winners");
    local u23 = nil;
    local success, result = pcall(function() -- Line: 160
        -- upvalues: u23 (ref), u22 (copy), PreloadController (ref), u10 (copy)
        u23 = u22.AnimationController:LoadAnimation(PreloadController:GetPreloadedAnimation("FinalResultsCamera"));
        u23:Play(0);
        table.insert(u10._animation_cleanup, u23);
    end);
    local u24 = 40;
    local u25 = false;

    local function tween_camera_fov(p26, p27, p28, p29, p30) -- Line: 169
        -- upvalues: u25 (ref), u24 (ref), TweenService (ref), RunService (ref)
        if u25 then
            return;
        end;

        local v31 = tick();

        while tick() < v31 + p26 do
            u24 = 40 + 30 * TweenService:GetValue((tick() - v31) / p26, p29, p30);
            RunService.RenderStepped:Wait();

            if u25 then
                return;
            end;
        end;

        u24 = p28;
    end;

    if success then
        if u23 then
            u23:GetMarkerReachedSignal("Start Sine-Out 70"):Connect(function() -- Line: 192
                -- upvalues: tween_camera_fov (copy)
                tween_camera_fov(0.9666666666666667, 40, 70, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            end);
            u23:GetMarkerReachedSignal("Start Quad-Out 120"):Connect(function() -- Line: 196
                -- upvalues: tween_camera_fov (copy)
                tween_camera_fov(0.75, 70, 120, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            end);
        end;
    else
        warn("Camera failed to animate, error:", result);
    end;

    u10._renderstep_id = "FinalResults" .. HttpService:GenerateGUID(false);
    RunService:BindToRenderStep(u10._renderstep_id, CameraController:GetRenderstepPriority() + 1, function(p32) -- Line: 203
        -- upvalues: u10 (copy), UserInputService (ref), u24 (ref), u22 (copy)
        if not u10.FinalResults.DuelInterface.ClientDuel:Get("IsSpectating") then
            return;
        end;

        local CFrame_Angles = CFrame.Angles;
        local v33 = tick() * 0.23983 % 6.283185307179586;
        local v34 = math.sin(v33) * 0.017453292519943295;
        local v35 = tick() * 0.372721 % 6.283185307179586;
        local v36 = math.sin(v35) * 0.017453292519943295;
        local v37 = tick() * 0.43123 % 6.283185307179586;
        local v38 = CFrame_Angles(v34, v36, math.sin(v37) * 0.017453292519943295);
        UserInputService.MouseIconEnabled = true;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        workspace.CurrentCamera.FieldOfView = u24;
        workspace.CurrentCamera.CFrame = u22.Cam.CFrame * v38;

        for i, v in pairs(u10._static_viewmodels) do
            i:GripPivotTo(v);
        end;
    end);
    task.delay(12, function() -- Line: 226
        -- upvalues: u10 (copy), u23 (ref), u18 (copy)
        if u10._destroyed then
            return;
        end;

        if u23 then
            u23:AdjustSpeed(0);
        end;

        for _, v in pairs(u18) do
            v:AdjustSpeed(0);
        end;
    end);
    local v39 = u10.FinalResults.DuelInterface:CreateSound("rbxassetid://18221897857", 0, 1, script, true, 60);

    if v39 then
        v39.Looped = true;
    end;

    local DuelInterface = u10.FinalResults.DuelInterface;
    local v40;

    if v14 == "Win" then
        v40 = math.random() < 0.5 and "rbxassetid://18239670056" or "rbxassetid://18221725850";
    else
        v40 = math.random() < 0.5 and "rbxassetid://18239670367" or "rbxassetid://18221726246";
    end;

    u10._outro_sound = DuelInterface:RawCreateSound(v40, 1.25, 1, script, true, 15, nil, nil, "Music");
    u10:_WaitWhileNotSkipped(1);

    if u10._destroyed then
        return;
    end;

    u10:_WaitWhileNotSkipped(5);

    if u10._destroyed then
        return;
    end;

    if not u10:IsFinished() then
        u10.FinalResults.DuelInterface:CreateSound("rbxassetid://18129776757", 1.25, 1, script, true, 15);
    end;

    u10:_WaitWhileNotSkipped(0.45);

    if u10._destroyed then
        return;
    end;

    if not u10:IsFinished() then
        u10.FinalResults.DuelInterface:CreateSound("rbxassetid://18221897857", 1.25, 1, script, true, 15);
    end;

    u10:_WaitWhileNotSkipped(3.6);

    if u10._destroyed then
        return;
    end;

    if u10:IsFinished() then
        u25 = true;
        u24 = 120;

        if u23 then
            u23.TimePosition = 12;
            u23:AdjustSpeed(0);
        end;

        for _, v in pairs(u18) do
            v.TimePosition = 12;
            v:AdjustSpeed(0);
        end;
    end;

    local v41 = u10.FinalResults.DuelInterface.ClientDuel:Get("ScoresBehavior");
    local v42 = u10.FinalResults.DuelInterface.ClientDuel:Get("ArcadeMode");
    local v43 = not v42 or v41 == "Teams";
    local v44 = not v42;

    for i, v in pairs(u10._displayed_duelers) do
        if not u10.FinalResults.DuelInterface.ClientDuel.IsRanked then
            local _ = v.Player:GetAttribute("StatisticDuelsWinStreak") or 0;
        end;

        local v45 = not u10.FinalResults.DuelInterface.ClientDuel.IsRanked and (v.Player:GetAttribute("Level") or 0) or nil;
        local TeamColor = DuelLibrary:GetTeamColor(v:Get("TeamID"));
        local v46 = Utility:SanitizeName(v.Player.Name);
        local v47 = FinalResultsPlayerSlot:Clone();
        local v48;

        if v42 then
            v48 = v41 == "Duelers";
        else
            v48 = v42;
        end;

        v47.Placement.Visible = v48;
        v47.Placement.Title.Text = "#" .. i;
        local v49;

        if i == 1 and #p12 > 1 then
            v49 = not v47.Placement.Visible;
        else
            v49 = false;
        end;

        v47.MVP.Visible = v49;
        v47.Background.ImageColor3 = TeamColor;
        v47.Player.Username.Text = v.Player.DisplayName == v46 and "" or "@" .. v46;
        v47.Player.Text = ComplianceController:GetName(v.Player);
        v47.Player.Position = v47.Player.Username.Text == "" and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.4, 0);
        v47.Controls.Image = CONSTANTS.CONTROLS_IMAGES_CENTERED[v.ClientFighter:Get("Controls")] or "";
        local v50;

        if v45 then
            v50 = v45 > 0;
        else
            v50 = v45;
        end;

        v47.Level.Visible = v50;
        v47.Level.Value.Text = v45 and Utility:PrettyNumber(v45) or "";
        v47.Performance.Eliminations.Value.Text = Utility:PrettyNumber(v:Get("Eliminations"));
        v47.Performance.Deaths.Value.Text = Utility:PrettyNumber(v:Get("Deaths"));
        v47.Performance.Assists.Value.Text = Utility:PrettyNumber(v:Get("Assists"));
        v47.Performance.DamageDealt.Position = v44 and UDim2.new(0.333, 0, 3.25, 0) or UDim2.new(0.5, 0, 3.25, 0);
        v47.Performance.DamageDealt.Title.Text = v43 and "Damage Dealt" or "Points";
        local Value = v47.Performance.DamageDealt.Value;
        local v51;

        if v43 then
            local v52 = v:Get("Damage") + 0.5;
            v51 = Utility:PrettyNumber((math.floor(v52))) or (v41 == "Duelers" and (Utility:PrettyNumber(u10.FinalResults.DuelInterface.ClientDuel:Get("Scores")[v:Get("DuelerID")] or 0) or "???") or "???");
        else
            v51 = v41 == "Duelers" and (Utility:PrettyNumber(u10.FinalResults.DuelInterface.ClientDuel:Get("Scores")[v:Get("DuelerID")] or 0) or "???") or "???";
        end;

        Value.Text = v51;
        v47.Performance.DamageTaken.Visible = v44;
        local Value2 = v47.Performance.DamageTaken.Value;
        local v53 = v:Get("DamageTaken") + 0.5;
        Value2.Text = Utility:PrettyNumber((math.floor(v53)));
        table.insert(u10._player_slots, v47);

        if u10.FinalResults.DuelInterface.ClientDuel.IsRanked then
            local v54;

            if v.IsLocalPlayer then
                v54 = u10.FinalResults.Summary:GetLocalPlayerPreviousELO();
            else
                v54 = v.Player:GetAttribute("DisplayELO");
            end;

            RankIcon.new(v54, v.Player.UserId):SetParent(v47.Rank);
        end;

        local Player = v47.Player;
        local Username = Player.Username;
        local Controls = v47.Controls;
        local Streak = v47.Streak;
        local Level = v47.Level;
        local Rank = v47.Rank;

        local function update() -- Line: 353
            -- upvalues: Player (copy), Username (copy), Controls (copy), Streak (copy), Level (copy), Rank (copy)
            local math_max_ret = math.max(Player.TextBounds.X, Username.TextBounds.X);
            Controls.Position = UDim2.new(0.5, math_max_ret / 2, 0.5, 0);
            Streak.Position = UDim2.new(0.5, -math_max_ret / 2, 0.5, 0);
            Level.Position = UDim2.new(0.5, -math_max_ret / 2, 0.5, 0);
            Rank.Position = UDim2.new(0.5, -math_max_ret / 2, 0.5, 0);
        end;

        Player:GetPropertyChangedSignal("TextBounds"):Connect(update);
        Username:GetPropertyChangedSignal("TextBounds"):Connect(update);
        Player.AncestryChanged:Connect(update);
        Username.AncestryChanged:Connect(update);
        update();
    end;

    u10:Skip();
end;

function u2.Destroy(p55) -- Line: 373
    -- upvalues: RunService (copy)
    p55._destroyed = true;
    p55._final_winning_animation_hash = p55._final_winning_animation_hash + 1;

    for _, v in pairs(p55._animation_cleanup) do
        v:Destroy();
    end;

    for _, v in pairs(p55._static_viewmodels) do
        v:Destroy();
    end;

    if p55._renderstep_id then
        RunService:UnbindFromRenderStep(p55._renderstep_id);
        p55._renderstep_id = nil;
    end;

    p55.Finished:Destroy();
    p55._superstarterbundle_slot:Destroy();
end;

function u2._PlayFinalWinningAnimation(p56) -- Line: 398
    -- upvalues: DuelLibrary (copy)
    if not p56:IsFinished() then
        return;
    end;

    p56._final_winning_animation_hash = p56._final_winning_animation_hash + 1;
    local _final_winning_animation_hash = p56._final_winning_animation_hash;
    local v57;

    if #p56._winning_dueler_ids > 0 and p56.FinalResults.DuelInterface.ClientDuel:Get("ScoresBehavior") == "Teams" then
        v57 = p56._displayed_duelers[1] and p56._displayed_duelers[1]:Get("TeamID");
    else
        v57 = false;
    end;

    local TeamColor = DuelLibrary:GetTeamColor(v57);
    p56.SuperStarterBundleFrame.Visible = false;
    p56.TeamFrame.Background.ImageColor3 = TeamColor;
    p56.TeamFrame.Visible = v57 and true;
    p56.TeamFrame.Position = UDim2.new(0.5, 0, 0.16, 40);
    p56.TeamFrame:TweenPosition(UDim2.new(0.5, 0, 0.125, 30), "Out", "Quint", 0.25, true);
    p56.TeamText.Text = v57 and DuelLibrary.TeamsByID[v57].TeamName or "";
    p56.TeamShineFrame.Position = UDim2.new(-0.5, 0, 0.5, 0);
    p56.TeamShineFrame:TweenPosition(UDim2.new(1.5, 0, 0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 1, true);

    for i, v in pairs(p56._player_slots) do
        if p56._final_winning_animation_hash ~= _final_winning_animation_hash then
            return;
        end;

        v.Parent = p56.PlayersFrame:FindFirstChild(i);
        v.Size = UDim2.new(0.45, 0, 0.075, 0);
        v.Position = UDim2.new(0.5, 0, 0.4, 0);
        v:TweenSizeAndPosition(UDim2.new(0.75, 0, 0.125, 0), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25 * i, true);
        wait(0.125);
    end;
end;

function u2._GetWinnersLocation(p58) -- Line: 436
    local Winners = p58.FinalResults.DuelInterface.ClientDuel.Map.Model:FindFirstChild("Winners");

    return Winners, Winners and Winners:FindFirstChild("Primary") and Winners.Primary.CFrame or CFrame.identity;
end;

function u2._WaitWhileNotSkipped(p59, p60) -- Line: 443
    -- upvalues: RunService (copy)
    local v61 = tick() + p60;

    while tick() < v61 and not p59:IsFinished() do
        RunService.RenderStepped:Wait();
    end;
end;

function u2._Setup(p62) -- Line: 451
    p62.SuperStarterBundleFrame.Visible = false;
    p62._superstarterbundle_slot:SetParent(p62.SuperStarterBundleFrame);
end;

function u2._Init(u63) -- Line: 456
    u63.Finished:Connect(function() -- Line: 457
        -- upvalues: u63 (copy)
        u63:_PlayFinalWinningAnimation();
    end);
    u63:_Setup();
end;

return u2;