-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

if not game:GetService("RunService"):IsClient() then
	warn("Attempted to initialize SmartBone on Server.")

	return nil
end

local Dependencies = script:WaitForChild("Dependencies")
local Components = script:WaitForChild("Components")
local Config = require(Dependencies.Config)
local UnitConversion = require(Dependencies.UnitConversion)
local DefaultSettings = require(Dependencies.DefaultSettings)
local ParticleTree = require(Components.ParticleTree)
local Particle = require(Components.Particle)
local SettingsMath = require(Dependencies.SettingsMath)
local Utilities = require(Dependencies.Utilities)
local v1 = Random.new(12098135901304)
local v2 = CollectionService:GetTagged("SmartBone")
local Debug = Config.Debug
local SMARTBONE_DEBUGFOLDER

if Debug then
	SMARTBONE_DEBUGFOLDER = Instance.new("Model")
	SMARTBONE_DEBUGFOLDER.Name = "SMARTBONE_DEBUGFOLDER"
	SMARTBONE_DEBUGFOLDER.Parent = workspace

	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.fromRGB(255, 0, 0)
	Highlight.OutlineTransparency = 1
	Highlight.FillTransparency = 0
	Highlight.Parent = SMARTBONE_DEBUGFOLDER
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Enabled = true
else
	SMARTBONE_DEBUGFOLDER = nil
end

local t = {}
local t2 = {}

t2.__index = t2
function t2.new(p1, p2) --[[ new | Line: 119 | Upvalues: v1 (copy), UnitConversion (copy), t2 (copy), DefaultSettings (copy) ]]
	local t = {
		Time = 0,
		WindPreviousPosition = Vector3.new(0, 0, 0),
		Removed = false,
		InRange = false,
		ID = v1:NextInteger(1, 10000000),
		RootPart = p1,
		ParticleTrees = {},
		Connections = {},
		RootList = p2
	}

	t.ObjectScale = UnitConversion.Convert(math.abs(p1.Size.X), "Millimeter")
	t.RemovedEvent = Instance.new("BindableEvent")
	t.Settings = {}

	local v2 = setmetatable(t, t2)

	for v3, v4 in DefaultSettings do
		v2.Settings[v3] = p1:GetAttribute(v3) or v4
	end

	v2.Settings.BlendWeight = 1
	v2.Settings.UpdateRate = math.floor(v2.Settings.UpdateRate + 0.1)
	v2:Init()
	v2:UpdateParameters(v2.Settings)

	return v2
