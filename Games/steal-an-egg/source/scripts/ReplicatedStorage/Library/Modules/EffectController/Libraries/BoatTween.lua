-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local TweenFunctions = require(script.TweenFunctions)
local Lerps = require(script.Lerps)
local Heartbeat = RunService.Heartbeat
local t = {}
local t2 = {
	Heartbeat = true,
	Stepped = true,
	RenderStepped = true
}

if not RunService:IsClient() then
	t2.RenderStepped = nil
end

local t3 = {
	FabricAccelerate = {
		In = TweenFunctions.InFabricAccelerate,
		Out = TweenFunctions.OutFabricAccelerate,
		InOut = TweenFunctions.InOutFabricAccelerate,
		OutIn = TweenFunctions.OutInFabricAccelerate
	},
	UWPAccelerate = {
		In = TweenFunctions.InUWPAccelerate,
		Out = TweenFunctions.OutUWPAccelerate,
		InOut = TweenFunctions.InOutUWPAccelerate,
		OutIn = TweenFunctions.OutInUWPAccelerate
	},
	Circ = {
		In = TweenFunctions.InCirc,
		Out = TweenFunctions.OutCirc,
		InOut = TweenFunctions.InOutCirc,
		OutIn = TweenFunctions.OutInCirc
	},
	RevBack = {
		In = TweenFunctions.InRevBack,
		Out = TweenFunctions.OutRevBack,
		InOut = TweenFunctions.InOutRevBack,
		OutIn = TweenFunctions.OutInRevBack
	},
	Spring = {
		In = TweenFunctions.InSpring,
		Out = TweenFunctions.OutSpring,
		InOut = TweenFunctions.InOutSpring,
		OutIn = TweenFunctions.OutInSpring
	},
	Standard = {
		In = TweenFunctions.InStandard,
		Out = TweenFunctions.OutStandard,
		InOut = TweenFunctions.InOutStandard,
		OutIn = TweenFunctions.OutInStandard
	},
	StandardExpressive = {
		In = TweenFunctions.InStandardExpressive,
		Out = TweenFunctions.OutStandardExpressive,
		InOut = TweenFunctions.InOutStandardExpressive,
		OutIn = TweenFunctions.OutInStandardExpressive
	},
	Linear = {
		In = TweenFunctions.InLinear,
		Out = TweenFunctions.OutLinear,
		InOut = TweenFunctions.InOutLinear,
		OutIn = TweenFunctions.OutInLinear
	},
	ExitProductive = {
		In = TweenFunctions.InExitProductive,
		Out = TweenFunctions.OutExitProductive,
		InOut = TweenFunctions.InOutExitProductive,
		OutIn = TweenFunctions.OutInExitProductive
	},
	Deceleration = {
		In = TweenFunctions.InDeceleration,
		Out = TweenFunctions.OutDeceleration,
		InOut = TweenFunctions.InOutDeceleration,
		OutIn = TweenFunctions.OutInDeceleration
	},
	Smoother = {
		In = TweenFunctions.InSmoother,
		Out = TweenFunctions.OutSmoother,
		InOut = TweenFunctions.InOutSmoother,
		OutIn = TweenFunctions.OutInSmoother
	},
	FabricStandard = {
		In = TweenFunctions.InFabricStandard,
		Out = TweenFunctions.OutFabricStandard,
		InOut = TweenFunctions.InOutFabricStandard,
		OutIn = TweenFunctions.OutInFabricStandard
	},
	RidiculousWiggle = {
		In = TweenFunctions.InRidiculousWiggle,
		Out = TweenFunctions.OutRidiculousWiggle,
		InOut = TweenFunctions.InOutRidiculousWiggle,
		OutIn = TweenFunctions.OutInRidiculousWiggle
	},
	MozillaCurve = {
		In = TweenFunctions.InMozillaCurve,
		Out = TweenFunctions.OutMozillaCurve,
		InOut = TweenFunctions.InOutMozillaCurve,
		OutIn = TweenFunctions.OutInMozillaCurve
	},
	Expo = {
		In = TweenFunctions.InExpo,
		Out = TweenFunctions.OutExpo,
		InOut = TweenFunctions.InOutExpo,
		OutIn = TweenFunctions.OutInExpo
	},
	Sine = {
		In = TweenFunctions.InSine,
		Out = TweenFunctions.OutSine,
		InOut = TweenFunctions.InOutSine,
		OutIn = TweenFunctions.OutInSine
	},
	Cubic = {
		In = TweenFunctions.InCubic,
		Out = TweenFunctions.OutCubic,
		InOut = TweenFunctions.InOutCubic,
		OutIn = TweenFunctions.OutInCubic
	},
	EntranceExpressive = {
		In = TweenFunctions.InEntranceExpressive,
		Out = TweenFunctions.OutEntranceExpressive,
		InOut = TweenFunctions.InOutEntranceExpressive,
		OutIn = TweenFunctions.OutInEntranceExpressive
	},
	Elastic = {
		In = TweenFunctions.InElastic,
		Out = TweenFunctions.OutElastic,
		InOut = TweenFunctions.InOutElastic,
		OutIn = TweenFunctions.OutInElastic
	},
	Quint = {
		In = TweenFunctions.InQuint,
		Out = TweenFunctions.OutQuint,
		InOut = TweenFunctions.InOutQuint,
		OutIn = TweenFunctions.OutInQuint
	},
	EntranceProductive = {
		In = TweenFunctions.InEntranceProductive,
		Out = TweenFunctions.OutEntranceProductive,
		InOut = TweenFunctions.InOutEntranceProductive,
		OutIn = TweenFunctions.OutInEntranceProductive
	},
	Bounce = {
		In = TweenFunctions.InBounce,
		Out = TweenFunctions.OutBounce,
		InOut = TweenFunctions.InOutBounce,
		OutIn = TweenFunctions.OutInBounce
	},
	Smooth = {
		In = TweenFunctions.InSmooth,
		Out = TweenFunctions.OutSmooth,
		InOut = TweenFunctions.InOutSmooth,
		OutIn = TweenFunctions.OutInSmooth
	},
	Back = {
		In = TweenFunctions.InBack,
		Out = TweenFunctions.OutBack,
		InOut = TweenFunctions.InOutBack,
		OutIn = TweenFunctions.OutInBack
	},
	Quart = {
		In = TweenFunctions.InQuart,
		Out = TweenFunctions.OutQuart,
		InOut = TweenFunctions.InOutQuart,
		OutIn = TweenFunctions.OutInQuart
	},
	StandardProductive = {
		In = TweenFunctions.InStandardProductive,
		Out = TweenFunctions.OutStandardProductive,
		InOut = TweenFunctions.InOutStandardProductive,
		OutIn = TweenFunctions.OutInStandardProductive
	},
	Quad = {
		In = TweenFunctions.InQuad,
		Out = TweenFunctions.OutQuad,
		InOut = TweenFunctions.InOutQuad,
		OutIn = TweenFunctions.OutInQuad
	},
	FabricDecelerate = {
		In = TweenFunctions.InFabricDecelerate,
		Out = TweenFunctions.OutFabricDecelerate,
		InOut = TweenFunctions.InOutFabricDecelerate,
		OutIn = TweenFunctions.OutInFabricDecelerate
	},
	Acceleration = {
		In = TweenFunctions.InAcceleration,
		Out = TweenFunctions.OutAcceleration,
		InOut = TweenFunctions.InOutAcceleration,
		OutIn = TweenFunctions.OutInAcceleration
	},
	SoftSpring = {
		In = TweenFunctions.InSoftSpring,
		Out = TweenFunctions.OutSoftSpring,
		InOut = TweenFunctions.InOutSoftSpring,
		OutIn = TweenFunctions.OutInSoftSpring
	},
	ExitExpressive = {
		In = TweenFunctions.InExitExpressive,
		Out = TweenFunctions.OutExitExpressive,
		InOut = TweenFunctions.InOutExitExpressive,
		OutIn = TweenFunctions.OutInExitExpressive
	},
	Sharp = {
		In = TweenFunctions.InSharp,
		Out = TweenFunctions.OutSharp,
		InOut = TweenFunctions.InOutSharp,
		OutIn = TweenFunctions.OutInSharp
	}
}

