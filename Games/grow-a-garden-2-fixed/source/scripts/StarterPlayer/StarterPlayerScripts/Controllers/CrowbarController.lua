--credit to prince games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local Gardens = workspace:WaitForChild("Gardens")
local v1 = nil
local v2 = 0
local v3 = nil
local t2 = {}
local t3 = {}

function t.Init(p1) --[[ Init | Line: 30 ]] end
function t.Start(p1) --[[ Start | Line: 33 | Upvalues: UserInputService (copy), v1 (ref), LocalPlayer (copy), Networking (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 34 | Upvalues: v1 (ref), p1 (copy) ]]
		if p2 then
			return
		end

		if not v1 then
			return
		end

		if not (if p12.UserInputType == Enum.UserInputType.MouseButton1 then true else p12.KeyCode == Enum.KeyCode.ButtonR2) then
			return
		end

		p1:ProcessSwing()
	end)
	UserInputService.TouchTapInWorld:Connect(function(p12, p2) --[[ Line: 46 | Upvalues: v1 (ref), p1 (copy) ]]
		if p2 then
			return
		end

		if v1 then
			p1:ProcessSwing()
		end
	end)

	local Character = LocalPlayer.Character

	if Character then
		p1:SetupCharacter(Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 56 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	Networking.Crowbar.DoorForced.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 60 | Upvalues: p1 (copy) ]]
		p1:HandleDoorForced(p12, p2, p3)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 68 | Upvalues: v1 (ref) ]]
	for v12, v2 in p2:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Crowbar") then
			v1 = v2
		end
	end

	p2.ChildAdded:Connect(function(p1) --[[ Line: 75 | Upvalues: v1 (ref) ]]
		if not (p1:IsA("Tool") and p1:GetAttribute("Crowbar")) then
			return
		end

		v1 = p1
	end)
	p2.ChildRemoved:Connect(function(p1) --[[ Line: 81 | Upvalues: v1 (ref) ]]
		if not p1:IsA("Tool") or (not p1:GetAttribute("Crowbar") or v1 ~= p1) then
			return
		end

		v1 = nil
	end)
end
function t.FindPropByIds(p1, p2, p3) --[[ FindPropByIds | Line: 93 | Upvalues: Players (copy), Gardens (copy) ]]
	local v1 = Players:GetPlayerByUserId(p2)

	if not v1 then
		return nil
	end

	local v2 = v1:GetAttribute("PlotId")

	if not v2 then
		return nil
	end

	local v3 = Gardens:FindFirstChild("Plot" .. tostring(v2))

	if not v3 then
		return nil
	end

	local Props = v3:FindFirstChild("Props")

	if not Props then
		return nil
	end

	for v4, v5 in Props:GetChildren() do
		if v5:GetAttribute("PropId") == p3 then
			return v5
		end
	end

	return nil
end
function t.FindPropModel(p1, p2) --[[ FindPropModel | Line: 115 ]]
	local v1 = p2.Parent

	while v1 and v1 ~= workspace do
		if v1:IsA("Model") and v1:GetAttribute("PropId") then
			return v1
		end

		v1 = v1.Parent
	end

	return nil
end
function t.IsDoorPryable(p1, p2) --[[ IsDoorPryable | Line: 129 | Upvalues: LocalPlayer (copy) ]]
	if p2:GetAttribute("ForcedOpen") then
		return false
	end

	local v1 = p2:GetAttribute("UserId")

	return (not v1 or v1 ~= LocalPlayer.UserId) and true or false
end
function t.HandleDoorForced(p1, p2, p3, p4) --[[ HandleDoorForced | Line: 145 | Upvalues: t3 (copy), CollectionService (copy) ]]
	local v1 = p1:FindPropByIds(p2, p3)

	if not v1 then
		return
	end

	if t3[v1] then
		task.cancel(t3[v1])
		t3[v1] = nil
	end

	v1:SetAttribute("ForcedOpen", true)

	local t = {}
	local v2 = nil

	for v3, v4 in v1:GetDescendants() do
		if v4:IsA("BasePart") and CollectionService:HasTag(v4, "CrowbarDoor") then
			table.insert(t, v4.Color)

			if not v2 then
				v2 = v4.Position
			end
		end
	end

	t3[v1] = task.delay(p4, function() --[[ Line: 167 | Upvalues: t3 (ref), v1 (copy) ]]
		t3[v1] = nil

		if not (v1 and v1.Parent) then
			return
		end

		v1:SetAttribute("ForcedOpen", false)
	end)
