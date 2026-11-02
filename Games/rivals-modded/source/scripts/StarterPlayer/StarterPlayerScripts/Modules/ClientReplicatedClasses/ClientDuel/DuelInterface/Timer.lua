-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.TimerChanged = Signal.new();
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Top"):WaitForChild("Timer");
    v3.InfiniteIcon = v3.Frame:WaitForChild("Infinite");
    v3.StopwatchText = v3.Frame:WaitForChild("Stopwatch");
    v3.NumbersFrame = v3.Frame:WaitForChild("Numbers");
    v3.NumbersFullFrame = v3.NumbersFrame:WaitForChild("Full");
    v3.NumbersFullText = v3.NumbersFullFrame:WaitForChild("Value");
    v3.NumbersSecondsOnesFrame = v3.NumbersFrame:WaitForChild("SecondsOnes");
    v3.NumbersSecondsOnesText = v3.NumbersSecondsOnesFrame:WaitForChild("Value");
    v3.NumbersSecondsTensFrame = v3.NumbersFrame:WaitForChild("SecondsTens");
    v3.NumbersSecondsTensText = v3.NumbersSecondsTensFrame:WaitForChild("Value");
    v3.NumbersMinutesOnesFrame = v3.NumbersFrame:WaitForChild("MinutesOnes");
    v3.NumbersMinutesOnesText = v3.NumbersMinutesOnesFrame:WaitForChild("Value");
    v3.NumbersColonFrame = v3.NumbersFrame:WaitForChild("Colon");
    v3.NumbersColonText = v3.NumbersColonFrame:WaitForChild("Value");
    v3.NumbersIconFrame = v3.NumbersFrame:WaitForChild("Icon");
    v3.NumbersIconIcon = v3.NumbersIconFrame:WaitForChild("Icon");
    v3._destroyed = false;
    v3._is_visible = true;
    v3._time_remaining = 0;
    v3._countdown_hash = 0;
    v3._last4sec_sound = nil;
    v3._last10sec_sound = nil;
    v3._stopwatch_start = nil;
    v3._stopwatch_finish = nil;
    v3._stopwatch_connection = nil;
    v3:_Init();

    return v3;
end;

function u1.GetTimeRemaining(p4) -- Line: 53
    return p4._time_remaining;
end;

function u1.SetVisible(p5, p6) -- Line: 57
    p5._is_visible = p6;
    p5:Update();
end;

function u1.Set(p7, p8) -- Line: 63
    -- upvalues: RunService (copy)
    p7.NumbersFrame.Visible = p8 ~= nil;
    p7.InfiniteIcon.Visible = p8 == nil;
    p7._countdown_hash = p7._countdown_hash + 1;

    if not p8 then
        p7:_ClearSounds();

        return;
    end;

    local _countdown_hash = p7._countdown_hash;
    local v9 = tick();

    while _countdown_hash == p7._countdown_hash and tick() - v9 < p8 do
        p7:_SetText(p8 - (tick() - v9));
        RunService.RenderStepped:Wait();
    end;

    if _countdown_hash ~= p7._countdown_hash then
        return;
    end;

    p7:_SetText(0);
end;

function u1.Pause(p10, p11) -- Line: 92
    p10._countdown_hash = p10._countdown_hash + 1;

    if p11 then
        p10:_SetText(p11);
    end;

    p10:_ClearSounds();
end;

function u1.UpdateSizeAndPosition(p12) -- Line: 102
    -- upvalues: Players (copy)
    local v13;

    if p12.DuelInterface.ClientDuel:Get("ScoresBehavior") == "Duelers" then
        v13 = not p12.DuelInterface.ClientDuel:Get("VoteOptions");
    else
        v13 = false;
    end;

    local v14 = v13 and UDim2.new(0.5, 0, 0.03, 7.5) or UDim2.new(0.5, 0, 0.04, 10);
    local v15 = v13 and UDim2.new(0.075, 30, 0.0375, 15) or UDim2.new(0.1, 40, 0.05, 20);

    if p12.Frame:IsDescendantOf(Players) then
        p12.Frame:TweenSizeAndPosition(v15, v14, "Out", "Quint", 0.25, true);

        return;
    end;

    p12.Frame.Size = v15;
    p12.Frame.Position = v14;
end;

function u1.StopwatchStart(u16) -- Line: 115
    -- upvalues: RunService (copy)
    u16:StopwatchFinish();
    u16.InfiniteIcon.Position = UDim2.new(0.5, 0, 0.4, 0);
    u16.NumbersFrame.Position = UDim2.new(0.5, 0, 0.4, 0);
    u16._stopwatch_start = tick();
    u16._stopwatch_finish = nil;
    u16._stopwatch_connection = RunService.RenderStepped:Connect(function() -- Line: 124
        -- upvalues: u16 (copy)
        u16.StopwatchText.Text = string.format("%.3f", tick() - u16._stopwatch_start);
    end);
end;

