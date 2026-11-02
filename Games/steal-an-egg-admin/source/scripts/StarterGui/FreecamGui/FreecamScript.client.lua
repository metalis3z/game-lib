-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local abs = math.abs
local clamp = math.clamp
local exp = math.exp
local rad = math.rad
local sign = math.sign
local sqrt = math.sqrt
local tan = math.tan
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local LocalPlayer_2 = LocalPlayer

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer_2 = Players.LocalPlayer
end
local CurrentCamera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line 24 | captures: CurrentCamera, Workspace
    local CurrentCamera_2 = Workspace.CurrentCamera
    if CurrentCamera_2 then
        CurrentCamera = CurrentCamera_2
    end
end)
local Value = Enum.ContextActionPriority.Low.Value
local Value_2 = Enum.ContextActionPriority.High.Value
local v1 = {
    Enum.KeyCode.LeftShift,
    Enum.KeyCode.P
}
local v2 = Vector2.new(0.75, 1) * 8
local v3 = {}

v3.__index = v3

function v3.new(v4, v5) -- line 48 | captures: v3
    local v6 = {}
    local v7 = setmetatable(v6, v3)
    v7.f = v4
    v7.p = v5
    v7.v = v5 * 0
    return v7
end

function v3.Update(v8, v9, v10) -- line 56 | captures: exp
    local v11 = v8.f * 2 * 3.141592653589793
    local p = v8.p
    local v = v8.v
    local v12 = v10 - p
    local v13 = -v11 * v9
    local v14 = exp(v13)
    local v15 = v10 + (v * v9 - v12 * (v11 * v9 + 1)) * v14
    local v16 = (v11 * v9 * (v12 * v11 - v) + v) * v14
    v8.p = v15
    v8.v = v16
    return v15
end

local function Reset(v17, v18) -- line 73
    v17.p = v18
    v17.v = v18 * 0
end

v3.Reset = Reset

local v19 = Vector3.new()
local v20 = Vector2.new()
local v21 = 0
local v22 = v3.new(1.5, (Vector3.new()))
local v23 = v3.new(1, Vector2.new())
local v24 = v3.new(4, 0)
local v25 = {}

local function fCurve(v26) -- line 92 | captures: exp
    local v27 = 2 * v26
    return (exp(v27) - 1) / 6.38905609893065
end

local function fDeadzone(v28) -- line 96 | captures: exp
    local v29 = 2 * ((v28 - 0.15) / 0.85)
    return (exp(v29) - 1) / 6.38905609893065
end

local function v30(v31) -- line 100 | captures: abs, clamp, exp, sign
    local v32 = sign(v31)
    local v33 = 2 * ((abs(v31) - 0.15) / 0.85)
    local v34 = (exp(v33) - 1) / 6.38905609893065
    return v32 * clamp(v34, 0, 1)
end

local v35 = {
    ButtonX = 0,
    ButtonY = 0,
    DPadDown = 0,
    DPadUp = 0,
    ButtonL2 = 0,
    ButtonR2 = 0,
    Thumbstick1 = Vector2.new(),
    Thumbstick2 = Vector2.new()
}
local v36 = {
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
    LeftShift = 0,
    RightShift = 0
}
local v37 = {
    MouseWheel = 0,
    Delta = Vector2.new()
}
local v38 = Vector2.new(1, 1) * 0.04908738521234052
local v39 = Vector2.new(1, 1) * 0.39269908169872414
local v40 = 1

function v25.Vel(v41) -- line 151 | captures: v30, v40, clamp, UserInputService, v35, v36
    local function v42(v43, v44, ...)
        return (Vector3.new(v43, v44, ...))
    end

    local v45 = v40 + v41 * (v36.Up - v36.Down) * 0.75
    v40 = clamp(v45, 0.01, 4)
    local v46 = v42(v30(v35.Thumbstick1.X), v30(v35.ButtonR2) - v30(v35.ButtonL2), v30(-v35.Thumbstick1.Y)) * Vector3.new(1, 1, 1)
    local v47 = v36.D - v36.A + v36.K - v36.H
    local v48 = v36.E - v36.Q + v36.I - v36.Y
    local v49 = v36.S - v36.W + v36.J - v36.U
    local v50 = Vector3.new(v47, v48, v49) * Vector3.new(1, 1, 1)
    local v51 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    local v52 = v46 + v50
    local v53 = v40
    local v54 = if v51 then 0.25 else 1
    return v52 * (v53 * v54)
