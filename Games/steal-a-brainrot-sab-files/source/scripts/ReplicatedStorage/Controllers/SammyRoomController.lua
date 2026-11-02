-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local LightingController = require(Controllers.LightingController)
local CycleController = require(Controllers.CycleController)
local InterfaceController = require(Controllers.InterfaceController)
local BackpackController = require(Controllers.BackpackController)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Observers = require(Packages.Observers)
local Synchronizer = require(Packages.Synchronizer)
local Moonlite = require(Packages.Moonlite)
local Serialization = require(Packages.Serialization)
local Squash = require(Packages.Squash)
local Trove = require(Packages.Trove)
local Timer = require(Packages.Timer)
local FFlags = require(Packages.FFlags)
local Net = require(Packages.Net)
local CreateTween = require(Packages.CreateTween)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local v1 = Net:RemoteEvent("SammyRoomService/CutsceneSeen")
local StartCutsceneEvent = Net:RemoteEvent("SammyRoomService/StartCutscene")
local Q = Enum.KeyCode.Q
local t = {
	{
		Tag = "SammyRoomCameraAnchor",
		Path = { "Camera" }
	},
	{
		Tag = "SammyRoomRig",
		Path = { "RoomSammyRig" }
	},
	{
		Tag = "SammyRoomProgressFill",
		Path = { "Interior", "Monitors", "Bar", "SurfaceGui", "Bar", "Fill" }
	},
	{
		Tag = "SammyRoomProgressLabel",
		Path = { "Interior", "Monitors", "Bar", "SurfaceGui", "Percentage" }
	}
}
local t2 = { 1800, 2700, 3600 }
local v2 = CFrame.new(10000, 0, 10000)
local t3 = {
	{ 1779562800, 1779566400 },
	{ 1779832800, 1779836400 },
	{ 1780167600, 1780171200 },
	{ 1780437600, 1780441200 },
	{ 1780772400, 1780776000 },
	{ 1781042400, 1781046000 },
	{ 1781377200, 1781380800 },
	{ 1781647200, 1781650800 }
}
local t4 = {
	Name = "PC",
	Pool = "Daytime",
	Intro = "WalkToChair",
	Loops = { "Sitting", "Typing" }
}
local t5 = {
	Name = "Laptop",
	Pool = "Daytime",
	Loops = { "UsingLaptop" }
}
local t6 = {
	Name = "Sleep",
	Pool = "Sleep",
	Outro = "WakeUp",
	Loops = { "Sleeping" }
}
local t7 = {
	Name = "AdminAbuse",
	Pool = "AdminAbuse",
	Loops = { "Typing" }
}
local t8 = { t4, t5 }
local t9 = {
	WalkToChair = {
		Sound = "WalkToChair",
		MaxDuration = 3
	},
	Walk = {
		Sound = "WalkToChair"
	},
	Sleeping = {
		Sound = "Sleeping",
		Looped = true,
		StartDelay = 3
	},
	Typing = {
		Sound = "TypingLoop",
		Looped = true
	},
	UsingLaptop = {
		Sound = "UsingLaptopLoop",
		Looped = true
	},
	EatTaco = {
		Sound = "EatTaco",
		StartDelay = 0.5
	}
}
local t10 = { "Sounds", "Events", "SammyRoom" }
local t11 = {
	WalkToChair = {
		PropPath = { "Interior", "Chair" },
		Animation = script.InteriorChairAnimation
	},
	EatTaco = {
		PropPath = { "Interior", "Taco" },
		Animation = script.InteriorTacoAnimation
	}
}
local t12 = {
	Sitting = Enum.AnimationPriority.Idle,
	Sleeping = Enum.AnimationPriority.Idle
}
local LocalPlayer = Players.LocalPlayer
local t13 = {}
local v3 = false
local v4 = nil
local v5 = workspace:GetServerTimeNow()
local v6 = v5
local v7 = 1
local function getNow()
	return v6 + (workspace:GetServerTimeNow() - v5) * v7
end
local function setSimNow(p1)
	v6 = p1
	v5 = workspace:GetServerTimeNow()
end
local function jumpSimBy(p1)
	v6 = v6 + (workspace:GetServerTimeNow() - v5) * v7 + p1
	v5 = workspace:GetServerTimeNow()
end
local function setTimeScale(p1)
	v6 = v6 + (workspace:GetServerTimeNow() - v5) * v7
	v5 = workspace:GetServerTimeNow()
	v7 = math.max(1, p1)
end
local v8 = nil
local function computeEtOffsetSeconds(p1)
	local v1 = os.date("!*t", p1)
	local month = v1.month
	if month < 3 or month > 11 then
		return -18000
	end
	if month > 3 and month < 11 then
		return -14400
	end
	local v2 = p1 - (v1.day - 1) * 86400 - v1.hour * 3600 - v1.min * 60 - v1.sec
	local t = {}
	for i = 0, 31 do
		local v3 = os.date("!*t", v2 + i * 86400)
		if v3.month ~= month then
			break
		end
		if v3.wday == 1 then
			table.insert(t, v3.day)
		end
	end
	if month == 3 then
		local v4 = t[2]
		if v4 < v1.day then
			return -14400
		end
		if v1.day < v4 then
			return -18000
		end
		if v1.hour >= 7 then
			return -14400
		else
			return -18000
		end
	else
		local v5 = t[1]
		if v1.day < v5 then
			return -14400
		end
		if v5 < v1.day then
			return -18000
		end
		if v1.hour >= 6 then
			return -18000
		else
			return -14400
		end
	end
end
local function getEtOffsetSeconds(p1)
	local v1 = p1 // 3600
	if v8 and v8.hourBucket == v1 then
		return v8.offset
	end
	local v2 = computeEtOffsetSeconds(p1)
	v8 = {
		hourBucket = v1,
		offset = v2
	}
	return v2
end
local function getEstClockTime()
	local v1 = (v6 + (workspace:GetServerTimeNow() - v5) * v7) // 1
	local v2 = v1 // 3600
	local v3
	if v8 and v8.hourBucket == v2 then
		v3 = v8.offset
	else
		local v4 = computeEtOffsetSeconds(v1)
		v8 = {
			hourBucket = v2,
			offset = v4
		}
		v3 = v4
	end
	return (v1 + v3) % 86400 / 3600
