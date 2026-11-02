--credit to prince games studio
local t = {
	StartOrder = 7
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local Plants = ReplicatedStorage.PlantGenerationModules.Plants
local Fruits = ReplicatedStorage.PlantGenerationModules.Fruits
local Plants2 = ReplicatedStorage.Assets.Plants
local Fruits2 = ReplicatedStorage.Assets.Fruits
local POT = ReplicatedStorage.Assets.POT
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v1 = CFrame.new(0, -0.5, 0.25) * CFrame.Angles(1.5707963267948966, 0, 0)

local function SetModelAnchored(p1) --[[ SetModelAnchored | Line: 27 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Anchored = true
			v2.CanCollide = false
			v2.CastShadow = false
			v2.CanQuery = false
			v2.CanTouch = false
		end
	end
end

local function PreparePartForTool(p1) --[[ PreparePartForTool | Line: 40 ]]
	p1.Anchored = false
	p1.CanCollide = false
	p1.CanQuery = false
	p1.CanTouch = false
	p1.Massless = true
end

local function WeldTo(p1, p2) --[[ WeldTo | Line: 49 ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("BasePart") and v2 ~= p1 then
			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = p1
			WeldConstraint.Part1 = v2
			WeldConstraint.Parent = v2
		end
	end
end

function t.Init(p1) --[[ Init | Line: 60 | Upvalues: Plants (copy), t2 (copy), Fruits (copy) ]]
	for v1, v2 in Plants:GetChildren() do
		if v2:IsA("ModuleScript") then
			t2[("Plant_%*"):format(v2.Name)] = require(v2)
		end
	end

	for v3, v4 in Fruits:GetChildren() do
		if v4:IsA("ModuleScript") then
			t2[("Fruit_%*"):format(v4.Name)] = require(v4)
		end
	end
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 77 ]]
	return p2:GetAttribute("PottedPlant") == true
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 82 | Upvalues: t4 (copy) ]]
	local v1 = t4[p2]

	return if v1 == nil or v1.Pot == nil then false else v1.Pot.Parent ~= nil
end
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 90 | Upvalues: t4 (copy) ]]
	local v1 = t4[p2]

	if not v1 then
		return
	end

	v1.Cancelled = true

	if v1.Pot and v1.Pot.Parent then
		v1.Pot:Destroy()
	end

	if v1.PlantModel and v1.PlantModel.Parent then
		v1.PlantModel:Destroy()
	end

	t4[p2] = nil
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 104 | Upvalues: t5 (copy), Plants2 (copy), t2 (copy), Fruits2 (copy), POT (copy), SetModelAnchored (copy), Players (copy), t4 (copy), ReplicatedStorage (copy), WeldTo (copy), LocalPlayer (copy), v1 (copy) ]]
	if t5[p2] then
		return
	end

	t5[p2] = true
	p1:ClearHandle(p2)

	local v12 = p2:GetAttribute("PlantName")
	local v2 = p2:GetAttribute("Seed")
	local v3 = p2:GetAttribute("Age") or 0
	local v4 = p2:GetAttribute("MaxAge") or 100
	local v5 = p2:GetAttribute("SizeMultiplier") or 1
	local v6 = p2:GetAttribute("Mutation")

	if not (v12 and v2) then
		t5[p2] = nil

		return
	end

	local v7 = Plants2:FindFirstChild(v12)
	local v8 = t2[("Plant_%*"):format(v12)]
	local v9

	if v7 then
		v9 = false
	else
		local v10 = Fruits2:FindFirstChild(v12)

		v8 = t2[("Fruit_%*"):format(v12)]
		v7 = v10
		v9 = true
	end

	if v7 and v8 then
		local v11 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

		if not v11 then
			t5[p2] = nil

			return
		end

		local PottedPlantVisual = POT:Clone()

		PottedPlantVisual.Name = "PottedPlantVisual"
		SetModelAnchored(PottedPlantVisual)

		local PlantRoot = PottedPlantVisual:FindFirstChild("PlantRoot", true)

		if not PlantRoot then
			PottedPlantVisual:Destroy()
			t5[p2] = nil

			return
		end

		PottedPlantVisual:SetAttribute("Owner", Players:GetPlayerFromCharacter(p3) and Players:GetPlayerFromCharacter(p3).UserId or 0)
		PottedPlantVisual.Parent = game.Workspace.PottedPlantVisuals

		local t = {
			Anchor = nil,
			PlantModel = nil,
			Cancelled = false,
			Pot = PottedPlantVisual
		}

		t4[p2] = t

		local function IsCancelledOrCleanup() --[[ IsCancelledOrCleanup | Line: 179 | Upvalues: t (copy), p2 (copy), p3 (copy), t4 (ref), t5 (ref) ]]
			if not t.Cancelled and (p2.Parent == p3 and p3.Parent) then
				return false
			end

			t.Cancelled = true

			if t.Pot and t.Pot.Parent then
				t.Pot:Destroy()
			end

			if t.PlantModel and t.PlantModel.Parent then
				t.PlantModel:Destroy()
			end

			if t4[p2] ~= t then
				t5[p2] = nil

				return true
			end

			t4[p2] = nil
			t5[p2] = nil

			return true
		end

		local v14 = v7:Clone()

		t.PlantModel = v14
		v14:SetAttribute("Age", v3)
		v14:SetAttribute("MaxAge", v4)

		if v6 and v6 ~= "" then
			v14:SetAttribute("Mutation", v6)
		end

		SetModelAnchored(v14)
		v14:PivotTo(PlantRoot.WorldCFrame);
		(v9 and v8.InitFruit or v8.InitPlant)(v14, v2, v5)

		if IsCancelledOrCleanup() then
			return
		end

		v14.Parent = workspace

		local sum = 0

		repeat
			sum = sum + task.wait()

			if IsCancelledOrCleanup() then
				return
			end
		until v14:HasTag("InitializationComplete") or sum > 5

		(v9 and v8.BeginFruitGrowth or v8.BeginPlantGrowth)(v14)
		task.wait()

		if IsCancelledOrCleanup() then
			return
		end

		local Fruits = ReplicatedStorage.Assets.Fruits
		local FruitSpawnLocations = v14:FindFirstChild("FruitSpawnLocations")

		if FruitSpawnLocations then
			local v17 = FruitSpawnLocations:GetChildren()

			if #v17 > 0 then
				local v18 = Fruits:FindFirstChild(v12)
				local v19 = t2[("Fruit_%*"):format(v12)]

				if v18 and v19 then
					local v20 = nil
					local v21 = p2:GetAttribute("SavedFruitsJSON")

					if v21 and v21 ~= "" then
						local ok, result = pcall(function() --[[ Line: 282 | Upvalues: v21 (copy) ]]
							return game:GetService("HttpService"):JSONDecode(v21)
						end)

						if ok and result and #result > 0 then
							v20 = result
						end
					end

					if v20 then
						for v22, v23 in v20 do
							local v24 = FruitSpawnLocations:FindFirstChild((tostring(v23.SpawnLocationIndex))) or v17[v23.SpawnLocationIndex]

							if v24 then
								local v25 = v18:Clone()

								v25:SetAttribute("Age", v4)
								v25:SetAttribute("MaxAge", v4)

								if v23.Mutation and v23.Mutation ~= "" then
									v25:SetAttribute("Mutation", v23.Mutation)
								end

								v25.Parent = v14
								v19.InitFruit(v25, v23.Seed, v23.SizeMultiplier)

								local sum2 = 0

								repeat
									sum2 = sum2 + task.wait()

									if IsCancelledOrCleanup() then
										return
									end
								until v25:HasTag("InitializationComplete") or sum2 > 5

								v19.BeginFruitGrowth(v25)
								task.wait()

								if IsCancelledOrCleanup() then
									return
								end

								if v23.OvertimeGrowth and v23.OvertimeGrowth > 1 then
									v25:ScaleTo(v23.OvertimeGrowth)
								end

								v25:PivotTo(v24.CFrame)
							end
						end
					else
						for v26, v27 in v17 do
							local v28 = v18:Clone()

							v28:SetAttribute("Age", v4)
							v28:SetAttribute("MaxAge", v4)
							v28.Parent = v14
							v19.InitFruit(v28, math.random(1, 999999), v5)

							local sum2 = 0

							repeat
								sum2 = sum2 + task.wait()

								if IsCancelledOrCleanup() then
									return
								end
							until v28:HasTag("InitializationComplete") or sum2 > 5

							v19.BeginFruitGrowth(v28)
							task.wait()

							if IsCancelledOrCleanup() then
								return
							end

							v28:PivotTo(v27.CFrame)
						end
					end
				end
			end
		end

		if IsCancelledOrCleanup() then
			return
		end

		v14.Parent = PottedPlantVisual

		local PrimaryPart = PottedPlantVisual.PrimaryPart

		if PrimaryPart then
			for v29, v30 in PottedPlantVisual:GetDescendants() do
				if v30:IsA("BasePart") then
					v30.Anchored = false
					v30.CanCollide = false
					v30.CanQuery = false
					v30.CanTouch = false
					v30.Massless = true
				end
			end

			WeldTo(PrimaryPart, PottedPlantVisual)
			WeldTo(PrimaryPart, v14)

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

			WeldConstraint.Part0 = Handle
			WeldConstraint.Part1 = v11
			WeldConstraint.Parent = Handle
			PrimaryPart.CFrame = v11.CFrame * CFrame.new(0, -2, 0.5) * CFrame.Angles(-1.5707963267948966, 0, 0)

			local WeldConstraint2 = Instance.new("WeldConstraint")

			WeldConstraint2.Part0 = PrimaryPart
			WeldConstraint2.Part1 = v11
			WeldConstraint2.Parent = PrimaryPart

			if Players:GetPlayerFromCharacter(p3) == LocalPlayer then
				p2.Grip = v1
			end

			t.Anchor = PrimaryPart
		else
			PottedPlantVisual:Destroy()
			v14:Destroy()

			if t4[p2] == t then
				t4[p2] = nil
			end
		end
	end

	t5[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 418 | Upvalues: t5 (copy), t4 (copy) ]]
	if t5[p2] then
		return
	end

	local v1 = t4[p2] and t4[p2].Character or p1:GetCharacterForTool(p2)

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
function t.GetCharacterForTool(p1, p2) --[[ GetCharacterForTool | Line: 435 | Upvalues: Players (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		if v2.Character and p2:IsDescendantOf(v2.Character) then
			return v2.Character
		end

		if v2.Backpack and p2:IsDescendantOf(v2.Backpack) then
			return v2.Character
		end
	end

	return nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 448 | Upvalues: t3 (copy) ]]
	local t = {}

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 452 | Upvalues: p2 (copy), p1 (copy), p3 (copy) ]]
		task.defer(function() --[[ Line: 453 | Upvalues: p2 (ref), p1 (ref), p3 (ref) ]]
			if not (p2 and p2.Parent) then
				p1:ClearHandle(p2)

				return
			end

			local isParent = p2.Parent == p3
			local v1 = p1:HasHandle(p2)

			if isParent and not v1 then
				p1:SpawnHandle(p2, p3)

				return
			end

			if isParent or not v1 then
				return
			end

			p1:ClearHandle(p2)
		end)
	end))

	local function f2() --[[ Line: 469 | Upvalues: p1 (copy), p2 (copy), t (copy), t3 (ref) ]]
		p1:ClearHandle(p2)

		for v1, v2 in t do
			v2:Disconnect()
		end

		t3[p2] = nil
	end

	table.insert(t, p2.Destroying:Connect(f2))
	t3[p2] = t
	task.defer(function() --[[ Line: 478 | Upvalues: p2 (copy), p3 (copy), p1 (copy) ]]
		if not p2 or p2.Parent ~= p3 then
			return
		end

		p1:SpawnHandle(p2, p3)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 486 | Upvalues: Players (copy) ]]
	local v1 = Players:GetPlayerFromCharacter(p2)

	local function CheckTool(p12) --[[ CheckTool | Line: 490 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		p1:SetupTool(p12, p2)
	end

	for v2, v3 in p2:GetChildren() do
		if v3:IsA("Tool") and p1:IsTrackedTool(v3) then
			p1:SetupTool(v3, p2)
		end
	end

	p2.ChildAdded:Connect(CheckTool)
	p2.ChildRemoved:Connect(function(p12) --[[ Line: 503 | Upvalues: p1 (copy) ]]
		if not p12:IsA("Tool") then
			return
		end

		p1:ClearHandle(p12)
	end)

	if not (v1 and v1.Backpack) then
		return
	end

	for v4, v5 in v1.Backpack:GetChildren() do
		if v5:IsA("Tool") and p1:IsTrackedTool(v5) then
			p1:SetupTool(v5, p2)
		end
	end
end

local function SetupTrackedToolFromBackpack(p1, p2, p3) --[[ SetupTrackedToolFromBackpack | Line: 515 ]]
	if not p3:IsA("Tool") then
		return
	end

	if not p1:IsTrackedTool(p3) then
		return
	end

	local Character = p2.Character

	if Character then
		p1:SetupTool(p3, Character)
	end
end

function t.Start(p1) --[[ Start | Line: 523 | Upvalues: BackpackListener (copy), Players (copy) ]]
	local function bindPlayer(p12) --[[ bindPlayer | Line: 524 | Upvalues: p1 (copy), BackpackListener (ref) ]]
		if p12.Character then
			p1:SetupCharacter(p12.Character)
		end

		p12.CharacterAdded:Connect(function(p12) --[[ Line: 526 | Upvalues: p1 (ref) ]]
			p1:SetupCharacter(p12)
		end)
		BackpackListener.bind(p12, function(p13) --[[ Line: 532 | Upvalues: p1 (ref), p12 (copy) ]]
			local v1 = p1

			if not p13:IsA("Tool") then
				return
			end

			if not v1:IsTrackedTool(p13) then
				return
			end

			local Character = p12.Character

			if Character then
				v1:SetupTool(p13, Character)
			end
		end)
	end

	for v1, v2 in Players:GetPlayers() do
		bindPlayer(v2)
	end

	Players.PlayerAdded:Connect(bindPlayer)
end

return t