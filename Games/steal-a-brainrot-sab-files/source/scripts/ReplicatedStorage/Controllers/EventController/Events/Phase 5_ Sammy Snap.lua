game:GetService("ServerScriptService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("TweenService")

local SoundService = game:GetService("SoundService")

game:GetService("HttpService")
game:GetService("StarterGui")

local RunService = game:GetService("RunService")

game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)

require(ReplicatedStorage.Controllers.CharacterController)

local EffectController = require(ReplicatedStorage.Controllers.EffectController)

require(ReplicatedStorage.Controllers.AnimalController)
require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.CycleController)

local EventController = require(ReplicatedStorage.Controllers.EventController)

require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Packages.Serialization)

local CreateTween = require(ReplicatedStorage.Packages.CreateTween)

require(ReplicatedStorage.Shared.ShakePresets)
require(ReplicatedStorage.Packages.TopbarPlus)
require(ReplicatedStorage.Packages.Observers)

local ServerData = require(ReplicatedStorage.Datas.ServerData)

require(ReplicatedStorage.Packages.Moonlite)
require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Packages.Squash)
require(ReplicatedStorage.Packages.Shake)

local Trove = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Packages.Net)
require(ReplicatedStorage.Packages.Spr)

local VFX = require(ReplicatedStorage.Shared.VFX)
local _ = workspace.RenderedMovingAnimals
local scriptName = script.Name
local v15 = Trove.new()

local function waitForTrackLength(p1)
	local elapsed = os.clock()

	while p1.Length <= 0 do
		if os.clock() - elapsed >= 5 then
			warn(`[Sammy Snap] Animation '{ p1.Animation and p1.Animation.Name or "?" }' length never resolved`)

			return p1.Length
		end

		task.wait()
	end

	return p1.Length
