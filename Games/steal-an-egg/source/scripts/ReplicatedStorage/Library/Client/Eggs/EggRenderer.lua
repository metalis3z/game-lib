-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local Assets = require(ReplicatedStorage.Directory.Assets)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local EggScaleUtil = require(ReplicatedStorage.Library.Util.EggScaleUtil)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)

require(script.Parent.Types)

local Eggs2 = ReplicatedStorage.Assets.Models.Eggs
local t = {}

local function exceedsPlacedCollisionBounds(p1) --[[ exceedsPlacedCollisionBounds | Line: 34 ]]
	return if p1.X > 20 or p1.Y > 20 then true else p1.Z > 20
end

function t.GetTemplate(p1) --[[ GetTemplate | Line: 44 | Upvalues: Eggs (copy), Eggs2 (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local v2 = Eggs2[p1.AssetCategory]
	local v3 = v2:IsA("Model")

	assert(v3, (("Egg model %* must be a Model"):format(p1.AssetCategory)))

	return v2
end
function t.DisableCollisions(p1) --[[ DisableCollisions | Line: 52 | Upvalues: Asserts (copy) ]]
	Asserts.Model(p1)

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.CanCollide = false
		end
	end
end
function t.ApplyPlacedCollisionPolicy(p1) --[[ ApplyPlacedCollisionPolicy | Line: 62 | Upvalues: Asserts (copy), BBFromModelVisibleOnly (copy) ]]
	Asserts.Model(p1)

	local _, v1 = BBFromModelVisibleOnly(p1)
	local v2 = p1.PrimaryPart and p1.PrimaryPart.Size or v1
	local v4 = not (if v2.X > 20 or v2.Y > 20 then true else v2.Z > 20)

	for v5, v6 in p1:GetDescendants() do
		if v6:IsA("BasePart") then
			v6.CanCollide = if v4 then if v6.Transparency < 1 then true else false else v4
		end
	end
end
function t.RenderVisual(p1, p2, p3) --[[ RenderVisual | Line: 75 | Upvalues: Asserts (copy), Eggs (copy), Assets (copy), t (copy), EggScaleUtil (copy), AssetColorUtil (copy), BBFromModelVisibleOnly (copy) ]]
	Asserts.Instance(p2)
	Asserts.number(p1.OwnerUserId)
	Asserts.string(p1.UID)
	Asserts.string(p1.ModelName)
	assert(Eggs.SchemaValidation.SavedEgg(p1.Record), "Invalid saved egg record")

	local v2 = Assets.Directory[p1.Record.AssetCategory]

	assert(if v2 == nil then false else true, (("Missing asset config for category %*"):format(p1.Record.AssetCategory)))

	local v5 = t.GetTemplate(p1.Record):Clone()

	v5.Name = p1.ModelName

	local v6 = v5:GetScale()
	local v7 = if p1.ScaleMultiplier then EggScaleUtil.ClampRenderedScale(v6, p1.ScaleMultiplier) else EggScaleUtil.GetPreGrowthVisualScale(v6, p1.Record.AssetScale)

	v5:ScaleTo(EggScaleUtil.ClampRenderedScale(v6, v7 * math.clamp(p1.ScaleAlpha or 1, 0.5, 1)))
	AssetColorUtil.Apply(v5, p1.Record.AssetCategory, p1.Record.AssetEyeColor, p1.Record.AssetColorSeed, p1.Record.AssetColorIndex)

	local PrimaryPart = v5.PrimaryPart

	Asserts.BasePart(PrimaryPart)

	local v10, v11 = BBFromModelVisibleOnly(v5)

	PrimaryPart.PivotOffset = CFrame.new(0, v10.Position.Y - v11.Y * 0.5 - PrimaryPart.CFrame.Position.Y, 0)

	for v13, v14 in v5:GetDescendants() do
		if v14:IsA("BasePart") then
			v14.CanCollide = false
			v14.CanQuery = if v14.Transparency == 1 then false else true
			v14.CanTouch = false
			v14.Massless = true
			v14.Anchored = not p2:IsA("Tool") and (if v14 == PrimaryPart then true else false)
		end
	end

	if p3 then
		t.ApplyPlacedCollisionPolicy(v5)
	end

	v5.Parent = p2

	return {
		Model = v5,
		VisibleParts = { PrimaryPart },
		Config = v2.Egg
	}
end
function t.GetAuthoredScale(p1) --[[ GetAuthoredScale | Line: 142 | Upvalues: Eggs (copy), t (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")

	local v2 = t.GetTemplate(p1):GetScale()

	assert(v2 > 0, (("Egg model %* scale must be greater than 0"):format(p1.AssetCategory)))

	return v2
end
function t.GetVisibleBounds(p1) --[[ GetVisibleBounds | Line: 152 | Upvalues: Eggs (copy), Assets (copy), t (copy), BBFromModelVisibleOnly (copy) ]]
	assert(Eggs.SchemaValidation.SavedEgg(p1), "Invalid saved egg record")
	assert(Assets.Directory[p1.AssetCategory] ~= nil, (("Missing asset config for category %*"):format(p1.AssetCategory)))

	local v4 = t.GetTemplate(p1)
	local v5 = t.GetAuthoredScale(p1)
	local _, v6 = BBFromModelVisibleOnly(v4)

	return v6 / v5
end

return t