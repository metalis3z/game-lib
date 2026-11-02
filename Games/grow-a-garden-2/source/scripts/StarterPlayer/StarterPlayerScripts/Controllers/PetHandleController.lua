--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local PetModules = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("PetModules"))
local PetSizes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetSizes"))
local PetTypes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetTypes"))
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = nil
local v2 = nil
local v3 = CFrame.fromOrientation(0, 0, -1.5707963267948966)

local function GetSpeciesGrip(p1) --[[ GetSpeciesGrip | Line: 60 | Upvalues: v3 (copy) ]]
	if not p1 then
		return v3
	end

	local HandGrip = p1.HandGrip

	if typeof(HandGrip) == "Vector3" then
		return CFrame.fromOrientation(math.rad(HandGrip.X), math.rad(HandGrip.Y), (math.rad(HandGrip.Z)))
	end

	return v3
end

local function GetSpeciesPivotCFrame(p1) --[[ GetSpeciesPivotCFrame | Line: 69 ]]
	if not p1 then
		return CFrame.identity
	end

	local Pivot = p1.Pivot

	if typeof(Pivot) == "Vector3" then
		return CFrame.Angles(math.rad(Pivot.X), math.rad(Pivot.Y), (math.rad(Pivot.Z)))
	end

	return CFrame.identity
end

local function GetIdleAnimationName(p1) --[[ GetIdleAnimationName | Line: 77 ]]
	local v1 = if p1 then p1.Animations else p1

	if type(v1) ~= "table" then
		return nil
	end

	if not p1.IsFlying then
		return v1.Idle
	end

	return v1.Fly or v1.Idle
end

local function PlayPetCarry() --[[ PlayPetCarry | Line: 86 | Upvalues: LocalPlayer (copy), v1 (ref) ]]
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

	if not v1 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://72938295589356"
		v1 = Animator:LoadAnimation(Animation)
		v1.Looped = true
		v1.Priority = Enum.AnimationPriority.Action4
	end

	if v1.IsPlaying then
		return
	end

	v1:Play()
end

local function StopPetCarry() --[[ StopPetCarry | Line: 107 | Upvalues: v1 (ref) ]]
	if not (v1 and v1.IsPlaying) then
		return
	end

	v1:Stop()
end