end

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)

	local v21 = ActiveEventData.arguments ~= nil and table.find(ActiveEventData.arguments, "Coffin") ~= nil
	local v22 = not v21 and 0 or 5.5

	local function loadAnimationsOnRig(p3, t2: {[any]: any})
		local t3 = {}

		for v85, v86 in t2 do
			local v87 = p3:FindFirstChild(v85)

			if not v87 then
				warn(`[Sammy Snap] Coffin rig missing part: { v85 }`)
			else
				local Animator = v87:FindFirstChildWhichIsA("Animator", true)

				if not Animator then
					warn(`[Sammy Snap] No Animator under part: { v85 }`)
				else
					local v89 = Animator:LoadAnimation(v86)

					v15:Add(v89, "Stop")
					v15:Add(v89)
					t3[v85] = v89
				end
			end
		end

		return t3
	end

	local u24 = nil
	local v25 = nil
	local Sammy5 = nil
	local Pivot = nil

	if v21 then
		local clone = v15:Clone(script.Coffin)

		clone.Parent = workspace
		u24 = clone

		local customSammy = script:FindFirstChild("CustomSammy")
		if customSammy then
			for i = 1, 5 do
				local sammySlot = clone:FindFirstChild("Sammy" .. i)
				if sammySlot then
					local customClone = customSammy:Clone()
					customClone.Name = "Sammy" .. i
					customClone:PivotTo(sammySlot:GetPivot())
					sammySlot:Destroy()
					customClone.Parent = clone
				end
			end
		end

		local Pivot2 = clone:GetPivot()
		local Coffin = clone:FindFirstChild("Coffin")
		local v31 = if not Coffin or not Coffin:IsA("Model") then if not Coffin or not Coffin:IsA("BasePart") then clone.PrimaryPart else Coffin else Coffin.PrimaryPart
		local u32 = nil

		if v31 then
			local v33 = v15:Add(Instance.new("Sound"))

			v33.RollOffMode = Enum.RollOffMode.InverseTapered
			v33.RollOffMinDistance = 50
			v33.RollOffMaxDistance = 1500
			v33.Looped = false
			v33.SoundId = "rbxassetid://76961994638696"
			v33.Volume = 0.25
			v33.PlaybackSpeed = 1
			v33.SoundGroup = SoundService.Cutscene.WorkspaceSounds.EventMusic
			v33.Parent = v31
			v33:Play()
			u32 = v33
		end

		if v31 then
			local CoffinSequence = ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"]:FindFirstChild("CoffinSequence")

			if CoffinSequence then
				local clone2 = v15:Clone(CoffinSequence)

				clone2.Parent = v31
				clone2:Play()
			end
		end

		local v36 = loadAnimationsOnRig(clone, {
			Coffin = script.CoffinWalkCoffin1,
			Sammy1 = script.CoffinWalkSammy1,
			Sammy2 = script.CoffinWalkSammy2,
			Sammy3 = script.CoffinWalkSammy3,
			Sammy4 = script.CoffinWalkSammy4,
			Sammy5 = script.CoffinWalkSammy5
		})

		for _, v38 in v36 do
			v38.Looped = true
			v38:Play()
		end

		local startedAt = ActiveEventData.startedAt
		local connection = nil

		connection = RunService.PostSimulation:Connect(function()
			local v90 = math.clamp((workspace:GetServerTimeNow() - startedAt) / 2.5, 0, 1)

			clone:PivotTo(Pivot2:Lerp(Pivot2 + Vector3.new(0, 0, 23), v90))

			if v90 >= 1 then
				connection:Disconnect()
			end
		end)
		v15:Add(connection)

		local u41 = true

		v15:Add(function()
			u41 = false
		end)

		local v42 = ActiveEventData.startedAt + 2.5 - workspace:GetServerTimeNow()

		if v42 > 0 then
			task.wait(v42)
		end

		if not u41 then
			return
		end

		for _, v44 in v36 do
			v44:Stop()
		end

		if u32 then
			v15:Add(task.delay(2.5, function()
				CreateTween(u32, TweenInfo.new(2.5), {
					Volume = 0
				})
			end))
		end

		local v45 = loadAnimationsOnRig(clone, {
			Coffin = script.CoffinCoffin1,
			Sammy1 = script.CoffinSammy1,
			Sammy2 = script.CoffinSammy2,
			Sammy3 = script.CoffinSammy3,
			Sammy4 = script.CoffinSammy4,
			Sammy5 = script.CoffinSammy5
		})

		Sammy5 = v45.Sammy5

		for _, v47 in v45 do
			v47.Looped = false
			waitForTrackLength(v47)
		end

		local v48 = ActiveEventData.startedAt + 2.5
		local v49 = math.max(workspace:GetServerTimeNow() - v48, 0)

		for _, v51 in v45 do
			v51:Play()

			if v49 > 0 and v49 < v51.Length then
				v51.TimePosition = v49
			end

			local v52 = math.max(v51.Length - 0.05 - v49, 0)

			v15:Add(task.delay(v52, function()
				v51:AdjustSpeed(0)
			end))
		end

		local v53 = ActiveEventData.startedAt + 5.5 - workspace:GetServerTimeNow()

		if v53 > 0 then
			task.wait(v53)
		end

		local Sammy5_2 = clone:FindFirstChild("Sammy5")

		if Sammy5_2 then
			v25 = Sammy5_2
			Pivot = v25:GetPivot()
		end
	end

	local u55

	if v25 then
		if Sammy5 then
			Sammy5:Stop()
		end

		v25.Parent = workspace
		v15:Add(v25)
		u55 = v25

		for _, v57 in script.SammyEffects:GetChildren() do
			v57:Clone().Parent = u55.UpperTorso
		end

		local Highlight = Instance.new("Highlight")

		Highlight.Name = "Highlight"

		if ServerData.IsTsunamiServer() then
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		else
			Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		end

		Highlight.FillTransparency = 1
		Highlight.OutlineColor = Color3.fromRGB(255, 12, 12)
		Highlight.Parent = u55
		v15:Add(Highlight)
	else
		local customSammy = script:FindFirstChild("CustomSammy")
		u55 = v15:Clone(customSammy or script.Sammy)
		u55.Parent = workspace
	end


	local clone = v15:Clone(ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Fire)

	clone.Parent = u55.HumanoidRootPart
	clone:Play()

	local clone3 = v15:Clone(ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Walk)

	clone3.Parent = u55.HumanoidRootPart
	clone3:Play()

	local _ = ActiveEventData.startedAt + 11.17 - workspace:GetServerTimeNow()
	local v62 = u55.AnimationController.Animator:LoadAnimation(script.WalkAnimation)

	v62.Looped = true
	v15:Add(v62, "Stop")
	v15:Add(v62)

	local v63 = u55.AnimationController.Animator:LoadAnimation(script.SnapAnimation)

	v63.Looped = false
	v15:Add(v63, "Stop")
	v15:Add(v63)
	v15:Add(v63:GetMarkerReachedSignal("Freeze"):Connect(function()
		v63:AdjustSpeed(0)
	end))
	v62:Play()

	local v64 = (not v21 and 0 or 1) + 9
	local v65 = if not ServerData.IsTsunamiServer() then not ServerData.IsBiggerServer() and 150 or 250 else 350
	local v66 = if not ServerData.IsTsunamiServer() then workspace.Road.StartGround.CFrame else script.StartTsunami.CFrame
	local v67 = Pivot or v66
	local v68 = not ServerData.IsTsunamiServer() and 1 or 10
	local v69 = not ServerData.IsTsunamiServer() and 13.9 or 50

	v15:Add(RunService.PostSimulation:Connect(function(_: number)
		debug.profilebegin("Sammy Snap:Update")

		local v92 = ActiveEventData.startedAt + v22 + v64 - workspace:GetServerTimeNow()
		local v93 = math.clamp((v64 - v92) / v64, 0, 1)

		u55:PivotTo(v67:Lerp(v67 + Vector3.new(0, 0, v65), v93))
		u55:ScaleTo((math.lerp(v68, v69, v93 * v93)))

		
		debug.profileend()
	end))
	v15:Add(task.delay(ActiveEventData.startedAt + v22 + v64 - workspace:GetServerTimeNow(), function()
		v63:Play()
	end))

	local v70 = v15
	local delay = task.delay
	local v72 = v64 + 0.5

	v70:Add(delay(ActiveEventData.startedAt + v22 + v72 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Play(2.5, "Lower")
	end))

	local v73 = v15
	local delay2 = task.delay
	local v75 = v64 + 0.5

	v73:Add(delay2(ActiveEventData.startedAt + v22 + v75 - workspace:GetServerTimeNow(), function()
		ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Snap:Play()

		local LeftHand = u55.LeftHand
		local clone4 = v15:Clone(script.Snap)

		clone4.CFrame = LeftHand.CFrame
		clone4.Parent = workspace

		local Weld = Instance.new("Weld")

		Weld.Part0 = clone4
		Weld.Part1 = LeftHand
		Weld.Parent = clone4
		VFX.emit(clone4)
	end))

	local v76 = v15
	local delay3 = task.delay
	local v78 = v64 + 1 + 2

	v76:Add(delay3(ActiveEventData.startedAt + v22 + v78 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Stop()
		EffectController:Activate("Blink")
		v15:Remove(u55)

		if u24 then
			v15:Remove(u24)
		end
	end))
end
function t1.OnStop(_)
	v15:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(ReplicatedStorage.Models.Events["Phase 5: Sammy Snap"])
	end)
end

return t1
