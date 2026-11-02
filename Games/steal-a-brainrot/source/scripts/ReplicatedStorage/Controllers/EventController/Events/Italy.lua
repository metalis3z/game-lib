local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")

require(v_u_1.Shared.EventTypes)

local v6 = {}

local v_u_7 = require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.EventController)
local v_u_12 = require(v_u_1.Controllers.CycleController)

require(v_u_1.Shared.SharedEventUtils)

local v_u_13 = require(v_u_1.Packages.CreateTween)
local v_u_14 = require(v_u_1.Shared.TweenPivot)
local v_u_15 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)

local v_u_16 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)

local v17 = require(v_u_1.Packages.Net)
local v_u_18 = require(v_u_1.Shared.VFX)

local v_u_19 = workspace.Sounds.FranceEvent
local v_u_20 = script.Name
local v_u_21 = v17:RemoteEvent(("EventService/%*/Burst"):format(v_u_20))

local v_u_22 = v_u_16.new()

function v6.OnStart()
	local v_u_23 = v_u_11:GetActiveEventData(v_u_20)
	if not v_u_23 then
		return
	end

	v_u_22:Add(function()
		v_u_9:Activate("Blink")
		v_u_12:Update()
		v_u_10:UpdateOST()
	end)

	local v_u_24 = v_u_22:Clone(script.Map)
	v_u_24.Parent = workspace

	v_u_22:Add(v_u_15.observeTag("HideInFrance", function(p)
		local oldParent = p.Parent
		p.Parent = script
		return function()
			pcall(function()
				p.Parent = oldParent
			end)
		end
	end, { workspace, script }))

	v_u_9:Activate("Blink")
	v_u_12:Update()
	v_u_10:UpdateOST()

	v_u_9:Run("FranceEvent", "GrassRecolor")
	v_u_9:Run("FranceEvent", "WallRecolor")
	v_u_9:Run("FranceEvent", "WallBottomRecolor")

	v_u_22:Add(function()
		v_u_9:Stop("FranceEvent", "GrassRecolor")
		v_u_9:Stop("FranceEvent", "WallRecolor")
		v_u_9:Stop("FranceEvent", "WallBottomRecolor")
	end)

	v_u_18.enable(v_u_24.MapVFX.Waterfall)

	local v_u_27 = v_u_23.startedAt + 13 - workspace:GetServerTimeNow()

	task.spawn(function()
		if v_u_27 > 10 then
			v_u_10:PlaySound(
				v_u_1.Sounds.Events.France.Activating,
				v_u_24.MapVFX.Waterfall.francewaterfall.Position,
				false
			)
		end
	end)

	local floodPivot = v_u_24.Flood:GetPivot()
	v_u_24.Flood:PivotTo(floodPivot - Vector3.new(0, 3, 0))

	v_u_22:Add(
		v_u_14(
			v_u_24.Flood,
			TweenInfo.new(v_u_27, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
			floodPivot
		)
	):Play()

	v_u_22:Add(task.delay(
		v_u_23.startedAt + 87.79 - workspace:GetServerTimeNow(),
		function()
			v_u_1:SetAttribute("FranceEventPart2", true)
			v_u_12:Update()
			v_u_10:UpdateOST()

			v_u_22:Add(function()
				v_u_1:SetAttribute("FranceEventPart2", nil)
				v_u_12:Update()
				v_u_10:UpdateOST()
			end)
		end
		))

	v_u_22:Add(task.delay(v_u_27, function()
		v_u_18.disable(v_u_24.MapVFX.Waterfall)
		v_u_1:SetAttribute("FranceEventAmbience", true)

		v_u_22:Add(function()
			v_u_1:SetAttribute("FranceEventAmbience", nil)
		end)
	end))

	v_u_22:Add(task.spawn(function()
		v_u_19.Volume = 0
		v_u_13(v_u_19, TweenInfo.new(3), { Volume = 0.35 })

		v_u_7:WaitForAssetId("rbxassetid://86272363718966")
		v_u_19.SoundId = "rbxassetid://86272363718966"

		while not v_u_19.IsLoaded do
			task.wait()
		end

		v_u_19.TimePosition = 62 + (workspace:GetServerTimeNow() - v_u_23.startedAt)
		v_u_19:Play()

		v_u_22:Add(function()
			v_u_19:Stop()
		end)
	end))
end

function v6.OnStop()
	v_u_22:Destroy()
end

function v6.OnLoad()
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)

	task.spawn(function()
		v_u_7:WaitForAssetId("rbxassetid://86272363718966")
		v_u_19.SoundId = "rbxassetid://86272363718966"
		v_u_2:PreloadAsync({ v_u_19 })
	end)

	v_u_15.observeTag("FranceCanoe", function(p)
		local trove = v_u_16.new()
		local canoe = trove:Clone(script.Canoe)
		canoe.Parent = p

		local weld = Instance.new("Weld")
		weld.Part0 = canoe.PrimaryPart
		weld.Part1 = p
		weld.C0 = CFrame.Angles(0, math.pi, 0)
		weld.Parent = canoe.PrimaryPart

		return trove:WrapClean()
	end, { workspace })

	v_u_21.OnClientEvent:Connect(function(id)
		local animal = v_u_8:GetAnimals()[id]
		if not animal then return end

		local model = animal.AnimalModel
		if not model or not model.PrimaryPart then return end

		local burst = v_u_22:Clone(script.Burst)
		burst:PivotTo(model.PrimaryPart.CFrame)
		burst.Parent = model

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = burst
		weld.Part1 = model.PrimaryPart
		weld.Parent = burst

		v_u_18.emit(burst)
		v_u_5:AddItem(burst, 5)

		v_u_10:PlaySound(
			v_u_1.Sounds.Events.France.BrainrotHit,
			model.PrimaryPart.Position,
			false
		)
	end)
end

return v6