-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Components = script:WaitForChild("Components")
local Dependencies = script:WaitForChild("Dependencies")
local CeiveImOverlay = require(Dependencies:WaitForChild("CeiveImOverlay"))
local Config = require(Dependencies:WaitForChild("Config"))
local Frustum = require(Dependencies:WaitForChild("Frustum"))
local Utilities = require(Dependencies:WaitForChild("Utilities"))
local v1 = nil
local Bone = require(Components:WaitForChild("Bone"))
local BoneTree = require(Components:WaitForChild("BoneTree"))
local ColliderObject = require(Components:WaitForChild("Collision"):WaitForChild("ColliderObject"))
local Runtime = Dependencies:WaitForChild("Runtime")

local function CopyPasteAttributes(p1, p2) --[[ CopyPasteAttributes | Line: 22 ]]
	for v1, v2 in p1:GetAttributes() do
		p2:SetAttribute(v1, v2)
	end
end

local SB_INDENT_LOG = Utilities.SB_INDENT_LOG
local SB_UNINDENT_LOG = Utilities.SB_UNINDENT_LOG
local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG
local SB_VERBOSE_WARN = Utilities.SB_VERBOSE_WARN
local t = {}

t.__index = t
function t.new() --[[ new | Line: 73 | Upvalues: HttpService (copy), t (copy) ]]
	return setmetatable({
		ShouldDestroy = false,
		ID = HttpService:GenerateGUID(false),
		BoneTrees = {},
		ColliderObjects = {}
	}, t)
end
function t.m_AppendBone(p1, p2, p3, p4, p5) --[[ m_AppendBone | Line: 96 | Upvalues: Utilities (copy), Bone (copy), SB_VERBOSE_LOG (copy) ]]
	local v1 = Utilities.GatherBoneSettings(p3)
	local v2 = Bone.new(p3, p2.Root, p2.RootPart)

	for v4, v5 in v1 do
		local v3

		v3 = if v5 == "\194\172" or not v5 then nil else v5
		v2[v4] = v3
	end

	local v6 = p2.Bones[p4]

	if p4 > 0 then
		local Magnitude = (v6.Position - v2.Position).Magnitude

		v2.FreeLength = Magnitude
		v2.Weight = Magnitude * 0.7
		v2.HeirarchyLength = p5
		v6.HasChild = true
	end

	if p5 <= p2.Settings.AnchorDepth then
		SB_VERBOSE_LOG("Anchoring bone")
		v2.Anchored = true
	end

	v2.ParentIndex = p4
	table.insert(p2.Bones, v2)
