-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local EventConfig = require(ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("EventConfig"))
local v1 = script.Parent
local t = {}
local v2 = false
local v3 = nil

local function getAnimationIds() --[[ getAnimationIds | Line: 30 | Upvalues: v1 (copy) ]]
	local Animations = v1:FindFirstChild("Animations")

	if not Animations then
		return nil
	end

	local Rig = Animations:FindFirstChild("Rig")
	local Ball = Animations:FindFirstChild("Ball")

	local function getAnimId(p1, p2) --[[ getAnimId | Line: 37 ]]
		if not p1 then
			return nil
		end

		local v1 = p1:FindFirstChild(p2)

		if v1 and v1:IsA("Animation") then
			return v1.AnimationId
		end

		return nil
	end

	local t = {}
	local v12

	if Rig then
		local Idle = Rig:FindFirstChild("Idle")

		v12 = if Idle and Idle:IsA("Animation") then Idle.AnimationId else nil
	else
		v12 = nil
	end

	t.RigIdle = v12

	local v2

	if Rig then
		local Walk = Rig:FindFirstChild("Walk")

		v2 = if Walk and Walk:IsA("Animation") then Walk.AnimationId else nil
	else
		v2 = nil
	end

	t.RigWalk = v2

	local v3

	if Rig then
		local Shoot = Rig:FindFirstChild("Shoot")

		v3 = if Shoot and Shoot:IsA("Animation") then Shoot.AnimationId else nil
	else
		v3 = nil
	end

	t.RigShoot = v3

	local v4

	if Ball then
		local Idle = Ball:FindFirstChild("Idle")

		v4 = if Idle and Idle:IsA("Animation") then Idle.AnimationId else nil
	else
		v4 = nil
	end

	t.BallIdle = v4

	local v5

	if Ball then
		local Walk = Ball:FindFirstChild("Walk")

		v5 = if Walk and Walk:IsA("Animation") then Walk.AnimationId else nil
	else
		v5 = nil
	end

	t.BallWalk = v5

	local v6

	if Ball then
		local Shoot = Ball:FindFirstChild("Shoot")

		v6 = if Shoot and Shoot:IsA("Animation") then Shoot.AnimationId else nil
	else
		v6 = nil
	end

	t.BallShoot = v6

	return t
end

