-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local v1 = getfenv(0)
local Encode = v1.Encode
local ensureOriginalRoot = v1.ensureOriginalRoot
local t = {}

t.__index = t

local t2 = {}

t2.__index = t2

local v2 = Log.new()
local v3 = RunService:IsRunning()
local v4 = RunService:IsServer()
local v5 = RunService:IsClient()
local t3 = { "BodyVelocity", "BodyGyro", "BodyPosition" }
local t4 = {
	BodyVelocity = {
		P = 15000,
		MaxForce = Vector3.new(300000, 300000, 300000)
	},
	BodyPosition = {
		P = 9000,
		D = 325,
		MaxForce = Vector3.new(30000000, 30000000, 30000000)
	},
	BodyGyro = {
		P = 10000,
		D = 150,
		MaxTorque = Vector3.new(400000, 400000, 400000)
	},
	AlignPosition = {
		ApplyAtCenterOfMass = true,
		RigidityEnabled = true,
		Mode = Enum.PositionAlignmentMode.OneAttachment
	}
}
local t5 = {}
local t6 = {}
local t7 = {}
local BodyMover = ReplicatedStorage.Remotes.BodyMover
local StunAnimator = require(game.ServerStorage.StunAnimator)

local function getServerPlayerFromCharacter(p1) --[[ getServerPlayerFromCharacter | Line: 118 | Upvalues: Players (copy), v4 (copy), v5 (copy) ]]
	if not p1 then
		return nil
	end

	local v1 = Players:GetPlayerFromCharacter(p1)

	if v4 and (v1 and not v5) then
		return v1
	end

	return nil
end

local function removeEntryByKey(p1, p2) --[[ removeEntryByKey | Line: 131 ]]
	for i = 1, #p1 do
		if p1[i].key == p2 then
			table.remove(p1, i)

			return
		end
	end
end

local function insertEntry(p1, p2) --[[ insertEntry | Line: 140 | Upvalues: HttpService (copy) ]]
	local v1 = HttpService:GenerateGUID(false)

	table.insert(p1, {
		key = v1,
		value = p2
	})

	return v1
end

local function getOrCreateNoopProxy() --[[ getOrCreateNoopProxy | Line: 149 ]]
	local v1 = nil
	local t = {
		__index = function() --[[ __index | Line: 152 | Upvalues: v1 (ref) ]]
			return v1
		end,
		__call = function() --[[ __call | Line: 155 | Upvalues: v1 (ref) ]]
			return v1
		end
	}

	v1 = setmetatable({}, t)

	return v1
end