end

function v25.Pan(v55) -- line 171 | captures: v30, v35, v37, v38, v39
    local v56 = Vector2.new(v30(v35.Thumbstick2.Y), v30(-v35.Thumbstick2.X)) * v39
    local v57 = v37.Delta * v38
    v37.Delta = Vector2.new()
    return v56 + v57
end

function v25.Fov(v58) -- line 181 | captures: v35, v37
    local v59 = (v35.ButtonX - v35.ButtonY) * 0.25
    local v60 = v37.MouseWheel * 1
    v37.MouseWheel = 0
    return v59 + v60
end

local function Keypress(v61, v62, v63) -- line 189 | captures: v36
    local Name = v63.KeyCode.Name
    local v64 = if v62 == Enum.UserInputState.Begin then 1 else 0
    v36[Name] = v64
    return Enum.ContextActionResult.Sink
end

local function GpButton(v65, v66, v67) -- line 194 | captures: v35
    local Name = v67.KeyCode.Name
    local v68 = if v66 == Enum.UserInputState.Begin then 1 else 0
    v35[Name] = v68
    return Enum.ContextActionResult.Sink
end

local function MousePan(v69, v70, v71) -- line 199 | captures: v37
    local Delta = v71.Delta
    v37.Delta = Vector2.new(-Delta.y, -Delta.x)
    return Enum.ContextActionResult.Sink
end

local function Thumb(v72, v73, v74) -- line 205 | captures: v35
    v35[v74.KeyCode.Name] = v74.Position
    return Enum.ContextActionResult.Sink
end

local function Trigger(v75, v76, v77) -- line 210 | captures: v35
    v35[v77.KeyCode.Name] = v77.Position.z
    return Enum.ContextActionResult.Sink
end

local function MouseWheel(v78, v79, v80) -- line 215 | captures: v37
    v37[v80.UserInputType.Name] = -v80.Position.z
    return Enum.ContextActionResult.Sink
end

local function Zero(v81) -- line 220
    for v82, v83 in pairs(v81) do
        v81[v82] = v83 * 0
    end
end

