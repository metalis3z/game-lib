--credit to prince games studio
local t = {}
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

game:GetService("TweenService")

local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local Environment = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Environment"))
local Gardens = workspace:WaitForChild("Gardens")

require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SellValueData"))

local FruitValueCalc = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"))

require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("MutationData"))

local Fruits = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Fruits")
local Plants = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Plants")
local Fruits2 = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits")

ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Plants")
require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SeedData"))

local PlantVisualizerController = require(script.Parent.PlantVisualizerController)

require(game.ReplicatedStorage.ClientModules.Effects.ChunkDebris)

local LocalPlayer = Players.LocalPlayer

local function notifyBambooBlocked() --[[ notifyBambooBlocked | Line: 39 ]]
	require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("Bamboo can\'t be stolen!")
end

local v1 = RunService:IsStudio() or Environment.env == "Dev"

local function dprint(...) --[[ dprint | Line: 51 | Upvalues: v1 (copy) ]]
	if not v1 then
		return
	end

	print("[StealStack]", ...)
end

local function dwarn(...) --[[ dwarn | Line: 57 | Upvalues: v1 (copy) ]]
	if not v1 then
		return
	end

	warn("[StealStack]", ...)
end

local Debris = game:GetService("Debris")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local v2 = 0

local function spawnStealPopVFX(p1, p2) --[[ spawnStealPopVFX | Line: 79 | Upvalues: v2 (ref), Assets (copy), Debris (copy) ]]
	if v2 >= 12 then
		return
	end

	if p2 == nil then
		p2 = 1
	end

	local v1 = Assets.PopVFXModel:Clone()

	v1:ScaleTo(p2 * 0.5)

	if v1:IsA("Model") then
		v1:PivotTo(CFrame.new(p1))
	elseif v1:IsA("BasePart") then
		v1.CFrame = CFrame.new(p1)
	end

	v1.Parent = workspace
	v2 = v2 + 1
	v1.Destroying:Connect(function() --[[ Line: 98 | Upvalues: v2 (ref) ]]
		v2 = math.max(0, v2 - 1)
	end)
	task.spawn(function() --[[ Line: 101 | Upvalues: v1 (copy) ]]
		task.wait()

		if not (v1 and v1.Parent) then
			return
		end

		for v12, v2 in v1:GetDescendants() do
			if v2:IsA("ParticleEmitter") then
				v2:Emit(v2:GetAttribute("EmitCount") or 1)
			end
		end
	end)
	Debris:AddItem(v1, 5)
end

local v3 = nil
local v4 = nil
local v5 = false
local v6 = nil
local v7 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local v8 = nil
local v9 = nil

local function setModelQueryEnabled(p1, p2) --[[ setModelQueryEnabled | Line: 156 | Upvalues: v1 (copy), dwarn (copy) ]]
	for v12, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2:SetAttribute("_AllowQuery", p2 or nil)
			v2.CanQuery = p2
		end
	end

	if not (v1 and p2) then
		return
	end

	local count = 0

	for v3, v4 in p1:GetDescendants() do
		if v4:IsA("BasePart") and v4.CanQuery ~= true then
			count = count + 1
		end
	end

	if not (count > 0) then
		return
	end

	dwarn(("setModelQueryEnabled: %d part(s) in %s had CanQuery reverted to false! Raycasts will miss them."):format(count, p1:GetFullName()))
end

local t7 = {}

local function acquirePlacementLock(p1) --[[ acquirePlacementLock | Line: 193 | Upvalues: t7 (copy), dwarn (copy) ]]
	local sum = 0

	repeat
		if not t7[p1] then
			t7[p1] = true

			return
		end

		sum = sum + task.wait()
	until sum > 10

	dwarn("acquirePlacementLock: waited >10s for", p1.Name, "- breaking lock (previous placement likely errored)")
	t7[p1] = true
end

local function releasePlacementLock(p1) --[[ releasePlacementLock | Line: 205 | Upvalues: t7 (copy) ]]
	t7[p1] = nil
end

local v10 = false
local v11 = nil

local function getBackpackGui() --[[ getBackpackGui | Line: 218 | Upvalues: LocalPlayer (copy) ]]
	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

	return if PlayerGui then PlayerGui:FindFirstChild("BackpackGui") else PlayerGui
end

local function lockBackpack() --[[ lockBackpack | Line: 224 | Upvalues: v10 (ref), LocalPlayer (copy) ]]
	if v10 then
		return
	end

	v10 = true

	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
	local v1 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

	if v1 then
		v1.Enabled = false
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	Humanoid:UnequipTools()
end

local function unlockBackpack() --[[ unlockBackpack | Line: 248 | Upvalues: v10 (ref), LocalPlayer (copy) ]]
	if not v10 then
		return
	end

	v10 = false

	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
	local v1 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

	if not v1 then
		return
	end

	v1.Enabled = true
end

local function isLocalPlayerCarryingStolen() --[[ isLocalPlayerCarryingStolen | Line: 261 | Upvalues: t6 (copy), LocalPlayer (copy) ]]
	local v1 = t6[LocalPlayer]

	return if v1 == nil then false else #v1 > 0
end

