return {
	Get = function(p1) --[[ Line: 4 ]]
		local v1 = game.ReplicatedStorage:WaitForChild("Data"):FindFirstChild(p1)

		if v1 then
			return require(v1)
		end
	end
}