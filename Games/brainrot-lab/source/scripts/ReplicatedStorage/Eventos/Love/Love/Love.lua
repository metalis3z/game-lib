-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local EventConfig = require(ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("EventConfig"))
local v1 = script.Parent
local v2 = nil
local v3 = false
local v4 = nil

local function getMutationModule() --[[ getMutationModule | Line: 27 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")

	if not Events then
		return nil
	end

	local Mutations = Events:FindFirstChild("Mutations")

	if not Mutations then
		return nil
	end

	local Love = Mutations:FindFirstChild("Love")

	if Love then
		return Love:FindFirstChild("Love")
	end

	return nil
end

local function getEventConfig() --[[ getEventConfig | Line: 38 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 39 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)

	if not ok then
		return nil
	end

	return result.Events and result.Events.Love
end

local function findAllBrainrots() --[[ findAllBrainrots | Line: 51 ]]
	local t = {}

	for i, v in ipairs(workspace:GetChildren()) do
		if v:IsA("Model") and v:GetAttribute("BrainrotName") then
			table.insert(t, v)
		end
	end

	return t
end

local function syncToSlot(p1, p2, p3) --[[ syncToSlot | Line: 68 ]]
	p1:SetAttribute(p2, p3)

	local v1 = p1.Parent

	if not (v1 and v1:GetAttribute("Earn")) then
		return
	end

	v1:SetAttribute(p2, p3)
end

local function applyLoveMutation(p1) --[[ applyLoveMutation | Line: 77 | Upvalues: ReplicatedStorage (copy), EventConfig (copy), v1 (copy) ]]
	local list = {}

	for v2 in string.gmatch(p1:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, v2)

		if v2 == "Love" then
			return
		end
	end

	local ok, result = pcall(function() --[[ Line: 39 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)
	local v3 = if ok then result.Events and result.Events.Love else nil

	if not v3 then
		warn("[Love] Could not load EventConfig for Love")

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

	table.insert(list, "Love")

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
		p1:SetAttribute("Mutation", "Love")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = p1:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Love")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Love"
			end
		end
	end

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v122

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Love = Mutations:FindFirstChild("Love")

			v122 = if Love then Love:FindFirstChild("Love") else nil
		else
			v122 = nil
		end
	else
		v122 = nil
	end

	if v122 then
		local ok2, result2 = pcall(function() --[[ Line: 126 | Upvalues: v122 (copy) ]]
			return require(v122)
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

	EventHighlight.FillColor = Color3.fromRGB(255, 100, 150)
	EventHighlight.OutlineColor = Color3.fromRGB(255, 150, 180)

	local JudgmentExplosion = v1:FindFirstChild("JudgmentExplosion")

	if JudgmentExplosion then
		local v14 = JudgmentExplosion:Clone()

		v14.Anchored = true
		v14.CanCollide = false
		v14.Parent = workspace

		local Position = p1:GetPivot().Position

		v14.CFrame = CFrame.new(Position)

		for i, v in ipairs(v14:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(30)
			end
		end

		task.delay(3, function() --[[ Line: 221 | Upvalues: v14 (copy) ]]
			if not (v14 and v14.Parent) then
				return
			end

			v14:Destroy()
		end)
	else
		local Position = p1:GetPivot().Position
		local Attachment = Instance.new("Attachment")

		Attachment.Position = Position
		Attachment.Parent = workspace.Terrain

		local ParticleEmitter = Instance.new("ParticleEmitter")

		ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 100, 150))
		ParticleEmitter.Size = NumberSequence.new(0.5, 0)
		ParticleEmitter.Lifetime = NumberRange.new(0.5, 1)
		ParticleEmitter.Rate = 100
		ParticleEmitter.Speed = NumberRange.new(10, 20)
		ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
		ParticleEmitter.Parent = Attachment
		ParticleEmitter:Emit(50)
		task.delay(2, function() --[[ Line: 243 | Upvalues: ParticleEmitter (copy), Attachment (copy) ]]
			ParticleEmitter.Enabled = false
			task.wait(1)

			if not (Attachment and Attachment.Parent) then
				return
			end

			Attachment:Destroy()
		end)
	end

	print("[Love] Applied Love mutation to " .. p1.Name .. " (" .. (v3.Multiplier or 3.5) .. "x multiplier)")
end

local function shootMiniHeartAtBrainrot(p1) --[[ shootMiniHeartAtBrainrot | Line: 258 | Upvalues: v1 (copy), v2 (ref), v3 (ref), applyLoveMutation (copy) ]]
	local JudgmentProjetctile = v1:FindFirstChild("JudgmentProjetctile")

	if not JudgmentProjetctile then
		return
	end

	if not (v2 and v2.Parent) then
		return
	end

	local LoveMiniHeartProjectile = JudgmentProjetctile:Clone()

	LoveMiniHeartProjectile.Name = "LoveMiniHeartProjectile"
	LoveMiniHeartProjectile.Anchored = true
	LoveMiniHeartProjectile.CanCollide = false
	LoveMiniHeartProjectile.Transparency = 0
	LoveMiniHeartProjectile.Parent = workspace
	LoveMiniHeartProjectile.CFrame = CFrame.new(v2.Position)

	for i, v in ipairs(LoveMiniHeartProjectile:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = true
		end
	end

	local v12 = tick()

	task.spawn(function() --[[ Line: 283 | Upvalues: LoveMiniHeartProjectile (copy), p1 (copy), v3 (ref), applyLoveMutation (ref), v12 (copy) ]]
		repeat
			if not (LoveMiniHeartProjectile and (LoveMiniHeartProjectile.Parent and (p1 and (p1.Parent and v3)))) then
				if not (LoveMiniHeartProjectile and LoveMiniHeartProjectile.Parent) then
					return
				end

				LoveMiniHeartProjectile:Destroy()

				return
			end

			task.wait()

			local v1 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart

			if not v1 then
				for i, v in ipairs(p1:GetDescendants()) do
					if v:IsA("BasePart") then
						v1 = v

						break
					end
				end
			end

			if not v1 then
				break
			end

			local Position2 = LoveMiniHeartProjectile.Position
			local v2 = v1.Position - Position2

			if v2.Magnitude < 4 then
				applyLoveMutation(p1)
				LoveMiniHeartProjectile:Destroy()

				return
			end

			local Unit = v2.Unit
			local v5 = Position2 + Unit * 40 * 0.03 + Vector3.new(0, math.sin((tick() - v12) * 3) * 2 * 0.01, 0)

			LoveMiniHeartProjectile.CFrame = CFrame.new(v5, v5 + Unit)
		until tick() - v12 > 6

		LoveMiniHeartProjectile:Destroy()
	end)
end

local function findHeartPosition() --[[ findHeartPosition | Line: 338 | Upvalues: findAllBrainrots (copy) ]]
	local v1 = findAllBrainrots()

	if not (#v1 > 0) then
		return Vector3.new(0, 50, 0)
	end

	local sum = 0
	local sum2 = 0

	for i, v in ipairs(v1) do
		local Position = v:GetPivot().Position

		sum = sum + Position.X
		sum2 = sum2 + Position.Z
	end

	return Vector3.new(sum / #v1, 50, sum2 / #v1)
end

local function spawnGiantHeart() --[[ spawnGiantHeart | Line: 356 | Upvalues: v1 (copy), v2 (ref), findHeartPosition (copy), v3 (ref) ]]
	local JudgmentHeart = v1:FindFirstChild("JudgmentHeart")

	if not JudgmentHeart then
		warn("[Love] JudgmentHeart template not found")

		return
	end

	v2 = JudgmentHeart:Clone()
	v2.Name = "LoveGiantHeart"
	v2.Anchored = true
	v2.CanCollide = false
	v2.Transparency = 0
	v2.Parent = workspace

	local v12 = findHeartPosition()

	v2.CFrame = CFrame.new(v12)
	v2.Size = JudgmentHeart.Size * 8

	local Outline = v2:FindFirstChild("Outline")

	if Outline then
		Outline.Size = Outline.Size * 8
	end

	for i, v in ipairs(v2:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = true
		end
	end

	task.spawn(function() --[[ Line: 391 | Upvalues: v2 (ref), v3 (ref), v12 (copy) ]]
		while v2 and (v2.Parent and v3) do
			local Y = v12.Y
			local v22 = math.sin(tick() * 0.5) * 3
			local v4 = math.sin(tick() * 0.3) * 5

			if v2 and v2.Parent then
				v2.CFrame = CFrame.new(v12.X, Y + v22, v12.Z) * CFrame.Angles(0, math.rad(v4), 0)
			end

			task.wait(0.05)
		end
	end)
	task.spawn(function() --[[ Line: 406 | Upvalues: v2 (ref), v3 (ref) ]]
		while v2 and (v2.Parent and v3) do
			local v22 = math.sin(tick() * 2) * 0.3 + 0.7

			for i, v in ipairs(v2:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.Rate = math.floor(v22 * 20)
				end
			end

			task.wait(0.1)
		end
	end)
	print("[Love] Giant heart spawned at " .. tostring(v12))
end

local function startHeartLoop() --[[ startHeartLoop | Line: 423 | Upvalues: v4 (ref), v3 (ref), findAllBrainrots (copy), shootMiniHeartAtBrainrot (copy) ]]
	v4 = task.spawn(function() --[[ Line: 424 | Upvalues: v3 (ref), findAllBrainrots (ref), shootMiniHeartAtBrainrot (ref) ]]
		while v3 do
			task.wait(math.random(2, 4))

			if not v3 then
				break
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v32 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Love" then
						v32 = true

						break
					end
				end

				if not v32 then
					table.insert(t2, v)
				end
			end

			if #t2 == 0 then
				continue
			end

			shootMiniHeartAtBrainrot(t2[math.random(1, #t2)])
		end
	end)
end

local t = {}

function t.Start() --[[ Start | Line: 463 | Upvalues: t (copy), v3 (ref), spawnGiantHeart (copy), v4 (ref), findAllBrainrots (copy), shootMiniHeartAtBrainrot (copy) ]]
	t.Stop()
	v3 = true
	spawnGiantHeart()
	v4 = task.spawn(function() --[[ Line: 424 | Upvalues: v3 (ref), findAllBrainrots (ref), shootMiniHeartAtBrainrot (ref) ]]
		while v3 do
			task.wait(math.random(2, 4))

			if not v3 then
				break
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v32 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "Love" then
						v32 = true

						break
					end
				end

				if not v32 then
					table.insert(t2, v)
				end
			end

			if #t2 == 0 then
				continue
			end

			shootMiniHeartAtBrainrot(t2[math.random(1, #t2)])
		end
	end)
	print("[Love] Event started - giant heart spawned, mini hearts will apply Love mutation on hit")
end
function t.Stop() --[[ Stop | Line: 476 | Upvalues: v3 (ref), v4 (ref), v2 (ref) ]]
	v3 = false

	if v4 then
		task.cancel(v4)
		v4 = nil
	end

	if v2 and v2.Parent then
		v2:Destroy()
	end

	v2 = nil

	for i, v in ipairs(workspace:GetChildren()) do
		if v.Name == "LoveMiniHeartProjectile" then
			v:Destroy()
		end
	end

	print("[Love] Event stopped")
end
function t.Shoot(p1) --[[ Shoot | Line: 502 | Upvalues: v3 (ref), shootMiniHeartAtBrainrot (copy) ]]
	if v3 then
		shootMiniHeartAtBrainrot(p1)
	end
end
function t.ApplyVFX(p1) --[[ ApplyVFX | Line: 508 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Love = Mutations:FindFirstChild("Love")

			v1 = if Love then Love:FindFirstChild("Love") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 511 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if not (ok and (result and result.ApplyVFX)) then
		return
	end

	result.ApplyVFX(p1)
end
function t.RemoveVFX(p1) --[[ RemoveVFX | Line: 521 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Love = Mutations:FindFirstChild("Love")

			v1 = if Love then Love:FindFirstChild("Love") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 524 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if not (ok and (result and result.RemoveVFX)) then
		return
	end

	result.RemoveVFX(p1)
end

return t