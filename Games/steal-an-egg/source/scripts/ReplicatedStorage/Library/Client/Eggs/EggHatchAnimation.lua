-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Audio = require(ReplicatedStorage.Library.Audio)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local Bezier = require(ReplicatedStorage.Library.Functions.Bezier)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local EmitDescendants = require(ReplicatedStorage.Library.Functions.EmitDescendants)

require(ReplicatedStorage.Library.Types.AssetItem)

local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local Player = require(ReplicatedStorage.Library.Player)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Transparency = require(ReplicatedStorage.Library.Functions.Transparency)
local CollisionGroups = require(ReplicatedStorage.Library.Types.CollisionGroups)
local v1 = Color3.fromRGB(248, 248, 248)
local Assets2 = ReplicatedStorage.Assets
local __DEBRIS = Workspace.__DEBRIS
local PlacedEggOpen = Assets2.Particles["Egg Open"].PlacedEggOpen
local EggExplode = PlacedEggOpen.EggExplode
local Trail = PlacedEggOpen.Trail
local EggPoof = Assets2.EggPoof

assert(__DEBRIS:IsA("Folder"), "Workspace.__DEBRIS must be a Folder")
assert(EggExplode:IsA("Model"), "PlacedEggOpen.EggExplode must be a Model")
assert(Trail:IsA("Trail"), "PlacedEggOpen.Trail must be a Trail")
assert(EggPoof:IsA("BasePart"), "Assets.EggPoof must be a BasePart")

for v6, v7 in EggExplode:GetDescendants() do
	if v7:IsA("BasePart") then
		v7.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
	end
end

local t = {}

local function buildAssetItemData(p1, p2) --[[ buildAssetItemData | Line: 88 ]]
	local t = {
		HasBeenFirstPlaced = false,
		Category = p1.AssetCategory
	}

	t.Scale = if p2 then p2 else p1.AssetScale
	t.EyeColor = p1.AssetEyeColor
	t.ColorSeed = p1.AssetColorSeed
	t.ColorIndex = p1.AssetColorIndex
	t.Mutations = p1.Mutations or {}
	t.BaseMutation = p1.BaseMutation

	return t
end

local function playPoofSound() --[[ playPoofSound | Line: 101 | Upvalues: Audio (copy) ]]
	Audio.Play("rbxassetid://114382853652995", script, nil, 0.5)
end

local function playAssetRevealSound(p1, p2) --[[ playAssetRevealSound | Line: 105 | Upvalues: Assets (copy), Audio (copy) ]]
	local RandomIdleSound = Assets.Directory[p1.AssetCategory].RandomIdleSound

	if RandomIdleSound == nil then
		return nil
	end

	return Audio.PlayFromSoundFile(RandomIdleSound, p2)
end

local function autoControlPoint(p1, p2) --[[ autoControlPoint | Line: 114 ]]
	local v1 = (p1 + p2) / 2

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v1.Z)
end

local function getPlayerBodyPosition(p1, p2) --[[ getPlayerBodyPosition | Line: 122 | Upvalues: Player (copy) ]]
	local v1 = Player.Optional.PrimaryPart(p1)

	if v1 then
		return v1:GetPivot().Position
	end

	return p2
end

