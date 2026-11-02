--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local PetModules = require(ReplicatedStorage.SharedModules.PetModules)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PetSizes = require(ReplicatedStorage.SharedData.PetSizes)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)

local function ApplyPetTypeTag(p1, p2) --[[ ApplyPetTypeTag | Line: 17 | Upvalues: PetTypes (copy) ]]
	if not p1 then
		return
	end

	if p2 == PetTypes.Rainbow then
		if not p1:HasTag("PetRainbow") then
			p1:AddTag("PetRainbow")
		end
	else
		if not p1:HasTag("PetRainbow") then
			return
		end

		p1:RemoveTag("PetRainbow")
	end
end

local Assets = ReplicatedStorage:WaitForChild("Assets")
local t = {
	StartOrder = 6
}
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil

local function GetChaseSpeed(p1) --[[ GetChaseSpeed | Line: 73 ]]
	local v1 = p1.Module and p1.Module.FollowSpeed or 14
	local Owner = p1.Owner

	if not Owner then
		return v1
	end

	local Character = Owner.Character
	local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if v2 then
		return v1 * math.max(1, v2.WalkSpeed / 16)
	end

	return v1
end

local function YawOnlyCFrameFromHRP(p1) --[[ YawOnlyCFrameFromHRP | Line: 84 ]]
	local v1 = p1.CFrame
	local LookVector = v1.LookVector
	local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
	local v3 = if v2.Magnitude < 0.0001 then Vector3.new(0, 0, -1) else v2.Unit
	local Position = v1.Position

	return CFrame.lookAt(Position, Position + v3)
end

local v6 = RaycastParams.new()

v6.FilterType = Enum.RaycastFilterType.Exclude
v6.IgnoreWater = false
v6.RespectCanCollide = false

local function RefreshGroundFilter() --[[ RefreshGroundFilter | Line: 110 | Upvalues: Players (copy), v1 (ref), v6 (copy) ]]
	local t = {}

	for k, v in pairs(Players:GetPlayers()) do
		local Character = v.Character

		if Character then
			table.insert(t, Character)
		end
	end

	local PlayerPetReferences = workspace:FindFirstChild("PlayerPetReferences")

	if PlayerPetReferences then
		table.insert(t, PlayerPetReferences)
	end

	if v1 then
		table.insert(t, v1)
	end

	local Gardens = workspace:FindFirstChild("Gardens")

	if Gardens then
		for k, v in pairs(Gardens:GetChildren()) do
			local Plants = v:FindFirstChild("Plants")

			if Plants then
				table.insert(t, Plants)
			end
		end
	end

	local PottedPlantVisuals = workspace:FindFirstChild("PottedPlantVisuals")

	if PottedPlantVisuals then
		table.insert(t, PottedPlantVisuals)
	end

	v6.FilterDescendantsInstances = t
end

local v7 = (-1 / 0)

local function RefreshGroundFilterIfDue() --[[ RefreshGroundFilterIfDue | Line: 133 | Upvalues: v7 (ref), RefreshGroundFilter (copy) ]]
	local v1 = os.clock()

	if not (v1 - v7 < 1) then
		v7 = v1
		RefreshGroundFilter()
	end
end

local v8 = RaycastParams.new()

v8.FilterType = Enum.RaycastFilterType.Exclude
v8.IgnoreWater = false
v8.RespectCanCollide = false

local function CastGroundY(p1, p2) --[[ CastGroundY | Line: 146 | Upvalues: v6 (copy), v8 (copy) ]]
	local v1 = Vector3.new(p1.X, p2 + 200, p1.Z)
	local v2 = workspace:Raycast(v1, Vector3.new(0, -600, 0), v6)

	if not (v2 and v2.Instance) then
		return nil
	end

	local v3 = v2.Instance

	if v3.Transparency < 0.99 and v3.CanCollide then
		return v2.Position.Y
	end

	local v4 = table.clone(v6.FilterDescendantsInstances)

	table.insert(v4, v3)
	v8.FilterDescendantsInstances = v4

	for i = 1, 8 do
		local v5 = workspace:Raycast(v1, Vector3.new(0, -600, 0), v8)

		if not (v5 and v5.Instance) then
			break
		end

		local v62 = v5.Instance

		if v62.Transparency < 0.99 and v62.CanCollide then
			return v5.Position.Y
		end

		table.insert(v4, v62)
		v8.FilterDescendantsInstances = v4
	end

	return nil
end

local function ThrottledSlotGroundY(p1, p2) --[[ ThrottledSlotGroundY | Line: 191 | Upvalues: CastGroundY (copy) ]]
	local v1 = os.clock()

	if (p1.SlotGroundCastNext or 0) <= v1 then
		local v2 = CastGroundY(p2, p2.Y)

		if v2 ~= nil then
			p1.SlotGroundCachedY = v2
		end

		p1.SlotGroundCastNext = v1 + 0.06666666666666667
	end

	return p1.SlotGroundCachedY
end

local function ComputeJumpOffset(p1) --[[ ComputeJumpOffset | Line: 206 ]]
	if p1:GetAttribute("PetSpecies") ~= "Frog" then
		return 0
	end

	local v1 = p1:GetAttribute("SlotJumpStart")

	if typeof(v1) ~= "number" then
		return 0
	end

	local v2 = p1:GetAttribute("SlotJumpPeak")

	if typeof(v2) ~= "number" or v2 <= 0 then
		return 0
	end

	local v3 = p1:GetAttribute("SlotJumpDuration")

	if typeof(v3) ~= "number" or v3 <= 0 then
		return 0
	end

	local v4 = workspace:GetServerTimeNow() - v1

	if v4 < 0 or v3 < v4 then
		return 0
	end

	local v5 = v4 / v3

	return v2 * 4 * v5 * (1 - v5)
end

local function BumpGeneration(p1) --[[ BumpGeneration | Line: 227 | Upvalues: t4 (copy) ]]
	local v1 = (t4[p1] or 0) + 1

	t4[p1] = v1

	return v1
end

local function CurrentGeneration(p1) --[[ CurrentGeneration | Line: 234 | Upvalues: t4 (copy) ]]
	return t4[p1] or 0
end

local function ResolveSlotOwner(p1) --[[ ResolveSlotOwner | Line: 239 | Upvalues: Players (copy) ]]
	local v1 = p1.Parent

	if v1 and v1:IsA("Folder") then
		return Players:FindFirstChild(v1.Name)
	end

	return nil
end

local function GetSpeciesPivotCFrame(p1) --[[ GetSpeciesPivotCFrame | Line: 246 ]]
	if not p1 then
		return CFrame.identity
	end

	local Pivot = p1.Pivot

	if typeof(Pivot) == "Vector3" then
		return CFrame.Angles(math.rad(Pivot.X), math.rad(Pivot.Y), (math.rad(Pivot.Z)))
	end

	return CFrame.identity
end

local function ComputeFootOffset(p1) --[[ ComputeFootOffset | Line: 254 ]]
	local Y = p1:GetPivot().Position.Y
	local v1 = (1 / 0)

	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency < 1 then
			local v2 = v.CFrame
			local Size = v.Size
			local v3 = Size.X * 0.5
			local v4 = Size.Y * 0.5
			local v5 = Size.Z * 0.5

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					local Y2 = (v2 * Vector3.new(i * v3, j * v4, -1 * v5)).Y

					if Y2 < v1 then
						v1 = Y2
					end

					local Y3 = (v2 * Vector3.new(i * v3, j * v4, 1 * v5)).Y

					if Y3 < v1 then
						v1 = Y3
					end
				end
			end
		end
	end

	if v1 == (1 / 0) then
		return 0
	end

	return Y - v1