task.spawn(function() --[[ Line: 162 | Upvalues: t5 (copy), t6 (copy) ]]
	while task.wait(10) do
		for v1, v2 in next, t5 do
			if v1.Parent == nil then
				t5[v1] = nil
				t6[v1] = nil
			end
		end
	end
end)
function t.new(p1, p2) --[[ new | Line: 173 | Upvalues: v5 (copy), Players (copy), v2 (copy), getOrCreateNoopProxy (copy), v4 (copy), ensureOriginalRoot (copy), getServerPlayerFromCharacter (copy), t (copy), t6 (copy), t5 (copy) ]]
	local v1 = if p2 then p2 else {}
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
	local v22

	if v5 and not Players:GetPlayerFromCharacter(p1) then
		v2:AtWarning():Log("DANGEROUS BODYMOVER DETECTED. DO NOT INSTANCE ENEMY BODYMOVERS IN THE CLIENT.")
		v22 = true
	else
		v22 = false
	end

	local AntiMover = p1:FindFirstChild("AntiMover")

	if v1.BypassAntiMover then
		AntiMover = nil
	end

	if not HumanoidRootPart or (AntiMover or v22) then
		return getOrCreateNoopProxy()
	end

	assert(HumanoidRootPart:IsA("BasePart"), "HumanoidRootPart must be a BasePart")

	if v4 then
		HumanoidRootPart = ensureOriginalRoot(HumanoidRootPart)
	end

	local v52 = getServerPlayerFromCharacter(p1)

	if v52 then
		return setmetatable({
			Parent = HumanoidRootPart,
			Player = v52,
			Meta = v1
		}, t)
	end

	local v7 = t6[p1]

	if v7 then
		return v7
	end

	local v8 = HumanoidRootPart:FindFirstChild("BodyVelocity") or p1:FindFirstChild("BodyVelocity")
	local v9 = HumanoidRootPart:FindFirstChild("BodyPosition") or p1:FindFirstChild("BodyPosition")
	local v10 = HumanoidRootPart:FindFirstChild("BodyGyro") or p1:FindFirstChild("BodyGyro")

	if not (v8 and (v9 and v10)) then
		local BodyVelocity = Instance.new("BodyVelocity")
		local BodyPosition = Instance.new("BodyPosition")
		local BodyGyro = Instance.new("BodyGyro")
		local v11

		if BodyVelocity then
			v11 = BodyVelocity:IsA("BodyVelocity")
			v8 = BodyVelocity
		else
			v11 = BodyVelocity
			v8 = BodyVelocity
		end

		assert(v11, "BodyVelocity instance creation failed")

		local v12

		if BodyPosition then
			v12 = BodyPosition:IsA("BodyPosition")
			v9 = BodyPosition
		else
			v12 = BodyPosition
			v9 = BodyPosition
		end

		assert(v12, "BodyPosition instance creation failed")

		local v13

		if BodyGyro then
			v13 = BodyGyro:IsA("BodyGyro")
			v10 = BodyGyro
		else
			v13 = BodyGyro
			v10 = BodyGyro
		end

		assert(v13, "BodyGyro instance creation failed")
		v8.MaxForce = Vector3.new()
		v9.MaxForce = Vector3.new()
		v10.MaxTorque = Vector3.new()
	end

	if not t5[p1] then
		t5[p1] = {
			BodyVelocity = {},
			BodyPosition = {},
			BodyGyro = {}
		}
	end

	assert(if v8 then v8:IsA("BodyVelocity") else v8, "BodyVelocity must exist")
	assert(if v9 then v9:IsA("BodyPosition") else v9, "BodyPosition must exist")
	assert(if v10 then v10:IsA("BodyGyro") else v10, "BodyGyro must exist")

	local v17 = t5[p1]

	assert(v17, "Running movers table is missing")

	local v19 = setmetatable({
		Running = v17,
		Parent = HumanoidRootPart,
		BodyVelocity = v8,
		BodyPosition = v9,
		BodyGyro = v10
	}, t)

	t6[p1] = v19

	if v5 and Players:GetPlayerFromCharacter(p1) == Players.LocalPlayer then
		v19.Player2 = true
	end

	if v4 then
		v19.Meta = v1
	end

	return v19
end
function t.GetActive(p1, p2) --[[ GetActive | Line: 266 | Upvalues: t5 (copy) ]]
	return t5[p2]
