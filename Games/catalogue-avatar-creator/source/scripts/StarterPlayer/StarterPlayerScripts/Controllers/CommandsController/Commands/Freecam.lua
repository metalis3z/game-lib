-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local abs = math.abs;
local clamp = math.clamp;
local exp = math.exp;
local rad = math.rad;
local sign = math.sign;
local sqrt = math.sqrt;
local tan = math.tan;
local ContextActionService = game:GetService("ContextActionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace");
local GameSettings = UserSettings().GameSettings;
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 52
    -- upvalues: Workspace (copy), CurrentCamera (ref)
    local CurrentCamera2 = Workspace.CurrentCamera;

    if CurrentCamera2 then
        CurrentCamera = CurrentCamera2;
    end;
end);
local success, result = pcall(function() -- Line: 61
    -- upvalues: LocalPlayer (copy)
    local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 10);

    if PlayerScripts then
        PlayerScripts = PlayerScripts:WaitForChild("PlayerModule", 10);
    end;

    if PlayerScripts then
        return require(PlayerScripts):GetControls();
    end;

    return nil;
end);

if not success then
    result = nil;
end;

local Value = Enum.ContextActionPriority.High.Value;
local u1 = {
    [Enum.KeyCode.Z] = true,
    [Enum.KeyCode.C] = true
};
local u2 = {
    [Enum.KeyCode.ButtonL1] = true,
    [Enum.KeyCode.ButtonR1] = true
};
local u3 = Vector2.new(0.75, 1) * 8;
local u4 = 3.75;
local u5 = 2.5;
local u6 = 10;
local u7 = 2.5;
local u8 = {};
local u9 = 0;
local u10 = {};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 114
    -- upvalues: u10 (copy)
    local v13 = setmetatable({}, u10);
    v13.f = p11;
    v13.p = p12;
    v13.v = p12 * 0;

    return v13;
end;

function u10.Update(p14, p15, p16) -- Line: 122
    -- upvalues: exp (copy)
    local v17 = p14.f * 2 * 3.141592653589793;
    local v = p14.v;
    local v18 = p16 - p14.p;
    local v19 = exp(-v17 * p15);
    local v20 = p16 + (v * p15 - v18 * (v17 * p15 + 1)) * v19;
    p14.p = v20;
    p14.v = (v17 * p15 * (v18 * v17 - v) + v) * v19;

    return v20;
end;

function u10.SetFreq(p21, p22) -- Line: 139
    p21.f = p22;
end;

function u10.Reset(p23, p24) -- Line: 143
    p23.p = p24;
    p23.v = p24 * 0;
end;

local u25 = Vector3.new();
local u26 = Vector3.new();
local u27 = 0;
local u28 = u10.new(u4, (Vector3.new()));
local u29 = u10.new(u5, Vector2.new());
local u30 = u10.new(u6, 0);
local u31 = u10.new(u7, 0);
local u32 = {};

local function fCurve(p33) -- Line: 167
    -- upvalues: exp (copy)
    return (exp(2 * p33) - 1) / 6.38905609893065;
end;

local function fDeadzone(p34) -- Line: 171
    -- upvalues: exp (copy)
    return (exp(2 * ((p34 - 0.15) / 0.85)) - 1) / 6.38905609893065;
end;

