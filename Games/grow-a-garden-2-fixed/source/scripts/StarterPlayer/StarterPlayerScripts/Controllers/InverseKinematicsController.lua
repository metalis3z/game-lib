--credit to quartz games studio
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local t = {}
local t2 = {}
local t3 = {}
local v1 = 0
local v2 = false

local function profileBegin(p1) --[[ profileBegin | Line: 22 ]]
	debug.profilebegin("Controllers/InverseKinematicsController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 26 ]]
	debug.profileend()
end

local function getGardenOwner(p1) --[[ getGardenOwner | Line: 30 ]]
	local v1 = if p1 then p1.Parent and p1.Parent.Parent else p1

	if v1 then
		return v1:GetAttribute("Owner")
	end

	return nil
end

local function isOwner(p1, p2) --[[ isOwner | Line: 38 ]]
	local v1 = if p2 then p2.Parent and p2.Parent.Parent else p2
	local v2 = if v1 then v1:GetAttribute("Owner") else nil

	if not v2 then
		return false
	end

	return if p1.Name == v2 then true else tostring(p1.UserId) == v2
end

local function unregisterPlant(p1) --[[ unregisterPlant | Line: 44 | Upvalues: t3 (copy), t2 (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	t3[p1] = nil
	t2[p1] = nil

	if v1.jawValue then
		v1.jawValue:Destroy()
	end

	if not v1.lungeValue then
		return
	end

	v1.lungeValue:Destroy()
end

local function updateRegisteredPlant(p1, p2) --[[ updateRegisteredPlant | Line: 53 | Upvalues: t3 (copy), t2 (copy), Players (copy) ]]
	if p1.Parent then
		debug.profilebegin("Controllers/InverseKinematicsController/Update")

		local basePart = p2.basePart
		local topPart = p2.topPart
		local chain = p2.chain
		local topJawData = p2.topJawData
		local bottomJawData = p2.bottomJawData
		local topJawPivot = p2.topJawPivot
		local bottomJawPivot = p2.bottomJawPivot
		local v1 = os.clock()
		local v2 = p2.lungeValue.Value
		local v3 = math.sin(v1 * 1.5) * 0.03 + math.sin(v1 * 3.1) * 0.01
		local Position = basePart.Position

		debug.profilebegin("Controllers/InverseKinematicsController/Update/scanPlayers")

		local v4 = (1 / 0)
		local v5 = nil

		for v8, v9 in Players:GetPlayers() do
			local v6, v7
			local v10 = if p1 then p1.Parent and p1.Parent.Parent else p1

			v6 = if v10 then v10:GetAttribute("Owner") else nil
			v7 = if v6 then if v9.Name == v6 then true elseif tostring(v9.UserId) == v6 then true else false else false

			if not v7 then
				local Character = v9.Character

				if Character then
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					if HumanoidRootPart then
						local Magnitude = (HumanoidRootPart.Position - Position).Magnitude

						if Magnitude < v4 then
							v4 = Magnitude
							v5 = HumanoidRootPart
						end
					end
				end
			end
		end

		debug.profileend()

		if v5 and v4 <= 15 then
			local v12 = v5.Position - Position
			local v13 = Vector3.new(v12.X, 0, v12.Z)

			if v13.Magnitude > 0.1 then
				local v16 = math.atan2(-v13.X, -v13.Z)
				local _, v17, _2 = basePart.CFrame:ToEulerAnglesYXZ()

				basePart.CFrame = CFrame.new(Position) * CFrame.Angles(0, v17 + ((v16 - v17 + math.pi) % 6.283185307179586 - math.pi) * 0.08, 0)
			end
		elseif not (if p1:FindFirstChildOfClass("Highlight") == nil then false else true) then
			local _, v19, _2 = basePart.CFrame:ToEulerAnglesYXZ()
			local v20 = (p2.originalBaseAngle - v19 + math.pi) % 6.283185307179586 - math.pi

			if math.abs(v20) > 0.001 then
				basePart.CFrame = CFrame.new(Position) * CFrame.Angles(0, v19 + v20 * 0.05, 0)
			end
		end

		debug.profilebegin("Controllers/InverseKinematicsController/Update/computeSwayChain")

		local t = { basePart.CFrame }
		local v21 = basePart.CFrame

		for v22, v23 in chain do
			local v24 = v21 * v23.restOffset * CFrame.Angles(v3, 0, 0)

			t[v22 + 1] = v24
			v21 = v24
		end

		debug.profileend()

		local Position2 = (t[#t] * CFrame.new(0, chain[#chain].part.Size.Y / 2, 0)).Position
		local v25 = Vector3.new(0, 1, 0)
		local v26 = 0
		local v27 = p1:GetAttribute("LungeTarget")

		if v2 > 0.001 and v27 then
			local Position3 = basePart.Position
			local v28 = Position2 - Position3
			local v29 = v27 - Position3

			if v28.Magnitude > 0.01 and v29.Magnitude > 0.01 then
				local Unit = v28.Unit
				local Unit2 = v29.Unit
				local v30 = Unit:Cross(Unit2)

				if v30.Magnitude > 0.0001 then
					v25 = v30.Unit
					v26 = math.acos((math.clamp(Unit:Dot(Unit2), -1, 1))) * v2 / #chain
				end
			end
		end

		debug.profilebegin("Controllers/InverseKinematicsController/Update/rebuildChain")

		local v33 = basePart.CFrame
		local v34 = CFrame.fromAxisAngle(v25, v26)

		for v35, v36 in chain do
			local v37 = v33 * v36.restOffset * CFrame.Angles(v3, 0, 0)

			if v26 > 0.0001 then
				v37 = CFrame.new(v37.Position) * (v34 * (v37 - v37.Position))
			end

			v36.part.CFrame = v37
			v33 = v37
		end

		debug.profileend()
		debug.profilebegin("Controllers/InverseKinematicsController/Update/updateAttachments")

		for v39, v40 in p2.attachmentData do
			v40.part.CFrame = v40.parent.CFrame * v40.offset
		end

		debug.profileend()
		debug.profilebegin("Controllers/InverseKinematicsController/Update/updateHeadBase")

		for v41, v42 in p2.baseData do
			v42.part.CFrame = topPart.CFrame * v42.offset
		end

		debug.profileend()

		local v43 = p2.jawValue.Value * 0.45

		if topJawPivot then
			local v44 = topPart.CFrame * topJawPivot * CFrame.Angles(0, 0, v43)

			for v45, v46 in topJawData do
				v46.part.CFrame = v44 * v46.offset
			end
		end

		if bottomJawPivot then
			local v47 = topPart.CFrame * bottomJawPivot * CFrame.Angles(0, 0, -v43)

			for v48, v49 in bottomJawData do
				v49.part.CFrame = v47 * v49.offset
			end
		end

		debug.profileend()
	else
		local v50 = t3[p1]

		if not v50 then
			return
		end

		t3[p1] = nil
		t2[p1] = nil

		if v50.jawValue then
			v50.jawValue:Destroy()
		end

		if not v50.lungeValue then
			return
		end

		v50.lungeValue:Destroy()
	end
end

local function ensureSharedHeartbeat() --[[ ensureSharedHeartbeat | Line: 226 | Upvalues: v2 (ref), RunService (copy), v1 (ref), t3 (copy), updateRegisteredPlant (copy) ]]
	if not v2 then
		v2 = true
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 230 | Upvalues: v1 (ref), t3 (ref), updateRegisteredPlant (ref) ]]
			v1 = v1 + p1

			if v1 < 0.15 then
				return
			end

			v1 = 0
			debug.profilebegin("Controllers/InverseKinematicsController/SharedHeartbeat")

			for v12, v2 in t3 do
				updateRegisteredPlant(v12, v2)
			end

			debug.profileend()
		end)
	end
end

function t.Init(p1) --[[ Init | Line: 243 | Upvalues: v2 (ref), RunService (copy), v1 (ref), t3 (copy), updateRegisteredPlant (copy) ]]
	if not v2 then
		v2 = true
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 230 | Upvalues: v1 (ref), t3 (ref), updateRegisteredPlant (ref) ]]
			v1 = v1 + p1

			if v1 < 0.15 then
				return
			end

			v1 = 0
			debug.profilebegin("Controllers/InverseKinematicsController/SharedHeartbeat")

			for v12, v2 in t3 do
				updateRegisteredPlant(v12, v2)
			end

			debug.profileend()
		end)
	end
