-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local v1 = Instance.new("BindableEvent")
local t = {}
local t2 = {
	ResizeParticlesByFactor = function(p1, p2) --[[ ResizeParticlesByFactor | Line: 10 ]]
		if not p1 then
			return
		end

		local v1 = p2 or 1

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local t = {}

				for k2, v2 in pairs(v.Size.Keypoints) do
					table.insert(t, NumberSequenceKeypoint.new(v2.Time, v2.Value * v1, v2.Envelope * v1))
				end

				v.Size = NumberSequence.new(t)
			end
		end
	end,
	EmitParticles = function(p1) --[[ EmitParticles | Line: 33 ]]
		if not p1 then
			return
		end

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local v1 = v:GetAttribute("EmitCount")
				local v2 = v:GetAttribute("EmitDelay")

				if v2 then
					task.delay(v2, function() --[[ Line: 42 | Upvalues: v (copy), v1 (copy) ]]
						v:Emit(v1 or 0)
					end)

					continue
				end

				if v1 then
					v:Emit(v1)
				end
			end
		end

		return true
	end,
	EmitParticlesAndExecute = function(p1, p2) --[[ EmitParticlesAndExecute | Line: 53 ]]
		if not p1 then
			return
		end

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local v1 = v:GetAttribute("EmitCount")
				local v2 = v:GetAttribute("EmitDelay")

				if v2 then
					task.delay(v2, function() --[[ Line: 62 | Upvalues: v (copy), v1 (copy), p2 (copy) ]]
						v:Emit(v1 or 0)

						if not p2 then
							return
						end

						task.defer(p2, v)
					end)

					continue
				end

				if v1 then
					v:Emit(v1)

					if p2 then
						task.defer(p2, v)
					end
				end
			end
		end

		return true
	end,
	ValidateBeforeEmitParticles = function(p1, p2) --[[ ValidateBeforeEmitParticles | Line: 79 ]]
		if not (p1 and p2) then
			return
		end

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") and p2(v) then
				local v1 = v:GetAttribute("EmitCount")
				local v2 = v:GetAttribute("EmitDelay")

				if v2 then
					task.delay(v2, function() --[[ Line: 88 | Upvalues: v (copy), v1 (copy) ]]
						v:Emit(v1 or 0)
					end)

					continue
				end

				if v1 then
					v:Emit(v1)
				end
			end
		end

		return true
	end,
	SetParticleEnabled = function(p1, p2) --[[ SetParticleEnabled | Line: 99 ]]
		if not p1 then
			return
		end

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = p2
			end
		end

		return true
	end,
	CFrameLookAt = function(p1, p2) --[[ CFrameLookAt | Line: 111 ]]
		local Unit = (p2 - p1).Unit

		if Unit ~= Unit then
			Unit = Vector3.new(0, 0, -1)
		end

		local v1 = -Unit
		local v2 = v1:Cross(Vector3.new(0, -1, 0))

		return CFrame.fromMatrix(p1, v2, v1:Cross(v2), v1)
	end,
	DeferredTask = function(p1) --[[ DeferredTask | Line: 122 ]]
		local t = {}
		local t2 = {}
		local v1 = "Processing"
		local v2 = nil

		function t.AndThen(p1, p2) --[[ Line: 127 | Upvalues: v1 (ref), t2 (copy), v2 (ref), t (copy) ]]
			if v1 == "Processing" then
				table.insert(t2, p2)
			else
				p2(table.unpack(v2 or {}))
			end

			return t
		end

		local function resolve(...) --[[ resolve | Line: 135 | Upvalues: v2 (ref), v1 (ref), t2 (copy) ]]
			v2 = { ... }
			v1 = "Resolved"

			for k, v in pairs(t2) do
				v(table.unpack(v2))
			end
		end

		coroutine.wrap(function() --[[ Line: 142 | Upvalues: p1 (copy), resolve (copy) ]]
			pcall(p1, resolve)
		end)()

		return t
	end
}

function t2.Trajectory(p1, p2, p3) --[[ Trajectory | Line: 148 | Upvalues: t2 (copy) ]]
	local Gravity = workspace.Gravity
	local v1 = p2 - p1
	local v2 = Vector3.new(v1.X, 0, v1.Z)
	local Magnitude = v2.Magnitude
	local v3 = math.rad(p3)
	local v5 = math.cos(v3) ^ 2 * 2 * (Magnitude * math.tan(v3) - v1.Y)

	if v5 <= 0 then
		return t2.TimedTrajectory(p1, p2, 1)
	end

	local v6 = math.sqrt(Gravity * Magnitude ^ 2 / v5)

	if v6 == v6 then
		local v7 = v2.Unit * v6 * math.cos(v3)

		return v7 + Vector3.new(0, v6 * math.sin(v3), 0)
	end
