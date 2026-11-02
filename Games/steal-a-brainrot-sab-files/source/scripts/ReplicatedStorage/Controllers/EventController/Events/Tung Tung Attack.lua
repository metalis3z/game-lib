local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local Name = script.Name

local eventServiceTungTungAttackHit = Net:RemoteEvent("EventService/Tung Tung Attack/Hit")

local managedObj = Trove.new()

local val1 = {
	script.Tung1,
	script.Tung2
}


local function initBabyObserver()
	local rng = Random.new()

	managedObj:Add(Observers.observeTag("BabyTungTung", function(babyBox)
		local boxTrove = Trove.new()

		local rootPart = babyBox:WaitForChild("HumanoidRootPart")

		local visual = boxTrove:Clone(script.BabyTungTung)

		for _, child in ipairs(visual:GetChildren()) do
			if child:IsA("AnimationController") or child:IsA("Humanoid") then
				child:Destroy()
			end
		end

		local animController = Instance.new("AnimationController")
		animController.Name  = "AnimationController"
		animController.Parent = visual

		local animator = Instance.new("Animator")
		animator.Parent = animController

		local visualRoot = visual.PrimaryPart
		if visualRoot then
			local weld = boxTrove:Add(Instance.new("Weld"))
			weld.Part0  = visualRoot
			weld.Part1  = rootPart
			weld.C0     = CFrame.new()
			weld.Parent = visualRoot
		end

		visual.Parent = babyBox

		local walkTrack, idleTrack

		local walkAnim = visual:FindFirstChild("BabyTungWalk")
		local idleAnim = visual:FindFirstChild("BabyTungIdle")

		if not walkAnim or not idleAnim then
			local animFolder = ReplicatedStorage:FindFirstChild("Animations")
				and ReplicatedStorage.Animations:FindFirstChild("Animals")
				and ReplicatedStorage.Animations.Animals:FindFirstChild("Tung Tung Tung Sahur")
			if animFolder then
				walkAnim = walkAnim or animFolder:FindFirstChild("Walk")
				idleAnim = idleAnim or animFolder:FindFirstChild("Idle")
			end
		end

		if walkAnim and idleAnim then
			walkTrack          = animator:LoadAnimation(walkAnim)
			idleTrack          = animator:LoadAnimation(idleAnim)
			walkTrack.Looped   = true
			walkTrack.Priority = Enum.AnimationPriority.Movement
			idleTrack.Looped   = true
			idleTrack.Priority = Enum.AnimationPriority.Idle

			local function onRunningChanged()
				local running = babyBox:GetAttribute("IsRunning") or babyBox:GetAttribute("IsHunting")
				if running then
					idleTrack:Stop()
					walkTrack:Play()
					walkTrack:AdjustSpeed(1.5)
				else
					walkTrack:Stop()
					idleTrack:Play()
				end
			end

			boxTrove:Add(babyBox:GetAttributeChangedSignal("IsRunning"):Connect(onRunningChanged))
			boxTrove:Add(babyBox:GetAttributeChangedSignal("IsHunting"):Connect(onRunningChanged))

			onRunningChanged()

			boxTrove:Add(function()
				pcall(function() walkTrack:Stop(); walkTrack:Destroy() end)
				pcall(function() idleTrack:Stop(); idleTrack:Destroy() end)
			end)
		end

		local soundActive = true
		boxTrove:Add(task.spawn(function()
			while soundActive do
				local clip = val1[rng:NextInteger(1, #val1)]:Clone()
				clip.Parent = rootPart
				clip:Play()
				clip.Ended:Once(function()
					task.wait(0.1)
					clip:Destroy()
				end)
				task.wait(rng:NextNumber(2, 4))
			end
		end))

		return function()
			soundActive = false
			boxTrove:Destroy()
		end
	end))
end


data.OnStart = function(_)
	local l_v11_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v11_ActiveEventData_0)
	local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
	CycleController:Update()
	SoundController:UpdateOST()

	local managedObj_2 = script["Tung Tung Tung Sahur"]:Clone()
	local pivot = managedObj_2:GetPivot() - Vector3.new(0, 0, ServerData.IsBiggerServer() and 251 or 0)
	managedObj_2:PivotTo(pivot - Vector3.new(0, 40, 0, 0))
	managedObj_2.Parent = workspace
	local managedObj_3 = if ServerData.IsBiggerServer() then script.VFXBigger:Clone() else script.VFX:Clone()
	managedObj_3.Parent = workspace
	local tweenObj = managedObj_2.AnimationController.Animator:LoadAnimation(script.GiantTungTung)
	tweenObj.Looped   = false
	tweenObj.Priority = Enum.AnimationPriority.Action4
	tweenObj:Play(0)
	local tweenObj_2 = managedObj_2.AnimationController.Animator:LoadAnimation(script.GiantTungTungIdle)
	tweenObj_2.Looped   = true
	tweenObj_2.Priority = Enum.AnimationPriority.Idle
	tweenObj_2:Play(0)

	managedObj:Add(task.spawn(function()
		while tweenObj.Length == 0 do task.wait() end
		SoundController:PlaySound("Sounds.Events.Tung Tung Attack.BigTungTungSpawn")
		tweenObj:Stop(0)
		tweenObj.TimePosition = 0
		tweenObj:Play(0)
		managedObj:Add(TweenPivot(managedObj_2, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), pivot)):Play()
	end))

	managedObj:Add(function()
		TweenPivot(managedObj_2, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), pivot - Vector3.new(0, 40, 0)):Play()
		for _, descendant in managedObj_3:GetDescendants() do
			if descendant:IsA("ParticleEmitter") then descendant.Enabled = false end
		end
		task.wait(5)
		managedObj_3:Destroy()
		managedObj_2:Destroy()
		tweenObj_2:Stop(0); tweenObj_2:Destroy()
		tweenObj:Stop(0);   tweenObj:Destroy()
	end)

	initBabyObserver()

	if not ServerData.IsTsunamiServer() then
		local val4         = l_v11_ActiveEventData_0.startedAt + 10 - l_workspace_ServerTimeNow_0
		local managedObj_4 = script.Caves:Clone()
		local managedObj_5 = script.Caves2:Clone()

		for _, getPivotObj in {
			managedObj_4["1"], managedObj_4["2"], managedObj_4["3"],
			managedObj_5["4"], managedObj_5["5"], managedObj_5["6"]
			} do
			SoundController:PlaySound("Sounds.Events.Tung Tung Attack.Cave", getPivotObj:GetPivot().Position)
		end

		managedObj_4.Parent = workspace
		managedObj_5.Parent = workspace

		local l_v40_Pivot_0 = managedObj_4:GetPivot()
		local l_v41_Pivot_0 = managedObj_5:GetPivot()

		managedObj:Add(TweenPivot(managedObj_4, TweenInfo.new(val4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), l_v40_Pivot_0 * CFrame.new(0, 0, 6))):Play()
		managedObj:Add(TweenPivot(managedObj_5, TweenInfo.new(val4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), l_v41_Pivot_0 * CFrame.new(0, 0, 6))):Play()

		managedObj:Add(function()
			TweenPivot(managedObj_4, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), l_v40_Pivot_0):Play()
			TweenPivot(managedObj_5, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), l_v41_Pivot_0):Play()
			task.wait(5)
			managedObj_4:Destroy()
			managedObj_5:Destroy()
		end)

		managedObj:Add(task.delay(val4, function()
			for _, descendant_2 in managedObj_3.Cave:GetDescendants() do
				if descendant_2:IsA("ParticleEmitter") then descendant_2.Enabled = true end
			end
		end))
	end
end


data.OnStop = function(_)
	managedObj:Destroy()
end


data.OnLoad = function(_)
	eventServiceTungTungAttackHit.OnClientEvent:Connect(function(animalName)
		local target = nil

		for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
			if animal.Name == animalName then target = animal; break end
		end

		if not target then
			local folder = workspace:FindFirstChild("BabyTungTungs")
			if folder then target = folder:FindFirstChild(animalName) end
		end

		if target then
			ClientEventUtils.playBurst(script.TungTungHit, target)
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Tung Tung Attack"].Hit, target.PrimaryPart.Position)
		else
			warn("[TungTungAttackEvent] Could not find animal model for burst:", animalName)
		end
	end)
end

return data