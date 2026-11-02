-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local math_abs = math.abs;
local math_clamp = math.clamp;
local math_exp = math.exp;
local math_rad = math.rad;
local math_sign = math.sign;
local math_sqrt = math.sqrt;
local math_tan = math.tan;
local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace");
local GameSettings = UserSettings().GameSettings;
local Lighting = game:GetService("Lighting");

if not Players.LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    local _ = Players.LocalPlayer;
end;

local CurrentCamera = Workspace.CurrentCamera;
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 33
    -- upvalues: Workspace (copy), CurrentCamera (ref)
    local CurrentCamera2 = Workspace.CurrentCamera;

    if CurrentCamera2 then
        CurrentCamera = CurrentCamera2;
    end;
end);
local u1 = nil;
local success, result = pcall(function() -- Line: 44
    return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock");
end);
local u2 = success and result;
local success2, result2 = pcall(function() -- Line: 52
    return UserSettings():IsUserFeatureEnabled("UserShowGuiHideToggles");
end);
local u3 = success2 and result2;
local success3, result3 = pcall(function() -- Line: 60
    return UserSettings():IsUserFeatureEnabled("UserFixFreecamDeltaTimeCalculation");
end);
local u4 = success3 and result3;
local success4, result4 = pcall(function() -- Line: 68
    return UserSettings():IsUserFeatureEnabled("UserFixFreecamGuiChangeVisibility");
end);
local u5 = success4 and result4;
local success5, result5 = pcall(function() -- Line: 76
    return UserSettings():IsUserFeatureEnabled("UserFreecamControlSpeed");
end);
local u6 = success5 and result5;
local success6, result6 = pcall(function() -- Line: 84
    return UserSettings():IsUserFeatureEnabled("UserFreecamTiltControl");
end);
local u7 = success6 and result6;
local success7, result7 = pcall(function() -- Line: 92
    return UserSettings():IsUserFeatureEnabled("UserFreecamSmoothnessControl");
end);
local u8 = success7 and result7;
local success8, result8 = pcall(function() -- Line: 100
    return UserSettings():IsUserFeatureEnabled("UserFreecamGuiDestabilization");
end);
local u9 = success8 and result8;
local success9, result9 = pcall(function() -- Line: 108
    return UserSettings():IsUserFeatureEnabled("UserFreecamDepthOfFieldEffect");
end);
local u10 = success9 and result9;
local _ = Enum.ContextActionPriority.Low.Value;
local Value = Enum.ContextActionPriority.High.Value;
local _ = { Enum.KeyCode.LeftShift, Enum.KeyCode.P };
local u11 = {
    [Enum.KeyCode.Z] = true,
    [Enum.KeyCode.C] = true
};
local u12 = {
    [Enum.KeyCode.ButtonL1] = true,
    [Enum.KeyCode.ButtonR1] = true
};
local u13 = {
    [Enum.KeyCode.BackSlash] = true
};
local u14 = Vector2.new(0.75, 1) * 8;
local u15 = 5;
local u16 = 5;
local u17 = 4;
local u18 = 5;
local u19 = {};
local u20 = 0;
local u21 = {};
local u22 = {};
u22.__index = u22;

function u22.new(p23, p24) -- Line: 170
    -- upvalues: u22 (copy)
    local v25 = setmetatable({}, u22);
    v25.f = p23;
    v25.p = p24;
    v25.v = p24 * 0;

    return v25;
end;

function u22.Update(p26, p27, p28) -- Line: 178
    -- upvalues: math_exp (copy)
    local v29 = p26.f * 2 * 3.141592653589793;
    local v = p26.v;
    local v30 = p28 - p26.p;
    local v31 = math_exp(-v29 * p27);
    local v32 = p28 + (v * p27 - v30 * (v29 * p27 + 1)) * v31;
    p26.p = v32;
    p26.v = (v29 * p27 * (v30 * v29 - v) + v) * v31;

    return v32;
end;

function u22.SetFreq(p33, p34) -- Line: 195
    p33.f = p34;
end;

function u22.Reset(p35, p36) -- Line: 199
    p35.p = p36;
    p35.v = p36 * 0;
end;

