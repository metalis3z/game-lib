--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local Environment = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Environment"))
local MutationController = require(script.Parent.MutationController)
local Handles = game.Workspace.Handles
local Hold_Above = script.Hold_Above
local Fruits = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Fruits")
local Plants = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Plants")
local Fruits2 = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits")
local Plants2 = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Plants")
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local v1 = CFrame.new(0, -0.5, 0.25)
local v2 = CFrame.new(0, -1.25, -0.5) * CFrame.Angles(-1.5707963267948966, 0, 0)

local function ApplyDecayFade(p1, p2) --[[ ApplyDecayFade | Line: 36 ]]
	if not p2 or p2 <= 0 then
		return
	end

	if p2 > 1 then
		p2 = 1
	end

	local count = 0

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			local v3, v4, v5 = Color3.toHSV(v2.Color)

			v2.Color = Color3.fromHSV(v3, v4 * (1 - p2 * 0.75), v5)
			count = count + 1
		end
	end
end

local v3 = RunService:IsStudio() or Environment.env == "Dev"

local function debugLog(...) --[[ debugLog | Line: 58 | Upvalues: v3 (copy) ]]
	if not v3 then
		return
	end

	print("[FruitHandle]", ...)
end

local function debugWarn(...) --[[ debugWarn | Line: 64 | Upvalues: v3 (copy) ]]
	if not v3 then
		return
	end

	warn("[FruitHandle]", ...)
end

local function enableModelQuery(p1) --[[ enableModelQuery | Line: 89 | Upvalues: v3 (copy), debugWarn (copy) ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			t[v2] = v2.CanQuery
			v2:SetAttribute("_AllowQuery", true)
			v2.CanQuery = true
		end
	end

	if v3 then
		local count = 0

		for v32 in t do
			if v32.CanQuery ~= true then
				count = count + 1
			end
		end

		if count > 0 then
			debugWarn(("enableModelQuery: %d part(s) in %s had CanQuery reverted! Bottom raycast will miss them."):format(count, p1:GetFullName()))
		end
	end

	return t
end

local function restoreModelQuery(p1) --[[ restoreModelQuery | Line: 115 ]]
	for v1, v2 in p1 do
		if v1 and v1.Parent then
			v1:SetAttribute("_AllowQuery", nil)
			v1.CanQuery = v2
		end
	end
end

function t.Init(p1) --[[ Init | Line: 124 | Upvalues: Fruits2 (copy), t6 (copy), Plants2 (copy) ]]
	for v1, v2 in Fruits2:GetChildren() do
		if v2:IsA("ModuleScript") then
			t6[("Fruit_%*"):format(v2.Name)] = require(v2)
		end
	end

	for v3, v4 in Plants2:GetChildren() do
		if v4:IsA("ModuleScript") then
			t6[("Plant_%*"):format(v4.Name)] = require(v4)
		end
	end
end
function t.Start(p1) --[[ Start | Line: 138 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 143 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 147 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 158 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
	p2.Massless = true
end
function t.PrepareMushroom(p1, p2) --[[ PrepareMushroom | Line: 166 ]]
	p2.Anchored = false
	p2.CanCollide = true
	p2.CanQuery = false
	p2.CanTouch = true
	p2.CollisionGroup = "OnlyPlayers"
	p2.AssemblyLinearVelocity = Vector3.new(0, 100, 0)

	local v1 = script.Mushroom:Clone()

	v1.Parent = p2
	v1.Enabled = true
	p2.Massless = true
end
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 179 | Upvalues: debugLog (copy), t4 (copy) ]]
	debugLog("ClearHandle called for tool:", p2.Name)

	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 185 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end

	local v3 = t4[p2]

	if not v3 then
		return
	end

	if v3.animTrack then
		v3.animTrack:Stop()
		v3.animTrack = nil
	end

	if v3.model and v3.model.Parent then
		v3.model:Destroy()
	end

	if v3.handle and v3.handle.Parent then
		v3.handle:Destroy()
	end

	t4[p2] = nil
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 209 | Upvalues: t4 (copy) ]]
	local v1 = t4[p2]

	return v1 and (v1.handle and v1.handle.Parent) and true or false