end
function t.SetupPlant(p1, p2) --[[ SetupPlant | Line: 247 | Upvalues: t2 (copy), t3 (copy), v2 (ref), RunService (copy), v1 (ref), updateRegisteredPlant (copy) ]]
	local t = {}
	local t4 = {}

	for v12, v22 in p2:GetChildren() do
		local v4 = tonumber(v22.Name)

		if v4 then
			if v22:IsA("Part") then
				table.insert(t, {
					part = v22,
					index = v4
				})

				continue
			end

			if v22:IsA("BasePart") then
				if not t4[v4] then
					t4[v4] = {}
				end

				table.insert(t4[v4], v22)
			end
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 265 ]]
		return p1.index < p2.index
	end)

	if #t < 2 then
		return
	end

	local t5 = {}

	for v6, v7 in t do
		t5[v7.index] = v7.part
	end

	local part = t[#t].part

	local function findParentPart(p1) --[[ findParentPart | Line: 276 | Upvalues: t5 (copy), t (copy), part (copy) ]]
		if t5[p1] then
			return t5[p1]
		end

		local v1 = nil

		for v2, v3 in t do
			if v3.index <= p1 and (not v1 or v3.index > v1.index) then
				v1 = v3
			end
		end

		if v1 then
			return v1.part
		end

		return part
	end

	local t6 = {}

	for v8, v9 in t4 do
		local v10 = findParentPart(v8)

		for v11, v12 in v9 do
			table.insert(t6, {
				part = v12,
				parent = v10,
				offset = v10.CFrame:ToObjectSpace(v12.CFrame)
			})
		end
	end

	local PlantModel = p2:FindFirstChild("PlantModel")
	local t7 = {}
	local t8 = {}
	local t9 = {}
	local v13 = nil
	local v14 = nil

	if PlantModel and PlantModel:IsA("Model") then
		local Base = PlantModel:FindFirstChild("Base")
		local TopJaw = PlantModel:FindFirstChild("TopJaw")
		local BottomJaw = PlantModel:FindFirstChild("BottomJaw")

		if Base then
			for v15, v16 in Base:GetDescendants() do
				if v16:IsA("BasePart") then
					table.insert(t7, {
						part = v16,
						offset = part.CFrame:ToObjectSpace(v16.CFrame)
					})
				end
			end
		end

		if TopJaw then
			v13 = part.CFrame:ToObjectSpace(TopJaw:GetPivot())

			for v18, v19 in TopJaw:GetDescendants() do
				if v19:IsA("BasePart") then
					table.insert(t8, {
						part = v19,
						offset = TopJaw:GetPivot():ToObjectSpace(v19.CFrame)
					})
				end
			end
		end

		if BottomJaw then
			v14 = part.CFrame:ToObjectSpace(BottomJaw:GetPivot())

			for v21, v22 in BottomJaw:GetDescendants() do
				if v22:IsA("BasePart") then
					table.insert(t9, {
						part = v22,
						offset = BottomJaw:GetPivot():ToObjectSpace(v22.CFrame)
					})
				end
			end
		end

		for v23, v24 in PlantModel:GetDescendants() do
			if v24:IsA("BasePart") then
				local v25 = v24.Parent
				local v26 = false

				while true do
					if not v25 or v25 == PlantModel then
						break
					end

					if v25.Name == "Base" or (v25.Name == "TopJaw" or v25.Name == "BottomJaw") then
						v26 = true

						break
					end

					v25 = v25.Parent
				end

				if not v26 then
					table.insert(t7, {
						part = v24,
						offset = part.CFrame:ToObjectSpace(v24.CFrame)
					})
				end
			end
		end
	end

	local part2 = t[1].part
	local t10 = {}

	for i = 2, #t do
		local part3 = t[i].part

		table.insert(t10, {
			part = part3,
			restOffset = t[i - 1].part.CFrame:ToObjectSpace(part3.CFrame)
		})
	end

	local JawValue = Instance.new("NumberValue")

	JawValue.Value = 0
	JawValue.Name = "JawValue"
	JawValue.Parent = p2

	local LungeValue = Instance.new("NumberValue")

	LungeValue.Value = 0
	LungeValue.Name = "LungeValue"
	LungeValue.Parent = p2
	t2[p2] = {
		basePart = part2
	}

	local _, v27, _2 = part2.CFrame:ToEulerAnglesYXZ()
	local t11 = {
		basePart = part2,
		topPart = part,
		chain = t10,
		attachmentData = t6,
		baseData = t7,
		topJawData = t8,
		bottomJawData = t9,
		topJawPivot = v13,
		bottomJawPivot = v14,
		jawValue = JawValue,
		lungeValue = LungeValue,
		originalBaseAngle = v27
	}

	p2.ChildRemoved:Connect(function(p1) --[[ Line: 418 | Upvalues: part2 (copy), t11 (copy) ]]
		if not p1:IsA("Highlight") then
			return
		end

		local _, v1, _2 = part2.CFrame:ToEulerAnglesYXZ()

		t11.originalBaseAngle = v1
	end)
	t3[p2] = t11

	if not v2 then
		v2 = true
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 230 | Upvalues: v1 (ref), t3 (ref), updateRegisteredPlant (ref) ]]
			v1 = v1 + p1

			if v1 < 0.15 then
				return
			end

			v1 = 0
			debug.profilebegin("Controllers/InverseKinematicsController/SharedHeartbeat")

			for v12, v2 in t3 do
				updateRegisteredPlant(v12, v2)
			end

			debug.profileend()
		end)
	end