local Vector3_new_ret = Vector3.new();
local u37;

if u7 then
    u37 = Vector3.new();
else
    u37 = Vector2.new();
end;

local u38 = 0;
local u39 = u22.new(u15, (Vector3.new()));
local u40 = u22.new(u16, Vector2.new());
local u41 = u22.new(u17, 0);
local u42 = u22.new(u18, 0);
local u43 = {};

local function fCurve(p44) -- Line: 228
    -- upvalues: math_exp (copy)
    return (math_exp(2 * p44) - 1) / 6.38905609893065;
end;

local function fDeadzone(p45) -- Line: 232
    -- upvalues: math_exp (copy)
    return (math_exp(2 * ((p45 - 0.15) / 0.85)) - 1) / 6.38905609893065;
end;

local function thumbstickCurve(p46) -- Line: 236
    -- upvalues: math_sign (copy), math_abs (copy), math_exp (copy), math_clamp (copy)
    return math_sign(p46) * math_clamp((math_exp(2 * ((math_abs(p46) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;

local u47 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    DPadLeft = 0,
    DPadRight = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    ButtonL1 = 0,
    ButtonR1 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
};
local u48 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    U = 0,
    H = 0,
    J = 0,
    K = 0,
    I = 0,
    Y = 0,
    Up = 0,
    Down = 0,
    Left = 0,
    Right = 0,
    LeftShift = 0,
    RightShift = 0,
    Z = 0,
    C = 0,
    Comma = 0,
    Period = 0,
    LeftBracket = 0,
    RightBracket = 0,
    Semicolon = 0,
    Quote = 0,
    V = 0,
    B = 0,
    N = 0,
    M = 0,
    BackSlash = 0,
    Minus = 0,
    Equals = 0
};
local u49 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u50 = Vector2.new(1, 1) * 0.04908738521234052;
local u51 = u50 / 60;
local u52 = Vector2.new(1, 1) * 0.39269908169872414;
local u53 = {
    FarIntensity = {
        ADJ = 0.1,
        MIN = 0,
        MAX = 1
    },
    NearIntensity = {
        ADJ = 0.1,
        MIN = 0,
        MAX = 1
    },
    FocusDistance = {
        ADJ = 20,
        MIN = 0,
        MAX = 200
    },
    FocusRadius = {
        ADJ = 5,
        MIN = 0,
        MAX = 50
    }
};
local u54 = 1;
local u55 = 1;
local u56 = 1;

function u43.Vel(p57) -- Line: 345
    -- upvalues: u6 (ref), u54 (ref), u48 (copy), u47 (copy), math_clamp (copy), thumbstickCurve (ref), UserInputService (copy)
    if u6 then
        u54 = math_clamp(u54 + p57 * (u48.Up - u48.Down + u47.DPadUp - u47.DPadDown) * 0.75, 0.01, 4);
    else
        u54 = math_clamp(u54 + p57 * (u48.Up - u48.Down) * 0.75, 0.01, 4);
    end;

    local v58 = thumbstickCurve(u47.Thumbstick1.X);
    local v59 = thumbstickCurve(u47.ButtonR2) - thumbstickCurve(u47.ButtonL2);
    local v60 = Vector3.new(v58, v59, thumbstickCurve(-u47.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v61 = Vector3.new(u48.D - u48.A + u48.K - u48.H, u48.E - u48.Q + u48.I - u48.Y, u48.S - u48.W + u48.J - u48.U) * Vector3.new(1, 1, 1);
    local v62 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);

    return (v60 + v61) * (u54 * (v62 and 0.25 or 1));
end;

function u43.Pan(p63) -- Line: 368
    -- upvalues: thumbstickCurve (ref), u47 (copy), u52 (copy), u49 (copy), u50 (copy), u4 (ref), u51 (copy)
    local v64 = Vector2.new(thumbstickCurve(u47.Thumbstick2.Y), thumbstickCurve(-u47.Thumbstick2.X)) * u52;
    local v65 = u49.Delta * u50;

    if u4 and p63 > 0 then
        v65 = u49.Delta / p63 * u51;
    end;

    u49.Delta = Vector2.new();

    return v64 + v65;
end;

function u43.Fov(p66) -- Line: 383
    -- upvalues: u6 (ref), u56 (ref), u48 (copy), u47 (copy), math_clamp (copy), u49 (copy), u4 (ref)
    if u6 then
        u56 = math_clamp(u56 + p66 * (u48.Right - u48.Left + u47.DPadRight - u47.DPadLeft) * 0.75, 0.01, 4);
    end;

    local v67 = (u47.ButtonX - u47.ButtonY) * 0.25;
    local v68 = u49.MouseWheel * 1;

    if u4 and p66 > 0 then
        v68 = u49.MouseWheel / p66 * 0.016666666666666666;
    end;

    u49.MouseWheel = 0;

    if u6 then
        return (v67 + v68) * u56;
    end;

    return v67 + v68;
end;

function u43.Roll(p69) -- Line: 402
    -- upvalues: u55 (ref), u48 (copy), math_clamp (copy), u47 (copy)
    u55 = math_clamp(u55 + p69 * (u48.Period - u48.Comma) * 0.75, 0.01, 4);

    return ((u47.ButtonR1 - u47.ButtonL1) * 1 + (u48.C - u48.Z) * 1) * u55;
end;

function u43.SpringControl(p70) -- Line: 411
    -- upvalues: u10 (ref), UserInputService (copy), u15 (ref), u48 (copy), math_clamp (copy), u39 (copy), u16 (ref), u40 (copy), u17 (ref), u41 (copy), u18 (ref), u42 (copy)
    if u10 and (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) or (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl))) then
        return;
    end;

    u15 = math_clamp(u15 + p70 * (u48.RightBracket - u48.LeftBracket) * 0.75, 0.01, 10);
    u39:SetFreq(u15);
    u16 = math_clamp(u16 + p70 * (u48.Quote - u48.Semicolon) * 0.75, 0.01, 10);
    u40:SetFreq(u16);
    u17 = math_clamp(u17 + p70 * (u48.B - u48.V) * 0.75, 0.01, 10);
    u41:SetFreq(u17);
    u18 = math_clamp(u18 + p70 * (u48.M - u48.N) * 0.75, 0.01, 10);
    u42:SetFreq(u18);
end;

function u43.DoF(p71) -- Line: 434
    -- upvalues: UserInputService (copy), u1 (ref), u48 (copy), u53 (copy), math_clamp (copy)
    local v72 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);
    local v73 = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl);

    if v72 then
        u1.FarIntensity = math_clamp(u1.FarIntensity + p71 * (u48.RightBracket - u48.LeftBracket) * u53.FarIntensity.ADJ, u53.FarIntensity.MIN, u53.FarIntensity.MAX);
        u1.InFocusRadius = math_clamp(u1.InFocusRadius + p71 * (u48.Equals - u48.Minus) * u53.FocusRadius.ADJ, u53.FocusRadius.MIN, u53.FocusRadius.MAX);

        return;
    end;

    if v73 then
        u1.NearIntensity = math_clamp(u1.NearIntensity + p71 * (u48.RightBracket - u48.LeftBracket) * u53.NearIntensity.ADJ, u53.NearIntensity.MIN, u53.NearIntensity.MAX);

        return;
    end;

    u1.FocusDistance = math_clamp(u1.FocusDistance + p71 * (u48.Equals - u48.Minus) * u53.FocusDistance.ADJ, u53.FocusDistance.MIN, u53.FocusDistance.MAX);