function t.Init(p1) --[[ Init | Line: 113 ]] end
function t.Start(p1) --[[ Start | Line: 116 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 121 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 125 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 136 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
	p2.Massless = true
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 144 ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("ParticleEmitter") or (v2:IsA("Trail") or v2:IsA("Beam")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Fire") or (v2:IsA("Smoke") or v2:IsA("Sparkles")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Light") then
			v2.Enabled = false
		end
	end
end
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 156 ]]
	if p2:HasTag("PetRainbow") then
		p2:RemoveTag("PetRainbow")
	end

	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 165 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 172 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.PlaceAboveHead(p1, p2, p3, p4, p5, p6) --[[ PlaceAboveHead | Line: 182 ]]
	local Head = p4:FindFirstChild("Head")
	local HumanoidRootPart = p4:FindFirstChild("HumanoidRootPart")

	if not (Head and Head:IsA("BasePart")) then
		return
	end

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return
	end

	local v1

	if p5 then
		local Pivot = p5.Pivot

		v1 = if typeof(Pivot) == "Vector3" then CFrame.Angles(math.rad(Pivot.X), math.rad(Pivot.Y), (math.rad(Pivot.Z))) else CFrame.identity
	else
		v1 = CFrame.identity
	end

	local LookVector = HumanoidRootPart.CFrame.LookVector
	local v5 = Vector3.new(LookVector.X, 0, LookVector.Z)

	if v5.Magnitude < 0.001 then
		v5 = LookVector
	end

	local v6 = Head.Position + Vector3.new(0, p6 * 1 + 1, 0)

	p2:PivotTo(CFrame.lookAt(v6, v6 + v5) * v1)

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = p3
	WeldConstraint.Part1 = HumanoidRootPart
	WeldConstraint.Parent = p3
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 210 | Upvalues: t4 (copy), Assets (copy), PetModules (copy), v3 (copy), PetSizes (copy), LocalPlayer (copy), PetTypes (copy) ]]
	if t4[p2] then
		return
	end

	t4[p2] = true
	p1:ClearHandle(p2)

	local v1 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v1 then
		t4[p2] = nil

		return
	end

	local v2 = p2:GetAttribute("Pet")

	if type(v2) ~= "string" or v2 == "" then
		t4[p2] = nil

		return
	end

	local Pets = Assets:FindFirstChild("Pets")
	local v32 = Assets:FindFirstChild("Pets") and Pets:FindFirstChild(v2) or Assets:FindFirstChild(v2)

	if v32 and v32:IsA("Model") then
		local v4 = PetModules[v2]
		local v5

		if v4 then
			local HandGrip = v4.HandGrip

			v5 = if typeof(HandGrip) == "Vector3" then CFrame.fromOrientation(math.rad(HandGrip.X), math.rad(HandGrip.Y), (math.rad(HandGrip.Z))) else v3
		else
			v5 = v3
		end

		local v9 = if PetSizes.Normalize(p2:GetAttribute("PetSize")) == nil then false else true
		local Build = v32:Clone()
		local v12 = PetSizes.GetScale(p2:GetAttribute("PetSize"), if v4 then {
	Big = v4.BigScale,
	Huge = v4.HugeScale
} else nil)

		if v12 ~= 1 then
			Build:ScaleTo(v12)
		end

		p1:DisableVFX(Build)

		local v13 = LocalPlayer and (if LocalPlayer.Character == p3 then true else false)
		local Handle = Build.PrimaryPart

		if not Handle then
			Build:Destroy()
			t4[p2] = nil

			return
		end

		for v14, v15 in Build:GetDescendants() do
			if v15:IsA("BasePart") then
				p1:PreparePartForTool(v15)
			end
		end

		local v16 = Build:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController")
		local Animator = v16:FindFirstChildOfClass("Animator")

		if not Animator then
			Animator = Instance.new("Animator")
			Animator.Parent = v16
		end

		local v17 = nil
		local v18 = if v4 then v4.Animations else v4
		local v19 = if type(v18) == "table" then if v4.IsFlying then v18.Fly or v18.Idle else v18.Idle else nil

		if v19 then
			local Animations = Build:FindFirstChild("Animations")

			if Animations then
				v17 = Animations:FindFirstChild(v19)
			end

			if not v17 then
				v17 = Build:FindFirstChild(v19)
			end
		end

		v16.Parent = Build

		if v9 then
			Build.Name = "Build"
			Build.Parent = p2

			local Handle2 = Instance.new("Part")

			Handle2.Name = "Handle"
			Handle2.Size = Vector3.new(1, 1, 1)
			Handle2.Transparency = 1
			Handle2.CanCollide = false
			Handle2.CanQuery = false
			Handle2.CanTouch = false
			Handle2.Massless = true
			Handle2.Parent = p2
			p1:PlaceAboveHead(Build, Handle, p3, v4, v12)
		else
			Build.Name = "Build"
			Build.Parent = p2
			Handle.Name = "Handle"
			Handle.Parent = p2
			p2.Grip = v5

			-- RequiresHandle=false -> el Grip no engancha en el jugador local. Crear
			-- el RightGrip Motor6D SIEMPRE (incluido el local) para que el pet salga
			-- en la propia mano tambien (igual que SeedHandleController suelda a mano).
			local RightGrip = Instance.new("Motor6D")

			RightGrip.Name = "RightGrip"
			RightGrip.Part0 = v1
			RightGrip.Part1 = Handle
			RightGrip.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
			RightGrip.C1 = CFrame.new(0, 0, 0) * v5
			RightGrip.Parent = v1
		end

		if v17 and v17:IsA("Animation") then
			local ok, result = pcall(function() --[[ Line: 345 | Upvalues: Animator (ref), v17 (ref) ]]
				return Animator:LoadAnimation(v17)
			end)

			if ok and result then
				result.Looped = true
				result:Play(0)
			end
		end

		if p2:GetAttribute("PetType") == PetTypes.Rainbow and not p2:HasTag("PetRainbow") then
			p2:AddTag("PetRainbow")
		end

		t4[p2] = nil
	else
		t4[p2] = nil
	end
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 365 | Upvalues: t4 (copy), t3 (copy), LocalPlayer (copy), PetSizes (copy), v2 (ref), PlayPetCarry (copy), v1 (ref) ]]
	if t4[p2] then
		return
	end

	local v12 = t3[p2]

	if not v12 then
		return
	end

	local v22 = if p2.Parent == v12 then true else false
	local v3 = p1:HasHandle(p2)

	if v22 and not v3 then
		p1:SpawnHandle(p2, v12)
	elseif not v22 and v3 then
		p1:ClearHandle(p2)
	end

	local v4 = if v12 == LocalPlayer.Character then true else false

	if v22 and (v4 and (if PetSizes.Normalize(p2:GetAttribute("PetSize")) == nil then false else true)) then
		v2 = p2
		PlayPetCarry()

		return
	end

	if v2 ~= p2 then
		return
	end

	v2 = nil

	if not (v1 and v1.IsPlaying) then
		return
	end

	v1:Stop()
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 391 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
	local v1 = t2[p2]

	if v1 then
		for v2, v3 in v1 do
			v3:Disconnect()
		end

		t2[p2] = nil
	end

	t3[p2] = nil
	t4[p2] = nil