end

local function GetOrCreateAnimator(p1) --[[ GetOrCreateAnimator | Line: 277 ]]
	local AnimationController = p1:FindFirstChildOfClass("AnimationController")

	if not AnimationController then
		local AnimationController2 = Instance.new("AnimationController")

		AnimationController2.Parent = p1
		AnimationController = AnimationController2
	end

	local Animator = AnimationController:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = AnimationController
		Animator = Animator2
	end

	return Animator
end

local function FindAnimationsOnModel(p1, p2) --[[ FindAnimationsOnModel | Line: 292 ]]
	local t = {}
	local Animations = p1:FindFirstChild("Animations")

	if p2 then
		local t2 = {}

		for k, v in pairs(p2) do
			if type(v) == "string" and (v ~= "" and not t2[v]) then
				t2[v] = true

				local v1 = Animations and Animations:FindFirstChild(v) or p1:FindFirstChild(v)

				if v1 and v1:IsA("Animation") then
					t[v] = v1
				end
			end
		end
	else
		if Animations then
			for k, v in pairs(Animations:GetChildren()) do
				if v:IsA("Animation") then
					t[v.Name] = v
				end
			end
		end

		for k, v in pairs(p1:GetChildren()) do
			if v:IsA("Animation") then
				t[v.Name] = v
			end
		end
	end

	return t
end

local function GetAnimNameForState(p1, p2) --[[ GetAnimNameForState | Line: 320 ]]
	local v1 = if p1 then p1.Animations else p1

	if not v1 then
		return nil
	end

	if p2 == "idle" then
		return v1.Idle
	end

	if p2 == "walking" then
		return v1.Walk
	end

	if p2 == "flying" then
		return v1.Fly
	end

	if p2 == "flyidle" then
		return v1.FlyIdle or v1.Fly
	end

	if p2 == "landing" then
		return v1.Land
	end

	if p2 == "takeoff" then
		return v1.Takeoff
	end

	if p2 ~= "groundidle" then
		return nil
	end

	return v1.GroundIdle or v1.Idle
end

local function IsLoopingState(p1) --[[ IsLoopingState | Line: 334 ]]
	if p1 == "landing" then
		return false
	end

	return p1 ~= "takeoff"
end

local function SwitchState(p1, p2) --[[ SwitchState | Line: 344 | Upvalues: GetAnimNameForState (copy) ]]
	if p2 == "takeoff" then
		local v1 = p1.Module and p1.Module.Animations

		if v1 and not v1.Takeoff then
			p2 = "flying"
		end
	end

	if p1.CurrentState == p2 then
		return
	end

	local CurrentState = p1.CurrentState

	p1.CurrentState = p2

	local v3 = if if CurrentState == "landing" then false else CurrentState ~= "takeoff" then 0.2 else 0.05

	for k, v in pairs(p1.Tracks) do
		if v.IsPlaying then
			v:Stop(v3)
		end
	end

	local v4 = GetAnimNameForState(p1.Module, p2)
	local v5 = if v4 then p1.Tracks[v4] else v4

	if not v5 then
		return
	end

	v5.Looped = if p2 == "landing" then false else p2 ~= "takeoff"
	v5:Play(if v5.Looped then 0.2 else 0.05)
end

local function ApplyVisibility(p1, p2) --[[ ApplyVisibility | Line: 366 ]]
	local v1 = if p2 then 0 else 1

	for k, v in pairs(p1.Model:GetDescendants()) do
		if v ~= p1.Model.PrimaryPart then
			if v:IsA("BasePart") then
				v.Transparency = v1

				continue
			end

			if v:IsA("Decal") then
				v.Transparency = v1
			end
		end
	end
end

