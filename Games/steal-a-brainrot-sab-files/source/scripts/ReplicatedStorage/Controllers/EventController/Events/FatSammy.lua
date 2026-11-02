game:GetService("CollectionService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("RunService")

local Players = game:GetService("Players")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {
	Duration = {
		Default = 600
	}
}
local ConfirmationController = require(ReplicatedStorage.Controllers.ConfirmationController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Animals = require(ReplicatedStorage.Datas.Animals)

require(ReplicatedStorage.Utils.TimeUtils)

local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)
local Animals2 = require(ReplicatedStorage.Shared.Animals)
local v16 = Net:RemoteEvent("EventService/FatSammy/PlaySpawnSequence")
local v17 = Net:RemoteEvent("EventService/FatSammy/PlayEatAnimation")
local v18 = Net:RemoteEvent("EventService/FatSammy/Delivery")
local scriptName = script.Name
local LocalPlayer = Players.LocalPlayer
local Model = workspace.Events.FatSammy.Model
local Sammy = Model.Sammy
local Animator = Sammy.AnimationController.Animator
local u24 = false
local v25 = Trove.new()

function t1.OnStart(_)
	assert((EventController:GetActiveEventData(scriptName)))

	local v27 = Trove.new()

	v25:Add(function()
		while u24 do
			task.wait()
		end

		v27:Destroy()
	end)

	local v28 = SharedEventUtils.loadAnimation(v27, Animator, script.Idle)
	local v29 = SharedEventUtils.loadAnimation(v27, Animator, script.PointUp)
	local v30 = SharedEventUtils.loadAnimation(v27, Animator, script.PoseToBeam)
	local v31 = SharedEventUtils.loadAnimation(v27, Animator, script.BeamLoop)
	local v32 = SharedEventUtils.loadAnimation(v27, Animator, script.BeamResume)
	local v33 = SharedEventUtils.loadAnimation(v27, Animator, script.Eat)

	v27:Add(v29:GetMarkerReachedSignal("Freeze"):Connect(function()
		v29:AdjustSpeed(0)
	end))
	v28.Looped = true
	v28:Play()
	v25:Add(v17.OnClientEvent:Connect(function()
		if u24 then
			return
		end

		v33:AdjustWeight(1)
		v33:Play()
		task.wait(0.1)
		SoundController:PlaySound(ReplicatedStorage.Sounds.Events.FatSammy.Eat, Sammy:GetPivot().Position)
	end))
	v25:Add(v16.OnClientEvent:Connect(function(n1: number)
		local v39 = Trove.new()

		u24 = true
		v39:Add(function()
			u24 = false
		end)
		v39:Add(task.delay(math.max(n1 + 11 - workspace:GetServerTimeNow(), 0), function()
			v39:Destroy()
		end))
		v29:Play()
		v33:AdjustWeight(0)

		if math.max(n1 + 5.5 - workspace:GetServerTimeNow(), 0) >= 4.5 then
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events.FatSammy.Charge, Sammy:GetPivot().Position, false)
		end

		task.wait((math.max(n1 + 0.5 - workspace:GetServerTimeNow(), 0)))

		local v40 = VFX.copy(script.Absorb, Sammy.Taco.CFrame, Sammy.Taco)

		v39:Add(v40)
		VFX.weldPosition(v40, Sammy.Taco)
		VFX.enable(v40)

		local v41 = VFX.copy(script.Orb, Sammy.Taco.CFrame, Sammy.Taco)

		v39:Add(v41)
		VFX.weldPosition(v41, Sammy.Taco)
		VFX.enable(v41)

		local Model2 = Instance.new("Model")

		v39:Add(Model2)
		v41.Parent = Model2
		Model2.Parent = Sammy.Taco

		local NumberValue = Instance.new("NumberValue")

		v39:Add(NumberValue)
		NumberValue.Value = 0.1
		Model2:ScaleTo(0.1)
		NumberValue.Changed:Connect(function(property)
			Model2:ScaleTo(property)
		end)

		local v44 = CreateTween(NumberValue, TweenInfo.new(math.max(n1 + 5 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			Value = 1
		})

		task.wait((math.max(n1 + 5 - workspace:GetServerTimeNow(), 0)))
		v44:Cancel()
		v44:Destroy()
		Model2:ScaleTo(1)
		VFX.disable(v40)
		v30:Play()
		task.wait((math.max(n1 + 5.5 - workspace:GetServerTimeNow(), 0)))

		local clone = v39:Clone(script.Beam)

		clone.Parent = workspace
		VFX.enable(clone)

		local att0 = clone.att0
		local WorldPosition = clone.att0.WorldPosition

		v39:Add(att0)
		att0.Parent = workspace.Terrain
		att0.WorldCFrame = v41.att1.WorldCFrame

		for _, v49 in clone.beams:GetChildren() do
			if v49:IsA("Beam") then
				v49.Attachment1 = v41.att1
			end
		end

		local v50 = VFX.copy(script.Burst, Sammy.Taco.CFrame, workspace)

		v39:Add(v50)
		VFX.emit(v50)
		v29:Stop()
		v31:Play()
		VFX.disable(v41)
		CreateTween(att0, TweenInfo.new(math.max(n1 + 6.5 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Position = WorldPosition
		})

		if math.max(n1 + 6.5 - workspace:GetServerTimeNow(), 0) >= 0.5 then
			local v51 = SoundController:PlaySound(ReplicatedStorage.Sounds.Events.FatSammy.Shot, nil, false)

			if v51 then
				v51.Parent = att0
			end
		end

		task.wait((math.max(n1 + 6.5 - workspace:GetServerTimeNow(), 0)))
		VFX.disable(att0)

		for _, v53 in clone.beams:GetChildren() do
			if v53:IsA("Beam") then
				CreateTween(v53, TweenInfo.new(math.max(n1 + 7.7 - workspace:GetServerTimeNow(), 0), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					Width0 = 0,
					Width1 = 0
				})
			end
		end

		task.wait((math.max(n1 + 7.3 - workspace:GetServerTimeNow(), 0)))
		v32:Play()
		task.delay(0.5, function()
			v31:Stop()
		end)
	end))
end
function t1.OnStop(_)
	v25:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	local function updateScale()
		local v54 = Sammy:GetAttribute("ScaleAlpha") or 0
		local v55 = math.lerp(1, 2, v54)

		Sammy:PivotTo(Model.SammySpawnPosition:GetPivot())
		Spr.target(Model.SammyBelly.Upper.Motor, 0.8, 1.5, {
			C0 = CFrame.new(0, v55 * -0.454, v55 * 0.445),
			C1 = CFrame.new(0, 0, (1 - v54) * 0.445 * v55)
		})
		Spr.target(Model.SammyBelly.Bottom.Motor, 0.8, 1.5, {
			C0 = CFrame.new(0, v55 * 0.433, v55 * 0.951),
			C1 = CFrame.new(0, 0, (1 - v54) * 0.951 * v55)
		})
		Spr.target(Sammy, 0.8, 1.5, {
			Scale = v55
		})
		Spr.target(Model.SammyBelly, 0.8, 1.5, {
			Scale = math.lerp(0.45, 0.667, v54) * v55
		})

		for _, v57 in Model.SammyArms:GetChildren() do
			Spr.target(v57, 0.8, 1.5, {
				Scale = math.lerp(0.6, 1, v54) * v55
			})
		end
	end

	Sammy:GetAttributeChangedSignal("ScaleAlpha"):Connect(updateScale)
	task.spawn(updateScale)

	local u37 = false

	workspace.Events.FatSammy.Model.DeliveryHitbox.Touched:Connect(function(part)
		if part.Name ~= "HumanoidRootPart" then
			return
		end

		local player = Players:GetPlayerFromCharacter(part.Parent)

		if not player then
			return
		end

		if player ~= LocalPlayer then
			return
		end

		if ConfirmationController:IsInPrompt() or u37 or u24 then
			return
		end

		local StealingIndex = player:GetAttribute("StealingIndex")

		if not StealingIndex then
			return
		end

		u37 = true
		task.delay(0.5, function()
			u37 = false
		end)

		local Rarity = Animals[StealingIndex].Rarity

		if Animals2:GetRarityWeight(Rarity) >= 5 and not ConfirmationController:Show(`Are you sure you want to give this { Rarity } Brainrot to Sammy?`) then
			return
		end

		v18:FireServer()
	end)
end

return t1