end
function t.Create(p1, p2, p3) --[[ Create | Line: 270 | Upvalues: t4 (copy), v4 (copy), StunAnimator (copy), t2 (copy), insertEntry (copy), t (copy), BodyMover (copy), Encode (copy) ]]
	if not p1.Player then
		for v1, v2 in next, t4[p2] do
			if p3[v1] == nil then
				p3[v1] = v2
			end
		end

		local t3 = {}

		for v3, v42 in next, p3 do
			if v3 ~= "Duration" and (v3 ~= "Priority" and (v3 ~= "AirFix" and (v3 ~= "AnimationType" and v3 ~= "Meta"))) then
				if v3 == "Velocity" then
					assert(typeof(v42) == "Vector3", "Velocity must be a Vector3")

					if v42 ~= v42 or v42.Magnitude < 0.001 then
						v42 = Vector3.new(0, 0.0010000000474974513, 0)
					end
				end

				t3[v3] = v42

				if v3 == "MaxForce" or v3 == "MaxTorque" then
					local v7 = t3[v3]

					assert(if typeof(v7) == "Vector3" then true else false, "MaxForce/MaxTorque must be a Vector3")

					local v9 = v7 * (p1.Parent.Size.Y - 1) ^ 2

					t3[v3] = Vector3.new(math.min(600000, v9.X), math.min(600000, v9.Y), (math.min(600000, v9.Z))) * (if p2 == "BodyVelocity" then 1.5 else 15)
				end
			end
		end

		p3.Values = t3
		p3.Priority = p3.Priority or 1
		p3.Duration = p3.Duration or (1 / 0)
		p3.AirFix = p3.AirFix or false
		p3.Type = p2
		p3.StartTime = tick()
		p3.Enabled = true
		p3.LastCurrent = false
		p3.ApplyCounter = 0
		p3.Parent = p1
	end

	if p1.Player then
		p3.ID = math.random(9999999)
		p3.Character = p1.Player.Character
	elseif p1.Player2 then
		local v15 = (1 / 0)

		if p2 == "BodyPosition" then
			local MaxForce = p3.Values.MaxForce

			if typeof(MaxForce) == "Vector3" and (MaxForce.X > 0 or MaxForce.Z > 0) then
				v15 = 600
			end
		end

		p3.Duration = math.min(p3.Duration or (1 / 0), v15)
	end

	if p1.Meta then
		p3.Meta = p1.Meta
	end

	if p3.Velocity and p3.Velocity ~= p3.Velocity then
		p3.Velocity = Vector3.new(0, 0, 0)
	end

	if v4 and p3.AnimationType ~= "None" then
		local StunObjects = p1.Parent:FindFirstChild("StunObjects")

		if StunObjects then
			local function addStunAnimatorMarker(p12) --[[ addStunAnimatorMarker | Line: 350 | Upvalues: p3 (copy), StunObjects (copy), p1 (copy), StunAnimator (ref) ]]
				local _ = Instance.new("Folder")

				_.Name = "_"
				_:SetAttribute("LastBodyVelocityValue", p12)
				_:SetAttribute("LastBodyVelocityDuration", p3.Duration or (1 / 0))
				_:SetAttribute("LastBodyVelocityTimestamp", workspace:GetServerTimeNow())
				_:SetAttribute("LastBodyVelocityPriority", p3.Priority or 1)

				if p3.AnimationType then
					_:SetAttribute("AnimationType", p3.AnimationType)
				end

				_.Parent = StunObjects

				local function f1() --[[ Line: 362 | Upvalues: p3 (ref), _ (copy) ]]
					p3.DestroyCallback = nil
					_.Name = "_"
					_:Destroy()
				end

				p3.DestroyCallback = f1

				if p3.Duration and p3.Duration < 1000000 then
					task.delay(p3.Duration, f1)
				end

				local v2 = p1.Parent.Parent

				if not (v2 and v2:IsA("Model")) then
					return
				end

				StunAnimator(v2, nil)
			end

			if p3.Velocity then
				addStunAnimatorMarker(p3.Velocity)
			elseif p3.Position then
				addStunAnimatorMarker((Vector3.new(0, 0.0010000000474974513, 0)))
			end
		end
	end

	local v18 = setmetatable(p3, t2)

	if not p1.Player then
		local Running = p1.Running

		assert(Running, "Running movers list missing on body mover")
		insertEntry(Running[p2], v18)
		t.UpdateAll(p1, 0)

		return v18
	end

	if v4 and p1.Player then
		BodyMover:FireClient(p1.Player, Encode(v18), "Create", p2, p3)
	end

	return v18
end
function t.UpdateAll(p1, p2) --[[ UpdateAll | Line: 410 | Upvalues: t5 (copy), t3 (copy), t2 (copy), removeEntryByKey (copy), t7 (copy) ]]
	local v1 = tick()

	for v2, v3 in next, t5 do
		local v4 = if v2 then v2:FindFirstChild("HumanoidRootPart") else v2

		for i, v in ipairs(t3) do
			local v5

			v5 = if v == "BodyGyro" then {
	P = 0,
	D = 0,
	MaxTorque = Vector3.new()
} elseif v == "BodyVelocity" then {
	P = 0,
	_D = 0,
	MaxForce = Vector3.new()
} else {
	P = 0,
	D = 0,
	MaxForce = Vector3.new()
}

			local v8 = setmetatable({
				Priority = (-1 / 0),
				Enabled = false,
				Duration = 0,
				AirFix = false,
				StartTime = 0,
				LastCurrent = false,
				ApplyCounter = 0,
				Type = v,
				Parent = v4,
				Values = v5
			}, t2)

			for k, v9 in pairs(v3[v]) do
				local key = v9.key
				local value = v9.value

				if v1 - value.StartTime > value.Duration or value.Removing then
					value.Enabled = false
					value.Removing = true

					if value.DestroyCallback then
						task.spawn(value.DestroyCallback)
					end

					local v92 = t5[v2]

					assert(v92, "Body mover table missing for character")
					removeEntryByKey(v92[v], key)
					t7[v] = nil

					if v == "BodyPosition" then
						if v4 and v4:IsA("BasePart") then
							v4.AssemblyLinearVelocity = Vector3.new()
						end
					elseif v == "BodyVelocity" and (value.AirFix and (v4 and v4:IsA("BasePart"))) then
						v4.AssemblyLinearVelocity = v4.AssemblyLinearVelocity * Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
					end
				end

				if value.Priority >= v8.Priority and not value.Removing then
					v8 = value
				end
			end

			if v8.Enabled then
				if t7[v] ~= v8 then
					t7[v] = v8
					t2._SetActive(v8, true)
				end

				continue
			end

			if v8[v] ~= v8 then
				t7[v] = v8

				if v4 and v4:FindFirstChild(v8.Type) then
					t2._SetActive(v8, false)
				end
			end

			if not v8.Parent then
				t7[v] = nil
			end
		end
	end
