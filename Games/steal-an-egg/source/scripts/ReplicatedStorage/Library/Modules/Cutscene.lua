-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Settings = {
		YieldPauseArgument = false,
		FreezeEnabled = false
	}
}
local LocalPlayer = game.Players.LocalPlayer
local v1 = nil
local v2 = nil

local function characterAdded(p1) --[[ characterAdded | Line: 15 | Upvalues: t (copy), v1 (ref), v2 (ref) ]]
	p1:WaitForChild("Humanoid").Died:Connect(function() --[[ Line: 16 | Upvalues: t (ref) ]]
		if not t.Playing then
			return
		end

		t.Playing:Cancel()
	end)
	v1 = p1
	v2 = p1:WaitForChild("HumanoidRootPart")
end

if LocalPlayer.Character then
	local Character = LocalPlayer.Character

	Character:WaitForChild("Humanoid").Died:Connect(function() --[[ Line: 16 | Upvalues: t (copy) ]]
		if not t.Playing then
			return
		end

		t.Playing:Cancel()
	end)
	v1 = Character
	v2 = Character:WaitForChild("HumanoidRootPart")
end

LocalPlayer.CharacterAdded:Connect(characterAdded)
v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
v2 = v1:WaitForChild("HumanoidRootPart")

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local v4 = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls()
local EasingFunctions = require(script.EasingFunctions)
local CurrentCamera = workspace.CurrentCamera
local clock = os.clock
local t2 = {}

t2.__index = t2

local v5 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) --[[ acquireRunnerThreadAndCallEventHandler | Line: 45 | Upvalues: v5 (ref) ]]
	local v1 = v5

	v5 = nil
	p1(...)
	v5 = v1
end

local function runEventHandlerInFreeThread(...) --[[ runEventHandlerInFreeThread | Line: 52 | Upvalues: acquireRunnerThreadAndCallEventHandler (copy) ]]
	acquireRunnerThreadAndCallEventHandler(...)

	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t3 = {}

t3.__index = t3
function t3.new(p1, p2) --[[ new | Line: 62 | Upvalues: t3 (copy) ]]
	return setmetatable({
		Connected = true,
		_next = false,
		_signal = p1,
		_fn = p2
	}, t3)
end
function t3.Disconnect(p1) --[[ Disconnect | Line: 71 ]]
	assert(p1.Connected, "Can\'t disconnect a connection twice")
	p1.Connected = false

	if p1._signal._handlerListHead == p1 then
		p1._signal._handlerListHead = p1._next

		return
	end

	local _handlerListHead = p1._signal._handlerListHead

	while _handlerListHead and _handlerListHead._next ~= p1 do
		_handlerListHead = _handlerListHead._next
	end

	if not _handlerListHead then
		return
	end

	_handlerListHead._next = p1._next
end
function t2.new() --[[ new | Line: 87 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_handlerListHead = false
	}, t2)
end
function t2.Connect(p1, p2) --[[ Connect | Line: 91 | Upvalues: t3 (copy) ]]
	local v1 = t3.new(p1, p2)

	if p1._handlerListHead then
		v1._next = p1._handlerListHead
	end

	p1._handlerListHead = v1

	return v1
end
function t2.DisconnectAll(p1) --[[ DisconnectAll | Line: 102 ]]
	p1._handlerListHead = false
end
function t2.Fire(p1, ...) --[[ Fire | Line: 106 | Upvalues: v5 (ref), runEventHandlerInFreeThread (copy) ]]
	local _handlerListHead = p1._handlerListHead

	while _handlerListHead do
		if _handlerListHead.Connected then
			if not v5 then
				v5 = coroutine.create(runEventHandlerInFreeThread)
			end

			task.spawn(v5, _handlerListHead._fn, ...)
		end

		_handlerListHead = _handlerListHead._next
	end
end
function t2.Wait(p1) --[[ Wait | Line: 119 ]]
	local v1 = coroutine.running()
	local v2 = nil

	v2 = p1:Connect(function(...) --[[ Line: 122 | Upvalues: v2 (ref), v1 (copy) ]]
		v2:Disconnect()
		task.spawn(v1, ...)
	end)

	return coroutine.yield()
end

