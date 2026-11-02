-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local v2 = assert(script.Parent, "Animate script has no parent!")
local v4 = assert(if v2:IsA("Model") then v2 else nil, "Parent of Animate must be a Model!")
local Humanoid = v4:FindFirstChildOfClass("Humanoid")
local v5 = assert(Humanoid, "No Humanoid found for the Animate script to use!")
local Animator = v5:FindFirstChildOfClass("Animator")

if not Animator and RunService:IsServer() then
	Animator = Instance.new("Animator")
	assert(Animator).Parent = v5
elseif not Animator then
	Animator = v5
end

local v6 = OverlapParams.new()

v6.FilterDescendantsInstances = { v4 }
v6.MaxParts = 5

local t = {
	Animations = {},
	Defaults = {},
	Emotes = {},
	Callbacks = {},
	DidLoop = {},
	LocomotionMap = {},
	Emotes = {
		wave = false,
		point = false,
		dance = true,
		dance2 = true,
		dance3 = true,
		laugh = false,
		cheer = false
	},
	Defaults = {
		idle = {
			{
				Id = "rbxassetid://507766666",
				Weight = 1
			},
			{
				Id = "rbxassetid://507766951",
				Weight = 1
			},
			{
				Id = "rbxassetid://507766388",
				Weight = 9
			}
		},
		walk = {
			{
				Id = "rbxassetid://507777826",
				Weight = 10
			}
		},
		run = {
			{
				Id = "rbxassetid://507767714",
				Weight = 10
			}
		},
		swim = {
			{
				Id = "rbxassetid://507784897",
				Weight = 10
			}
		},
		swimidle = {
			{
				Id = "rbxassetid://507785072",
				Weight = 10
			}
		},
		jump = {
			{
				Id = "rbxassetid://507765000",
				Weight = 10
			}
		},
		fall = {
			{
				Id = "rbxassetid://507767968",
				Weight = 10
			}
		},
		climb = {
			{
				Id = "rbxassetid://507765644",
				Weight = 10
			}
		},
		sit = {
			{
				Id = "rbxassetid://2506281703",
				Weight = 10
			}
		},
		toolnone = {
			{
				Id = "rbxassetid://507768375",
				Weight = 10
			}
		},
		toolslash = {
			{
				Id = "rbxassetid://522635514",
				Weight = 10
			}
		},
		toollunge = {
			{
				Id = "rbxassetid://522638767",
				Weight = 10
			}
		},
		wave = {
			{
				Id = "rbxassetid://507770239",
				Weight = 10
			}
		},
		point = {
			{
				Id = "rbxassetid://507770453",
				Weight = 10
			}
		},
		dance = {
			{
				Id = "rbxassetid://507771019",
				Weight = 10
			},
			{
				Id = "rbxassetid://507771955",
				Weight = 10
			},
			{
				Id = "rbxassetid://507772104",
				Weight = 10
			}
		},
		dance2 = {
			{
				Id = "rbxassetid://507776043",
				Weight = 10
			},
			{
				Id = "rbxassetid://507776720",
				Weight = 10
			},
			{
				Id = "rbxassetid://507776879",
				Weight = 10
			}
		},
		dance3 = {
			{
				Id = "rbxassetid://507777268",
				Weight = 10
			},
			{
				Id = "rbxassetid://507777451",
				Weight = 10
			},
			{
				Id = "rbxassetid://507777623",
				Weight = 10
			}
		},
		laugh = {
			{
				Id = "rbxassetid://507770818",
				Weight = 10
			}
		},
		cheer = {
			{
				Id = "rbxassetid://507770677",
				Weight = 10
			}
		}
	},
	LocomotionMap = {
		run = {
			Speed = 12.8,
			Velocity = Vector2.yAxis * 12.8
		},
		walk = {
			Speed = 6.4,
			Velocity = Vector2.yAxis * 6.4
		}
	}
}

local function newAnimSet() --[[ newAnimSet | Line: 209 ]]
	return {
		TotalWeight = 0
	}
end

local function signedAngle(p1, p2) --[[ signedAngle | Line: 213 ]]
	return -math.atan2(p1.X * p2.Y - p1.Y * p2.X, p1.X * p2.X + p1.Y * p2.Y)
