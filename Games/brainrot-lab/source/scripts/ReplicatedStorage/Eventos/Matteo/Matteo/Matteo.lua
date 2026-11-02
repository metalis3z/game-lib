-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local v1 = script.Parent
local t = {}
local v2 = false
local v3 = nil
local v4 = nil
local v5 = nil

local function getAnimationIds() --[[ getAnimationIds | Line: 25 | Upvalues: v1 (copy) ]]
	local Animations = v1:FindFirstChild("Animations")

	if not Animations then
		return nil
	end

	local Idle1 = Animations:FindFirstChild("Idle1")
	local Idle2 = Animations:FindFirstChild("Idle2")
	local t = {}

	t.TreeIdle = if Idle1 and Idle1:IsA("Animation") then Idle1.AnimationId or nil else nil
	t.MatteoIdle = if Idle2 and Idle2:IsA("Animation") then Idle2.AnimationId or nil else nil

	return t
end

local function getVisualsTemplate() --[[ getVisualsTemplate | Line: 39 | Upvalues: v1 (copy) ]]
	return v1:FindFirstChild("Visuals")
end

local function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 46 ]]
	if not (p1 and p2) then
		return
	end

	local AnimationController = p1:FindFirstChildOfClass("AnimationController")

	if not AnimationController then
		return
	end

	local Animator = AnimationController:FindFirstChildOfClass("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = AnimationController
	end

	for i, v in ipairs(Animator:GetPlayingAnimationTracks()) do
		v:Stop()
	end

	local Animation = Instance.new("Animation")

	Animation.AnimationId = p2

	local ok, result = pcall(function() --[[ Line: 65 | Upvalues: Animator (ref), Animation (copy) ]]
		return Animator:LoadAnimation(Animation)
	end)

	if not (ok and result) then
		return
	end

	result.Looped = p3
	result:Play()
end

local function getMutationModule() --[[ getMutationModule | Line: 75 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")

	if not Events then
		return nil
	end

	local Mutations = Events:FindFirstChild("Mutations")

	if not Mutations then
		return nil
	end

	local Matteo = Mutations:FindFirstChild("Matteo")

	if Matteo then
		return Matteo:FindFirstChild("Matteo")
	end

	return nil
end

local function getEventConfig() --[[ getEventConfig | Line: 86 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 87 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)

	if not ok then
		return nil
	end

	return result.Events and result.Events.Matteo
end

local function findAllBrainrots() --[[ findAllBrainrots | Line: 99 ]]
	local t = {}

	for i, v in ipairs(workspace:GetChildren()) do
		if v:IsA("Model") and v:GetAttribute("BrainrotName") then
			table.insert(t, v)
		end
	end

	return t
end

local function syncToSlot(p1, p2, p3) --[[ syncToSlot | Line: 116 ]]
	p1:SetAttribute(p2, p3)

	local v1 = p1.Parent

	if not (v1 and v1:GetAttribute("Earn")) then
		return
	end

	v1:SetAttribute(p2, p3)
end

local function applyMatteoMutation(p1) --[[ applyMatteoMutation | Line: 125 | Upvalues: ReplicatedStorage (copy), v1 (copy) ]]
	local list = {}

	for v2 in string.gmatch(p1:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, v2)

		if v2 == "Matteo" then
			return
		end
	end

	local ok, result = pcall(function() --[[ Line: 87 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)
	local v3 = if ok then result.Events and result.Events.Matteo else nil

	if not v3 then
		warn("[Matteo] Could not load EventConfig for Matteo")

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

	table.insert(list, "Matteo")

	local v7 = table.concat(list, ",")

	p1:SetAttribute("ActiveEvent", v7)

	local v8 = p1.Parent

	if v8 and v8:GetAttribute("Earn") then
		v8:SetAttribute("ActiveEvent", v7)
	end

	local sum = 0
	local ok2, result2 = pcall(function() --[[ Line: 157 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)

	if ok2 and (result2 and result2.Events) then
		for i, v in ipairs(list) do
			local v9 = result2.Events[v]

			if v9 and v9.Multiplier then
				sum = sum + (v9.Multiplier - 1)
			end
		end
	end

	local v10 = sum + 1

	p1:SetAttribute("EventMultiplier", v10)

	local v11 = p1.Parent

	if v11 and v11:GetAttribute("Earn") then
		v11:SetAttribute("EventMultiplier", v10)
	end

	if (p1:GetAttribute("Mutation") or "Normal") == "Normal" then
		p1:SetAttribute("Mutation", "Matteo")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = p1:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Matteo")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Matteo"
			end
		end
	end

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v122

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Matteo = Mutations:FindFirstChild("Matteo")

			v122 = if Matteo then Matteo:FindFirstChild("Matteo") else nil
		else
			v122 = nil
		end
	else
		v122 = nil
	end

	if v122 then
		local ok3, result3 = pcall(function() --[[ Line: 179 | Upvalues: v122 (copy) ]]
			return require(v122)
		end)

		if ok3 and (result3 and result3.ApplyVFX) then
			result3.ApplyVFX(p1)
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

	EventHighlight.FillColor = Color3.fromRGB(255, 200, 100)
	EventHighlight.OutlineColor = Color3.fromRGB(255, 220, 150)

	local Position = p1:GetPivot().Position
	local Attachment = Instance.new("Attachment")

	Attachment.Position = Position
	Attachment.Parent = workspace.Terrain

	local ParticleEmitter = Instance.new("ParticleEmitter")

	ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 200, 100))
	ParticleEmitter.Size = NumberSequence.new(0.5, 0)
	ParticleEmitter.Lifetime = NumberRange.new(0.5, 1)
	ParticleEmitter.Rate = 100
	ParticleEmitter.Speed = NumberRange.new(10, 20)
	ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
	ParticleEmitter.Parent = Attachment
	ParticleEmitter:Emit(50)
	task.delay(2, function() --[[ Line: 218 | Upvalues: ParticleEmitter (copy), Attachment (copy) ]]
		ParticleEmitter.Enabled = false
		task.wait(1)

		if not (Attachment and Attachment.Parent) then
			return
		end

		Attachment:Destroy()
	end)

	local Explosion = v1:FindFirstChild("Explosion")

	if Explosion then
		local Matteo_Explosion = Explosion:Clone()

		Matteo_Explosion.Name = "Matteo_Explosion"
		Matteo_Explosion.Parent = workspace
		task.delay(3, function() --[[ Line: 232 | Upvalues: Matteo_Explosion (copy) ]]
			if not (Matteo_Explosion and Matteo_Explosion.Parent) then
				return
			end

			Matteo_Explosion:Destroy()
		end)
	end

	print("[Matteo] Applied Matteo mutation to " .. p1.Name .. " (" .. (v3.Multiplier or 2.5) .. "x multiplier)")
end

local function shootHatAtBrainrot(p1, p2) --[[ shootHatAtBrainrot | Line: 245 | Upvalues: v1 (copy), v2 (ref), applyMatteoMutation (copy) ]]
	local Rig = p1:FindFirstChild("Rig")

	if not Rig then
		return
	end

	local v12 = Rig:FindFirstChildWhichIsA("MeshPart") or Rig:FindFirstChildWhichIsA("BasePart")

	if not v12 then
		return
	end

	local Hat = v1:FindFirstChild("Hat")

	if Hat then
		local MatteoHatProjectile = Hat:Clone()

		MatteoHatProjectile.Name = "MatteoHatProjectile"
		MatteoHatProjectile.Anchored = true
		MatteoHatProjectile.CanCollide = false
		MatteoHatProjectile.Parent = workspace
		MatteoHatProjectile.CFrame = CFrame.new(v12.Position + Vector3.new(0, 5, 0))

		local v3 = tick()

		task.spawn(function() --[[ Line: 268 | Upvalues: MatteoHatProjectile (copy), p2 (copy), v2 (ref), applyMatteoMutation (ref), v3 (copy) ]]
			repeat
				if not (MatteoHatProjectile and (MatteoHatProjectile.Parent and (p2 and (p2.Parent and v2)))) then
					if not (MatteoHatProjectile and MatteoHatProjectile.Parent) then
						return
					end

					MatteoHatProjectile:Destroy()

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

				local Position = MatteoHatProjectile.Position
				local v32 = v1.Position + Vector3.new(0, 3, 0) - Position

				if v32.Magnitude < 4 then
					pcall(function() --[[ Line: 294 | Upvalues: applyMatteoMutation (ref), p2 (ref) ]]
						applyMatteoMutation(p2)
					end)
					MatteoHatProjectile:Destroy()

					return
				end

				local Unit = v32.Unit
				local v4 = Position + Unit * 60 * 0.03

				MatteoHatProjectile.CFrame = CFrame.new(v4, v4 + Unit) * CFrame.Angles(-1.5707963267948966, 0, 0)
			until tick() - v3 > 5

			MatteoHatProjectile:Destroy()
		end)
	end
end

local function startShootingLoop() --[[ startShootingLoop | Line: 322 | Upvalues: v3 (ref), v2 (ref), t (ref), findAllBrainrots (copy), shootHatAtBrainrot (copy) ]]
	v3 = task.spawn(function() --[[ Line: 323 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), shootHatAtBrainrot (ref) ]]
		while v2 do
			task.wait(math.random(3, 6))

			if not v2 or #t == 0 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Matteo" then
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

			shootHatAtBrainrot(v6, v5)
		end
	end)
end

local t2 = {}

function t2.Start() --[[ Start | Line: 370 | Upvalues: t2 (copy), v2 (ref), v1 (copy), getAnimationIds (copy), v4 (ref), playAnimation (copy), t (ref), v5 (ref), v3 (ref), findAllBrainrots (copy), shootHatAtBrainrot (copy) ]]
	t2.Stop()
	v2 = true

	local Visuals = v1:FindFirstChild("Visuals")

	if not Visuals then
		warn("[Matteo] Missing Visuals template")

		return
	end

	local v12 = getAnimationIds()

	v4 = Visuals:Clone()
	v4.Name = "Matteo_Visuals"
	v4.Parent = workspace

	local Trees = v4:FindFirstChild("Trees")

	if Trees then
		for i, v in ipairs(Trees:GetChildren()) do
			if v:IsA("Model") then
				local Rig = v:FindFirstChild("Rig")

				if Rig then
					if v12 and v12.TreeIdle then
						playAnimation(Rig, v12.TreeIdle, true)
					end

					table.insert(t, v)
				end
			end
		end
	end

	local Matteo = v4:FindFirstChild("Matteo")

	if Matteo and (v12 and v12.MatteoIdle) then
		playAnimation(Matteo, v12.MatteoIdle, true)
	end

	local Sound = v1:FindFirstChild("Sound")

	if Sound and Sound:IsA("Sound") then
		v5 = Sound:Clone()
		v5.Name = "Matteo_EventSound"
		v5.Parent = workspace
		v5:Play()
		print("[Matteo] Event audio started playing")
	else
		v5 = Instance.new("Sound")
		v5.Name = "Matteo_EventSound"
		v5.SoundId = "rbxassetid://0"
		v5.Volume = 1
		v5.Looped = true
		v5.Parent = workspace
		warn("[Matteo] No Sound found in event folder - created placeholder. Please add a Sound object to: ReplicatedStorage.Events.Event.Matteo")
	end

	v3 = task.spawn(function() --[[ Line: 323 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), shootHatAtBrainrot (ref) ]]
		while v2 do
			task.wait(math.random(3, 6))

			if not v2 or #t == 0 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Matteo" then
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

			shootHatAtBrainrot(v6, v5)
		end
	end)
	print("[Matteo] Event started with " .. #t .. " trees - hats will apply Matteo mutation on hit")
end
function t2.Stop() --[[ Stop | Line: 436 | Upvalues: v2 (ref), v3 (ref), v5 (ref), v4 (ref), t (ref) ]]
	v2 = false

	if v3 then
		task.cancel(v3)
		v3 = nil
	end

	if v5 then
		v5:Stop()
		v5:Destroy()
		v5 = nil
		print("[Matteo] Event audio stopped")
	end

	for i, v in ipairs(workspace:GetChildren()) do
		if v.Name == "MatteoHatProjectile" then
			v:Destroy()
		end
	end

	if v4 and v4.Parent then
		v4:Destroy()
	end

	v4 = nil
	t = {}
	print("[Matteo] Event stopped")
end
function t2.Shoot(p1) --[[ Shoot | Line: 473 | Upvalues: v2 (ref), t (ref), shootHatAtBrainrot (copy) ]]
	if not v2 or #t == 0 then
		return
	end

	local v1 = t[math.random(1, #t)]

	if v1 and v1.Parent then
		shootHatAtBrainrot(v1, p1)
	end
end
function t2.ApplyVFX(p1) --[[ ApplyVFX | Line: 483 | Upvalues: ReplicatedStorage (copy), t2 (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Matteo = Mutations:FindFirstChild("Matteo")

			v1 = if Matteo then Matteo:FindFirstChild("Matteo") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if v1 then
		local ok, result = pcall(function() --[[ Line: 487 | Upvalues: v1 (copy) ]]
			return require(v1)
		end)

		if ok and (result and result.ApplyVFX) then
			result.ApplyVFX(p1)
		end
	end

	t2.Shoot(p1)
end
function t2.RemoveVFX(p1) --[[ RemoveVFX | Line: 500 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Matteo = Mutations:FindFirstChild("Matteo")

			v1 = if Matteo then Matteo:FindFirstChild("Matteo") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 503 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if not (ok and (result and result.RemoveVFX)) then
		return
	end

	result.RemoveVFX(p1)
end
function t2.HatFly(p1) --[[ HatFly | Line: 513 | Upvalues: t2 (copy) ]]
	t2.Shoot(p1)
end

return t2