end
function t2.Init(p1) --[[ Init | Line: 150 | Upvalues: t (copy), Lighting (copy) ]]
	local RootPart = p1.RootPart

	t[p1.ID] = p1
	p1.Connections.AttributeChanged = RootPart.AttributeChanged:ConnectParallel(function(p12) --[[ Line: 157 | Upvalues: p1 (copy), RootPart (copy) ]]
		if p1.Settings[p12] then
			p1:UpdateParameters(p12, RootPart:GetAttribute(p12))
		end
	end)
	p1.Connections.LightingAttributeChanged = Lighting.AttributeChanged:ConnectParallel(function(p12) --[[ Line: 164 | Upvalues: p1 (copy), Lighting (ref) ]]
		if p1.Settings[p12] then
			p1:UpdateParameters(p12, Lighting:GetAttribute(p12))
		end
	end)

	for v1, v2 in RootPart:GetDescendants() do
		if v2:IsA("Bone") and (v2.Parent:IsA("Bone") and #v2:GetChildren() == 0) then
			local Bone = Instance.new("Bone")

			Bone.Parent = v2
			Bone.Name = v2.Name .. "_Tail"
			Bone.WorldCFrame = v2.WorldCFrame + v2.WorldCFrame.UpVector.Unit * (v2.WorldPosition - v2.Parent.WorldPosition).Magnitude
		end
	end

	for v4, v5 in p1.RootList do
		p1:AppendParticleTree(v5)
	end

	for v6, v7 in p1.ParticleTrees do
		p1:AppendParticles(v7, v7.Root, 0, 0)
	end
end
function t2.AppendParticleTree(p1, p2) --[[ AppendParticleTree | Line: 191 | Upvalues: ParticleTree (copy) ]]
	table.insert(p1.ParticleTrees, ParticleTree.new(p2, p1.RootPart, p1.Settings.Gravity))
end
function t2.AppendParticles(p1, p2, p3, p4, p5) --[[ AppendParticles | Line: 195 | Upvalues: Particle (copy), Debug (copy), SMARTBONE_DEBUGFOLDER (ref), Utilities (copy) ]]
	local Settings = p1.Settings
	local v1 = Particle.new(p3, p2.Root, p1.RootPart, Settings)

	v1.Position = p3.WorldPosition
	v1.LastPosition = p3.WorldPosition
	v1.ParentIndex = p4
	v1.BoneLength = p5
	v1.HeirarchyLength = 0

	if Debug == true then
		v1.DebugPart = Instance.new("Part")
		v1.DebugPart.Size = Vector3.new(0.1, 0.1, 0.1)
		v1.DebugPart.Anchored = true
		v1.DebugPart.CanCollide = false
		v1.DebugPart.CastShadow = false
		v1.DebugPart.CanTouch = false
		v1.DebugPart.CanQuery = false
		v1.DebugPart.Color = Color3.fromRGB(255, 0, 0)
		v1.DebugPart.Parent = SMARTBONE_DEBUGFOLDER
	end

	if p4 >= 1 then
		p5 = (p2.Particles[p4].Bone.WorldPosition - v1.Position).Magnitude
		v1.BoneLength = p5
		v1.Weight = p5 * 0.7
		v1.HeirarchyLength = Utilities.GetHierarchyLength(p3, p2.Root)
	end

	if v1.HeirarchyLength <= Settings.AnchorDepth then
		v1.Anchored = true
	end

	table.insert(p2.Particles, v1)

	local v2 = #p2.Particles
	local v3 = p3:GetChildren()

	for i = 1, #v3 do
		local v4 = v3[i]

		if v4:IsA("Bone") then
			p1:AppendParticles(p2, v4, v2, p5)
		end
	end
end
function t2.UpdateParameters(p1, p2, p3) --[[ UpdateParameters | Line: 240 | Upvalues: SettingsMath (copy) ]]
	if not p1.Settings[p2] then
		return
	end

	p1.Settings[p2] = if SettingsMath[p2] then SettingsMath[p2](p3) else p3
end
function t2.PreUpdate(p1, p2) --[[ PreUpdate | Line: 247 ]]
	local RootPart = p2.RootPart
	local Root = p2.Root

	p2.ObjectMove = RootPart.Position - p2.ObjectPreviousPosition
	p2.ObjectPreviousPosition = RootPart.Position
	p2.RestGravity = Root.CFrame:PointToWorldSpace(p2.LocalGravity)

	for v1, v2 in p2.Particles do
		v2.LastTransformOffset = v2.TransformOffset

		if v2.Bone == v2.Root then
			v2.TransformOffset = RootPart.CFrame * v2.RootTransform
		else
			v2.TransformOffset = Root.WorldCFrame * v2.Transform
		end

		v2.LocalTransformOffset = Root.CFrame * v2.LocalTransform
	end
end
function t2.UpdateParticles(p1, p2, p3, p4) --[[ UpdateParticles | Line: 267 ]]
	local Settings = p1.Settings
	local Damping = Settings.Damping
	local Unit = Settings.Gravity.Unit
	local v2 = (Settings.Gravity - Unit * math.max(p2.RestGravity:Dot(Unit), 0) + Settings.Force) * (p1.ObjectScale * p3)
	local v3 = p4 == 0 and p2.ObjectMove or Vector3.new(0, 0, 0)

	for v5, v6 in p2.Particles do
		local v4

		if v6.ParentIndex >= 1 and v6.Anchored == false then
			if Settings.WindInfluence > 0 then
				local v7 = p2.WindOffset + (os.clock() - v6.HeirarchyLength / 5) + (v6.TransformOffset.Position - p2.Root.WorldPosition).Magnitude / 5 * Settings.WindInfluence
				local v14 = Vector3.new(Settings.WindDirection.X + Settings.WindDirection.X * math.sin(v7 * Settings.WindSpeed), Settings.WindDirection.Y + math.sin(v7 * Settings.WindSpeed) * 0.05, Settings.WindDirection.Z + Settings.WindDirection.X * math.sin(v7 * Settings.WindSpeed)) / v6.BoneLength * Settings.WindInfluence

				v4 = v14 * (Settings.WindStrength / 100 * (math.clamp(v6.HeirarchyLength, 1, 10) / 10)) * v6.Weight
				p1.WindPreviousPosition = v4
			else
				v4 = Vector3.new(0, 0, 0)
			end

			local v16 = v6.Position - v6.LastPosition
			local v17 = v3 * Settings.Inertia

			v6.LastPosition = v6.Position + v17
			v6.Position = v6.Position + (v16 * (1 - Damping) + v2 + v17 + v4)

			continue
		end

		v6.LastPosition = v6.TransformOffset.Position
		v6.Position = v6.TransformOffset.Position
	end
end
function t2.CorrectParticles(p1, p2, p3) --[[ CorrectParticles | Line: 331 ]]
	local Settings = p1.Settings
	local Stiffness = Settings.Stiffness

	for v1, v2 in p2.Particles do
		local v3 = p2.Particles[v2.ParentIndex]

		if v3 and (v2.ParentIndex >= 1 and v2.Anchored == false) then
			local Magnitude = (v3.TransformOffset.Position - v2.TransformOffset.Position).Magnitude

			if Stiffness > 0 or Settings.Elasticity > 0 then
				local Position = (CFrame.new(v3.Position) * v3.TransformOffset.Rotation * CFrame.new(v2.LocalTransformOffset.Position)).Position

				v2.Position = v2.Position + (Position - v2.Position) * (Settings.Elasticity * p3)

				if Stiffness > 0 then
					local v5 = Position - v2.Position
					local Magnitude2 = v5.Magnitude
					local v6 = Magnitude * (1 - Stiffness) * 2

					if v6 < Magnitude2 then
						v2.Position = v2.Position + v5 * ((Magnitude2 - v6) / Magnitude2)
					end
				end
			end

			local v7 = v3.Position - v2.Position
			local Magnitude2 = v7.Magnitude

			if Magnitude2 > 0 then
				v2.Position = v2.Position + v7 * ((Magnitude2 - Magnitude) / Magnitude2)
			end
		end
	end
end
function t2.SkipUpdateParticles(p1, p2) --[[ SkipUpdateParticles | Line: 371 ]]
	for v1, v2 in p2.Particles do
		if v2.ParentIndex >= 1 and not v2.Anchored then
			v2.LastPosition = v2.LastPosition + p2.ObjectMove
			v2.Position = v2.Position + p2.ObjectMove

			local v3 = p2.Particles[v2.ParentIndex]
			local Magnitude = (v3.TransformOffset.Position - v2.TransformOffset.Position).Magnitude
			local Stiffness = p1.Settings.Stiffness

			if Stiffness > 0 then
				local v4 = v3.Position + CFrame.lookAt(v3.Position, v2.Position).LookVector.Unit * (v3.Position - v2.Position).Magnitude - v2.Position
				local Magnitude2 = v4.Magnitude
				local v5 = Magnitude * (1 - Stiffness) * 2

				if v5 < Magnitude2 then
					v2.Position = v2.Position + v4 * ((Magnitude2 - v5) / Magnitude2)
				end
			end

			local v6 = v3.Position - v2.Position
			local Magnitude2 = v6.Magnitude

			if Magnitude < Magnitude2 then
				v2.Position = v2.Position + v6 * ((Magnitude2 - Magnitude) / Magnitude2)
			end

			continue
		end

		v2.LastPosition = v2.TransformOffset.Position
		v2.Position = v2.TransformOffset.Position
	end
end
function t2.CalculateTransforms(p1, p2, p3) --[[ CalculateTransforms | Line: 409 | Upvalues: Utilities (copy) ]]
	if not p1.InRange then
		return
	end

	for v1, v2 in p2.Particles do
		if v2.ParentIndex >= 1 and v2.Anchored == false then
			local v3 = p2.Particles[v2.ParentIndex]
			local Bone = v3.Bone

			if v3 and (Bone and (Bone:IsA("Bone") and Bone ~= p2.Root)) then
				local TransformOffset = v3.TransformOffset
				local v6 = Utilities.GetRotationBetween(TransformOffset.UpVector, v2.Position - v3.Position, (TransformOffset:PointToObjectSpace(v3.LocalTransformOffset.Position))).Rotation * TransformOffset.Rotation

				v3.CalculatedWorldCFrame = Bone.WorldCFrame:Lerp(CFrame.new(v3.Position) * v6, 1 - 0.00001 ^ p3)
			end
		end
	end
end
function t2.TransformBones(p1, p2) --[[ TransformBones | Line: 438 ]]
	if not p1.InRange then
		return
	end

	for v1, v2 in p2.Particles do
		if v2.ParentIndex >= 1 and v2.Anchored == false then
			local v3 = p2.Particles[v2.ParentIndex]
			local Bone = v3.Bone

			if v3 and (Bone and (Bone:IsA("Bone") and Bone ~= p2.Root)) then
				if v3.Anchored and p1.Settings.AnchorsRotate == false then
					Bone.WorldCFrame = v3.TransformOffset

					continue
				end

				Bone.WorldCFrame = v3.CalculatedWorldCFrame
			end
		end
	end
end
function t2.DEBUG(p1, p2) --[[ DEBUG | Line: 459 ]]
	for v1, v2 in p2.Particles do
		if v2 then
			v2.DebugPart.CFrame = CFrame.new(v2.Position)
		end
	end
end
function t2.RunLoop(p1, p2, p3, p4) --[[ RunLoop | Line: 467 ]]
	local v1 = p3 * 10
	local v2

	if p4 > 0 then
		p1.Time = p1.Time + p3

		if 1 / p4 <= p1.Time then
			p1.Time = 0
			v2 = true
		else
			v2 = false
		end
	else
		v2 = true
	end

	if v2 then
		p1:UpdateParticles(p2, v1, 0)
		p1:CorrectParticles(p2, v1)
	else
		p1:SkipUpdateParticles(p2)
	end
end
function t2.ResetParticles(p1, p2) --[[ ResetParticles | Line: 490 ]]
	for v1, v2 in p2.Particles do
		v2.LastPosition = v2.TransformOffset.Position
		v2.Position = v2.TransformOffset.Position
	end
end
function t2.ResetTransforms(p1, p2) --[[ ResetTransforms | Line: 497 ]]
	for v1, v2 in p2.Particles do
		v2.Bone.WorldCFrame = if v2.Bone == v2.Root then p2.RootPart.CFrame * v2.RootTransform else p2.Root.WorldCFrame * v2.Transform
	end
end
function t2.UpdateBones(p1, p2, p3) --[[ UpdateBones | Line: 511 ]]
	for v1, v2 in p1.ParticleTrees do
		p1:PreUpdate(v2, p2)
		p1:RunLoop(v2, p2, p3)
		p1:CalculateTransforms(v2, p2)
	end
end
function t2.Start() --[[ Start | Line: 519 | Upvalues: Debug (copy), Utilities (copy), t (copy), CollectionService (copy), v2 (copy) ]]
	local LocalPlayer = game.Players.LocalPlayer
	local Actors = Instance.new("Folder")

	Actors.Name = "Actors"
	Actors.Parent = LocalPlayer:WaitForChild("PlayerScripts")

	local function DebugPrint(p1) --[[ DebugPrint | Line: 526 | Upvalues: Debug (ref) ]]
		if not Debug then
			return
		end

		warn(p1)
	end

	local t2 = {}
	local t3 = {}

	local function registerSmartBoneObject(p1) --[[ registerSmartBoneObject | Line: 535 | Upvalues: Utilities (ref), Actors (copy), t2 (copy), t3 (copy), Debug (ref) ]]
		if not (p1:IsA("BasePart") and (Utilities.WaitForChildOfClass(p1, "Bone", 3) and game.Workspace:IsAncestorOf(p1))) then
			return
		end

		local t = {}

		if p1:GetAttribute("Roots") and (p1:GetAttribute("Roots") ~= nil and typeof(p1:GetAttribute("Roots")) == "string") then
			for i, v in ipairs((string.split(p1:GetAttribute("Roots"), ","))) do
				local v2 = p1:FindFirstChild(v, true)

				if v2 and v2:IsA("Bone") then
					table.insert(t, v2)
				end
			end
		end

		if #t > 0 then
			local Actor = Instance.new("Actor")
			local Event = Instance.new("BindableFunction")

			Event.Name = "Event"
			Event.Parent = Actor

			local Runtime = script.Dependencies.ActorScript:Clone()

			Runtime.Name = "Runtime"
			Runtime.Parent = Actor
			Actor.Parent = Actors
			Runtime.Enabled = true
			t2[p1] = Actor.Event:Invoke(p1, t)
			Actor.Name = p1.Name .. t2[p1].ID
			t2[p1].RemovedEvent.Event:Once(function() --[[ Line: 576 | Upvalues: Actor (copy) ]]
				Actor.Runtime.Enabled = false
				Actor:Destroy()
			end)
			table.insert(t3, p1)

			local v4 = "Created new SmartBone Object with ID: " .. t2[p1].ID

			if Debug then
				warn(v4)
			end
		else
			table.insert(t3, p1)

			local v6 = "Failed to create SmartBone Object for " .. p1:GetFullName() .. "! Make sure you have defined the Root Bone(s) for this object!"

			if not Debug then
				return
			end

			warn(v6)
		end
	end

	local function removeSmartBoneObject(p1) --[[ removeSmartBoneObject | Line: 594 | Upvalues: t2 (copy), Debug (ref), t (ref) ]]
		if not t2[p1] then
			return
		end

		local v1 = "Removing SmartBone Object with ID: " .. t2[p1].ID

		if Debug then
			warn(v1)
		end

		task.spawn(function() --[[ Line: 597 | Upvalues: t2 (ref), p1 (copy), t (ref) ]]
			for k, v in pairs(t2[p1].Connections) do
				v:Disconnect()
			end

			t2[p1].SimulationConnection:Disconnect()
			task.wait()
			t2[p1].RemovedEvent:Destroy()

			for i, v in ipairs(t2[p1].ParticleTrees) do
				for v1, v2 in v.Particles do
					for v3, v4 in v2.RecyclingBin do
						v4:Destroy()
					end
				end
			end

			task.wait()

			if not t[t2[p1].ID] then
				t2[p1].Removed = true
				t2[p1].RemovedEvent:Fire()
				t2[p1] = nil

				return
			end

			t[t2[p1].ID] = nil
			t2[p1].Removed = true
			t2[p1].RemovedEvent:Fire()
			t2[p1] = nil
		end)
	end

	CollectionService:GetInstanceAddedSignal("SmartBone"):Connect(registerSmartBoneObject)
	CollectionService:GetInstanceRemovedSignal("SmartBone"):Connect(removeSmartBoneObject)

	for k, v in pairs(v2) do
		if not (t2[v] or table.find(t3, v)) then
			task.spawn(function() --[[ Line: 635 | Upvalues: registerSmartBoneObject (copy), v (copy) ]]
				registerSmartBoneObject(v)
			end)
		end
	end
end

return t2