local function getCF(p1, p2) --[[ getCF | Line: 131 ]]
	local t = { unpack(p1) }
	local v1 = #t

	for i = 1, v1 - 1 do
		for j = 1, v1 - i do
			t[j] = t[j]:Lerp(t[j + 1], p2)
		end
	end

	return t[1]
end

function t.getCoreGuisEnabled() --[[ getCoreGuisEnabled | Line: 142 | Upvalues: StarterGui (copy) ]]
	return {
		Backpack = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack),
		Chat = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat),
		EmotesMenu = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu),
		Health = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health),
		PlayerList = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)
	}
end
t.Enum = {
	DisableControls = "DisableControls",
	CurrentCameraPoint = "CurrentCameraPoint",
	DefaultCameraPoint = "DefaultCameraPoint",
	FreezeCharacter = "FreezeCharacter",
	CustomCamera = "CustomCamera"
}

local t4 = {
	Start = {
		{ "CustomCamera", function(p1, p2) --[[ Line: 164 | Upvalues: CurrentCamera (ref) ]]
				assert(p2, "CustomCamera Argument 1 missing or nil")
				CurrentCamera = p2
				p1.CustomCamera = p2
			end },
		{ "DisableControls", function() --[[ Line: 172 | Upvalues: v4 (copy) ]]
				v4:Disable()
			end },
		{ "FreezeCharacter", function(p1, p2) --[[ Line: 178 | Upvalues: v1 (ref), v2 (ref) ]]
				if p2 == false then
					v2.Anchored = true

					return
				end

				for i, v in ipairs(v1.Humanoid.Animator:GetPlayingAnimationTracks()) do
					v:Stop()
				end

				v2.Anchored = true
			end },
		{ "CurrentCameraPoint", function(p1, p2) --[[ Line: 189 | Upvalues: CurrentCamera (ref) ]]
				local v1 = if p2 then p2 else #p1.PointsCopy + 1

				table.insert(p1.PointsCopy, v1, CurrentCamera.CFrame)
			end },
		{ "DefaultCameraPoint", function(p1, p2, p3) --[[ Line: 195 | Upvalues: LocalPlayer (copy), CurrentCamera (ref), v2 (ref) ]]
				local v1 = 12.5

				if p3 == false then
					local CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
					local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance

					LocalPlayer.CameraMinZoomDistance = v1
					LocalPlayer.CameraMaxZoomDistance = v1
					task.wait()
					LocalPlayer.CameraMinZoomDistance = CameraMinZoomDistance
					LocalPlayer.CameraMaxZoomDistance = CameraMaxZoomDistance
				else
					v1 = (CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude
				end

				local v3 = v2.CFrame.Position + Vector3.new(0, v2.Size.Y / 2 + 0.5, 0)
				local Position2 = (v2.CFrame * CFrame.new(0, v1 / 2.639783059671599, v1 / 1.035276097119764)).Position

				table.insert(p1.PointsCopy, if p2 then p2 else #p1.PointsCopy + 1, CFrame.lookAt(Position2, v3))
			end }
	},
	End = {
		{ "DisableControls", function() --[[ Line: 226 | Upvalues: v4 (copy) ]]
				v4:Enable(true)
			end },
		{ "FreezeCharacter", function() --[[ Line: 232 | Upvalues: v2 (ref) ]]
				v2.Anchored = false
			end },
		{ "CustomCamera", function(p1) --[[ Line: 238 | Upvalues: CurrentCamera (ref) ]]
				CurrentCamera.CameraType = p1.PreviousCameraType
				CurrentCamera = workspace.CurrentCamera
			end }
	},
	StartKeys = {},
	EndKeys = {}
}

for i, v in ipairs(t4.Start) do
	table.insert(t4.StartKeys, v[1])
	t4.Start[i] = v[2]
end

for i, v in ipairs(t4.End) do
	table.insert(t4.EndKeys, v[1])
	t4.End[i] = v[2]
end

local t5 = {}

t5.__index = t5
t5.ClassName = "Cutscene"
function t.Thaw(p1) --[[ Thaw | Line: 262 | Upvalues: t (copy) ]]
	if not (p1 or t.FreezeEnabled) then
		return
	end

	if typeof(t.Freezer) ~= "RBXScriptConnection" then
		t.Freezer = nil

		return
	end

	t.Freezer:Disconnect()
	t.Freezer = nil
end
function t.Freeze(p1, p2) --[[ Freeze | Line: 273 | Upvalues: t (copy), CurrentCamera (ref), RunService (copy) ]]
	if not (p1 or t.FreezeEnabled) then
		return
	end

	local v1 = typeof(p2) == "CFrame" and p2 or CurrentCamera.CFrame

	t.Thaw()
	t.Freezer = RunService.Heartbeat:Connect(function() --[[ Line: 280 | Upvalues: CurrentCamera (ref), p2 (copy), v1 (copy) ]]
		CurrentCamera.CFrame = typeof(p2) == "Instance" and p2.CFrame or v1
	end)
end
function t5.Play(p1, p2) --[[ Play | Line: 285 | Upvalues: t (copy), EasingFunctions (copy), StarterGui (copy), CurrentCamera (ref), t4 (copy), clock (copy), RunService (copy), getCF (copy) ]]
	if t.Playing then
		t.Playing:Cancel()
	end

	t.Thaw()

	if not (t.Playing and t.Playing.CurrentCutscene) then
		t.Playing = p1
	end

	local t2 = {}

	t2[1] = unpack(p1.Points)
	p1.PointsCopy = t2

	local PointsCopy = p1.PointsCopy
	local v1 = EasingFunctions[p1.EasingFunction]
	local Duration = p1.Duration
	local v2 = nil

	if not p1.Next then
		p1.PreviousCoreGuis = t.getCoreGuisEnabled()

		if not p1.Reset.Preserve_Cores then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		end

		p1.PreviousCameraType = CurrentCamera.CameraType
	end

	for i, v in ipairs(p1.SpecialFunctions[1]) do
		if type(v) == "table" then
			t4.Start[v[1]](p1, select(2, unpack(v)))

			continue
		end

		t4.Start[v](p1)
	end

	assert(if #p1.PointsCopy > 1 then true else false, "More than one point is required")
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p1.PlaybackState = Enum.PlaybackState.Playing

	local v4 = clock()

	RunService:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value + 1, function() --[[ Line: 325 | Upvalues: v2 (ref), clock (ref), v4 (copy), Duration (copy), CurrentCamera (ref), getCF (ref), PointsCopy (copy), v1 (copy), p1 (copy), RunService (ref), t4 (ref), t (ref), StarterGui (ref), p2 (copy) ]]
		v2 = clock() - v4

		if v2 <= Duration then
			CurrentCamera.CFrame = getCF(PointsCopy, v1(v2, 0, 1, Duration))
			p1.Progress = v2 / Duration
			p1.PassedTime = v2

			return
		end

		RunService:UnbindFromRenderStep("Cutscene")
		p1.Progress = 1
		p1.PassedTime = Duration

		for i, v in ipairs(p1.SpecialFunctions[2]) do
			if type(v) == "table" then
				t4.End[v[1]](p1, select(2, unpack(v)))

				continue
			end

			t4.End[v](p1)
		end

		p1.PlaybackState = Enum.PlaybackState.Completed

		if p1.Next then
			if p1.Next == 0 then
				local Playing = t.Playing

				t.Playing = nil
				Playing.PlaybackState = Enum.PlaybackState.Completed
				CurrentCamera.CameraType = Playing.PreviousCameraType
				Playing.CurrentCutscene = nil

				local Core_Gui = p1.Reset.Core_Gui

				for v3, v42 in next, if typeof(Core_Gui) == "table" and Core_Gui then Core_Gui else p1.PreviousCoreGuis do
					local v6 = Enum.CoreGuiType[v3]

					StarterGui:SetCoreGuiEnabled(v6, if typeof(Core_Gui) == "table" then v42 else Core_Gui or false)
				end

				for i, v in ipairs(Playing.Cutscenes) do
					v.Next = nil
				end

				Playing.Completed:Fire(Enum.PlaybackState.Completed)
			else
				if t.Playing.CurrentCutscene then
					t.Playing.CurrentCutscene = p1.Next
				end

				p1.Completed:Fire(Enum.PlaybackState.Completed)
				p1.Next:Play()
			end
		else
			t.Playing = nil

			if not p1.CustomCamera then
				CurrentCamera.CameraType = p1.Reset.Camera and Enum.CameraType[p1.Reset.Camera] or p1.PreviousCameraType
			end

			if p2 then
				t.Freeze()
			end

			local Core_Gui = p1.Reset.Core_Gui

			for v12, v13 in next, if typeof(Core_Gui) == "table" and Core_Gui then Core_Gui else p1.PreviousCoreGuis do
				local v15 = Enum.CoreGuiType[v12]

				StarterGui:SetCoreGuiEnabled(v15, if typeof(Core_Gui) == "table" then v13 else Core_Gui or false)
			end

			p1.Completed:Fire(Enum.PlaybackState.Completed)
		end
	end)
end
function t5.Pause(p1, p2) --[[ Pause | Line: 401 | Upvalues: t (copy), RunService (copy), CurrentCamera (ref) ]]
	if not t.Playing then
		error("Error while calling Pause - There was no cutscene playing")
	end

	if p1.PassedTime == nil then
		error("Error while calling Pause - Cutscene hasn\'t started yet")
	end

	RunService:UnbindFromRenderStep("Cutscene")

	local v1 = if t.Playing.CurrentCutscene then t.Playing else nil

	t.Playing = nil
	p1.PlaybackState = Enum.PlaybackState.Paused

	if p1.CustomCamera then
		CurrentCamera = workspace.CurrentCamera
	end

	if p2 and t.Settings.YieldPauseArgument then
		task.wait(p2)

		if v1 then
			v1:Resume()
		else
			p1:Resume()
		end
	elseif p2 then
		task.spawn(function() --[[ Line: 427 | Upvalues: p2 (copy), v1 (ref), p1 (copy) ]]
			task.wait(p2)

			if v1 then
				v1:Resume()
			else
				p1:Resume()
			end
		end)
	end
end
function t5.Resume(p1) --[[ Resume | Line: 442 | Upvalues: t (copy), EasingFunctions (copy), CurrentCamera (ref), clock (copy), RunService (copy), getCF (copy), t4 (copy), StarterGui (copy) ]]
	if t.Playing ~= nil and t.Playing.CurrentCutscene ~= p1 then
		error("Error while calling Resume - The cutscene was already playing")
	end

	if p1.PassedTime and p1.PassedTime ~= 0 then
		t.Playing = t.Playing or p1

		local Duration = p1.Duration
		local PointsCopy = p1.PointsCopy
		local v1 = EasingFunctions[p1.EasingFunction]
		local PassedTime = p1.PassedTime

		p1.PlaybackState = Enum.PlaybackState.Playing

		if p1.CustomCamera then
			CurrentCamera = p1.CustomCamera
		end

		CurrentCamera.CameraType = Enum.CameraType.Scriptable

		local v2 = clock() - PassedTime

		RunService:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value + 1, function() --[[ Line: 458 | Upvalues: PassedTime (ref), clock (ref), v2 (copy), Duration (copy), CurrentCamera (ref), getCF (ref), PointsCopy (copy), v1 (copy), p1 (copy), RunService (ref), t4 (ref), t (ref), StarterGui (ref) ]]
			PassedTime = clock() - v2

			if PassedTime <= Duration then
				CurrentCamera.CFrame = getCF(PointsCopy, v1(PassedTime, 0, 1, Duration))
				p1.Progress = PassedTime / Duration
				p1.PassedTime = PassedTime

				return
			end

			RunService:UnbindFromRenderStep("Cutscene")
			p1.Progress = 1
			p1.PassedTime = Duration

			for i, v in ipairs(p1.SpecialFunctions[2]) do
				if type(v) == "table" then
					t4.End[v[1]](p1, select(2, unpack(v)))

					continue
				end

				t4.End[v](p1)
			end

			p1.PlaybackState = Enum.PlaybackState.Completed

			if p1.Next then
				if p1.Next == 0 then
					local Playing = t.Playing

					t.Playing = nil
					Playing.PlaybackState = Enum.PlaybackState.Completed
					CurrentCamera.CameraType = Playing.PreviousCameraType
					Playing.CurrentCutscene = nil

					for v12, v22 in next, Playing.PreviousCoreGuis do
						if v22 then
							StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v12], true)
						end
					end

					for i, v in ipairs(Playing.Cutscenes) do
						v.Next = nil
					end

					Playing.Completed:Fire(Enum.PlaybackState.Completed)
				else
					if not t.Playing.CurrentCutscene then
						p1.Completed:Fire(Enum.PlaybackState.Completed)
						p1.Next:Play()

						return
					end

					t.Playing.CurrentCutscene = p1.Next
					p1.Completed:Fire(Enum.PlaybackState.Completed)
					p1.Next:Play()
				end
			else
				t.Playing = nil

				if not p1.CustomCamera then
					CurrentCamera.CameraType = p1.PreviousCameraType
				end

				for v3, v4 in next, p1.PreviousCoreGuis do
					if v4 then
						StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v3], true)
					end
				end

				p1.Completed:Fire(Enum.PlaybackState.Completed)
			end
		end)
	else
		p1:Play()
	end