function v25.StartCapture() -- line 226 | captures: ContextActionService, Value_2, Keypress, GpButton, MousePan, Thumb, Trigger, MouseWheel
    ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, Value_2, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down)
    ContextActionService:BindActionAtPriority("FreecamMousePan", MousePan, false, Value_2, Enum.UserInputType.MouseMovement)
    ContextActionService:BindActionAtPriority("FreecamMouseWheel", MouseWheel, false, Value_2, Enum.UserInputType.MouseWheel)
    ContextActionService:BindActionAtPriority("FreecamGamepadButton", GpButton, false, Value_2, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
    ContextActionService:BindActionAtPriority("FreecamGamepadTrigger", Trigger, false, Value_2, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
    ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb, false, Value_2, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
end

function v25.StopCapture() -- line 243 | captures: v40, ContextActionService, v35, v36, v37
    v40 = 1
    for v84, v85 in pairs(v35) do
        v35[v84] = v85 * 0
    end
    for v86, v87 in pairs(v36) do
        v36[v86] = v87 * 0
    end
    for v88, v89 in pairs(v37) do
        v37[v88] = v89 * 0
    end
    ContextActionService:UnbindAction("FreecamKeyboard")
    ContextActionService:UnbindAction("FreecamMousePan")
    ContextActionService:UnbindAction("FreecamMouseWheel")
    ContextActionService:UnbindAction("FreecamGamepadButton")
    ContextActionService:UnbindAction("FreecamGamepadTrigger")
    ContextActionService:UnbindAction("FreecamGamepadThumbstick")
end

local v90 = v40

local function GetFocusDistance(v91) -- line 258 | captures: CurrentCamera, v21, rad, tan, Workspace
    local ViewportSize = CurrentCamera.ViewportSize
    local v92 = v21
    local v93 = rad(v92) / 2
    local v94 = tan(v93) * 2
    local v95 = ViewportSize.x / ViewportSize.y * v94
    local rightVector = v91.rightVector
    local upVector = v91.upVector
    local lookVector = v91.lookVector
    local v96 = Vector3.new()
    local v97 = 512
    for v98 = 0, 1, 0.5 do
        for v99 = 0, 1, 0.5 do
            local v100 = (v98 - 0.5) * v95
            local v101 = (v99 - 0.5) * v94
            local v102 = rightVector * v100 - upVector * v101 + lookVector
            local v103 = v91.p + v102 * 0.1
            local v104, v105 = Workspace:FindPartOnRay(Ray.new(v103, v102.unit * v97))
            local magnitude = (v105 - v103).magnitude
            if magnitude < v97 then
                v96 = v102.unit
                v97 = magnitude
            end
        end
    end
    return lookVector:Dot(v96) * v97
end

local function StepFreecam(v106) -- line 288 | captures: LocalPlayer_2, CurrentCamera, v19, v20, v21, clamp, rad, sqrt, tan, v2, v22, v23, v24, v25, GetFocusDistance
    local function v107(...)
        return (tonumber(...))
    end

    local v108 = v22:Update(v106, v25.Vel(v106))
    local v109 = v23:Update(v106, v25.Pan(v106))
    local v110 = v24:Update(v106, v25.Fov(v106))
    local v111 = v21 / 2
    local v112 = rad(v111)
    local v113 = 0.7002075382097097 / tan(v112)
    local v114 = sqrt(v113)
    local v115 = v21 + v110 * 300 * (v106 / v114)
    v21 = clamp(v115, 1, 120)
    v20 += v109 * v2 * (v106 / v114)
    local new = Vector2.new
    local x = v20.x
    v20 = new(clamp(x, -1.5707963267948966, 1.5707963267948966), v20.y % 6.283185307179586)
    local v116 = CFrame.new(v19) * CFrame.fromOrientation(v20.x, v20.y, 0)
    local new_2 = CFrame.new
    local v117 = v108 * Vector3.new(64, 64, 64) * v106
    local v118 = v107(LocalPlayer_2:GetAttribute("FreecamSpeed")) or 1
    local v119 = v116 * new_2(v117 * math.clamp(v118, 0.1, 20))
    v19 = v119.p
    CurrentCamera.CFrame = v119
    CurrentCamera.Focus = v119 * CFrame.new(0, 0, -GetFocusDistance(v119))
    CurrentCamera.FieldOfView = v21
end

local v120 = {}
local MouseBehavior, MouseIconEnabled, CameraType
v90 = nil
local CFrame_2, FieldOfView
local v121 = {}
local v122 = {
    Backpack = true,
    Chat = true,
    Health = true,
    PlayerList = true
}
local v123 = {
    BadgesNotificationsActive = true,
    PointsNotificationsActive = true
}

function v120.Push() -- line 326 | captures: LocalPlayer_2, CurrentCamera, MouseBehavior, MouseIconEnabled, CameraType, CFrame_2, FieldOfView, StarterGui, UserInputService, v90, v121, v122, v123
    for v124 in pairs(v122) do
        v122[v124] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[v124])
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v124], false)
    end
    for v125 in pairs(v123) do
        local v126, v127 = pcall(StarterGui.GetCore, StarterGui, v125)
        v123[v125] = v126 and v127 or nil
        if v126 then
            pcall(StarterGui.SetCore, StarterGui, v125, false)
        end
    end
    local PlayerGui = LocalPlayer_2:FindFirstChildOfClass("PlayerGui")
    if PlayerGui then
        for v128, v129 in pairs(PlayerGui:GetChildren()) do
            if v129:IsA("ScreenGui") and v129 ~= script.Parent and v129.Enabled then
                v121[#v121 + 1] = v129
                v129.Enabled = false
            end
        end
    end
    FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.FieldOfView = 70
    CameraType = CurrentCamera.CameraType
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    CFrame_2 = CurrentCamera.CFrame
    v90 = CurrentCamera.Focus
    MouseIconEnabled = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = false
    MouseBehavior = UserInputService.MouseBehavior
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

function v120.Pop() -- line 362 | captures: CurrentCamera, MouseBehavior, MouseIconEnabled, CameraType, CFrame_2, FieldOfView, StarterGui, UserInputService, v90, v121, v122, v123
    for v130, v131 in pairs(v122) do
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v130], v131)
    end
    for v132, v133 in pairs(v123) do
        pcall(StarterGui.SetCore, StarterGui, v132, v133)
    end
    for v134, v135 in pairs(v121) do
        if v135.Parent then
            v135.Enabled = true
        end
    end
    table.clear(v121)
    CurrentCamera.FieldOfView = FieldOfView
    FieldOfView = nil
    CurrentCamera.CameraType = CameraType
    CameraType = nil
    CurrentCamera.CFrame = CFrame_2
    CFrame_2 = nil
    CurrentCamera.Focus = v90
    v90 = nil
    UserInputService.MouseIconEnabled = MouseIconEnabled
    MouseIconEnabled = nil
    UserInputService.MouseBehavior = MouseBehavior
    MouseBehavior = nil