local function CloneSpeciesModel(p1) --[[ CloneSpeciesModel | Line: 379 | Upvalues: PetModules (copy), Assets (copy) ]]
	local v1 = PetModules[p1]

	if not v1 then
		return nil, nil
	end

	local Pets = Assets:FindFirstChild("Pets")
	local v2 = Assets:FindFirstChild("Pets") and Pets:FindFirstChild(v1.AssetName) or Assets:FindFirstChild(v1.AssetName)

	if not (v2 and v2:IsA("Model")) then
		return nil, nil
	end

	local v3 = v2:Clone()

	for k, v in pairs(v3:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = false
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = true
			v.Massless = true
		end
	end

	return v3, v1
end

local function EnsurePrimaryPart(p1) --[[ EnsurePrimaryPart | Line: 399 ]]
	local PrimaryPart = p1.PrimaryPart

	if PrimaryPart and PrimaryPart.Parent then
		return PrimaryPart
	end

	local v1 = p1:FindFirstChild("Torso") or (p1:FindFirstChild("RootPart") or p1:FindFirstChildWhichIsA("BasePart"))

	if v1 then
		p1.PrimaryPart = v1
	end

	return v1
end

local function EnsureSlotAttachment(p1, p2, p3) --[[ EnsureSlotAttachment | Line: 410 ]]
	local PetTarget = p1:FindFirstChild("PetTarget")

	if not PetTarget then
		local PetTarget2 = Instance.new("Attachment")

		PetTarget2.Name = "PetTarget"
		PetTarget2.Parent = p1
		PetTarget = PetTarget2
	end

	local v1 = if p3 then p3 else CFrame.identity

	PetTarget.CFrame = CFrame.new(0, p2, 0) * v1

	return PetTarget
end

local function BuildConstraints(p1, p2, p3) --[[ BuildConstraints | Line: 423 ]]
	local PetPivot = Instance.new("Attachment")

	PetPivot.Name = "PetPivot"
	PetPivot.CFrame = p2
	PetPivot.Parent = p1

	return PetPivot
end

local function SyncAttached(p1) --[[ SyncAttached | Line: 432 ]]
	p1.Model:SetAttribute("AttachedToPetPart", p1.Slot:GetAttribute("PetAttached") ~= false)
end

local function DestroyActive(p1) --[[ DestroyActive | Line: 439 | Upvalues: t4 (copy), t3 (copy), t2 (copy) ]]
	t4[p1] = (t4[p1] or 0) + 1
	t3[p1] = nil

	local v1 = t2[p1]

	if v1 then
		t2[p1] = nil

		for k, v in pairs(v1.Connections) do
			v:Disconnect()
		end

		v1.Connections = {}

		for k, v in pairs(v1.Tracks) do
			v:Stop(0)
		end

		if v1.CarryFruitModel then
			v1.CarryFruitModel:Destroy()
			v1.CarryFruitModel = nil
		end

		if v1.Model and v1.Model.Parent then
			v1.Model:Destroy()
		end
	end

	t4[p1] = nil
end

local function SnapModelToSlot(p1) --[[ SnapModelToSlot | Line: 458 ]]
	local Slot = p1.Slot

	if Slot.Parent then
		p1.Model:PivotTo(Slot.CFrame * p1.SlotAttachment.CFrame)
	end
end

local function BuildSlotModel(p1, p2) --[[ BuildSlotModel | Line: 466 | Upvalues: t3 (copy), t4 (copy), t2 (copy), v4 (ref), Players (copy), CloneSpeciesModel (copy), PetSizes (copy), ComputeFootOffset (copy), EnsureSlotAttachment (copy), RunService (copy), v2 (ref), GetOrCreateAnimator (copy), FindAnimationsOnModel (copy), ApplyPetTypeTag (copy), DestroyActive (ref), SwitchState (copy), ApplyVisibility (copy) ]]
	if t3[p1] then
		return
	end

	local v1 = (t4[p1] or 0) + 1

	t4[p1] = v1

	local v22 = v1

	t3[p1] = v22

	local function Bail() --[[ Bail | Line: 475 | Upvalues: t3 (ref), p1 (copy), v22 (copy), p2 (copy), t2 (ref), v4 (ref) ]]
		if t3[p1] == v22 then
			t3[p1] = nil
		end

		if not p1.Parent then
			return
		end

		local v1 = p1:GetAttribute("PetSpecies")

		if type(v1) ~= "string" or (v1 == "" or v1 == p2 and t2[p1]) then
			return
		end

		task.defer(v4, p1)
	end

	local v3 = p1.Parent
	local v42 = if v3 and v3:IsA("Folder") then Players:FindFirstChild(v3.Name) else nil

	if not v42 then
		return Bail()
	end

	local v6, v7 = CloneSpeciesModel(p2)

	if v6 and v7 then
		v6:SetAttribute("PetID", p1:GetAttribute("PetId"))
		v6:SetAttribute("Owner", v42.Name)
		v6:SetAttribute("OwnerSlot", p1.Name)

		local PrimaryPart = v6.PrimaryPart
		local v8

		if PrimaryPart and PrimaryPart.Parent then
			v8 = PrimaryPart
		else
			local v9 = v6:FindFirstChild("Torso") or (v6:FindFirstChild("RootPart") or v6:FindFirstChildWhichIsA("BasePart"))

			if v9 then
				v6.PrimaryPart = v9
			end

			v8 = v9
		end

		if not v8 then
			v6:Destroy()

			return Bail()
		end

		local v11

		if v7 then
			local Pivot = v7.Pivot

			v11 = if typeof(Pivot) == "Vector3" then CFrame.Angles(math.rad(Pivot.X), math.rad(Pivot.Y), (math.rad(Pivot.Z))) else CFrame.identity
		else
			v11 = CFrame.identity
		end

		v6:PivotTo(v11)

		local v15 = PetSizes.GetScale(p1:GetAttribute("PetSize"), {
			Big = v7.BigScale,
			Huge = v7.HugeScale
		})

		if v15 ~= 1 then
			v6:ScaleTo(v15)
		end

		local v16 = ComputeFootOffset(v6)
		local v17 = v8.CFrame:Inverse() * v6:GetPivot()
		local v18 = EnsureSlotAttachment(p1, v16, v11)

		RunService.Heartbeat:Wait()

		local count = 0

		while count < 60 and not (p1.Position.Magnitude > 1 or p1:GetAttribute("SlotVisualIndex")) do
			RunService.Heartbeat:Wait()

			if (t4[p1] or 0) ~= v22 or (not p1.Parent or p1:GetAttribute("PetSpecies") ~= p2) then
				v6:Destroy()

				return Bail()
			end

			count = count + 1
		end

		if (t4[p1] or 0) == v22 and (p1.Parent and p1:GetAttribute("PetSpecies") == p2) then
			v6:PivotTo(p1.CFrame * v18.CFrame)

			local PetPivot = Instance.new("Attachment")

			PetPivot.Name = "PetPivot"
			PetPivot.CFrame = v17
			PetPivot.Parent = v8
			v8.Anchored = true
			v6.Parent = v2

			if (t4[p1] or 0) == v22 and (p1.Parent and p1:GetAttribute("PetSpecies") == p2) then
				local v19 = GetOrCreateAnimator(v6)

				t = {}
				v21 = PetPivot

				for k, v in pairs((FindAnimationsOnModel(v6, v7.Animations))) do
					local ok, result = pcall(function() --[[ Line: 547 | Upvalues: v19 (copy), v (copy) ]]
						return v19:LoadAnimation(v)
					end)

					if ok and result then
						result.Looped = true
						result.Priority = Enum.AnimationPriority.Movement
						t[k] = result
					end
				end

				local t5 = {
					Owner = v42,
					Slot = p1,
					Species = p2,
					Module = v7,
					Model = v6,
					Primary = v8,
					Animator = v19,
					Tracks = t,
					CurrentState = "",
					SlotAttachment = v18,
					PetAttachment = v21,
					FootOffset = v16,
					SpeciesPivotCFrame = v11,
					Generation = v22,
					Connections = {},
					LastAnimPos = p1.Position,
					LastAnimTime = os.clock(),
					AnimState = "idle"
				}

				t5.IsFlyer = v7.IsFlying == true
				t2[p1] = t5
				ApplyPetTypeTag(v6, p1:GetAttribute("PetType"))

				local function f22(p12, p2) --[[ Line: 579 | Upvalues: DestroyActive (ref), p1 (copy) ]]
					if p2 ~= nil then
						return
					end

					DestroyActive(p1)
				end

				table.insert(t5.Connections, v6.AncestryChanged:Connect(f22))
				task.spawn(function() --[[ Line: 583 | Upvalues: RunService (ref), t2 (ref), p1 (copy), t5 (copy) ]]
					RunService.Heartbeat:Wait()

					if not t2[p1] then
						return
					end

					local v1 = t5
					local Slot = v1.Slot

					if not Slot.Parent then
						t5.LastAnimPos = p1.Position
						t5.LastAnimTime = os.clock()

						return
					end

					v1.Model:PivotTo(Slot.CFrame * v1.SlotAttachment.CFrame)
					t5.LastAnimPos = p1.Position
					t5.LastAnimTime = os.clock()
				end)
				task.spawn(function() --[[ Line: 591 | Upvalues: RunService (ref), t2 (ref), p1 (copy), t5 (copy), SwitchState (ref) ]]
					RunService.Heartbeat:Wait()

					if not t2[p1] then
						return
					end

					local v1

					if t5.IsFlyer then
						local v2 = p1:GetAttribute("FlightPhase") or "Flying"

						v1 = if v2 == "Flying" then "flying" elseif v2 == "Landing" then "landing" elseif v2 == "Grounded" then "groundidle" elseif v2 == "Takeoff" then "takeoff" else "flying"
					else
						v1 = "idle"
					end

					t5.CurrentState = ""
					SwitchState(t5, v1)
				end)
				ApplyVisibility(t5, if p1:GetAttribute("PetVisible") == false then false else true)

				if t3[p1] ~= v22 then
					return
				end

				t3[p1] = nil

				return
			end

			if not v6.Parent then
				return Bail()
			end

			v6:Destroy()

			return Bail()
		end

		v6:Destroy()

		return Bail()
	end

	return Bail()
end

v4 = function(p1) --[[ SyncSlot | Line: 619 | Upvalues: t2 (copy), DestroyActive (ref), t4 (copy), t3 (copy), Players (copy), v2 (ref), BuildSlotModel (copy), ApplyVisibility (copy) ]]
	local v1 = p1:GetAttribute("PetSpecies")
	local v22 = t2[p1]

	if v22 and v22.Species ~= v1 then
		DestroyActive(p1)
		v22 = nil
	end

	if type(v1) == "string" and v1 ~= "" then
		if type(v1) == "string" and (v1 ~= "" and not v22) then
			BuildSlotModel(p1, v1)

			return
		end

		if not v22 then
			return
		end

		v22.Model:SetAttribute("PetID", p1:GetAttribute("PetId"))
		ApplyVisibility(v22, p1:GetAttribute("PetVisible") ~= false)
		v22.Model:SetAttribute("AttachedToPetPart", v22.Slot:GetAttribute("PetAttached") ~= false)
	else
		t4[p1] = (t4[p1] or 0) + 1
		t3[p1] = nil

		local v6 = p1.Parent
		local v7 = if v6 and v6:IsA("Folder") then Players:FindFirstChild(v6.Name) else nil

		if not (v7 and v2) then
			return
		end

		for k, v in pairs(v2:GetChildren()) do
			if v:GetAttribute("OwnerSlot") == p1.Name and v:GetAttribute("Owner") == v7.Name then
				v:Destroy()
			end
		end
	end
end

local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local t5 = {}

local function GetCarryFruitGenModule(p1) --[[ GetCarryFruitGenModule | Line: 661 | Upvalues: t5 (copy), v11 (ref), v12 (ref), ReplicatedStorage (copy) ]]
	if t5[p1] ~= nil then
		return t5[p1]
	end

	if not (v11 and v12) then
		local PlantGenerationModules = ReplicatedStorage:FindFirstChild("PlantGenerationModules")

		if PlantGenerationModules then
			v11 = PlantGenerationModules:FindFirstChild("Fruits")
			v12 = PlantGenerationModules:FindFirstChild("Plants")
		end
	end

	local v1 = nil

	if v11 and v11:FindFirstChild(p1) then
		v1 = v11
	elseif v12 and v12:FindFirstChild(p1) then
		v1 = v12
	end

	if not v1 then
		t5[p1] = false

		return false
	end

	local ok, result = pcall(require, (v1:FindFirstChild(p1)))

	if not (ok and result) then
		t5[p1] = false

		return false
	end

	local t = {
		Module = result
	}

	t.IsPlant = v1 == v12
	t5[p1] = t

	return t5[p1]
end

local function GetCarryFruitAsset(p1) --[[ GetCarryFruitAsset | Line: 691 | Upvalues: v9 (ref), v10 (ref), ReplicatedStorage (copy) ]]
	if not (v9 and v10) then
		local Assets = ReplicatedStorage:FindFirstChild("Assets")

		if Assets then
			v9 = Assets:FindFirstChild("Fruits")
			v10 = Assets:FindFirstChild("Plants")
		end
	end

	if v9 then
		local v1 = v9:FindFirstChild(p1)

		if v1 then
			return v1, false
		end
	end

	if not v10 then
		return nil, false
	end

	local v2 = v10:FindFirstChild(p1)

	if v2 then
		return v2, true
	end

	return nil, false
end

local function LockCarryPart(p1) --[[ LockCarryPart | Line: 712 ]]
	p1.CanCollide = false
	p1.CanQuery = false
	p1.CanTouch = false
	p1.Massless = true
	p1.Anchored = false
end

local function AttachCarryFruit(p1, p2, p3, p4, p5, p6) --[[ AttachCarryFruit | Line: 721 | Upvalues: GetCarryFruitAsset (copy), GetCarryFruitGenModule (copy), v3 (ref) ]]
	if p1.CarryFruitModel then
		p1.CarryFruitModel:Destroy()
		p1.CarryFruitModel = nil
	end

	if not (p1.Primary and p1.Primary.Parent) then
		return
	end

	local FruitPosition = p1.Primary:FindFirstChild("FruitPosition")

	if not (FruitPosition and FruitPosition:IsA("Attachment")) then
		return
	end

	local v1, v2 = GetCarryFruitAsset(p2)

	if not v1 then
		return
	end

	local v32 = GetCarryFruitGenModule(p2)

	if not v32 then
		return
	end

	p1.CarryFruitToken = (p1.CarryFruitToken or 0) + 1

	local CarryFruitToken = p1.CarryFruitToken
	local v4 = v1:Clone()

	for k, v in pairs(v4:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
			v.Massless = true
			v.Anchored = false
		end
	end

	v4.DescendantAdded:Connect(function(p1) --[[ Line: 747 ]]
		if not p1:IsA("BasePart") then
			return
		end

		p1.CanCollide = false
		p1.CanQuery = false
		p1.CanTouch = false
		p1.Massless = true
		p1.Anchored = false
	end)

	if p6 and p6 ~= "" then
		v4:SetAttribute("Mutation", p6)
	end

	local v5 = nil

	if v2 and type(v32.Module.InitPlant) == "function" then
		v5 = pcall(v32.Module.InitPlant, v4, p3, p4)
	else
		local v6, v7

		v6 = v32.Module.InitFruit

		if type(v6) == "function" then
			v7 = pcall(v32.Module.InitFruit, v4, p3, p4)
			v5 = v7
		end
	end

	if v5 then
		v4:PivotTo(CFrame.new(0, -5000, 0))
		v4.Parent = v3
		task.spawn(function() --[[ Line: 771 | Upvalues: v4 (copy), p1 (copy), CarryFruitToken (copy), FruitPosition (copy) ]]
			local count = 0

			repeat
				if not v4 or (not v4.Parent or v4:HasTag("InitializationComplete")) then
					break
				end

				task.wait()
				count = count + 1
			until count > 600

			if p1.CarryFruitToken ~= CarryFruitToken or not v4.Parent then
				v4:Destroy()

				return
			end

			v4:PivotTo(FruitPosition.WorldCFrame)

			local CarryAnchor = Instance.new("Part")

			CarryAnchor.Name = "CarryAnchor"
			CarryAnchor.Size = Vector3.new(0.01, 0.01, 0.01)
			CarryAnchor.Transparency = 1
			CarryAnchor.CanCollide = false
			CarryAnchor.CanQuery = false
			CarryAnchor.CanTouch = false
			CarryAnchor.Massless = true
			CarryAnchor.Anchored = true
			CarryAnchor.CFrame = FruitPosition.WorldCFrame
			CarryAnchor.Parent = v4
			v4.PrimaryPart = CarryAnchor

			for k, v in pairs(v4:GetDescendants()) do
				if v:IsA("BasePart") and v ~= CarryAnchor then
					v.Anchored = false
					v.CanCollide = false
					v.CanQuery = false
					v.CanTouch = false
					v.Massless = true
				end
			end

			for k, v in pairs(v4:GetDescendants()) do
				if v:IsA("BasePart") and v ~= CarryAnchor then
					local WeldConstraint = Instance.new("WeldConstraint")

					WeldConstraint.Part0 = CarryAnchor
					WeldConstraint.Part1 = v
					WeldConstraint.Parent = v
				end
			end

			p1.CarryFruitModel = v4
			p1.CarryFruitAnchor = CarryAnchor
			p1.CarryFruitAttach = FruitPosition
		end)
	else
		v4:Destroy()
	end
end

local function ClearCarryFruit(p1) --[[ ClearCarryFruit | Line: 824 ]]
	p1.CarryFruitToken = (p1.CarryFruitToken or 0) + 1
	p1.CarryFruitAnchor = nil
	p1.CarryFruitAttach = nil

	if not p1.CarryFruitModel then
		return
	end

	p1.CarryFruitModel:Destroy()
	p1.CarryFruitModel = nil
end

local function WatchSlot(p1) --[[ WatchSlot | Line: 835 | Upvalues: v4 (ref), DestroyActive (ref), t2 (copy), ApplyVisibility (copy), ApplyPetTypeTag (copy), AttachCarryFruit (copy) ]]
	p1.CanQuery = false
	p1:GetAttributeChangedSignal("PetSpecies"):Connect(function() --[[ Line: 838 | Upvalues: v4 (ref), p1 (copy) ]]
		v4(p1)
	end)
	p1:GetAttributeChangedSignal("PetSize"):Connect(function() --[[ Line: 840 | Upvalues: DestroyActive (ref), p1 (copy), v4 (ref) ]]
		DestroyActive(p1)
		v4(p1)
	end)
	p1:GetAttributeChangedSignal("PetVisible"):Connect(function() --[[ Line: 845 | Upvalues: t2 (ref), p1 (copy), ApplyVisibility (ref) ]]
		local v1 = t2[p1]

		if not v1 then
			return
		end

		ApplyVisibility(v1, p1:GetAttribute("PetVisible") ~= false)
	end)
	p1:GetAttributeChangedSignal("PetAttached"):Connect(function() --[[ Line: 851 | Upvalues: t2 (ref), p1 (copy) ]]
		local v1 = t2[p1]

		if not v1 then
			return
		end

		v1.Model:SetAttribute("AttachedToPetPart", v1.Slot:GetAttribute("PetAttached") ~= false)
	end)
	p1:GetAttributeChangedSignal("PetId"):Connect(function() --[[ Line: 857 | Upvalues: t2 (ref), p1 (copy) ]]
		local v1 = t2[p1]

		if v1 then
			v1.Model:SetAttribute("PetID", p1:GetAttribute("PetId"))
		end
	end)
	p1:GetAttributeChangedSignal("PetType"):Connect(function() --[[ Line: 863 | Upvalues: t2 (ref), p1 (copy), ApplyPetTypeTag (ref) ]]
		local v1 = t2[p1]

		if v1 then
			ApplyPetTypeTag(v1.Model, p1:GetAttribute("PetType"))
		end
	end)
	p1:GetAttributeChangedSignal("CarryingFruit"):Connect(function() --[[ Line: 869 | Upvalues: t2 (ref), p1 (copy), AttachCarryFruit (ref) ]]
		local v1 = t2[p1]

		if not v1 then
			return
		end

		local v2 = p1:GetAttribute("CarryingFruit")

		if typeof(v2) == "string" and v2 ~= "" then
			AttachCarryFruit(v1, v2, p1:GetAttribute("CarryingFruitSeed") or 0, p1:GetAttribute("CarryingFruitSize") or 1, p1:GetAttribute("CarryingFruitOvertimeGrowth") or 1, p1:GetAttribute("CarryingFruitMutation") or "")

			return
		end

		v1.CarryFruitToken = (v1.CarryFruitToken or 0) + 1
		v1.CarryFruitAnchor = nil
		v1.CarryFruitAttach = nil

		if not v1.CarryFruitModel then
			return
		end

		v1.CarryFruitModel:Destroy()
		v1.CarryFruitModel = nil
	end)
	p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 884 | Upvalues: DestroyActive (ref), p1 (copy) ]]
		if p2 ~= nil then
			return
		end

		DestroyActive(p1)
	end)
	v4(p1)
