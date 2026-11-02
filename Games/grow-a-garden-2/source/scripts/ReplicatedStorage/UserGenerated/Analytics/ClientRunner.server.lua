--credit to prince games studio
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
local LocalPlayer = Players.LocalPlayer
local v2 = nil

function SafeGet(p1, p2, p3) --[[ SafeGet | Line: 43 ]]
	local ok, result = pcall(function(p12, p22) --[[ Line: 48 | Upvalues: p1 (copy), p2 (copy) ]]
		return p1[p2]
	end, p1, p2)

	if ok then
		return result
	end

	return p3
end
function IsUWP() --[[ IsUWP | Line: 55 ]]
	local ok, result = pcall(function() --[[ Line: 56 ]]
		return tostring({ 1 }):match("^table: 0x(00000000%x+)$") ~= nil
	end)

	return ok and result
end
function IsWindows() --[[ IsWindows | Line: 64 | Upvalues: GuiService (copy) ]]
	return SafeGet(GuiService, "IsWindows", false)
end
function GetDeviceForm() --[[ GetDeviceForm | Line: 68 | Upvalues: UserInputService (copy), GuiService (copy) ]]
	if UserInputService.VREnabled then
		return Enum.DeviceForm.VR
	end

	if GuiService:IsTenFootInterface() then
		return Enum.DeviceForm.Console
	end

	if IsWindows() then
		return Enum.DeviceForm.Desktop
	end

	if UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled then
		return Enum.DeviceForm.Phone
	end

	if UserInputService.MouseEnabled then
		return Enum.DeviceForm.Desktop
	end

	if UserInputService.TouchEnabled then
		return Enum.DeviceForm.Phone
	end

	if UserInputService.GamepadEnabled then
		return Enum.DeviceForm.Console
	end

	return nil
end
function IsLoaded() --[[ IsLoaded | Line: 105 | Upvalues: LocalPlayer (copy) ]]
	if not game:IsLoaded() then
		return false
	end

	local Character = LocalPlayer.Character

	if Character then
		return Character.PrimaryPart and Character:FindFirstChild("Humanoid") and true or false
	end

	return false
end
task.spawn(function() --[[ Line: 119 | Upvalues: v2 (ref) ]]
	while not IsLoaded() do
		task.wait()
	end

	v2 = os.clock()
end)
function GetStartTime() --[[ GetStartTime | Line: 126 | Upvalues: v1 (copy) ]]
	local __StartTime = _G.__StartTime

	if type(__StartTime) == "number" then
		return __StartTime
	end

	return v1
end
function GetLoadDurationAsync(p1) --[[ GetLoadDurationAsync | Line: 134 | Upvalues: v2 (ref) ]]
	local v1

	while true do
		v1 = v2

		if v2 then
			break
		end

		if p1 then
			return nil
		end

		task.wait()
	end

	return math.max(0, v1 - GetStartTime())
