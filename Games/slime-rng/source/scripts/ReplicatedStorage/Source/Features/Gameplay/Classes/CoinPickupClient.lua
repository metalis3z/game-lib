-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CoinPickupClient, time of decompilation: Sun May  3 10:11:19 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)

require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)

local TopBarHudState = require(ReplicatedStorage.Source.Features.Hud.TopBarHudState)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local t1 = {}

t1.__index = t1

local t2 = {
	coins = {
		vfxName = "CoinPickup",
		startDelay = 0,
		lateralOffset = 0,
		popHeight = 6,
		arcHeight = 9,
		icon = ImageIds.coin,
		collectSound = Sounds.misc.coins
	},
	goop = {
		vfxName = "GoopPickup",
		startDelay = 0.14,
		lateralOffset = 7,
		popHeight = 7.5,
		arcHeight = 12,
		icon = ImageIds.goop,
		collectSound = Sounds.misc.goopPickup
	}
}

local function getTargetPosition() -- line: 97
	-- upvalues: Players (copy)
	local Character = Players.LocalPlayer.Character

	if not Character then
		return nil
	end

	local v22 = Character:FindFirstChild("HumanoidRootPart") or (Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Head"))

	if not v22 or not v22:IsA("BasePart") then
		return nil
	end

	return v22.Position + Vector3.new(0, 2.5, 0)
end
local function configureTemplate(p1, p2, n1: number) -- line: 167
	-- upvalues: Abbreviate (copy), t2 (copy)
	local BillboardGui = p1:FindFirstChildWhichIsA("BillboardGui", true)

	if BillboardGui then
		local Amount = BillboardGui:FindFirstChild("Amount", true)
		local v49 = Abbreviate((math.round(n1)))

		Amount.DropShadow.Text = v49
		Amount.TextLabel.Text = v49

		local v50 = BillboardGui:FindFirstChild("CoinIcon", true) or BillboardGui:FindFirstChild("Icon", true)

		if v50 and v50:IsA("ImageLabel") then
			v50.ScaleType = Enum.ScaleType.Fit

			local v51 = t2[p2]

			assert(v51 ~= nil, string.format("Unsupported currency pickup path '%s'", (tostring(p2))))
			v50.Image = v51.icon
		end
	end

	local Trail = p1:FindFirstChild("Trail")
	local v53 = if not Trail or not Trail:IsA("Trail") then p1:FindFirstChildWhichIsA("Trail", true) else Trail

	if v53 then
		v53.Enabled = true
		v53:Clear()
	end
end

function t1.collectImmediately(p3, n2: number) -- line: 189
	-- upvalues: t2 (copy), TopBarHudState (copy), SettingsState (copy), SoundController (copy)
	local v56 = t2[p3]

	assert(v56 ~= nil, string.format("Unsupported currency pickup path '%s'", (tostring(p3))))
	TopBarHudState.notifyCurrencyCollected(p3, n2)

	if SettingsState.get("coinGoopCollectionSounds") then
		SoundController:Play(v56.collectSound)
	end
end
function t1.new(p4, n3: number, vector3: Vector3, p5) -- line: 197
	-- upvalues: getTargetPosition (copy), t2 (copy), VfxUtils (copy), configureTemplate (copy), t1 (copy)
	local v61 = getTargetPosition() or vector3 + Vector3.new(0, 10, 0)
	local v62 = t2[p4]

	assert(v62 ~= nil, string.format("Unsupported currency pickup path '%s'", (tostring(p4))))

	local v63 = math.clamp(0.45 + (v61 - vector3).Magnitude * 0.005, 0.45, 0.8)
	local v64 = VfxUtils.getVfx(v62.vfxName, p5)

	assert(v64:IsA("Part"), string.format("VFX '%s' must be a Part", v62.vfxName))
	v64.CFrame = CFrame.new(vector3)
	configureTemplate(v64, p4, n3)

	local BillboardGui = v64:FindFirstChildWhichIsA("BillboardGui", true)
	local Size = v64.Size
	local v67 = if not BillboardGui then nil else BillboardGui.Size

	v64.Size = Size * 0.01

	if BillboardGui and v67 then
		BillboardGui.Size = UDim2.new(v67.X.Scale * 0.01, v67.X.Offset * 0.01, v67.Y.Scale * 0.01, v67.Y.Offset * 0.01)
	end

	local v68 = (math.sin(vector3.X * 12.9898 + vector3.Z * 78.233 + n3 * 0.37) * 0.5 + 0.5) * 3.141592653589793 * 2

	return (setmetatable({
		elapsed = 0,
		progress = 0,
		collected = false,
		currencyPath = p4,
		amount = n3,
		part = v64,
		billboard = BillboardGui,
		startPos = vector3,
		basePartSize = Size,
		baseBillboardSize = v67,
		floatPhase = v68,
		startDelay = v62.startDelay,
		lateralOffset = v62.lateralOffset,
		popHeight = v62.popHeight,
		arcHeight = v62.arcHeight,
		duration = v63
	}, t1))
end
function t1.update(p6, n4: number) -- line: 241
	-- upvalues: getTargetPosition (copy), t1 (copy)
	if p6.collected then
		return true
	end

	p6.elapsed = p6.elapsed + n4

	if p6.elapsed < p6.startDelay then
		local part = p6.part
		local basePartSize = p6.basePartSize
		local billboard = p6.billboard
		local baseBillboardSize = p6.baseBillboardSize

		part.Size = basePartSize * 0.01

		if billboard and baseBillboardSize then
			billboard.Size = UDim2.new(baseBillboardSize.X.Scale * 0.01, baseBillboardSize.X.Offset * 0.01, baseBillboardSize.Y.Scale * 0.01, baseBillboardSize.Y.Offset * 0.01)
		end

		p6.part.CFrame = CFrame.new(p6.startPos)

		return false
	end

	local v75 = p6.elapsed - p6.startDelay

	if v75 < 0.45 then
		local v76 = math.min(v75 / 0.24, 1)
		local v77 = math.min(v75 / 0.45, 1)
		local floatPhase = p6.floatPhase
		local v79 = math.sin(v75 * 12 + floatPhase) * 0.45
		local v80 = math.cos(v75 * 10 + floatPhase * 0.7) * 0.45 * 0.65
		local v81 = Vector3.new(v79, math.sin(v75 * 16 + floatPhase * 1.3) * 0.45, v80) * if not (v77 < 0.5) then 1 - math.pow(v77 * -2 + 2, 3) / 2 else v77 * 4 * v77 * v77
		local part = p6.part
		local basePartSize = p6.basePartSize
		local billboard = p6.billboard
		local baseBillboardSize = p6.baseBillboardSize
		local v86 = math.clamp(v76, 0, 1)
		local v88

		if v86 < 0.72 then
			local v87 = v86 / 0.72

			v88 = ((if not (v87 < 0.5) then 1 - math.pow(v87 * -2 + 2, 3) / 2 else v87 * 4 * v87 * v87)) * 1.6
		else
			local v89 = (v86 - 0.72) / 0.28

			v88 = ((if not (v89 < 0.5) then 1 - math.pow(v89 * -2 + 2, 3) / 2 else v89 * 4 * v89 * v89)) * -0.6000000000000001 + 1.6
		end

		local v90 = math.max(v88, 0.01)

		part.Size = basePartSize * v90

		if billboard and baseBillboardSize then
			billboard.Size = UDim2.new(baseBillboardSize.X.Scale * v90, baseBillboardSize.X.Offset * v90, baseBillboardSize.Y.Scale * v90, baseBillboardSize.Y.Offset * v90)
		end

		p6.part.CFrame = CFrame.new(p6.startPos + v81)

		return false
	end

	local part = p6.part
	local basePartSize = p6.basePartSize
	local billboard = p6.billboard
	local baseBillboardSize = p6.baseBillboardSize

	part.Size = basePartSize * 1

	if billboard and baseBillboardSize then
		billboard.Size = UDim2.new(baseBillboardSize.X.Scale * 1, baseBillboardSize.X.Offset * 1, baseBillboardSize.Y.Scale * 1, baseBillboardSize.Y.Offset * 1)
	end

	p6.progress = math.min((v75 - 0.45) / p6.duration, 1)

	local v95 = getTargetPosition() or p6.startPos + Vector3.new(0, 10, 0)
	local startPos = p6.startPos
	local floatPhase = p6.floatPhase
	local v98 = math.sin(floatPhase + 5.4) * 0.45
	local v99 = math.cos(floatPhase * 0.7 + 4.5) * 0.45 * 0.65
	local v100 = startPos + Vector3.new(v98, math.sin(floatPhase * 1.3 + 7.2) * 0.45, v99)
	local vector3 = Vector3.new(v95.X - v100.X, 0, v95.Z - v100.Z)
	local v102 = if not (vector3.Magnitude > 0.001) then Vector3.new(0, 0, 1) else vector3.Unit
	local v103 = Vector3.new(-v102.Z, 0, v102.X) * p6.lateralOffset
	local v104 = v100 + Vector3.new(0, p6.popHeight, 0) + v103 * 0.35
	local v105 = (v100 + v95) / 2 + Vector3.new(0, p6.arcHeight, 0) + v103
	local progress = p6.progress
	local v107 = if not (progress < 0.5) then 1 - math.pow(progress * -2 + 2, 3) / 2 else progress * 4 * progress * progress
	local v108 = 1 - v107
	local v109 = v100 * v108 * v108 * v108 + v104 * 3 * v108 * v108 * v107 + v105 * 3 * v108 * v107 * v107 + v95 * v107 * v107 * v107

	p6.part.CFrame = CFrame.new(v109)

	if p6.progress >= 1 then
		p6.collected = true
		t1.collectImmediately(p6.currencyPath, p6.amount)

		return true
	end

	return false
end
function t1.destroy(p7) -- line: 288
	-- upvalues: VfxUtils (copy), t2 (copy)
	local part = p7.part
	local Trail = part:FindFirstChild("Trail")
	local v113 = if not Trail or not Trail:IsA("Trail") then part:FindFirstChildWhichIsA("Trail", true) else Trail

	if v113 then
		v113.Enabled = false
		v113:Clear()
	end

	local part2 = p7.part
	local basePartSize = p7.basePartSize
	local billboard = p7.billboard
	local baseBillboardSize = p7.baseBillboardSize

	part2.Size = basePartSize * 1

	if billboard and baseBillboardSize then
		billboard.Size = UDim2.new(baseBillboardSize.X.Scale * 1, baseBillboardSize.X.Offset * 1, baseBillboardSize.Y.Scale * 1, baseBillboardSize.Y.Offset * 1)
	end

	local cacheVfx = VfxUtils.cacheVfx
	local currencyPath = p7.currencyPath
	local v120 = t2[currencyPath]

	assert(v120 ~= nil, string.format("Unsupported currency pickup path '%s'", (tostring(currencyPath))))
	cacheVfx(v120.vfxName, p7.part)
end

return t1