end
function t.GetModelMetrics(p1, p2) --[[ GetModelMetrics | Line: 217 | Upvalues: debugWarn (copy), debugLog (copy) ]]
	local v1, v2 = p2:GetBoundingBox()
	local Position = v1.Position
	local v3 = (1 / 0)
	local v4 = (-1 / 0)

	for v5, v6 in p2:GetDescendants() do
		if v6:IsA("BasePart") and v6.Transparency < 1 then
			local v7 = v6.Position.Y - v6.Size.Y / 2
			local v8 = v6.Position.Y + v6.Size.Y / 2

			if v7 < v3 then
				v3 = v7
			end

			if v4 < v8 then
				v4 = v8
			end
		end
	end

	if v3 == (1 / 0) or v4 == (-1 / 0) then
		debugWarn(("GetModelMetrics: \'%s\' has no visible parts right now - falling back to bounding box (size %.1f x %.1f x %.1f)"):format(p2.Name, v2.X, v2.Y, v2.Z))
		v3 = Position.Y - v2.Y / 2
		v4 = Position.Y + v2.Y / 2
	end

	local v9 = v4 - v3
	local v10 = Vector3.new(Position.X, v3, Position.Z)
	local v11 = if v2.X > 8 or v9 > 8 then true elseif v2.Z > 8 then true else false

	debugLog(("GetModelMetrics \'%s\': height=%.2f bounds=(%.1f, %.1f, %.1f) oversized=%s"):format(p2.Name, v9, v2.X, v2.Y, v2.Z, (tostring(v11))))

	return v9, v10, v11
