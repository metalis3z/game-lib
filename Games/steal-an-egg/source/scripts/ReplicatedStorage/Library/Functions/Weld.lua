-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Create = function(p1, p2, p3) --[[ Create | Line: 5 ]]
		if p1.Anchored or p2.Anchored then
			local Motor6D = Instance.new("Motor6D")

			Motor6D.Part0 = p1
			Motor6D.Part1 = p2
			Motor6D.C0 = p1.CFrame:Inverse() * p2.CFrame
			Motor6D.Parent = p1

			return Motor6D
		end

		if p3 then
			local ManualWeld = Instance.new("ManualWeld")

			ManualWeld.Part0 = p1
			ManualWeld.Part1 = p2
			ManualWeld.C0 = p1.CFrame:Inverse() * p2.CFrame
			ManualWeld.Parent = p1

			return ManualWeld
		end

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p1
		WeldConstraint.Part1 = p2
		WeldConstraint.Parent = p1

		return WeldConstraint
	end,
	SetC0 = function(p1, p2) --[[ SetC0 | Line: 35 ]]
		local _ = p1:IsA("ManualWeld")

		p1.C0 = p2
	end
}

return setmetatable(t, {
	__call = function(p1, ...) --[[ __call | Line: 45 | Upvalues: t (copy) ]]
		return t.Create(...)
	end
})