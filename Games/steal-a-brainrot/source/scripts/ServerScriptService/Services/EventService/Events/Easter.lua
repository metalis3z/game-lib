local Easter = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)

local EVENT_NAME = script.Name
local trove = Trove.new()

function Easter.OnStart()
	assert(EventController:GetActiveEventData(EVENT_NAME))

	trove:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)
	local ServerScriptService = game:GetService("ServerScriptService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local AnimalService = require(ServerScriptService.Services.AnimalService)
	local Animals = require(ReplicatedStorage.Datas.Animals)

	local EASTER_BRAINROTS = {
		"Bunny Bunny Bunny Sahur",
		"Buntteo"
	}

	local function spawnRandomEasterBrainrot()
		local name = EASTER_BRAINROTS[math.random(1, #EASTER_BRAINROTS)]

		for _, data in pairs(Animals) do
			if data.DisplayName == name or data.Name == name then
				AnimalService.spawnAnimalCustom(data, nil, nil, nil, nil, nil)
				break
			end
		end
	end

	trove:Clone(script.Map).Parent = workspace

	trove:Add(Observers.observeTag("HideInEaster", function(obj)
		local p = obj.Parent
		obj.Parent = script
		return function()
			pcall(function()
				obj.Parent = p
			end)
		end
	end, { workspace, script }))

	EffectController:Run("EasterEvent", "GrassRecolor")
	trove:Add(function()
		EffectController:Stop("EasterEvent", "GrassRecolor")
	end)

	EffectController:Run("EasterEvent", "WallBottomRecolor")
	trove:Add(function()
		EffectController:Stop("EasterEvent", "WallBottomRecolor")
	end)

	trove:Add(Observers.observeTag("EasterEventBunny", function(part)
		local t = Trove.new()
		local parent = part.Parent

		local bunny = t:Clone(script.Bunny)
		bunny:ScaleTo(parent:GetAttribute("Scale") or 1)
		bunny.Parent = workspace

		local weld = Instance.new("Weld")
		weld.Part0 = bunny.PrimaryPart
		weld.Part1 = part
		weld.C0 = bunny.PrimaryPart.PivotOffset
		weld.Parent = bunny.PrimaryPart

		local animator = bunny.AnimationController.Animator

		local idle = animator:LoadAnimation(script.BunnyIdle)
		idle.Looped = true
		idle:Play()

		local run = animator:LoadAnimation(script.BunnyRun)
		run.Looped = true

		local attack = animator:LoadAnimation(script.BunnyAttack)

		t:Add(Observers.observeAttribute(parent, "Moving", function(v)
			if v then run:Play() else run:Stop() end
		end))

		local jumpTrove

		t:Add(Observers.observeAttribute(parent, "Jumping", function(v)
			if jumpTrove then
				jumpTrove:Destroy()
				jumpTrove = nil
			end

			if not v then
				attack:Stop()
				weld.Enabled = true
				if bunny.PrimaryPart then
					bunny.PrimaryPart.Anchored = false
				end
				return
			end

			run:Stop()
			attack:Play()

			local jt = Trove.new()
			jumpTrove = jt

			local target = parent:GetAttribute("JumpTarget")
			if not target then return end

			weld.Enabled = false
			bunny.PrimaryPart.Anchored = true

			local startPos = bunny:GetPivot().Position
			local endPos = ClientEventUtils.getAnimalCFrame(target, { top = true }).Position

			local elapsed = 0

			jt:Add(RunService.Heartbeat:Connect(function(dt)
				elapsed += dt
				local t = math.clamp(elapsed / 1.2, 0, 1)
				local pos = startPos:Lerp(endPos, t)
				bunny:PivotTo(CFrame.new(pos))

				if t >= 1 then
					ClientEventUtils.playBurst(script.Burst, target, {
						ReplicatedStorage.Sounds.Events.Easter.Hit
					})
					bunny:Destroy()
					jt:Destroy()
					jumpTrove = nil
				end
			end))
		end))

		return t:WrapClean()
	end, { workspace }))
end

function Easter.OnStop()
	trove:Destroy()
end

function Easter.OnLoad()
end

return Easter