end

local function registerCallback(p1, p2) --[[ registerCallback | Line: 217 | Upvalues: t (copy) ]]
	t.Callbacks[p1] = p2
end

local function getTrackController(p1) --[[ getTrackController | Line: 221 | Upvalues: t (copy) ]]
	return assert(t.Animations[p1], "Unknown animation name: " .. tostring(p1))
end

local function getNumber(p1, p2) --[[ getNumber | Line: 226 ]]
	local v1 = p1:FindFirstChild(p2)

	if v1 and v1:IsA("NumberValue") then
		return v1.Value
	end

	local v2 = p1:GetAttribute(p2)

	if typeof(v2) == "number" then
		return v2
	end

	return nil
end

local function getHeightScale() --[[ getHeightScale | Line: 242 | Upvalues: v5 (copy) ]]
	if not v5.AutomaticScalingEnabled then
		return 1
	end

	local v1 = script
	local ScaleDampeningPercent = v1:FindFirstChild("ScaleDampeningPercent")
	local v2

	if ScaleDampeningPercent and ScaleDampeningPercent:IsA("NumberValue") then
		v2 = ScaleDampeningPercent.Value
	else
		local v3 = v1:GetAttribute("ScaleDampeningPercent")

		v2 = if typeof(v3) == "number" then v3 else nil
	end

	if v2 then
		return 1 + (v5.HipHeight - 2) * v2 / 2
	end

	return v5.HipHeight / 2
end

local function getTimePosition(p1) --[[ getTimePosition | Line: 256 ]]
	local ActiveTrack = p1.ActiveTrack

	if ActiveTrack and (ActiveTrack.IsPlaying and ActiveTrack.WeightTarget > 0.0001) then
		return ActiveTrack.TimePosition
	end
end

local function loadAnimation(p1) --[[ loadAnimation | Line: 266 | Upvalues: v5 (copy), Animator (ref), t (copy) ]]
	if not p1.Track then
		local Animation = p1.Animation

		if Animation == nil then
			local Animation2 = Instance.new("Animation")

			assert(Animation2)
			Animation2.AnimationId = assert(p1.Id)
			p1.Animation = Animation2
			Animation = Animation2
		end

		local v2 = (if script:GetAttribute("DebugHumanoidLoadAnimation") then v5 else Animator):LoadAnimation(assert(Animation))

		v2.Priority = Enum.AnimationPriority.Core
		v2.DidLoop:Connect(function() --[[ Line: 289 | Upvalues: t (ref), v2 (copy) ]]
			t.DidLoop[v2] = true
		end)
		p1.Track = v2
	end

	return assert(p1.Track)
end

local function getAnimSetForAnimation(p1) --[[ getAnimSetForAnimation | Line: 299 | Upvalues: t (copy) ]]
	local v1 = p1.Parent

	if not (v1 and v1:IsA("StringValue")) then
		return
	end

	if v1.Parent ~= script then
		return
	end

	local v2 = v1.Name
	local v3 = t.Animations[v2]

	if not v3 then
		local t2 = {
			DefaultSet = {
				TotalWeight = 0
			},
			CustomSet = {
				TotalWeight = 0
			}
		}

		t.Animations[v2] = t2
		v3 = t2
	end

	return v3.CustomSet, v2
end

local function rollAnimation(p1) --[[ rollAnimation | Line: 325 | Upvalues: loadAnimation (copy) ]]
	local v1 = if #p1.CustomSet == 0 then p1.DefaultSet else p1.CustomSet

	if #v1 == 1 then
		return loadAnimation(v1[1]), false
	end

	if #v1 == 0 then
		return nil, nil
	end

	local v2 = assert(v1.TotalWeight)
	local v3 = math.random() * v2
	local v4 = 0
	local v5 = 1

	while v4 < v2 do
		local v7 = assert(v1[v5])
		local v8 = v4 + v7.Weight

		if v4 <= v3 and v3 < v8 then
			return loadAnimation(v7), true
		end

		v4, v5 = v8, v5 + 1
	end

	return nil, nil
