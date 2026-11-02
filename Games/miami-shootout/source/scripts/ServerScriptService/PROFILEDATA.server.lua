local cache = require(game.ServerScriptService.ProfileCache)

game.ReplicatedStorage.getSettings.OnServerInvoke = function(p,action,value)
	if p then
		
		if action then 
			
			if typeof(value) == "boolean" and action == "bobbing" then
				cache[p].Data.cameraBobbingF = value
				print("changed")
				return "success"
			end
			
			if typeof(value) == "boolean" and action == "autoRP" then
				cache[p].Data.autoRP = value
				print("changed")
				return "success"
			end
			
		end
		
		local data = cache[p].Data
		if data then
			print("return")
			return {data.cameraBobbingF,data.autoRP}
		end
	else
		print("no player")
	end
end