end

local function WatchPlayerFolder(p1) --[[ WatchPlayerFolder | Line: 891 | Upvalues: WatchSlot (copy) ]]
	for k, v in pairs(p1:GetChildren()) do
		if v:IsA("BasePart") and string.match(v.Name, "^PetPart%d+$") then
			WatchSlot(v)
		end
	end

	p1.ChildAdded:Connect(function(p1) --[[ Line: 897 | Upvalues: WatchSlot (ref) ]]
		if not (p1:IsA("BasePart") and string.match(p1.Name, "^PetPart%d+$")) then
			return
		end

		WatchSlot(p1)
	end)
end

local function WatchRoot(p1) --[[ WatchRoot | Line: 904 | Upvalues: WatchPlayerFolder (copy) ]]
	for k, v in pairs(p1:GetChildren()) do
		if v:IsA("Folder") then
			WatchPlayerFolder(v)
		end
	end

	p1.ChildAdded:Connect(function(p1) --[[ Line: 908 | Upvalues: WatchPlayerFolder (ref) ]]
		if not p1:IsA("Folder") then
			return
		end

		WatchPlayerFolder(p1)
	end)
end

function t.SnapPetsForPlayer(p1, p2) --[[ SnapPetsForPlayer | Line: 913 | Upvalues: t2 (copy) ]]
	for k, v in pairs(t2) do
		if v.Owner == p2 and k.Parent then
			local v1 = k:GetAttribute("PetClaim")

			if type(v1) ~= "string" or v1 == "" then
				v.Model:PivotTo(k.CFrame * v.SlotAttachment.CFrame)
				v.LastAnimPos = k.Position
				v.LastAnimTime = os.clock()
				v.LastVisualPos = v.Primary and v.Primary.Position
				v.LastVisualTime = os.clock()
				v.SmoothedSpeed = 0
				v.LastGoalChangeTime = nil
				v.LastTrackedGoalXZ = nil
			end
		end
	end
