--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local t = {
	Intensity = 0.7,
	Duration = 0.5
}
local t2 = {
	Intensity = 0.8,
	Duration = 0.5
}
local t3 = {
	Intensity = 1.2,
	Duration = 0.75,
	Shake = 0.6
}
local t4 = {
	Intensity = 1.2,
	Duration = 0.75,
	Shake = 1
}
local t5 = { t, t }
local t6 = {
	Chance = 0.1,
	PreDelayMin = 0.5,
	PreDelayMax = 1.5,
	PostDelay = 0.5,
	Spec = t,
	FollowUpSpec = t
}
local v1 = Random.new()
local t7 = {}
local SpiralTrail = require(game.ReplicatedStorage.ClientModules.SpiralTrail)
local Assets = ReplicatedStorage:WaitForChild("Assets")

local function GetGrowEffectsTemplate() --[[ GetGrowEffectsTemplate | Line: 99 | Upvalues: Assets (copy) ]]
	local EggEffects = Assets:FindFirstChild("EggEffects")

	if EggEffects then
		return EggEffects:FindFirstChild("GrowEffects")
	end

	return nil
end

local function DebugPopVFX(p1) --[[ DebugPopVFX | Line: 104 ]] end

local function GetInstancePath(p1) --[[ GetInstancePath | Line: 110 ]]
	local t = { p1.Name }
	local v1 = p1.Parent

	while v1 and v1 ~= game do
		table.insert(t, 1, v1.Name)
		v1 = v1.Parent
	end

	return table.concat(t, "/")
end

local function DescribeChildren(p1) --[[ DescribeChildren | Line: 120 ]]
	local t = {}

	for v1, v2 in p1:GetChildren() do
		table.insert(t, (("%*(%*)"):format(v2.Name, v2.ClassName)))
	end

	if #t == 0 then
		return "(no children)"
	end

	return table.concat(t, ", ")
end

local function StopWobble(p1) --[[ StopWobble | Line: 133 | Upvalues: t7 (copy) ]]
	local v1 = t7[p1]

	if not v1 then
		return
	end

	v1.Connection:Disconnect()

	if p1.Parent then
		p1:PivotTo(v1.StartPivot)
	end

	t7[p1] = nil
end

local function Wobble(p1, p2, p3, p4) --[[ Wobble | Line: 144 | Upvalues: t7 (copy), v1 (copy), RunService (copy) ]]
	local v12 = t7[p1]

	if v12 then
		v12.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v12.StartPivot)
		end

		t7[p1] = nil
	end

	local v2 = p2 or 1
	local v3 = p3 or 0.5
	local v4 = p4 or 0
	local v5, v6 = p1:GetBoundingBox()

	p1.WorldPivot = v5 * CFrame.new(0, -v6.Y / 2, 0)

	local v7 = p1:GetPivot()
	local v8 = os.clock()
	local v9 = v1:NextNumber(0, 6.283185307179586)
	local v10 = if v1:NextInteger(0, 1) == 0 then 1 else -1
	local v11 = nil

	v11 = RunService.Heartbeat:Connect(function() --[[ Line: 159 | Upvalues: p1 (copy), v11 (ref), t7 (ref), v8 (copy), v3 (ref), v2 (ref), v10 (copy), v1 (ref), v4 (ref), v7 (copy), v9 (copy) ]]
		if p1.Parent then
			local v12 = os.clock() - v8
			local v32 = math.clamp(v12 / v3, 0, 1)
			local v42 = 1 - v32
			local v5 = math.sin(v12 * 25) * 0.2617993877991494 * v2 * v42 * v10

			p1:PivotTo(v7 * CFrame.new(v1:NextNumber(-1, 1) * v4 * v2 * v42, 0, v1:NextNumber(-1, 1) * v4 * v2 * v42) * CFrame.Angles(0, v9, 0) * CFrame.Angles(0, 0, v5) * CFrame.Angles(0, -v9, 0))

			if not (v32 >= 1) then
				return
			end

			p1:PivotTo(v7)
		end

		v11:Disconnect()
		t7[p1] = nil
	end)
	t7[p1] = {
		Connection = v11,
		StartPivot = v7
	}
end

