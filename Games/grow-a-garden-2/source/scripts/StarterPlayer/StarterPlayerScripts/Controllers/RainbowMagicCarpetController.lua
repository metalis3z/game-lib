--credit to prince games studio
local t = {
	StartOrder = 6
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local t2 = {}
local t3 = {}
local v1 = false
local v2 = false
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil

local function IsAlive() --[[ IsAlive | Line: 30 | Upvalues: v3 (ref), v4 (ref), v5 (ref) ]]
	return v3 and (v3.Parent and (v4 and (v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false))))
end

local function DisableJump(p1) --[[ DisableJump | Line: 36 | Upvalues: v6 (ref), v4 (ref) ]]
	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	if not (p1 and v4) then
		return
	end

	v6 = v4:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 42 | Upvalues: v4 (ref) ]]
		v4.Jump = false
	end)
end

local function ResetHumanoid() --[[ ResetHumanoid | Line: 48 | Upvalues: v4 (ref), v6 (ref) ]]
	if not v4 then
		return
	end

	v4.PlatformStand = false
	v4.AutoRotate = true

	if not v6 then
		return
	end

	v6:Disconnect()
	v6 = nil
end

local function CleanFlightBodies() --[[ CleanFlightBodies | Line: 57 | Upvalues: v5 (ref) ]]
	if not (v5 and v5.Parent) then
		return
	end

	for v1, v2 in { "FlightSpin", "FlightPower", "FlightHold" } do
		local v3 = v5:FindFirstChild(v2)

		if v3 then
			v3:Destroy()
		end
	end
end

local function StopAllAnimations() --[[ StopAllAnimations | Line: 66 | Upvalues: t2 (ref), t3 (copy) ]]
	for v1, v2 in t2 do
		if v2.AnimationTrack then
			v2.AnimationTrack:Stop()
		end
	end

	t2 = {}

	for v3, v4 in t3 do
		pcall(function() --[[ Line: 76 | Upvalues: v4 (copy) ]]
			v4:Destroy()
		end)
		t3[v3] = nil
	end
end

local function HandleFlightControl() --[[ HandleFlightControl | Line: 81 | Upvalues: v3 (ref), v4 (ref), v5 (ref), v7 (ref), v1 (ref), v6 (ref), v2 (ref), CurrentCamera (copy) ]]
	local v12 = v3 and (v3.Parent and (v4 and (v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false))))

	if not v12 then
		return
	end

	if v7 then
		v7:Disconnect()
	end

	v7 = v5.ChildAdded:Connect(function(p1) --[[ Line: 88 | Upvalues: v1 (ref), v5 (ref), v4 (ref), v6 (ref), v2 (ref), v3 (ref), CurrentCamera (ref) ]]
		if v1 then
			return
		end

		if p1.Name ~= "FlightHold" then
			return
		end

		local FlightSpin = v5:FindFirstChild("FlightSpin")
		local FlightPower = v5:FindFirstChild("FlightPower")
		local FlightHold = v5:FindFirstChild("FlightHold")

		if not (FlightSpin and (FlightPower and FlightHold)) then
			return
		end

		v1 = true
		v4.PlatformStand = true
		v4.AutoRotate = false

		if v6 then
			v6:Disconnect()
			v6 = nil
		end

		if v4 then
			v6 = v4:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 42 | Upvalues: v4 (ref) ]]
				v4.Jump = false
			end)
		end

		v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

		while v1 and (v2 and (FlightSpin.Parent and (FlightPower.Parent and FlightHold.Parent))) do
			if not (v3 and (v3.Parent and (v4 and (v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false))))) then
				break
			end

			local v22 = CurrentCamera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
			local v32 = CurrentCamera.CFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
			local v52 = CFrame.new(Vector3.new(0, 0, 0), CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(v4.MoveDirection)
			local v62 = v22 * 90 * -v52.Z + v32 * 60 * -v52.X

			FlightSpin.CFrame = CFrame.new(Vector3.new(0, 0, 0), v22)

			if v62.Magnitude < 1 then
				FlightHold.MaxForce = Vector3.new(1, 1, 1) * FlightHold.P
				FlightPower.MaxForce = Vector3.new(0, 0, 0)
				FlightHold.Position = v5.Position
			else
				FlightHold.MaxForce = Vector3.new(0, 0, 0)
				FlightPower.MaxForce = Vector3.new(1, 1, 1) * FlightPower.P * 100
			end

			FlightPower.Velocity = v62
			task.wait(1 / 60)
		end

		v1 = false

		local v7 = v3 and v3.Parent and v4 and v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false)

		if not v7 then
			return
		end

		v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

		if v4 then
			v4.PlatformStand = false
			v4.AutoRotate = true

			if v6 then
				v6:Disconnect()
				v6 = nil
			end
		end

		v4:ChangeState(Enum.HumanoidStateType.Freefall)
	end)
