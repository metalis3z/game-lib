-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = os.clock();
local l_GuiService_0 = game:GetService("GuiService");
local l_HttpService_0 = game:GetService("HttpService");
local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Stats_0 = game:GetService("Stats");
local l_TeleportService_0 = game:GetService("TeleportService");
local v9 = require(l_ReplicatedStorage_0.UserGenerated.Roblox.VoiceChatServiceHelper);
local v10 = require(l_ReplicatedStorage_0.UserGenerated.Concurrency.ThreadJoin);
local v11 = require(l_ReplicatedStorage_0.UserGenerated.Analytics.ClientKit);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v13 = nil;
SafeGet = function(v14, v15, v16) --[[ Line: 41 ]] --[[ Name: SafeGet ]]
    local l_status_0, l_result_0 = pcall(function(_, _) --[[ Line: 46 ]]
        -- upvalues: v14 (copy), v15 (copy)
        return v14[v15];
    end, v14, v15);
    if l_status_0 then
        return l_result_0;
    else
        return v16;
    end;
end;
IsUWP = function() --[[ Line: 53 ]] --[[ Name: IsUWP ]]
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 54 ]]
        return tostring({
            1
        }):match("^table: 0x(00000000%x+)$") ~= nil;
    end);
    return l_status_1 and l_result_1;
end;
IsWindows = function() --[[ Line: 62 ]] --[[ Name: IsWindows ]]
    -- upvalues: l_GuiService_0 (copy)
    return SafeGet(l_GuiService_0, "IsWindows", false);
end;
GetDeviceForm = function() --[[ Line: 66 ]] --[[ Name: GetDeviceForm ]]
    -- upvalues: l_UserInputService_0 (copy), l_GuiService_0 (copy)
    if l_UserInputService_0.VREnabled then
        return Enum.DeviceForm.VR;
    elseif l_GuiService_0:IsTenFootInterface() then
        return Enum.DeviceForm.Console;
    elseif IsWindows() then
        return Enum.DeviceForm.Desktop;
    elseif l_UserInputService_0.GyroscopeEnabled or l_UserInputService_0.AccelerometerEnabled then
        return Enum.DeviceForm.Phone;
    elseif l_UserInputService_0.MouseEnabled then
        return Enum.DeviceForm.Desktop;
    elseif l_UserInputService_0.TouchEnabled then
        return Enum.DeviceForm.Phone;
    elseif l_UserInputService_0.GamepadEnabled then
        return Enum.DeviceForm.Console;
    else
        return nil;
    end;
