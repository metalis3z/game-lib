-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local EventConfig = require(ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("EventConfig"))
local v1 = script.Parent
local v2 = false
local v3 = nil
local v4 = nil
local t = {}

local function getMutationModule() --[[ getMutationModule | Line: 28 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")

	if not Events then
		return nil
	end

	local Mutations = Events:FindFirstChild("Mutations")

	if not Mutations then
		return nil
	end

	local Acid = Mutations:FindFirstChild("Acid")

	if Acid then
		return Acid:FindFirstChild("Acid")
	end

	return nil
end

local function getEventConfig() --[[ getEventConfig | Line: 39 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 40 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)

	if not ok then
		return nil
	end

	return result.Events and result.Events.AcidStorm
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

local function applyAcidStormMutation(p1) --[[ applyAcidStormMutation | Line: 77 | Upvalues: ReplicatedStorage (copy), EventConfig (copy) ]]
	local list = {}

	for v2 in string.gmatch(p1:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, v2)

		if v2 == "AcidStorm" then
			return
		end
	end

	local ok, result = pcall(function() --[[ Line: 40 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage.Shared.EventConfig)
	end)
	local v3 = if ok then result.Events and result.Events.AcidStorm else nil

	if not v3 then
		warn("[AcidStorm] Could not load EventConfig for AcidStorm")

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

	table.insert(list, "AcidStorm")

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
		p1:SetAttribute("Mutation", "Acid")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = p1:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Acid")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Acid"
			end
		end
	end

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v12

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Acid = Mutations:FindFirstChild("Acid")

			v12 = if Acid then Acid:FindFirstChild("Acid") else nil
		else
			v12 = nil
		end
	else
		v12 = nil
	end

	if v12 then
		local ok2, result2 = pcall(function() --[[ Line: 126 | Upvalues: v12 (copy) ]]
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
	EventHighlight.OutlineColor = Color3.fromRGB(150, 255, 150)

	local Position = p1:GetPivot().Position
	local Attachment = Instance.new("Attachment")

	Attachment.Position = Position
	Attachment.Parent = workspace.Terrain

	local ParticleEmitter = Instance.new("ParticleEmitter")

	ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(100, 255, 100))
	ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0) })
	ParticleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
	ParticleEmitter.Rate = 100
	ParticleEmitter.Speed = NumberRange.new(8, 15)
	ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
	ParticleEmitter.Parent = Attachment
	ParticleEmitter:Emit(40)
	task.delay(2, function() --[[ Line: 165 | Upvalues: ParticleEmitter (copy), Attachment (copy) ]]
		ParticleEmitter.Enabled = false
		task.wait(1)

		if not (Attachment and Attachment.Parent) then
			return
		end

		Attachment:Destroy()
	end)
	print("[AcidStorm] Applied Acid mutation to " .. p1.Name .. " (" .. (v3.Multiplier or 3.5) .. "x multiplier)")
end

local function createAcidDrop(p1) --[[ createAcidDrop | Line: 179 | Upvalues: t (ref), v2 (ref), applyAcidStormMutation (copy) ]]
	if not (p1 and p1.Parent) then
		return
	end

	local v1 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart

	if not v1 then
		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") then
				v1 = v

				break
			end
		end
	end

	if v1 then
		local Position = v1.Position
		local AcidRainDrop = Instance.new("Part")

		AcidRainDrop.Name = "AcidRainDrop"
		AcidRainDrop.Shape = Enum.PartType.Ball
		AcidRainDrop.Size = Vector3.new(0.6, 0.6, 0.6)
		AcidRainDrop.Color = Color3.fromRGB(100, 255, 100)
		AcidRainDrop.Material = Enum.Material.Neon
		AcidRainDrop.Anchored = true
		AcidRainDrop.CanCollide = false
		AcidRainDrop.CastShadow = false
		AcidRainDrop.Parent = workspace

		local ParticleEmitter = Instance.new("ParticleEmitter")

		ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(100, 255, 100))
		ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
		ParticleEmitter.Lifetime = NumberRange.new(0.2, 0.4)
		ParticleEmitter.Rate = 30
		ParticleEmitter.Speed = NumberRange.new(0, 1)
		ParticleEmitter.SpreadAngle = Vector2.new(20, 20)
		ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1) })
		ParticleEmitter.LightEmission = 1
		ParticleEmitter.Parent = AcidRainDrop
		AcidRainDrop.CFrame = CFrame.new((Vector3.new(Position.X, Position.Y + 120, Position.Z)))

		local v4 = tick()

		table.insert(t, AcidRainDrop)
		task.spawn(function() --[[ Line: 236 | Upvalues: AcidRainDrop (copy), p1 (copy), v2 (ref), applyAcidStormMutation (ref), v4 (copy) ]]
			repeat
				local v1, v22

				if not (AcidRainDrop and (AcidRainDrop.Parent and (p1 and (p1.Parent and v2)))) then
					if not (AcidRainDrop and AcidRainDrop.Parent) then
						return
					end

					AcidRainDrop:Destroy()

					return
				end

				task.wait()

				local v3 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart

				if not v3 then
					for i, v in ipairs(p1:GetDescendants()) do
						if v:IsA("BasePart") then
							v3 = v

							break
						end
					end
				end

				if v3 then
					v1 = AcidRainDrop.Position
					v22 = v3.Position - v1

					if v22.Magnitude < 5 then
						applyAcidStormMutation(p1)

						local Attachment = Instance.new("Attachment")

						Attachment.Position = v1
						Attachment.Parent = workspace.Terrain

						local ParticleEmitter = Instance.new("ParticleEmitter")

						ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(100, 255, 100))
						ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) })
						ParticleEmitter.Lifetime = NumberRange.new(0.3, 0.6)
						ParticleEmitter.Rate = 50
						ParticleEmitter.Speed = NumberRange.new(5, 10)
						ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
						ParticleEmitter.LightEmission = 0.8
						ParticleEmitter.Parent = Attachment
						ParticleEmitter:Emit(20)
						task.delay(1, function() --[[ Line: 280 | Upvalues: ParticleEmitter (copy), Attachment (copy) ]]
							ParticleEmitter.Enabled = false
							task.wait(0.5)

							if not (Attachment and Attachment.Parent) then
								return
							end

							Attachment:Destroy()
						end)

						if not (AcidRainDrop and AcidRainDrop.Parent) then
							return
						end

						AcidRainDrop:Destroy()

						return
					end
				else
					if not (AcidRainDrop and AcidRainDrop.Parent) then
						return
					end

					AcidRainDrop:Destroy()

					return
				end

				local Unit = v22.Unit
				local v42 = v1 + Unit * 80 * 0.03

				AcidRainDrop.CFrame = CFrame.new(v42, v42 + Unit)
			until tick() - v4 > 8

			if not (AcidRainDrop and AcidRainDrop.Parent) then
				return
			end

			AcidRainDrop:Destroy()
		end)
	end
