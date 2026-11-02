-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMachineVisualsClient, time of decompilation: Sun May  3 10:12:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local SlimeInfoBillboard = require(ReplicatedStorage.Source.Features.Gameplay.Classes.SlimeInfoBillboard)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local VfxUtils = require(ReplicatedStorage.Source.Core.Platform.VfxUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local cFrame = CFrame.Angles(0, 3.141592653589793, 0)
local t1 = {}

t1.__index = t1

local function configureDisplayModel(p1) -- line: 175
	for _, v45 in p1:GetDescendants() do
		if v45:IsA("BasePart") then
			v45.Anchored = true
			v45.CanCollide = false
			v45.CanQuery = false
			v45.CanTouch = false
		end
	end
end
local function createDisplaySlime(p2, p3, cFrame2: CFrame) -- line: 186
	-- upvalues: Slimes (copy), Mutations (copy), InventoryServiceUtils (copy), configureDisplayModel (copy), VfxUtils (copy), SlimeInfoBillboard (copy)
	local clone = Slimes.getModel(p2.id):Clone()
	local v50 = Mutations.getSizeScale(p2.mutations)
	local v51 = Slimes.getSlime(p2.id)
	local v52 = Mutations.getDisplayName(v51.name, p2.mutations)
	local v53 = InventoryServiceUtils.getVisualOdds({
		level = 1,
		xp = 0,
		id = p2.id,
		mutations = p2.mutations
	})

	configureDisplayModel(clone)
	Slimes.applyMutationVisuals(clone, p2.id, p2.mutations)

	if Mutations.has(p2.mutations, "shiny") and clone.PrimaryPart ~= nil then
		VfxUtils.getVfx("ShinyParticles").Parent = clone.PrimaryPart
	end

	local v54 = SlimeInfoBillboard.new(clone, v52, v53, v50)

	clone:ScaleTo((math.max(v50 * 0.01, 0.001)))
	clone.Parent = p3
	v54:setVisible(true)

	return {
		model = clone,
		baseRotation = clone:GetPivot().Rotation * cFrame2,
		infoBillboard = v54,
		targetScale = v50
	}
end
local function getArcCFrame(cFrame3: CFrame, cFrame4: CFrame, n1: number, n2: number) -- line: 231
	local v60 = cFrame3:Lerp(cFrame4, n1)
	local v61 = cFrame3.Position:Lerp(cFrame4.Position, n1) + Vector3.new(0, math.sin(n1 * 3.141592653589793) * n2, 0)

	return CFrame.new(v61) * v60.Rotation
end
local function runTimedAnimation(n3: number, p4: ((...any) -> ...any), p5: ((...any) -> ...any)) -- line: 238
	-- upvalues: RunService (copy)
	p5(0)

	if n3 <= 0 then
		p5(1)

		return not p4()
	end

	local n4 = 0

	while n4 < n3 do
		if p4() then
			return false
		end

		n4 += RunService.Heartbeat:Wait()
		p5((math.clamp(n4 / n3, 0, 1)))
	end

	return not p4()
end
local function waitDuration(n5: number, p6: ((...any) -> ...any)) -- line: 258
	-- upvalues: RunService (copy)
	if n5 <= 0 then
		return not p6()
	end

	local n6 = 0

	while n6 < n5 do
		if p6() then
			return false
		end

		n6 += RunService.Heartbeat:Wait()
	end

	return not p6()
end

function t1.new(p7) -- line: 275
	-- upvalues: Sounds (copy), SoundController (copy), t1 (copy)
	local Dropper = p7:FindFirstChild("Dropper", true)
	local v71 = if Dropper ~= nil then if not Dropper:IsA("BasePart") then if not Dropper:IsA("Model") then nil else Dropper.PrimaryPart or Dropper:FindFirstChildWhichIsA("BasePart", true) else Dropper else nil
	local Middle = p7:FindFirstChild("Middle", true)
	local v73 = if Middle == nil or not Middle:IsA("Model") then nil else Middle
	local v74 = if not p7:IsA("BasePart") then if not p7:IsA("Model") then p7:FindFirstChildWhichIsA("BasePart", true) else p7.PrimaryPart or p7:FindFirstChildWhichIsA("BasePart", true) else p7
	local t2 = {
		processing = false,
		destroyed = false,
		dropperPulseId = 0,
		middlePulseId = 0,
		machine = p7
	}
	local Dropper2 = p7:FindFirstChild("Dropper", true)

	t2.dropperCFrame = ((if Dropper2 ~= nil then (if not Dropper2:IsA("Attachment") then (if not Dropper2:IsA("BasePart") then (if not Dropper2:IsA("Model") then nil else Dropper2:GetPivot()) else Dropper2.CFrame) else Dropper2.WorldCFrame) else nil)) or if p7 ~= nil then if not p7:IsA("Attachment") then if not p7:IsA("BasePart") then if not p7:IsA("Model") then nil else p7:GetPivot() else p7.CFrame else p7.WorldCFrame else nil
	t2.dropperInstance = Dropper
	t2.dropperPart = v71
	t2.rootPart = v74

	local v77 = v71 or v74
	local plop = Sounds.misc.plop
	local v79

	if v77 == nil or v77.Parent == nil then
		v79 = nil
	else
		v79 = Instance.new("Sound")
		SoundController:ApplySoundInfo(v79, plop)
		v79.RollOffMode = Enum.RollOffMode.InverseTapered
		v79.RollOffMinDistance = 20
		v79.RollOffMaxDistance = 70
		v79.Parent = v77
	end

	t2.plopSound = v79

	local v80 = v71 or v74
	local machineConsume = Sounds.misc.machineConsume
	local v82

	if v80 == nil or v80.Parent == nil then
		v82 = nil
	else
		v82 = Instance.new("Sound")
		SoundController:ApplySoundInfo(v82, machineConsume)
		v82.RollOffMode = Enum.RollOffMode.InverseTapered
		v82.RollOffMinDistance = 20
		v82.RollOffMaxDistance = 70
		v82.Parent = v80
	end

	t2.machineConsumeSound = v82

	local v83 = v74 or v71
	local ding = Sounds.misc.ding
	local v85

	if v83 == nil or v83.Parent == nil then
		v85 = nil
	else
		v85 = Instance.new("Sound")
		SoundController:ApplySoundInfo(v85, ding)
		v85.RollOffMode = Enum.RollOffMode.InverseTapered
		v85.RollOffMinDistance = 20
		v85.RollOffMaxDistance = 70
		v85.Parent = v83
	end

	t2.dingSound = v85
	t2.dropperBaseSize = if v71 == nil then nil else v71.Size

	local AttachmentPoints = p7:FindFirstChild("AttachmentPoints", true)
	local v87

	if AttachmentPoints == nil then
		v87 = nil
	else
		local ConveyorStart = AttachmentPoints:FindFirstChild("ConveyorStart", true)

		v87 = if ConveyorStart ~= nil then if not ConveyorStart:IsA("Attachment") then if not ConveyorStart:IsA("BasePart") then if not ConveyorStart:IsA("Model") then nil else ConveyorStart:GetPivot() else ConveyorStart.CFrame else ConveyorStart.WorldCFrame else nil
	end

	t2.conveyorStartCFrame = v87

	local AttachmentPoints2 = p7:FindFirstChild("AttachmentPoints", true)
	local v90

	if AttachmentPoints2 == nil then
		v90 = nil
	else
		local Mid = AttachmentPoints2:FindFirstChild("Mid", true)

		v90 = if Mid ~= nil then if not Mid:IsA("Attachment") then if not Mid:IsA("BasePart") then if not Mid:IsA("Model") then nil else Mid:GetPivot() else Mid.CFrame else Mid.WorldCFrame else nil
	end

	t2.midCFrame = v90

	local AttachmentPoints3 = p7:FindFirstChild("AttachmentPoints", true)
	local v93

	if AttachmentPoints3 == nil then
		v93 = nil
	else
		local Final = AttachmentPoints3:FindFirstChild("Final", true)

		v93 = if Final ~= nil then if not Final:IsA("Attachment") then if not Final:IsA("BasePart") then if not Final:IsA("Model") then nil else Final:GetPivot() else Final.CFrame else Final.WorldCFrame else nil
	end

	t2.finalCFrame = v93
	t2.middleModel = v73
	t2.middleBaseScale = if v73 == nil then nil else v73:GetScale()
	t2.queue = {}

	local v95 = setmetatable(t2, t1)

	v95.isConfigured = v95.dropperCFrame ~= nil and (v95.conveyorStartCFrame ~= nil and (v95.midCFrame ~= nil and v95.finalCFrame ~= nil))

	if not v95.isConfigured then
		warn("Crafting machine is missing required animation points:", p7:GetFullName())
	end

	return v95
end
function t1.shouldStop(p8) -- line: 313
	return p8.destroyed or p8.machine.Parent == nil
end
function t1.pulseDropper(p9) -- line: 317
	-- upvalues: runTimedAnimation (copy)
	if p9.dropperPart == nil or p9.dropperBaseSize == nil then
		return
	end

	local plopSound = p9.plopSound

	if plopSound ~= nil and plopSound.Parent ~= nil then
		plopSound:Play()
	end

	p9.dropperPulseId = p9.dropperPulseId + 1

	local dropperPulseId = p9.dropperPulseId
	local dropperPart = p9.dropperPart
	local dropperBaseSize = p9.dropperBaseSize
	local v102 = 0.23 + math.random() * 0.11000000000000001

	task.spawn(function() -- line: 330
		-- upvalues: runTimedAnimation (copy), p9 (copy), dropperPulseId (copy), dropperPart (copy), dropperBaseSize (copy), v102 (copy)
		runTimedAnimation(0.6, function() -- line: 331
			-- upvalues: p9 (copy), dropperPulseId (copy), dropperPart (copy)
			return p9:shouldStop() or (dropperPulseId ~= p9.dropperPulseId or dropperPart.Parent == nil)
		end, function(n7: number) -- line: 333
			-- upvalues: dropperPart (copy), dropperBaseSize (copy), v102 (copy)
			local v167 = dropperPart
			local v168 = dropperBaseSize
			local v169 = v102
			local v170 = math.exp(n7 * -4.8)
			local v171 = math.sin(n7 * 3.141592653589793 * 2.6)

			v167.Size = v168 * (v169 * v170 * v171 + 1)
		end)

		if dropperPulseId == p9.dropperPulseId and dropperPart.Parent ~= nil then
			dropperPart.Size = dropperBaseSize
		end
	end)
end
function t1.pulseMiddle(p10) -- line: 343
	-- upvalues: runTimedAnimation (copy)
	if p10.middleModel == nil or p10.middleBaseScale == nil then
		return
	end

	local machineConsumeSound = p10.machineConsumeSound

	if machineConsumeSound ~= nil and machineConsumeSound.Parent ~= nil then
		machineConsumeSound:Play()
	end

	p10.middlePulseId = p10.middlePulseId + 1

	local middlePulseId = p10.middlePulseId
	local middleModel = p10.middleModel
	local middleBaseScale = p10.middleBaseScale
	local v108 = 0.08 + math.random() * 0.08

	task.spawn(function() -- line: 356
		-- upvalues: runTimedAnimation (copy), p10 (copy), middlePulseId (copy), middleModel (copy), middleBaseScale (copy), v108 (copy)
		runTimedAnimation(0.6, function() -- line: 357
			-- upvalues: p10 (copy), middlePulseId (copy), middleModel (copy)
			return p10:shouldStop() or (middlePulseId ~= p10.middlePulseId or middleModel.Parent == nil)
		end, function(n8: number) -- line: 359
			-- upvalues: middleModel (copy), middleBaseScale (copy), v108 (copy)
			local v173 = middleModel
			local v174 = middleBaseScale
			local v175 = v108
			local v176 = math.exp(n8 * -4.8)
			local v177 = math.sin(n8 * 3.141592653589793 * 2.6)

			v173:ScaleTo(v174 * (v175 * v176 * v177 + 1))
		end)

		if middlePulseId == p10.middlePulseId and middleModel.Parent ~= nil then
			middleModel:ScaleTo(middleBaseScale)
		end
	end)
end
function t1.applyDisplayTransform(p11, t3: {[any]: any}, cFrame5: CFrame, n9: number, n10: number?) -- line: 369
	if p11:shouldStop() then
		return
	end

	local v114 = math.max(t3.targetScale * math.max(n9, 0.01), 0.001)

	t3.model:ScaleTo(v114)
	t3.model:PivotTo(cFrame5 * CFrame.Angles(0, n10 or 0, 0) * t3.baseRotation)
end
function t1.playInputSequence(p12, p13) -- line: 385
	-- upvalues: createDisplaySlime (copy), cFrame (copy), runTimedAnimation (copy), getArcCFrame (copy)
	local v117 = createDisplaySlime(p13, workspace, cFrame)
	local v118 = false
	local u119 = false

	local function stopCheck() -- line: 393
		-- upvalues: p12 (copy)
		return p12:shouldStop()
	end

	if not runTimedAnimation(0.84, stopCheck, function(n11: number) -- line: 397
		-- upvalues: u119 (ref), p12 (copy), getArcCFrame (copy), v117 (copy)
		if not u119 and n11 > 0 then
			u119 = true
			p12:pulseDropper()
		end

		local v146 = if not (n11 < 0.5) then 1 - math.pow(n11 * -2 + 2, 2) / 2 else n11 * 2 * n11
		local v147 = math.clamp(n11 / 0.78, 0, 1)
		local v148 = math.clamp((n11 - 0.68) / 0.32, 0, 1)
		local v149 = math.max(v147 * 0.99 + 0.01 + math.sin(v148 * 3.141592653589793) * 0.12, 0.01)
		local v150 = getArcCFrame(p12.dropperCFrame, p12.conveyorStartCFrame, v146, 1.6)

		p12:applyDisplayTransform(v117, v150, v149)
	end) then
		if v117 ~= nil then
			if v117.infoBillboard ~= nil then
				v117.infoBillboard:destroy()
			end

			if v117.model.Parent ~= nil then
				v117.model:Destroy()
			end
		end

		return false
	end

	if not runTimedAnimation(0.84, stopCheck, function(n12: number) -- line: 418
		-- upvalues: getArcCFrame (copy), p12 (copy), v117 (copy)
		local v152 = if not (n12 < 0.5) then 1 - math.pow(n12 * -2 + 2, 2) / 2 else n12 * 2 * n12
		local v153 = getArcCFrame(p12.conveyorStartCFrame, p12.midCFrame, v152, 0.6)

		p12:applyDisplayTransform(v117, v153, 1)
	end) then
		if v117 ~= nil then
			if v117.infoBillboard ~= nil then
				v117.infoBillboard:destroy()
			end

			if v117.model.Parent ~= nil then
				v117.model:Destroy()
			end
		end

		return false
	end

	p12:pulseMiddle()

	if runTimedAnimation(0.24, stopCheck, function(n13: number) -- line: 431
		-- upvalues: p12 (copy), v117 (copy)
		p12:applyDisplayTransform(v117, p12.midCFrame, 1 - n13)
	end) then
		v118 = true
	end

	if v117 ~= nil then
		if v117.infoBillboard ~= nil then
			v117.infoBillboard:destroy()
		end

		if v117.model.Parent ~= nil then
			v117.model:Destroy()
		end
	end

	return v118
end
function t1.playOutputSequence(p14, p15) -- line: 442
	-- upvalues: createDisplaySlime (copy), runTimedAnimation (copy), getArcCFrame (copy)
	local v123 = createDisplaySlime(p15, workspace, CFrame.identity)
	local n14 = 0

	local function stopCheck() -- line: 449
		-- upvalues: p14 (copy)
		return p14:shouldStop()
	end

	local dingSound = p14.dingSound

	if dingSound ~= nil and dingSound.Parent ~= nil then
		dingSound:Play()
	end

	if not runTimedAnimation(1, stopCheck, function(n15: number) -- line: 455
		-- upvalues: n14 (ref), getArcCFrame (copy), p14 (copy), v123 (copy)
		local v156 = if not (n15 < 0.5) then 1 - math.pow(n15 * -2 + 2, 2) / 2 else n15 * 2 * n15

		n14 = v156 * 3.839724354387525

		local v157 = math.pow(n15 - 1, 3) * 2.70158 + 1 + math.pow(n15 - 1, 2) * 1.70158
		local v158 = getArcCFrame(p14.midCFrame, p14.finalCFrame, v156, 0.85)

		p14:applyDisplayTransform(v123, v158, v157, n14)
	end) then
		if v123 ~= nil then
			if v123.infoBillboard ~= nil then
				v123.infoBillboard:destroy()
			end

			if v123.model.Parent ~= nil then
				v123.model:Destroy()
			end
		end

		return false
	end

	if not runTimedAnimation(0.84, stopCheck, function(n16: number) -- line: 468
		-- upvalues: p14 (copy), v123 (copy), n14 (ref)
		local vector3 = Vector3.new(0, math.sin(n16 * 3.141592653589793) * 1.15, 0)
		local v161 = p14.finalCFrame + vector3

		p14:applyDisplayTransform(v123, v161, 1, n14 + ((if not (n16 < 0.5) then 1 - math.pow(n16 * -2 + 2, 2) / 2 else n16 * 2 * n16)) * 6.283185307179586)
	end) then
		if v123 ~= nil then
			if v123.infoBillboard ~= nil then
				v123.infoBillboard:destroy()
			end

			if v123.model.Parent ~= nil then
				v123.model:Destroy()
			end
		end

		return false
	end

	local v127 = runTimedAnimation(0.32, stopCheck, function(n17: number) -- line: 483
		-- upvalues: p14 (copy), v123 (copy), n14 (ref)
		local vector3 = Vector3.new(0, n17 * 0.8, 0)

		p14:applyDisplayTransform(v123, p14.finalCFrame + vector3, 1 - n17, n14 + 6.283185307179586)
	end)

	if v123 ~= nil then
		if v123.infoBillboard ~= nil then
			v123.infoBillboard:destroy()
		end

		if v123.model.Parent ~= nil then
			v123.model:Destroy()
		end
	end

	return v127
end
function t1.playInputSequences(p16, t4: {[any]: any}) -- line: 497
	-- upvalues: waitDuration (copy), RunService (copy)
	if #t4 == 0 then
		return true
	end

	local n18 = 0
	local v131 = #t4
	local u132 = false

	for v133, v134 in t4 do
		task.spawn(function() -- line: 512
			-- upvalues: v133 (copy), waitDuration (copy), p16 (copy), u132 (ref), n18 (ref), v134 (copy)
			local v164 = (v133 - 1) * 0.576

			if not waitDuration(v164, function() -- line: 514
				-- upvalues: p16 (copy), u132 (ref)
				return p16:shouldStop() or u132
			end) then
				n18 += 1

				return
			end

			if not p16:playInputSequence(v134) then
				u132 = true
			end

			n18 += 1
		end)
	end

	while v131 > n18 do
		if p16:shouldStop() or u132 then
			return false
		end

		RunService.Heartbeat:Wait()
	end

	return true
end
function t1.playSequence(p17, t5: {[any]: any}) -- line: 540
	if not p17:playInputSequences(t5.inputs) then
		if t5.onCompleted ~= nil then
			t5.onCompleted(false)
		end

		return
	end

	local v137 = p17:playOutputSequence(t5.output)

	if t5.onCompleted ~= nil then
		t5.onCompleted(v137)
	end
end
function t1.processQueue(p18) -- line: 554
	if p18.processing then
		return
	end

	p18.processing = true
	task.spawn(function() -- line: 560
		-- upvalues: p18 (copy)
		while not p18:shouldStop() and #p18.queue > 0 do
			local v165 = table.remove(p18.queue, 1)

			p18:playSequence(v165)
		end

		p18.processing = false

		if not p18:shouldStop() and #p18.queue > 0 then
			p18:processQueue()
		end
	end)
end
function t1.enqueueCraft(p19, t6: {[any]: any}, p20, p21: ((...any) -> ...any)?) -- line: 573
	if p19.destroyed or not p19.isConfigured then
		if p21 ~= nil then
			p21(false)
		end

		return
	end

	local t7 = {
		inputs = t6,
		output = p20,
		onCompleted = p21
	}

	task.spawn(function() -- line: 591
		-- upvalues: p19 (copy), p21 (copy), t7 (copy)
		if p19:shouldStop() then
			if p21 ~= nil then
				p21(false)
			end

			return
		end

		p19:playSequence(t7)
	end)
end
function t1.destroy(p22) -- line: 603
	p22.destroyed = true
	table.clear(p22.queue)

	if p22.plopSound ~= nil then
		p22.plopSound:Destroy()
	end

	if p22.machineConsumeSound ~= nil then
		p22.machineConsumeSound:Destroy()
	end

	if p22.dingSound ~= nil then
		p22.dingSound:Destroy()
	end
end

return t1
