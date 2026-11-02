return {
	Apply = function(p1) --[[ Apply | Line: 5 ]]
		local SecondEars = p1:FindFirstChild("SecondEars")
		local Ears = p1:FindFirstChild("Ears")

		if not (SecondEars and Ears) then
			return
		end

		for i, v in ipairs(SecondEars:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
			end
		end

		for i, v in ipairs(Ears:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 1
			end
		end
	end,
	UnDo = function(p1) --[[ UnDo | Line: 14 ]]
		local SecondEars = p1:FindFirstChild("SecondEars")
		local Ears = p1:FindFirstChild("Ears")

		if not (SecondEars and Ears) then
			return
		end

		for i, v in ipairs(SecondEars:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 1
			end
		end

		for i, v in ipairs(Ears:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
			end
		end
	end
}