end
function t5.Cancel(p1) --[[ Cancel | Line: 526 | Upvalues: t (copy), RunService (copy), t4 (copy), CurrentCamera (ref), StarterGui (copy) ]]
	if not t.Playing then
		error("Error while calling Cancel - There was no cutscene playing")
	end

	t.Thaw()
	RunService:UnbindFromRenderStep("Cutscene")
	t.Playing = nil

	for i, v in ipairs(p1.SpecialFunctions[2]) do
		if type(v) == "table" then
			t4.End[v[1]](p1, select(2, unpack(v)))

			continue
		end

		t4.End[v](p1)
	end

	if not p1.Next then
		if not p1.CustomCamera then
			CurrentCamera.CameraType = p1.PreviousCameraType
		end

		for v1, v2 in next, p1.PreviousCoreGuis do
			if v2 then
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v1], true)
			end
		end
	end

	p1.PlaybackState = Enum.PlaybackState.Cancelled
	p1.Completed:Fire(Enum.PlaybackState.Cancelled)
end
function t5.Destroy(p1) --[[ Destroy | Line: 558 ]]
	table.clear(p1)
	setmetatable(p1, nil)
end
function t.Create(p1, p2, p3, p4, ...) --[[ Create | Line: 563 | Upvalues: t2 (copy), EasingFunctions (copy), t4 (copy), t5 (copy) ]]
	assert(p2, "Argument 1 (points) missing or nil")
	assert(p3, "Argument 2 (duration) missing or nil")

	local t = {
		Progress = 0,
		PreviousCameraType = nil,
		PreviousCoreGuis = nil,
		Completed = t2.new(),
		PlaybackState = Enum.PlaybackState.Begin,
		Duration = p3,
		Reset = p4
	}
	local list = { ... }

	if typeof(p2) == "Instance" then
		assert(typeof(p2) ~= "table", "Argument 1 (points) not an instance or table")

		local v2 = p2:GetChildren()

		table.sort(v2, function(p1, p2) --[[ Line: 584 ]]
			local v2 = tonumber(p1.Name)

			return v2 < tonumber(p2.Name)
		end)
		p2 = {}

		for i, v in ipairs(v2) do
			table.insert(p2, v.CFrame)
		end
	end

	t.Points = p2
	t.EasingFunction = "Linear"

	local v4 = nil
	local v5 = "In"

	for i, v in ipairs(list) do
		if EasingFunctions[v] then
			t.EasingFunction = v

			continue
		end

		if typeof(v) == "EnumItem" then
			if v.EnumType == Enum.EasingDirection then
				v5 = v.Name

				continue
			end

			if v.EnumType == Enum.EasingStyle then
				v4 = v.Name
			end
		end
	end

	if v4 then
		assert(EasingFunctions[v5 .. v4], "EasingFunction " .. v5 .. v4 .. " not found")
		t.EasingFunction = v5 .. v4
	end

	t.SpecialFunctions = {
		{},
		{}
	}

	for i, v in ipairs(t4.StartKeys) do
		local v7 = 0

		repeat
			local v8
			local v9 = table.find(list, v, v7 + 1)

			if v9 then
				local count, v10

				count = v9 + 1
				v10 = {}
				v7 = v9

				repeat
					local v11 = list[count]

					v8 = if v11 or v11 == false then if typeof(v11) == "string" then false elseif typeof(v11) == "EnumItem" then false else true else false

					if v8 then
						table.insert(v10, v11)
						count = count + 1
					end
				until not v8

				if #v10 == 0 then
					table.insert(t.SpecialFunctions[1], i)

					continue
				end

				table.insert(v10, 1, i)
				table.insert(t.SpecialFunctions[1], v10)

				continue
			end

			v7 = v9
		until not v9
	end

	for i, v in ipairs(t4.EndKeys) do
		local v14 = 0

		repeat
			local v15
			local v16 = table.find(list, v, v14 + 1)

			if v16 then
				local count, v17

				count = v16 + 1
				v17 = {}
				v14 = v16

				repeat
					local v18 = list[count]

					v15 = if v18 or v18 == false then if typeof(v18) == "string" then false elseif typeof(v18) == "EnumItem" then false else true else false

					if v15 then
						table.insert(v17, v18)
						count = count + 1
					end
				until not v15

				if #v17 == 0 then
					table.insert(t.SpecialFunctions[2], i)

					continue
				end

				table.insert(v17, 1, i)
				table.insert(t.SpecialFunctions[2], v17)

				continue
			end

			v14 = v16
		until not v16
	end

	return setmetatable(t, t5)