end
function t.GetBasePart(p1, p2) --[[ GetBasePart | Line: 432 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	return if v1 then v1.basePart or nil else nil
end
function t.OpenMouth(p1, p2) --[[ OpenMouth | Line: 437 | Upvalues: TweenService (copy) ]]
	local JawValue = p2:FindFirstChild("JawValue")

	if JawValue then
		TweenService:Create(JawValue, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Value = 1
		}):Play()
	end
end
function t.CloseMouth(p1, p2) --[[ CloseMouth | Line: 443 | Upvalues: TweenService (copy) ]]
	local JawValue = p2:FindFirstChild("JawValue")

	if JawValue then
		TweenService:Create(JawValue, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Value = -0.25
		}):Play()
	end
end
function t.LungeAt(p1, p2, p3) --[[ LungeAt | Line: 449 | Upvalues: TweenService (copy) ]]
	p2:SetAttribute("LungeTarget", p3)

	local LungeValue = p2:FindFirstChild("LungeValue")

	if LungeValue then
		TweenService:Create(LungeValue, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Value = 1
		}):Play()
	end
end
function t.ReturnToRest(p1, p2) --[[ ReturnToRest | Line: 456 | Upvalues: TweenService (copy) ]]
	local LungeValue = p2:FindFirstChild("LungeValue")

	if LungeValue then
		TweenService:Create(LungeValue, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Value = 0
		}):Play()
	end
end

return t