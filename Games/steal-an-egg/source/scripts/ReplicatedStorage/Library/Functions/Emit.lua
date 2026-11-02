-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CreateParticleHost = require(script.Parent.CreateParticleHost)
local AddDebris = require(script.Parent.AddDebris)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

function EmitParticles(p1, p2, ...) --[[ EmitParticles | Line: 20 | Upvalues: CreateParticleHost (copy), Asserts (copy), Constants (copy), AddDebris (copy) ]]
	local t = {}
	local v1 = 0
	local v2 = nil
	local v3

	if typeof(p1) == "Instance" then
		if p1:IsA("Model") then
			local PrimaryPart = p1.PrimaryPart

			assert(PrimaryPart, "target Model missing PrimaryPart!")
			p1 = PrimaryPart
		end

		v3 = p1
	else
		local v4, v5 = CreateParticleHost(p1)

		v2 = v4
		v3 = v5
	end

	local function processEmitter(p1) --[[ processEmitter | Line: 45 | Upvalues: p2 (copy), Asserts (ref), Constants (ref), v3 (ref), t (copy), v1 (ref), v2 (ref), AddDebris (ref) ]]
		local TimeScale = p1.TimeScale

		if not (TimeScale < 0) then
			local v12 = p1:Clone()

			v12.Enabled = false

			if p2 then
				p2(v12)
			end

			local v22 = v12:GetAttribute("EmitCount") or v12.Rate

			Asserts.number(v22)

			local v32 = v22 - math.floor(v22)
			local count = math.floor(v22)

			if v32 > 0 and math.random() < v32 then
				count = count + 1
			end

			if Constants.IS_MOBILE and count > 1 then
				count = math.max(count * 0.1, 1)
			end

			if count < 1 then
				v12:Destroy()
			else
				local v4 = v12:GetAttribute("EmitDelay") or 0

				Asserts.number(v4)

				if v4 == (1 / 0) then
					v12:Destroy()
				else
					local v5 = math.max(v4, 0)

					v12.Parent = v3
					table.insert(t, v12)

					local v7 = v12.Lifetime.Max / TimeScale

					v1 = math.max(v1, v5 + v7)

					if v5 > 0 then
						task.delay(v5, function() --[[ Line: 96 | Upvalues: v12 (ref), count (ref), v2 (ref), AddDebris (ref), v7 (copy) ]]
							v12:Emit(count)

							if v2 then
								return
							end

							AddDebris(v12, v7)
						end)
					else
						v12:Emit(count)

						if not v2 then
							AddDebris(v12, v7)
						end
					end
				end
			end
		end
	end

	local v6 = table.pack(...)

	for i = 1, v6.n do
		local v7 = v6[i]

		if type(v7) == "table" then
			for i2, v in ipairs(v7) do
				processEmitter(v)
			end

			continue
		end

		processEmitter(v7)
	end

	if v2 then
		AddDebris(v2, v1)
	end

	return t, v1
end

return EmitParticles