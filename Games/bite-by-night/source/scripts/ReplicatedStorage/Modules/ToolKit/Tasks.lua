
return {
	GetAnnouncementPoints = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("AnnouncementPoints")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetBatteries = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("Batteries")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetPoints = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("Points")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetGenerators = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("Generators")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetGenPoints = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("GenPoints")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetFuseBoxes = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("FuseBoxes")
		
		return not points and {} or points:GetChildren()
	end,
	
	GetFusePoints = function(_, map)
		local gameMap = map or workspace.MAPS:FindFirstChild("GAME MAP")
		local points = gameMap and gameMap:FindFirstChild("FusePoints")
		
		return not points and {} or points:GetChildren()
	end,
}