end

local t6 = {}

t6.__index = t6
t6.ClassName = "Queue"
function t6.Play(p1) --[[ Play | Line: 672 | Upvalues: t (copy), StarterGui (copy), CurrentCamera (ref) ]]
	if t.Playing ~= nil then
		error("Error while calling Play - A cutscene/queue was already playing")
	end

	t.Playing = p1

	local Cutscenes = p1.Cutscenes

	for i, v in ipairs(Cutscenes) do
		if Cutscenes[i + 1] then
			v.Next = Cutscenes[i + 1]

			continue
		end

		v.Next = 0
	end

	p1.PreviousCoreGuis = t.getCoreGuisEnabled()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	p1.PreviousCameraType = CurrentCamera.CameraType
	p1.PlaybackState = Enum.PlaybackState.Playing
	t.Playing = p1
	p1.CurrentCutscene = Cutscenes[1]
	Cutscenes[1]:Play()
end
function t6.Pause(p1, p2) --[[ Pause | Line: 698 | Upvalues: t (copy) ]]
	if t.Playing then
		p1.CurrentCutscene:Pause(p2)
	else
		error("Error while calling Pause - There was no queue playing")
	end
end
function t6.Resume(p1) --[[ Resume | Line: 706 | Upvalues: t (copy) ]]
	if t.Playing == nil then
		t.Playing = p1
		p1.CurrentCutscene:Resume()
	else
		error("Error while calling Resume - A cutscene/queue was already playing")
	end
end
function t6.Cancel(p1) --[[ Cancel | Line: 715 | Upvalues: t (copy), CurrentCamera (ref), StarterGui (copy) ]]
	if not t.Playing then
		error("Error while calling Cancel - There was no queue playing")
	end

	p1.CurrentCutscene:Cancel()
	p1.CurrentCutscene = nil
	CurrentCamera.CameraType = p1.PreviousCameraType

	for v1, v2 in next, p1.PreviousCoreGuis do
		if v2 then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[v1], true)
		end
	end

	for i, v in ipairs(p1.Cutscenes) do
		v.Next = nil
	end

	p1.PlaybackState = Enum.PlaybackState.Cancelled
	p1.Completed:Fire(Enum.PlaybackState.Cancelled)
end
function t6.Destroy(p1) --[[ Destroy | Line: 735 ]]
	table.clear(p1)
	setmetatable(p1, nil)
end
function t.CreateQueue(p1, ...) --[[ CreateQueue | Line: 740 | Upvalues: t2 (copy), t6 (copy) ]]
	return setmetatable({
		Completed = t2.new(),
		PlaybackState = Enum.PlaybackState.Begin,
		Cutscenes = { ... }
	}, t6)
end

return t