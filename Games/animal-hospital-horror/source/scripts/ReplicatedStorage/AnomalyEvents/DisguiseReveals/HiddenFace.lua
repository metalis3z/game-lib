return {
	Apply = function(p1) --[[ Apply | Line: 3 ]]
		if not p1:FindFirstChild("NoFaceBillboard") then
			local v1 = game.ReplicatedStorage:WaitForChild("Misc"):WaitForChild("NoFaceBillboard"):Clone()

			v1.Parent = p1
			v1.Adornee = p1:FindFirstChild("Head")
		end
	end,
	UnDo = function(p1) --[[ UnDo | Line: 12 ]]
		local NoFaceBillboard = p1:FindFirstChild("NoFaceBillboard")

		if not NoFaceBillboard then
			return
		end

		NoFaceBillboard:Destroy()
	end
}