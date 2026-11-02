-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = os.clock()
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
local VoiceChatServiceHelper = require(ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper)
local ThreadJoin = require(ReplicatedStorage.UserGenerated.Concurrency.ThreadJoin)
local ClientKit = require(ReplicatedStorage.UserGenerated.Analytics.ClientKit)
local UTF8Sub = require(ReplicatedStorage.UserGenerated.Strings.UTF8Sub)
local DeviceForm = require(ReplicatedStorage.UserGenerated.Roblox.DeviceForm)
local LocalPlayer = Players.LocalPlayer
local v2

function SafeGet(v3, v4, v5) -- line 23
    local v6, v7 = pcall(function(v8, v9) -- line 25 | captures: v3, v4
        return v3[v4]
    end, v3, v4)
    if v6 then
        return v7
    end
    return v5
end

function IsUWP() -- line 33
    local v10, v11 = pcall(function() -- line 35
        local v12 = { 1 }
        return tostring(v12):match("^table: 0x(00000000%x+)$") ~= nil
    end)
    return v10 and v11
end

function IsWindows() -- line 42 | captures: GuiService
    return SafeGet(GuiService, "IsWindows", false)
end

function IsLoaded() -- line 45 | captures: LocalPlayer
    if game:IsLoaded() then
        local Character = LocalPlayer.Character
        return not not (Character and Character.PrimaryPart and Character:FindFirstChild("Humanoid"))
    end
    return false
end

task.spawn(function() -- line 55 | captures: v2
    while true do
        if IsLoaded() then
            break
        end
        task.wait()
    end
    v2 = os.clock()
end)

function GetStartTime() -- line 61 | captures: v1
    local __StartTime = _G.__StartTime
    if type(__StartTime) == "number" then
        return __StartTime
    end
    return v1
end

function GetLoadDurationAsync(v13) -- line 68 | captures: v2
    while true do
        local v14 = v2
        if v14 then
            local v15 = v14 - GetStartTime()
            return (math.max(0, v15))
        end
        if v13 then
            break
        end
        task.wait()
    end
    return nil
end

