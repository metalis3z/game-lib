--credit to prince games studio
return table.freeze({
	applyTo = function(p1, p2, p3) --[[ applyTo | Line: 3 ]]
		if math.abs(p3 - 1) < 0.0001 then
			return
		end

		if p2.Parent then
			p2.Size = p2.Size * p3

			local v1 = p1.CFrame:ToObjectSpace(p2.CFrame)

			p2.CFrame = p1.CFrame * CFrame.new(v1.Position * p3) * (v1 - v1.Position)
		end
	end
})