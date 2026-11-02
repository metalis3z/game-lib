-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local TutorialBeam = ReplicatedStorage.Assets.Extra.TutorialBeam
local LocalPlayer = Players.LocalPlayer
local t = {}

local function createTargetAttachment(p1, p2) --[[ createTargetAttachment | Line: 38 ]]
	local TutorialBeamTargetAttachment = Instance.new("Attachment")

	TutorialBeamTargetAttachment.Name = "TutorialBeamTargetAttachment"

	if typeof(p1) == "Instance" and p1:IsA("BasePart") then
		TutorialBeamTargetAttachment.Parent = p1

		return TutorialBeamTargetAttachment, nil
	end

	local TutorialBeamContainer = Instance.new("Part")

	TutorialBeamContainer.Name = "TutorialBeamContainer"
	TutorialBeamContainer.Anchored = true
	TutorialBeamContainer.CanCollide = false
	TutorialBeamContainer.Transparency = 1
	TutorialBeamContainer.Size = Vector3.new(1, 1, 1)
	TutorialBeamContainer.Position = p1
	TutorialBeamContainer.Parent = workspace
	p2:Add(TutorialBeamContainer)
	TutorialBeamTargetAttachment.Parent = TutorialBeamContainer

	return TutorialBeamTargetAttachment, TutorialBeamContainer
end

local function attachToPlayer(p1) --[[ attachToPlayer | Line: 60 ]]
	local Character = p1._player.Character

	if not Character then
		p1._beam.Enabled = false

		return
	end

	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 5)

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		p1._beam.Enabled = false

		return
	end

	if p1._playerAttachment then
		p1._trove:Remove(p1._playerAttachment)
	end

	local TutorialBeamPlayerAttachment = Instance.new("Attachment")

	TutorialBeamPlayerAttachment.Name = "TutorialBeamPlayerAttachment"
	TutorialBeamPlayerAttachment.Parent = HumanoidRootPart
	p1._playerAttachment = TutorialBeamPlayerAttachment
	p1._trove:Add(TutorialBeamPlayerAttachment)
	p1._beam.Attachment0 = TutorialBeamPlayerAttachment
	p1._beam.Enabled = true
end

function t.Create(p1, p2) --[[ Create | Line: 88 | Upvalues: Trove (copy), TutorialBeam (copy), createTargetAttachment (copy), Workspace (copy), LocalPlayer (copy), attachToPlayer (copy) ]]
	assert(if typeof(p1) == "Vector3" then true elseif typeof(p1) == "Instance" then p1:IsA("BasePart") else false, "target must be BasePart or Vector3")

	local v2 = Trove.new()
	local v3 = if p2 and p2.Template then p2.Template else TutorialBeam
	local v4 = if p2 and p2.Name then p2.Name else "TutorialBeam"
	local v5, v6 = createTargetAttachment(p1, v2)

	v2:Add(v5)

	local v7 = v3:Clone()

	v7.Name = v4
	v7.Attachment1 = v5
	v7.FaceCamera = true
	v7.Enabled = false
	v7.Parent = Workspace
	v2:Add(v7)

	local t = {
		_playerAttachment = nil,
		_trove = v2,
		_beam = v7,
		_targetAttachment = v5,
		_targetContainer = v6,
		_player = LocalPlayer
	}

	attachToPlayer(t)
	v2:Connect(LocalPlayer.CharacterAdded, function(p1) --[[ Line: 120 | Upvalues: attachToPlayer (ref), t (copy) ]]
		task.spawn(function() --[[ Line: 121 | Upvalues: p1 (copy), attachToPlayer (ref), t (ref) ]]
			if not p1:WaitForChild("HumanoidRootPart", 5) then
				return
			end

			attachToPlayer(t)
		end)
	end)

	return t
end
function t.UpdateTarget(p1, p2) --[[ UpdateTarget | Line: 132 | Upvalues: Asserts (copy), createTargetAttachment (copy) ]]
	Asserts.table(p1)
	assert(if typeof(p2) == "Vector3" then true elseif typeof(p2) == "Instance" then p2:IsA("BasePart") else false, "newTarget must be BasePart or Vector3")

	if typeof(p2) == "Vector3" and p1._targetContainer ~= nil then
		p1._targetContainer.Position = p2

		return
	end

	if p2 == p1._targetAttachment.Parent then
		return
	end

	p1._trove:Remove(p1._targetAttachment)

	if p1._targetContainer ~= nil then
		p1._trove:Remove(p1._targetContainer)
	end

	local v2, v3 = createTargetAttachment(p2, p1._trove)

	p1._trove:Add(v2)
	p1._targetAttachment = v2
	p1._targetContainer = v3
	p1._beam.Attachment1 = v2
end
function t.Destroy(p1) --[[ Destroy | Line: 160 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	p1._trove:Destroy()
end

return t