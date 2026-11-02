-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local CameraShaker = require(ReplicatedStorage.Library.Modules.Packages.CameraShaker)
local EmitDescendants = require(ReplicatedStorage.Library.Functions.EmitDescendants)
local LightningBolt = require(script.Parent.LightningBolt)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)

require(script.Types.Interface)

local v1 = Color3.fromRGB(43, 117, 255)
local v2 = Log.new()
local v3 = CameraShaker.new()
local t = {}

local function createAttachment(p1) --[[ createAttachment | Line: 37 | Upvalues: Workspace (copy), Debris (copy) ]]
	local Attachment = Instance.new("Attachment")

	Attachment.WorldPosition = p1
	Attachment.Parent = Workspace.Terrain
	Debris:AddItem(Attachment, 1)

	return Attachment
end

local function createBolt(p1, p2, p3) --[[ createBolt | Line: 45 | Upvalues: Workspace (copy), Debris (copy), LightningBolt (copy), v1 (copy) ]]
	local Attachment = Instance.new("Attachment")

	Attachment.WorldPosition = p1 + Vector3.new(0, 400, 0) + p3
	Attachment.Parent = Workspace.Terrain
	Debris:AddItem(Attachment, 1)

	local Attachment2 = Instance.new("Attachment")

	Attachment2.WorldPosition = p1
	Attachment2.Parent = Workspace.Terrain
	Debris:AddItem(Attachment2, 1)

	local v12 = LightningBolt.new(Attachment, Attachment2, 30)

	v12.Thickness = p2.BoltThickness
	v12.Color = p2.BoltColor or v1
	v12.Frequency = 30
	v12.MinThicknessMultiplier = 0.6
	v12.MaxThicknessMultiplier = 2.5
	task.delay(0.7, function() --[[ Line: 54 | Upvalues: v12 (copy) ]]
		v12:DestroyDissipate(0.7)
	end)
end

local function createImpact(p1, p2) --[[ createImpact | Line: 59 | Upvalues: ReplicatedStorage (copy), Workspace (copy), EmitDescendants (copy), Debris (copy), TweenService (copy), Lighting (copy) ]]
	local Assets = ReplicatedStorage.Assets

	assert(Assets:IsA("Folder"), "ReplicatedStorage.Assets must be a Folder")

	local VFX = Assets.VFX

	assert(VFX:IsA("Folder"), "ReplicatedStorage.Assets.VFX must be a Folder")

	local LightningStrike = VFX.LightningStrike

	assert(LightningStrike:IsA("Folder"), "ReplicatedStorage.Assets.VFX.LightningStrike must be a Folder")

	local fx = LightningStrike.fx

	assert(fx:IsA("BasePart"), "LightningStrike.fx must be a BasePart")

	local v5 = fx:Clone()

	v5.CFrame = p1
	v5.Parent = Workspace.__DEBRIS
	EmitDescendants(v5)
	Debris:AddItem(v5, 2)

	local PointLight = Instance.new("PointLight")

	PointLight.Color = Color3.fromRGB(82, 122, 255)
	PointLight.Range = p2.ImpactLightRange
	PointLight.Brightness = p2.ImpactLightBrightness
	PointLight.Parent = v5
	TweenService:Create(PointLight, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Brightness = 0,
		Range = 0
	}):Play()
	Debris:AddItem(PointLight, 0.35)

	local LightningStrikeBlackout = script.LightningStrikeBlackout

	assert(LightningStrikeBlackout:IsA("ColorCorrectionEffect"), "LightningStrikeBlackout must be a ColorCorrectionEffect")

	local v7 = LightningStrikeBlackout:Clone()

	v7.Parent = Lighting
	Debris:AddItem(v7, p2.FlashDuration)
end

function t.Play(p1, p2) --[[ Play | Line: 96 | Upvalues: Asserts (copy), createBolt (copy), createImpact (copy), Audio (copy), v3 (copy), v2 (copy) ]]
	Asserts.CFrame(p1)
	createBolt(p1.Position, p2, Vector3.new(0, 0, 0))

	if p2.SecondaryBolt then
		createBolt(p1.Position, p2, Vector3.new(11, 0, -9))
	end

	task.delay(0.65, function() --[[ Line: 102 | Upvalues: createImpact (ref), p1 (copy), p2 (copy), Audio (ref), v3 (ref), v2 (ref) ]]
		createImpact(p1, p2)
		Audio.Play(128966102518500, p1, 1, 0.8, 350)
		Audio.Play(107651969389508, script, 1, 0.3)
		v3:ShakeOnce(p2.CameraShakeMagnitude, 10, 0, 0.75)
		v2:AtDebug():Log("Lightning strike impact played")
	end)
end
v3:Start()

return table.freeze(t)