end;

local function resetKeys(p74, p75) -- Line: 465
    for i, _ in pairs(p74) do
        if p75[i.Name] then
            p75[i.Name] = 0;
        end;
    end;
end;

local function handleDoubleTapReset(p76) -- Line: 473
    -- upvalues: u19 (copy), u20 (ref), u37 (ref), u42 (copy), u10 (ref), u12 (copy), u47 (copy), u11 (copy), u48 (copy)
    local os_clock_ret = os.clock();
    local v77 = u19[p76];

    if v77 and ((v77 and (os_clock_ret - v77 or -1) or -1) <= 0.25 and os_clock_ret - u20 >= 0.1) then
        u37 = Vector3.new(u37.x, u37.y, 0);
        u42:Reset(0);

        if u10 then
            local v78 = u47;

            for i, _ in pairs(u12) do
                if v78[i.Name] then
                    v78[i.Name] = 0;
                end;
            end;

            local v79 = u48;

            for i, _ in pairs(u11) do
                if v79[i.Name] then
                    v79[i.Name] = 0;
                end;
            end;
        else
            u47.ButtonL1 = 0;
            u47.ButtonR1 = 0;
            u48.C = 0;
            u48.Z = 0;
        end;

        u20 = os_clock_ret;
    end;

    u19[p76] = os_clock_ret;