end
function t2.SetForce(p1, p2) --[[ SetForce | Line: 511 | Upvalues: getServerPlayerFromCharacter (copy), v4 (copy), BodyMover (copy), Encode (copy), t7 (copy) ]]
	local v1 = p1.Parent
	local v2 = p2 * (v1.Parent.Size.Y - 1) ^ 2
	local v6 = Vector3.new(math.min(600000, v2.X), math.min(600000, v2.Y), (math.min(600000, v2.Z))) * 15
	local v7 = getServerPlayerFromCharacter(p1.Character)

	if v7 then
		if not v4 then
			return
		end

		BodyMover:FireClient(v7, Encode(p1), "SetForce", v6)
	else
		local v8 = v1.Parent[p1.Type]
		local v9 = t7[p1.Type] == p1

		if p1.Type == "BodyVelocity" or p1.Type == "BodyPosition" then
			p1.Values.MaxForce = v6

			if v9 then
				v8.MaxForce = v6
			end
		else
			if p1.Type ~= "BodyGyro" then
				return
			end

			p1.Values.MaxTorque = v6

			if not v9 then
				return
			end

			v8.MaxTorque = v6
		end
	end
end
function t2.Set(p1, p2) --[[ Set | Line: 544 | Upvalues: getServerPlayerFromCharacter (copy), BodyMover (copy), Encode (copy), t7 (copy) ]]
	local v1 = getServerPlayerFromCharacter(p1.Character)

	if v1 then
		BodyMover:FireClient(v1, Encode(p1), "Set", p2)

		return
	end

	local v2 = p1.Parent.Parent[p1.Type]
	local v3 = t7[p1.Type] == p1

	if p1.Type == "BodyVelocity" then
		assert(typeof(p2) == "Vector3", "BodyVelocity value must be Vector3")

		if p2 ~= p2 or p2.Magnitude < 0.001 then
			p2 = Vector3.new(0, 0.0010000000474974513, 0)
		end

		p1.Values.Velocity = p2

		if v3 then
			v2.Velocity = p2
		end
	elseif p1.Type == "BodyPosition" or p1.Type == "AlignPosition" then
		assert(if typeof(p2) == "Vector3" then true else false, "BodyPosition/AlignPosition value must be Vector3")
		p1.Values.Position = p2

		if v3 then
			v2.Position = p2
		end
	else
		if p1.Type ~= "BodyGyro" then
			return
		end

		assert(typeof(p2) == "CFrame", "BodyGyro value must be CFrame")
		p1.Values.CFrame = p2

		if not v3 then
			return
		end

		v2.CFrame = p2
	end
end
function t2.Enable(p1) --[[ Enable | Line: 579 | Upvalues: getServerPlayerFromCharacter (copy), BodyMover (copy), Encode (copy), t (copy) ]]
	local v1 = getServerPlayerFromCharacter(p1.Character)

	if v1 then
		BodyMover:FireClient(v1, Encode(p1), "Enable")
	else
		p1.Enabled = true
		t.UpdateAll(p1.Parent, 0)
	end
end
function t2.Disable(p1) --[[ Disable | Line: 590 | Upvalues: getServerPlayerFromCharacter (copy), BodyMover (copy), Encode (copy), t (copy) ]]
	local v1 = getServerPlayerFromCharacter(p1.Character)

	if v1 then
		BodyMover:FireClient(v1, Encode(p1), "Disable")
	else
		p1.Enabled = false
		t.UpdateAll(p1.Parent, 0)
	end
