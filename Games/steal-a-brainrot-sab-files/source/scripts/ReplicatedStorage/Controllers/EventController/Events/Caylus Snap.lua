
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local scriptName = script.Name
local v12 = Trove.new()

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)

	local function calculateTimeLeftFor(n1: number)
		return ActiveEventData.startedAt + n1 - workspace:GetServerTimeNow()
	end

	local clone = ShakePresets.BumpS:Clone()

	clone.Amplitude = 0.5
	clone.Sustain = true

	local v17 = v12:Add(ShakePresets.BindShakeToCamera(clone, workspace.CurrentCamera))

	v12:Add(task.delay(1, function()
		clone:Start()
	end))
	v12:Clone(script.Part).Parent = workspace

	local StartCFrameCFrame = script.StartCFrame.CFrame
	local EndCFrameCFrame = script.EndCFrame.CFrame

	local morphTemplate = script:FindFirstChild("CustomCaylus")
	local clone2 = v12:Clone(morphTemplate or script.Caylus)

	clone2.Parent = workspace

	local driver = clone2
	local usingDriver = false

	if morphTemplate then
		usingDriver = true

		driver = v12:Clone(script.Caylus)
		driver.Parent = workspace

		local driverBottle = driver:FindFirstChild("Model")
		for _, d in ipairs(driver:GetDescendants()) do
			if driverBottle and (d == driverBottle or d:IsDescendantOf(driverBottle)) then
				continue
			end
			if d:IsA("BasePart") then
				d.Transparency = 1
				d.CanCollide = false
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			end
		end

		local morphHum = clone2:FindFirstChildOfClass("Humanoid")
		if morphHum then
			morphHum.EvaluateStateMachine = false
			morphHum.AutoRotate = false
			morphHum.WalkSpeed = 0
			morphHum.JumpPower = 0
		end

		local morphHRP = clone2:FindFirstChild("HumanoidRootPart")
		local driverHRP = driver:FindFirstChild("HumanoidRootPart")
		if morphHRP then
			morphHRP.Anchored = false
			for _, p in ipairs(clone2:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
					p.Massless = true
				end
			end
		end

		driver:PivotTo(StartCFrameCFrame)
		clone2:PivotTo(StartCFrameCFrame)
		if morphHRP and driverHRP then
			local weld = Instance.new("Weld")
			weld.Part0 = driverHRP
			weld.Part1 = morphHRP
			weld.C0 = CFrame.new()
			weld.C1 = CFrame.new()
			weld.Parent = driverHRP
			v12:Add(weld)
		end
	end

	local clone3 = v12:Clone(script.Sound)

	clone3.Parent = clone2.HumanoidRootPart
	clone3:Play()

	driver:PivotTo(StartCFrameCFrame)
	driver:ScaleTo(1)
	if usingDriver then
		clone2:PivotTo(StartCFrameCFrame)
		clone2:ScaleTo(1)
	end

	local Animator = driver:FindFirstChildWhichIsA("Animator", true)
	local track = Animator:LoadAnimation(script.WalkAnimation)

	track.Looped = true
	v12:Add(track, "Stop")
	v12:Add(track)
	track:Play()

	local track2 = Animator:LoadAnimation(script.SnapAnimation)

	track2.Looped = false
	v12:Add(track2, "Stop")
	v12:Add(track2)

	local morphTrack, morphTrack2
	if usingDriver then
		local morphAnimator = clone2:FindFirstChildWhichIsA("Animator", true)
		if morphAnimator then
			morphTrack = morphAnimator:LoadAnimation(script.WalkAnimation)
			morphTrack.Looped = true
			morphTrack.Priority = Enum.AnimationPriority.Action
			v12:Add(morphTrack, "Stop")
			v12:Add(morphTrack)
			morphTrack:Play()

			morphTrack2 = morphAnimator:LoadAnimation(script.SnapAnimation)
			morphTrack2.Looped = false
			morphTrack2.Priority = Enum.AnimationPriority.Action
			v12:Add(morphTrack2, "Stop")
			v12:Add(morphTrack2)
		end
	end

	local RootPart = driver.HumanoidRootPart.RootPart
	local Model = driver.Model
	local t2 = {
		Model.Cylinder,
		Model["Cylinder.001"],
		Model["Cylinder.002"],
		Model["Cylinder.003"]
	}
	local t3 = {}

	for _, v30 in t2 do
		t3[v30] = v30.Size
	end

	local function rescaleBottle(n2: number)
		for _, v40 in t2 do
			v40.Size = t3[v40] * n2
		end
	end

	local u32 = nil
	local n3 = 0

	u32 = v12:Add(RunService.PostSimulation:Connect(function()
		local ServerTimeNow = workspace:GetServerTimeNow()
		local v42 = math.clamp((ServerTimeNow - ActiveEventData.startedAt) / 5, 0, 1)
		local v43 = math.clamp((ServerTimeNow - (ActiveEventData.startedAt + 5)) / 1.5833333333333333, 0, 1)

		if n3 < 1 then
			n3 = v42
			driver:PivotTo(StartCFrameCFrame:Lerp(EndCFrameCFrame, v42))
			driver:ScaleTo((math.lerp(1, 6.95, v42)))
			if usingDriver then
				clone2:ScaleTo((math.lerp(1, 6.95, v42)))
			end
		end

		clone.Amplitude = math.lerp(0.5, 3, v42)

		if v43 >= 0.4 then
			local v44 = math.map(v43, 0.4, 0.8, 0, 1)

			RootPart.C1 = CFrame.identity:Lerp(CFrame.new(0, 3.8225000000000002, 0), v44)

			local v45 = 6.95 + v44 * 2

			for _, v47 in t2 do
				v47.Size = t3[v47] * v45
			end
		end

		if v43 >= 1 and u32 then
			v12:Remove(u32)
			u32 = nil
		end
	end))
	v12:Add(task.delay(ActiveEventData.startedAt + 5 - workspace:GetServerTimeNow(), function()
		track:Stop()
		track2:Play()
		if morphTrack then
			morphTrack:Stop()
		end
		if morphTrack2 then
			morphTrack2:Play()
		end
	end))

	local v34 = v12:Add(Observers.observeTag("HideInCaylusSnap", function(p2)
		local p2Parent = p2.Parent

		p2.Parent = script

		return function()
			pcall(function()
				p2.Parent = p2Parent
			end)
		end
	end, {
		workspace,
		script
	}))

	v12:Add(Observers.observeTag("HideInSteakSnap", function(p3)
		local p3Parent = p3.Parent

		p3.Parent = script

		return function()
			pcall(function()
				p3.Parent = p3Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	v12:Add(task.delay(ActiveEventData.startedAt + 6.483333333333333 - workspace:GetServerTimeNow(), function()
		v12:Remove(v17)
	end))
	v12:Add(task.delay(ActiveEventData.startedAt + 6.833333333333333 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Play(1, "Lower")
	end))
	v12:Add(task.delay(ActiveEventData.startedAt + 7.5 - workspace:GetServerTimeNow(), function()
		EffectController:Activate("Blink")
		v12:Add(task.delay(0.35, function()
			v12:Remove(clone2)
			if usingDriver then
				v12:Remove(driver)
			end
			v12:Remove(v34)
		end))
	end))
end
function t1.OnStop(_)
	v12:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
end

return t1