end;
IsLoaded = function() --[[ Line: 103 ]] --[[ Name: IsLoaded ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not game:IsLoaded() then
        return false;
    else
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return false;
        elseif not l_Character_0.PrimaryPart or not l_Character_0:FindFirstChild("Humanoid") then
            return false;
        else
            return true;
        end;
    end;
end;
task.spawn(function() --[[ Line: 117 ]]
    -- upvalues: v13 (ref)
    while not IsLoaded() do
        task.wait();
    end;
    v13 = os.clock();
end);
GetStartTime = function() --[[ Line: 124 ]] --[[ Name: GetStartTime ]]
    -- upvalues: v0 (copy)
    local l___StartTime_0 = _G.__StartTime;
    if type(l___StartTime_0) == "number" then
        return l___StartTime_0;
    else
        return v0;
    end;
end;
GetLoadDurationAsync = function(v25) --[[ Line: 132 ]] --[[ Name: GetLoadDurationAsync ]]
    -- upvalues: v13 (ref)
    while true do
        local l_v13_0 = v13;
        if l_v13_0 then
            return (math.max(0, l_v13_0 - GetStartTime()));
        elseif not v25 then
            task.wait();
        else
            return nil;
        end;
    end;
end;
Build = function() --[[ Line: 146 ]] --[[ Name: Build ]]
    -- upvalues: l_Stats_0 (copy), l_GuiService_0 (copy), l_LocalPlayer_0 (copy), l_HttpService_0 (copy), l_TeleportService_0 (copy), l_LocalizationService_0 (copy), v9 (copy), v10 (copy)
    local v27 = GetLoadDurationAsync(false);
    local v28 = os.time();
    local v29 = os.clock();
    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
    local v31 = elapsedTime();
    local v32 = {};
    for _, v34 in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
        v32[v34.Name] = l_Stats_0:GetMemoryUsageMbForTag(v34);
    end;
    local l_GameSettings_0 = UserSettings().GameSettings;
    local l_l_GuiService_0_GuiInset_0, v37 = l_GuiService_0:GetGuiInset();
    local v38 = nil;
    pcall(function() --[[ Line: 172 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v38 (ref)
        local l_l_LocalPlayer_0_NetworkPing_0 = l_LocalPlayer_0:GetNetworkPing();
        if l_l_LocalPlayer_0_NetworkPing_0 > 0 then
            v38 = l_l_LocalPlayer_0_NetworkPing_0 * 1000;
        end;
    end);
    local l_l_LocalPlayer_0_JoinData_0 = l_LocalPlayer_0:GetJoinData();
    if l_l_LocalPlayer_0_JoinData_0.LaunchData ~= nil then
        pcall(function() --[[ Line: 180 ]]
            -- upvalues: l_l_LocalPlayer_0_JoinData_0 (copy), l_HttpService_0 (ref)
            l_l_LocalPlayer_0_JoinData_0.LaunchData = l_HttpService_0:JSONDecode(l_l_LocalPlayer_0_JoinData_0.LaunchData);
        end);
    end;
    local v41 = {
        System = {
            UWP = IsUWP(), 
            Windows = IsWindows(), 
            Time = v28, 
            Clock = v29, 
            ElapsedTime = v31, 
            TimezoneOffset = os.date("%z"), 
            Timezone = l_HttpService_0:UrlEncode((os.date("%Z"))), 
            TimezoneDST = os.date("*t").isdst == true, 
            HeapSize = gcinfo()
        }, 
        Game = {
            LoadingDuration = v27
        }, 
        LocalPlayer = {
            JoinData = l_l_LocalPlayer_0_JoinData_0, 
            NetworkPing = v38
        }, 
        TeleportService = {
            TeleportData = l_TeleportService_0:GetLocalPlayerTeleportData()
        }, 
        Workspace = {
            ServerTimeNow = l_workspace_ServerTimeNow_0, 
            RealPhysicsFPS = workspace:GetRealPhysicsFPS(), 
            DistributedGameTime = workspace.DistributedGameTime, 
            NumAwakeParts = workspace:GetNumAwakeParts(), 
            PhysicsThrottling = workspace:GetPhysicsThrottling()
        }, 
        Stats = {
            ContactsCount = l_Stats_0.ContactsCount, 
            DataReceiveKbps = l_Stats_0.DataReceiveKbps, 
            DataSendKbps = l_Stats_0.DataSendKbps, 
            FrameTime = l_Stats_0.FrameTime, 
            HeartbeatTime = l_Stats_0.HeartbeatTime, 
            InstanceCount = l_Stats_0.InstanceCount, 
            MovingPrimitivesCount = l_Stats_0.MovingPrimitivesCount, 
            PhysicsReceiveKbps = l_Stats_0.PhysicsReceiveKbps, 
            PhysicsSendKbps = l_Stats_0.PhysicsSendKbps, 
            PhysicsStepTime = l_Stats_0.PhysicsStepTime, 
            PrimitivesCount = l_Stats_0.PrimitivesCount, 
            RenderCPUFrameTime = l_Stats_0.RenderCPUFrameTime, 
            RenderGPUFrameTime = l_Stats_0.RenderGPUFrameTime, 
            SceneDrawcallCount = l_Stats_0.SceneDrawcallCount, 
            SceneTriangleCount = l_Stats_0.SceneTriangleCount, 
            ShadowsDrawcallCount = l_Stats_0.ShadowsDrawcallCount, 
            ShadowsTriangleCount = l_Stats_0.ShadowsTriangleCount, 
            UI2DDrawcallCount = l_Stats_0.UI2DDrawcallCount, 
            UI2DTriangleCount = l_Stats_0.UI2DTriangleCount, 
            UI3DDrawcallCount = l_Stats_0.UI3DDrawcallCount, 
            UI3DTriangleCount = l_Stats_0.UI3DTriangleCount, 
            MemoryUsageMbForTag = v32, 
            TotalMemoryUsageMb = l_Stats_0:GetTotalMemoryUsageMb()
        }, 
        UserInputService = {
            DeviceForm = GetDeviceForm()
        }, 
        GuiService = {
            IsTenFootInterface = l_GuiService_0:IsTenFootInterface(), 
            TouchControlsEnabled = l_GuiService_0.TouchControlsEnabled, 
            GuiInsetTopLeft = l_l_GuiService_0_GuiInset_0, 
            GuiInsetBotRight = v37, 
            IsModalDialog = SafeGet(l_GuiService_0, "IsModalDialog", false), 
            MenuIsOpen = l_GuiService_0.MenuIsOpen, 
            PreferredTransparency = l_GuiService_0.PreferredTransparency, 
            ReducedMotionEnabled = l_GuiService_0.ReducedMotionEnabled, 
            CoreGuiNavigationEnabled = l_GuiService_0.CoreGuiNavigationEnabled, 
            GuiNavigationEnabled = l_GuiService_0.GuiNavigationEnabled, 
            AutoSelectGuiEnabled = l_GuiService_0.AutoSelectGuiEnabled
        }, 
        CurrentCamera = {
            ViewportSize = workspace.CurrentCamera.ViewportSize
        }, 
        LocalizationService = {
            RobloxLocaleId = l_LocalizationService_0.RobloxLocaleId:lower(), 
            SystemLocaleId = l_LocalizationService_0.SystemLocaleId:lower()
        }, 
        VoiceChatService = {}, 
        UserSettings = {
            GameSettings = {
                ControlMode = l_GameSettings_0.ControlMode, 
                VignetteEnabled = l_GameSettings_0.VignetteEnabled, 
                ComputerCameraMovementMode = l_GameSettings_0.ComputerCameraMovementMode, 
                ComputerMovementMode = l_GameSettings_0.ComputerMovementMode, 
                GamepadCameraSensitivity = l_GameSettings_0.GamepadCameraSensitivity, 
                MouseSensitivity = l_GameSettings_0.MouseSensitivity, 
                RotationType = l_GameSettings_0.RotationType, 
                SavedQualityLevel = l_GameSettings_0.SavedQualityLevel, 
                TouchCameraMovementMode = l_GameSettings_0.TouchCameraMovementMode, 
                TouchMovementMode = l_GameSettings_0.TouchMovementMode, 
                InFullScreen = l_GameSettings_0:InFullScreen(), 
                InStudioMode = l_GameSettings_0:InStudioMode()
            }
        }
    };
    local v42 = {};
    table.insert(v42, task.spawn(function() --[[ Line: 288 ]]
        -- upvalues: v41 (copy), v9 (ref), l_LocalPlayer_0 (ref)
        v41.VoiceChatService.VoiceEnabled = v9.IsVoiceEnabledForUserIdAsync(l_LocalPlayer_0.UserId, false);
    end));
    for _, v44 in ipairs(v42) do
        v10(v44);
    end;
    return v41;
end;
local v45 = false;
Send = function() --[[ Line: 307 ]] --[[ Name: Send ]]
    -- upvalues: v45 (ref), v11 (copy)
    if v45 then
        return true;
    else
        v45 = true;
        local v47 = pcall(function() --[[ Line: 312 ]]
            -- upvalues: v11 (ref)
            local v46 = Build();
            v11.AcceptRemote:FireServer(v46);
        end);
        v45 = false;
        return v47;
    end;
end;
local v48 = -1e999;
l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 321 ]]
    -- upvalues: v48 (ref)
    local v49 = os.clock();
    if v49 - v48 > 15 then
        v48 = v49;
        Send();
    end;
end);
task.spawn(function() --[[ Line: 329 ]]
    while true do
        Send();
        task.wait(30 + 60 * math.random());
    end;
end);