end

local function canEmote() --[[ canEmote | Line: 356 | Upvalues: v5 (copy) ]]
	local v1 = v5:GetState()

	if v5.MoveDirection == Vector3.new(0, 0, 0) then
		return v1 == Enum.HumanoidStateType.Running
	end

	return false
end

local function checkAnimationAdded(p1) --[[ checkAnimationAdded | Line: 375 | Upvalues: getAnimSetForAnimation (copy), loadAnimation (copy), t (copy) ]]
	if not p1:IsA("Animation") then
		return
	end

	local v1, v2 = getAnimSetForAnimation(p1)

	if not v1 then
		return
	end

	local v3 = p1:GetAttribute("LinearVelocity")
	local Weight = p1:FindFirstChild("Weight")
	local v4

	if Weight and Weight:IsA("NumberValue") then
		v4 = Weight.Value
	else
		local v5 = p1:GetAttribute("Weight")

		v4 = if typeof(v5) == "number" then v5 else nil
	end

	local v6 = v4 or 1
	local t2 = {
		Id = p1.AnimationId,
		Animation = p1,
		Weight = v6
	}

	v1.TotalWeight = v1.TotalWeight + v6
	loadAnimation(t2)

	if v2 and typeof(v3) == "Vector2" then
		t.LocomotionMap[v2] = {
			Velocity = v3,
			Speed = v3.Magnitude
		}
	end

	table.insert(v1, t2)
end

local function checkAnimationRemoving(p1) --[[ checkAnimationRemoving | Line: 404 | Upvalues: getAnimSetForAnimation (copy) ]]
	if not p1:IsA("Animation") then
		return
	end

	local v1 = getAnimSetForAnimation(p1)

	if not v1 then
		return
	end

	local v2 = nil

	for i, v in ipairs(v1) do
		if v.Animation == p1 then
			v1.TotalWeight = v1.TotalWeight - v.Weight
			v2 = i

			break
		end
	end

	if not v2 then
		return
	end

	table.remove(v1, v2)
end

for v7, v8 in t.Defaults do
	local t2 = {
		TotalWeight = 0
	}

	for v9, v10 in v8 do
		t2.TotalWeight = t2.TotalWeight + v10.Weight
		table.insert(t2, v10)
		loadAnimation(v10)
	end

	t.Animations[v7] = {
		DefaultSet = t2,
		CustomSet = {
			TotalWeight = 0
		}
	}
end

for v11, v12 in script:GetDescendants() do
	checkAnimationAdded(v12)
end

script.DescendantAdded:Connect(checkAnimationAdded)
script.DescendantRemoving:Connect(checkAnimationRemoving)

local v13 = nil
local v14 = nil
local v15 = 0
local v16 = 0

local function onJumping() --[[ onJumping | Line: 463 | Upvalues: v15 (ref) ]]
	v15 = os.clock() + 0.4
end

local function onFreefall() --[[ onFreefall | Line: 467 | Upvalues: v15 (ref), t (copy) ]]
	local v1 = if os.clock() < v15 then assert(t.Animations.jump, "Unknown animation name: " .. tostring("jump")) else assert(t.Animations.fall, "Unknown animation name: " .. tostring("fall"))

	v1.Weight = 1
	v1.FadeTime = 0.1
end

local function onSeated() --[[ onSeated | Line: 476 | Upvalues: t (copy) ]]
	local v2 = assert(t.Animations.sit, "Unknown animation name: " .. tostring("sit"))

	v2.FadeTime = 0.4
	v2.Weight = 1
	v2.Speed = 0
end

local function onClimbing() --[[ onClimbing | Line: 483 | Upvalues: v5 (copy), t (copy) ]]
	local RootPart = v5.RootPart
	local v1 = if RootPart then RootPart.AssemblyLinearVelocity.Y / 5 else 0
	local v3 = assert(t.Animations.climb, "Unknown animation name: " .. tostring("climb"))

	v3.Speed = v1
	v3.Weight = 1
end