function u1.StopwatchFinish(p17, p18) -- Line: 129
    p17._stopwatch_start = nil;
    p17._stopwatch_finish = p18;

    if p17._stopwatch_connection then
        p17._stopwatch_connection:Disconnect();
        p17._stopwatch_connection = nil;
    end;

    p17.StopwatchText.Text = p17._stopwatch_finish and string.format("%.3f", p17._stopwatch_finish) or "";
end;

function u1.ClearStopwatch(p19) -- Line: 141
    p19:StopwatchFinish();
    p19.InfiniteIcon.Position = UDim2.new(0.5, 0, 0.5, 0);
    p19.NumbersFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
end;

function u1.Update(p20) -- Line: 147
    local Frame = p20.Frame;
    local v21 = p20._is_visible and not p20.DuelInterface:IsPageOpen() and not p20.DuelInterface.ClientDuel:Get("HideMostDuelInterfaceElements");
    Frame.Visible = v21;
end;

function u1.Destroy(p22) -- Line: 151
    p22._destroyed = true;
    p22._countdown_hash = p22._countdown_hash + 1;
    p22.TimerChanged:Destroy();
    p22:ClearStopwatch();
    p22:_ClearSounds();
end;

function u1._UpdateLayouts(p23) -- Line: 163
    p23.NumbersFullFrame.Size = UDim2.new(0.1, p23.NumbersFullText.TextBounds.X, 0.6, 0);
end;

function u1._ClearSounds(p24) -- Line: 167
    if p24._last4sec_sound then
        p24._last4sec_sound:Destroy();
        p24._last4sec_sound = nil;
    end;

    if p24._last10sec_sound then
        p24._last10sec_sound:Destroy();
        p24._last10sec_sound = nil;
    end;
end;

function u1._SetText(p25, p26) -- Line: 179
    -- upvalues: Utility (copy)
    p25._time_remaining = math.max(0, p26);
    p25.TimerChanged:Fire(p25._time_remaining);
    local math_ceil_ret = math.ceil(p25._time_remaining);
    local v27 = p25._time_remaining <= 0.05 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255);
    local v28 = p25._time_remaining < 10;
    local v29 = Utility:TimeFormat(math_ceil_ret);
    p25.NumbersFullFrame.Visible = false;
    p25.NumbersSecondsOnesFrame.Visible = not v28;
    p25.NumbersSecondsTensFrame.Visible = true;
    p25.NumbersMinutesOnesFrame.Visible = true;
    p25.NumbersColonFrame.Visible = true;
    local NumbersFullText = p25.NumbersFullText;

    if v28 then
        v29 = string.format("%.1f", (math.abs(p25._time_remaining)));
    end;

    NumbersFullText.Text = v29;
    p25.NumbersSecondsOnesText.Text = math_ceil_ret % 10;
    local NumbersSecondsTensText = p25.NumbersSecondsTensText;
    local v30;

    if v28 then
        v30 = math.floor(p25._time_remaining % 1 * 10);
    else
        v30 = math.floor(math_ceil_ret % 60 / 10);
    end;

    NumbersSecondsTensText.Text = v30;
    local NumbersMinutesOnesText = p25.NumbersMinutesOnesText;
    local v31;

    if v28 then
        v31 = math.floor(p25._time_remaining % 10);
    else
        v31 = math.floor(math_ceil_ret / 60) % 10;
    end;

    NumbersMinutesOnesText.Text = v31;
    p25.NumbersColonText.Text = v28 and "." or ":";
    p25.NumbersFullText.TextColor3 = v27;
    p25.NumbersSecondsOnesText.TextColor3 = v27;
    p25.NumbersSecondsTensText.TextColor3 = v27;
    p25.NumbersColonText.TextColor3 = v27;
    p25.NumbersMinutesOnesText.TextColor3 = v27;
    p25.NumbersIconIcon.ImageColor3 = v27;

    if p25._time_remaining <= 4 then
        if not p25._last4sec_sound and p25.DuelInterface.ClientDuel:Get("Status") == "RoundStarted" then
            p25._last4sec_sound = p25.DuelInterface:CreateSound("rbxassetid://17826390328", 1.25, 1, script, true, 15);
        end;
    elseif p25._time_remaining <= 10 then
        if not p25._last10sec_sound and p25.DuelInterface.ClientDuel:Get("Status") == "RoundStarted" then
            p25._last10sec_sound = p25.DuelInterface:CreateSound("rbxassetid://17826470563", 0.5, 1, script, true, 15);
        end;
    else
        p25:_ClearSounds();
    end;
end;

function u1._Init(u32) -- Line: 220
    u32.NumbersFullText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 221
        -- upvalues: u32 (copy)
        u32:_UpdateLayouts();
    end);
    u32:_UpdateLayouts();
    u32:UpdateSizeAndPosition();
    u32:ClearStopwatch();
    task.defer(u32._SetText, u32, 0);
end;

return u1;