end

local v136 = v90

local function StartFreecam() -- line 396 | captures: CurrentCamera, v19, v20, v21, RunService, Workspace, v22, v23, v24, v25, StepFreecam, v120
    CurrentCamera = Workspace.CurrentCamera
    local CFrame = CurrentCamera.CFrame
    v20 = Vector2.new(CFrame:toEulerAnglesYXZ())
    v19 = CFrame.p
    v21 = CurrentCamera.FieldOfView
    v22:Reset((Vector3.new()))
    v23:Reset(Vector2.new())
    v24:Reset(0)
    v120.Push()
    RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
    v25.StartCapture()
end

local function StopFreecam() -- line 412 | captures: RunService, v25, v120
    v25.StopCapture()
    RunService:UnbindFromRenderStep("Freecam")
    v120.Pop()
end

local TextButton = Instance.new("TextButton")

TextButton.Name = "ExitFreecam"
TextButton.Text = "Exit freecam (Shift+P)"
TextButton.Size = UDim2.fromOffset(210, 42)
TextButton.Position = UDim2.new(0.5, -105, 0, 12)
TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Visible = false
TextButton.Parent = script.Parent
v136 = false

local function ToggleFreecam() -- line 431 | captures: LocalPlayer_2, RunService, v25, v120, v136, StartFreecam, TextButton
    if v136 then
        v25.StopCapture()
        RunService:UnbindFromRenderStep("Freecam")
        v120.Pop()
    else
        StartFreecam()
    end
    v136 = not v136
    LocalPlayer_2:SetAttribute("FreecamEnabled", v136)
    TextButton.Visible = v136
end

local ToggleRequested = script:FindFirstChild("ToggleRequested") or Instance.new("BindableEvent")

ToggleRequested.Name = "ToggleRequested"
ToggleRequested.Parent = script
ToggleRequested.Event:Connect(ToggleFreecam)
TextButton.Activated:Connect(ToggleFreecam)
LocalPlayer_2.CharacterRemoving:Connect(function() -- line 447 | captures: LocalPlayer_2, RunService, v25, v120, v136, StartFreecam, TextButton
    if not v136 then
        return
    end
    if v136 then
        v25.StopCapture()
        RunService:UnbindFromRenderStep("Freecam")
        v120.Pop()
    else
        StartFreecam()
    end
    v136 = not v136
    LocalPlayer_2:SetAttribute("FreecamEnabled", v136)
    TextButton.Visible = v136
end)
script.Destroying:Connect(function() -- line 450 | captures: ContextActionService, RunService, v25, v120, v136
    if v136 then
        v25.StopCapture()
        RunService:UnbindFromRenderStep("Freecam")
        v120.Pop()
    end
    ContextActionService:UnbindAction("FreecamToggle")
end)

local function CheckMacro(v137) -- line 454 | captures: LocalPlayer_2, RunService, UserInputService, v25, v120, v136, StartFreecam, TextButton
    local v138 = #v137 - 1
    for v139 = 1, v138 do
        if not UserInputService:IsKeyDown(v137[v139]) then
            return
        end
    end
    if v136 then
        v25.StopCapture()
        RunService:UnbindFromRenderStep("Freecam")
        v120.Pop()
    else
        StartFreecam()
    end
    v136 = not v136
    LocalPlayer_2:SetAttribute("FreecamEnabled", v136)
    TextButton.Visible = v136
end

local function HandleActivationInput(v140, v141, v142) -- line 463 | captures: UserInputService, v1, CheckMacro
    if v141 == Enum.UserInputState.Begin and not UserInputService:GetFocusedTextBox() and v142.KeyCode == v1[#v1] then
        CheckMacro(v1)
    end
    return Enum.ContextActionResult.Pass
end

local v143 = v1[#v1]
ContextActionService:BindActionAtPriority("FreecamToggle", HandleActivationInput, false, Value, v143)
