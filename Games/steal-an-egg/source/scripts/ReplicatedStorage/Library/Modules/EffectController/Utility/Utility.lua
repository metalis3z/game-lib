-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace }
t.RayParams = v1
function t.AddItem(p1, p2, p3) --[[ AddItem | Line: 7 ]]
	task.delay(p3, function() --[[ Line: 8 | Upvalues: p2 (copy) ]]
		if not p2.Parent then
			return
		end

		p2:Destroy()
	end)
end
function t.PlaySound(p1, p2, p3) --[[ PlaySound | Line: 15 | Upvalues: t (copy) ]]
	local v1 = p2:Clone()

	v1.Parent = p3
	v1:Play()
	t:AddItem(v1, v1.TimeLength)

	return v1
end
function t.WeldInPlace(p1, p2, p3) --[[ WeldInPlace | Line: 23 ]]
	if p2 == p3 then
		return
	end

	local v1 = CFrame.new(p2.Position)
	local Weld = Instance.new("ManualWeld")

	Weld.Part0 = p2
	Weld.Part1 = p3
	Weld.C0 = p2.CFrame:inverse() * v1
	Weld.C1 = p3.CFrame:inverse() * v1
	Weld.Parent = p2
	Weld.Name = "Weld"

	return Weld
end
function t.CreateLockPart(p1, p2, p3, p4, p5) --[[ CreateLockPart | Line: 39 ]]
	p2:PivotTo(p3)

	local v1 = if p5 then workspace.World.ClientEffects:FindFirstChild(p5) else p5

	if not v1 then
		local v2 = script.LOCK:Clone()

		v2.Name = p5 or "LOCK"
		v2.Parent = workspace.World.Visuals
		v2.Transparency = 1
		v1 = v2
	end

	v1:PivotTo(p3)

	if p4 then
		task.delay(p4, v1.Destroy, v1)
	end

	v1.Weld.part1 = p2

	return v1
end
function t.Round(p1, p2, p3, p4) --[[ Round | Line: 57 ]]
	local v1 = p4 ^ p3

	return math.floor(p2 * v1 + 0.5) / v1
end
function t.HasProperty(p1, p2, p3) --[[ HasProperty | Line: 62 ]]
	return pcall(function() --[[ Line: 63 | Upvalues: p2 (copy), p3 (copy) ]]
		local _ = p2[p3]
	end)
end

return t