local function onSwimming() --[[ onSwimming | Line: 497 | Upvalues: v5 (copy), t (copy) ]]
	local RootPart = v5.RootPart
	local v1 = if RootPart then RootPart.AssemblyLinearVelocity.Magnitude else 0
	local v3 = assert(t.Animations.swim, "Unknown animation name: " .. tostring("swim"))

	v3.FadeTime = 0.4

	local v52 = assert(t.Animations.swimidle, "Unknown animation name: " .. tostring("swimidle"))

	v52.FadeTime = 0.4

	if v1 > 1 then
		v3.Speed = v1 / 10
		v3.Weight = 1
	else
		v52.Weight = 1
	end
end

local function onRunning() --[[ onRunning | Line: 520 | Upvalues: v5 (copy), v6 (copy), t (copy) ]]
	local RootPart = v5.RootPart
	local zero = Vector2.zero
	local v1

	if RootPart then
		local v4 = RootPart.Position - Vector3.new(0, 1, 0) * (v5.HipHeight + RootPart.Size.Y / 2)
		local v52 = workspace:GetPartBoundsInRadius(v4, 1, v6)
		local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
		local t2 = {}

		for v62, v7 in v52 do
			local v9 = assert(if v7:IsA("BasePart") then v7.AssemblyRootPart else nil)

			if not t2[v9] then
				AssemblyLinearVelocity = AssemblyLinearVelocity - v9:GetVelocityAtPosition(v4)
				t2[v9] = true
			end
		end

		local v10 = RootPart.CFrame
		local v13 = Vector2.new(v10.RightVector:Dot(AssemblyLinearVelocity), (v10.LookVector:Dot(AssemblyLinearVelocity)))

		v1 = v13.Magnitude
		zero = v13
	else
		v1 = 0
	end

	local v14

	if v5.AutomaticScalingEnabled then
		local v15 = script
		local ScaleDampeningPercent = v15:FindFirstChild("ScaleDampeningPercent")
		local v16

		if ScaleDampeningPercent and ScaleDampeningPercent:IsA("NumberValue") then
			v16 = ScaleDampeningPercent.Value
		else
			local v17 = v15:GetAttribute("ScaleDampeningPercent")

			v16 = if typeof(v17) == "number" then v17 else nil
		end

		v14 = if v16 then 1 + (v5.HipHeight - 2) * v16 / 2 else v5.HipHeight / 2
	else
		v14 = 1
	end

	local v18 = v1 / 12.8 / v14

	if not (v14 / 2 < v1) then
		assert(t.Animations.idle, "Unknown animation name: " .. tostring("idle")).Weight = 1

		return
	end

	local v20 = (v18 - 0.5) / 0.5
	local v22 = math.max(1, (math.log(v20 + 1)))
	local v23 = math.clamp(v20, 0.0001, 1)
	local v25 = math.clamp(if v23 == 0.0001 then v18 / 0.5 else 1 - v20, 0.0001, 1)
	local t2 = {}
	local v26 = false
	local v27 = false
	local v28 = false
	local v29 = false
	local v30 = false
	local v31 = false

	for v32, v33 in t.LocomotionMap do
		local Velocity = v33.Velocity

		if zero:Dot(Velocity) > 0 then
			t2[v32] = v33
		end

		if not v26 then
			local v34 = if v27 then v27 elseif Velocity.X < 0 then true else false
			local v35 = if v31 then v31 elseif Velocity.Y < 0 then true else false

			v27 = v34
			v26 = v34 and v35
			v31 = v35
		end

		if not v29 then
			local v36 = if v30 then v30 elseif Velocity.X > 0 then true else false
			local v37 = if v28 then v28 else Velocity.Y > 0

			v28 = v37
			v29 = v36 and v37
			v30 = v36
		end
	end

	if v26 and v29 then
		local t3 = {}
		local sum = 0
		local t4 = {}
		local sum2 = 0
		local v38 = 0

		for v40, v41 in t2 do
			local v39
			local Velocity = v41.Velocity
			local v46 = math.clamp(1 - math.abs(-math.atan2(zero.X * Velocity.Y - zero.Y * Velocity.X, zero.X * Velocity.X + zero.Y * Velocity.Y)), 0, 1)
			local Speed = v41.Speed

			if math.abs(Speed - 12.8) < math.abs(Speed - 6.4) then
				t3[v40] = v46
				sum = sum + v46
			else
				t4[v40] = v46
				sum2 = sum2 + v46
			end

			local ActiveTrack = assert(t.Animations[v40], "Unknown animation name: " .. tostring(v40)).ActiveTrack

			v39 = if ActiveTrack and (ActiveTrack.IsPlaying and ActiveTrack.WeightTarget > 0.0001) then ActiveTrack.TimePosition else nil

			if v39 then
				v38 = math.max(v38, v39)
			end
		end

		for v50, v51 in t3 do
			local v54 = assert(t.Animations[v50], "Unknown animation name: " .. tostring(v50))

			v54.Weight = math.clamp(v51 / sum * v23, 0.0001, 1)
			v54.TimePosition = v38
			v54.Speed = v22
		end

		for v55, v56 in t4 do
			local v59 = assert(t.Animations[v55], "Unknown animation name: " .. tostring(v55))

			v59.Weight = math.clamp(v56 / sum2 * v25, 0.0001, 1)
			v59.TimePosition = v38
		end
	else
		local v61 = assert(t.Animations.run, "Unknown animation name: " .. tostring("run"))

		v61.Weight = v23
		v61.Speed = v22
		assert(t.Animations.walk, "Unknown animation name: " .. tostring("walk")).Weight = v25
	end