end;

local function Keypress(p80, p81, p82) -- Line: 498
    -- upvalues: u48 (copy), u7 (ref), u11 (copy), handleDoubleTapReset (copy), u10 (ref), u13 (copy), u1 (ref), u21 (ref), CurrentCamera (ref), Lighting (copy)
    u48[p82.KeyCode.Name] = p81 == Enum.UserInputState.Begin and 1 or 0;

    if u7 and (u11[p82.KeyCode] and p82.UserInputState == Enum.UserInputState.Begin) then
        handleDoubleTapReset(p82.KeyCode);
    end;

    if u10 and (u13[p82.KeyCode] and p82.UserInputState == Enum.UserInputState.Begin) then
        if u1.Enabled then
            for _, v in ipairs(u21) do
                if v.Parent then
                    v.Enabled = true;
                end;
            end;

            u21 = {};
        else
            u21 = {};

            for _, child in ipairs(CurrentCamera:GetChildren()) do
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    u21[#u21 + 1] = child;
                    child.Enabled = false;
                end;
            end;

            for _, child in ipairs(Lighting:GetChildren()) do
                if child:IsA("DepthOfFieldEffect") and child.Enabled then
                    u21[#u21 + 1] = child;
                    child.Enabled = false;
                end;
            end;

            CurrentCamera.ChildAdded:Connect(function(p83) -- Line: 524
                -- upvalues: u21 (ref)
                if p83:IsA("DepthOfFieldEffect") and p83.Enabled then
                    u21[#u21 + 1] = p83;
                    p83.Enabled = false;
                end;
            end);
            Lighting.ChildAdded:Connect(function(p84) -- Line: 530
                -- upvalues: u21 (ref)
                if p84:IsA("DepthOfFieldEffect") and p84.Enabled then
                    u21[#u21 + 1] = p84;
                    p84.Enabled = false;
                end;
            end);
        end;

        u1.Enabled = not u1.Enabled;
        local v85 = u48;

        for i, _ in pairs(u13) do
            if v85[i.Name] then
                v85[i.Name] = 0;
            end;
        end;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function GpButton(p86, p87, p88) -- Line: 554
    -- upvalues: u47 (copy), u7 (ref), u12 (copy), handleDoubleTapReset (copy)
    u47[p88.KeyCode.Name] = p87 == Enum.UserInputState.Begin and 1 or 0;

    if u7 and (u12[p88.KeyCode] and p88.UserInputState == Enum.UserInputState.Begin) then
        handleDoubleTapReset(p88.KeyCode);
    end;

    return Enum.ContextActionResult.Sink;
end;

local function MousePan(p89, p90, p91) -- Line: 566
    -- upvalues: u49 (copy)
    local Delta = p91.Delta;
    u49.Delta = Vector2.new(-Delta.y, -Delta.x);

    return Enum.ContextActionResult.Sink;
end;

local function Thumb(p92, p93, p94) -- Line: 572
    -- upvalues: u47 (copy)
    u47[p94.KeyCode.Name] = p94.Position;

    return Enum.ContextActionResult.Sink;
end;

local function Trigger(p95, p96, p97) -- Line: 577
    -- upvalues: u47 (copy)
    u47[p97.KeyCode.Name] = p97.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function MouseWheel(p98, p99, p100) -- Line: 582
    -- upvalues: u49 (copy)
    u49[p100.UserInputType.Name] = -p100.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function Zero(p101) -- Line: 587
    for i, v in pairs(p101) do
        p101[i] = v * 0;
    end;
end;

function u43.StartCapture() -- Line: 593
    -- upvalues: u6 (ref), ContextActionService (copy), Keypress (copy), Value (copy), GpButton (copy), u7 (ref), u8 (ref), u10 (ref), MousePan (copy), MouseWheel (copy), Trigger (copy), Thumb (copy)
    if u6 then
        ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y);
        ContextActionService:BindActionAtPriority("FreecamKeyboardControlSpeed", Keypress, false, Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
        ContextActionService:BindActionAtPriority("FreecamGamepadControlSpeed", GpButton, false, Value, Enum.KeyCode.DPadUp, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight);
    else
        ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down);
    end;

    if u7 then
        ContextActionService:BindActionAtPriority("FreecamKeyboardTiltControl", Keypress, false, Value, Enum.KeyCode.Z, Enum.KeyCode.C);
        ContextActionService:BindActionAtPriority("FreecamGamepadTiltControl", GpButton, false, Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
        ContextActionService:BindActionAtPriority("FreecamKeyboardTiltControlSpeed", Keypress, false, Value, Enum.KeyCode.Comma, Enum.KeyCode.Period);

        if u8 then
            ContextActionService:BindActionAtPriority("FreecamKeyboardSmoothnessControl", Keypress, false, Value, Enum.KeyCode.LeftBracket, Enum.KeyCode.RightBracket, Enum.KeyCode.Semicolon, Enum.KeyCode.Quote, Enum.KeyCode.V, Enum.KeyCode.B, Enum.KeyCode.N, Enum.KeyCode.M);
        end;
    end;

    if u10 then
        ContextActionService:BindActionAtPriority("FreecamKeyboardDoFToggle", Keypress, false, Value, Enum.KeyCode.BackSlash);
        ContextActionService:BindActionAtPriority("FreecamKeyboardDoFControls", Keypress, false, Value, Enum.KeyCode.Minus, Enum.KeyCode.Equals);
    end;

    ContextActionService:BindActionAtPriority("FreecamMousePan", MousePan, false, Value, Enum.UserInputType.MouseMovement);
    ContextActionService:BindActionAtPriority("FreecamMouseWheel", MouseWheel, false, Value, Enum.UserInputType.MouseWheel);
    ContextActionService:BindActionAtPriority("FreecamGamepadButton", GpButton, false, Value, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    ContextActionService:BindActionAtPriority("FreecamGamepadTrigger", Trigger, false, Value, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb, false, Value, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
end;

function u43.StopCapture() -- Line: 654
    -- upvalues: u54 (ref), u6 (ref), u56 (ref), u7 (ref), u55 (ref), u47 (copy), u48 (copy), u49 (copy), ContextActionService (copy), u8 (ref), u10 (ref)
    u54 = 1;

    if u6 then
        u56 = 1;
    end;

    if u7 then
        u55 = 1;
    end;

    local v102 = u47;

    for i, v in pairs(v102) do
        v102[i] = v * 0;
    end;

    local v103 = u48;

    for i, v in pairs(v103) do
        v103[i] = v * 0;
    end;

    local v104 = u49;

    for i, v in pairs(v104) do
        v104[i] = v * 0;
    end;

    ContextActionService:UnbindAction("FreecamKeyboard");

    if u6 then
        ContextActionService:UnbindAction("FreecamKeyboardControlSpeed");
        ContextActionService:UnbindAction("FreecamGamepadControlSpeed");
    end;

    if u7 then
        ContextActionService:UnbindAction("FreecamKeyboardTiltControl");
        ContextActionService:UnbindAction("FreecamGamepadTiltControl");
        ContextActionService:UnbindAction("FreecamKeyboardTiltControlSpeed");

        if u8 then
            ContextActionService:UnbindAction("FreecamKeyboardSmoothnessControl");
        end;
    end;

    if u10 then
        ContextActionService:UnbindAction("FreecamKeyboardDoFToggle");
        ContextActionService:UnbindAction("FreecamKeyboardDoFControls");
    end;

    ContextActionService:UnbindAction("FreecamMousePan");
    ContextActionService:UnbindAction("FreecamMouseWheel");
    ContextActionService:UnbindAction("FreecamGamepadButton");
    ContextActionService:UnbindAction("FreecamGamepadTrigger");
    ContextActionService:UnbindAction("FreecamGamepadThumbstick");
end;

local function GetFocusDistance(p105) -- Line: 692
    -- upvalues: CurrentCamera (ref), u38 (ref), math_tan (copy), Workspace (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v106 = math_tan(u38 / 2) * 2;
    local v107 = ViewportSize.x / ViewportSize.y * v106;
    local rightVector = p105.rightVector;
    local upVector = p105.upVector;
    local lookVector = p105.lookVector;
    local Vector3_new_ret2 = Vector3.new();
    local v108 = 512;

    for i = 0, 1, 0.5 do
        local v109 = i;

        for i2 = 0, 1, 0.5 do
            local v110 = rightVector * ((v109 - 0.5) * v107) - upVector * ((i2 - 0.5) * v106) + lookVector;
            local v111 = p105.p + v110 * 0.1;
            local _, v112 = Workspace:FindPartOnRay(Ray.new(v111, v110.unit * v108));
            local magnitude = (v112 - v111).magnitude;
            local v113;

            if magnitude < v108 then
                Vector3_new_ret2 = v110.unit;
                v108 = magnitude;
                v113 = i2;
            else
                v113 = i2;
            end;
        end;
    end;

    return lookVector:Dot(Vector3_new_ret2) * v108;
end;

local function StepFreecam(p114) -- Line: 724
    -- upvalues: u8 (ref), u43 (copy), u10 (ref), u1 (ref), u39 (copy), u40 (copy), u41 (copy), u7 (ref), u42 (copy), u38 (ref), math_rad (copy), math_tan (copy), math_sqrt (copy), math_clamp (copy), u14 (copy), u37 (ref), Vector3_new_ret (ref), CurrentCamera (ref), GetFocusDistance (copy)
    if u8 then
        u43.SpringControl(p114);
    end;

    if u10 and (u1 and u1.Parent) then
        u43.DoF(p114);
    end;

    local v115 = u39:Update(p114, u43.Vel(p114));
    local v116 = u40:Update(p114, u43.Pan(p114));
    local v117 = u41:Update(p114, u43.Fov(p114));
    local v118;

    if u7 then
        v118 = u42:Update(p114, u43.Roll(p114));
    else
        v118 = nil;
    end;

    local v119 = math_sqrt(0.7002075382097097 / math_tan((math_rad(u38 / 2))));
    u38 = math_clamp(u38 + v117 * 300 * (p114 / v119), 1, 120);
    local v120;

    if u7 then
        local v121 = v116 * u14 * (p114 / v119);
        u37 = u37 + Vector3.new(v121.X, v121.Y, v118 * -1.5707963267948966 * (p114 / v119));

        if u8 then
            u37 = Vector3.new(u37.x % 6.283185307179586, u37.y % 6.283185307179586, u37.z % 6.283185307179586);
        else
            local v122 = math_clamp(u37.x, -1.5707963267948966, 1.5707963267948966);
            u37 = Vector3.new(v122, u37.y % 6.283185307179586, u37.z);
        end;

        v120 = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation(u37.x, u37.y, u37.z) * CFrame.new(v115 * Vector3.new(50, 50, 50) * p114);
    else
        u37 = u37 + v116 * u14 * (p114 / v119);
        u37 = Vector2.new(math_clamp(u37.x, -1.5707963267948966, 1.5707963267948966), u37.y % 6.283185307179586);
        v120 = CFrame.new(Vector3_new_ret) * CFrame.fromOrientation(u37.x, u37.y, 0) * CFrame.new(v115 * Vector3.new(50, 50, 50) * p114);
    end;

    Vector3_new_ret = v120.p;
    CurrentCamera.CFrame = v120;
    CurrentCamera.Focus = v120 * CFrame.new(0, 0, -GetFocusDistance(v120));
    CurrentCamera.FieldOfView = u38;
end;

local function CheckMouseLockAvailability() -- Line: 771
    -- upvalues: Players (copy), GameSettings (copy)
    return Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);
end;

local u123 = {};
local u124 = nil;
local u125 = nil;
local u126 = nil;
local u127 = nil;
local u128 = nil;
local u129 = nil;
local u130 = {};

function u123.Push() -- Line: 803
    -- upvalues: u129 (ref), CurrentCamera (ref), u126 (ref), u128 (ref), u127 (ref), u125 (ref), UserInputService (copy), u2 (ref), Players (copy), GameSettings (copy), u124 (ref)
    u129 = CurrentCamera.FieldOfView;
    CurrentCamera.FieldOfView = 70;
    u126 = CurrentCamera.CameraType;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u128 = CurrentCamera.CFrame;
    u127 = CurrentCamera.Focus;
    u125 = UserInputService.MouseIconEnabled;
    UserInputService.MouseIconEnabled = true;

    if u2 then
        if Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable) then
            u124 = Enum.MouseBehavior.Default;
        else
            u124 = UserInputService.MouseBehavior;
        end;
    else
        u124 = UserInputService.MouseBehavior;
    end;

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u123.Pop() -- Line: 852
    -- upvalues: u5 (ref), u130 (ref), CurrentCamera (ref), u129 (ref), u126 (ref), u128 (ref), u127 (ref), UserInputService (copy), u125 (ref), u124 (ref)
    if u5 then
        u130 = {};
    end;

    CurrentCamera.FieldOfView = u129;
    u129 = nil;
    CurrentCamera.CameraType = u126;
    u126 = nil;
    CurrentCamera.CFrame = u128;
    u128 = nil;
    CurrentCamera.Focus = u127;
    u127 = nil;
    UserInputService.MouseIconEnabled = u125;
    u125 = nil;
    UserInputService.MouseBehavior = u124;
    u124 = nil;
end;

local function StartFreecam() -- Line: 889
    -- upvalues: u9 (ref), u3 (ref), CurrentCamera (ref), u7 (ref), u37 (ref), Vector3_new_ret (ref), u38 (ref), u39 (copy), u40 (copy), u41 (copy), u42 (copy), u8 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u123 (copy), u10 (ref), u1 (ref), RunService (copy), StepFreecam (copy), u43 (copy)
    if not u9 and u3 then
        script:SetAttribute("FreecamEnabled", true);
    end;

    local CFrame2 = CurrentCamera.CFrame;

    if u7 then
        u37 = Vector3.new(CFrame2:toEulerAnglesYXZ());
    else
        u37 = Vector2.new(CFrame2:toEulerAnglesYXZ());
    end;

    Vector3_new_ret = CFrame2.p;
    u38 = CurrentCamera.FieldOfView;
    u39:Reset((Vector3.new()));
    u40:Reset(Vector2.new());
    u41:Reset(0);

    if u7 then
        u42:Reset(0);
    end;

    if u8 then
        u15 = 1.5;
        u16 = 1;
        u17 = 4;
        u18 = 1;
    end;

    u123.Push();

    if u10 and not (u1 and u1.Parent) then
        u1 = Instance.new("DepthOfFieldEffect");
        u1.Enabled = false;
        u1.Name = "FreecamDepthOfField";
        u1.Parent = CurrentCamera;
    end;

    RunService:BindToRenderStep("CustomFreecam", Enum.RenderPriority.Camera.Value, StepFreecam);
    u43.StartCapture();
end;

local function StopFreecam() -- Line: 935
    -- upvalues: u9 (ref), u3 (ref), u10 (ref), u1 (ref), u21 (ref), u43 (copy), RunService (copy), u123 (copy)
    if not u9 and u3 then
        script:SetAttribute("FreecamEnabled", false);
    end;

    if u10 and (u1 and u1.Parent) then
        if u1.Enabled then
            for _, v in ipairs(u21) do
                if v.Parent then
                    v.Enabled = true;
                end;
            end;

            u21 = {};
        end;

        u1.Enabled = false;
    end;

    u43.StopCapture();
    RunService:UnbindFromRenderStep("CustomFreecam");
    u123.Pop();
end;

local u131 = false;
script:WaitForChild("Toggle").Event:Connect(function(p132) -- Line: 967
    -- upvalues: u131 (ref), StartFreecam (copy), StopFreecam (copy)
    if p132 and not u131 then
        StartFreecam();
    elseif not p132 and u131 then
        StopFreecam();
    end;

    u131 = p132;
end);