end
function t.WaitForAttributes(p1, p2, p3) --[[ WaitForAttributes | Line: 262 | Upvalues: debugLog (copy), debugWarn (copy) ]]
	local function ready() --[[ ready | Line: 263 | Upvalues: p2 (copy) ]]
		return if p2:GetAttribute("FruitName") == nil then false else p2:GetAttribute("Seed") ~= nil
	end

	if if p2:GetAttribute("FruitName") == nil then false elseif p2:GetAttribute("Seed") == nil then false else true then
		return true
	end

	debugLog("Waiting for attributes to replicate on tool:", p2.Name)

	local v2 = false
	local v3 = Instance.new("BindableEvent")
	local v4 = p2.AttributeChanged:Connect(function() --[[ Line: 283 | Upvalues: p2 (copy), v2 (ref), v3 (copy) ]]
		if not (if p2:GetAttribute("FruitName") == nil then false else p2:GetAttribute("Seed") ~= nil) then
			return
		end

		v2 = true
		v3:Fire()
	end)

	if if p2:GetAttribute("FruitName") == nil then false elseif p2:GetAttribute("Seed") == nil then false else true then
		v2 = true
		v4:Disconnect()
		v3:Destroy()

		return true
	end

	task.delay(p3, function() --[[ Line: 298 | Upvalues: v2 (ref), v3 (copy) ]]
		if v2 then
			return
		end

		v3:Fire()
	end)
	v3.Event:Wait()
	v4:Disconnect()
	v3:Destroy()

	if v2 then
		return v2
	end

	debugWarn("TIMEOUT waiting for attributes on tool:", p2.Name)

	return v2
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 315 | Upvalues: t5 (copy), Players (copy), LocalPlayer (copy), debugWarn (copy), Fruits (copy), Plants (copy), t6 (copy), MutationController (copy), ApplyDecayFade (copy), debugLog (copy), enableModelQuery (copy), restoreModelQuery (copy), Handles (copy), t4 (copy), v1 (copy), Hold_Above (copy), v2 (copy) ]]
	if t5[p2] then
		return
	end

	t5[p2] = true
	p1:ClearHandle(p2)

	local v12 = Players:GetPlayerFromCharacter(p3) == LocalPlayer

	if not p1:WaitForAttributes(p2, 5) then
		debugWarn("SpawnHandle ABORTED - attributes never replicated. Tool:", p2.Name)
		t5[p2] = nil

		return
	end

	local v22 = p2:GetAttribute("FruitName")
	local v3 = p2:GetAttribute("Seed")
	local v4 = p2:GetAttribute("SizeMultiplier") or 1
	local _ = p2:GetAttribute("OvertimeGrowth") or 1
	local v5 = p2:GetAttribute("Mutation")
	local v6 = p2:GetAttribute("DecayAlpha")

	if not (v22 and v3) then
		t5[p2] = nil

		return
	end

	local v7 = Fruits:FindFirstChild(v22) or Plants:FindFirstChild(v22)

	if not v7 then
		debugWarn("SpawnHandle: no asset template for", v22)
		t5[p2] = nil

		return
	end

	local v8 = if v7.Parent.Name == Fruits.Name then true else false
	local v10, v11

	if v8 then
		local v122 = ("Fruit_%*"):format(v22)

		if v122 then
			v10 = v122
		else
			v11 = ("Plant_%*"):format(v22)
			v10 = v11
		end
	else
		v11 = ("Plant_%*"):format(v22)
		v10 = v11
	end

	local v13 = t6[v10]

	if not v13 then
		debugWarn("SpawnHandle: no generation module for", v22)
		t5[p2] = nil

		return
	end

	local v14 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v14 then
		debugWarn("SpawnHandle: character has no Right Arm / RightHand")
		t5[p2] = nil

		return
	end

	-- Offset de sujecion segun rig. R6 ("Right Arm", 1x2x1) conserva el valor
	-- original; R15 ("RightHand", parte pequena) acerca la fruta a la palma para
	-- que no quede colgando lejos.
	local armOffset = if v14.Name == "Right Arm" then v2 else CFrame.new(0, -0.3, -0.2) * CFrame.Angles(-math.pi / 2, 0, 0)

	local Build = v7:Clone()

	Build:SetAttribute("MaxAge", 100000)
	Build:SetAttribute("Age", 100000)

	if v5 and v5 ~= "" then
		Build:SetAttribute("Mutation", v5)
	end

	v13[if v8 then "InitFruit" else "InitPlant"](Build, v3, v4)

	local sum = 0

	repeat
		sum = sum + task.wait()
	until Build:HasTag("InitializationComplete") or sum > 5

	if sum > 5 then
		debugWarn("SpawnHandle: initialization timed out for", v22, "- metrics below may be measured mid-init")
	end

	v13[if v8 then "BeginFruitGrowth" else "BeginPlantGrowth"](Build)

	local HarvestPrompt = Build:FindFirstChild("HarvestPrompt", true)

	if HarvestPrompt and HarvestPrompt:IsA("ProximityPrompt") then
		HarvestPrompt:Destroy()
	end

	MutationController:ApplyMutation(Build)

	if not v5 or v5 == "" then
		ApplyDecayFade(Build, v6)
	end

	local v17, _2, v18 = p1:GetModelMetrics(Build)
	local PrimaryPart = Build.PrimaryPart

	if not PrimaryPart then
		debugWarn("SpawnHandle: fruit has no PrimaryPart after init:", v22)
		Build:Destroy()
		t5[p2] = nil

		return
	end

	local FruitAnchor = Instance.new("Part")

	FruitAnchor.Name = "FruitAnchor"
	FruitAnchor.Size = Vector3.new(0.01, 0.01, 0.01)
	FruitAnchor.Transparency = 1
	FruitAnchor.CanCollide = false
	FruitAnchor.CanQuery = false
	FruitAnchor.CanTouch = false
	FruitAnchor.Massless = true

	local v19 = if Build:GetAttribute("FlipWhenHeld") == true then true elseif ({
	Strawberry = true
})[v22] == true then true else false

	if v19 then
		local v20 = Build:GetBoundingBox()
		local v21 = CFrame.Angles(math.pi, 0, 0)

		for v222, v23 in Build:GetDescendants() do
			if v23:IsA("BasePart") then
				v23.CFrame = v20 * v21 * v20:ToObjectSpace(v23.CFrame)
			end
		end

		debugLog(("\'%s\' flipped 180 around bounding-box center BEFORE bottom detection"):format(v22))
	end

	local v24 = (1 / 0)
	local v25 = nil

	for v26, v27 in Build:GetDescendants() do
		if v27:IsA("BasePart") and v27.Transparency < 1 then
			local v28 = v27.Position.Y - v27.Size.Y / 2

			if v28 < v24 then
				v24 = v28
				v25 = v27
			end
		end
	end

	if v24 == (1 / 0) then
		v24 = PrimaryPart.Position.Y - PrimaryPart.Size.Y / 2
		debugWarn("SpawnHandle: no visible parts when finding bottom of", v22, "- using PrimaryPart fallback Y =", v24)
	end

	Build.Parent = workspace

	local v29 = enableModelQuery(Build)
	local v30 = RaycastParams.new()

	v30.FilterDescendantsInstances = { Build }
	v30.FilterType = Enum.RaycastFilterType.Include

	local v31 = CFrame.new(PrimaryPart.Position.X, v24, PrimaryPart.Position.Z)
	local v33 = Vector3.new(PrimaryPart.Position.X, PrimaryPart.Position.Y - 100, PrimaryPart.Position.Z)

	for i = 1, 20 do
		local v34, v35, v36
		local v37 = workspace:Raycast(v33, Vector3.new(0, 300, 0), v30)

		if v37 then
			if v37.Instance.Transparency >= 1 then
				v33 = Vector3.new(v33.X, v37.Position.Y + 0.01, v33.Z)
			else
				local v40 = CFrame.new(v37.Position)

				debugLog(("SpawnHandle: bottom raycast hit \'%s\' at Y=%.2f for \'%s\'%s"):format(v37.Instance.Name, v37.Position.Y, v22, if v19 then " (post-flip geometry)" else ""))
				v31 = v40

				break
			end
		else
			if v25 then
				v34 = v25.Name

				if v34 then
					v35 = v22
					v36 = v24
				else
					v35 = v22
					v36 = v24
					v34 = "?"
				end
			else
				v35 = v22
				v36 = v24
				v34 = "?"
			end

			debugWarn(("SpawnHandle: bottom raycast MISSED for \'%s\' - using iterated lowestY=%.2f (part: %s). If this is frequent, check the asset\'s CanQuery/Transparency."):format(v35, v36, v34))

			break
		end
	end

	restoreModelQuery(v29)
	FruitAnchor.CFrame = v31 * CFrame.new(0, 0.5, 0)
	FruitAnchor.Parent = Build

	local Part = Instance.new("Part")

	Part.Transparency = 1
	Part.Anchored = true
	Part.CanCollide = false
	Part.Size = Vector3.new(1, 1, 1)
	Part.Parent = game.Workspace.Temporary

	local v47 = p2.Parent and p2.Parent:FindFirstChild("HumanoidRootPart")

	Part.CFrame = v47 and v47.CFrame or v31

	local Default = game.SoundService.SFX.FruitSFX.Default

	if v5 and v5 ~= "" then
		for k, v in pairs(game.SoundService.SFX.FruitSFX:GetChildren()) do
			if v.Name == v5 then
				Default = v

				break
			end
		end
	end

	local v49 = Default:Clone()

	v49.Parent = Part
	v49.PlaybackSpeed = 1 + math.random(-15, 15) / 100

	if v18 then
		v49.Volume = v49.Volume * 1.75
	end

	v49.Playing = true
	game.Debris:AddItem(Part, v49.TimeLength * v49.PlaybackSpeed)
	Build.PrimaryPart = FruitAnchor

	for v50, v51 in Build:GetDescendants() do
		if v51:IsA("BasePart") then
			if v51:HasTag("MuhsroomTop") then
				p1:PrepareMushroom(v51)

				continue
			end

			p1:PreparePartForTool(v51)
		end
	end

	local v52 = Build:GetAttribute("HeldYOffset")
	local v53 = if type(v52) == "number" then v52 else ({
	["Moon Bloom"] = 1,
	["Dragon\'s Breath"] = 1,
	Bamboo = 3
})[v22] or 0

	for v54, v55 in Build:GetDescendants() do
		if v55:IsA("BasePart") and v55 ~= FruitAnchor then
			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = FruitAnchor
			WeldConstraint.Part1 = v55
			WeldConstraint.Parent = v55
		end
	end

	Build.Name = "Build"
	Build.Parent = Handles
	t4[p2] = {
		handle = FruitAnchor,
		model = Build
	}

	local Handle = Instance.new("Part")

	Handle.Name = "Handle"
	Handle.Size = Vector3.new(1, 1, 1)
	Handle.Transparency = 1
	Handle.CanCollide = false
	Handle.CanQuery = false
	Handle.CanTouch = false
	Handle.Massless = true
	Handle.Parent = p2

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Parent = Handle
	WeldConstraint.Part0 = Handle
	WeldConstraint.Part1 = v14

	if v12 then
		p2.Grip = v1
	end

	if v18 then
		debugLog(("\'%s\' is OVERSIZED (height %.2f vs threshold %d) -> hold-above"):format(v22, v17, 8))
		FruitAnchor.CFrame = v31 * CFrame.new(0, -0.5, 0)

		local Head = p3:FindFirstChild("Head")

		if Head then
			local Humanoid = p3:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				local Animator = Humanoid:FindFirstChildOfClass("Animator")

				if Animator and Hold_Above then
					local ok, result = pcall(function() --[[ Line: 637 | Upvalues: Animator (copy), Hold_Above (ref) ]]
						return Animator:LoadAnimation(Hold_Above)
					end)

					if ok and result then
						result.Looped = true
						result.Priority = Enum.AnimationPriority.Action4
						result:Play()
						t4[p2].animTrack = result
					else
						debugWarn("Hold-above animation failed to load:", result)
					end
				end
			end

			FruitAnchor.CFrame = Head.CFrame * CFrame.new(0, v53 + 1, 0)

			local WeldConstraint2 = Instance.new("WeldConstraint")

			WeldConstraint2.Part0 = FruitAnchor
			WeldConstraint2.Part1 = Head
			WeldConstraint2.Parent = FruitAnchor
		else
			debugWarn("Oversized fruit but no Head found - falling back to arm hold")
			FruitAnchor.CFrame = v14.CFrame * armOffset

			local WeldConstraint2 = Instance.new("WeldConstraint")

			WeldConstraint2.Part0 = FruitAnchor
			WeldConstraint2.Part1 = v14
			WeldConstraint2.Parent = FruitAnchor
		end
	else
		debugLog(("\'%s\' is normal-sized (height %.2f) -> arm hold"):format(v22, v17))
		FruitAnchor.CFrame = v14.CFrame * armOffset

		local WeldConstraint2 = Instance.new("WeldConstraint")

		WeldConstraint2.Part0 = FruitAnchor
		WeldConstraint2.Part1 = v14
		WeldConstraint2.Parent = FruitAnchor
	end

	debugLog("SpawnHandle complete for:", p2.Name)
	t5[p2] = nil

	if p2.Parent == p3 then
		return
	end

	p1:ClearHandle(p2)
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 690 | Upvalues: t5 (copy), t3 (copy) ]]
	if t5[p2] then
		return
	end

	local v1 = t3[p2]

	if not v1 then
		return
	end

	local v2 = if p2.Parent == v1 then true else false
	local v3 = p1:HasHandle(p2)

	if v2 and not v3 then
		p1:SpawnHandle(p2, v1)

		return
	end

	if v2 or not v3 then
		return
	end

	p1:ClearHandle(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 706 | Upvalues: t2 (copy), t3 (copy), t5 (copy) ]]
	local v1 = t2[p2]

	if v1 then
		for v2, v3 in v1 do
			v3:Disconnect()
		end

		t2[p2] = nil
	end

	t3[p2] = nil
	t5[p2] = nil