end
function t2.Destroy(p1) --[[ Destroy | Line: 601 | Upvalues: getServerPlayerFromCharacter (copy), v5 (copy), BodyMover (copy), Encode (copy), t (copy) ]]
	if p1.DestroyCallback then
		task.spawn(p1.DestroyCallback)
	end

	local v1 = getServerPlayerFromCharacter(p1.Character)

	if not v1 then
		p1.Removing = true
		t.UpdateAll(p1.Parent, 0)

		return
	end

	if v5 then
		return
	end

	BodyMover:FireClient(v1, Encode(p1), "Destroy")
end
function t2._SetActive(p1, p2) --[[ _SetActive | Line: 618 | Upvalues: v2 (copy) ]]
	local v1 = p1.Parent
	local v22 = v1.Parent[p1.Type]

	local function applyValues() --[[ applyValues | Line: 623 | Upvalues: p1 (copy), v22 (copy) ]]
		for k, v in pairs(p1.Values) do
			if k ~= "ID" and (k ~= "Character" and (k ~= "FaceCameraAtEnd" and (k ~= "StopOnCollision" and (k ~= "FollowVelocity" and (k ~= "MaxForce" and (k ~= "MaxTorque" and (k ~= "_D" and (k ~= "DestroyCallback" and k ~= "Meta")))))))) then
				v22[k] = v
			end
		end
	end

	if p2 then
		applyValues()
	end

	for k, v in pairs(p1.Values) do
		if k == "MaxForce" or (k == "MaxTorque" or k == "P") then
			v22[k] = v * (if p2 then 1 else 0)
		end
	end

	local ok, result = pcall(function() --[[ Line: 652 | Upvalues: v22 (copy), p2 (copy), v1 (copy) ]]
		v22.Parent = if p2 then v1.Parent.Parent else nil
	end)

	if ok or tostring(result):match("current parent: NULL") then
		return
	end

	v2:AtWarning():Log((tostring(result)))
end

if RunService:IsServer() and v3 then
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 662 | Upvalues: t (copy) ]]
		t.UpdateAll({}, p1)
	end)
elseif RunService:IsClient() and v3 then
	RunService.RenderStepped:Connect(function(p1) --[[ Line: 666 | Upvalues: t (copy) ]]
		t.UpdateAll({}, p1)
	end)
end

if RunService:IsClient() and v3 then
	task.spawn(function() --[[ Line: 672 | Upvalues: BodyMover (copy), Encode (copy), Players (copy), t (copy), t2 (copy) ]]
		local t3 = {}

		BodyMover.OnClientEvent:Connect(function(p1, p2, ...) --[[ Line: 682 | Upvalues: Encode (ref), Players (ref), t (ref), t3 (copy), t2 (ref) ]]
			local v1 = Encode(p1)

			if v1.Character ~= Players.LocalPlayer.Character then
				return
			end

			local v2 = t.new(v1.Character, v1.Meta)

			if p2 == "Create" then
				local v3, v4 = ...

				assert(type(v3) == "string", "Remote Create moverType must be a string")
				assert(if type(v4) == "table" then true else false, "Remote Create moverProperties must be a table")

				local v7 = t.Create(v2, v3, v4)

				t3[v1.ID] = v7

				if v7.Duration and v7.Duration < 1000000 then
					task.delay(v7.Duration + 0.1, function() --[[ Line: 701 | Upvalues: t3 (ref), v1 (copy), t2 (ref), v7 (copy) ]]
						if not t3[v1.ID] then
							return
						end

						t2.Destroy(v7)
						t3[v1.ID] = nil
					end)
				end
			elseif p2 == "Set" then
				local v8 = t3[v1.ID]

				if v8 then
					t2.Set(v8, ...)
				end
			elseif p2 == "Enable" then
				local v9 = t3[v1.ID]

				if v9 then
					t2.Enable(v9)
				end
			elseif p2 == "Disable" then
				local v10 = t3[v1.ID]

				if v10 then
					t2.Disable(v10)
				end
			else
				if p2 ~= "Destroy" then
					return
				end

				local v11 = t3[v1.ID]

				if not v11 then
					return
				end

				t2.Destroy(v11)
				t3[v1.ID] = nil
			end
		end)
	end)
end

return {
	new = t.new,
	GetActive = t.GetActive,
	UpdateAll = t.UpdateAll
}