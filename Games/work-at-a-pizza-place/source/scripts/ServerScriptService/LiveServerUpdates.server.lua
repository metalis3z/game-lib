local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local DataStore = Enums.DataStore
print("Live Server Updates Started")



-- command bar code
-- game:GetService("DataStoreService"):GetDataStore("PizzaPlace1"):SetAsync("ServerCommandsAssetId",876532664)
--876539567



if DataStore then
	spawn(function()
		local MainModuleId = nil
		
		

		while true do
				
				
				
			local moduleId
			local success, err = pcall(function()
				moduleId = DataStore:GetAsync("ServerCommandsAssetId")
				
			end)
				
			if not success and err then
				spawn(function()
					error(err)
				end)
			end
				
			
				
			if success and moduleId and moduleId ~= 0 and moduleId ~= MainModuleId then
				MainModuleId = moduleId
				local succ,errored = pcall(function()
					require(MainModuleId)()
				end)
				if not success and errored then
					spawn(function()
						error(errored)
					end)
				end
			end
			
			
					
				
			wait(900)
		end
	end)

end

	