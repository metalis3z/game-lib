-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Player = require(ReplicatedStorage.Library.Player)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Enum.RenderPriority.Camera.Value + 3
local v2 = Log.new()
local LocalPlayer = Players.LocalPlayer
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v3 = nil
local v4 = false
local t6 = {
	_restorePart = function(p1, p2) --[[ _restorePart | Line: 54 ]]
		local v1 = p1[p2]

		if v1 == nil then
			return
		end

		p1[p2] = nil

		if p2.Parent == nil then
			return
		end

		p2.Transparency = v1
	end,
	_applyPart = function(p1, p2, p3) --[[ _applyPart | Line: 66 ]]
		local v1 = p1[p2]

		if p2.Transparency >= 1 then
			return
		end

		if v1 == nil then
			local Transparency = p2.Transparency

			if p3 <= Transparency then
				return
			end

			p1[p2] = Transparency
			v1 = Transparency
		end

		p2.Transparency = math.max(v1, p3)
	end,
	_restoreModel = function(p1) --[[ _restoreModel | Line: 88 ]]
		p1.RestoreAt = nil

		local FadeSnapshot = p1.FadeSnapshot

		if FadeSnapshot == nil then
			return
		end

		for k, v in pairs(FadeSnapshot) do
			if k.Parent ~= nil then
				k.Transparency = v
			end
		end

		table.clear(FadeSnapshot)
		p1.FadeSnapshot = nil
	end
}

function t6._reconcileModel(p1, p2, p3) --[[ _reconcileModel | Line: 104 | Upvalues: t6 (copy) ]]
	if p2 then
		p1.RestoreAt = nil
		t6._fadeModel(p1)

		return
	end

	if p1.FadeSnapshot == nil then
		p1.RestoreAt = nil

		return
	end

	local RestoreAt = p1.RestoreAt

	if RestoreAt == nil then
		p1.RestoreAt = p3 + 1

		return
	end

	if not (RestoreAt <= p3) then
		return
	end

	t6._restoreModel(p1)
end
function t6._fadeModel(p1) --[[ _fadeModel | Line: 127 | Upvalues: t6 (copy) ]]
	local FadeSnapshot = p1.FadeSnapshot

	if FadeSnapshot == nil then
		local t = {}

		p1.FadeSnapshot = t

		for k in pairs(p1.Parts) do
			t6._applyPart(t, k, p1.TargetTransparency)
		end
	else
		for k in pairs(p1.Parts) do
			t6._applyPart(FadeSnapshot, k, p1.TargetTransparency)
		end
	end
end
function t6._restoreAll() --[[ _restoreAll | Line: 143 | Upvalues: t (copy), t6 (copy), t3 (copy) ]]
	for k, v in pairs(t) do
		t6._restoreModel(v)
	end

	table.clear(t3)
end
function t6._trackPart(p1, p2, p3) --[[ _trackPart | Line: 150 | Upvalues: t2 (copy), t6 (copy) ]]
	if not p3:IsA("BasePart") then
		return
	end

	local v1 = if t2[p3] == nil then true else false

	assert(v1, (("Tracked camera-occlusion part %* is already tracked"):format((p3:GetFullName()))))
	p2.Parts[p3] = true
	t2[p3] = p1

	local FadeSnapshot = p2.FadeSnapshot

	if FadeSnapshot == nil then
		return
	end

	t6._applyPart(FadeSnapshot, p3, p2.TargetTransparency)
end
function t6._untrackPart(p1, p2) --[[ _untrackPart | Line: 168 | Upvalues: t6 (copy), t2 (copy) ]]
	if not p2:IsA("BasePart") or p1.Parts[p2] ~= true then
		return
	end

	local FadeSnapshot = p1.FadeSnapshot

	if FadeSnapshot ~= nil then
		t6._restorePart(FadeSnapshot, p2)
	end

	p1.Parts[p2] = nil
	t2[p2] = nil
end
function t6._isBottomNearPlayer(p1, p2) --[[ _isBottomNearPlayer | Line: 181 ]]
	local v1 = p1.Model:GetScale() / p1.InitialModelScale
	local VisibleBoundsOffset = p1.VisibleBoundsOffset
	local v3 = p1.PrimaryPart.CFrame * (CFrame.new(VisibleBoundsOffset.Position * v1) * VisibleBoundsOffset.Rotation)
	local v4 = v3:PointToObjectSpace(p2.Position)
	local v5 = p1.VisibleBoundsSize * v1 * 0.5
	local v11 = v3:PointToWorldSpace((Vector3.new(math.clamp(v4.X, -v5.X, v5.X), -v5.Y, (math.clamp(v4.Z, -v5.Z, v5.Z))))) - p2.Position

	return v11.X * v11.X + v11.Z * v11.Z <= 625