end
function t.SnapLocalPetsToFollow(p1) --[[ SnapLocalPetsToFollow | Line: 933 | Upvalues: Players (copy), t2 (copy), CastGroundY (copy) ]]
	local LocalPlayer = Players.LocalPlayer
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v1 then
		return
	end

	local v2 = v1.CFrame
	local LookVector = v2.LookVector
	local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)
	local v4 = if v3.Magnitude < 0.0001 then Vector3.new(0, 0, -1) else v3.Unit
	local Position = v2.Position
	local v6 = CFrame.lookAt(Position, Position + v4)

	for k, v in pairs(t2) do
		if v.Owner == LocalPlayer and (k.Parent and (v.Primary and v.Primary.Parent)) then
			local v7 = k:GetAttribute("PetClaim")

			if type(v7) ~= "string" or v7 == "" then
				local v8 = k:GetAttribute("SlotOffsetX")
				local v9 = k:GetAttribute("SlotOffsetZ")

				if typeof(v8) == "number" and typeof(v9) == "number" then
					local v10 = k:GetAttribute("SlotHeightOffset") or 0
					local v11 = v6 * CFrame.new(v8, -2.5, v9)
					local Position2 = v11.Position
					local v12 = CastGroundY(Position2, Position2.Y)

					if v12 == nil then
						v12 = Position2.Y
					end

					v.LastLocalGroundY = v12

					local v14 = Vector3.new(Position2.X, if v.IsFlyer then v12 + (v.FootOffset or 0) + v10 else v12 + (v.FootOffset or 0), Position2.Z)
					local v15 = v11 - v11.Position
					local v18 = math.atan2(-v15.LookVector.X, -v15.LookVector.Z)
					local v19 = v.SpeciesPivotCFrame or CFrame.identity

					v.Primary.CFrame = CFrame.new(v14) * CFrame.Angles(0, v18, 0) * v19
					v.LocalGoalPos = v14
					v.LocalGoalRotation = v15
					v.LastYaw = v18
					v.LocalChase = true
					v.VirtualSlotPos = nil
					v.ForceFollowUntil = os.clock() + 0.4
					v.LastVisualPos = v14
					v.LastVisualTime = os.clock()
					v.SmoothedSpeed = 0
					v.LastGoalChangeTime = nil
					v.LastTrackedGoalXZ = nil
					v.AnimState = "idle"
				end
			end
		end
	end
