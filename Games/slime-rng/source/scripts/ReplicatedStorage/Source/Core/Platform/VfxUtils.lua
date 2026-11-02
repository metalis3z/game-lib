-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: VfxUtils, time of decompilation: Sun May  3 10:10:54 2026 ]]
local VFX = game:GetService("ReplicatedStorage").Assets.VFX
local t1 = {}
local t2 = {}

function t1.getVfx(s1: string, p1) -- line: 7
	-- upvalues: t2 (ref), VFX (copy)
	local v6 = t2[s1]

	if v6 and #v6 > 0 then
		local v7 = table.remove(v6)

		v7.Parent = p1 or workspace.CurrentCamera

		return v7
	end

	local s1_2 = VFX:FindFirstChild(s1)

	assert(s1_2, "Vfx template not found for " .. s1)

	local clone = s1_2:Clone()

	clone.Parent = p1 or workspace.CurrentCamera

	return clone
end
function t1.cacheVfx(s2: string, p2) -- line: 23
	-- upvalues: t2 (ref)
	p2.Parent = nil

	if t2[s2] then
		table.insert(t2[s2], p2)

		return
	end

	t2[s2] = { p2 }
end
function t1.emitAllAtPosition(s3: string, vector3: Vector3, b1: boolean?) -- line: 32
	-- upvalues: t1 (copy)
	local v15 = t1.getVfx(s3)

	v15.Position = vector3

	if b1 == nil then
		b1 = true
	end

	local n1 = 0

	for _, v18 in v15:GetDescendants() do
		if b1 and v18:IsA("Sound") then
			v18:Play()
		elseif v18:IsA("ParticleEmitter") then
			v18:Emit(v18:GetAttribute("EmitCount") or 1)

			local Max = v18.Lifetime.Max

			if n1 < Max then
				n1 = Max
			end
		end
	end

	task.delay(n1, function() -- line: 52
		-- upvalues: t1 (copy), s3 (copy), v15 (copy)
		t1.cacheVfx(s3, v15)
	end)
end
function t1.clearCache() -- line: 57
	-- upvalues: t2 (ref)
	for _, v in pairs(t2) do
		for _, v2 in ipairs(v) do
			v2:Destroy()
		end
	end

	t2 = {}
end

task.spawn(function() -- line: 66
	-- upvalues: t1 (copy)
	while true do
		task.wait(5)
		t1.clearCache()
	end
end)

return t1