end
function t6._step() --[[ _step | Line: 200 | Upvalues: v4 (ref), t6 (copy), Workspace (copy), Player (copy), LocalPlayer (copy), t4 (copy), t5 (copy), t3 (copy), t2 (copy), t (copy) ]]
	if not v4 then
		t6._restoreAll()

		return
	end

	local CurrentCamera = Workspace.CurrentCamera
	local v1 = Player.Optional.Character(LocalPlayer)
	local v2 = Player.Optional.Head(LocalPlayer)
	local v3 = Player.Optional.HumanoidRootPart(LocalPlayer)

	if CurrentCamera == nil or (v1 == nil or (v2 == nil or v3 == nil)) then
		t6._restoreAll()

		return
	end

	t4[1] = v2.Position
	t5[1] = v1
	table.clear(t3)

	for i, v in ipairs(CurrentCamera:GetPartsObscuringTarget(t4, t5)) do
		local v42 = t2[v]

		if v42 ~= nil and t3[v42] ~= true then
			t3[v42] = true
		end
	end

	local v5 = Workspace:GetServerTimeNow()

	for k, v in pairs(t) do
		if not v.Suppressed then
			t6._reconcileModel(v, if t3[k] == true then true else t6._isBottomNearPlayer(v, v3), v5)
		end
	end
end
function t6.TrackModel(p1, p2) --[[ TrackModel | Line: 240 | Upvalues: Asserts (copy), t (copy), Trove (copy), BBFromModelVisibleOnly (copy), t6 (copy) ]]
	Asserts.Model(p1)
	Asserts.number(p2)
	assert(if p2 >= 0 then if p2 <= 1 then true else false else false, "Target transparency must be within [0, 1]")
	assert(if t[p1] == nil then true else false, (("Tracked camera-occlusion model %* is already tracked"):format(p1.Name)))

	local v4 = Trove.new()
	local v6 = assert(p1.PrimaryPart, (("Tracked camera-occlusion model %* must have a PrimaryPart"):format(p1.Name)))
	local v7 = p1:GetScale()

	assert(if v7 > 0 then true else false, (("Tracked camera-occlusion model %* must have positive scale"):format(p1.Name)))

	local v10, v11 = BBFromModelVisibleOnly(p1)
	local t2 = {
		FadeSnapshot = nil,
		RestoreAt = nil,
		Suppressed = false,
		Trove = v4,
		Model = p1,
		Parts = {},
		TargetTransparency = p2,
		InitialModelScale = v7,
		PrimaryPart = v6,
		VisibleBoundsOffset = v6.CFrame:ToObjectSpace(v10),
		VisibleBoundsSize = v11
	}

	t[p1] = t2

	for i, v in ipairs(p1:GetDescendants()) do
		t6._trackPart(p1, t2, v)
	end

	v4:Connect(p1.DescendantAdded, function(p12) --[[ Line: 269 | Upvalues: t6 (ref), p1 (copy), t2 (copy) ]]
		t6._trackPart(p1, t2, p12)
	end)
	v4:Connect(p1.DescendantRemoving, function(p1) --[[ Line: 272 | Upvalues: t6 (ref), t2 (copy) ]]
		t6._untrackPart(t2, p1)
	end)
end
function t6.UntrackModel(p1) --[[ UntrackModel | Line: 277 | Upvalues: Asserts (copy), t (copy), t6 (copy), t2 (copy), t3 (copy) ]]
	Asserts.Model(p1)

	local v3 = assert(t[p1], (("Tracked camera-occlusion model %* is not tracked"):format(p1.Name)))

	t6._restoreModel(v3)

	for k in pairs(v3.Parts) do
		t2[k] = nil
	end

	v3.Trove:Destroy()
	table.clear(v3.Parts)
	t[p1] = nil
	t3[p1] = nil
end
function t6.SetModelSuppressed(p1, p2) --[[ SetModelSuppressed | Line: 291 | Upvalues: Asserts (copy), t (copy), t6 (copy), t3 (copy) ]]
	Asserts.Model(p1)
	Asserts.boolean(p2)

	local v3 = assert(t[p1], (("Tracked camera-occlusion model %* is not tracked"):format(p1.Name)))

	if v3.Suppressed == p2 then
		return
	end

	v3.Suppressed = p2

	if not p2 then
		return
	end

	t6._restoreModel(v3)
	t3[p1] = nil
end
function t6.SetSessionActive(p1) --[[ SetSessionActive | Line: 306 | Upvalues: Asserts (copy), v4 (ref), v3 (ref), t6 (copy), v2 (copy), RenderStepped (copy), v1 (copy) ]]
	Asserts.boolean(p1)

	if p1 then
		if v4 then
			return
		end

		assert(v3 == nil, "Inactive model camera occlusion scheduler must not exist")
		v4 = true
		v3 = RenderStepped(t6._step, nil, nil, nil, v1)
		v2:AtDebug():Log("Started model camera occlusion")
	else
		local v22 = v4

		v4 = false

		local v32 = v3

		v3 = nil

		if v32 ~= nil then
			v32:Destroy()
		end

		t6._restoreAll()

		if not v22 then
			return
		end

		v2:AtDebug():Log("Stopped model camera occlusion")
	end
end

return t6