end

function t.Init(p1) --[[ Init | Line: 141 ]] end
function t.Equip(p1) --[[ Equip | Line: 144 | Upvalues: v2 (ref), v3 (ref), LocalPlayer (copy), v4 (ref), v5 (ref), v6 (ref), HandleFlightControl (copy) ]]
	if v2 then
		return
	end

	v3 = LocalPlayer.Character

	if not v3 then
		return
	end

	v4 = v3:FindFirstChildOfClass("Humanoid")
	v5 = v3:FindFirstChild("HumanoidRootPart")
	v2 = true

	if not (v3 and v3.Parent and v4 and v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false)) then
		v2 = false

		return
	end

	if v4 then
		v4.PlatformStand = false
		v4.AutoRotate = true

		if v6 then
			v6:Disconnect()
			v6 = nil
		end
	end

	if v5 then
		v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	end

	task.spawn(HandleFlightControl)
end
function t.Unequip(p1) --[[ Unequip | Line: 170 | Upvalues: v2 (ref), v1 (ref), StopAllAnimations (copy), v7 (ref), v4 (ref), v6 (ref), CleanFlightBodies (copy) ]]
	if not v2 then
		return
	end

	v1 = false
	v2 = false
	StopAllAnimations()

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	if v4 then
		v4.PlatformStand = false
		v4.AutoRotate = true

		if v6 then
			v6:Disconnect()
			v6 = nil
		end
	end

	CleanFlightBodies()
end
Networking.Carpet.Equip.OnClientEvent:Connect(function() --[[ Line: 187 | Upvalues: t (copy) ]]
	t:Equip()
end)
Networking.Carpet.Unequip.OnClientEvent:Connect(function() --[[ Line: 191 | Upvalues: t (copy) ]]
	t:Unequip()
end)
Networking.Carpet.PlayAnimation.OnClientEvent:Connect(function(p1) --[[ Line: 195 | Upvalues: v2 (ref), v4 (ref), t3 (copy), t2 (ref) ]]
	if not (v2 and v4) then
		return
	end

	-- MODDED: elegir la animación según el rig (R6 = "Sit", R15 = "SitR15")
	local animName = p1
	if p1 == "Sit" and v4.RigType == Enum.HumanoidRigType.R15 then
		animName = "SitR15"
	end
	local v1 = game.ReplicatedStorage.Assets:FindFirstChild(animName, true)
		or game.ReplicatedStorage.Assets:FindFirstChild(p1, true)

	if not v1 then
		return
	end

	local v22 = v4:FindFirstChildOfClass("Animator") or v4:WaitForChild("Animator", 5)

	if not v22 then
		return
	end

	local v3 = t3[v1]

	if v3 then
		v3:Stop()
	else
		local v42 = v22:LoadAnimation(v1)

		t3[v1] = v42
		v3 = v42
	end

	for i = #t2, 1, -1 do
		if t2[i].Animation == v1 then
			table.remove(t2, i)
		end
	end

	table.insert(t2, {
		Animation = v1,
		AnimationTrack = v3
	})
	v3:Play()
end)
Networking.Carpet.StopAnimation.OnClientEvent:Connect(function(p1) --[[ Line: 224 | Upvalues: t2 (ref) ]]
	for i = #t2, 1, -1 do
		if t2[i].Animation.Name == p1 then
			t2[i].AnimationTrack:Stop()
			table.remove(t2, i)
		end
	end
end)
Networking.Carpet.Activated.OnClientEvent:Connect(function(p1) --[[ Line: 233 | Upvalues: v2 (ref), v1 (ref), CleanFlightBodies (copy), v4 (ref), v6 (ref), v3 (ref), v5 (ref) ]]
	if not v2 then
		return
	end

	if p1 then
		return
	end

	v1 = false
	CleanFlightBodies()

	if v4 then
		v4.PlatformStand = false
		v4.AutoRotate = true

		if v6 then
			v6:Disconnect()
			v6 = nil
		end
	end

	if not (v3 and (v3.Parent and (v4 and (v4.Parent and (if v4.Health > 0 then v5 and v5.Parent else false))))) then
		return
	end

	v4:ChangeState(Enum.HumanoidStateType.Freefall)
end)