local function thumbstickCurve(p35) -- Line: 175
    -- upvalues: sign (copy), abs (copy), exp (copy), clamp (copy)
    return sign(p35) * clamp((exp(2 * ((abs(p35) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1);
end;

local u36 = {
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
local u37 = {
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
    M = 0
};
local u38 = {
    MouseWheel = 0,
    Delta = Vector2.new()
};
local u39 = Vector2.new(1, 1) * 0.04908738521234052;
local u40 = u39 / 60;
local u41 = Vector2.new(1, 1) * 0.39269908169872414;
local u42 = 1;
local u43 = 1;
local u44 = 1;

function u32.Vel(p45) -- Line: 237
    -- upvalues: u42 (ref), u37 (copy), u36 (copy), clamp (copy), result (ref), UserInputService (copy), thumbstickCurve (ref)
    u42 = clamp(u42 + p45 * (u37.Up - u37.Down + u36.DPadUp - u36.DPadDown) * 0.75, 0.01, 4);
    local v46 = (not result or (not UserInputService.TouchEnabled or (UserInputService.GamepadEnabled or (u37.W ~= 0 or (u37.A ~= 0 or (u37.S ~= 0 or u37.D ~= 0)))))) and Vector3.new(0, 0, 0) or result:GetMoveVector();
    local v47 = thumbstickCurve(u36.Thumbstick1.X);
    local v48 = thumbstickCurve(u36.ButtonR2) - thumbstickCurve(u36.ButtonL2);
    local v49 = Vector3.new(v47, v48, thumbstickCurve(-u36.Thumbstick1.Y)) * Vector3.new(1, 1, 1);
    local v50 = Vector3.new(u37.D - u37.A + u37.K - u37.H + v46.X, u37.E - u37.Q + u37.I - u37.Y, u37.S - u37.W + u37.J - u37.U + v46.Z) * Vector3.new(1, 1, 1);
    local v51 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);

    return (v49 + v50) * (u42 * (v51 and 0.25 or 1));
end;

function u32.Pan(p52) -- Line: 265
    -- upvalues: thumbstickCurve (ref), u36 (copy), u41 (copy), u38 (copy), u39 (copy), u40 (copy)
    local v53 = Vector2.new(thumbstickCurve(u36.Thumbstick2.Y), thumbstickCurve(-u36.Thumbstick2.X)) * u41;
    local v54 = u38.Delta * u39;

    if p52 > 0 then
        v54 = u38.Delta / p52 * u40;
    end;

    u38.Delta = Vector2.new();

    return v53 + v54;
end;

function u32.Fov(p55) -- Line: 278
    -- upvalues: u44 (ref), u37 (copy), u36 (copy), clamp (copy), u38 (copy)
    u44 = clamp(u44 + p55 * (u37.Right - u37.Left + u36.DPadRight - u36.DPadLeft) * 0.75, 0.01, 4);
    local v56 = (u36.ButtonX - u36.ButtonY) * 0.25;
    local v57 = u38.MouseWheel * 1;

    if p55 > 0 then
        v57 = u38.MouseWheel / p55 * 0.016666666666666666;
    end;

    u38.MouseWheel = 0;

    return (v56 + v57) * u44;
end;

function u32.Roll(p58) -- Line: 289
    -- upvalues: u43 (ref), u37 (copy), clamp (copy), u36 (copy)
    u43 = clamp(u43 + p58 * (u37.Period - u37.Comma) * 0.75, 0.01, 4);

    return ((u36.ButtonR1 - u36.ButtonL1) * 1 + (u37.C - u37.Z) * 1) * u43;
end;

function u32.SpringControl(p59) -- Line: 296
    -- upvalues: u4 (ref), u37 (copy), clamp (copy), u28 (copy), u5 (ref), u29 (copy), u6 (ref), u30 (copy), u7 (ref), u31 (copy)
    u4 = clamp(u4 + p59 * (u37.RightBracket - u37.LeftBracket) * 0.75, 0.01, 10);
    u28:SetFreq(u4);
    u5 = clamp(u5 + p59 * (u37.Quote - u37.Semicolon) * 0.75, 0.01, 10);
    u29:SetFreq(u5);
    u6 = clamp(u6 + p59 * (u37.B - u37.V) * 0.75, 0.01, 10);
    u30:SetFreq(u6);
    u7 = clamp(u7 + p59 * (u37.M - u37.N) * 0.75, 0.01, 10);
    u31:SetFreq(u7);
end;

local function resetKeys(p60, p61) -- Line: 311
    for i, _ in pairs(p60) do
        if p61[i.Name] then
            p61[i.Name] = 0;
        end;
    end;
end;

local function handleDoubleTapReset(p62) -- Line: 319
    -- upvalues: u8 (copy), u9 (ref), u26 (ref), u31 (copy), u2 (copy), u36 (copy), u1 (copy), u37 (copy)
    local v63 = os.clock();
    local v64 = u8[p62];

    if v64 and ((v64 and (v63 - v64 or -1) or -1) <= 0.25 and v63 - u9 >= 0.1) then
        u26 = Vector3.new(u26.x, u26.y, 0);
        u31:Reset(0);
        local v65 = u36;

        for i, _ in pairs(u2) do
            if v65[i.Name] then
                v65[i.Name] = 0;
            end;
        end;

        local v66 = u37;

        for i, _ in pairs(u1) do
            if v66[i.Name] then
                v66[i.Name] = 0;
            end;
        end;

        u9 = v63;
    end;

    u8[p62] = v63;
end;

local function Keypress(p67, p68, p69) -- Line: 336
    -- upvalues: u37 (copy), u1 (copy), handleDoubleTapReset (copy)
    u37[p69.KeyCode.Name] = p68 == Enum.UserInputState.Begin and 1 or 0;

    if u1[p69.KeyCode] and p69.UserInputState == Enum.UserInputState.Begin then
        handleDoubleTapReset(p69.KeyCode);
    end;

    return Enum.ContextActionResult.Sink;
end;

local function GpButton(p70, p71, p72) -- Line: 346
    -- upvalues: u36 (copy), u2 (copy), handleDoubleTapReset (copy)
    u36[p72.KeyCode.Name] = p71 == Enum.UserInputState.Begin and 1 or 0;

    if u2[p72.KeyCode] and p72.UserInputState == Enum.UserInputState.Begin then
        handleDoubleTapReset(p72.KeyCode);
    end;

    return Enum.ContextActionResult.Sink;
end;

local function Thumb(p73, p74, p75) -- Line: 356
    -- upvalues: u36 (copy)
    u36[p75.KeyCode.Name] = p75.Position;

    return Enum.ContextActionResult.Sink;
end;

local function Trigger(p76, p77, p78) -- Line: 361
    -- upvalues: u36 (copy)
    u36[p78.KeyCode.Name] = p78.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function MousePan(p79, p80, p81) -- Line: 366
    -- upvalues: u38 (copy)
    local Delta = p81.Delta;
    u38.Delta = Vector2.new(-Delta.y, -Delta.x);

    return Enum.ContextActionResult.Sink;
end;

local u82 = nil;
local u83 = nil;
local u84 = 1;

local function MouseWheel(p85, p86, p87) -- Line: 379
    -- upvalues: u38 (copy)
    u38[p87.UserInputType.Name] = -p87.Position.z;

    return Enum.ContextActionResult.Sink;
end;

local function Zero(p88) -- Line: 384
    for i, v in pairs(p88) do
        p88[i] = v * 0;
    end;
end;

function u32.StartCapture() -- Line: 390
    -- upvalues: ContextActionService (copy), Keypress (copy), Value (copy), GpButton (copy), Trigger (copy), Thumb (copy), MousePan (copy), MouseWheel (copy), u82 (ref), UserInputService (copy), u38 (copy), u84 (ref), u83 (ref)
    ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y);
    ContextActionService:BindActionAtPriority("FreecamKeyboardControlSpeed", Keypress, false, Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
    ContextActionService:BindActionAtPriority("FreecamKeyboardTiltControl", Keypress, false, Value, Enum.KeyCode.Z, Enum.KeyCode.C);
    ContextActionService:BindActionAtPriority("FreecamKeyboardTiltControlSpeed", Keypress, false, Value, Enum.KeyCode.Comma, Enum.KeyCode.Period);
    ContextActionService:BindActionAtPriority("FreecamKeyboardSmoothnessControl", Keypress, false, Value, Enum.KeyCode.LeftBracket, Enum.KeyCode.RightBracket, Enum.KeyCode.Semicolon, Enum.KeyCode.Quote, Enum.KeyCode.V, Enum.KeyCode.B, Enum.KeyCode.N, Enum.KeyCode.M);
    ContextActionService:BindActionAtPriority("FreecamGamepadControlSpeed", GpButton, false, Value, Enum.KeyCode.DPadUp, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight);
    ContextActionService:BindActionAtPriority("FreecamGamepadTiltControl", GpButton, false, Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    ContextActionService:BindActionAtPriority("FreecamGamepadButton", GpButton, false, Value, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY);
    ContextActionService:BindActionAtPriority("FreecamGamepadTrigger", Trigger, false, Value, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2);
    ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb, false, Value, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2);
    ContextActionService:BindActionAtPriority("FreecamMousePan", MousePan, false, Value, Enum.UserInputType.MouseMovement);
    ContextActionService:BindActionAtPriority("FreecamMouseWheel", MouseWheel, false, Value, Enum.UserInputType.MouseWheel);
    u82 = UserInputService.InputChanged:Connect(function(p89, p90) -- Line: 430
        -- upvalues: u38 (ref)
        if p90 then
            return;
        end;

        if p89.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local Delta = p89.Delta;
        u38.Delta = u38.Delta + Vector2.new(-Delta.Y, -Delta.X);
    end);
    u84 = 1;
    u83 = UserInputService.TouchPinch:Connect(function(p91, p92, p93, p94, p95) -- Line: 437
        -- upvalues: u84 (ref), u38 (ref)
        if p95 then
            return;
        end;

        if p94 == Enum.UserInputState.Begin then
            u84 = p92;

            return;
        end;

        if p94 == Enum.UserInputState.Change then
            u38.MouseWheel = u38.MouseWheel - (p92 - u84) * 10;
            u84 = p92;
        end;
    end);
end;

function u32.StopCapture() -- Line: 448
    -- upvalues: u42 (ref), u44 (ref), u43 (ref), u36 (copy), u37 (copy), u38 (copy), ContextActionService (copy), u82 (ref), u83 (ref)
    u42 = 1;
    u44 = 1;
    u43 = 1;
    local v96 = u36;

    for i, v in pairs(v96) do
        v96[i] = v * 0;
    end;

    local v97 = u37;

    for i, v in pairs(v97) do
        v97[i] = v * 0;
    end;

    local v98 = u38;

    for i, v in pairs(v98) do
        v98[i] = v * 0;
    end;

    ContextActionService:UnbindAction("FreecamKeyboard");
    ContextActionService:UnbindAction("FreecamKeyboardControlSpeed");
    ContextActionService:UnbindAction("FreecamKeyboardTiltControl");
    ContextActionService:UnbindAction("FreecamKeyboardTiltControlSpeed");
    ContextActionService:UnbindAction("FreecamKeyboardSmoothnessControl");
    ContextActionService:UnbindAction("FreecamGamepadControlSpeed");
    ContextActionService:UnbindAction("FreecamGamepadTiltControl");
    ContextActionService:UnbindAction("FreecamGamepadButton");
    ContextActionService:UnbindAction("FreecamGamepadTrigger");
    ContextActionService:UnbindAction("FreecamGamepadThumbstick");
    ContextActionService:UnbindAction("FreecamMousePan");
    ContextActionService:UnbindAction("FreecamMouseWheel");

    if u82 then
        u82:Disconnect();
        u82 = nil;
    end;

    if u83 then
        u83:Disconnect();
        u83 = nil;
    end;
end;

local function StepFreecam(p99) -- Line: 481
    -- upvalues: u32 (copy), u28 (copy), u29 (copy), u30 (copy), u31 (copy), u27 (ref), rad (copy), tan (copy), sqrt (copy), clamp (copy), u3 (copy), u26 (ref), u25 (ref), CurrentCamera (ref)
    u32.SpringControl(p99);
    local v100 = u28:Update(p99, u32.Vel(p99));
    local v101 = u29:Update(p99, u32.Pan(p99));
    local v102 = u30:Update(p99, u32.Fov(p99));
    local v103 = u31:Update(p99, u32.Roll(p99));
    local v104 = sqrt(0.7002075382097097 / tan((rad(u27 / 2))));
    u27 = clamp(u27 + v102 * 300 * (p99 / v104), 1, 120);
    local v105 = v101 * u3 * (p99 / v104);
    u26 = u26 + Vector3.new(v105.X, v105.Y, v103 * -1.5707963267948966 * (p99 / v104));
    u26 = Vector3.new(u26.x % 6.283185307179586, u26.y % 6.283185307179586, u26.z % 6.283185307179586);
    local v106 = CFrame.new(u25) * CFrame.fromOrientation(u26.x, u26.y, u26.z) * CFrame.new(v100 * Vector3.new(64, 64, 64) * p99);
    u25 = v106.p;
    CurrentCamera.CFrame = v106;
    CurrentCamera.Focus = v106;
    CurrentCamera.FieldOfView = u27;
end;

local function CheckMouseLockAvailability() -- Line: 506
    -- upvalues: LocalPlayer (copy), GameSettings (copy)
    return LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);
end;

local u107 = {};
local u108 = nil;
local u109 = nil;
local u110 = nil;
local u111 = nil;
local u112 = nil;
local u113 = nil;
local u114 = nil;
local u115 = nil;
local u116 = nil;

function u107.Push() -- Line: 527
    -- upvalues: u110 (ref), CurrentCamera (ref), u112 (ref), u111 (ref), u109 (ref), UserInputService (copy), LocalPlayer (copy), GameSettings (copy), u108 (ref), u113 (ref), u114 (ref), u115 (ref), u116 (ref)
    u110 = CurrentCamera.CameraType;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    u112 = CurrentCamera.CFrame;
    u111 = CurrentCamera.Focus;
    u109 = UserInputService.MouseIconEnabled;
    UserInputService.MouseIconEnabled = false;

    if LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable) then
        u108 = Enum.MouseBehavior.Default;
    else
        u108 = UserInputService.MouseBehavior;
    end;

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Humanoid");
    end;

    u113 = Character;

    if u113 then
        u114 = u113.WalkSpeed;
        u115 = u113.JumpPower;
        u116 = u113.AutoRotate;
        u113.WalkSpeed = 0;
        u113.JumpPower = 0;
        u113.AutoRotate = false;
    end;
end;

function u107.Pop() -- Line: 559
    -- upvalues: CurrentCamera (ref), u110 (ref), u112 (ref), u111 (ref), UserInputService (copy), u109 (ref), u108 (ref), u113 (ref), u114 (ref), u115 (ref), u116 (ref)
    CurrentCamera.CameraType = u110;
    u110 = nil;
    CurrentCamera.CFrame = u112;
    u112 = nil;
    CurrentCamera.Focus = u111;
    u111 = nil;
    UserInputService.MouseIconEnabled = u109;
    u109 = nil;
    UserInputService.MouseBehavior = u108;
    u108 = nil;

    if u113 and u113.Parent then
        u113.WalkSpeed = u114;
        u113.JumpPower = u115;
        u113.AutoRotate = u116;
    end;

    u113 = nil;
    u114 = nil;
    u115 = nil;
    u116 = nil;
end;

local u117 = {
    IsOn = false
};
local u118 = {};

function u117.Start() -- Line: 593
    -- upvalues: u117 (copy), CurrentCamera (ref), u26 (ref), u25 (ref), u27 (ref), u28 (copy), u29 (copy), u30 (copy), u31 (copy), u107 (copy), RunService (copy), StepFreecam (copy), u32 (copy)
    if u117.IsOn then
        return;
    end;

    u117.IsOn = true;
    local CFrame2 = CurrentCamera.CFrame;
    u26 = Vector3.new(CFrame2:toEulerAnglesYXZ());
    u25 = CFrame2.p;
    u27 = CurrentCamera.FieldOfView;
    u28:Reset((Vector3.new()));
    u29:Reset(Vector2.new());
    u30:Reset(0);
    u31:Reset(0);
    u107.Push();
    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam);
    u32.StartCapture();
end;

function u117.Stop() -- Line: 613
    -- upvalues: u117 (copy), u32 (copy), RunService (copy), u107 (copy)
    if not u117.IsOn then
        return;
    end;

    u117.IsOn = false;
    u32.StopCapture();
    RunService:UnbindFromRenderStep("Freecam");
    u107.Pop();
end;

function u117.SaveCFrame(p119) -- Line: 622
    -- upvalues: u118 (copy), CurrentCamera (ref)
    if p119 == nil then
        local v120 = 0;

        for i in pairs(u118) do
            if v120 < i then
                v120 = i;
            end;
        end;

        p119 = v120 + 1;
    end;

    u118[p119] = CurrentCamera.CFrame;

    return p119;
end;

function u117.LoadCFrame(p121) -- Line: 634
    -- upvalues: u118 (copy), u117 (copy), u25 (ref), u26 (ref), u28 (copy), u29 (copy), CurrentCamera (ref)
    local v122 = u118[p121];

    if not v122 then
        return false;
    end;

    if not u117.IsOn then
        u117.Start();
    end;

    u25 = v122.Position;
    u26 = Vector3.new(v122:ToEulerAnglesYXZ());
    u28:Reset((Vector3.new()));
    u29:Reset(Vector2.new());
    CurrentCamera.CFrame = v122;
    CurrentCamera.Focus = v122;

    return true;
end;

return u117;