end
function t.m_CreateBoneTree(p1, p2, p3) --[[ m_CreateBoneTree | Line: 135 | Upvalues: Utilities (copy), BoneTree (copy), SB_VERBOSE_LOG (copy), SB_INDENT_LOG (copy), SB_UNINDENT_LOG (copy) ]]
	local v1 = Utilities.GatherObjectSettings(p2)
	local v2 = BoneTree.new(p3, p2)

	v2.Settings = v1
	SB_VERBOSE_LOG((("Creating bone tree %*; %*"):format(p2.Name, p3.Name)))
	SB_INDENT_LOG()

	local function v3(p12, p2, p3) --[[ AddChildren | Line: 144 | Upvalues: SB_VERBOSE_LOG (ref), SB_INDENT_LOG (ref), p1 (copy), v2 (copy), v3 (copy), SB_UNINDENT_LOG (ref) ]]
		SB_VERBOSE_LOG((("Adding bone: %*; %*; %*"):format(p12.Name, p2, p3)))
		SB_INDENT_LOG()

		local v1 = false

		for v22, v32 in p12:GetChildren() do
			if v32:IsA("Bone") then
				p1:m_AppendBone(v2, v32, p2, p3)
				v3(v32, #v2.Bones, p3 + 1)
				v1 = true
			end
		end

		if v1 then
			SB_UNINDENT_LOG()

			return
		end

		SB_VERBOSE_LOG("Adding tail bone")

		local v4 = p12.Parent
		local v6 = p12.WorldCFrame + p12.WorldCFrame.UpVector.Unit * (p12.WorldPosition - (v4:IsA("Bone") and v4.WorldPosition or v4.Position)).Magnitude
		local Bone = Instance.new("Bone")

		Bone.Parent = p12
		Bone.Name = p12.Name .. "_Tail"
		Bone.WorldCFrame = v6

		for v7, v8 in p12:GetAttributes() do
			Bone:SetAttribute(v7, v8)
		end

		p1:m_AppendBone(v2, Bone, #v2.Bones, p3)
		SB_UNINDENT_LOG()
	end

	p1:m_AppendBone(v2, p3, 0, 0)
	v3(p3, 1, 1)
	table.insert(p1.BoneTrees, v2)
	SB_UNINDENT_LOG()
end
function t.m_UpdateViewFrustum(p1) --[[ m_UpdateViewFrustum | Line: 194 | Upvalues: Config (copy), Frustum (copy) ]]
	if shared.FrameCounter % Config.FRUSTUM_FREQ ~= 0 then
		return
	end

	local v1, v2, v3, v4, v5, v6, v7, v8, v9 = Frustum.GetCFrames(workspace.CurrentCamera, Config.FAR_PLANE)

	for v10, v11 in p1.BoneTrees do
		v11.InView = Frustum.ObjectInFrustum({
			CFrame = v11.BoundingBoxCFrame,
			Size = v11.BoundingBoxSize
		}, v1, v2, v3, v4, v5, v6, v7, v8, v9)
	end
end
function t.m_CleanColliders(p1) --[[ m_CleanColliders | Line: 219 | Upvalues: SB_VERBOSE_WARN (copy), SB_INDENT_LOG (copy), SB_UNINDENT_LOG (copy) ]]
	if #p1.ColliderObjects ~= 0 then
		for v1, v2 in p1.ColliderObjects do
			if #v2.Colliders == 0 or v2.Destroyed == true then
				SB_VERBOSE_WARN("Deleting Collider Object")
				SB_INDENT_LOG()
				v2:Destroy()
				SB_UNINDENT_LOG()
				table.remove(p1.ColliderObjects, v1)
				_ = true
			end
		end
	end
end
function t.m_UpdateBoneTree(p1, p2, p3, p4) --[[ m_UpdateBoneTree | Line: 253 | Upvalues: SB_VERBOSE_LOG (copy) ]]
	if p2.Destroyed then
		p2:Destroy()
		table.remove(p1.BoneTrees, p3)

		return
	end

	p2:PreUpdate(p4)

	if p2.InView and (math.floor(p2.UpdateRate) ~= 0 and p2.InWorkspace) then
		for v1, v2 in p1.ColliderObjects do
			v2:Step()
		end

		local v3 = 1 / p2.UpdateRate

		p2.AccumulatedDelta = p2.AccumulatedDelta + p4

		local v4 = false

		while v3 < p2.AccumulatedDelta do
			p2.AccumulatedDelta = p2.AccumulatedDelta - v3
			p2:StepPhysics(v3)
			p2:Constrain(p1.ColliderObjects, v3)
			p2:SolveTransform(v3)
			v4 = true
		end

		if not v4 then
			return
		end

		task.synchronize()
		p2:ApplyTransform()

		return
	end

	p2:SkipUpdate()

	if p2.IsSkippingUpdates then
		return
	end

	task.synchronize()
	p2:ApplyTransform()
	SB_VERBOSE_LOG((("Skipping BoneTree, InView: %*, Update Rate == 0: %*, InWorkspace: %*"):format(p2.InView, math.floor(p2.UpdateRate) == 0, p2.InWorkspace)))
end
function t.m_CheckDestroy(p1) --[[ m_CheckDestroy | Line: 323 ]]
	p1.ShouldDestroy = false

	if #p1.BoneTrees == 0 then
		p1.ShouldDestroy = true

		return true
	end

	return false
end
function t.LoadObject(p1, p2) --[[ LoadObject | Line: 339 ]]
	local v1 = p2:GetAttribute("Roots")

	if not v1 then
		warn((("[SmartBone2::LoadObject] Cannot load an object with no roots defined %*"):format(p2.Name)))

		return
	end

	local v2 = v1:split(",")
	local t = {}

	for v3, v4 in p2:GetDescendants() do
		if v4:IsA("Bone") then
			if t[v4.Name] then
				warn((("[SmartBone2::LoadObject] Duplicate bones of name: %* in RootPart: %*"):format(v4.Name, p2.Name)))

				continue
			end

			t[v4.Name] = v4
		end
	end

	for v5, v6 in v2 do
		local v7 = t[v6]

		if v7 then
			p1:m_CreateBoneTree(p2, v7)

			continue
		end

		warn((("[SmartBone2::LoadObject] Couldn\'t find Root Bone of name: %* in RootPart: %*"):format(v6, p2.Name)))
	end
end
function t.LoadColliderModule(p1, p2, p3) --[[ LoadColliderModule | Line: 380 | Upvalues: HttpService (copy), ColliderObject (copy) ]]
	assert(p2, "[SmartBone2::LoadColliderModule] No collider module passed in")

	local v2 = ColliderObject.new(HttpService:JSONDecode((require(p2))), p3)

	table.insert(p1.ColliderObjects, v2)
end
function t.LoadRawCollider(p1, p2, p3) --[[ LoadRawCollider | Line: 395 | Upvalues: ColliderObject (copy) ]]
	local v1 = ColliderObject.new(p2, p3)

	table.insert(p1.ColliderObjects, v1)
end
function t.SkipUpdate(p1) --[[ SkipUpdate | Line: 403 ]]
	for v1, v2 in p1.BoneTrees do
		v2:SkipUpdate()
	end
end
function t.StepBoneTrees(p1, p2) --[[ StepBoneTrees | Line: 416 | Upvalues: SB_VERBOSE_WARN (copy) ]]
	if p1:m_CheckDestroy() then
		return
	end

	if p2 <= 0 then
		SB_VERBOSE_WARN("DeltaTime is zero or sub zero, not updating.")

		return
	end

	p1:m_CleanColliders()
	p1:m_UpdateViewFrustum()

	for v1, v2 in p1.BoneTrees do
		p1:m_UpdateBoneTree(v2, v1, p2)
	end
end
function t.DrawDebug(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14) --[[ DrawDebug | Line: 449 ]]
	for v1, v2 in p1.BoneTrees do
		v2:DrawDebug(p3, p4, p5, p6, p7, p12, p13, p14)
	end

	if not p2 then
		return
	end

	for v3, v4 in p1.ColliderObjects do
		v4:DrawDebug(p8, p9, p10, p11)
	end
end
function t.DrawOverlay(p1, p2) --[[ DrawOverlay | Line: 493 | Upvalues: Config (copy) ]]
	if not Config.DEBUG_OVERLAY_ENABLED then
		return
	end

	local v1 = Color3.new(1, 0.431373, 0.713725)
	local v2 = Color3.new(255/255, 255/255, 255/255)
	local v3 = Color3.new(0.486275, 0.431373, 1)
	local v4 = Color3.new(255/255, 255/255, 255/255)

	p2.Begin(("SmartBone Instance ID: %*"):format(p1.ID), v1, v2)
	p2.Text((("Frame Counter: %*"):format(shared.FrameCounter)))

	if Config.DEBUG_OVERLAY_TREE then
		for v5, v6 in p1.BoneTrees do
			if Config.DEBUG_OVERLAY_MAX_TREES > 0 and Config.DEBUG_OVERLAY_TREE_OFFSET + Config.DEBUG_OVERLAY_MAX_TREES <= v5 then
				break
			end

			if not (v5 < Config.DEBUG_OVERLAY_TREE_OFFSET) then
				p2.Begin(("Bone Tree %*"):format(v5), v3, v4)
				v6:DrawOverlay(p2)
				p2.End()
			end
		end
	end

	p2.End()
end
function t.Destroy(p1) --[[ Destroy | Line: 529 | Upvalues: SB_VERBOSE_LOG (copy) ]]
	SB_VERBOSE_LOG("Deleting SmartBone Object")

	for v1, v2 in p1.BoneTrees do
		v2:Destroy()
	end

	for v3, v4 in p1.ColliderObjects do
		v4:Destroy()
	end

	setmetatable(p1, nil)
end
function t.Start() --[[ Start | Line: 547 | Upvalues: RunService (copy), t (copy), Config (copy), Players (copy), v1 (ref), CollectionService (copy), SB_VERBOSE_LOG (copy), SB_INDENT_LOG (copy), Utilities (copy), Runtime (copy), SB_UNINDENT_LOG (copy), CeiveImOverlay (copy) ]]
	if not RunService:IsClient() then
		warn("Smartbone.Start() can only be called in client context.")

		return
	end

	if t.Running then
		warn("Cannot call Smartbone.Start() multiple times")

		return
	end

	if Config.STARTUP_PRINT_ENABLED or Config.LOG_VERBOSE then
		print((("SmartBone2 v%* Starting"):format(Config.VERSION)))
	end

	t.Running = true

	local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
	local v12 = Instance.new("Folder")

	v12.Name = "SmartBone-Actors"
	v12.Parent = PlayerScripts

	local OverlayEvent = Instance.new("BindableEvent")

	OverlayEvent.Name = "OverlayEvent"
	OverlayEvent.Parent = script
	OverlayEvent.Event:Connect(function(p1, ...) --[[ Line: 575 | Upvalues: Config (ref), v1 (ref) ]]
		if not Config.DEBUG_OVERLAY_ENABLED then
			return
		end

		if p1 == "Text" then
			v1:Text(...)

			return
		end

		if p1 == "Begin" then
			v1:Begin(...)

			return
		end

		if p1 ~= "End" then
			return
		end

		v1:End()
	end)

	local function GatherColliders() --[[ GatherColliders | Line: 589 | Upvalues: CollectionService (ref), SB_VERBOSE_LOG (ref), Config (ref) ]]
		local t = {
			Key = {},
			Raw = {}
		}

		for v1, v2 in CollectionService:GetTagged("SmartCollider") do
			if v2:IsA("BasePart") then
				local v3 = v2:GetAttribute("ColliderKey")

				if v3 then
					local v4 = tostring(v3)

					if not t.Key[v4] then
						t.Key[v4] = {}
					end

					v3 = v4
					table.insert(t.Key[v4], v2)
				end

				SB_VERBOSE_LOG((("Adding collider: %*, Collider Key: %*"):format(v2.Name, v3)))
				table.insert(t.Raw, v2)

				if Config.YIELD_ON_COLLIDER_GATHER then
					task.wait()
				end
			end
		end

		return t
	end

	local function SetupObject(p1) --[[ SetupObject | Line: 623 | Upvalues: SB_VERBOSE_LOG (ref), SB_INDENT_LOG (ref), GatherColliders (copy), Utilities (ref), Runtime (ref), v12 (copy), SB_UNINDENT_LOG (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		SB_VERBOSE_LOG((("Setup Object: %*"):format(p1.Name)))
		SB_INDENT_LOG()

		local v1 = GatherColliders()
		local v2 = p1:GetAttribute("ColliderKey")
		local t = {}

		for v6, v7 in if v2 then v1.Key[tostring(v2)] or {} else v1.Raw or {} do
			table.insert(t, { Utilities.GetCollider(v7), v7 })
		end

		print("Setting global colliders, for", p1, "with colliders", v1, "descriptions:", t)

		local Actor = Instance.new("Actor")
		local v8 = Runtime:Clone()

		v8.Parent = Actor
		v8.Enabled = true
		Actor.Parent = v12
		task.wait()
		Actor:SendMessage("Setup", p1, t, script)
		SB_VERBOSE_LOG("Runtime Started")
		SB_UNINDENT_LOG()
	end

	CollectionService:GetInstanceAddedSignal("SmartBone"):Connect(SetupObject)

	for v2, v3 in CollectionService:GetTagged("SmartBone") do
		SetupObject(v3)
	end

	if not Config.DEBUG_OVERLAY_ENABLED then
		return {
			Stop = function() --[[ Stop | Line: 698 | Upvalues: t (ref), Config (ref), v12 (copy) ]]
				t.Running = false

				if not Config.RESET_BONE_ON_DESTROY then
					v12:Destroy()

					return
				end

				for v1, v2 in v12:GetChildren() do
					v2:SendMessage("Destroy")
				end
			end
		}
	end

	v1 = CeiveImOverlay.new()

	local SmartBoneDebugOverlay = Instance.new("ScreenGui")

	SmartBoneDebugOverlay.Name = "SmartBoneDebugOverlay"
	SmartBoneDebugOverlay.IgnoreGuiInset = true
	SmartBoneDebugOverlay.ResetOnSpawn = false
	SmartBoneDebugOverlay.Parent = Players.LocalPlayer.PlayerGui
	v1.BackFrame.Parent = SmartBoneDebugOverlay
	RunService.RenderStepped:Connect(function() --[[ Line: 692 | Upvalues: v1 (ref) ]]
		v1:Render()
	end)

	return {
		Stop = function() --[[ Stop | Line: 698 | Upvalues: t (ref), Config (ref), v12 (copy) ]]
			t.Running = false

			if not Config.RESET_BONE_ON_DESTROY then
				v12:Destroy()

				return
			end

			for v1, v2 in v12:GetChildren() do
				v2:SendMessage("Destroy")
			end
		end
	}
end

return t