
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Net = require(ReplicatedStorage.Packages.Net)
local scriptName = script.Name
local v14 = Net:RemoteEvent("EventService/Laser City/Burst")
local v15 = Trove.new()
local v16 = Shake.new()

v16.Frequency = 0.25
v16.Amplitude = 0.2
v16.FadeInTime = 0.1
v16.FadeOutTime = 0.2
v16.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
v16.RotationInfluence = Vector3.new(1, 1, 1)

local v17 = Shake.new()

v17.Frequency = 0.06666666666666667
v17.Amplitude = 0.04
v17.Sustain = true
v17.PositionInfluence = Vector3.new(0.75, 0.75, 0.75)
v17.RotationInfluence = Vector3.new(1.25, 0.25, 0.25)

function t1.OnStart(_)
	assert((EventController:GetActiveEventData(scriptName)))
	EffectController:Activate("Blink")
	v15:Add(function()
		EffectController:Activate("Blink")
	end)

	local Sky = Lighting:FindFirstChildOfClass("Sky")

	if Sky then
		Sky.Parent = script
		v15:Add(function()
			Sky.Parent = Lighting
		end)
	end

	local LaserCitySky = script:FindFirstChild("LaserCitySky")

	if LaserCitySky then
		v15:Clone(LaserCitySky).Parent = Lighting
	end

	local Burst = script:FindFirstChild("Burst")

	if Burst and Burst:IsA("BasePart") then
		v15:Add(v14.OnClientEvent:Connect(function(s1: string)
			ClientEventUtils.playBurst(Burst, s1, { ReplicatedStorage.Sounds.Events["Laser City"].BeamDirectHit })
		end))
	end

	local u22 = nil

	v15:Add(RunService.Heartbeat:Connect(function()
		if not u22 then
			return
		end

		local CurrentCamera = workspace.CurrentCamera

		if CurrentCamera then
			CurrentCamera.CFrame = u22
		end

		u22 = nil
	end))
	ReplicatedStorage:SetAttribute("LaserCityEvent", true)
	SoundController:UpdateOST()
	EffectController:Run("LaserCityEvent", "GrassRecolor")
	EffectController:Run("LaserCityEvent", "WallRecolor")
	EffectController:Run("LaserCityEvent", "WallBottomRecolor")
	v15:Add(function()
		ReplicatedStorage:SetAttribute("LaserCityEvent", nil)
		SoundController:UpdateOST()
		EffectController:Stop("LaserCityEvent", "GrassRecolor")
		EffectController:Stop("LaserCityEvent", "WallRecolor")
		EffectController:Stop("LaserCityEvent", "WallBottomRecolor")
	end)

	local _script = script
	local clone = v15:Clone(_script.LaserCityMap)

	clone.Parent = workspace

	local LaserCaylus = clone.LaserCaylus
	local Caylus = LaserCaylus:FindFirstChild("Caylus")
	local v27 = Caylus and Caylus:FindFirstChildWhichIsA("Animator", true)

	if v27 then
		local track = v27:LoadAnimation(_script.CaylusAnimation)

		v15:Add(track, "Stop")
		v15:Add(track)
		track:Play()
	end

	local v29 = Caylus and Caylus:FindFirstChild("UpperTorso", true)
	local v30 = Caylus and Caylus:FindFirstChild("Head", true)
	local v31 = Caylus and Caylus:FindFirstChild("Waist", true)
	local v32 = Caylus and Caylus:FindFirstChild("Neck", true)
	local v33 = if not v31 or not v31:IsA("Motor6D") then nil else v31.C0
	local v34 = if not v32 or not v32:IsA("Motor6D") then nil else v32.C0

	v15:Add(function()
		if v31 and (v31:IsA("Motor6D") and v33) then
			v31.C0 = v33
		end

		if v32 and v32:IsA("Motor6D") and v34 then
			v32.C0 = v34
		end
	end)

	local Impact = LaserCaylus.Impact
	local Pivot = Impact:GetPivot()

	Impact.BeamEffect:Play()
	v15:Add(Observers.observeTag("LaserCityImpact", function(p2)
		local v42 = v15:Extend()

		v42:AttachToInstance(p2)

		local v43 = v42:Add(v16:Clone())

		v43:Start()
		v43:BindToRenderStep(Shake.NextRenderName(), Enum.RenderPriority.Camera.Value + 1, function(p3, p4)
			local CurrentCamera = workspace.CurrentCamera

			if not CurrentCamera then
				return
			end

			if not u22 then
				u22 = CurrentCamera.CFrame
			end

			CurrentCamera.CFrame = CurrentCamera.CFrame * (CFrame.new(p3) * CFrame.Angles(p4.X, p4.Y, p4.Z))
		end)

		local v44 = v42:Add(v17:Clone())

		v44:Start()
		v44:BindToRenderStep(Shake.NextRenderName(), Enum.RenderPriority.Camera.Value + 1, function()
			local CurrentCamera = workspace.CurrentCamera

			if not CurrentCamera then
				return
			end

			local v52, v53 = v44:Update()
			local v54 = math.clamp(1 - math.max(0, (CurrentCamera.CFrame.Position - p2.Position).Magnitude - 25) / 75, 0, 1)
			local v55 = v54 * v54

			if v55 < 0.01 then
				return
			end

			if not u22 then
				u22 = CurrentCamera.CFrame
			end

			local v56 = v52 * v55
			local v57 = v53 * v55

			CurrentCamera.CFrame = CurrentCamera.CFrame * (CFrame.new(v56) * CFrame.Angles(v57.X, v57.Y, v57.Z))
		end)

		local connection = RunService.PostSimulation:Connect(function()
			Impact:PivotTo(p2:GetPivot())

			local p2Position = p2.Position

			if v31 and (v31:IsA("Motor6D") and v29 and v29:IsA("BasePart") and v33) then
				local v59 = v29.CFrame:VectorToObjectSpace((p2Position - v29.Position).Unit)
				local v60 = math.clamp(math.atan2(-v59.X, -v59.Z), -0.6108652381980153, 0.6108652381980153)
				local v61 = math.clamp(math.asin(v59.Y), -0.3490658503988659, 0.3490658503988659)

				v31.C0 = v31.C0:Lerp(v33 * CFrame.Angles(v61 * 0.35, v60 * 0.55, 0), 0.15)
			end

			if v32 and v32:IsA("Motor6D") and v30 and v30:IsA("BasePart") and v34 then
				local v62 = v30.CFrame:VectorToObjectSpace((p2Position - v30.Position).Unit)
				local v63 = math.clamp(math.atan2(-v62.X, -v62.Z), -1.3089969389957472, 1.3089969389957472)
				local v64 = math.clamp(math.asin(v62.Y), -0.7853981633974483, 0.7853981633974483)

				v32.C0 = v32.C0:Lerp(v34 * CFrame.Angles(v64 * 0.9, v63, 0), 0.15)
			end
		end)

		return function()
			connection:Disconnect()
			v42:Destroy()
			Impact:PivotTo(Pivot)

			if v31 and (v31:IsA("Motor6D") and v33) then
				v31.C0 = v33
			end

			if v32 and v32:IsA("Motor6D") and v34 then
				v32.C0 = v34
			end
		end
	end, { workspace }))
	v15:Add(Observers.observeTag("HideInLaserCity", function(p5)
		local p5Parent = p5.Parent

		p5.Parent = script

		return function()
			pcall(function()
				p5.Parent = p5Parent
			end)
		end
	end, {
		workspace,
		script
	}))
end
function t1.OnStop(_)
	v15:Destroy()
end
function t1.OnLoad(_)
end

return t1