end

local function onPlayEmote(p1) --[[ onPlayEmote | Line: 662 | Upvalues: v5 (copy), t (copy), v14 (ref) ]]
	if typeof(p1) ~= "Instance" then
		return false
	end

	if not p1:IsA("Animation") then
		return false
	end

	if not (if v5.MoveDirection == Vector3.new(0, 0, 0) then v5:GetState() == Enum.HumanoidStateType.Running else false) then
		return false
	end

	local v3 = p1.AnimationId:match("%d+$")

	if not v3 then
		return false
	end

	local v4 = "emote_" .. assert(v3)

	if t.Animations[v4] == nil then
		local t2 = {
			DefaultSet = {
				TotalWeight = 0
			},
			CustomSet = {
				TotalWeight = 0
			}
		}

		table.insert(t2.DefaultSet, {
			Weight = 1,
			Id = "rbxassetid://" .. v3,
			Animation = p1
		})
		t.Animations[v4] = t2
	end

	v14 = v4

	return true
end

local function onChatted(p1) --[[ onChatted | Line: 703 | Upvalues: t (copy), v5 (copy), v14 (ref) ]]
	local v1 = nil

	if p1:sub(1, 3) == "/e " then
		v1 = p1:sub(4)
	elseif p1:sub(1, 7) == "/emote " then
		v1 = p1:sub(8)
	end

	if t.Emotes[v1] == nil then
		return
	end

	if not (if v5.MoveDirection == Vector3.new(0, 0, 0) then v5:GetState() == Enum.HumanoidStateType.Running else false) then
		return
	end

	v14 = v1
end

v5.Jumping:Connect(onJumping)

if LocalPlayer then
	LocalPlayer.Chatted:Connect(onChatted)
end

task.spawn(function() --[[ Line: 725 | Upvalues: onPlayEmote (copy) ]]
	local PlayEmote = script:WaitForChild("PlayEmote", (1 / 0))

	if not (PlayEmote and PlayEmote:IsA("BindableFunction")) then
		return
	end

	PlayEmote.OnInvoke = onPlayEmote
end)
t.Callbacks[Enum.HumanoidStateType.Seated] = onSeated
t.Callbacks[Enum.HumanoidStateType.Running] = onRunning
t.Callbacks[Enum.HumanoidStateType.Climbing] = onClimbing
t.Callbacks[Enum.HumanoidStateType.Freefall] = onFreefall
t.Callbacks[Enum.HumanoidStateType.Swimming] = onSwimming
assert(Animator)

for v17, v18 in Animator:GetPlayingAnimationTracks() do
	v18:Stop(0)
	v18:Destroy()
end