end

local function FlightPhaseToState(p1) --[[ FlightPhaseToState | Line: 992 ]]
	if p1 == "Flying" then
		return "flying"
	end

	if p1 == "Landing" then
		return "landing"
	end

	if p1 == "Grounded" then
		return "groundidle"
	end

	if p1 == "Takeoff" then
		return "takeoff"
	end

	return "flying"
end

local function FindLocalOwlPrimary() --[[ FindLocalOwlPrimary | Line: 1002 | Upvalues: Players (copy), t2 (copy) ]]
	local LocalPlayer = Players.LocalPlayer

	for k, v in pairs(t2) do
		if v.Owner == LocalPlayer and v.Species == "Owl" then
			local Primary = v.Primary

			if Primary and Primary.Parent then
				return Primary
			end
		end
	end

	return nil
end

local function PlayOwlHoot(p1) --[[ PlayOwlHoot | Line: 1015 | Upvalues: v5 (ref), FindLocalOwlPrimary (copy), Players (copy), SoundService (copy) ]]
	if type(p1) ~= "string" or p1 == "" then
		return
	end

	if v5 and (v5.Parent and v5.IsPlaying) then
		return
	end

	local v1 = FindLocalOwlPrimary()

	if not v1 then
		local Character = Players.LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		if v2 and v2:IsA("BasePart") then
			v1 = v2
		end
	end

	if not v1 then
		return
	end

	local OwlHoot = Instance.new("Sound")

	OwlHoot.Name = "OwlHoot"
	OwlHoot.SoundId = p1
	OwlHoot.Volume = 4.5
	OwlHoot.RollOffMode = Enum.RollOffMode.InverseTapered
	OwlHoot.RollOffMinDistance = 10
	OwlHoot.RollOffMaxDistance = 400

	local SFXGroup = SoundService:FindFirstChild("SFXGroup")

	if SFXGroup and SFXGroup:IsA("SoundGroup") then
		OwlHoot.SoundGroup = SFXGroup
	end

	OwlHoot.Parent = v1
	v5 = OwlHoot
	OwlHoot:Play()
	OwlHoot.Ended:Once(function() --[[ Line: 1039 | Upvalues: v5 (ref), OwlHoot (copy) ]]
		if v5 == OwlHoot then
			v5 = nil
		end

		OwlHoot:Destroy()
	end)
end