end
local function getEstSecondsInDay(p1)
	local v1 = p1 // 3600
	local v2
	if v8 and v8.hourBucket == v1 then
		v2 = v8.offset
	else
		local v3 = computeEtOffsetSeconds(p1)
		v8 = {
			hourBucket = v1,
			offset = v3
		}
		v2 = v3
	end
	return (p1 + v2) % 86400
end
local function getEstDayIndex(p1)
	local v1 = p1 // 3600
	local v2
	if v8 and v8.hourBucket == v1 then
		v2 = v8.offset
	else
		local v3 = computeEtOffsetSeconds(p1)
		v8 = {
			hourBucket = v1,
			offset = v3
		}
		v2 = v3
	end
	return math.floor((p1 + v2) / 86400)
end
local function getAdminAbuseStart(p1)
	for v1, v2 in t3 do
		if v2[1] <= p1 and p1 < v2[2] then
			return v2[1]
		end
	end
	return nil
end
local v9 = nil
local function getDayShuffle(p1)
	if v9 and v9.dayIndex == p1 then
		return v9.order
	end
	local v1 = Random.new(p1)
	local v2 = table.clone(t8)
	for i = #v2, 2, -1 do
		local v3 = v1:NextInteger(1, i)
		local v5 = v2[i]
		v2[i] = v2[v3]
		v2[v3] = v5
	end
	v9 = {
		dayIndex = p1,
		order = v2
	}
	return v2
