return function()
	print("LOADED TELEPORTER")
	--[[local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
	if not Enums.IsPartyServer then
		local ENABLED = true
		
		local modelName = "Teleport to Party Island"
		math.randomseed(tick())
		math.random()
		if ENABLED and (math.random(1,10) == 2 or game.Players:WaitForChild("Dued1",10)) then
				
			if workspace:FindFirstChild(modelName) == nil then
				script[modelName].Parent = workspace
			end
			
		elseif not ENABLED and workspace:FindFirstChild(modelName) then
			workspace[modelName]:Destroy()
		end
	end]]
	
		
end