function t.Init(p1) --[[ Init | Line: 1045 ]] end
function t.Start(p1) --[[ Start | Line: 1047 | Upvalues: v1 (ref), v2 (ref), v3 (ref), WatchRoot (copy), Networking (copy), PlayOwlHoot (copy), RunService (copy), t (copy), Players (copy), v7 (ref), RefreshGroundFilter (copy), t2 (copy), CastGroundY (copy), ComputeJumpOffset (copy), SwitchState (copy) ]]
	v1 = Instance.new("Folder")
	v1.Name = "_PetVisualClient"
	v1.Parent = workspace
	v2 = Instance.new("Folder")
	v2.Name = "Models"
	v2.Parent = v1
	v3 = Instance.new("Folder")
	v3.Name = "Carry"
	v3.Parent = v1

	local v12 = workspace:FindFirstChild("PlayerPetReferences") or workspace:WaitForChild("PlayerPetReferences", 30)

	if not (v12 and v12:IsA("Folder")) then
		return
	end

	WatchRoot(v12)
	Networking.SFX.OwlHoot.OnClientEvent:Connect(PlayOwlHoot)
	Networking.Place.TeleportedBack.OnClientEvent:Connect(function() --[[ Line: 1066 | Upvalues: RunService (ref), t (ref), Players (ref) ]]
		task.spawn(function() --[[ Line: 1067 | Upvalues: RunService (ref), t (ref), Players (ref) ]]
			RunService.Heartbeat:Wait()
			t:SnapPetsForPlayer(Players.LocalPlayer)
		end)
	end)

	local v22 = 0

	local function HookLocalHumanoid(p1) --[[ HookLocalHumanoid | Line: 1080 | Upvalues: v22 (ref), Networking (ref) ]]
		p1.Jumping:Connect(function(p13) --[[ Line: 1081 | Upvalues: v22 (ref), Networking (ref) ]]
			if not p13 then
				return
			end

			local v1 = os.clock()

			if not (v1 - v22 < 0.2) then
				v22 = v1
				Networking.Pets.FrogJump:Fire()
			end
		end)
	end

	local function HookLocalCharacter(p1) --[[ HookLocalCharacter | Line: 1089 | Upvalues: v22 (ref), Networking (ref) ]]
		local v1 = p1:FindFirstChildOfClass("Humanoid") or p1:WaitForChild("Humanoid", 10)

		if not (v1 and v1:IsA("Humanoid")) then
			return
		end

		v1.Jumping:Connect(function(p13) --[[ Line: 1081 | Upvalues: v22 (ref), Networking (ref) ]]
			if not p13 then
				return
			end

			local v1 = os.clock()

			if not (v1 - v22 < 0.2) then
				v22 = v1
				Networking.Pets.FrogJump:Fire()
			end
		end)
	end

	Players.LocalPlayer.CharacterAdded:Connect(HookLocalCharacter)

	if Players.LocalPlayer.Character then
		task.spawn(HookLocalCharacter, Players.LocalPlayer.Character)
	end

	Networking.Pets.SnapPetsBroadcast.OnClientEvent:Connect(function(p1) --[[ Line: 1102 | Upvalues: Players (ref), RunService (ref), t (ref) ]]
		if p1 == Players.LocalPlayer.UserId then
			return
		end

		local v1 = Players:GetPlayerByUserId(p1)

		if v1 then
			task.spawn(function() --[[ Line: 1106 | Upvalues: RunService (ref), t (ref), v1 (copy) ]]
				RunService.Heartbeat:Wait()
				t:SnapPetsForPlayer(v1)
			end)
		end
	end)
	RunService:BindToRenderStep("PetVisualFollow", Enum.RenderPriority.Camera.Value + 1, function(p1) --[[ Line: 1113 | Upvalues: Players (ref), v7 (ref), RefreshGroundFilter (ref), t2 (ref), CastGroundY (ref), ComputeJumpOffset (ref) ]]
		local LocalPlayer = Players.LocalPlayer
		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
		local v2 = os.clock()

		if not (v2 - v7 < 1) then
			v7 = v2
			RefreshGroundFilter()
		end

		for k, v in pairs(t2) do
			local v3, v4, v5, v6, v72, v8, v9, v10, v11, v12, v13, v14, v15

			if k.Parent and (v.Primary and v.Primary.Parent) then
				local v16 = nil
				local v17 = k:GetAttribute("SlotOverride")
				local v18 = k:GetAttribute("SlotOffsetX")
				local v19 = k:GetAttribute("SlotOffsetZ")
				local v20 = k:GetAttribute("SlotHeightOffset") or 0
				local v21 = k:GetAttribute("PetClaim")

				if if type(v21) == "string" then v21 ~= "" else false then
					v.ForceFollowUntil = nil
					v17 = true
				elseif v.ForceFollowUntil and os.clock() < v.ForceFollowUntil then
					if v.Owner == LocalPlayer and v1 then
						v17 = false
					else
						v.ForceFollowUntil = nil
					end
				elseif v.ForceFollowUntil then
					v.ForceFollowUntil = nil
				end

				if v.Owner == LocalPlayer and (v1 and (v17 ~= true and (typeof(v18) == "number" and typeof(v19) == "number"))) then
					local v23 = v1.CFrame
					local LookVector = v23.LookVector
					local v24 = Vector3.new(LookVector.X, 0, LookVector.Z)
					local v25 = if v24.Magnitude < 0.0001 then Vector3.new(0, 0, -1) else v24.Unit
					local Position = v23.Position
					local v26 = CFrame.lookAt(Position, Position + v25) * CFrame.new(v18, -2.5, v19)
					local Position2 = v26.Position
					local v28 = Vector3.new(Position2.X, if v.IsFlyer then Position2.Y + v20 else Position2.Y, Position2.Z)

					v.LocalGoalPos = v28
					v.LocalGoalRotation = v26 - v26.Position
					v.LocalChase = true

					local v30 = Vector3.new(v28.X, 0, v28.Z)

					if v.LastTrackedGoalXZ and (v30 - v.LastTrackedGoalXZ).Magnitude > 0.005 then
						v.LastGoalChangeTime = os.clock()
					end

					v.LastTrackedGoalXZ = v30
				else
					local v31 = k.CFrame

					if v31 ~= v.LastSlotCF then
						local v32 = os.clock()

						if v.LastSlotTickAt then
							local v33 = v32 - v.LastSlotTickAt

							if v.SlotTickPeriod then
								v.SlotTickPeriod = v.SlotTickPeriod * 0.7 + math.clamp(v33, 0.01, 0.2) * 0.3
							else
								v.SlotTickPeriod = math.clamp(v33, 0.01, 0.2)
							end
						end

						v.PrevSlotCF = v.LastSlotCF or v31
						v.LastSlotCF = v31
						v.LastSlotTickAt = v32
						v.LastGoalChangeTime = v32
					end

					v3 = if v.PrevSlotCF and v.LastSlotTickAt then v.PrevSlotCF:Lerp(v31, (math.clamp((os.clock() - v.LastSlotTickAt) / (v.SlotTickPeriod or 0.03333333333333333), 0, 1))) else v31
					v16 = v3 * v.SlotAttachment.CFrame
					v.InterpSlotCF = v3
					v.LocalChase = false
				end

				if v.LocalChase then
					local LocalGoalPos = v.LocalGoalPos
					local LocalGoalRotation = v.LocalGoalRotation
					local Position = v.Primary.CFrame.Position
					local v38 = LocalGoalPos.X - Position.X
					local v39 = LocalGoalPos.Z - Position.Z
					local v40 = math.sqrt(v38 * v38 + v39 * v39)
					local v41 = 1 - math.exp(-60 * p1)
					local v42 = v.Module and v.Module.FollowSpeed or 14
					local Owner = v.Owner

					if Owner then
						local Character2 = Owner.Character
						local v43 = if Character2 then Character2:FindFirstChildOfClass("Humanoid") else Character2

						v4 = if v43 then v42 * math.max(1, v43.WalkSpeed / 16) else v42
					else
						v4 = v42
					end

					local v45 = v4 * p1

					if v40 <= 0.05 or v40 <= v45 then
						v5 = LocalGoalPos.X
						v6 = LocalGoalPos.Z
					else
						local v46 = 1 / v40
						local v47 = v45 / math.max(v41, 0.001)

						v5 = Position.X + v38 * v46 * v47
						v6 = Position.Z + v39 * v46 * v47
					end

					if v.IsFlyer then
						local v49 = math.clamp((k:GetAttribute("SlotHeightOffset") or 0) / 1.5, 0, 1)
						local Y = LocalGoalPos.Y

						if v49 < 1 then
							local v50 = CastGroundY(Vector3.new(v5, Position.Y, v6), Position.Y)
							local v51 = if v50 then v50 else v.LastChaseGroundY or Position.Y
							local v52 = v.LastChaseGroundY or v51
							local v53 = v52 + (v51 - v52) * math.clamp(18 * p1, 0, 1)

							v.LastChaseGroundY = v53
							v72 = v53 + (v.FootOffset or 0)
						else
							v72 = Y
						end

						v8 = v72 * (1 - v49) + Y * v49
					else
						local v54 = CastGroundY(Vector3.new(v5, Position.Y, v6), Position.Y)
						local v55 = if v54 then v54 else v.LastChaseGroundY or Position.Y
						local v56 = v.LastChaseGroundY or v55
						local v57 = v56 + (v55 - v56) * math.clamp(18 * p1, 0, 1)

						v.LastChaseGroundY = v57
						v8 = v57 + (v.FootOffset or 0) + ComputeJumpOffset(k)
					end

					local v58 = Vector3.new(v5, v8, v6)
					local v59 = v58 - Position
					local v60 = v59.Magnitude / math.max(p1, 0.001)
					local v63 = math.atan2(-LocalGoalRotation.LookVector.X, -LocalGoalRotation.LookVector.Z)

					if v60 > 0.5 then
						local v64 = Vector3.new(v59.X, 0, v59.Z)

						if v64.Magnitude > 0.0001 then
							local Unit = v64.Unit

							v9 = math.atan2(-Unit.X, -Unit.Z)
						else
							v9 = v63
						end
					else
						v9 = v63
					end

					local v68 = v.LastYaw or v9
					local v69 = v68 + ((v9 - v68 + math.pi) % 6.283185307179586 - math.pi) * math.clamp(12 * p1, 0, 1)

					v.LastYaw = v69
					v.VirtualSlotPos = nil

					local v70 = v.SpeciesPivotCFrame or CFrame.identity

					v.Primary.CFrame = v.Primary.CFrame:Lerp(CFrame.new(v58) * CFrame.Angles(0, v69, 0) * v70, v41)
				else
					local Position = v.Primary.CFrame.Position
					local Position2 = v16.Position
					local v722 = Position2.X - Position.X
					local v73 = Position2.Z - Position.Z
					local v74 = math.sqrt(v722 * v722 + v73 * v73)
					local v75 = 1 - math.exp(-60 * p1)
					local v76 = v.Module and v.Module.FollowSpeed or 14
					local Owner = v.Owner

					if Owner then
						local Character2 = Owner.Character
						local v77 = if Character2 then Character2:FindFirstChildOfClass("Humanoid") else Character2

						v10 = if v77 then v76 * math.max(1, v77.WalkSpeed / 16) else v76
					else
						v10 = v76
					end

					local v79 = v10 * p1

					if v74 > 0.05 and v79 < v74 then
						local v80 = 1 / v74
						local v81 = v79 / math.max(v75, 0.001)

						v11 = Position.X + v722 * v80 * v81
						v12 = Position.Z + v73 * v80 * v81
						v13 = true
					else
						v11 = Position2.X
						v12 = Position2.Z
						v13 = false
					end

					if v.IsFlyer then
						v14 = Position2.Y
					else
						local v82 = CastGroundY(Vector3.new(v11, Position.Y, v12), Position.Y)
						local v83 = if v82 then v82 else v.LastChaseGroundY or Position.Y
						local v84 = v.LastChaseGroundY or v83
						local v85 = v84 + (v83 - v84) * math.clamp(18 * p1, 0, 1)

						v.LastChaseGroundY = v85
						v14 = v85 + (v.FootOffset or 0) + ComputeJumpOffset(k)
					end

					local v86 = Vector3.new(v11, v14, v12)
					local LookVector = (v.InterpSlotCF or v16).LookVector
					local v89 = math.atan2(-LookVector.X, -LookVector.Z)
					local v90 = v86 - Position

					if v13 and v90.Magnitude / math.max(p1, 0.001) > 0.5 then
						local v91 = Vector3.new(v90.X, 0, v90.Z)

						if v91.Magnitude > 0.0001 then
							local Unit = v91.Unit

							v15 = math.atan2(-Unit.X, -Unit.Z)
						else
							v15 = v89
						end
					else
						v15 = v89
					end

					local v95 = v.LastYaw or v15
					local v96 = v95 + ((v15 - v95 + math.pi) % 6.283185307179586 - math.pi) * math.clamp(12 * p1, 0, 1)

					v.LastYaw = v96

					local v97 = v.SpeciesPivotCFrame or CFrame.identity

					v.Primary.CFrame = v.Primary.CFrame:Lerp(CFrame.new(v86) * CFrame.Angles(0, v96, 0) * v97, v75)
					v.VirtualSlotPos = nil
				end

				if v.CarryFruitAnchor and (v.CarryFruitAnchor.Parent and (v.CarryFruitAttach and v.CarryFruitAttach.Parent)) then
					v.CarryFruitAnchor.CFrame = v.CarryFruitAttach.WorldCFrame
				end
			end
		end
	end)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 1349 | Upvalues: v7 (ref), RefreshGroundFilter (ref), t2 (ref), CastGroundY (ref), SwitchState (ref) ]]
		local v1 = os.clock()

		if not (v1 - v7 < 1) then
			v7 = v1
			RefreshGroundFilter()
		end

		for k, v in pairs(t2) do
			local v2, v3

			if k.Parent then
				local Position = k.Position
				local SlotAttachment = v.SlotAttachment

				if SlotAttachment and SlotAttachment.Parent then
					local v4 = v.SpeciesPivotCFrame or CFrame.identity

					if v.IsFlyer then
						local v6 = math.clamp((k:GetAttribute("SlotHeightOffset") or 0) / 1.5, 0, 1)
						local v72 = v.FootOffset or 0
						local v8 = if k:GetAttribute("Perched") == true then true else false

						if v6 < 1 and not (v8 or (if k:GetAttribute("FlightPhase") == "Takeoff" then true else false)) then
							local v10 = os.clock()

							if (v.SlotGroundCastNext or 0) <= v10 then
								local v11 = CastGroundY(Position, Position.Y)

								if v11 ~= nil then
									v.SlotGroundCachedY = v11
								end

								v.SlotGroundCastNext = v10 + 0.06666666666666667
							end

							local SlotGroundCachedY = v.SlotGroundCachedY

							if SlotGroundCachedY == nil then
								SlotGroundCachedY = v.LastGroundY or Position.Y
							end

							local v13 = v.LastGroundY or SlotGroundCachedY
							local v14 = v13 + (SlotGroundCachedY - v13) * math.clamp(18 * p1, 0, 1)

							v.LastGroundY = v14
							v2 = v14 - Position.Y + (v.FootOffset or 0)
						else
							v2 = v72
						end

						v3 = v2 * (1 - v6) + v72 * v6
					else
						local v15 = os.clock()

						if (v.SlotGroundCastNext or 0) <= v15 then
							local v16 = CastGroundY(Position, Position.Y)

							if v16 ~= nil then
								v.SlotGroundCachedY = v16
							end

							v.SlotGroundCastNext = v15 + 0.06666666666666667
						end

						local SlotGroundCachedY = v.SlotGroundCachedY

						if SlotGroundCachedY == nil then
							SlotGroundCachedY = v.LastGroundY or Position.Y
						end

						local v18 = v.LastGroundY or SlotGroundCachedY
						local v19 = v18 + (SlotGroundCachedY - v18) * math.clamp(18 * p1, 0, 1)

						v.LastGroundY = v19
						v3 = v19 - Position.Y + (v.FootOffset or 0)
					end

					SlotAttachment.CFrame = CFrame.new(0, v3, 0) * v4
				end

				if v.IsFlyer then
					local v20 = k:GetAttribute("FlightPhase") or "Flying"
					local v21 = if v20 == "Flying" then "flying" elseif v20 == "Landing" then "landing" elseif v20 == "Grounded" then "groundidle" elseif v20 == "Takeoff" then "takeoff" else "flying"
					local v22 = v.Module and v.Module.Animations

					if v21 == "flying" and (v22 and v22.FlyIdle) then
						local v23 = os.clock()
						local v24 = 0
						local v25 = v.Primary and v.Primary.Position

						if v25 then
							if v.LastVisualPos and v.LastVisualTime then
								local v27 = math.max(0.001, v23 - v.LastVisualTime)
								local Magnitude = (v25 - v.LastVisualPos).Magnitude

								if Magnitude < 50 then
									v24 = Magnitude / v27
								end
							end

							v.LastVisualPos = v25
							v.LastVisualTime = v23
						end

						local v28 = math.clamp(p1 * 6, 0, 1)

						v.SmoothedSpeed = (v.SmoothedSpeed or 0) * (1 - v28) + v24 * v28

						local SmoothedSpeed = v.SmoothedSpeed
						local AnimState = v.AnimState

						v21 = if SmoothedSpeed > 2 then "flying" elseif SmoothedSpeed < 0.6 then "flyidle" elseif AnimState == "flying" or AnimState == "flyidle" then AnimState else "flying"
					end

					v.AnimState = v21
					SwitchState(v, v21)

					continue
				end

				local v29 = os.clock()
				local v30 = 0
				local v31 = v.Primary and v.Primary.Position

				if v31 then
					if v.LastVisualPos and v.LastVisualTime then
						local v33 = math.max(0.001, v29 - v.LastVisualTime)
						local Magnitude = (v31 - v.LastVisualPos).Magnitude

						if Magnitude < 50 then
							v30 = Magnitude / v33
						end
					end

					v.LastVisualPos = v31
					v.LastVisualTime = v29
				end

				local v34 = math.clamp(p1 * 6, 0, 1)

				v.SmoothedSpeed = (v.SmoothedSpeed or 0) * (1 - v34) + v30 * v34

				local SmoothedSpeed = v.SmoothedSpeed
				local v35 = v.AnimState or "idle"

				if v35 == "idle" and SmoothedSpeed > 2 then
					v35 = "walking"
				elseif v35 == "walking" and SmoothedSpeed < 0.6 then
					v35 = "idle"
				end

				v.AnimState = v35
				SwitchState(v, v35)
			end
		end
	end)
end

return t