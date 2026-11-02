-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

function t.IsObjectA(p1, p2) --[[ IsObjectA | Line: 9 ]]
	if typeof(p2) ~= "string" then
		return warn("Invalid type for argument 2. String expected, got : ", (typeof(p2)))
	end

	return if typeof(p1) == "Instance" then p1:IsA(p2) else false
end
function t.PlaySound(p1, p2, p3, p4, p5) --[[ PlaySound | Line: 16 | Upvalues: t (copy), Trove (copy), Debris (copy) ]]
	local v1 = t.IsObjectA(p1, "Folder") and p1:GetChildren() or p1

	if typeof(v1) == "table" then
		local v2 = Trove.new()

		for v3, v4 in v1 do
			local v5 = t.PlaySound(v4, p2, p3, p4, p5)

			if v5 then
				v2:Add(v5)
			end
		end

		return v2
	end

	if not t.IsObjectA(v1, "Sound") then
		return
	end

	local v6

	if v1:GetAttribute("__unprotected") and v1 then
		v6 = v1
	else
		v6 = v1
		v1 = v6:Clone()
	end

	local TimeLength = v6.TimeLength

	if t.IsObjectA(p2, "BasePart") and not p5 then
		p2.Transparency = 1
		p2.Anchored = true
		p2.CanCollide = false
		p2.CanQuery = false
		p2.CanTouch = false
	end

	v1.Volume = if p3 then p3 else v1.Volume
	v1.Parent = if p2 then p2 else workspace
	v1:Play()

	if not p4 then
		Debris:AddItem(v1, TimeLength + 10)
	end

	return v1
end
function t.Emit_Cellular(p1, p2) --[[ Emit_Cellular | Line: 55 ]]
	local v1 = if typeof(p2) == "table" and p2 then p2 else {}
	local v2 = if typeof(p1) == "Instance" then p1:GetAttribute("EmitCount") else false

	if not (v1.Skip_Check or p1:IsA("ParticleEmitter")) then
		return
	end

	local v3

	if typeof(v2) == "number" then
		v3, v2 = v1, v2 * (if Is_Mobile then 0.5 else 1)
	else
		v3 = v1
	end

	if not v3.Protected then
		p1:Emit(v2)
	end

	return v2
end
function t.EmitVfx(p1, p2, p3) --[[ EmitVfx | Line: 74 | Upvalues: t (copy), Debris (copy) ]]
	if typeof(p1) ~= "Instance" then
		return
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("ParticleEmitter") then
			if p2 == nil then
				t.Emit_Cellular(v2, {
					Skip_Check = true
				})

				continue
			end

			v2.Enabled = p2
		end
	end

	if not p3 then
		return
	end

	local v4 = p1:GetAttribute("Destroy_Delay")
	local v5

	if v4 then
		v5 = p1
	elseif typeof(p3) == "number" and p3 then
		v5 = p1
		v4 = p3
	else
		v5 = p1
		v4 = 10
	end

	Debris:AddItem(v5, v4)
end

return t