end

local function startRainLoop() --[[ startRainLoop | Line: 313 | Upvalues: v3 (ref), v2 (ref), t (ref), findAllBrainrots (copy), createAcidDrop (copy) ]]
	v3 = task.spawn(function() --[[ Line: 314 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), createAcidDrop (ref) ]]
		while v2 do
			task.wait(math.random(2, 5))

			if not v2 then
				break
			end

			local count2 = 0

			for i = #t, 1, -1 do
				if t[i] and t[i].Parent then
					count2 = count2 + 1

					continue
				end

				table.remove(t, i)
			end

			if count2 >= 6 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "AcidStorm" then
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

			createAcidDrop(t2[math.random(1, #t2)])
		end
	end)
end

local t2 = {}

function t2.Start() --[[ Start | Line: 367 | Upvalues: t2 (copy), v2 (ref), v1 (copy), v4 (ref), v3 (ref), t (ref), findAllBrainrots (copy), createAcidDrop (copy) ]]
	t2.Stop()
	v2 = true

	local Clouds = v1:FindFirstChild("Clouds")

	if not Clouds then
		v3 = task.spawn(function() --[[ Line: 314 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), createAcidDrop (ref) ]]
			while v2 do
				task.wait(math.random(2, 5))

				if not v2 then
					break
				end

				local count2 = 0

				for i = #t, 1, -1 do
					if t[i] and t[i].Parent then
						count2 = count2 + 1

						continue
					end

					table.remove(t, i)
				end

				if count2 >= 6 then
					continue
				end

				local t2 = {}

				for i2, v in ipairs((findAllBrainrots())) do
					local v3 = false

					for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
						if v4 == "AcidStorm" then
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

				createAcidDrop(t2[math.random(1, #t2)])
			end
		end)
		print("[AcidStorm] Event started - acid rain drops will apply Acid mutation on hit")

		return
	end

	local AcidStorm_Clouds = Clouds:Clone()

	AcidStorm_Clouds.Name = "AcidStorm_Clouds"
	AcidStorm_Clouds.Parent = workspace
	v4 = AcidStorm_Clouds
	v3 = task.spawn(function() --[[ Line: 314 | Upvalues: v2 (ref), t (ref), findAllBrainrots (ref), createAcidDrop (ref) ]]
		while v2 do
			task.wait(math.random(2, 5))

			if not v2 then
				break
			end

			local count2 = 0

			for i = #t, 1, -1 do
				if t[i] and t[i].Parent then
					count2 = count2 + 1

					continue
				end

				table.remove(t, i)
			end

			if count2 >= 6 then
				continue
			end

			local t2 = {}

			for i2, v in ipairs((findAllBrainrots())) do
				local v3 = false

				for v4 in string.gmatch(v:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if v4 == "AcidStorm" then
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

			createAcidDrop(t2[math.random(1, #t2)])
		end
	end)
	print("[AcidStorm] Event started - acid rain drops will apply Acid mutation on hit")
end
function t2.Stop() --[[ Stop | Line: 386 | Upvalues: v2 (ref), v3 (ref), v4 (ref), t (ref) ]]
	v2 = false

	if v3 then
		task.cancel(v3)
		v3 = nil
	end

	if v4 and v4.Parent then
		v4:Destroy()
	end

	v4 = nil

	for i, v in ipairs(t) do
		if v and v.Parent then
			v:Destroy()
		end
	end

	t = {}

	for i, v in ipairs(workspace:GetChildren()) do
		if v.Name == "AcidRainDrop" then
			v:Destroy()
		end
	end

	print("[AcidStorm] Event stopped")
end
function t2.ApplyVFX(p1) --[[ ApplyVFX | Line: 420 | Upvalues: ReplicatedStorage (copy), v2 (ref), createAcidDrop (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Acid = Mutations:FindFirstChild("Acid")

			v1 = if Acid then Acid:FindFirstChild("Acid") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if v1 then
		local ok, result = pcall(function() --[[ Line: 424 | Upvalues: v1 (copy) ]]
			return require(v1)
		end)

		if ok and (result and result.ApplyVFX) then
			result.ApplyVFX(p1)
		end
	end

	if not v2 then
		return
	end

	createAcidDrop(p1)
end
function t2.RemoveVFX(p1) --[[ RemoveVFX | Line: 439 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local v1

	if Events then
		local Mutations = Events:FindFirstChild("Mutations")

		if Mutations then
			local Acid = Mutations:FindFirstChild("Acid")

			v1 = if Acid then Acid:FindFirstChild("Acid") else nil
		else
			v1 = nil
		end
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	local ok, result = pcall(function() --[[ Line: 442 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if not (ok and (result and result.RemoveVFX)) then
		return
	end

	result.RemoveVFX(p1)
end

return t2