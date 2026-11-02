-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	ShallowCopy = function(p1) --[[ ShallowCopy | Line: 3 ]]
		local t = {}

		for k, v in pairs(p1) do
			t[k] = v
		end

		return t
	end,
	Lerp = function(p1, p2, p3) --[[ Lerp | Line: 13 ]]
		return p1 + (p2 - p1) * p3
	end,
	GetRotationBetween = function(p1, p2, p3) --[[ GetRotationBetween | Line: 17 ]]
		local v1 = p1:Dot(p2)
		local v2 = p1:Cross(p2)

		if v1 < -0.99999 then
			return CFrame.fromAxisAngle(p3, math.pi)
		end

		return CFrame.new(0, 0, 0, v2.X, v2.Y, v2.Z, 1 + v1)
	end,
	GetHierarchyLength = function(p1, p2) --[[ GetHierarchyLength | Line: 27 ]]
		if p1 == p2 then
			warn("Child and Root are the same Instance!")

			return
		end

		if p1 == nil then
			warn("Child is nil!")

			return
		end

		local count, v1 = 0, p1

		repeat
			count = count + 1
			v1 = v1.Parent
		until v1 == p2

		return count
	end,
	WaitForChildOfClass = function(p1, p2, p3) --[[ WaitForChildOfClass | Line: 49 ]]
		local v1 = os.clock()

		repeat
			task.wait()
		until p1:FindFirstChildOfClass(p2) or (p3 or 10) < os.clock() - v1

		return p1:FindFirstChildOfClass(p2)
	end
}