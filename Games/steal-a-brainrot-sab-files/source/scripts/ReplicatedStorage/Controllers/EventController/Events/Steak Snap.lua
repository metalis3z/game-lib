
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("SoundService")

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ViewportWindow = require(script.ViewportWindow)
local scriptName = script.Name
local v15 = Trove.new()
local v16 = Trove.new()

local function spawnGroundCrack(cFrame: CFrame)
	v16:Clean()

	local v19 = v16:Add(Instance.new("Part"))

	v19.Anchored = true
	v19.CanCollide = false
	v19.CanQuery = false
	v19.CanTouch = false
	v19.Transparency = 1
	v19.Size = Vector3.new(40, 0.009999999776482582, 40)
	v19.CFrame = cFrame
	v19.Parent = workspace

	local v20 = v16:Add(Instance.new("SurfaceGui"))

	v20.Name = "SurfaceGui"
	v20.Active = false
	v20.ClipsDescendants = true
	v20.Face = Enum.NormalId.Top
	v20.LightInfluence = 1
	v20.MaxDistance = 1000
	v20.PixelsPerStud = 200
	v20.ResetOnSpawn = false
	v20.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	v20.ToolPunchThroughDistance = 0.01
	v20.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	v20.Adornee = v19
	v20.Parent = Players.LocalPlayer.PlayerGui

	local v21 = ViewportWindow.bindToSurfaceGui(v20)

	v21.viewportFrame.LightColor = Color3.new(0, 0, 0)

	local clone = v16:Clone(script.Objects)

	clone.Parent = v21.viewportFrame

	local v23 = `SteakCrackPortal_{ HttpService:GenerateGUID(false) }`

	RunService:BindToRenderStep(v23, Enum.RenderPriority.Character.Value, function()
		if not v19.Parent or not v20.Parent then
			return
		end

		clone:PivotTo(v19.CFrame)
		ViewportWindow.render(v21)
	end)
	v16:Add(function()
		RunService:UnbindFromRenderStep(v23)
	end)
	v16:Add(task.delay(300, function()
		v16:Destroy()
	end))
end

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)

	local function calculateTimeLeftFor(n1: number)
		return ActiveEventData.startedAt + n1 - workspace:GetServerTimeNow()
	end

	local clone = ShakePresets.BumpS:Clone()

	clone.Amplitude = 0.5
	clone.Sustain = true

	local v28 = v15:Add(ShakePresets.BindShakeToCamera(clone, workspace.CurrentCamera))

	v15:Add(task.delay(1, function()
		clone:Start()
	end))
	v15:Clone(script.Part).Parent = workspace

	local StartCFrameCFrame = script.StartCFrame.CFrame
	local EndCFrameCFrame = script.EndCFrame.CFrame

	local morphTemplate = script:FindFirstChild("CustomSteak")
	local clone2 = v15:Clone(morphTemplate or script.Steak)

	clone2.Parent = workspace

	local driver = clone2
	local usingDriver = false

	if morphTemplate then
		usingDriver = true

		driver = v15:Clone(script.Steak)
		driver.Parent = workspace

		for _, d in ipairs(driver:GetDescendants()) do
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
			v15:Add(weld)
		end
	end

	local clone3 = v15:Clone(script.Sound)

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
	v15:Add(track, "Stop")
	v15:Add(track)
	track:Play()

	local track2 = Animator:LoadAnimation(script.SnapAnimation)

	track2.Looped = false
	v15:Add(track2, "Stop")
	v15:Add(track2)

	local morphTrack, morphTrack2
	if usingDriver then
		local morphAnimator = clone2:FindFirstChildWhichIsA("Animator", true)
		if morphAnimator then
			morphTrack = morphAnimator:LoadAnimation(script.WalkAnimation)
			morphTrack.Looped = true
			morphTrack.Priority = Enum.AnimationPriority.Action
			v15:Add(morphTrack, "Stop")
			v15:Add(morphTrack)
			morphTrack:Play()

			morphTrack2 = morphAnimator:LoadAnimation(script.SnapAnimation)
			morphTrack2.Looped = false
			morphTrack2.Priority = Enum.AnimationPriority.Action
			v15:Add(morphTrack2, "Stop")
			v15:Add(morphTrack2)
		end
	end

	local connection = nil

	connection = RunService.PostSimulation:Connect(function()
		local v41 = math.clamp((workspace:GetServerTimeNow() - ActiveEventData.startedAt) / 5, 0, 1)

		local scale = math.lerp(1, 6.95, v41)

		driver:PivotTo(StartCFrameCFrame:Lerp(EndCFrameCFrame, v41))
		driver:ScaleTo(scale)
		if usingDriver then
			clone2:ScaleTo(scale)
		end

		clone.Amplitude = math.lerp(0.5, 3, v41)

		if v41 >= 1 then
			connection:Disconnect()
		end
	end)
	v15:Add(connection)
	v15:Add(task.delay(ActiveEventData.startedAt + 5 - workspace:GetServerTimeNow(), function()
		track:Stop()
		track2:Play()
		if morphTrack then
			morphTrack:Stop()
		end
		if morphTrack2 then
			morphTrack2:Play()
		end
	end))

	local v37 = v15:Add(Observers.observeTag("HideInSteakSnap", function(p2)
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

	v15:Add(task.delay(ActiveEventData.startedAt + 6.300000000000001 - workspace:GetServerTimeNow(), function()
		v15:Remove(v28)

		local clone4 = ShakePresets.Explosion:Clone()

		clone4.Amplitude = 8
		clone4.SustainTime = math.max(0, 2.5 - clone4.FadeInTime - clone4.FadeOutTime)
		ShakePresets.BindShakeToCamera(clone4, workspace.CurrentCamera)
		clone4:Start()
		spawnGroundCrack(CFrame.new(-410.424, -9.3, -61.83))
	end))
	v15:Add(task.delay(ActiveEventData.startedAt + 6.3500000000000005 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Play(1, "Lower")
	end))
	v15:Add(task.delay(ActiveEventData.startedAt + 6.4 - workspace:GetServerTimeNow(), function()
		EffectController:Activate("Blink")
		v15:Add(task.delay(0.35, function()
			v15:Remove(clone2)
			if usingDriver then
				v15:Remove(driver)
			end
			v15:Remove(v37)
		end))
	end))
end
function t1.OnStop(_)
	v15:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
end

return t1