local function playAnimation(p1, p2, p3, p4) --[[ playAnimation | Line: 57 ]]
	local Rig = p1:FindFirstChild("Rig")

	if not Rig then
		return
	end

	local AnimationController = Rig:FindFirstChild("AnimationController")

	if AnimationController then
		local Animator = AnimationController:FindFirstChildOfClass("Animator")

		if Animator then
			for i, v in ipairs(Animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end

			if p2 then
				local Animation = Instance.new("Animation")

				Animation.AnimationId = p2

				local ok, result = pcall(function() --[[ Line: 72 | Upvalues: Animator (copy), Animation (copy) ]]
					return Animator:LoadAnimation(Animation)
				end)

				if ok and result then
					result.Looped = p4
					result:Play()
				end
			end
		end
	end

	local Ball = Rig:FindFirstChild("Ball")

	if not Ball then
		return
	end

	local AnimationController2 = Ball:FindFirstChild("AnimationController")
	local v1 = AnimationController2 and AnimationController2:FindFirstChildOfClass("Animator")

	if not v1 then
		return
	end

	for i, v in ipairs(v1:GetPlayingAnimationTracks()) do
		v:Stop()
	end

	if not p3 then
		return
	end

	local Animation = Instance.new("Animation")

	Animation.AnimationId = p3

	local ok, result = pcall(function() --[[ Line: 95 | Upvalues: v1 (copy), Animation (copy) ]]
		return v1:LoadAnimation(Animation)
	end)

	if not (ok and result) then
		return
	end

	result.Looped = p4
	result:Play()
end

local function getMutationModule() --[[ getMutationModule | Line: 108 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")

	if not Events then
		return nil
	end

	local Mutations = Events:FindFirstChild("Mutations")

	if not Mutations then
		return nil
	end

	local Brazil = Mutations:FindFirstChild("Brazil")

	if Brazil then
		return Brazil:FindFirstChild("Brazil")
	end

	return nil
end

local function getEventConfig() --[[ getEventConfig | Line: 119 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 120 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)

	if not ok then
		return nil
	end

	return result.Events and result.Events.Brazil
end

local function findAllBrainrots() --[[ findAllBrainrots | Line: 132 ]]
	local t = {}

	for i, v in ipairs(workspace:GetChildren()) do
		if v:IsA("Model") and v:GetAttribute("BrainrotName") then
			table.insert(t, v)
		end
	end

	return t
end

local function syncToSlot(p1, p2, p3) --[[ syncToSlot | Line: 149 ]]
	p1:SetAttribute(p2, p3)

	local v1 = p1.Parent

	if not (v1 and v1:GetAttribute("Earn")) then
		return
	end

	v1:SetAttribute(p2, p3)
end

local function applyBrazilMutation(p1) --[[ applyBrazilMutation | Line: 158 | Upvalues: ReplicatedStorage (copy), EventConfig (copy) ]]
	local list = {}

	for v2 in string.gmatch(p1:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, v2)

		if v2 == "Brazil" then
			return
		end
	end

	local ok, result = pcall(function() --[[ Line: 120 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)
	local v3 = if ok then result.Events and result.Events.Brazil else nil

	if not v3 then
		warn("[Brazil] Could not load EventConfig for Brazil")

		return
	end

	local v5 = tonumber(p1:GetAttribute("Earn")) or 0

	if not p1:GetAttribute("BaseEarn") then
		p1:SetAttribute("BaseEarn", v5)

		local v6 = p1.Parent

		if v6 and v6:GetAttribute("Earn") then
			v6:SetAttribute("BaseEarn", v5)
		end
	end

	table.insert(list, "Brazil")

	local v7 = table.concat(list, ",")

	p1:SetAttribute("ActiveEvent", v7)

	local v8 = p1.Parent

	if v8 and v8:GetAttribute("Earn") then
		v8:SetAttribute("ActiveEvent", v7)
	end

	local sum = 0

	for i, v in ipairs(list) do
		local v9 = EventConfig.Events[v]

		if v9 and v9.Multiplier then
			sum = sum + (v9.Multiplier - 1)
		end
	end

	local v10 = sum + 1

	p1:SetAttribute("EventMultiplier", v10)

	local v11 = p1.Parent

	if v11 and v11:GetAttribute("Earn") then
		v11:SetAttribute("EventMultiplier", v10)
	end

	if (p1:GetAttribute("Mutation") or "Normal") == "Normal" then
		p1:SetAttribute("Mutation", "Brazil")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = p1:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Brazil")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Brazil"
			end
		end
	end

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v12

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Brazil = Mutations:FindFirstChild("Brazil")

			v12 = if Brazil then Brazil:FindFirstChild("Brazil") else nil
		else
			v12 = nil
		end
	else
		v12 = nil
	end

	if v12 then
		local ok2, result2 = pcall(function() --[[ Line: 207 | Upvalues: v12 (copy) ]]
			return require(v12)
		end)

		if ok2 and (result2 and result2.ApplyVFX) then
			result2.ApplyVFX(p1)
		end
	end

	local EventHighlight = p1:FindFirstChild("EventHighlight")

	if not EventHighlight then
		local EventHighlight2 = Instance.new("Highlight")

		EventHighlight2.Name = "EventHighlight"
		EventHighlight2.FillTransparency = 0.5
		EventHighlight2.OutlineTransparency = 0.3
		EventHighlight2.Parent = p1
		EventHighlight = EventHighlight2
	end

	EventHighlight.FillColor = Color3.fromRGB(100, 255, 100)
	EventHighlight.OutlineColor = Color3.fromRGB(255, 255, 100)

	local Position = p1:GetPivot().Position
	local Attachment = Instance.new("Attachment")

	Attachment.Position = Position
	Attachment.Parent = workspace.Terrain

	local ParticleEmitter = Instance.new("ParticleEmitter")

	ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(100, 255, 100))
	ParticleEmitter.Size = NumberSequence.new(0.5, 0)
	ParticleEmitter.Lifetime = NumberRange.new(0.5, 1)
	ParticleEmitter.Rate = 100
	ParticleEmitter.Speed = NumberRange.new(10, 20)
	ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
	ParticleEmitter.Parent = Attachment
	ParticleEmitter:Emit(50)
	task.delay(2, function() --[[ Line: 246 | Upvalues: ParticleEmitter (copy), Attachment (copy) ]]
		ParticleEmitter.Enabled = false
		task.wait(1)

		if not (Attachment and Attachment.Parent) then
			return
		end

		Attachment:Destroy()
	end)
	print("[Brazil] Applied Brazil mutation to " .. p1.Name .. " (" .. (v3.Multiplier or 3.5) .. "x multiplier)")
end

local function shootBallAtBrainrot(p1, p2) --[[ shootBallAtBrainrot | Line: 260 | Upvalues: v1 (copy), v2 (ref), applyBrazilMutation (copy) ]]
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local Ball = v1:FindFirstChild("Ball")

	if Ball then
		local BrazilBallProjectile = Ball:Clone()

		BrazilBallProjectile.Name = "BrazilBallProjectile"
		BrazilBallProjectile.Anchored = true
		BrazilBallProjectile.CanCollide = false
		BrazilBallProjectile.Parent = workspace
		BrazilBallProjectile.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 3, 0))

		local v22 = tick()

		task.spawn(function() --[[ Line: 278 | Upvalues: BrazilBallProjectile (copy), p2 (copy), v2 (ref), applyBrazilMutation (ref), v22 (copy) ]]
			repeat
				if not (BrazilBallProjectile and (BrazilBallProjectile.Parent and (p2 and (p2.Parent and v2)))) then
					if not (BrazilBallProjectile and BrazilBallProjectile.Parent) then
						return
					end

					BrazilBallProjectile:Destroy()

					return
				end

				task.wait()

				local v1 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart

				if not v1 then
					for i, v in ipairs(p2:GetDescendants()) do
						if v:IsA("BasePart") then
							v1 = v

							break
						end
					end
				end

				if not v1 then
					break
				end

				local Position2 = BrazilBallProjectile.Position
				local v23 = v1.Position - Position2

				if v23.Magnitude < 4 then
					applyBrazilMutation(p2)
					BrazilBallProjectile:Destroy()

					return
				end

				local Unit = v23.Unit
				local v3 = Position2 + Unit * 60 * 0.03

				BrazilBallProjectile.CFrame = CFrame.new(v3, v3 + Unit)
			until tick() - v22 > 5

			BrazilBallProjectile:Destroy()
		end)
	end
end

local function wanderNPC(p1, p2, p3) --[[ wanderNPC | Line: 330 | Upvalues: v2 (ref), playAnimation (copy) ]]
	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if Humanoid and p1:FindFirstChild("HumanoidRootPart") then
		task.spawn(function() --[[ Line: 334 | Upvalues: p1 (copy), v2 (ref), p2 (copy), p3 (copy), playAnimation (ref), Humanoid (copy) ]]
			while p1 and (p1.Parent and v2) do
				if math.random() < 0.7 then
					local v1 = math.random() * math.pi * 2
					local v22 = math.random(8, 25)
					local v5 = p2 + Vector3.new(math.cos(v1) * v22, 0, math.sin(v1) * v22)

					if p3 and (p3.RigWalk and p3.BallWalk) then
						playAnimation(p1, p3.RigWalk, p3.BallWalk, true)
					end

					Humanoid:MoveTo(v5)
					Humanoid.MoveToFinished:Wait(5)
				end

				if p3 and (p3.RigIdle and p3.BallIdle) then
					playAnimation(p1, p3.RigIdle, p3.BallIdle, true)
				end

				task.wait(math.random(1, 4))
			end
		end)
	end
end

local function startShootingLoop() --[[ startShootingLoop | Line: 362 | Upvalues: v3 (ref), v2 (ref), t (ref), findAllBrainrots (copy), getAnimationIds (copy), playAnimation (copy), shootBallAtBrainrot (copy) ]]
	v3 = task.spawn(function() --[[ Line: 363 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), getAnimationIds (ref), playAnimation (ref), shootBallAtBrainrot (ref) ]]
		while v2 do
			task.wait(math.random(3, 6))

			if not v2 or #t == 0 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Brazil" then
						v3 = true

						break
					end
				end

				if not v3 then
					table.insert(t2, v)
				end
			end

			if #t2 == 0 then
				continue
			end

			local v5 = t2[math.random(1, #t2)]
			local v6 = t[math.random(1, #t)]

			if not (v6 and v6.Parent) then
				continue
			end

			local HumanoidRootPart = v6:FindFirstChild("HumanoidRootPart")
			local v7 = v5:FindFirstChild("HumanoidRootPart") or v5.PrimaryPart

			if not v7 then
				for i2, v in ipairs(v5:GetDescendants()) do
					if v:IsA("BasePart") then
						v7 = v

						break
					end
				end
			end

			if HumanoidRootPart and v7 then
				local v8 = v7.Position - HumanoidRootPart.Position

				if v8.Magnitude > 0 then
					HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(v8.X, 0, v8.Z))
				end
			end

			local v10 = getAnimationIds()

			if v10 and (v10.RigShoot and v10.BallShoot) then
				playAnimation(v6, v10.RigShoot, v10.BallShoot, false)
			end

			shootBallAtBrainrot(v6, v5)
			task.delay(1.5, function() --[[ Line: 429 | Upvalues: v6 (copy), v2 (ref), v10 (copy), playAnimation (ref) ]]
				if not (v6 and (v6.Parent and (v2 and (v10 and (v10.RigIdle and v10.BallIdle))))) then
					return
				end

				playAnimation(v6, v10.RigIdle, v10.BallIdle, true)
			end)
		end
	end)
end

local t2 = {}

function t2.Start() --[[ Start | Line: 444 | Upvalues: t2 (copy), v2 (ref), v1 (copy), getAnimationIds (copy), playAnimation (copy), t (ref), wanderNPC (copy), v3 (ref), findAllBrainrots (copy), shootBallAtBrainrot (copy) ]]
	t2.Stop()
	v2 = true

	local NPCwar = v1:FindFirstChild("NPCwar")
	local Spawns = v1:FindFirstChild("Spawns")

	if not (NPCwar and Spawns) then
		warn("[Brazil] Missing NPCwar template or Spawns folder")

		return
	end

	for i, v in ipairs(NPCwar:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end

	local v12 = getAnimationIds()

	for i = 1, 4 do
		local v22 = Spawns:FindFirstChild("Spawn_" .. i)

		if v22 then
			local v32 = NPCwar:Clone()

			v32.Name = "BrazilNPC_" .. i
			v32.Parent = workspace

			local Rig = v32:FindFirstChild("Rig")

			for i2, v in ipairs(v32:GetDescendants()) do
				if v:IsA("BasePart") then
					if Rig and v:IsDescendantOf(Rig) then
						v.Transparency = 0
					else
						v.Transparency = 1
					end

					v.CanCollide = false
					v.Anchored = false
				end
			end

			v32:PivotTo(v22.CFrame)

			if v12 and (v12.RigIdle and v12.BallIdle) then
				playAnimation(v32, v12.RigIdle, v12.BallIdle, true)
			end

			table.insert(t, v32)
			wanderNPC(v32, v22.Position, v12)
		end
	end

	v3 = task.spawn(function() --[[ Line: 363 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), getAnimationIds (ref), playAnimation (ref), shootBallAtBrainrot (ref) ]]
		while v2 do
			task.wait(math.random(3, 6))

			if not v2 or #t == 0 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Brazil" then
						v3 = true

						break
					end
				end

				if not v3 then
					table.insert(t2, v)
				end
			end

			if #t2 == 0 then
				continue
			end

			local v5 = t2[math.random(1, #t2)]
			local v6 = t[math.random(1, #t)]

			if not (v6 and v6.Parent) then
				continue
			end

			local HumanoidRootPart = v6:FindFirstChild("HumanoidRootPart")
			local v7 = v5:FindFirstChild("HumanoidRootPart") or v5.PrimaryPart

			if not v7 then
				for i2, v in ipairs(v5:GetDescendants()) do
					if v:IsA("BasePart") then
						v7 = v

						break
					end
				end
			end

			if HumanoidRootPart and v7 then
				local v8 = v7.Position - HumanoidRootPart.Position

				if v8.Magnitude > 0 then
					HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(v8.X, 0, v8.Z))
				end
			end

			local v10 = getAnimationIds()

			if v10 and (v10.RigShoot and v10.BallShoot) then
				playAnimation(v6, v10.RigShoot, v10.BallShoot, false)
			end

			shootBallAtBrainrot(v6, v5)
			task.delay(1.5, function() --[[ Line: 429 | Upvalues: v6 (copy), v2 (ref), v10 (copy), playAnimation (ref) ]]
				if not (v6 and (v6.Parent and (v2 and (v10 and (v10.RigIdle and v10.BallIdle))))) then
					return
				end

				playAnimation(v6, v10.RigIdle, v10.BallIdle, true)
			end)
		end
	end)
	print("[Brazil] Event started with " .. #t .. " NPCs - balls will apply Brazil mutation on hit")
end
function t2.Stop() --[[ Stop | Line: 507 | Upvalues: v2 (ref), v3 (ref), t (ref) ]]
	v2 = false

	if v3 then
		task.cancel(v3)
		v3 = nil
	end

	for i, v in ipairs(t) do
		if v and v.Parent then
			v:Destroy()
		end
	end

	t = {}
	print("[Brazil] Event stopped")
end
function t2.Shoot(p1) --[[ Shoot | Line: 528 | Upvalues: v2 (ref), t (ref), getAnimationIds (copy), playAnimation (copy), shootBallAtBrainrot (copy) ]]
	if not v2 or #t == 0 then
		return
	end

	local v1 = t[math.random(1, #t)]

	if not (v1 and v1.Parent) then
		return
	end

	local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")
	local HumanoidRootPart2 = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart2 then
		local v22 = HumanoidRootPart2.Position - HumanoidRootPart.Position

		if v22.Magnitude > 0 then
			HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Vector3.new(v22.X, 0, v22.Z))
		end
	end

	local v4 = getAnimationIds()

	if v4 and (v4.RigShoot and v4.BallShoot) then
		playAnimation(v1, v4.RigShoot, v4.BallShoot, false)
	end

	shootBallAtBrainrot(v1, p1)
	task.delay(1.5, function() --[[ Line: 554 | Upvalues: v1 (copy), v2 (ref), v4 (copy), playAnimation (ref) ]]
		if not (v1 and (v1.Parent and (v2 and (v4 and (v4.RigIdle and v4.BallIdle))))) then
			return
		end

		playAnimation(v1, v4.RigIdle, v4.BallIdle, true)
	end)
end
function t2.ApplyVFX(p1) --[[ ApplyVFX | Line: 564 | Upvalues: ReplicatedStorage (copy), t2 (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Brazil = Mutations:FindFirstChild("Brazil")

			v1 = if Brazil then Brazil:FindFirstChild("Brazil") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if v1 then
		local ok, result = pcall(function() --[[ Line: 568 | Upvalues: v1 (copy) ]]
			return require(v1)
		end)

		if ok and (result and result.ApplyVFX) then
			result.ApplyVFX(p1)
		end
	end

	t2.Shoot(p1)
end
function t2.RemoveVFX(p1) --[[ RemoveVFX | Line: 581 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Brazil = Mutations:FindFirstChild("Brazil")

			v1 = if Brazil then Brazil:FindFirstChild("Brazil") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 584 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if not (ok and (result and result.RemoveVFX)) then
		return
	end

	result.RemoveVFX(p1)
end

return t2