local function ScaleUp(p1, p2, p3, p4) --[[ ScaleUp | Line: 188 | Upvalues: t7 (copy), RunService (copy), TweenService (copy) ]]
	local v1 = t7[p1]

	if v1 then
		v1.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v1.StartPivot)
		end

		t7[p1] = nil
	end

	local v3 = p4 or Enum.EasingStyle.Exponential
	local v4, v5 = p1:GetBoundingBox()
	local v6 = v4.Position.Y - v5.Y / 2
	local v7 = p1:GetScale()
	local v8 = os.clock()
	local v9 = nil

	v9 = RunService.Heartbeat:Connect(function() --[[ Line: 197 | Upvalues: p1 (copy), v9 (ref), v8 (copy), p3 (copy), TweenService (ref), v3 (ref), v7 (copy), p2 (copy), v6 (copy) ]]
		if p1.Parent then
			local v2 = math.clamp((os.clock() - v8) / p3, 0, 1)

			p1:ScaleTo(v7 + (p2 - v7) * TweenService:GetValue(v2, v3, Enum.EasingDirection.Out))

			local v32, v4 = p1:GetBoundingBox()

			p1:PivotTo(p1:GetPivot() + Vector3.new(0, v6 - (v32.Position.Y - v4.Y / 2), 0))

			if not (v2 >= 1) then
				return
			end
		end

		v9:Disconnect()
	end)
end

local function ScaleUpInstant(p1, p2) --[[ ScaleUpInstant | Line: 216 | Upvalues: t7 (copy) ]]
	local v1 = t7[p1]

	if v1 then
		v1.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v1.StartPivot)
		end

		t7[p1] = nil
	end

	local v2, v3 = p1:GetBoundingBox()

	p1:ScaleTo(p2)

	local v5, v6 = p1:GetBoundingBox()

	p1:PivotTo(p1:GetPivot() + Vector3.new(0, v2.Position.Y - v3.Y / 2 - (v5.Position.Y - v6.Y / 2), 0))
end