local function getCharacterPosition() --[[ getCharacterPosition | Line: 270 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position
	end

	return nil
end

local function findFruitModel(p1, p2, p3) --[[ findFruitModel | Line: 278 | Upvalues: Gardens (copy) ]]
	for v1, v2 in Gardens:GetChildren() do
		local Plants = v2:FindFirstChild("Plants")

		if Plants then
			local v3 = Plants:FindFirstChild(p1 .. "_" .. p2)

			if v3 then
				local Fruits = v3:FindFirstChild("Fruits")

				if Fruits then
					return Fruits:FindFirstChild(p1 .. "_" .. p2 .. "_" .. p3)
				end
			end
		end
	end

	return nil
end

local function playStealDown(p1) --[[ playStealDown | Line: 297 | Upvalues: LocalPlayer (copy), v9 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		return
	end

	local _ = tick() + 0.5

	game.ReplicatedStorage.Assets.DigParticle:Clone().Parent = workspace

	if not v9 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://119994994979267"
		v9 = Animator:LoadAnimation(Animation)
		v9.Priority = Enum.AnimationPriority.Action4
	end

	if v9.IsPlaying then
		return
	end

	v9:Play()
end

local function playArmsUpAnimation() --[[ playArmsUpAnimation | Line: 361 | Upvalues: LocalPlayer (copy), v8 (ref), v9 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		return
	end

	if not v8 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://86868346180508"
		v8 = Animator:LoadAnimation(Animation)
		v8.Looped = true
		v8.Priority = Enum.AnimationPriority.Action4
	end

	if not v9 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://119994994979267"
		v9 = Animator:LoadAnimation(Animation)
		v9.Priority = Enum.AnimationPriority.Action4
		v9.Looped = false
	end

	if v9.IsPlaying then
		v9:Stop(0)
	end

	v9:Play()

	if v8.IsPlaying then
		return
	end

	v8:Play(0.6)
end

local function stopStealAnimation() --[[ stopStealAnimation | Line: 399 | Upvalues: v9 (ref) ]]
	if not (v9 and v9.IsPlaying) then
		return
	end

	v9:Stop(0.3)
end

local function stopArmsUpAnimation() --[[ stopArmsUpAnimation | Line: 405 | Upvalues: v8 (ref) ]]
	if not (v8 and v8.IsPlaying) then
		return
	end

	v8:Stop()
end

local function addStolenFruitVisual(p1, p2, p3, p4, p5, p6) --[[ addStolenFruitVisual | Line: 411 | Upvalues: Players (copy), LocalPlayer (copy), v10 (ref), Fruits (copy), Plants (copy), dwarn (copy), t5 (copy), ReplicatedStorage (copy), t6 (copy), acquirePlacementLock (copy), dprint (copy), setModelQueryEnabled (copy), FruitValueCalc (copy), playArmsUpAnimation (copy), t7 (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if not (v1 and v1.Character) then
		return
	end

	if v1 == LocalPlayer and not v10 then
		v10 = true

		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local v2 = PlayerGui

		if v2 then
			v2 = PlayerGui:FindFirstChild("BackpackGui")
		end

		if v2 then
			v2.Enabled = false
		end

		local Character = LocalPlayer.Character

		if Character then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				Humanoid:UnequipTools()
			end
		end
	end

	local v3 = Fruits:FindFirstChild(p2)
	local v4

	if v3 then
		v4 = false
	else
		v3, v4 = Plants:FindFirstChild(p2), true
	end

	if not v3 then
		dwarn("addStolenFruitVisual: no asset found for", p2)
	else
		local v6 = v3:Clone()

		local function lockPart(p1) --[[ lockPart | Line: 434 ]]
			if not p1:GetAttribute("_StealLocked") then
				p1:SetAttribute("_StealLocked", true)
				p1.CanCollide = false
				p1.CanQuery = false
				p1.CanTouch = false
				p1.Massless = true
				p1:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 443 | Upvalues: p1 (copy) ]]
					if not p1.CanCollide then
						return
					end

					p1.CanCollide = false
				end)
				p1:GetPropertyChangedSignal("CanQuery"):Connect(function() --[[ Line: 450 | Upvalues: p1 (copy) ]]
					if not p1.CanQuery or p1:GetAttribute("_AllowQuery") then
						return
					end

					p1.CanQuery = false
				end)
				p1:GetPropertyChangedSignal("CanTouch"):Connect(function() --[[ Line: 455 | Upvalues: p1 (copy) ]]
					if not p1.CanTouch then
						return
					end

					p1.CanTouch = false
				end)
			end
		end

		v6.DescendantAdded:Connect(function(p1) --[[ Line: 460 | Upvalues: lockPart (copy) ]]
			if not p1:IsA("BasePart") then
				return
			end

			lockPart(p1)
		end)

		for v7, v8 in v6:GetDescendants() do
			if v8:IsA("BasePart") then
				lockPart(v8)
			end
		end

		task.spawn(function() --[[ Line: 472 | Upvalues: t5 (ref), p2 (copy), ReplicatedStorage (ref), dwarn (ref), p6 (copy), v6 (copy), v4 (ref), p3 (copy), p4 (copy), t6 (ref), v1 (copy), acquirePlacementLock (ref), dprint (ref), setModelQueryEnabled (ref), LocalPlayer (ref), FruitValueCalc (ref), playArmsUpAnimation (ref), t7 (ref) ]]
			local v12 = t5[p2]

			if not v12 then
				local v2 = ReplicatedStorage.PlantGenerationModules.Plants:FindFirstChild(p2)

				if v2 then
					v12 = require(v2)
				end
			end

			if not v12 then
				dwarn("addStolenFruitVisual: no generation module for", p2)

				return
			end

			if p6 and p6 ~= "" then
				v6:SetAttribute("Mutation", p6)
			end

			if v4 then
				v12.InitPlant(v6, p3, p4)
			else
				v12.InitFruit(v6, p3, p4)
			end

			repeat
				task.wait()
			until v6:HasTag("InitializationComplete")

			if not t6[v1] then
				t6[v1] = {}
			end

			local PrimaryPart = v6.PrimaryPart

			if not PrimaryPart then
				PrimaryPart = v6:FindFirstChild("FruitAnchor", true) or (v6:FindFirstChild("Base", true) or v6:FindFirstChildWhichIsA("BasePart", true))

				if not PrimaryPart then
					dwarn("addStolenFruitVisual: fruit", p2, "has no usable PrimaryPart, destroying")
					v6:Destroy()
				else
					v6.PrimaryPart = PrimaryPart
				end
			end

			acquirePlacementLock(v1)

			local ok, result = pcall(function() --[[ Line: 523 | Upvalues: dprint (ref), p2 (ref), v1 (ref), t6 (ref), setModelQueryEnabled (ref), v6 (ref), PrimaryPart (ref), dwarn (ref), LocalPlayer (ref), FruitValueCalc (ref), p4 (ref), p6 (ref), playArmsUpAnimation (ref) ]]
				dprint(("Placing \'%s\' for %s (stack size before: %d)"):format(p2, v1.Name, #t6[v1]))
				setModelQueryEnabled(v6, true)

				local v12 = (1 / 0)

				for v2, v3 in v6:GetDescendants() do
					if v3:IsA("BasePart") and v3.Transparency < 1 then
						local v4 = v3.Position.Y - v3.Size.Y / 2

						if v4 < v12 then
							v12 = v4
						end
					end
				end

				if v12 == (1 / 0) then
					v12 = PrimaryPart.Position.Y - PrimaryPart.Size.Y / 2
				end

				local v5 = CFrame.new(PrimaryPart.Position.X, PrimaryPart.Position.Y - 100, PrimaryPart.Position.Z)

				v6.Parent = workspace

				local v62 = RaycastParams.new()

				v62.FilterDescendantsInstances = { v6 }
				v62.FilterType = Enum.RaycastFilterType.Include

				local v7 = workspace:Raycast(v5.Position, Vector3.new(0, 300, 0), v62)
				local v8 = CFrame.new(PrimaryPart.Position.X, v12, PrimaryPart.Position.Z)

				if v7 and v7.Instance then
					local v9 = CFrame.new(v7.Position)

					dprint(("Bottom raycast hit \'%s\' at Y=%.2f"):format(v7.Instance.Name, v7.Position.Y))
					v8 = v9
				else
					dwarn(("Bottom raycast MISSED for \'%s\' - falling back to iterated lowestY=%.2f. If this happens often, the fruit\'s parts aren\'t queryable."):format(p2, v12))
				end

				setModelQueryEnabled(v6, false)

				local FruitAnchor = Instance.new("Part")

				FruitAnchor.Name = "FruitAnchor"
				FruitAnchor.Size = Vector3.new(0.01, 0.01, 0.01)
				FruitAnchor.Transparency = 1
				FruitAnchor.CanCollide = false
				FruitAnchor.CanQuery = false
				FruitAnchor.CanTouch = false
				FruitAnchor.Massless = true
				FruitAnchor.CFrame = v8
				FruitAnchor.Parent = v6
				v6.PrimaryPart = FruitAnchor

				for v10, v11 in v6:GetDescendants() do
					if v11:IsA("BasePart") then
						v11.Anchored = false
						v11.CanCollide = false
						v11.CanTouch = false
						v11.Massless = true
					end
				end

				for v122, v13 in v6:GetDescendants() do
					if v13:IsA("BasePart") and v13 ~= FruitAnchor then
						local WeldConstraint = Instance.new("WeldConstraint")

						WeldConstraint.Part0 = FruitAnchor
						WeldConstraint.Part1 = v13
						WeldConstraint.Parent = v13
					end
				end

				if not v1.Character:FindFirstChild("Head") then
					v6:Destroy()

					return
				end

				local HumanoidRootPart = v1.Character:FindFirstChild("HumanoidRootPart")

				if not HumanoidRootPart then
					v6:Destroy()

					return
				end

				local v14 = t6[v1]
				local v15 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)

				if v14 and #v14 ~= 0 then
					local X = v15.Position.X
					local Z = v15.Position.Z
					local t = {}

					for v16, v17 in v14 do
						if v17.model and v17.model.Parent then
							table.insert(t, v17.model)
							setModelQueryEnabled(v17.model, true)
						end
					end

					dprint(("Stacking on top of %d carried model(s)"):format(#t))
					task.wait()

					local v18 = RaycastParams.new()

					v18.FilterDescendantsInstances = t
					v18.FilterType = Enum.RaycastFilterType.Include

					local v19 = HumanoidRootPart.Position.Y + 200
					local count = 0
					local v20 = (-1 / 0)
					local v21 = nil

					for i = 0, 4 do
						for j = 0, 4 do
							local v22 = X - 2 + i * 1
							local v23 = Z - 2 + j * 1
							local v24 = Vector3.new(v22, v19, v23)

							for k = 1, 20 do
								local v25 = workspace:Raycast(v24, Vector3.new(0, -400, 0), v18)

								if not v25 then
									break
								end

								if v25.Instance.Transparency >= 1 then
									v24 = Vector3.new(v22, v25.Position.Y - 0.01, v23)
								else
									count = count + 1

									if v20 < v25.Position.Y then
										v20 = v25.Position.Y
										v21 = v25.Instance
									end

									break
								end
							end
						end
					end

					for v28, v29 in t do
						setModelQueryEnabled(v29, false)
					end

					if v20 > (-1 / 0) then
						local v33, v34

						if v21 then
							v33 = v21.Name

							if v33 then
								v34 = count
							else
								v34 = count
								v33 = "?"
							end
						else
							v34 = count
							v33 = "?"
						end

						dprint(("Grid raycast: %d/%d columns hit. Highest surface: \'%s\' at Y=%.2f"):format(v34, 25, v33, v20))
						FruitAnchor.CFrame = CFrame.new(X, v20, Z)
					else
						dwarn(("Grid raycast hit NOTHING above the stack for \'%s\' (stack size %d). Using fallback Y=%.2f. Check that the carried fruits\' parts have CanQuery enabled during the raycast."):format(p2, #t, HumanoidRootPart.Position.Y + 0.5))
						FruitAnchor.CFrame = CFrame.new(X, HumanoidRootPart.Position.Y + 0.5, Z)
					end
				else
					FruitAnchor.CFrame = v15
					dprint(("First fruit in stack -> placed at base ref Y=%.2f"):format(v15.Position.Y))
				end

				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Parent = FruitAnchor
				WeldConstraint.Part0 = FruitAnchor
				WeldConstraint.Part1 = HumanoidRootPart
				table.insert(t6[v1], {
					model = v6,
					stealer = v1
				})
				v6.Parent = v1.Character
				dprint(("Placed \'%s\' at Y=%.2f (stack size now: %d)"):format(p2, FruitAnchor.Position.Y, #t6[v1]))

				if v1 ~= LocalPlayer then
					return
				end

				local sum = tonumber(LocalPlayer:GetAttribute("StolenCarryValue")) or 0

				if #t6[v1] == 1 then
					sum = 0
				end

				local ok, result = pcall(FruitValueCalc, p2, p4, p6, LocalPlayer, nil)

				if ok and type(result) == "number" then
					sum = sum + result
				else
					dwarn("FruitValueCalc failed for", p2, "-", result)
				end

				LocalPlayer:SetAttribute("StolenCarryValue", sum)
				playArmsUpAnimation()
			end)

			t7[v1] = nil

			if not ok then
				dwarn("Placement errored for", p2, "-", result)

				if v6 and v6.Parent then
					v6:Destroy()
				end
			end
		end)
	end
end

local t8 = {}
local v12 = false

local function queueDestroy(p1) --[[ queueDestroy | Line: 774 | Upvalues: t8 (copy), v12 (ref), RunService (copy) ]]
	if p1.Parent then
		p1.Parent = nil
	end

	local v1 = t8

	table.insert(v1, p1)

	if not v12 then
		v12 = true
		task.defer(function() --[[ Line: 785 | Upvalues: t8 (ref), RunService (ref), v12 (ref) ]]
			while #t8 > 0 do
				local v1 = os.clock()

				repeat
					local v2 = table.remove(t8)

					if not v2 then
						continue
					end

					v2:Destroy()
				until #t8 == 0 or os.clock() - v1 >= 0.004

				if not (#t8 > 0) then
					continue
				end

				RunService.Heartbeat:Wait()
			end

			v12 = false
		end)
	end
end

local function clearStolenFruitVisuals(p1) --[[ clearStolenFruitVisuals | Line: 802 | Upvalues: Players (copy), t6 (copy), t8 (copy), v12 (ref), RunService (copy), LocalPlayer (copy), v8 (ref), v9 (ref), v10 (ref) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 then
		if p1 == LocalPlayer.UserId then
			if v8 and v8.IsPlaying then
				v8:Stop()
			end

			if v9 and v9.IsPlaying then
				v9:Stop(0.3)
			end

			if v10 then
				v10 = false

				local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
				local v2 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

				if v2 then
					v2.Enabled = true
				end
			end
		end

		local v3 = t6[v1]

		if not v3 then
			return
		end

		for v4, v5 in v3 do
			if v5.model and v5.model.Parent then
				local model = v5.model

				if model.Parent then
					model.Parent = nil
				end

				local v6 = t8

				table.insert(v6, model)

				if not v12 then
					v12 = true
					task.defer(function() --[[ Line: 785 | Upvalues: t8 (ref), RunService (ref), v12 (ref) ]]
						while #t8 > 0 do
							local v1 = os.clock()

							repeat
								local v2 = table.remove(t8)

								if not v2 then
									continue
								end

								v2:Destroy()
							until #t8 == 0 or os.clock() - v1 >= 0.004

							if not (#t8 > 0) then
								continue
							end

							RunService.Heartbeat:Wait()
						end

						v12 = false
					end)
				end
			end
		end

		t6[v1] = nil
	else
		for v7, v82 in t6 do
			if v7.UserId == p1 then
				for v92, v102 in v82 do
					if v102.model and v102.model.Parent then
						local model = v102.model

						if model.Parent then
							model.Parent = nil
						end

						local v11 = t8

						table.insert(v11, model)

						if not v12 then
							v12 = true
							task.defer(function() --[[ Line: 785 | Upvalues: t8 (ref), RunService (ref), v12 (ref) ]]
								while #t8 > 0 do
									local v1 = os.clock()

									repeat
										local v2 = table.remove(t8)

										if not v2 then
											continue
										end

										v2:Destroy()
									until #t8 == 0 or os.clock() - v1 >= 0.004

									if not (#t8 > 0) then
										continue
									end

									RunService.Heartbeat:Wait()
								end

								v12 = false
							end)
						end
					end
				end

				t6[v7] = nil

				return
			end
		end
	end
end

local function markFruitStolen(p1, p2, p3) --[[ markFruitStolen | Line: 836 | Upvalues: PlantVisualizerController (copy), findFruitModel (copy), t4 (copy) ]]
	local v1 = if p3 == "" or p3 == nil then PlantVisualizerController:GetSpawnedPlant(p1, p2) else findFruitModel(p1, p2, p3)

	if not v1 then
		return
	end

	local t = {}

	local function hide(p1, p2, p3) --[[ hide | Line: 850 | Upvalues: t (copy) ]]
		local ok, result = pcall(function() --[[ Line: 851 | Upvalues: p1 (copy), p2 (copy) ]]
			return p1[p2]
		end)

		if ok then
			table.insert(t, {
				instance = p1,
				property = p2,
				original = result
			})
			p1[p2] = p3
		end
	end

	local v4 = v1:IsA("Model") and v1.PrimaryPart or nil

	local function processInstance(p1) --[[ processInstance | Line: 859 | Upvalues: v4 (copy), hide (copy) ]]
		if p1.Name == "HarvestPart" then
			return
		end

		if p1:HasTag("MutationVFX") then
			return
		end

		if p1:IsA("BasePart") then
			if p1 ~= v4 then
				hide(p1, "Transparency", 1)
				hide(p1, "CanCollide", false)
			end
		elseif p1:IsA("Decal") or p1:IsA("Texture") then
			hide(p1, "Transparency", 1)
		else
			if not (p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or p1:IsA("Trail"))) then
				if p1:IsA("Light") then
				elseif not (p1:IsA("SurfaceGui") or p1:IsA("BillboardGui")) then
					return
				end
			end

			hide(p1, "Enabled", false)
		end
	end

	if v1:IsA("BasePart") then
		processInstance(v1)
	end

	for v5, v6 in v1:GetDescendants() do
		processInstance(v6)
	end

	t4[v1] = t

	for v7, v8 in v1:GetDescendants() do
		if v8:IsA("ProximityPrompt") then
			v8:Destroy()
		end
	end
end

local function restoreFruitAppearance(p1, p2, p3) --[[ restoreFruitAppearance | Line: 895 | Upvalues: PlantVisualizerController (copy), findFruitModel (copy), t4 (copy) ]]
	local v1 = if p3 == "" or p3 == nil then PlantVisualizerController:GetSpawnedPlant(p1, p2) else findFruitModel(p1, p2, p3)

	if not v1 then
		return
	end

	local v4 = t4[v1]

	if v4 then
		for v5, v6 in v4 do
			local instance = v6.instance

			if instance and instance.Parent then
				pcall(function() --[[ Line: 911 | Upvalues: instance (copy), v6 (copy) ]]
					instance[v6.property] = v6.original
				end)
			end
		end

		t4[v1] = nil
	end

	local StolenBillboard = v1:FindFirstChild("StolenBillboard")

	if StolenBillboard then
		StolenBillboard:Destroy()
	end

	if p3 ~= "" and p3 ~= nil then
		return
	end

	PlantVisualizerController:AddHarvestPrompt(v1)
end

local function deleteFruitModels(p1) --[[ deleteFruitModels | Line: 930 | Upvalues: findFruitModel (copy), t4 (copy), t8 (copy), v12 (ref), RunService (copy) ]]
	for v1, v2 in p1 do
		local v3 = findFruitModel(v2.OwnerUserId, v2.PlantId, v2.FruitId)

		if v3 then
			t4[v3] = nil

			if v3.Parent then
				v3.Parent = nil
			end

			local v4 = t8

			table.insert(v4, v3)

			if not v12 then
				v12 = true
				task.defer(function() --[[ Line: 785 | Upvalues: t8 (ref), RunService (ref), v12 (ref) ]]
					while #t8 > 0 do
						local v1 = os.clock()

						repeat
							local v2 = table.remove(t8)

							if not v2 then
								continue
							end

							v2:Destroy()
						until #t8 == 0 or os.clock() - v1 >= 0.004

						if not (#t8 > 0) then
							continue
						end

						RunService.Heartbeat:Wait()
					end

					v12 = false
				end)
			end
		end
	end
end

local function cancelCurrentSteal() --[[ cancelCurrentSteal | Line: 940 | Upvalues: v5 (ref), v3 (ref), v4 (ref), Networking (copy), v7 (ref), v6 (ref), v11 (ref), LocalPlayer (copy), t6 (copy), v10 (ref), v9 (ref) ]]
	v5 = true

	local v1 = v3

	v3 = nil
	v4 = nil

	if v1 and v1:IsDescendantOf(workspace) then
		v1.Enabled = false
		task.defer(function() --[[ Line: 947 | Upvalues: v1 (copy) ]]
			if not (v1 and v1:IsDescendantOf(workspace)) then
				return
			end

			v1.Enabled = true
		end)
	end

	Networking.Steal.CancelSteal:Fire()

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	v6 = nil

	if not v11 then
		v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	end

	v11:Enable()

	local v2 = t6[LocalPlayer]

	if if v2 == nil then false else #v2 > 0 then
		return
	end

	if v10 then
		v10 = false

		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local v42 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

		if v42 then
			v42.Enabled = true
		end
	end

	if not (v9 and v9.IsPlaying) then
		return
	end

	v9:Stop(0.3)
end

local function startMoveDetection() --[[ startMoveDetection | Line: 976 | Upvalues: v6 (ref), LocalPlayer (copy), cancelCurrentSteal (copy), v7 (ref), RunService (copy) ]]
	local Character = LocalPlayer.Character
	local v1

	if Character then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v1 = if HumanoidRootPart then HumanoidRootPart.Position else nil
	else
		v1 = nil
	end

	v6 = v1

	if not v6 then
		cancelCurrentSteal()

		return
	end

	local v2

	if not v7 then
		v2 = os.clock()
		v7 = RunService.Heartbeat:Connect(function() --[[ Line: 992 | Upvalues: LocalPlayer (ref), cancelCurrentSteal (ref), v2 (copy), v6 (ref) ]]
			debug.profilebegin("Controllers/StealController/MoveCheck")

			local Character = LocalPlayer.Character
			local v1

			if Character then
				local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

				v1 = if HumanoidRootPart then HumanoidRootPart.Position else nil
			else
				v1 = nil
			end

			if v1 and os.clock() - v2 < 0.6 then
				v6 = v1
			elseif v1 then
				local _ = not ((v1 - v6).Magnitude > 5)
			end

			cancelCurrentSteal()
			debug.profileend()
		end)

		return
	end

	v7:Disconnect()
	v2 = os.clock()
	v7 = RunService.Heartbeat:Connect(function() --[[ Line: 992 | Upvalues: LocalPlayer (ref), cancelCurrentSteal (ref), v2 (copy), v6 (ref) ]]
		debug.profilebegin("Controllers/StealController/MoveCheck")

		local Character = LocalPlayer.Character
		local v1

		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			v1 = if HumanoidRootPart then HumanoidRootPart.Position else nil
		else
			v1 = nil
		end

		if v1 and os.clock() - v2 < 0.6 then
			v6 = v1
		elseif v1 then
			local _ = not ((v1 - v6).Magnitude > 5)
		end

		cancelCurrentSteal()
		debug.profileend()
	end)
end

local function applyPulsingHighlight(p1) --[[ applyPulsingHighlight | Line: 1018 | Upvalues: LocalPlayer (copy), t2 (copy) ]]
	if p1 == LocalPlayer then
		return
	end

	local v1 = t2[p1]

	if v1 and v1.Parent then
		return
	end

	if v1 then
		t2[p1] = nil
	end

	local Character = p1.Character

	if Character then
		local StealHighlight = Instance.new("Highlight")

		StealHighlight.Name = "StealHighlight"
		StealHighlight.FillColor = Color3.new(255/255, 0/255, 0/255)
		StealHighlight.OutlineColor = Color3.new(255/255, 0/255, 0/255)
		StealHighlight.FillTransparency = 0.5
		StealHighlight.OutlineTransparency = 1
		StealHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		StealHighlight.Parent = Character
		t2[p1] = StealHighlight
	end
end

local function removePulsingHighlight(p1) --[[ removePulsingHighlight | Line: 1044 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]

	if v1 then
		v1:Destroy()
		t2[p1] = nil
	end

	local v2 = t3[p1]

	if not v2 then
		return
	end

	task.cancel(v2)
	t3[p1] = nil
end

local StealSFX = game.SoundService.SFX.StealSFX

function t.Init(p1) --[[ Init | Line: 1060 | Upvalues: ProximityPromptService (copy), v5 (ref), LocalPlayer (copy), StealSFX (copy), v3 (ref), v4 (ref), ReplicatedStorage (copy), v11 (ref), v10 (ref), Networking (copy), startMoveDetection (copy), v7 (ref), v6 (ref), t6 (copy), v9 (ref), applyPulsingHighlight (copy), t2 (copy), t3 (copy), markFruitStolen (copy), restoreFruitAppearance (copy), deleteFruitModels (copy), addStolenFruitVisual (copy), clearStolenFruitVisuals (copy), spawnStealPopVFX (copy), Players (copy), t7 (copy), RunService (copy), v8 (ref) ]]
	ProximityPromptService.PromptButtonHoldBegan:Connect(function(p1, p2) --[[ Line: 1061 | Upvalues: v5 (ref), LocalPlayer (ref), StealSFX (ref), v3 (ref), v4 (ref), ReplicatedStorage (ref), v11 (ref), v10 (ref), Networking (ref), startMoveDetection (ref), v7 (ref), v6 (ref), t6 (ref), v9 (ref) ]]
		v5 = false

		if not p1:HasTag("StealPrompt") then
			return
		end

		if p2 ~= LocalPlayer then
			return
		end

		local v1 = p1.Parent

		if not v1 then
			return
		end

		local v2 = v1:FindFirstAncestorWhichIsA("Model")

		if not v2 then
			return
		end

		if p1.HoldDuration > 0 then
			require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("Bamboo can\'t be stolen!")

			return
		end

		local v32 = tonumber(v2:GetAttribute("UserId"))
		local v42 = v2:GetAttribute("PlantId")
		local v52 = v2:GetAttribute("FruitId")

		StealSFX.TimePosition = 0
		StealSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		StealSFX.Playing = true

		if not (v32 and v42) then
			return
		end

		v3 = p1
		v4 = v2

		local Night = ReplicatedStorage:FindFirstChild("Night")

		if not Night or Night.Value ~= true then
			require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("You can only steal at night!")
			v3 = nil
			v4 = nil

			return
		end

		if not v11 then
			v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
		end

		v11:Disable()

		if not v10 then
			v10 = true

			local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
			local v62 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

			if v62 then
				v62.Enabled = false
			end

			local Character = LocalPlayer.Character

			if Character then
				local Humanoid = Character:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid:UnequipTools()
				end
			end
		end

		Networking.Steal.BeginSteal:Fire(v32, v42, v52 or "")
		startMoveDetection()
		task.spawn(function() --[[ Line: 1124 | Upvalues: v4 (ref) ]]
			v4:GetPivot()

			local v1, v2 = v4:GetBoundingBox()
			local Part = Instance.new("Part")

			Part.Size = v2
			Part.CFrame = v1
			Part.Anchored = true
			Part.Transparency = 1
			Part.CanCollide = false
			Part.CanQuery = false

			local v3 = game.ReplicatedStorage.Assets.ShakeParticle:Clone()

			v3.Parent = Part
			Part.Parent = workspace.Temporary

			local v42 = v4:GetPivot()

			game.Debris:AddItem(Part, 2)

			local v6 = Vector3.new()
			local sum = 0

			while v4 ~= nil do
				local v7 = game:GetService("RunService").Heartbeat:Wait()

				sum = sum + v7

				local v8 = math.clamp(sum / 0.7, 0, 1)

				Part.CFrame = v1

				if v4.PrimaryPart and v4.PrimaryPart.Anchored == true then
					local v9 = v6:Lerp(Random.new():NextUnitVector() * 0.4 * v8, v7 * 12)

					v4:PivotTo(v42 * CFrame.new(v9))
					v6 = v9
				end
			end

			v3.Enabled = false
			v4:PivotTo(v42)
		end)
		p1.Destroying:Connect(function() --[[ Line: 1179 | Upvalues: v3 (ref), p1 (copy), v4 (ref), v7 (ref), v6 (ref), Networking (ref), v11 (ref), LocalPlayer (ref), t6 (ref), v10 (ref), v9 (ref) ]]
			if v3 ~= p1 then
				return
			end

			v3 = nil
			v4 = nil

			if v7 then
				v7:Disconnect()
				v7 = nil
			end

			v6 = nil
			Networking.Steal.CancelSteal:Fire()

			if not v11 then
				v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
			end

			v11:Enable()

			local v1 = t6[LocalPlayer]

			if if v1 == nil then false else #v1 > 0 then
				return
			end

			if v10 then
				v10 = false

				local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
				local v32 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

				if v32 then
					v32.Enabled = true
				end
			end

			if not (v9 and v9.IsPlaying) then
				return
			end

			v9:Stop(0.3)
		end)
	end)
	ProximityPromptService.PromptButtonHoldEnded:Connect(function(p1, p2) --[[ Line: 1205 | Upvalues: LocalPlayer (ref), v3 (ref), v4 (ref), v7 (ref), v6 (ref), Networking (ref), v11 (ref), v9 (ref), t6 (ref), v10 (ref) ]]
		if not p1:HasTag("StealPrompt") then
			return
		end

		if p2 == LocalPlayer then
			task.defer(function() --[[ Line: 1210 | Upvalues: v3 (ref), p1 (copy), v4 (ref), v7 (ref), v6 (ref), Networking (ref), v11 (ref), LocalPlayer (ref), v9 (ref), t6 (ref), v10 (ref) ]]
				if v3 ~= p1 then
					return
				end

				v3 = nil
				v4 = nil

				if v7 then
					v7:Disconnect()
					v7 = nil
				end

				v6 = nil
				Networking.Steal.CancelSteal:Fire()

				if not v11 then
					v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
				end

				v11:Enable()

				if v9 and v9.IsPlaying then
					v9:Stop(0.3)
				end

				local v1 = t6[LocalPlayer]

				if if v1 == nil then false else #v1 > 0 then
					return
				end

				if not v10 then
					return
				end

				v10 = false

				local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
				local v32 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

				if not v32 then
					return
				end

				v32.Enabled = true
			end)
		end
	end)
	ProximityPromptService.PromptTriggered:Connect(function(p1, p2) --[[ Line: 1239 | Upvalues: LocalPlayer (ref), v5 (ref), ReplicatedStorage (ref), v3 (ref), v4 (ref), v7 (ref), v6 (ref), t6 (ref), v10 (ref), Networking (ref), v11 (ref) ]]
		if not p1:HasTag("StealPrompt") then
			return
		end

		if p2 ~= LocalPlayer then
			return
		end

		if p1.HoldDuration > 0 then
			require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("Bamboo can\'t be stolen!")
			v5 = false

			return
		end

		local Night = ReplicatedStorage:FindFirstChild("Night")

		if Night and Night.Value == true then
			if p1.HoldDuration == 0 then
				local v1 = p1.Parent

				if not v1 then
					return
				end

				local v2 = v1:FindFirstAncestorWhichIsA("Model")

				if not v2 then
					return
				end

				local v32 = tonumber(v2:GetAttribute("UserId"))
				local v42 = v2:GetAttribute("PlantId")
				local v52 = v2:GetAttribute("FruitId")

				if v32 and v42 then
					Networking.Steal.BeginSteal:Fire(v32, v42, v52 or "")
					Networking.Steal.CompleteSteal:Fire()
				end
			else
				if v3 ~= p1 or v5 then
					v5 = false

					return
				end

				if v7 then
					v7:Disconnect()
					v7 = nil
				end

				v6 = nil
				v3 = nil
				v4 = nil

				if v11 then
					v11:Enable()
					Networking.Steal.CompleteSteal:Fire()

					return
				end

				v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
				v11:Enable()
				Networking.Steal.CompleteSteal:Fire()
			end
		else
			require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController):CreateNotification("You can only steal at night!")
			v3 = nil
			v4 = nil
			v5 = false

			if v7 then
				v7:Disconnect()
				v7 = nil
			end

			v6 = nil

			local v62 = t6[LocalPlayer]

			if if v62 == nil then false else #v62 > 0 then
				return
			end

			if not v10 then
				return
			end

			v10 = false

			local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
			local v8 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

			if not v8 then
				return
			end

			v8.Enabled = true
		end
	end)
	Networking.Steal.StealStarted.OnClientEvent:Connect(function(p1) --[[ Line: 1334 | Upvalues: applyPulsingHighlight (ref) ]]
		if not (p1 and p1:IsA("Player")) then
			return
		end

		applyPulsingHighlight(p1)
	end)
	Networking.Steal.StealCancelled.OnClientEvent:Connect(function(p1) --[[ Line: 1340 | Upvalues: t2 (ref), t3 (ref) ]]
		if not (p1 and p1:IsA("Player")) then
			return
		end

		local v1 = t2[p1]

		if v1 then
			v1:Destroy()
			t2[p1] = nil
		end

		local v2 = t3[p1]

		if not v2 then
			return
		end

		task.cancel(v2)
		t3[p1] = nil
	end)
	Networking.Steal.MarkFruitStolen.OnClientEvent:Connect(markFruitStolen)
	Networking.Steal.RestoreFruitAppearance.OnClientEvent:Connect(restoreFruitAppearance)
	Networking.Steal.DeleteFruitModels.OnClientEvent:Connect(deleteFruitModels)
	Networking.Steal.AddStolenFruitVisual.OnClientEvent:Connect(addStolenFruitVisual)
	Networking.Steal.ClearStolenFruitVisuals.OnClientEvent:Connect(clearStolenFruitVisuals)
	Networking.Steal.PopVFX.OnClientEvent:Connect(function(p1, p2) --[[ Line: 1353 | Upvalues: spawnStealPopVFX (ref) ]]
		spawnStealPopVFX(p1, p2)
	end)
	Players.PlayerRemoving:Connect(function(p1) --[[ Line: 1359 | Upvalues: t2 (ref), t3 (ref), clearStolenFruitVisuals (ref), t7 (ref) ]]
		local v1 = t2[p1]

		if v1 then
			v1:Destroy()
			t2[p1] = nil
		end

		local v2 = t3[p1]

		if v2 then
			task.cancel(v2)
			t3[p1] = nil
		end

		clearStolenFruitVisuals(p1.UserId)
		t7[p1] = nil
	end)
	RunService.Heartbeat:Connect(function() --[[ Line: 1365 | Upvalues: v10 (ref), LocalPlayer (ref) ]]
		debug.profilebegin("Controllers/StealController/Heartbeat")

		if not v10 then
			debug.profileend()

			return
		end

		local Character = LocalPlayer.Character

		if not (Character and Character:FindFirstChildWhichIsA("Tool")) then
			debug.profileend()

			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			debug.profileend()

			return
		end

		Humanoid:UnequipTools()
		debug.profileend()
	end)
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 1383 | Upvalues: v8 (ref), v10 (ref), LocalPlayer (ref) ]]
		v8 = nil

		if not v10 then
			return
		end

		if not v10 then
			return
		end

		v10 = false

		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local v1 = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

		if not v1 then
			return
		end

		v1.Enabled = true
	end)
end
function t.Start(p1) --[[ Start | Line: 1393 | Upvalues: Fruits2 (copy), t5 (copy) ]]
	for v1, v2 in Fruits2:GetChildren() do
		if v2:IsA("ModuleScript") then
			t5[v2.Name] = require(v2)
		end
	end
end

return t