end
function t2.TimedTrajectory(p1, p2, p3) --[[ TimedTrajectory | Line: 172 ]]
	local Gravity = workspace.Gravity
	local v1 = p2 - p1
	local v2 = Vector3.new(v1.X, 0, v1.Z)

	return v2 / p3 + Vector3.new(0, (v1.Y + 0.5 * Gravity * p3 ^ 2) / p3, 0)
end
function t2.Dust(p1, p2, p3) --[[ Dust | Line: 180 | Upvalues: v1 (copy) ]]
	if not p2 then
		return
	end

	local v12 = p3 or 1

	if typeof(v12) == "number" and not (v12 <= 0) then
		v1:Fire(p2, v12)
	end
end
function t2.GetMobCenterPosition(p1) --[[ GetMobCenterPosition | Line: 191 ]]
	local Monster = workspace:FindFirstChild("Monster")

	if not Monster then
		return nil
	end

	local count = 0
	local sum = Vector3.new(0, 0, 0)

	for i, v in ipairs(Monster:GetChildren()) do
		if v:IsA("Folder") then
			for i2, v2 in ipairs(v:GetChildren()) do
				if v2:IsA("Model") and (v2.Name == p1 and v2.PrimaryPart) then
					sum = sum + v2.PrimaryPart.Position
					count = count + 1
				end
			end
		end
	end

	if count == 0 then
		return nil
	end

	return sum / count
end
function t2.KillThread(p1) --[[ KillThread | Line: 215 | Upvalues: t (copy) ]]
	if typeof(p1) == "table" then
		for i, v in ipairs(p1) do
			local v1 = t[v]

			if v1 then
				v1._Dead = true
				t[v] = nil
			end
		end
	else
		local v2 = t[p1]

		if not v2 then
			return
		end

		v2._Dead = true
		t[p1] = nil
	end
end
v1.Event:Connect(function(p1, p2) --[[ Line: 235 | Upvalues: t2 (copy), t (copy) ]]
	t2.KillThread(p1)

	local t3 = {}

	if typeof(p1) == "table" then
		for i, v in ipairs(p1) do
			t3[v] = {
				_Dead = false
			}
			t[v] = t3[v]
		end
	else
		t3[p1] = {
			_Dead = false
		}
		t[p1] = t3[p1]
	end

	task.delay(p2, function() --[[ Line: 247 | Upvalues: p1 (copy), t3 (copy), t2 (ref) ]]
		if typeof(p1) == "table" then
			for i, v in ipairs(p1) do
				local v2 = t3[v]

				if v2 and not v2._Dead then
					if v and v:IsDescendantOf(game) then
						v:Destroy()
					end

					t2.KillThread(v)
				end
			end
		else
			local v3 = t3[p1]

			if not v3 or v3._Dead then
				return
			end

			if not (p1 and p1:IsDescendantOf(game)) then
				t2.KillThread(p1)
				table.clear(t3)

				return
			end

			p1:Destroy()
			t2.KillThread(p1)
		end

		table.clear(t3)
	end)
end)
function t2.PlayOneShotAnim(p1, p2, p3, p4) --[[ PlayOneShotAnim | Line: 276 ]]
	local v1 = p1:LoadAnimation(p2)

	if p4 then
		v1:AdjustSpeed(p4)
	end

	v1:Play(p3 or 0)

	local v2 = nil

	v2 = v1.Stopped:Once(function() --[[ Line: 283 | Upvalues: v1 (copy), v2 (ref) ]]
		v1:Destroy()

		if not v2 then
			return
		end

		v2:Disconnect()
		v2 = nil
	end)

	return v1
end
function t2.RandomUniqueId() --[[ RandomUniqueId | Line: 293 | Upvalues: HttpService (copy) ]]
	return HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 15):gsub(".", function(p1) --[[ Line: 295 ]]
		return math.random() < 0.5 and string.upper(p1) or p1
	end)
end
function t2.LerpCF(p1, p2, p3) --[[ LerpCF | Line: 301 | Upvalues: RunService (copy), TweenService (copy) ]]
	local v1 = p1.CFrame
	local v2 = 0
	local v3 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 304 | Upvalues: v2 (ref), p2 (copy), TweenService (ref), p1 (copy), v1 (copy), p3 (copy) ]]
		v2 = math.min(v2 + p12 / p2.Time, 1)
		p1.CFrame = v1:Lerp(p3, (TweenService:GetValue(v2, p2.EasingStyle or Enum.EasingStyle.Linear, p2.EasingDirection or Enum.EasingDirection.InOut)))
	end)

	task.delay(p2.Time + 0.001, function() --[[ Line: 313 | Upvalues: v3 (ref) ]]
		v3:Disconnect()
		v3 = nil
	end)
end

return t2