end
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 718 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 723 ]]
	return p2:GetAttribute("HarvestedFruit") == true
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 727 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 733 | Upvalues: p2 (copy), p1 (copy), t3 (ref) ]]
		task.defer(function() --[[ Line: 734 | Upvalues: p2 (ref), p1 (ref), t3 (ref) ]]
			if not p2 then
				return
			end

			if not p2.Parent then
				p1:ClearHandle(p2)

				return
			end

			if not t3[p2] then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	table.insert(t, p2.Destroying:Connect(function() --[[ Line: 748 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:CleanupTool(p2)
	end))
	t2[p2] = t
	task.defer(function() --[[ Line: 754 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.DisconnectAllFruitTools(p1) --[[ DisconnectAllFruitTools | Line: 761 | Upvalues: t2 (copy) ]]
	for v1 in t2 do
		p1:DisconnectTool(v1)
	end
end
function t.CleanupAllToolsForCharacter(p1, p2) --[[ CleanupAllToolsForCharacter | Line: 767 | Upvalues: t3 (copy), Handles (copy) ]]
	for v1, v2 in t3 do
		if v2 == p2 then
			p1:CleanupTool(v1)
		end
	end

	for v3, v4 in Handles:GetChildren() do
		if v4.Name == "Build" and v4:IsA("Model") then
			local PrimaryPart = v4.PrimaryPart

			if PrimaryPart then
				for v5, v6 in PrimaryPart:GetDescendants() do
					if v6:IsA("WeldConstraint") then
						local Part1 = v6.Part1

						if Part1 and Part1:IsDescendantOf(p2) then
							v4:Destroy()

							break
						end
					end
				end
			end
		end
	end
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 794 | Upvalues: t4 (copy), Players (copy) ]]
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 797 | Upvalues: t4 (ref), p1 (copy) ]]
		if not (p12:IsA("Tool") and t4[p12]) then
			return
		end

		p1:CleanupTool(p12)
	end)
	p2.Destroying:Connect(function() --[[ Line: 806 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:CleanupAllToolsForCharacter(p2)
	end)
	task.defer(function() --[[ Line: 810 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
		if not (p2 and p2.Parent) then
			return
		end

		for v1, v2 in p2:GetChildren() do
			if v2:IsA("Tool") then
				if p1:IsTrackedTool(v2) then
					p1:SetupTool(v2, p2)

					continue
				end

				p1:ListenForTrackedAttribute(v2, p2)
			end
		end

		local v3 = Players:GetPlayerFromCharacter(p2)

		if not (v3 and v3.Backpack) then
			p2.ChildAdded:Connect(function(p13) --[[ Line: 839 | Upvalues: p2 (ref), p1 (ref) ]]
				if not p13:IsA("Tool") then
					return
				end

				task.defer(function() --[[ Line: 841 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
					if not (p13 and (p13.Parent and (p2 and p2.Parent))) then
						return
					end

					if p1:IsTrackedTool(p13) then
						p1:SetupTool(p13, p2)
					else
						p1:ListenForTrackedAttribute(p13, p2)
					end
				end)
			end)

			return
		end

		for v4, v5 in v3.Backpack:GetChildren() do
			if v5:IsA("Tool") then
				if p1:IsTrackedTool(v5) then
					p1:SetupTool(v5, p2)

					continue
				end

				p1:ListenForTrackedAttribute(v5, p2)
			end
		end

		p2.ChildAdded:Connect(function(p13) --[[ Line: 839 | Upvalues: p2 (ref), p1 (ref) ]]
			if not p13:IsA("Tool") then
				return
			end

			task.defer(function() --[[ Line: 841 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
				if not (p13 and (p13.Parent and (p2 and p2.Parent))) then
					return
				end

				if p1:IsTrackedTool(p13) then
					p1:SetupTool(p13, p2)
				else
					p1:ListenForTrackedAttribute(p13, p2)
				end
			end)
		end)
	end)
end
function t.ListenForTrackedAttribute(p1, p2, p3) --[[ ListenForTrackedAttribute | Line: 857 | Upvalues: t2 (copy) ]]
	if t2[p2] then
		return
	end

	local v1 = nil

	v1 = p2.AttributeChanged:Connect(function(p12) --[[ Line: 862 | Upvalues: p1 (copy), p2 (copy), v1 (ref), p3 (copy) ]]
		if p12 ~= "HarvestedFruit" or not p1:IsTrackedTool(p2) then
			return
		end

		v1:Disconnect()
		task.defer(function() --[[ Line: 865 | Upvalues: p2 (ref), p3 (ref), p1 (ref) ]]
			if not (p2 and (p2.Parent and (p3 and p3.Parent))) then
				return
			end

			p1:SetupTool(p2, p3)
		end)
	end)
	p2.Destroying:Once(function() --[[ Line: 874 | Upvalues: v1 (ref) ]]
		if not v1.Connected then
			return
		end

		v1:Disconnect()
	end)

	if not p1:IsTrackedTool(p2) then
		return
	end

	v1:Disconnect()
	task.defer(function() --[[ Line: 883 | Upvalues: p2 (copy), p3 (copy), p1 (copy) ]]
		if not (p2 and (p2.Parent and (p3 and p3.Parent))) then
			return
		end

		p1:SetupTool(p2, p3)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 891 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 896 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 903 | Upvalues: p2 (copy), p1 (copy) ]]
		if p12:IsA("Tool") then
			task.defer(function() --[[ Line: 905 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
				local Character = p2.Character

				if not (p12 and (p12.Parent and (Character and Character.Parent))) then
					return
				end

				if p1:IsTrackedTool(p12) then
					p1:SetupTool(p12, Character)
				else
					p1:ListenForTrackedAttribute(p12, Character)
				end
			end)
		end
	end)
end

return t