end
local v10 = nil
local function getSlotSequence(p1)
	if v10 and v10.dayIndex == p1 then
		return v10.sequence
	end
	local v1 = table.create(64)
	local sum = 0
	for i = 0, 63 do
		local v2 = t2[Random.new(p1 * 1024 + i):NextInteger(1, #t2)]
		if not v2 or v2 <= 0 then
			v2 = 1800
		end
		sum = sum + v2
		v1[i + 1] = sum
	end
	local t = {
		cumulativeEnds = v1
	}
	v10 = {
		dayIndex = p1,
		sequence = t
	}
	return t
end
local function resolveSlot(p1)
	local v1
	do
		local __inline_returned = false
		for v2, v3 in t3 do
			if v3[1] <= p1 and p1 < v3[2] then
				v1 = v3[1]
				__inline_returned = true
				break
			end
		end
		if not __inline_returned then
			v1 = nil
		end
	end
	if v1 then
		return {
			Length = 3600,
			Action = t7,
			Start = v1
		}
	end
	local v4 = p1 // 3600
	local v5
	if v8 and v8.hourBucket == v4 then
		v5 = v8.offset
	else
		local v6 = computeEtOffsetSeconds(p1)
		v8 = {
			hourBucket = v4,
			offset = v6
		}
		v5 = v6
	end
	local v7 = (p1 + v5) % 86400
	if v7 < 28800 then
		return {
			Length = 28800,
			Action = t6,
			Start = p1 - v7
		}
	end
	local v82 = v7 - 28800
	local v9 = p1 // 3600
	local v10
	if v8 and v8.hourBucket == v9 then
		v10 = v8.offset
	else
		local v11 = computeEtOffsetSeconds(p1)
		v8 = {
			hourBucket = v9,
			offset = v11
		}
		v10 = v11
	end
	local v12 = math.floor((p1 + v10) / 86400)
	local v13 = getDayShuffle(v12)
	local cumulativeEnds = getSlotSequence(v12).cumulativeEnds
	for i = 0, 63 do
		local v14 = cumulativeEnds[i + 1]
		if v82 < v14 then
			local v15 = if i > 0 then cumulativeEnds[i] else 0
			local v17 = i % #v13 + 1
			local v18 = v13[v17]
			if i > 0 and (#v13 > 1 and v13[(i - 1) % #v13 + 1] == v18) then
				v18 = v13[v17 % #v13 + 1]
			end
			return {
				Action = v18,
				Start = p1 - (v82 - v15),
				Length = v14 - v15
			}
		end
	end
	return {
		Length = 1800,
		Action = v13[1],
		Start = p1 - (v82 - (cumulativeEnds[64] or 0))
	}
end
local function resolvePreviousSlot(p1)
	return resolveSlot(p1.Start - 1)
end
local function getProgress(p1)
	return math.clamp((p1 - 1779562800) / 1814400, 0, 1)
end
local v11 = false
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local function clearPreloadCache()
	if v12 then
		pcall(function()
			v12:Stop()
		end)
		pcall(function()
			v12:Destroy()
		end)
		v12 = nil
	end
	if v13 then
		v13:Destroy()
		v13 = nil
	end
	if v14 then
		v14:Destroy()
		v14 = nil
	end
	if not v15 then
		v11 = false
		return
	end
	v15:Destroy()
	v15 = nil
	v11 = false
end
local function preloadCutscene()
	if v11 then
		return v12 ~= nil
	else
		v11 = true
		local v2 = Synchronizer:Get(LocalPlayer)
		local v3, v4 = pcall(require, script.Cutscene)
		if not v3 or (type(v4) ~= "string" or v4 == "") then
			warn("[SammyRoomController] cutscene save is empty \226\128\148 paste the Moonlite export into script.Cutscene")
			return false
		end
		local v5, v6 = pcall(function()
			return Serialization.des(Squash.frombuffer(HttpService:JSONDecode(v4)))
		end)
		if v5 then
			local v7 = script.Cutscene.Assets:Clone()
			v7.Parent = script
			local v8 = script.Sound:Clone()
			v8.Parent = script
			local SammyRoomCutsceneProxyCamera = Instance.new("Camera")
			SammyRoomCutsceneProxyCamera.Name = "SammyRoomCutsceneProxyCamera"
			SammyRoomCutsceneProxyCamera.Parent = script
			local v9 = Moonlite.CreatePlayer(v6, v7)
			v9:ReplaceElementByPath("game", SammyRoomCutsceneProxyCamera)
			v9.Looped = false
			v9:Compile()
			v12 = v9
			v13 = v7
			v14 = v8
			v15 = SammyRoomCutsceneProxyCamera
			return true
		else
			warn((("[SammyRoomController] cutscene save failed to decode: %*"):format(v6)))
			return false
		end
	end
end
local function getCutsceneStartTime()
	local v1 = 0
	if type(v1) == "number" and not (v1 <= 0) then
		return v1
	else
		return nil
	end
end
local function startCutscene()
	if v3 then
		return
	end
	v3 = true
	local v32 = 0
	local v4 = Synchronizer:Wait(LocalPlayer)
	if not v4 then
		v3 = false
		clearPreloadCache()
		return
	end
	if not (preloadCutscene() and v12) then
		v3 = false
		clearPreloadCache()
		return
	end
	local v5 = v12
	local v6 = v13
	local v7 = v14
	local v8 = v15
	local v9 = Trove.new()
	v9:Add(function()
		v3 = false
	end)
	v9:Add(Observers.observeTag("HideInSummerCutscene", function(p1)
		local v1 = p1.Parent
		p1.Parent = script
		return function()
			pcall(function()
				p1.Parent = v1
			end)
		end
	end, { workspace, script }))
	v6.Parent = workspace
	v9:Add(v6)
	v7.Parent = ReplicatedStorage
	v9:Add(v7)
	local CurrentCamera = workspace.CurrentCamera
	v9:Add(v8)
	v9:Add(v8:GetPropertyChangedSignal("CFrame"):Connect(function()
		local v1 = v2 * v8.CFrame
		CurrentCamera.CFrame = v1
		CurrentCamera.Focus = v1
		CurrentCamera.FieldOfView = v8.FieldOfView
	end))
	local v10 = false
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	v9:Add(CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function()
		if v10 then
			return
		end
		if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			return
		end
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
	end))
	v9:Add(function()
		v10 = true
		CurrentCamera.CameraType = Enum.CameraType.Custom
		CurrentCamera.FieldOfView = 70
		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		if not v1 then
			return
		end
		CurrentCamera.CameraSubject = v1
	end)
	ProximityPromptService.Enabled = false
	v9:Add(function()
		ProximityPromptService.Enabled = true
	end)
	v9:Add(Observers.observeChildren(LocalPlayer:WaitForChild("PlayerGui"), function(p1)
		if not p1:IsA("LayerCollector") then
			return nil
		end
		if p1:GetAttribute("ShowInCutscene") then
			return nil
		else
			local Enabled = p1.Enabled
			p1.Enabled = false
			return function()
				if not p1.Parent or p1.Enabled == Enabled then
					return
				end
				p1.Enabled = Enabled
			end
		end
	end))
	task.spawn(pcall, function()
		StarterGui:SetCore("TopbarEnabled", false)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	end)
	v9:Add(function()
		task.spawn(pcall, function()
			StarterGui:SetCore("TopbarEnabled", true)
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		end)
	end)
	v9:Add(Observers.observeCharacters(function(p1, p2)
		local v1 = p2.Parent
		p2.Parent = ReplicatedStorage
		return function()
			if p2.Parent ~= ReplicatedStorage then
				return
			end
			p2.Parent = v1 or workspace
		end
	end))
	LightingController:SetSuspended(true)
	v9:Add(function()
		LightingController:SetSuspended(false)
	end)
	local t = {}
	for v11, v122 in SoundService:GetChildren() do
		if v122:IsA("SoundGroup") then
			t[v122] = v122.Volume
			v122.Volume = 0
		end
	end
	v9:Add(function()
		for v1, v2 in t do
			if v1.Parent then
				v1.Volume = v2
			end
		end
	end)
	local ClockTime = Lighting.ClockTime
	local v132 = false
	local function setClockTime(p1)
		if not v132 then
			v132 = true
			Lighting.ClockTime = p1
			v132 = false
		end
	end
	if not v132 then
		v132 = true
		Lighting.ClockTime = 14
		v132 = false
	end
	v9:Add(RunService.PreRender:Connect(function()
		if not v132 then
			v132 = true
			Lighting.ClockTime = 14
			v132 = false
		end
	end))
	v9:Add(function()
		v132 = true
		Lighting.ClockTime = ClockTime
		v132 = false
		CycleController:Update()
	end)
	v9:Add(function()
		clearPreloadCache()
	end)
	local SAMMY_ROOM_CUTSCENE_Fade = Instance.new("ColorCorrectionEffect")
	SAMMY_ROOM_CUTSCENE_Fade.Name = "SAMMY_ROOM_CUTSCENE_Fade"
	SAMMY_ROOM_CUTSCENE_Fade.Brightness = 0
	SAMMY_ROOM_CUTSCENE_Fade.Saturation = 0
	SAMMY_ROOM_CUTSCENE_Fade.Contrast = 0
	SAMMY_ROOM_CUTSCENE_Fade.TintColor = Color3.new(255/255, 255/255, 255/255)
	SAMMY_ROOM_CUTSCENE_Fade.Enabled = true
	SAMMY_ROOM_CUTSCENE_Fade.Parent = Lighting
	v9:Add(SAMMY_ROOM_CUTSCENE_Fade)
	local function tweenBrightness(p1, p2, p3)
		local v1 = TweenService:Create(p1, TweenInfo.new(p2), {
			Brightness = p3
		})
		v9:Add(v1)
		v1:Play()
		return v1
	end
	v5.TimePosition = math.clamp(math.max(v32, 0), 0, 34.233333333333334)
	if v32 < 0.5 then
		tweenBrightness(SAMMY_ROOM_CUTSCENE_Fade, 0.5, -1)
		task.wait(0.5)
		SAMMY_ROOM_CUTSCENE_Fade.Brightness = -1
	end
	v9:Add(task.spawn(function()
		while not v7.IsLoaded do
			task.wait()
		end
		v7.TimePosition = v5.TimePosition
		v7:Play()
		v7.TimePosition = v5.TimePosition
	end))
	v1:FireServer()
	v5:Play()
	if v32 < 0.5 then
		tweenBrightness(SAMMY_ROOM_CUTSCENE_Fade, 0.5, 0)
	end
	local v152 = 33.733333333333334 - v32
	if v152 < 0 then
		v152 = 0
	end
	v9:Add(task.delay(v152, function()
		tweenBrightness(SAMMY_ROOM_CUTSCENE_Fade, 0.5, -1)
		task.wait(0.5)
		SAMMY_ROOM_CUTSCENE_Fade.Brightness = -1
		local SAMMY_ROOM_CUTSCENE_PostFade = Instance.new("ColorCorrectionEffect")
		SAMMY_ROOM_CUTSCENE_PostFade.Name = "SAMMY_ROOM_CUTSCENE_PostFade"
		SAMMY_ROOM_CUTSCENE_PostFade.Brightness = -1
		SAMMY_ROOM_CUTSCENE_PostFade.Saturation = 0
		SAMMY_ROOM_CUTSCENE_PostFade.Contrast = 0
		SAMMY_ROOM_CUTSCENE_PostFade.TintColor = Color3.new(255/255, 255/255, 255/255)
		SAMMY_ROOM_CUTSCENE_PostFade.Enabled = true
		SAMMY_ROOM_CUTSCENE_PostFade.Parent = Lighting
		v9:Destroy()
		local v1 = TweenService:Create(SAMMY_ROOM_CUTSCENE_PostFade, TweenInfo.new(0.5), {
			Brightness = 0
		})
		v1:Play()
		v1.Completed:Once(function()
			SAMMY_ROOM_CUTSCENE_PostFade:Destroy()
		end)
	end))
end
local v16 = nil
local function getEstClockText()
	local v1 = v6 + (workspace:GetServerTimeNow() - v5) * v7
	local v2 = v1 // 3600
	local v3
	if v8 and v8.hourBucket == v2 then
		v3 = v8.offset
	else
		local v4 = computeEtOffsetSeconds(v1)
		v8 = {
			hourBucket = v2,
			offset = v4
		}
		v3 = v4
	end
	local v52 = (v1 + v3) // 1 % 86400
	local v62 = v52 // 3600
	return string.format("%02d:%02d %s EST", (v62 + 11) % 12 + 1, v52 % 3600 // 60, if v62 < 12 then "AM" else "PM")
end
local function bindCameraUi(p1)
	local SecurityCam = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SecurityCam")
	if not SecurityCam then
		warn("[SammyRoomController] PlayerGui.SecurityCam missing; UI overlay disabled")
		return
	end
	SecurityCam.Enabled = true
	p1:Add(function()
		SecurityCam.Enabled = false
	end)
	local v1 = InterfaceController:Get("Hud")
	if v1 and v1:IsOpened() then
		v1:Close()
		p1:Add(function()
			if not v1 then
				return
			end
			v1:Open()
		end)
	end
	ReplicatedStorage:SetAttribute("SammyRoomCamera", true)
	p1:Add(function()
		ReplicatedStorage:SetAttribute("SammyRoomCamera", nil)
	end)
	BackpackController:SetEnabled("SammyRoomCamera", false)
	p1:Add(function()
		BackpackController:SetEnabled("SammyRoomCamera", true)
	end)
	local Close = SecurityCam:FindFirstChild("Close")
	if Close and Close:IsA("GuiButton") then
		p1:Add(Close.Activated:Connect(function()
			v16()
		end))
	end
	local TopLeftCorner = SecurityCam:FindFirstChild("TopLeftCorner")
	local v2 = if TopLeftCorner then TopLeftCorner:FindFirstChild("Record") else TopLeftCorner
	local v3 = v2 and v2:FindFirstChild("Dot")
	if v3 and v3:IsA("Frame") then
		local BackgroundTransparency = v3.BackgroundTransparency
		local UIStroke = v3:FindFirstChildOfClass("UIStroke")
		local v4 = UIStroke and UIStroke.Transparency
		local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local function tweenTo(p1)
			CreateTween(v3, v5, {
				BackgroundTransparency = p1
			})
			if not UIStroke then
				return
			end
			CreateTween(UIStroke, v5, {
				Transparency = p1
			})
		end
		local v6 = task.spawn(function()
			while true do
				task.wait(1.4)
				tweenTo(1)
				task.wait(0.4)
				tweenTo(0)
				task.wait(0.2)
			end
		end)
		p1:Add(function()
			task.cancel(v6)
			v3.BackgroundTransparency = BackgroundTransparency
			if not (UIStroke and v4) then
				return
			end
			UIStroke.Transparency = v4
		end)
	end
	local BottomLeftCorner = SecurityCam:FindFirstChild("BottomLeftCorner")
	local v7 = BottomLeftCorner and BottomLeftCorner:FindFirstChild("Time")
	if v7 and v7:IsA("TextLabel") then
		local Text = v7.Text
		local function updateClock()
			v7.Text = getEstClockText()
		end
		v7.Text = getEstClockText()
		p1:Add(Timer.Simple(1, updateClock))
		p1:Add(function()
			v7.Text = Text
		end)
	end
	local Lines = SecurityCam:FindFirstChild("Lines")
	if Lines and Lines:IsA("ImageLabel") then
		local Position = Lines.Position
		local v10 = Position + UDim2.new(0, 0, Lines.TileSize.Y.Scale * Lines.Size.Y.Scale, Lines.TileSize.Y.Scale * Lines.Size.Y.Offset + Lines.TileSize.Y.Offset)
		local v11 = TweenService:Create(Lines, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {
			Position = v10
		})
		v11:Play()
		p1:Add(function()
			v11:Cancel()
			v11:Destroy()
			Lines.Position = Position
		end)
	end
	local Noise = SecurityCam:FindFirstChild("Noise")
	if not (Noise and Noise:IsA("ImageLabel")) then
		return
	end
	local Position = Noise.Position
	local ImageTransparency = Noise.ImageTransparency
	local v12 = Random.new()
	local v13 = task.spawn(function()
		while true do
			Noise.Position = Position + UDim2.fromScale(v12:NextNumber(-0.008, 0.008), v12:NextNumber(-0.008, 0.008))
			Noise.ImageTransparency = v12:NextNumber(0.86, 0.94)
			Noise.Rotation = v12:NextNumber(-1, 1)
			task.wait(v12:NextNumber(0.06, 0.13))
		end
	end)
	p1:Add(function()
		task.cancel(v13)
		Noise.Position = Position
		Noise.ImageTransparency = ImageTransparency
		Noise.Rotation = 0
	end)
end
local v17 = false
local function resolveMapPath(p1, p2)
	local v1 = p1
	for v2, v3 in p2 do
		if not v1 then
			return nil
		end
		v1 = v1:FindFirstChild(v3)
	end
	return v1
end
local function trySpawnMap()
	if v17 then
		return
	end
	if not workspace:FindFirstChild("SammyRoom") then
		local Models = ReplicatedStorage:FindFirstChild("Models")
		local v1 = if Models then Models:FindFirstChild("Events") else Models
		local v2 = if v1 then v1:FindFirstChild("SammyRoom") else v1
		if not v2 then
			warn("[SammyRoomController] ReplicatedStorage.Models.Events.SammyRoom missing")
			return
		end
		local SammyRoom = v2:Clone()
		SammyRoom.Name = "SammyRoom"
		SammyRoom.Parent = workspace
		for v3, v4 in t do
			local v5 = SammyRoom
			local v6 = v5
			for v7, v8 in v4.Path do
				if v5 then
					v5 = v5:FindFirstChild(v8)
				else
					v6 = nil
					break
				end
			end
			if v6 then
				v6:AddTag(v4.Tag)
				continue
			end
			warn((("[SammyRoomController] map missing path \'%*\' for tag \'%*\'"):format(table.concat(v4.Path, "/"), v4.Tag)))
		end
	end
	v17 = true
end
local function openCamera()
	if v4 then
		return
	end
	local v1 = nil
	for v2, v3 in CollectionService:GetTagged("SammyRoomCameraAnchor") do
		if v3:IsA("BasePart") and v3:IsDescendantOf(workspace) then
			v1 = v3
			break
		end
	end
	if not v1 then
		warn("[SammyRoomController] No part tagged \'SammyRoomCameraAnchor\' in workspace; aborting camera open")
		return
	end
	local v42 = Trove.new()
	v4 = v42
	local CurrentCamera = workspace.CurrentCamera
	local function lockHumanoid(p1)
		local WalkSpeed = p1.WalkSpeed
		local JumpPower = p1.JumpPower
		local JumpHeight = p1.JumpHeight
		p1.WalkSpeed = 0
		p1.JumpPower = 0
		p1.JumpHeight = 0
		v42:Add(function()
			if not p1.Parent then
				return
			end
			p1.WalkSpeed = WalkSpeed
			p1.JumpPower = JumpPower
			p1.JumpHeight = JumpHeight
		end)
	end
	local Character = LocalPlayer.Character
	local v52 = Character and Character:FindFirstChildOfClass("Humanoid")
	if v52 then
		local WalkSpeed = v52.WalkSpeed
		local JumpPower = v52.JumpPower
		local JumpHeight = v52.JumpHeight
		v52.WalkSpeed = 0
		v52.JumpPower = 0
		v52.JumpHeight = 0
		v42:Add(function()
			if not v52.Parent then
				return
			end
			v52.WalkSpeed = WalkSpeed
			v52.JumpPower = JumpPower
			v52.JumpHeight = JumpHeight
		end)
	end
	local v62 = false
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	v42:Add(CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function()
		if v62 then
			return
		end
		if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			return
		end
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
	end))
	v42:Add(function()
		v62 = true
		CurrentCamera.CameraType = Enum.CameraType.Custom
		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
		if not v1 then
			return
		end
		CurrentCamera.CameraSubject = v1
	end)
	v42:Add(RunService.PreRender:Connect(function()
		if not (v1 and v1.Parent) then
			return
		end
		CurrentCamera.CFrame = v1.CFrame
	end))
	local ClockTime = Lighting.ClockTime
	local v72 = false
	local function setClockTime(p1)
		if not v72 then
			v72 = true
			Lighting.ClockTime = p1
			v72 = false
		end
	end
	local v82 = (v6 + (workspace:GetServerTimeNow() - v5) * v7) // 1
	local v9 = v82 // 3600
	local v10
	if v8 and v8.hourBucket == v9 then
		v10 = v8.offset
	else
		local v11 = computeEtOffsetSeconds(v82)
		v8 = {
			hourBucket = v9,
			offset = v11
		}
		v10 = v11
	end
	local v12 = (v82 + v10) % 86400 / 3600
	if not v72 then
		v72 = true
		Lighting.ClockTime = v12
		v72 = false
	end
	v42:Add(RunService.PreRender:Connect(function()
		if v72 then
			return
		end
		local v1 = (v6 + (workspace:GetServerTimeNow() - v5) * v7) // 1
		local v2 = v1 // 3600
		local v3
		if v8 and v8.hourBucket == v2 then
			v3 = v8.offset
		else
			local v4 = computeEtOffsetSeconds(v1)
			v8 = {
				hourBucket = v2,
				offset = v4
			}
			v3 = v4
		end
		local v52 = (v1 + v3) % 86400 / 3600
		if not v72 then
			v72 = true
			Lighting.ClockTime = v52
			v72 = false
		end
	end))
	v42:Add(Timer.Simple(1, function()
		local v1 = (v6 + (workspace:GetServerTimeNow() - v5) * v7) // 1
		local v2 = v1 // 3600
		local v3
		if v8 and v8.hourBucket == v2 then
			v3 = v8.offset
		else
			local v4 = computeEtOffsetSeconds(v1)
			v8 = {
				hourBucket = v2,
				offset = v4
			}
			v3 = v4
		end
		local v52 = (v1 + v3) % 86400 / 3600
		if not v72 then
			v72 = true
			Lighting.ClockTime = v52
			v72 = false
		end
	end))
	v42:Add(function()
		v72 = true
		Lighting.ClockTime = ClockTime
		v72 = false
		CycleController:Update()
	end)
	v42:Add(LightingController:Push("SammyRoomCamera", {
		Priority = 100,
		ColorCorrection = {
			Saturation = -0.35,
			Contrast = 0.1,
			Brightness = -0.05
		}
	}))
	bindCameraUi(v42)
end
v16 = function()
	if v4 then
		v4:Destroy()
		v4 = nil
	end
end
local function toggleCamera()
	if v4 then
		v16()
	else
		openCamera()
	end
end
local function bindCameraPrompt(p1)
	p1:Add(Observers.observeTag("SammysRoomCameraPrompt", function(p1)
		if not p1:IsA("ProximityPrompt") then
			return nil
		end
		local v1 = Trove.new()
		local Enabled = p1.Enabled
		local function applyFlag()
			p1.Enabled =true
		end
		p1.Enabled = Enabled

		v1:Add(function()
			p1.Enabled = Enabled
		end)
		v1:Add(p1.Triggered:Connect(function()
			if v4 then
				v16()
			else
				openCamera()
			end
		end))
		return v1:WrapClean()
	end, { workspace }))
end
local function findInterlude(p1, p2, p3, p4)
	local Interlude = p1.Action.Interlude
	if not Interlude then
		return false, 0
	end
	local v1 = p1.Start + p2 + p3
	local v2 = p1.Start + p1.Length
	if p4 < v1 or v2 <= p4 then
		return false, 0
	end
	local sum = v1 + Interlude.Period
	local count = 0
	while sum < v2 do
		local v4 = sum + (if Interlude.Jitter > 0 then Random.new(p1.Start + count):NextNumber(-Interlude.Jitter, Interlude.Jitter) else 0)
		if v4 <= p4 and p4 < v4 + Interlude.Duration then
			return true, p4 - v4
		end
		if p4 < v4 then
			break
		end
		sum = sum + Interlude.Period
		count = count + 1
	end
	return false, 0
end
local function resolvePhase(p1, p2)
	local v1 = resolveSlot(p1)
	local Action = v1.Action
	local v2 = resolveSlot(v1.Start - 1)
	local function effLen(p1)
		if not p1 then
			return 0
		end
		local v1 = p2(p1)
		if v1 > 0 then
			return v1
		else
			return 3
		end
	end
	local Outro = v2.Action.Outro
	local v3
	if Outro then
		local v4 = p2(Outro)
		v3 = if v4 > 0 then v4 else 3
	else
		v3 = 0
	end
	local Intro = Action.Intro
	local v5
	if Intro then
		local v6 = p2(Intro)
		v5 = if v6 > 0 then v6 else 3
	else
		v5 = 0
	end
	local v7 = p1 - v1.Start
	if Action ~= v2.Action and (v2.Action.Outro and v7 < v3) then
		return {
			Kind = "outro",
			Tracks = { v2.Action.Outro },
			TimeIntoPhase = v7
		}
	end
	local v9 = v7 - (if Action == v2.Action then 0 else v3)
	if Action.Intro and v9 < v5 then
		return {
			Kind = "intro",
			Tracks = { Action.Intro },
			TimeIntoPhase = v9
		}
	end
	local v12, v13 = findInterlude(v1, if Action == v2.Action then 0 else v3, v5, p1)
	if v12 and Action.Interlude then
		return {
			Kind = "interlude",
			Tracks = { Action.Interlude.Animation },
			TimeIntoPhase = v13
		}
	end
	return {
		Kind = "loop",
		Tracks = Action.Loops,
		TimeIntoPhase = v9 - v5
	}
end
local function bindAnimationCycle(p1)
	p1:Add(Observers.observeTag("SammyRoomRig", function(p1)
		if p1:IsA("Model") then
			local v1 = Trove.new()
			v1:Add(task.spawn(function()
				local v12 = os.clock() + 10
				local v2 = nil
				while os.clock() < v12 do
					local Humanoid = p1:FindFirstChild("Humanoid")
					if Humanoid then
						v2 = Humanoid:WaitForChild("Animator", 5)
					end
					if not v2 then
						local AnimationController = p1:FindFirstChild("AnimationController")
						if AnimationController then
							v2 = AnimationController:WaitForChild("Animator", 5)
						end
					end
					if v2 then
						break
					end
					task.wait(0.2)
				end
				if not v2 then
					warn((("[SammyRoomController] Sammy rig \'%*\' has no Animator after 10s"):format(p1.Name)))
				else
					local Animations = script:WaitForChild("Animations", 10)
					if not Animations then
						warn("[SammyRoomController] script.Animations folder missing")
					else
						local t = {}
						local function getTrack(p1, p2)
							local v12 = t[p1]
							if v12 then
								v12.Looped = p2
								return v12
							end
							local v22 = Animations:FindFirstChild(p1)
							if not v22 or (not v22:IsA("Animation") or v22.AnimationId == "") then
								return nil
							end
							local v3 = v2:LoadAnimation(v22)
							v3.Looped = p2
							v3.Priority = t12[p1] or Enum.AnimationPriority.Action
							t[p1] = v3
							v1:Add(function()
								v3:Stop(0)
								v3:Destroy()
							end)
							return v3
						end
						for v3, v4 in { t4, t5, t6, t7 } do
							if v4.Intro then
								getTrack(v4.Intro, false)
							end
							if v4.Outro then
								getTrack(v4.Outro, false)
							end
							if v4.Interlude then
								getTrack(v4.Interlude.Animation, false)
							end
							for v52, v62 in v4.Loops do
								getTrack(v62, true)
							end
						end
						local function lengthOf(p1)
							local v1 = t[p1]
							if v1 then
								return v1.Length
							else
								return 0
							end
						end
						local v72 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")
						local v8 = ReplicatedStorage
						for v9, v10 in t10 do
							if v8 then
								v8 = v8:FindFirstChild(v10)
							end
						end
						local t2 = {}
						local function stopTrackSound(p1)
							local v1 = t2[p1]
							if not v1 then
								return
							end
							t2[p1] = nil
							if v1.task then
								task.cancel(v1.task)
							end
							if not v1.clone then
								return
							end
							v1.clone:Stop()
							v1.clone:Destroy()
						end
						local function startTrackSound(p1)
							local v1 = t9[p1]
							if not (v1 and (v8 and v72)) then
								return
							end
							local v2 = v8:FindFirstChild(v1.Sound)
							if not v2 then
								return
							end
							local t = {}
							t2[p1] = t
							local function play()
								t.task = nil
								if t2[p1] ~= t then
									return
								end
								local v12 = v2:Clone()
								v12.Looped = v1.Looped == true
								v12.Parent = v72
								v12:Play()
								t.clone = v12
								if not v1.Looped then
									v12.Ended:Once(function()
										if t.clone == v12 then
											t.clone = nil
										end
										v12:Destroy()
									end)
								end
								if not v1.MaxDuration then
									return
								end
								task.delay(v1.MaxDuration, function()
									if t.clone ~= v12 then
										return
									end
									t.clone = nil
									v12:Stop()
									v12:Destroy()
								end)
							end
							if v1.StartDelay then
								t.task = task.delay(v1.StartDelay, play)
							else
								play()
							end
						end
						v1:Add(function()
							for v1 in t2 do
								local v2 = t2[v1]
								if v2 then
									t2[v1] = nil
									if v2.task then
										task.cancel(v2.task)
									end
									if v2.clone then
										v2.clone:Stop()
										v2.clone:Destroy()
									end
								end
							end
						end)
						local t3 = {}
						local function getPropTrack(p1)
							local v12 = t3[p1]
							if v12 then
								return v12
							end
							local v2 = t11[p1]
							if not v2 then
								return nil
							end
							local SammyRoom = workspace:FindFirstChild("SammyRoom")
							if not SammyRoom then
								return nil
							end
							local v3 = SammyRoom
							for v4, v5 in v2.PropPath do
								if not v3 then
									return nil
								end
								v3 = v3:FindFirstChild(v5)
							end
							if not v3 then
								warn((("[SammyRoomController] prop missing at path \'%*\'"):format((table.concat(v2.PropPath, "/")))))
								return nil
							end
							local AnimationController = v3:FindFirstChild("AnimationController")
							if not AnimationController then
								warn((("[SammyRoomController] prop \'%*\' has no AnimationController"):format(v3.Name)))
								return nil
							end
							local Animator = AnimationController:FindFirstChild("Animator")
							if Animator then
								local v7 = Animator:LoadAnimation(v2.Animation)
								v7.Priority = Enum.AnimationPriority.Action
								v7.Looped = false
								t3[p1] = v7
								v1:Add(function()
									v7:Stop(0)
									v7:Destroy()
								end)
								return v7
							else
								warn((("[SammyRoomController] prop \'%*\' AnimationController has no Animator"):format(v3.Name)))
								return nil
							end
						end
						local function stopTrackProp(p1)
							local v1 = t3[p1]
							if not (v1 and v1.IsPlaying) then
								return
							end
							v1:Stop(0)
						end
						local function startTrackProp(p1)
							local v1 = getPropTrack(p1)
							if not v1 then
								return
							end
							if v1.IsPlaying then
								v1:Stop(0)
							end
							v1.Looped = false
							v1.TimePosition = 0
							v1:Play(0)
						end
						v1:Add(function()
							for v1 in t3 do
								local v2 = t3[v1]
								if v2 and v2.IsPlaying then
									v2:Stop(0)
								end
							end
						end)
						local t8 = {}
						local function applyCurrent()
							local v1 = resolvePhase(v6 + (workspace:GetServerTimeNow() - v5) * v7, lengthOf)
							local t4 = {}
							for v2, v3 in v1.Tracks do
								t4[v3] = true
							end
							for v4 in t8 do
								if not t4[v4] then
									local v52 = t[v4]
									if v52 and v52.IsPlaying then
										v52:Stop(0)
									end
									local v62 = t2[v4]
									if v62 then
										t2[v4] = nil
										if v62.task then
											task.cancel(v62.task)
										end
										if v62.clone then
											v62.clone:Stop()
											v62.clone:Destroy()
										end
									end
									local v72 = t3[v4]
									if v72 and v72.IsPlaying then
										v72:Stop(0)
									end
									t8[v4] = nil
								end
							end
							local isNotKind = v1.Kind ~= "loop"
							for v8, v9 in v1.Tracks do
								local v10 = getTrack(v9, not isNotKind)
								if v10 then
									local v11 = if t8[v9] == true then true else false
									if not v11 then
										v10:Play(0)
									end
									if not v11 or (isNotKind or v7 ~= 1) then
										local v12 = t[v9]
										local v13 = if v12 then v12.Length else 0
										if v13 > 0 and isNotKind then
											v10.TimePosition = math.min(v1.TimeIntoPhase, v13)
										elseif v13 > 0 then
											v10.TimePosition = v1.TimeIntoPhase % v13
										end
									end
									if not v11 then
										startTrackSound(v9)
										local v14 = getPropTrack(v9)
										if v14 then
											if v14.IsPlaying then
												v14:Stop(0)
											end
											v14.Looped = false
											v14.TimePosition = 0
											v14:Play(0)
										end
									end
									t8[v9] = true
								end
							end
						end
						applyCurrent()
						v1:Add(Timer.Simple(0.1, applyCurrent))
					end
				end
			end))
			return v1:WrapClean()
		else
			return nil
		end
	end, { workspace }))
end
local function bindProgressDisplay(p1)
	p1:Add(Observers.observeTag("SammyRoomProgressFill", function(p1)
		if p1:IsA("GuiObject") then
			local v1 = Trove.new()
			local Size = p1.Size
			v1:Add(p1:GetPropertyChangedSignal("Size"):Connect(function()  end))
			local function apply()
				p1.Size = UDim2.new(math.clamp((v6 + (workspace:GetServerTimeNow() - v5) * v7 - 1779562800) / 1814400, 0, 1), Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
			end
			local v2 = (v6 + (workspace:GetServerTimeNow() - v5) * v7 - 1779562800) / 1814400
			p1.Size = UDim2.new(math.clamp(v2, 0, 1), Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
			v1:Add(Timer.Simple(1, apply))
			v1:Add(function()
				p1.Size = Size
			end)
			return v1:WrapClean()
		else
			return nil
		end
	end))
	p1:Add(Observers.observeTag("SammyRoomProgressLabel", function(p1)
		if not (p1:IsA("TextLabel") or (p1:IsA("TextBox") or p1:IsA("TextButton"))) then
			return nil
		end
		local v1 = Trove.new()
		local Text = p1.Text
		local function apply()
			p1.Text = ("%*%%"):format((math.floor(math.clamp((v6 + (workspace:GetServerTimeNow() - v5) * v7 - 1779562800) / 1814400, 0, 1) * 100)))
		end
		local v2 = (v6 + (workspace:GetServerTimeNow() - v5) * v7 - 1779562800) / 1814400
		p1.Text = ("%*%%"):format((math.floor(math.clamp(v2, 0, 1) * 100)))
		v1:Add(Timer.Simple(1, apply))
		v1:Add(function()
			p1.Text = Text
		end)
		return v1:WrapClean()
	end))
end
local function jumpForwardFifteen()
	local v1 = v6 + (workspace:GetServerTimeNow() - v5) * v7
	local v2 = resolveSlot(v1)
	local v3 = v2.Start + v2.Length
	local v4 = v3 - 3
	local v52 = v1 + 900
	if not (v4 <= v52) then
		v6 = v52
	elseif v4 <= v1 then
		local v62 = resolveSlot(v3 + 1)
		v6 = v62.Start + v62.Length - 3
	else
		v6 = v4
	end
	v5 = workspace:GetServerTimeNow()
end
local function setEtClock(p1, p2)
	local v1 = v6 + (workspace:GetServerTimeNow() - v5) * v7
	local v2 = v1 // 3600
	local v3
	if v8 and v8.hourBucket == v2 then
		v3 = v8.offset
	else
		local v4 = computeEtOffsetSeconds(v1)
		v8 = {
			hourBucket = v2,
			offset = v4
		}
		v3 = v4
	end
	local v52 = v1 + v3
	v6 = v52 - v52 % 86400 + p1 * 3600 + p2 * 60 - v3
	v5 = workspace:GetServerTimeNow()
end
local function bindDebugUi(p1)
	if not ServerData.IsDevGame() then
		return
	end
	local SammyRoomDebug = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("SammyRoomDebug")
	if not SammyRoomDebug then
		return
	end
	local Hour = SammyRoomDebug:FindFirstChild("Hour", true)
	local Minute = SammyRoomDebug:FindFirstChild("Minute", true)
	local TimeBack = SammyRoomDebug:FindFirstChild("TimeBack", true)
	local TimeForward = SammyRoomDebug:FindFirstChild("TimeForward", true)
	local SpeedDown = SammyRoomDebug:FindFirstChild("SpeedDown", true)
	local SpeedUp = SammyRoomDebug:FindFirstChild("SpeedUp", true)
	local SpeedLabel = SammyRoomDebug:FindFirstChild("SpeedLabel", true)
	if Hour and (Minute and (TimeBack and (TimeForward and (SpeedDown and (SpeedUp and SpeedLabel))))) then
		SammyRoomDebug.Enabled = false
		p1:Add(function()
			SammyRoomDebug.Enabled = false
		end)
		p1:Add(UserInputService.InputBegan:Connect(function(p1, p2)
			if p2 then
				return
			end
			if p1.KeyCode ~= Q then
				return
			end
			SammyRoomDebug.Enabled = not SammyRoomDebug.Enabled
		end))
		local function refresh()
			local v1 = v6 + (workspace:GetServerTimeNow() - v5) * v7
			local v2 = v1 // 3600
			local v3
			if v8 and v8.hourBucket == v2 then
				v3 = v8.offset
			else
				local v4 = computeEtOffsetSeconds(v1)
				v8 = {
					hourBucket = v2,
					offset = v4
				}
				v3 = v4
			end
			local v52 = (v1 + v3) % 86400
			local v62 = v52 // 3600
			local v72 = v52 % 3600 // 60
			if not Hour:IsFocused() then
				Hour.Text = string.format("%02d", v62)
			end
			if not Minute:IsFocused() then
				Minute.Text = string.format("%02d", v72)
			end
			SpeedLabel.Text = ("%*x"):format(v7)
		end
		refresh()
		p1:Add(Timer.Simple(0.1, refresh))
		local function commitTextboxes()
			local v1 = tonumber(Hour.Text) or 0
			local v2 = tonumber(Minute.Text) or 0
			local v3 = math.clamp(v1, 0, 23)
			local v4 = math.clamp(v2, 0, 59)
			local v52 = v6 + (workspace:GetServerTimeNow() - v5) * v7
			local v62 = v52 // 3600
			local v72
			if v8 and v8.hourBucket == v62 then
				v72 = v8.offset
			else
				local v82 = computeEtOffsetSeconds(v52)
				v8 = {
					hourBucket = v62,
					offset = v82
				}
				v72 = v82
			end
			local v9 = v52 + v72
			v6 = v9 - v9 % 86400 + v3 * 3600 + v4 * 60 - v72
			v5 = workspace:GetServerTimeNow()
			refresh()
		end
		p1:Add(Hour.FocusLost:Connect(commitTextboxes))
		p1:Add(Minute.FocusLost:Connect(commitTextboxes))
		p1:Add(TimeBack.Activated:Connect(function()
			v6 = v6 + (workspace:GetServerTimeNow() - v5) * v7 + -900
			v5 = workspace:GetServerTimeNow()
			refresh()
		end))
		p1:Add(TimeForward.Activated:Connect(function()
			jumpForwardFifteen()
			refresh()
		end))
		p1:Add(SpeedUp.Activated:Connect(function()
			v6 = v6 + (workspace:GetServerTimeNow() - v5) * v7
			v5 = workspace:GetServerTimeNow()
			v7 = math.max(1, v7 + 5)
			refresh()
		end))
		p1:Add(SpeedDown.Activated:Connect(function()
			v6 = v6 + (workspace:GetServerTimeNow() - v5) * v7
			v5 = workspace:GetServerTimeNow()
			v7 = math.max(1, v7 - 5)
			refresh()
		end))
	else
		warn("[SammyRoomController] SammyRoomDebug missing expected children")
	end
end
local v18 = nil
local cutsceneConnection = nil

local function scheduleFromFFlag() 
	if cutsceneConnection then
		cutsceneConnection:Disconnect()
		cutsceneConnection = nil
	end

	task.spawn(trySpawnMap)

	cutsceneConnection = StartCutsceneEvent.OnClientEvent:Connect(function()
		task.spawn(preloadCutscene)

		task.defer(startCutscene)
	end)
end
function t13.Start(p1)
	if not (ServerData.IsDuelsServer() or ServerData.IsTsunamiServer()) then
		local v1 = Trove.new()
		task.spawn(scheduleFromFFlag)
		bindCameraPrompt(v1)
		bindAnimationCycle(v1)
		bindProgressDisplay(v1)
		bindDebugUi(v1)
	end
end
return t13