function Build() -- line 83 | captures: GuiService, HttpService, LocalizationService, Stats, TeleportService, VoiceChatServiceHelper, ThreadJoin, UTF8Sub, DeviceForm, LocalPlayer
    local function v16(...)
        return (tostring(...))
    end

    local function v17(v18, ...)
        table.insert(v18, ...)
    end

    local v19
    local v20 = GetLoadDurationAsync(false)
    local v21 = os.time()
    local v22 = os.clock()
    local v23 = workspace:GetServerTimeNow()
    local v24 = elapsedTime()
    local GameSettings = UserSettings().GameSettings
    local v25, v26 = GuiService:GetGuiInset()
    pcall(function() -- line 92 | captures: v19, LocalPlayer
        local v27 = LocalPlayer:GetNetworkPing()
        if v27 > 0 then
            v19 = v27 * 1000
        end
    end)
    local v28 = LocalPlayer:GetJoinData()
    if v28.LaunchData ~= nil then
        pcall(function() -- line 100 | captures: v28, HttpService
            v28.LaunchData = HttpService:JSONDecode(v28.LaunchData)
        end)
    end
    local v29
    if Stats.MemoryTrackingEnabled then
        v29 = {
            ContactsCount = Stats.ContactsCount,
            DataReceiveKbps = Stats.DataReceiveKbps,
            DataSendKbps = Stats.DataSendKbps,
            FrameTime = Stats.FrameTime,
            HeartbeatTime = Stats.HeartbeatTime,
            InstanceCount = Stats.InstanceCount,
            MovingPrimitivesCount = Stats.MovingPrimitivesCount,
            PhysicsReceiveKbps = Stats.PhysicsReceiveKbps,
            PhysicsSendKbps = Stats.PhysicsSendKbps,
            PhysicsStepTime = Stats.PhysicsStepTime,
            PrimitivesCount = Stats.PrimitivesCount,
            RenderCPUFrameTime = Stats.RenderCPUFrameTime,
            RenderGPUFrameTime = Stats.RenderGPUFrameTime,
            SceneDrawcallCount = Stats.SceneDrawcallCount,
            SceneTriangleCount = Stats.SceneTriangleCount,
            ShadowsDrawcallCount = Stats.ShadowsDrawcallCount,
            ShadowsTriangleCount = Stats.ShadowsTriangleCount,
            UI2DDrawcallCount = Stats.UI2DDrawcallCount,
            UI2DTriangleCount = Stats.UI2DTriangleCount,
            UI3DDrawcallCount = Stats.UI3DDrawcallCount,
            UI3DTriangleCount = Stats.UI3DTriangleCount
        }
        local v30 = {}
        for v31, v32 in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
            local Name = v32.Name
            if Name == "PhysicsParts" then
                Name = "BaseParts"
            end
            v30[Name] = Stats:GetMemoryUsageMbForTag(v32)
        end
        v29.MemoryUsageMbForTag = v30
        v29.TotalMemoryUsageMb = Stats:GetTotalMemoryUsageMb()
    end
    local v33 = {}
    local v34 = {
        UWP = IsUWP(),
        Windows = IsWindows(),
        Time = v21,
        Clock = v22,
        ElapsedTime = v24,
        TimezoneOffset = os.date("%z"),
        Timezone = HttpService:UrlEncode((os.date("%Z")))
    }
    v34.TimezoneDST = os.date("*t").isdst == true
    v34.HeapSize = gcinfo()
    local v35 = v16(version())
    v34.RobloxVersion = UTF8Sub(v35, 1, 20)
    v33.System = v34
    v33.Game = { LoadingDuration = v20 }
    v33.LocalPlayer = {
        NetworkPing = nil,
        JoinData = v28
    }
    v33.TeleportService = { TeleportData = TeleportService:GetLocalPlayerTeleportData() }
    v33.Workspace = {
        ServerTimeNow = v23,
        RealPhysicsFPS = workspace:GetRealPhysicsFPS(),
        DistributedGameTime = workspace.DistributedGameTime,
        NumAwakeParts = workspace:GetNumAwakeParts(),
        PhysicsThrottling = workspace:GetPhysicsThrottling()
    }
    v33.Stats = v29
    v33.UserInputService = {
        DeviceForm = DeviceForm.Get(),
        Platform = DeviceForm.GetPlatform()
    }
    local v36 = {
        IsTenFootInterface = GuiService:IsTenFootInterface(),
        TouchControlsEnabled = GuiService.TouchControlsEnabled,
        GuiInsetTopLeft = v25,
        GuiInsetBotRight = v26,
        IsModalDialog = SafeGet(GuiService, "IsModalDialog", false),
        MenuIsOpen = GuiService.MenuIsOpen
    }
    local PreferredTransparency = GuiService.PreferredTransparency
    v36.PreferredTransparency = math.clamp(PreferredTransparency, 0, 1)
    v36.ReducedMotionEnabled = GuiService.ReducedMotionEnabled
    v36.CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled
    v36.GuiNavigationEnabled = GuiService.GuiNavigationEnabled
    v36.AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled
    v33.GuiService = v36
    v33.CurrentCamera = { ViewportSize = workspace.CurrentCamera.ViewportSize }
    local v37 = { RobloxLocaleId = LocalizationService.RobloxLocaleId:lower() }
    local v38 = LocalizationService.SystemLocaleId:lower()
    v37.SystemLocaleId = UTF8Sub(v38, 1, 1000)
    v33.LocalizationService = v37
    v33.VoiceChatService = {}
    v33.UserSettings = {
        GameSettings = {
            ControlMode = GameSettings.ControlMode,
            VignetteEnabled = GameSettings.VignetteEnabled,
            ComputerCameraMovementMode = GameSettings.ComputerCameraMovementMode,
            ComputerMovementMode = GameSettings.ComputerMovementMode,
            GamepadCameraSensitivity = GameSettings.GamepadCameraSensitivity,
            MouseSensitivity = GameSettings.MouseSensitivity,
            RotationType = GameSettings.RotationType,
            SavedQualityLevel = GameSettings.SavedQualityLevel,
            TouchCameraMovementMode = GameSettings.TouchCameraMovementMode,
            TouchMovementMode = GameSettings.TouchMovementMode,
            InFullScreen = GameSettings:InFullScreen(),
            InStudioMode = GameSettings:InStudioMode()
        }
    }
    local v39 = {}
    v17(v39, task.spawn(function() -- line 206 | captures: v33, VoiceChatServiceHelper, LocalPlayer
        v33.VoiceChatService.VoiceEnabled = VoiceChatServiceHelper.IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId, false)
    end))
    for v40, v41 in ipairs(v39) do
        ThreadJoin(v41)
    end
    return v33
end

local v42 = false

function Send() -- line 215 | captures: v42, ClientKit
    if v42 then
        return true
    end
    v42 = true
    local v43 = pcall(function() -- line 220 | captures: ClientKit
        ClientKit.AcceptRemote:FireServer((Build()))
    end)
    v42 = false
    return v43
end

local v44 = (-1/0)
GuiService.MenuOpened:Connect(function() -- line 227 | captures: v44
    local v45 = os.clock()
    if v45 - v44 > 15 then
        v44 = v45
        Send()
    end
end)
UserInputService.WindowFocusReleased:Connect(function() -- line 235 | captures: v44
    local v46 = os.clock()
    if v46 - v44 > 15 then
        v44 = v46
        Send()
    end
end)
task.spawn(function() -- line 243
    while true do
        Send()
        task.wait(150 + 300 * math.random())
    end
end)