local function getBottomCFrameFacingPlayer(p1, p2, p3) --[[ getBottomCFrameFacingPlayer | Line: 127 | Upvalues: Players (copy), Player (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 == nil then
		return CFrame.new(p2) * p3
	end

	local v2 = Player.Optional.PrimaryPart(v1)
	local v3 = if v2 then v2:GetPivot().Position else p2
	local v4 = Vector3.new(v3.X, p2.Y, v3.Z)

	if (p2 - v4).Magnitude < 0.001 then
		return CFrame.new(p2) * p3
	end

	return CFrame.lookAt(p2, v4)
end

local function shakeEggPass(p1, p2, p3) --[[ shakeEggPass | Line: 146 | Upvalues: RunService (copy), EggActionMovement (copy) ]]
	local sum = 0

	while sum < 0.5 do
		sum = sum + RunService.Heartbeat:Wait()
		EggActionMovement.SetPivot(p1, p2 * CFrame.Angles(0, 0, (math.rad((1 - sum / 0.5) * math.sin(tick() * 90) * p3))))
	end
end

local function shakeEgg(p1, p2) --[[ shakeEgg | Line: 155 | Upvalues: shakeEggPass (copy) ]]
	shakeEggPass(p1, p2, 7)
	task.wait(0.3)
	shakeEggPass(p1, p2, 9)
	task.wait(0.3)
	shakeEggPass(p1, p2, 13)
end

local function pivotAssetToEggBottom(p1, p2) --[[ pivotAssetToEggBottom | Line: 163 | Upvalues: BBFromModelVisibleOnly (copy) ]]
	local v1 = p1:GetPivot()
	local v2, v3 = BBFromModelVisibleOnly(p1)

	p1:PivotTo(CFrame.new(p2.Position - (v2.Position - Vector3.new(0, 1, 0) * (v3.Y * 0.5) - v1.Position)) * (p2 - p2.Position))
end

local function growAsset(p1, p2, p3) --[[ growAsset | Line: 174 | Upvalues: RenderStepped (copy), Easing (copy), pivotAssetToEggBottom (copy) ]]
	local v1 = p3 * 0.5

	RenderStepped(function(p12, p22) --[[ Line: 176 | Upvalues: p1 (copy), Easing (ref), v1 (copy), p3 (copy), pivotAssetToEggBottom (ref), p2 (copy) ]]
		if p1.Parent == nil then
			return true
		end

		p1:ScaleTo(v1 + (p3 - v1) * Easing(p22, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out))
		pivotAssetToEggBottom(p1, p2)
	end, 1.3, true):Wait()

	if p1.Parent == nil then
		return
	end

	p1:ScaleTo(p3)
	pivotAssetToEggBottom(p1, p2)
end

local function lookAtPlayer(p1, p2) --[[ lookAtPlayer | Line: 194 | Upvalues: RenderStepped (copy), Player (copy), Easing (copy) ]]
	local v1 = p1:GetPivot()

	RenderStepped(function(p13, p2) --[[ Line: 196 | Upvalues: p1 (copy), v1 (copy), p2 (copy), Player (ref), Easing (ref) ]]
		if p1.Parent == nil then
			return true
		end

		local v3 = v1 + Vector3.new(0, math.sin(6.283185307179586 * p2 * 0.5) * 1, 0)
		local v5 = Player.Optional.PrimaryPart(p2)
		local v6 = if v5 then v5:GetPivot().Position else v1.Position
		local v7 = Vector3.new(v6.X, v3.Y, v6.Z)

		p1:PivotTo(v3:Lerp(if (v3.Position - v7).Magnitude < 0.001 then v3 else CFrame.lookAt(v3.Position, v7), (Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))))
	end, 3, true):Wait()
end

local function flyAssetIntoPlayer(p1, p2) --[[ flyAssetIntoPlayer | Line: 215 | Upvalues: Transparency (copy), RenderStepped (copy), Player (copy), Bezier (copy), Easing (copy) ]]
	local v1 = p1:GetScale()
	local v2 = p1:GetPivot()
	local v3 = Transparency()

	task.spawn(function() --[[ Line: 221 | Upvalues: RenderStepped (ref), p1 (copy), p2 (copy), v2 (copy), Player (ref), Bezier (ref), Easing (ref), v3 (copy), v1 (copy) ]]
		RenderStepped(function(p12, p22) --[[ Line: 222 | Upvalues: p1 (ref), p2 (ref), v2 (ref), Player (ref), Bezier (ref), Easing (ref), v3 (ref), v1 (ref) ]]
			if p1.Parent == nil then
				return true
			end

			local v22 = Player.Optional.PrimaryPart(p2)
			local v32 = if v22 then v22:GetPivot().Position else v2.Position
			local Position3 = v2.Position
			local v5 = (Position3 + v32) / 2
			local v8 = CFrame.new(Bezier(v2.Position, Vector3.new(v5.X, math.max(Position3.Y, v32.Y) + ((Position3 - v32) * Vector3.new(1, 0, 1)).Magnitude * 0.5, v5.Z), v32)(p22)) * v2.Rotation
			local v9 = Vector3.new(v32.X, v8.Y, v32.Z)
			local v10 = if (v8.Position - v9).Magnitude < 0.001 then v8 else CFrame.lookAt(v8.Position, v9)
			local v11 = Easing(math.clamp((p22 - 0.6) / 0.4, 0, 1), Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

			v3(p1, 1, v11)
			p1:ScaleTo((math.max(0.001, v1 * (1 - v11))))
			p1:PivotTo(v10)
		end, 0.7, true):Wait()

		if p1.Parent == nil then
			return
		end

		v3(p1, 1, 1)
		p1:ScaleTo(0.001)
		p1:Destroy()
	end)
	task.wait(0.3)
end

local function playAssetClaimSequence(p1, p2) --[[ playAssetClaimSequence | Line: 253 | Upvalues: Players (copy), RenderStepped (copy), Player (copy), Easing (copy), flyAssetIntoPlayer (copy) ]]
	local v1 = Players:GetPlayerByUserId(p1)

	if v1 == nil then
		p2:Destroy()
	else
		local v2 = p2:GetPivot()

		RenderStepped(function(p13, p2) --[[ Line: 196 | Upvalues: p2 (copy), v2 (copy), v1 (copy), Player (ref), Easing (ref) ]]
			if p2.Parent == nil then
				return true
			end

			local v3 = v2 + Vector3.new(0, math.sin(6.283185307179586 * p2 * 0.5) * 1, 0)
			local v5 = Player.Optional.PrimaryPart(v1)
			local v6 = if v5 then v5:GetPivot().Position else v2.Position
			local v7 = Vector3.new(v6.X, v3.Y, v6.Z)

			p2:PivotTo(v3:Lerp(if (v3.Position - v7).Magnitude < 0.001 then v3 else CFrame.lookAt(v3.Position, v7), (Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))))
		end, 3, true):Wait()
		flyAssetIntoPlayer(p2, v1)
	end
end

local function revealAsset(p1, p2, p3, p4) --[[ revealAsset | Line: 264 | Upvalues: ItemDisplay (copy), buildAssetItemData (copy), __DEBRIS (copy), Asserts (copy), BBFromModelVisibleOnly (copy), pivotAssetToEggBottom (copy), growAsset (copy), TweenService (copy) ]]
	local v1 = ItemDisplay.CreateActiveModel(p2, buildAssetItemData(p3, 1), true, true)

	v1.Name = ("%*_%*"):format(p1, p2)
	v1.Parent = __DEBRIS

	local PrimaryPart = v1.PrimaryPart

	Asserts.BasePart(PrimaryPart)
	PrimaryPart.Anchored = true

	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.FillTransparency = 0
	Highlight.OutlineTransparency = 1
	Highlight.Adornee = v1
	Highlight.Parent = v1
	v1:ScaleTo(p3.AssetScale * 0.5)

	local v2, v3 = BBFromModelVisibleOnly(v1)

	PrimaryPart.PivotOffset = CFrame.new(0, v2.Position.Y - v3.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)
	pivotAssetToEggBottom(v1, p4)
	task.spawn(function() --[[ Line: 285 | Upvalues: growAsset (ref), v1 (copy), p4 (copy), p3 (copy) ]]
		growAsset(v1, p4, p3.AssetScale)
	end)

	for i, v in ipairs(v1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.CanQuery = false
		end
	end

	TweenService:Create(Highlight, TweenInfo.new(0.5), {
		FillTransparency = 1
	}):Play()

	return v1
end

function t.Play(p1, p2, p3, p4) --[[ Play | Line: 307 | Upvalues: Asserts (copy), Eggs (copy), EggRenderer (copy), EggExplode (copy), __DEBRIS (copy), Debris (copy), ReplicatedStorage (copy), BBFromModelVisibleOnly (copy), getBottomCFrameFacingPlayer (copy), shakeEgg (copy), v1 (copy), revealAsset (copy), Assets (copy), Audio (copy), Trail (copy), TweenService (copy), EmitDescendants (copy), EggPoof (copy), Players (copy), RenderStepped (copy), Player (copy), Easing (copy), flyAssetIntoPlayer (copy) ]]
	Asserts.number(p1)
	Asserts.string(p2)
	assert(Eggs.SchemaValidation.SavedEgg(p3), "Invalid saved egg record")
	Asserts.Model(p4)
	EggRenderer.DisableCollisions(p4)

	local v2 = EggExplode:Clone()

	v2:ScaleTo(p4:GetScale() / 3)
	v2:PivotTo(p4:GetPivot())

	local Core = v2.Core

	assert(Core:IsA("BasePart"), "Egg explosion Core must be a BasePart")
	Core.Parent = __DEBRIS
	Debris:AddItem(Core, 60)
	v2.Parent = ReplicatedStorage
	task.wait(0.4)

	local v4 = p4:GetPivot()
	local v5, v6 = BBFromModelVisibleOnly(p4)
	local v7 = getBottomCFrameFacingPlayer(p1, v5.Position - Vector3.new(0, 1, 0) * (v6.Y * 0.5) + Vector3.new(0, 0.2, 0), v4 - v4.Position)

	shakeEgg(p4, v4)

	local sum = 0
	local sum2 = 0
	local sum3 = 0
	local count = 0
	local v8 = 0

	for i, v in ipairs(p4:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency < 1 then
			local Color = v.Color

			sum = sum + Color.R
			sum2 = sum2 + Color.G
			sum3 = sum3 + Color.B
			count = count + 1

			if v.Transparency > 0.3 then
				v8 = v.Transparency
			end
		end
	end

	local v9 = if count > 0 then Color3.new(sum / count, sum2 / count, sum3 / count) else v1
	local PrimaryPart = p4.PrimaryPart

	Asserts.BasePart(PrimaryPart)

	local t = {
		Color = v9,
		Material = PrimaryPart.Material,
		MaterialVariant = PrimaryPart.MaterialVariant,
		Transparency = PrimaryPart.Transparency
	}

	p4:Destroy()
	v2.Parent = __DEBRIS

	for i, v in ipairs(v2:GetDescendants()) do
		if v ~= Core and (v.Name ~= "RootPart" and v:IsA("BasePart")) then
			v.Anchored = false
		end
	end

	local v10 = revealAsset(p1, p2, p3, v7)
	local RandomIdleSound = Assets.Directory[p3.AssetCategory].RandomIdleSound
	local v11 = if RandomIdleSound == nil then nil else Audio.PlayFromSoundFile(RandomIdleSound, v7)

	for i, v in ipairs(v2:GetChildren()) do
		if not v:IsA("BasePart") then
			assert(v:IsA("Model"), (("Explosion child %* must be a Model"):format((v:GetFullName()))))

			local PrimaryPart2 = v.PrimaryPart

			Asserts.BasePart(PrimaryPart2)

			local v15, v16 = v:GetBoundingBox()
			local Part = Instance.new("Part")

			Part.Transparency = 1
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.CFrame = v15
			Part.Size = v16

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Part
			WeldConstraint.Part1 = PrimaryPart2
			WeldConstraint.Parent = Part
			Part.Parent = v

			local Attachment = Instance.new("Attachment")
			local Attachment2 = Instance.new("Attachment")

			Attachment.Parent = Part
			Attachment2.Parent = Part
			Attachment.Position = Vector3.new(0, v16.Y / 2, 0)
			Attachment2.Position = Vector3.new(0, -v16.Y / 2, 0)

			local v19 = Trail:Clone()

			v19.Attachment0 = Attachment
			v19.Attachment1 = Attachment2
			v19.Color = ColorSequence.new(t.Color)
			v19.Parent = Attachment
			v19.Enabled = true
		end
	end

	Audio.Play("rbxassetid://114382853652995", script, nil, 0.5)

	for i, v in ipairs(v2:GetDescendants()) do
		if v ~= Core and (v.Name ~= "RootPart" and v:IsA("BasePart")) then
			local v20 = CFrame.new(Core.Position, v.Position).LookVector * 16 + Vector3.new(0, 24, 0)

			v.Transparency = v8
			v.Color = v9
			v.Material = t.Material
			v.MaterialVariant = t.MaterialVariant
			v:ApplyImpulse(v20 * v.AssemblyMass)
		end
	end

	task.delay(3, function() --[[ Line: 428 | Upvalues: v2 (copy), TweenService (ref), Debris (ref) ]]
		for i, v in ipairs(v2:GetChildren()) do
			for i2, v3 in ipairs(v:GetDescendants()) do
				if v3:IsA("BasePart") then
					TweenService:Create(v3, TweenInfo.new(1), {
						Transparency = 1
					}):Play()
				end
			end
		end

		Debris:AddItem(v2, 1)
	end)

	local Attachment = Core.Attachment

	assert(Attachment:IsA("Attachment"), "Egg explosion core Attachment must be an Attachment")

	for i, v in ipairs(Attachment:GetDescendants()) do
		if v:IsA("ParticleEmitter") and v.Name == "ColorMe" then
			v.Color = ColorSequence.new(t.Color)
		end
	end

	EmitDescendants(Attachment)

	local Rare = Core.Rare

	assert(Rare:IsA("Attachment"), "Egg explosion core Rare must be an Attachment")

	for i, v in ipairs(Rare:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Color = ColorSequence.new(t.Color)
		end
	end

	EmitDescendants(Rare)

	local v23 = EggPoof:Clone()

	v23.CFrame = v4
	v23.Parent = __DEBRIS
	EmitDescendants(v23)
	Debris:AddItem(v23, 6)

	local v24 = Players:GetPlayerByUserId(p1)

	if v24 == nil then
		v10:Destroy()
	else
		local v25 = v10:GetPivot()

		RenderStepped(function(p13, p2) --[[ Line: 196 | Upvalues: v10 (copy), v25 (copy), v24 (copy), Player (ref), Easing (ref) ]]
			if v10.Parent == nil then
				return true
			end

			local v3 = v25 + Vector3.new(0, math.sin(6.283185307179586 * p2 * 0.5) * 1, 0)
			local v5 = Player.Optional.PrimaryPart(v24)
			local v6 = if v5 then v5:GetPivot().Position else v25.Position
			local v7 = Vector3.new(v6.X, v3.Y, v6.Z)

			v10:PivotTo(v3:Lerp(if (v3.Position - v7).Magnitude < 0.001 then v3 else CFrame.lookAt(v3.Position, v7), (Easing(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))))
		end, 3, true):Wait()
		flyAssetIntoPlayer(v10, v24)
	end

	return v11
end
function t.FadeSoundWhenGrantedToolUnequips(p1, p2) --[[ FadeSoundWhenGrantedToolUnequips | Line: 468 | Upvalues: Asserts (copy), Players (copy), Audio (copy) ]]
	Asserts.Sound(p1)
	Asserts.string(p2)

	if not p1:IsDescendantOf(game) then
		return
	end

	local LocalPlayer = Players.LocalPlayer
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = false

	local function disconnectLifecycle() --[[ disconnectLifecycle | Line: 482 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref) ]]
		if v1 ~= nil then
			v1:Disconnect()
			v1 = nil
		end

		if v2 ~= nil then
			v2:Disconnect()
			v2 = nil
		end

		if v3 ~= nil then
			v3:Disconnect()
			v3 = nil
		end

		if v4 == nil then
			return
		end

		v4:Disconnect()
		v4 = nil
	end

	local function fadeAndStop() --[[ fadeAndStop | Line: 501 | Upvalues: disconnectLifecycle (copy), p1 (copy), Audio (ref) ]]
		disconnectLifecycle()

		if p1:IsDescendantOf(game) then
			Audio.Fade(p1, 0, 0.35).Completed:Once(function() --[[ Line: 508 | Upvalues: p1 (ref) ]]
				if not p1:IsDescendantOf(game) then
					return
				end

				p1:Stop()
			end)
		end
	end

	local function tryBindTool(p1) --[[ tryBindTool | Line: 515 | Upvalues: v5 (ref), p2 (copy), v1 (ref), v4 (ref), fadeAndStop (copy) ]]
		if v5 or (not p1:IsA("Tool") or p1:GetAttribute("UID") ~= p2) then
			return
		end

		v5 = true

		if v1 == nil then
			v4 = p1.Unequipped:Once(fadeAndStop)

			return
		end

		v1:Disconnect()
		v1 = nil
		v4 = p1.Unequipped:Once(fadeAndStop)
	end

	v2 = p1.Ended:Once(disconnectLifecycle)
	v3 = p1.Stopped:Once(disconnectLifecycle)
	v1 = LocalPlayer.DescendantAdded:Connect(tryBindTool)

	for v6, v7 in LocalPlayer:GetDescendants() do
		tryBindTool(v7)

		if v5 then
			break
		end
	end
end

return t