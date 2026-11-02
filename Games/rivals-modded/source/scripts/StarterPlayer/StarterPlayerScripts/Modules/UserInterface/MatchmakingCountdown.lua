-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"));
local Notifications = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Notifications"));
local GlowyBackground = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"));
local ChickenFooter = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 18
    -- upvalues: u1 (copy), Signal (copy), UILibrary (copy), ChickenFooter (copy), GlowyBackground (copy)
    local v2 = setmetatable({}, u1);
    v2.VisibilityChanged = Signal.new();
    v2.Frame = UILibrary:GetTo("MatchmakingCountdown");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.CountdownFrame = v2.Container:WaitForChild("Countdown");
    v2.CountdownText = v2.CountdownFrame:WaitForChild("Value");
    v2.CountdownGlow = v2.CountdownFrame:WaitForChild("Glow");
    v2.WaitingFrame = v2.Container:WaitForChild("Waiting");
    v2.WaitingDotsFrame = v2.WaitingFrame:WaitForChild("Dots");
    v2._countdown_hash = 0;
    v2._aborted_notification = false;
    v2._cover_part = Instance.new("Part");
    v2._cover_connection = nil;
    v2._chicken_footer = ChickenFooter.new();
    v2._glowy_background = GlowyBackground.new("MatchmakingCountdown");
    v2:_Init();

    return v2;
end;

function u1.IsVisible(p3) -- Line: 47
    return p3.Frame.Visible;
end;

function u1._Countdown(p4) -- Line: 55
    -- upvalues: MatchmakingController (copy), Utility (copy), TweenService (copy), RunService (copy)
    p4._countdown_hash = p4._countdown_hash + 1;
    local _countdown_hash = p4._countdown_hash;
    local v5 = MatchmakingController:Get("MatchmadeCountdown") or 0;
    p4.CountdownFrame.Visible = v5 > 0;
    p4.CountdownText.Text = v5;

    if v5 <= 0 then
        return;
    end;

    Utility:CreateSound("rbxassetid://17259538274", 0.5, 1, script, true, 5);
    local v6 = tick();

    while tick() < v6 + 0.375 do
        if _countdown_hash ~= p4._countdown_hash then
            return;
        end;

        local v7 = (tick() - v6) / 0.375;
        local Value = TweenService:GetValue(v7, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
        local Value2 = TweenService:GetValue(v7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        p4.CountdownText.Size = UDim2.new(1, 0, 1.25 - 0.625 * Value);
        p4.CountdownGlow.ImageTransparency = 0.875 - 0.25 * Value2;
        p4.CountdownGlow.Size = UDim2.new(Value2, 0, Value2, 0);
        RunService.RenderStepped:Wait();
    end;

    local v8 = tick();

    while tick() < v8 + 0.625 do
        if _countdown_hash ~= p4._countdown_hash then
            return;
        end;

        local v9 = (tick() - v8) / 0.625;
        local Value = TweenService:GetValue(v9, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
        local Value2 = TweenService:GetValue(v9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        p4.CountdownText.Size = UDim2.new(1, 0, 0.625 - 0.625 * Value);
        p4.CountdownGlow.ImageTransparency = 0.625 + 0.25 * Value2;
        RunService.RenderStepped:Wait();
    end;

    if _countdown_hash ~= p4._countdown_hash then
        return;
    end;

    p4.CountdownFrame.Visible = false;
end;

function u1._Update(u10) -- Line: 112
    -- upvalues: MatchmakingController (copy), CONSTANTS (copy), RunService (copy), Notifications (copy)
    local v11 = MatchmakingController:Get("MatchmadeStatus");
    local v12 = MatchmakingController:Get("MatchmadeExpectedPlayers");
    local v13 = CONSTANTS.IS_MATCHMAKING_SERVER and not MatchmakingController:Get("MatchmadeGameOver") and (v11 == "Waiting" and true or v11 == "Starting");
    local v14;

    if v13 then
        v14 = v11 == "Waiting";
    else
        v14 = v13;
    end;

    u10.Frame.Visible = v13;
    u10.WaitingFrame.Visible = v14;
    u10._glowy_background:SetEnabled(v13, v13);

    if v14 then
        u10.WaitingDotsFrame:AddTag("UILoadingDots");
        u10._chicken_footer:Show();
        u10._chicken_footer:SetStatus("Waiting For Players");
        u10._chicken_footer:EnableFunFacts();
        u10._chicken_footer:SetTimer((MatchmakingController:Get("MatchmadeConnectedPlayers") or 0) .. " / " .. (v12 or "???"));
    else
        u10.WaitingDotsFrame:RemoveTag("UILoadingDots");
        u10._chicken_footer:Hide();
    end;

    if v13 and not u10._cover_connection then
        u10._cover_part.Parent = workspace;
        u10._cover_connection = RunService.RenderStepped:Connect(function() -- Line: 136
            -- upvalues: u10 (copy)
            u10._cover_part.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1);
        end);
    elseif not v13 and u10._cover_connection then
        u10._cover_part.Parent = nil;
        u10._cover_connection:Disconnect();
        u10._cover_connection = nil;
    end;

    if v11 == "Aborted" and not u10._aborted_notification then
        u10._aborted_notification = true;
        Notifications:Queue("Duel Cancelled", "Not enough players connected", "rbxassetid://18553001997", nil, 0.75);
    end;
end;

function u1._Setup(p15) -- Line: 151
    p15._cover_part.Size = Vector3.new(10, 10, 0);
    p15._cover_part.Anchored = true;
    p15._cover_part.CanCollide = false;
    p15._cover_part.CanTouch = false;
    p15._cover_part.CanQuery = false;
    p15._cover_part.Color = Color3.fromRGB(0, 0, 0);
    p15._cover_part.Material = Enum.Material.Neon;
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.AlwaysOnTop = true;
    SurfaceGui.Face = Enum.NormalId.Back;
    SurfaceGui.Parent = p15._cover_part;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.Parent = SurfaceGui;
    p15._chicken_footer:SetParent(p15.Container);
    p15._glowy_background:SetParent(p15.Container);
end;

function u1._Init(u16) -- Line: 174
    -- upvalues: MatchmakingController (copy)
    u16.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 175
        -- upvalues: u16 (copy)
        u16.VisibilityChanged:Fire();
    end);
    MatchmakingController:GetDataChangedSignal("MatchmadeGameOver"):Connect(function() -- Line: 179
        -- upvalues: u16 (copy)
        u16:_Update();
    end);
    MatchmakingController:GetDataChangedSignal("MatchmadeStatus"):Connect(function() -- Line: 183
        -- upvalues: u16 (copy)
        u16:_Update();
    end);
    MatchmakingController:GetDataChangedSignal("MatchmadeCountdown"):Connect(function() -- Line: 187
        -- upvalues: u16 (copy)
        u16:_Update();
        u16:_Countdown();
    end);
    MatchmakingController:GetDataChangedSignal("MatchmadeConnectedPlayers"):Connect(function() -- Line: 192
        -- upvalues: u16 (copy)
        u16:_Update();
        u16:_Countdown();
    end);
    MatchmakingController:GetDataChangedSignal("MatchmadeExpectedPlayers"):Connect(function() -- Line: 197
        -- upvalues: u16 (copy)
        u16:_Update();
        u16:_Countdown();
    end);
    u16:_Setup();
    task.defer(u16._Update, u16);
    task.defer(u16._Countdown, u16);
end;

return u1._new();