end
function Build() --[[ Build | Line: 148 | Upvalues: GuiService (copy), LocalPlayer (copy), HttpService (copy), Stats (copy), TeleportService (copy), LocalizationService (copy), UTF8Sub (copy), VoiceChatServiceHelper (copy), ThreadJoin (copy) ]]
	local v1 = GetLoadDurationAsync(false)
	local v2 = os.time()
	local v3 = os.clock()
	local v4 = workspace:GetServerTimeNow()
	local v5 = elapsedTime()
	local GameSettings = UserSettings().GameSettings
	local v6, v7 = GuiService:GetGuiInset()
	local v8 = nil

	pcall(function() --[[ Line: 168 | Upvalues: LocalPlayer (ref), v8 (ref) ]]
		local v1 = LocalPlayer:GetNetworkPing()

		if not (v1 > 0) then
			return
		end

		v8 = v1 * 1000
	end)

	local v9 = LocalPlayer:GetJoinData()

	if v9.LaunchData ~= nil then
		pcall(function() --[[ Line: 176 | Upvalues: v9 (copy), HttpService (ref) ]]
			v9.LaunchData = HttpService:JSONDecode(v9.LaunchData)
		end)
	end

	local v10 = if Stats.MemoryTrackingEnabled then {
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
	UI3DTriangleCount = Stats.UI3DTriangleCount,
	MemoryUsageMbForTag = (function() --[[ Line: 207 | Upvalues: Stats (ref) ]]
		local t = {}

		for i, v in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
			local v1 = v.Name

			if v1 == "PhysicsParts" then
				v1 = "BaseParts"
			end

			t[v1] = Stats:GetMemoryUsageMbForTag(v)
		end

		return t
	end)(),
	TotalMemoryUsageMb = Stats:GetTotalMemoryUsageMb()
} else nil
	local t = {}
	local t2 = {
		UWP = IsUWP(),
		Windows = IsWindows(),
		Time = v2,
		Clock = v3,
		ElapsedTime = v5,
		TimezoneOffset = os.date("%z"),
		Timezone = HttpService:UrlEncode((os.date("%Z")))
	}

	t2.TimezoneDST = if os.date("*t").isdst == true then true else false
	t2.HeapSize = gcinfo()
	t.System = t2
	t.Game = {
		LoadingDuration = v1
	}
	t.LocalPlayer = {
		JoinData = v9,
		NetworkPing = v8
	}
	t.TeleportService = {
		TeleportData = TeleportService:GetLocalPlayerTeleportData()
	}
	t.Workspace = {
		ServerTimeNow = v4,
		RealPhysicsFPS = workspace:GetRealPhysicsFPS(),
		DistributedGameTime = workspace.DistributedGameTime,
		NumAwakeParts = workspace:GetNumAwakeParts(),
		PhysicsThrottling = workspace:GetPhysicsThrottling()
	}
	t.Stats = v10
	t.UserInputService = {
		DeviceForm = GetDeviceForm()
	}

	local t3 = {
		IsTenFootInterface = GuiService:IsTenFootInterface(),
		TouchControlsEnabled = GuiService.TouchControlsEnabled,
		GuiInsetTopLeft = v6,
		GuiInsetBotRight = v7,
		IsModalDialog = SafeGet(GuiService, "IsModalDialog", false),
		MenuIsOpen = GuiService.MenuIsOpen
	}

	t3.PreferredTransparency = math.clamp(GuiService.PreferredTransparency, 0, 1)
	t3.ReducedMotionEnabled = GuiService.ReducedMotionEnabled
	t3.CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled
	t3.GuiNavigationEnabled = GuiService.GuiNavigationEnabled
	t3.AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled
	t.GuiService = t3
	t.CurrentCamera = {
		ViewportSize = workspace.CurrentCamera.ViewportSize
	}
	t.LocalizationService = {
		RobloxLocaleId = LocalizationService.RobloxLocaleId:lower(),
		SystemLocaleId = UTF8Sub(LocalizationService.SystemLocaleId:lower(), 1, 1000)
	}
	t.VoiceChatService = {}
	t.UserSettings = {
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

	local list = {}

	local function f13() --[[ Line: 301 | Upvalues: t (copy), VoiceChatServiceHelper (ref), LocalPlayer (ref) ]]
		t.VoiceChatService.VoiceEnabled = VoiceChatServiceHelper.IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId, false)
	end

	table.insert(list, task.spawn(f13))

	for i, v in ipairs(list) do
		ThreadJoin(v)
	end

	return t
end

local v3 = false

function Send() --[[ Send | Line: 319 | Upvalues: v3 (ref), ClientKit (copy) ]]
	if v3 then
		return true
	end

	v3 = true

	local ok = pcall(function() --[[ Line: 324 | Upvalues: ClientKit (ref) ]]
		ClientKit.AcceptRemote:FireServer((Build()))
	end)

	v3 = false

	return ok
end

local v4 = (-1 / 0)

GuiService.MenuOpened:Connect(function() --[[ Line: 333 | Upvalues: v4 (ref) ]]
	local v1 = os.clock()

	if not (v1 - v4 > 15) then
		return
	end

	v4 = v1
	Send()
end)
UserInputService.WindowFocusReleased:Connect(function() --[[ Line: 341 | Upvalues: v4 (ref) ]]
	local v1 = os.clock()

	if not (v1 - v4 > 15) then
		return
	end

	v4 = v1
	Send()
end)
task.spawn(function() --[[ Line: 349 ]]
	while true do
		Send()
		task.wait(150 + 300 * math.random())
	end
end)