local function updateToolAnimation(p1) --[[ updateToolAnimation | Line: 755 | Upvalues: v13 (ref), v16 (ref), v5 (copy), t (copy) ]]
	local v1 = os.clock()
	local v2 = "toolnone"
	local toolanim = p1:FindFirstChild("toolanim")

	if toolanim and toolanim:IsA("StringValue") then
		v13 = toolanim.Value
		v16 = v1 + 0.3
		toolanim.Parent = nil
	end

	if v1 < v16 then
		if v13 == "Slash" then
			v2 = "toolslash"
		elseif v13 == "Lunge" and not v5.Sit then
			v2 = "toollunge"
		end
	elseif v13 then
		v13 = nil
	end

	local v52 = assert(t.Animations[v2], "Unknown animation name: " .. tostring(v2))

	v52.Priority = Enum.AnimationPriority.Action
	v52.FadeTime = 0.1
	v52.Weight = 1
end

local function updateAnimations() --[[ updateAnimations | Line: 782 | Upvalues: v4 (copy), updateToolAnimation (copy), v14 (ref), v5 (copy), t (copy), rollAnimation (copy) ]]
	local v1 = v4:FindFirstChildWhichIsA("Tool")

	if v1 and v1.RequiresHandle then
		updateToolAnimation(v1)
	end

	if v14 and (if v5.MoveDirection == Vector3.new(0, 0, 0) then v5:GetState() == Enum.HumanoidStateType.Running else false) then
		local v6 = v14

		assert(t.Animations[v6], "Unknown animation name: " .. tostring(v6)).Weight = 1
	else
		local v2, v3

		v2 = v5:GetState()
		v3 = t.Callbacks[v2]

		if v3 then
			v3()
		end

		v14 = nil
	end

	for v10, v11 in t.Animations do
		local v9
		local Speed = v11.Speed
		local Weight = v11.Weight
		local FadeTime = v11.FadeTime
		local ActiveTrack = v11.ActiveTrack

		if Speed or Weight then
			local v12 = if ActiveTrack then ActiveTrack.IsPlaying else false

			if v12 and (ActiveTrack and t.DidLoop[ActiveTrack]) then
				local v13, v142 = rollAnimation(v11)

				if v142 then
					v12 = false
				end

				t.DidLoop[ActiveTrack] = nil
				v9 = v13
			else
				v9 = nil
			end

			if not v12 then
				if ActiveTrack and ActiveTrack ~= v9 then
					ActiveTrack:Stop(FadeTime or 0.3)
				end

				local v15 = if v9 then v9 else rollAnimation(v11)

				v11.ActiveTrack = v15
				ActiveTrack = v15
			end

			if ActiveTrack then
				local TimePosition = v11.TimePosition

				assert(ActiveTrack)

				if ActiveTrack.IsPlaying then
					local Priority = v11.Priority

					if Weight then
						v11.Weight = nil

						if Weight == 0.0001 and ActiveTrack.WeightTarget ~= 0.0001 then
							ActiveTrack:AdjustWeight(0.0001, FadeTime or 0.3)
						elseif math.abs(Weight - ActiveTrack.WeightTarget) > 0.01 then
							ActiveTrack:AdjustWeight(Weight, FadeTime or 0.3)
						end
					end

					if Speed then
						v11.Speed = nil

						if math.abs(Speed - ActiveTrack.Speed) > 0.01 and ActiveTrack.WeightTarget > 0.0001 then
							ActiveTrack:AdjustSpeed(Speed)
						end
					end

					if Priority then
						ActiveTrack.Priority = Priority
						v11.Priority = nil
					end

					if TimePosition then
						ActiveTrack.TimePosition = TimePosition
					end
				else
					ActiveTrack:Play(FadeTime or 0.3, Weight or 1, Speed or 1)
					ActiveTrack.TimePosition = TimePosition or 0
				end

				if TimePosition then
					v11.TimePosition = nil
				end

				if FadeTime then
					v11.FadeTime = nil
				end
			end
		else
			if ActiveTrack and ActiveTrack.IsPlaying then
				ActiveTrack:Stop(FadeTime or 0.3)
			end

			if FadeTime then
				v11.FadeTime = nil
			end
		end
	end
end

RunService.Heartbeat:Connect(updateAnimations)