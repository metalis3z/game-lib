local t = {
	Weld = function(p1, p2, p3) --[[ Weld | Line: 3 ]]
		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Name = p1.Name .. "Weld"
		p1.CFrame = if p3 then p3 else p1.CFrame
		WeldConstraint.Part1 = p1
		WeldConstraint.Part0 = p2

		local v2 = CFrame.new(p1.Position)
		local _ = p1.CFrame:inverse() * v2
		local _2 = p2.CFrame:inverse() * v2

		WeldConstraint.Parent = WeldConstraint.Part1

		return WeldConstraint
	end,
	WeldModel = function(p1, p2, p3) --[[ WeldModel | Line: 19 ]]
		local v1 = if p3 then p3 else p1.PrimaryPart

		for k, v in pairs(p1:GetChildren()) do
			if v:IsA("BasePart") and v ~= v1 then
				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = v
				WeldConstraint.Part1 = v1
				WeldConstraint.Parent = WeldConstraint.Part0
				v.Anchored = false
			end
		end
	end
}

function t.WeldModelToPrimary(p1, p2) --[[ WeldModelToPrimary | Line: 36 | Upvalues: t (copy) ]]
	local v2 = if p2 then p2 else p1.PrimaryPart

	for k, v in pairs(p1:GetChildren()) do
		if v:IsA("BasePart") and v ~= v2 then
			v.CanCollide = false
			v.Massless = true
			v.Anchored = false
			t.Weld(v, v2, v.CFrame)

			continue
		end

		v:IsA("Model")
	end
end

return t