local function PopupFadeEffect(p1, p2, p3) --[[ PopupFadeEffect | Line: 228 | Upvalues: ScaleUp (copy), TweenService (copy), Debris (copy) ]]
	local v1 = p1:GetScale()
	local v2 = p1:GetPivot()
	local v3 = p1:Clone()

	v3:ScaleTo(v1)
	v3:PivotTo(v2)
	v3.Parent = p1.Parent or workspace
	ScaleUp(v3, p2, 0.5)

	local v5 = TweenInfo.new(p3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

	for v6, v7 in v3:GetDescendants() do
		if v7:IsA("BasePart") then
			v7.CanCollide = false

			local v8 = TweenService:Create(v7, v5, {
				Transparency = 1
			})

			v8:Play()
			Debris:AddItem(v8, v5.Time)
		end
	end

	Debris:AddItem(v3, v5.Time)
end

local function ConfigureVfxPart(p1) --[[ ConfigureVfxPart | Line: 251 ]]
	p1.Anchored = true
	p1.CanCollide = false
	p1.CanQuery = false
	p1.CanTouch = false
	p1.Massless = true
	p1.Transparency = 1
end

local function WrapAsScalableModel(p1) --[[ WrapAsScalableModel | Line: 260 ]]
	if p1:IsA("Model") then
		if not p1.PrimaryPart then
			local v1 = p1:FindFirstChildWhichIsA("BasePart", true)

			if v1 then
				p1.PrimaryPart = v1
			end
		end

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("BasePart") then
				v3.Anchored = true
				v3.CanCollide = false
				v3.CanQuery = false
				v3.CanTouch = false
				v3.Massless = true
				v3.Transparency = 1
			end
		end

		return p1
	end

	local Model = Instance.new("Model")

	if p1:IsA("BasePart") then
		p1.Anchored = true
		p1.CanCollide = false
		p1.CanQuery = false
		p1.CanTouch = false
		p1.Massless = true
		p1.Transparency = 1
		p1.Parent = Model
		Model.PrimaryPart = p1

		return Model
	end

	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Massless = true
	Part.Transparency = 1
	Part.Size = Vector3.new(0.1, 0.1, 0.1)
	Part.Parent = Model
	Model.PrimaryPart = Part

	for v4, v5 in p1:GetChildren() do
		v5.Parent = Part
	end

	return Model
end

local function CreateScaledVfxClone(p1, p2, p3) --[[ CreateScaledVfxClone | Line: 298 | Upvalues: WrapAsScalableModel (copy) ]]
	local v1 = WrapAsScalableModel((p1:Clone()))

	if not v1.PrimaryPart then
		v1:Destroy()

		return nil
	end

	local v2 = p2:GetScale()

	if math.abs(v2 - 1) > 0.001 then
		v1:ScaleTo(v2)
	end

	v1:PivotTo(p3)
	v1.Parent = p2

	return v1
end

local function GetMaxParticleLifetime(p1) --[[ GetMaxParticleLifetime | Line: 316 ]]
	local v1 = 1

	for v2, v3 in p1 do
		v1 = math.max(v1, v3.Lifetime.Max)
	end

	return v1 + 0.5
end

local function AddEmitter(p1, p2) --[[ AddEmitter | Line: 324 ]]
	if not table.find(p1, p2) then
		table.insert(p1, p2)
	end
end

local function CollectLevelEmitters(p1, p2) --[[ CollectLevelEmitters | Line: 331 ]]
	local v1 = ("Level%*"):format(p2)
	local t = {}

	if p1.Name == v1 then
		if p1:IsA("ParticleEmitter") and not table.find(t, p1) then
			table.insert(t, p1)
		end

		for v2, v3 in p1:GetDescendants() do
			if v3:IsA("ParticleEmitter") and not table.find(t, v3) then
				table.insert(t, v3)
			end
		end
	else
		local v4 = p1:FindFirstChild(v1)

		if v4 then
			if v4:IsA("ParticleEmitter") and not table.find(t, v4) then
				table.insert(t, v4)
			end

			for v6, v7 in v4:GetDescendants() do
				if v7:IsA("ParticleEmitter") and not table.find(t, v7) then
					table.insert(t, v7)
				end
			end
		end

		for v8, v9 in p1:GetDescendants() do
			if v9:IsA("ParticleEmitter") and v9.Name == v1 and not table.find(t, v9) then
				table.insert(t, v9)
			end
		end
	end

	return t
end

local function EmitLevelParticles(p1) --[[ EmitLevelParticles | Line: 368 | Upvalues: GetInstancePath (copy) ]]
	for v1, v2 in p1 do
		if v2.Parent then
			local v3 = v2:GetAttribute("EmitCount")
			local v4 = if type(v3) == "number" then v3 else 1

			("Emitting %* from %* Enabled=%*"):format(v4, GetInstancePath(v2), v2.Enabled)
			v2:Emit(v4)

			continue
		end

		("Skipping emit, no parent: %*"):format((GetInstancePath(v2)))
	end
end

local function PlayPopVFX(p1, p2) --[[ PlayPopVFX | Line: 381 | Upvalues: GetInstancePath (copy), Assets (copy), DescribeChildren (copy), CreateScaledVfxClone (copy), CollectLevelEmitters (copy), EmitLevelParticles (copy), Debris (copy) ]]
	("Start level=%* egg=%*"):format(p2, (p1:GetFullName()))

	local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if not v1 then
		return
	end

	("Root part: %* eggScale=%*"):format(GetInstancePath(v1), (p1:GetScale()))

	local EggEffects = Assets:FindFirstChild("EggEffects")

	if not EggEffects then
		return
	end

	local EggEffects2 = Assets:FindFirstChild("EggEffects")
	local v2 = if EggEffects2 then EggEffects2:FindFirstChild("GrowEffects") else nil

	if not v2 then
		("Abort: EggEffects.GrowEffects missing. EggEffects children: %*"):format((DescribeChildren(EggEffects)))

		return
	end

	("GrowEffects template: %* (%*) children: %*"):format(GetInstancePath(v2), v2.ClassName, (DescribeChildren(v2)))

	local v3 = CreateScaledVfxClone(v2, p1, v1.CFrame)

	if not v3 then
		return
	end

	("Scaled VFX clone to %* at %* (%*)"):format(p1:GetScale(), GetInstancePath(v3), v3.ClassName)

	local v4 = CollectLevelEmitters(v3, p2)

	if #v4 == 0 then
		("Abort: no Level%* ParticleEmitters in scaled GrowEffects clone"):format(p2)

		local t = {}

		for v5, v6 in v2:GetDescendants() do
			if v6:IsA("ParticleEmitter") then
				table.insert(t, (("%* EmitCount=%*"):format(GetInstancePath(v6), (v6:GetAttribute("EmitCount")))))
			end
		end

		if #t ~= 0 then
			("GrowEffects ParticleEmitters: %*"):format((table.concat(t, " | ")))
		end

		v3:Destroy()
	else
		for v8, v9 in v4 do
			local v11 = GetInstancePath(v9);

			("Queued emitter: %* parent=%*"):format(v11, if v9.Parent then v9.Parent:GetFullName() else "nil")
		end

		task.spawn(function() --[[ Line: 438 | Upvalues: v4 (copy), EmitLevelParticles (ref) ]]
			task.wait();
			("Emitting %* emitter(s)"):format(#v4)
			EmitLevelParticles(v4)
		end)

		local v13 = 1

		for v14, v15 in v4 do
			v13 = math.max(v13, v15.Lifetime.Max)
		end

		local v17 = v13 + 0.5

		("Scheduling cleanup in %*s for scaled VFX clone"):format(v17)
		Debris:AddItem(v3, v17)
	end
end

local function HighlightFlash(p1, p2) --[[ HighlightFlash | Line: 449 | Upvalues: TweenService (copy), Debris (copy) ]]
	local v1 = TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	local Highlight = Instance.new("Highlight")

	Highlight.OutlineTransparency = 1
	Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.FillTransparency = 0
	Highlight.Parent = p1
	Highlight.Adornee = p1

	local v2 = TweenService:Create(Highlight, v1, {
		FillTransparency = 1
	})

	v2:Play()
	Debris:AddItem(v2, v1.Time)
	Debris:AddItem(Highlight, v1.Time)
end

local function lerp(p1, p2, p3) --[[ lerp | Line: 464 ]]
	return p1 + (p2 - p1) * p3
end

local function EggSwell(p1, p2, p3) --[[ EggSwell | Line: 468 | Upvalues: ScaleUpInstant (copy), v1 (copy), SpiralTrail (copy), TweenService (copy) ]]
	local Highlight = p1:FindFirstChild("Highlight", true)
	local v12 = p1:GetScale()

	ScaleUpInstant(p1, v12)

	local v2 = p1:GetPivot()
	local v3 = v2 * CFrame.new(0, 4, 0)
	local v5 = v3 * CFrame.Angles(0, math.rad((v1:NextNumber(-180, 180))), 0)

	task.delay(0.5, function() --[[ Line: 487 | Upvalues: SpiralTrail (ref), p1 (copy) ]]
		SpiralTrail.Init(p1.PrimaryPart, {
			Size = 0.4,
			Offset = 2,
			Time = 0.2,
			Frequency = 1,
			Color = Color3.fromRGB(255, 255, 255)
		})
	end)

	local sum = 0
	local v6 = v12 * 0.7

	while sum < 1.8 do
		sum = sum + game:GetService("RunService").Heartbeat:Wait()

		local v8 = CFrame.Angles(0, math.rad((math.sin(sum / 1.8 * 6.283185307179586) + 1) / 2 * (sum / 1.8 * 360 * 5)), 0)
		local v9 = CFrame.new(v1:NextNumber(-1, 1) * p3 * sum / 1.8, v1:NextNumber(-1, 1) * p3 * sum / 1.8, v1:NextNumber(-1, 1) * p3 * sum / 1.8)

		if sum < 1.4 then
			p1:PivotTo(v2:Lerp(v5, (TweenService:GetValue(sum / 1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))) * v9 * v8)
		else
			p1:PivotTo(v5:Lerp(v2, (TweenService:GetValue((sum - 1.4) / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In))) * v9 * v8)
		end

		if sum > 0.4 and sum < 1 then
			ScaleUpInstant(p1, v12 + (v6 - v12) * TweenService:GetValue(sum - 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		elseif sum > 1 then
			ScaleUpInstant(p1, v6 + (p2 - v6) * TweenService:GetValue((sum - 1) / 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.InOut))
		end

		if sum < 0.6 then
			Highlight.FillTransparency = TweenService:GetValue(sum / 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * -1 + 1
			Highlight.OutlineTransparency = TweenService:GetValue(sum / 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * -0.5 + 1
		elseif sum > 1 then
			local v10 = sum - 1.4

			Highlight.FillTransparency = TweenService:GetValue(v10 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * 1 + 0
			Highlight.OutlineTransparency = TweenService:GetValue(v10 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) * 0.5 + 0.5
		else
			continue
		end
	end
end

local function PlayNearMissScale(p1, p2, p3) --[[ PlayNearMissScale | Line: 558 | Upvalues: EggSwell (copy), PlayPopVFX (copy) ]]
	if p3 == 1 then
		EggSwell(p1, p2, 0)
	elseif p3 == 2 then
		EggSwell(p1, p2, 0.2)
	end

	PlayPopVFX(p1, p3)
end

local function Pause(p1) --[[ Pause | Line: 578 ]]
	task.wait(p1 or 0.5)
end

local function WobbleAndWait(p1, p2, p3, p4, p5) --[[ WobbleAndWait | Line: 582 | Upvalues: Wobble (copy), t7 (copy) ]]
	local v2 = if math.abs(p1:GetScale() - 1) > 0.001 then true else false

	if not v2 then
		p1:PivotTo(p2)
	end

	Wobble(p1, p3, p4, p5)
	task.wait(p4)

	local v3 = t7[p1]

	if v3 then
		v3.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v3.StartPivot)
		end

		t7[p1] = nil
	end

	if v2 then
		return
	end

	p1:PivotTo(p2)
end

local function ResetToLand(p1, p2) --[[ ResetToLand | Line: 595 | Upvalues: t7 (copy) ]]
	local v1 = t7[p1]

	if v1 then
		v1.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v1.StartPivot)
		end

		t7[p1] = nil
	end

	if not (math.abs(p1:GetScale() - 1) <= 0.001) then
		return
	end

	p1:PivotTo(p2)
end

local function NotifyWobbleBeat(p1, p2) --[[ NotifyWobbleBeat | Line: 604 ]]
	p1.index = p1.index + 1

	if not (p2 and p2.onWobbleBeat) then
		return
	end

	p2.onWobbleBeat(p1.index)
end

local function NotifyGrowStart(p1, p2, p3) --[[ NotifyGrowStart | Line: 611 ]]
	if not (p1 and p1.onGrowStart) then
		return
	end

	p1.onGrowStart(p2, p3)
end

local function NotifyGrowBeat(p1, p2, p3) --[[ NotifyGrowBeat | Line: 617 ]]
	if not (p1 and p1.onGrowBeat) then
		return
	end

	p1.onGrowBeat(p2, p3)
end

local function PlayWobbleBeat(p1, p2, p3, p4, p5, p6, p7, p8) --[[ PlayWobbleBeat | Line: 623 | Upvalues: WobbleAndWait (copy) ]]
	if not p8 then
		task.wait(p4 or 0.5)
	end

	if p6 then
		p6()
	end

	WobbleAndWait(p1, p2, p3.Intensity, p3.Duration, p3.Shake)
	p5.index = p5.index + 1

	if not (p7 and p7.onWobbleBeat) then
		return
	end

	p7.onWobbleBeat(p5.index)
end

local function PlayWobbleBeats(p1, p2, p3, p4, p5, p6, p7, p8) --[[ PlayWobbleBeats | Line: 643 | Upvalues: WobbleAndWait (copy) ]]
	for v1, v2 in p3 do
		if not (if p8 then v1 == 1 else p8) then
			task.wait(p4 or 0.5)
		end

		if p6 then
			p6()
		end

		WobbleAndWait(p1, p2, v2.Intensity, v2.Duration, v2.Shake)
		p5.index = p5.index + 1

		if p7 and p7.onWobbleBeat then
			p7.onWobbleBeat(p5.index)
		end
	end
end

local function PlayPreGrowWobbles(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ PlayPreGrowWobbles | Line: 667 | Upvalues: WobbleAndWait (copy) ]]
	if #p3 == 0 then
		if not p9 then
			return
		end

		if math.random() >= 0.15 then
			p9()

			return
		end

		p5.index = p5.index + 1

		if not (p7 and p7.onWobbleBeat) then
			return
		end

		p7.onWobbleBeat(p5.index)
	else
		for i = 1, #p3 - 1 do
			local v1 = p3[i]

			if not (if p8 then if i == 1 then true else false else p8) then
				task.wait(p4 or 0.5)
			end

			if p6 then
				p6()
			end

			WobbleAndWait(p1, p2, v1.Intensity, v1.Duration, v1.Shake)
			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end
		end

		if p9 then
			local v3 = p3[#p3]

			if not (if p8 then #p3 == 1 else p8) then
				task.wait(p4 or 0.5)
			end

			if p6 then
				p6()
			end

			WobbleAndWait(p1, p2, v3.Intensity, v3.Duration, v3.Shake)
			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end

			if math.random() >= 0.15 then
				p9()

				return
			end

			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end
		elseif math.random() >= 0.15 then
			local v5 = p3[#p3]

			if not (if p8 then #p3 == 1 else p8) then
				task.wait(p4 or 0.5)
			end

			if p6 then
				p6()
			end

			WobbleAndWait(p1, p2, v5.Intensity, v5.Duration, v5.Shake)
			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end
		else
			p5.index = p5.index + 1

			if not (p7 and p7.onWobbleBeat) then
				return
			end

			p7.onWobbleBeat(p5.index)
		end
	end
end

local function PlayNearMissWobbleChain(p1, p2, p3, p4, p5, p6, p7) --[[ PlayNearMissWobbleChain | Line: 735 | Upvalues: v1 (copy), WobbleAndWait (copy) ]]
	local v12

	if p3.PreDelayMin and p3.PreDelayMax then
		local v2 = v1:NextNumber(p3.PreDelayMin, p3.PreDelayMax)

		task.wait(v2 or 0.5)
		v12 = v2
	else
		v12 = nil
	end

	local Spec = p3.Spec

	task.wait(p4 or 0.5)

	if p6 then
		p6()
	end

	WobbleAndWait(p1, p2, Spec.Intensity, Spec.Duration, Spec.Shake)
	p5.index = p5.index + 1

	if p7 and p7.onWobbleBeat then
		p7.onWobbleBeat(p5.index)
	end

	if p3.FollowUpSpec then
		if v12 then
			task.wait(v12 or 0.5)
		end

		local FollowUpSpec = p3.FollowUpSpec

		task.wait(p4 or 0.5)

		if p6 then
			p6()
		end

		WobbleAndWait(p1, p2, FollowUpSpec.Intensity, FollowUpSpec.Duration, FollowUpSpec.Shake)
		p5.index = p5.index + 1

		if p7 and p7.onWobbleBeat then
			p7.onWobbleBeat(p5.index)
		end

		if p3.PostDelay then
			task.wait(p3.PostDelay or 0.5)
		end
	else
		if not p3.PostDelay then
			return
		end

		task.wait(p3.PostDelay or 0.5)
	end
end

local function PlayChanceWobbleBeat(p1, p2, p3, p4, p5, p6, p7) --[[ PlayChanceWobbleBeat | Line: 773 | Upvalues: PlayNearMissWobbleChain (copy) ]]
	if not (math.random() > p3.Chance) then
		PlayNearMissWobbleChain(p1, p2, p3, p4, p5, p6, p7)
	end
end

local function PlaySharedOpeningPhase(p1, p2, p3, p4, p5) --[[ PlaySharedOpeningPhase | Line: 796 | Upvalues: PlayWobbleBeats (copy), t5 (copy), PlayNearMissWobbleChain (copy), t6 (copy) ]]
	local t = {
		index = 0
	}

	PlayWobbleBeats(p1, p2, t5, 0.5, t, p3, p4, true)

	if p5 then
		PlayNearMissWobbleChain(p1, p2, t6, 0.5, t, p3, p4)

		return t
	end

	local v1 = t6

	if not (math.random() > v1.Chance) then
		PlayNearMissWobbleChain(p1, p2, v1, 0.5, t, p3, p4)
	end

	return t
end

local function PlayPostFirstGrowFakeOutPhase(p1, p2, p3, p4, p5, p6) --[[ PlayPostFirstGrowFakeOutPhase | Line: 842 | Upvalues: PlayWobbleBeats (copy), t (copy), t2 (copy), PlayNearMissWobbleChain (copy), t6 (copy) ]]
	PlayWobbleBeats(p1, p2, { t, t2 }, 0.7, p3, p4, p5)

	if p6 then
		PlayNearMissWobbleChain(p1, p2, t6, 0.5, p3, p4, p5)

		return
	end

	local v1 = t6

	if not (math.random() > v1.Chance) then
		PlayNearMissWobbleChain(p1, p2, v1, 0.5, p3, p4, p5)
	end
end

local function PlayGrowBeat(p1, p2, p3, p4, p5) --[[ PlayGrowBeat | Line: 886 | Upvalues: EggSwell (copy), PlayPopVFX (copy) ]]
	task.wait(p4 or 0.5)

	if p5 and p5.onGrowStart then
		p5.onGrowStart(p3, p2)
	end

	if p3 == 1 then
		EggSwell(p1, p2, 0)
	elseif p3 == 2 then
		EggSwell(p1, p2, 0.2)
	end

	PlayPopVFX(p1, p3)

	if not (p5 and p5.onGrowBeat) then
		return
	end

	p5.onGrowBeat(p3, p2)
end

local function v2(p1, p2, p3, p4, p5, p6, p7) --[[ RunNearMissStage | Line: 899 | Upvalues: WobbleAndWait (copy), EggSwell (copy), PlayPopVFX (copy), v2 (copy) ]]
	if math.random() > p3.Chance then
		return
	end

	if p3.Wobble and (p3.ScaleUp and p3.WobbleAfterScale) then
		if math.random() >= 0.15 then
			local Wobble = p3.Wobble

			task.wait(p4 or 0.5)

			if p6 then
				p6()
			end

			WobbleAndWait(p1, p2, Wobble.Intensity, Wobble.Duration, Wobble.Shake)
			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end

			task.wait(p4 or 0.5)
		else
			p5.index = p5.index + 1

			if p7 and p7.onWobbleBeat then
				p7.onWobbleBeat(p5.index)
			end
		end

		local Scale = p3.ScaleUp.Scale
		local VfxLevel = p3.ScaleUp.VfxLevel

		if VfxLevel == 1 then
			EggSwell(p1, Scale, 0)
		elseif VfxLevel == 2 then
			EggSwell(p1, Scale, 0.2)
		end

		PlayPopVFX(p1, VfxLevel)

		local VfxLevel2 = p3.ScaleUp.VfxLevel
		local Scale2 = p3.ScaleUp.Scale

		if p7 and p7.onGrowBeat then
			p7.onGrowBeat(VfxLevel2, Scale2)
		end

		local WobbleAfterScale = p3.WobbleAfterScale

		task.wait(p4 or 0.5)

		if p6 then
			p6()
		end

		WobbleAndWait(p1, p2, WobbleAfterScale.Intensity, WobbleAfterScale.Duration, WobbleAfterScale.Shake)
		p5.index = p5.index + 1

		if p7 and p7.onWobbleBeat then
			p7.onWobbleBeat(p5.index)
		end
	elseif p3.Wobble then
		local Wobble = p3.Wobble

		task.wait(p4 or 0.5)

		if p6 then
			p6()
		end

		WobbleAndWait(p1, p2, Wobble.Intensity, Wobble.Duration, Wobble.Shake)
		p5.index = p5.index + 1

		if p7 and p7.onWobbleBeat then
			p7.onWobbleBeat(p5.index)
		end
	end

	if not p3.Nested then
		return
	end

	v2(p1, p2, p3.Nested, p4, p5, p6, p7)
end

local function RunPreHatchSequence(p1, p2, p3, p4, p5) --[[ RunPreHatchSequence | Line: 939 | Upvalues: WobbleAndWait (copy), PlayNearMissWobbleChain (copy), v2 (copy), t7 (copy) ]]
	local v1 = p3.Pause or 0.5
	local t = {
		index = 0
	}

	for v22, v3 in p3.InitialWobbles do
		if not (if v22 == 1 then true else false) then
			task.wait(v1 or 0.5)
		end

		if p4 then
			p4()
		end

		WobbleAndWait(p1, p2, v3.Intensity, v3.Duration, v3.Shake)
		t.index = t.index + 1

		if p5 and p5.onWobbleBeat then
			p5.onWobbleBeat(t.index)
		end
	end

	if p3.OptionalWobble then
		local OptionalWobble = p3.OptionalWobble

		if not (math.random() > OptionalWobble.Chance) then
			PlayNearMissWobbleChain(p1, p2, OptionalWobble, v1, t, p4, p5)
		end
	end

	if p3.NearMiss then
		v2(p1, p2, p3.NearMiss, v1, t, p4, p5)
	end

	task.wait(v1 or 0.5)

	local v5 = t7[p1]

	if v5 then
		v5.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v5.StartPivot)
		end

		t7[p1] = nil
	end

	if not (math.abs(p1:GetScale() - 1) <= 0.001) then
		return
	end

	p1:PivotTo(p2)
end

local function RunBigPreHatchSequence(p1, p2, p3, p4) --[[ RunBigPreHatchSequence | Line: 982 | Upvalues: PlayWobbleBeats (copy), t5 (copy), PlayNearMissWobbleChain (copy), t6 (copy), EggSwell (copy), PlayPopVFX (copy), t (copy), t2 (copy), t7 (copy) ]]
	local t3 = {
		index = 0
	}

	PlayWobbleBeats(p1, p2, t5, 0.5, t3, p3, p4, true)
	PlayNearMissWobbleChain(p1, p2, t6, 0.5, t3, p3, p4)
	task.wait(0.5)

	if p4 and p4.onGrowStart then
		p4.onGrowStart(1, 2)
	end

	EggSwell(p1, 2, 0)
	PlayPopVFX(p1, 1)

	if p4 and p4.onGrowBeat then
		p4.onGrowBeat(1, 2)
	end

	PlayWobbleBeats(p1, p2, { t, t2 }, 0.7, t3, p3, p4)

	local v1 = t6

	if not (math.random() > v1.Chance) then
		PlayNearMissWobbleChain(p1, p2, v1, 0.5, t3, p3, p4)
	end

	task.wait(0.5)

	local v2 = t7[p1]

	if v2 then
		v2.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v2.StartPivot)
		end

		t7[p1] = nil
	end

	if not (math.abs(p1:GetScale() - 1) <= 0.001) then
		return
	end

	p1:PivotTo(p2)
end

local function RunHugePreHatchSequence(p1, p2, p3, p4) --[[ RunHugePreHatchSequence | Line: 998 | Upvalues: PlayWobbleBeats (copy), t5 (copy), PlayNearMissWobbleChain (copy), t6 (copy), EggSwell (copy), PlayPopVFX (copy), t (copy), t2 (copy), t3 (copy), t4 (copy), t7 (copy) ]]
	local t8 = {
		index = 0
	}

	PlayWobbleBeats(p1, p2, t5, 0.5, t8, p3, p4, true)
	PlayNearMissWobbleChain(p1, p2, t6, 0.5, t8, p3, p4)
	task.wait(0.5)

	if p4 and p4.onGrowStart then
		p4.onGrowStart(1, 2)
	end

	EggSwell(p1, 2, 0)
	PlayPopVFX(p1, 1)

	if p4 and p4.onGrowBeat then
		p4.onGrowBeat(1, 2)
	end

	PlayWobbleBeats(p1, p2, { t, t2 }, 0.7, t8, p3, p4)
	PlayNearMissWobbleChain(p1, p2, t6, 0.5, t8, p3, p4)
	task.wait(0.5)

	if p4 and p4.onGrowStart then
		p4.onGrowStart(2, 4)
	end

	EggSwell(p1, 4, 0.2)
	PlayPopVFX(p1, 2)

	if p4 and p4.onGrowBeat then
		p4.onGrowBeat(2, 4)
	end

	PlayWobbleBeats(p1, p2, { t3, t4 }, 0.9, t8, p3, p4)
	task.wait(0.5)

	local v1 = t7[p1]

	if v1 then
		v1.Connection:Disconnect()

		if p1.Parent then
			p1:PivotTo(v1.StartPivot)
		end

		t7[p1] = nil
	end

	if not (math.abs(p1:GetScale() - 1) <= 0.001) then
		return
	end

	p1:PivotTo(p2)
end

return table.freeze({
	GROW_SCALE_1 = 2,
	GROW_SCALE_2 = 4,
	GROW_SCALE_3 = 6,
	GROW_STEP_MULT = 2,
	ResolveHatchTargetScale = function(p1, p2) --[[ ResolveHatchTargetScale | Line: 1038 ]]
		if p1 == "Huge" then
			return 6
		end

		if p1 == "Big" then
			return 4
		end

		return p2 * 2
	end,
	NormalPreHatchConfig = {
		InitialWobbles = t5,
		OptionalWobble = t6
	},
	StopWobble = StopWobble,
	Wobble = Wobble,
	ScaleUp = ScaleUp,
	ScaleUpInstant = ScaleUpInstant,
	PopupFadeEffect = PopupFadeEffect,
	PlayPopVFX = PlayPopVFX,
	HighlightFlash = HighlightFlash,
	PlayNearMissScale = PlayNearMissScale,
	Pause = Pause,
	WobbleAndWait = WobbleAndWait,
	ResetToLand = ResetToLand,
	RunPreHatchSequence = RunPreHatchSequence,
	RunBigPreHatchSequence = RunBigPreHatchSequence,
	RunHugePreHatchSequence = RunHugePreHatchSequence
})