end
function t.HandleDoorForced(p1, p2, p3, p4) --[[ HandleDoorForced | Line: 174 | Upvalues: Players (copy), Gardens (copy), t3 (copy), CollectionService (copy) ]]
	local v1 = p1:FindPropByIds(p2, p3)

	if v1 then
		if t3[v1] then
			task.cancel(t3[v1])
			t3[v1] = nil
		end

		v1:SetAttribute("ForcedOpen", true)

		local t = {}
		local v2 = nil

		for v3, v4 in v1:GetDescendants() do
			if v4:IsA("BasePart") and CollectionService:HasTag(v4, "CrowbarDoor") then
				table.insert(t, v4.Color)

				if not v2 then
					v2 = v4.Position
				end
			end
		end

		t3[v1] = task.delay(p4, function() --[[ Line: 217 | Upvalues: t3 (ref), v1 (copy) ]]
			t3[v1] = nil

			if not (v1 and v1.Parent) then
				return
			end

			v1:SetAttribute("ForcedOpen", false)
		end)
	else
		local v5 = Players:GetPlayerByUserId(p2)

		if not v5 then
			return
		end

		local v6 = v5:GetAttribute("PlotId")

		if not v6 then
			return
		end

		local v7 = Gardens:FindFirstChild("Plot" .. tostring(v6))

		if not v7 then
			return
		end

		local Props = v7:FindFirstChild("Props")

		if not Props then
			return
		end

		for v8, v9 in Props:GetChildren() do

		end
	end
end
function t.PlaySwingAnimation(p1) --[[ PlaySwingAnimation | Line: 227 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if Animator then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = "rbxassetid://78592768207309"
		v3 = Animator:LoadAnimation(Animation)
		v3.Looped = false
		v3.Priority = Enum.AnimationPriority.Action4
		v3:Play()
	end
end
function t.ProcessSwing(p1) --[[ ProcessSwing | Line: 243 | Upvalues: v1 (ref), v2 (ref), Networking (copy) ]]
	if not v1 then
		return
	end

	local v12 = os.clock()

	if not (v12 - v2 < 1) then
		v2 = v12
		p1:PlaySwingAnimation()
		Networking.Crowbar.SwingCrowbar:Fire()
		p1:ActivateHitDetection()
	end
end
function t.ActivateHitDetection(p1) --[[ ActivateHitDetection | Line: 262 | Upvalues: v1 (ref), LocalPlayer (copy), CollectionService (copy), Networking (copy), Players (copy), t2 (copy) ]]
	local v12 = v1

	if not v12 then
		return
	end

	local t = {}
	local t3 = {}
	local t4 = {}
	local v2 = 0
	local t5 = {}
	local v3 = if LocalPlayer:GetAttribute("IsInOwnGarden") then "NormalCollision" else "GardenCollision"
	local t6 = {}

	for v4, v5 in v12:GetDescendants() do
		if v5:IsA("BasePart") then
			if v5.Name == v3 then
				table.insert(t6, v5.Name)

				continue
			end

			table.insert(t5, v5)
		end
	end

	for v7, v8 in t5 do

	end

	if #t5 == 0 then
		for v9, v10 in v12:GetDescendants() do

		end
	end

	for v11, v122 in t5 do
		local v13 = v122.Touched:Connect(function(p12) --[[ Line: 298 | Upvalues: v2 (ref), CollectionService (ref), p1 (copy), t4 (copy), Networking (ref), Players (ref), LocalPlayer (ref), t3 (copy), t2 (ref) ]]
			if not p12:IsA("BasePart") then
				return
			end

			v2 = v2 + 1

			if CollectionService:HasTag(p12, "CrowbarDoor") then
				local v1 = p1:FindPropModel(p12)

				if not v1 then
					return
				end

				if t4[v1] then
					return
				end

				if not p1:IsDoorPryable(v1) then
					return
				end

				t4[v1] = true

				local v22 = v1:GetAttribute("UserId")
				local v3 = v1:GetAttribute("PropId")

				if v22 and v3 then
					Networking.Crowbar.PryDoor:Fire(v22, v3)
				end
			else
				local v4 = p12:FindFirstAncestorWhichIsA("Model")

				if not v4 then
					return
				end

				local v5 = Players:GetPlayerFromCharacter(v4)

				if not v5 or v5 == LocalPlayer then
					return
				end

				if t3[v5] then
					return
				end

				local v6 = os.clock()

				if t2[v5] and v6 - t2[v5] < 0.5 then
					return
				end

				t3[v5] = true
				t2[v5] = v6
				Networking.Crowbar.HitPlayer:Fire(v5.UserId)
			end
		end)

		table.insert(t, v13)
	end

	task.delay(0.4, function() --[[ Line: 350 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			v2:Disconnect()
		end
	end)
end

return t