end
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 403 | Upvalues: v2 (ref), v1 (ref) ]]
	if v2 ~= p2 then
		p1:ClearHandle(p2)
		p1:DisconnectTool(p2)

		return
	end

	v2 = nil

	if not (v1 and v1.IsPlaying) then
		p1:ClearHandle(p2)
		p1:DisconnectTool(p2)

		return
	end

	v1:Stop()
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 412 ]]
	local v1 = p2:GetAttribute("Pet")

	return if type(v1) == "string" then v1 ~= "" else false
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 417 | Upvalues: t3 (copy), Networking (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 423 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 424 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))

	local v3 = p2:GetAttribute("PetId")

	if type(v3) == "string" and v3 ~= "" then
		local function f4() --[[ Line: 437 | Upvalues: Networking (ref), v3 (copy) ]]
			Networking.Pets.RequestToggleFollower:Fire(v3)
		end

		table.insert(t, p2.Activated:Connect(f4))
	end

	t2[p2] = t
	task.defer(function() --[[ Line: 444 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 451 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 452 | Upvalues: p2 (copy), Players (ref), p1 (copy) ]]
		if not (p2 and p2.Parent) then
			return
		end

		local v1 = Players:GetPlayerFromCharacter(p2)

		for v2, v3 in p2:GetChildren() do
			if v3:IsA("Tool") and p1:IsTrackedTool(v3) then
				p1:SetupTool(v3, p2)
			end
		end

		if v1 and v1.Backpack then
			for v4, v5 in v1.Backpack:GetChildren() do
				if v5:IsA("Tool") and p1:IsTrackedTool(v5) then
					p1:SetupTool(v5, p2)
				end
			end
		end

		p2.ChildAdded:Connect(function(p12) --[[ Line: 472 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 474 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 484 | Upvalues: LocalPlayer (copy), v1 (ref), v2 (ref), BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 489 | Upvalues: p2 (copy), LocalPlayer (ref), v1 (ref), v2 (ref), p1 (copy) ]]
		if p2 ~= LocalPlayer then
			p1:SetupCharacter(p12)

			return
		end

		v1 = nil
		v2 = nil
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 499 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 501 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t