local function newCarpetModel(p1) --[[ newCarpetModel | Line: 253 | Upvalues: RunService (copy) ]]
	local TargetFloat = p1.TargetFloat.Value
	local HumanoidRootPart = TargetFloat:WaitForChild("HumanoidRootPart")
	local RootJoint = HumanoidRootPart:WaitForChild("RootJoint")
	local t = {}

	for v1, v2 in p1.Carpet:GetChildren() do
		if v2:IsA("Bone") then
			t[v2] = v2.CFrame
		end
	end

	local function UpdateBones(p1, p2) --[[ UpdateBones | Line: 267 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			local X = v2.Position.X
			local v3 = p2 * math.sin(1.0471975511965976 * X + p1)
			local v5 = math.atan(p2 * 1.0471975511965976 * math.cos(1.0471975511965976 * X + p1))

			v1.CFrame = v2 * CFrame.new(0, v3, 0) * CFrame.Angles(0, 0, v5)
		end
	end

	local X = p1.Carpet:WaitForChild("Bone_04").CFrame.Position.X
	local C0 = RootJoint.C0
	local v3 = TargetFloat.Name
	local v4 = 0
	local v5 = 0

	RunService:BindToRenderStep("CarpetSway" .. v3, Enum.RenderPriority.Character.Value + 1, function(p1) --[[ Line: 285 | Upvalues: HumanoidRootPart (copy), v5 (ref), v4 (ref), UpdateBones (copy), X (copy), RootJoint (copy), C0 (copy) ]]
		local v1 = if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 1 then 1 else 0

		v5 = v5 + (v1 - v5) * math.min(p1 * 4, 1)

		local v2 = v5 * 0.3 + 0.2

		v4 = v4 + (v5 * 3 + 1) * p1
		UpdateBones(v4, v2)

		local v42 = v2 * math.sin(1.0471975511965976 * X + v4)
		local v7 = math.atan(v2 * 1.0471975511965976 * math.cos(1.0471975511965976 * X + v4))

		RootJoint.C0 = C0 * CFrame.new(0, 0.5, v42 + 0.1) * CFrame.Angles(-v7, 0, 0)
	end)

	repeat
		task.wait()
	until not (game.CollectionService:HasTag(p1, "RainbowCarpet") and p1:IsDescendantOf(workspace))

	RunService:UnbindFromRenderStep("CarpetSway" .. v3)
	RootJoint.C0 = C0
end

game.CollectionService:GetInstanceRemovedSignal("RainbowCarpet"):Connect(function(p1) --[[ Line: 309 ]] end)
game.CollectionService:GetInstanceAddedSignal("RainbowCarpet"):Connect(newCarpetModel)

for v8, v9 in game.CollectionService:GetTagged("RainbowCarpet") do
	newCarpetModel(v9)
end

return t