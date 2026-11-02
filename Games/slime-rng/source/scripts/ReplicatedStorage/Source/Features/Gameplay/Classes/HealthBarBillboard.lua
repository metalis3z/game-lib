-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: HealthBarBillboard, time of decompilation: Sun May  3 10:11:20 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HealthBarBillboardGui = ReplicatedStorage.Assets.Misc.HealthBarBillboardGui
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local t1 = {}

t1.__index = t1

local function getGradientTransparency(n1: number) -- line: 33
	if n1 <= 0 then
		return NumberSequence.new(1)
	end

	if n1 >= 1 then
		return NumberSequence.new(0)
	end

	local v10 = math.clamp(n1, 0, 1)
	local v11 = math.max(v10 - 0.001, 0)

	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(v11, 0),
		NumberSequenceKeypoint.new(v10, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
end
local function applyVisuals(p1) -- line: 60
	-- upvalues: SettingsState (copy), Abbreviate (copy), getGradientTransparency (copy)
	if not SettingsState.get("showHealthbars") then
		p1.gui.Enabled = false

		return
	end

	local v15 = math.max(p1.displayMaxHealth, 0)
	local v16 = math.clamp(p1.displayHealth, 0, v15)
	local v17 = not (v15 > 0) and 0 or v16 / v15
	local v18 = p1.targetMaxHealth > 0 and p1.targetHealth >= p1.targetMaxHealth
	local v19 = v15 <= 0 or v17 >= 0.999

	p1.gui.Enabled = not (v18 and v19)
	p1.hpLabel.Text = Abbreviate((math.ceil(v16))) .. "/" .. Abbreviate((math.ceil(v15)))
	p1.barGradient.Transparency = getGradientTransparency(v17)
end

function t1.new(p2) -- line: 77
	-- upvalues: HealthBarBillboardGui (copy), t1 (copy)
	local clone = HealthBarBillboardGui:Clone()
	local v22 = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart", true)

	if v22 then
		clone.Adornee = v22
	end

	clone.Enabled = false
	clone.Parent = p2

	return (setmetatable({
		targetHealth = 0,
		targetMaxHealth = 0,
		displayHealth = 0,
		displayMaxHealth = 0,
		shakeTime = 0,
		shakeMagnitude = 0,
		gui = clone,
		barGradient = clone.Bar.UIGradient,
		hpLabel = clone.Hp,
		baseStudsOffset = clone.StudsOffsetWorldSpace
	}, t1))
end
function t1.setHealth(p3, n2: number, n3: number) -- line: 102
	-- upvalues: applyVisuals (copy)
	local v26 = math.max(n3, 0)
	local v27 = math.clamp(n2, 0, v26)
	local v28 = p3.targetMaxHealth <= 0 and p3.displayMaxHealth <= 0
	local targetHealth = p3.targetHealth
	local v30 = math.max(p3.targetMaxHealth, v26, 1)
	local v31 = math.max(targetHealth - v27, 0)

	if v31 > 0 then
		local v32 = math.clamp(v31 / v30, 0, 1)

		p3.shakeTime = 0.3
		p3.shakeMagnitude = math.max(p3.shakeMagnitude, v32 * 1.1)
	end

	p3.targetHealth = v27
	p3.targetMaxHealth = v26

	if v28 then
		p3.displayHealth = v27
		p3.displayMaxHealth = v26
	elseif p3.displayMaxHealth <= 0 then
		p3.displayMaxHealth = v26
	elseif p3.displayHealth <= 0 and v26 <= v27 then
		p3.displayHealth = v27
	end

	applyVisuals(p3)
end
function t1.update(p4, n4: number) -- line: 129
	-- upvalues: applyVisuals (copy)
	local v35 = if not (n4 <= 0) then 1 - math.exp(n4 * -14) else 0

	p4.displayHealth = p4.displayHealth + (p4.targetHealth - p4.displayHealth) * v35
	p4.displayMaxHealth = p4.displayMaxHealth + (p4.targetMaxHealth - p4.displayMaxHealth) * v35

	if math.abs(p4.displayHealth - p4.targetHealth) <= 0.01 then
		p4.displayHealth = p4.targetHealth
	end

	if math.abs(p4.displayMaxHealth - p4.targetMaxHealth) <= 0.01 then
		p4.displayMaxHealth = p4.targetMaxHealth
	end

	if p4.shakeTime > 0 then
		p4.shakeTime = math.max(p4.shakeTime - n4, 0)

		local v36 = 1 - p4.shakeTime / 0.3
		local v37 = 1 - v36
		local v38 = v36 * 3.141592653589793 * 10
		local v39 = math.sin(v38) * p4.shakeMagnitude * v37
		local v40 = math.cos(v38 * 1.35) * p4.shakeMagnitude * 0.45 * v37

		p4.gui.StudsOffsetWorldSpace = p4.baseStudsOffset + Vector3.new(v39, v40, 0)

		if p4.shakeTime <= 0 then
			p4.shakeMagnitude = 0
		end
	else
		p4.gui.StudsOffsetWorldSpace = p4.baseStudsOffset
	end

	applyVisuals(p4)
end
function t1.isVisible(p5) -- line: 158
	return p5.gui.Enabled
end
function t1.destroy(p6) -- line: 162
	p6.gui:Destroy()
end

return t1