local function Wait(p1) --[[ Wait | Line: 333 | Upvalues: Heartbeat (copy) ]]
	local sum = math.max(p1 or 0.03, 0)
	local v1 = sum

	while sum > 0 do
		sum = sum - Heartbeat:Wait()
	end

	return v1 - sum
end

function t.Create(p1, p2, p3) --[[ Create | Line: 344 | Upvalues: t2 (copy), RunService (copy), t3 (copy), Lerps (copy), Wait (copy) ]]
	if p2 and typeof(p2) == "Instance" then
		local v2 = if type(p3) == "table" then p3 or {} else {}
		local v3 = t2[v2.StepType] and RunService[v2.StepType] or RunService.Stepped
		local v4 = t3[v2.EasingStyle or "Quad"][v2.EasingDirection or "In"]
		local Time = v2.Time
		local v5 = type(Time) == "number" and v2.Time or 1
		local v6 = math.max(v5, 0.001)
		local Goal = v2.Goal
		local v7 = type(Goal) == "table" and v2.Goal or {}
		local DelayTime = v2.DelayTime
		local v8 = if type(DelayTime) == "number" and v2.DelayTime > 0.027 then v2.DelayTime else false
		local RepeatCount = v2.RepeatCount
		local v9 = type(RepeatCount) == "number" and math.max(v2.RepeatCount, -1) or 0
		local t = {}
		local v10 = v9 + 1

		for k, v in pairs(v7) do
			t[k] = Lerps[typeof(v)](p2[k], v)
		end

		local v11 = Instance.new("BindableEvent")
		local v12 = Instance.new("BindableEvent")
		local v13 = Instance.new("BindableEvent")
		local v14 = nil
		local v15 = os.clock()
		local v16 = 0
		local t4 = {
			Instance = p2,
			PlaybackState = Enum.PlaybackState.Begin,
			Completed = v11.Event,
			Resumed = v13.Event,
			Stopped = v12.Event
		}

		function t4.Destroy() --[[ Destroy | Line: 382 | Upvalues: v14 (ref), v11 (copy), v12 (copy), v13 (copy), t4 (ref) ]]
			if v14 then
				v14:Disconnect()
				v14 = nil
			end

			v11:Destroy()
			v12:Destroy()
			v13:Destroy()
			t4 = nil
		end

		local v17 = false
		local v18 = 0

		local function v19(p1, p22) --[[ Play | Line: 397 | Upvalues: v14 (ref), v10 (copy), t4 (ref), v11 (copy), v17 (ref), v18 (ref), v8 (copy), Wait (ref), v15 (ref), v16 (ref), v3 (copy), v6 (copy), t (copy), p2 (copy), v19 (copy), v2 (ref), v4 (copy) ]]
			if v14 then
				v14:Disconnect()
				v14 = nil
			end

			local v1 = p1 or 1

			if v10 ~= 0 and v10 < v1 then
				t4.PlaybackState = Enum.PlaybackState.Completed
				v11:Fire()
				v17 = false
				v18 = 1

				return
			end

			v18 = v1

			if p22 then
				v17 = true
			end

			if v8 then
				t4.PlaybackState = Enum.PlaybackState.Delayed;
				(v8 < 2 and Wait or wait)(v8)
			end

			v15 = os.clock() - v16
			v14 = v3:Connect(function() --[[ Line: 426 | Upvalues: v16 (ref), v15 (ref), v6 (ref), p22 (copy), t (ref), p2 (ref), v14 (ref), v19 (ref), v1 (ref), v2 (ref), v4 (ref) ]]
				v16 = os.clock() - v15

				if v6 <= v16 then
					if p22 then
						for k, v in pairs(t) do
							p2[k] = v(0)
						end
					else
						for k, v in pairs(t) do
							p2[k] = v(1)
						end
					end

					v14:Disconnect()
					v14 = nil

					if p22 then
						v16 = 0
						v19(v1 + 1, false)

						return
					end

					if v2.Reverses then
						v16 = 0
						v19(v1, true)
					else
						v16 = 0
						v19(v1 + 1, false)
					end
				else
					local v3 = math.clamp(v4(p22 and 1 - v16 / v6 or v16 / v6), 0, 1)

					for k, v in pairs(t) do
						p2[k] = v(v3)
					end
				end
			end)
			t4.PlaybackState = Enum.PlaybackState.Playing
		end

		function t4.Play() --[[ Play | Line: 466 | Upvalues: v16 (ref), v19 (copy) ]]
			v16 = 0
			v19(1, false)
		end
		function t4.Stop() --[[ Stop | Line: 471 | Upvalues: v14 (ref), t4 (ref), v12 (copy) ]]
			if not v14 then
				return
			end

			v14:Disconnect()
			v14 = nil
			t4.PlaybackState = Enum.PlaybackState.Cancelled
			v12:Fire()
		end
		function t4.Resume() --[[ Resume | Line: 480 | Upvalues: v19 (copy), v18 (ref), v17 (ref), v13 (copy) ]]
			v19(v18, v17)
			v13:Fire()
		end

		return t4
	end

	return warn("Invalid object to tween:", p2)
end

return t