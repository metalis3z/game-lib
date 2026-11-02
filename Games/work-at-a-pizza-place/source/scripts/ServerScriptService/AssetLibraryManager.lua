
local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Vehicles = Global.Vehicles
local AssetLibraryManager = Global.AssetLibraryManager
local Houses = Global.Houses
local Players = Global.Players
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local DataStore = (game.PlaceId ~= 0 and game:GetService("DataStoreService"):GetGlobalDataStore())



--module1 
--game:GetService("DataStoreService"):GetGlobalDataStore():SetAsync("ModuleId",640427092)

--module2 <--Current
--game:GetService("DataStoreService"):GetGlobalDataStore():SetAsync("ModuleId",640427368)



--get the module script id
local MainModuleId 


--[[if DataStore then--and game.PlaceId == 192800 then-- then
	local success, err = pcall(function()
		MainModuleId = DataStore:GetAsync("ModuleId")
	end)
	if not success or MainModuleId == nil then
		MainModuleId = script.Parent.MainModule
	end
else]]
	MainModuleId = script.Parent.MainModule
--end
	
	
AssetLibraryManager.MainModule = require(MainModuleId)
AssetLibraryManager.AssetLibrary = AssetLibraryManager.MainModule.AssetLibrary


--check to see if module script has been update, if so, get the new module script
--[[spawn(function()
	while true do
		wait(900)
		
		local moduleId
		local success, error = pcall(function()
			moduleId = DataStore:GetAsync("ModuleId")
		end)
		
		if success and MainModuleId ~= moduleId then
			MainModuleId = moduleId
			AssetLibraryManager.MainModule = require(MainModuleId)
			AssetLibraryManager.AssetLibrary = AssetLibraryManager.MainModule.AssetLibrary
		end
	end
end)]]




local function SortItemsByPrice(items)
	table.sort(items,function(a,b)
		return a.Price < b.Price
	end)
end


function AssetLibraryManager:GetAssetById(id)
	return AssetLibraryManager.AssetLibrary[tostring(id)]
end




function AssetLibraryManager:GetItemsInCategories(...)
	local categories = {...}
	local items = {}
	for _,category in ipairs(categories) do
		for id,data in pairs(AssetLibraryManager.AssetLibrary) do
			if data.Category == category then
				data["AssetId"] = tonumber(id) --add id field
				table.insert(items,data)
			end
		end
	end
	SortItemsByPrice(items)
	return items
end


function AssetLibraryManager:GetAssetByName(name)
	for id,data in pairs(AssetLibraryManager.AssetLibrary) do
		if data.Name == name then
			return data
		end
	end
end



function AssetLibraryManager:GetAssetLibrary()
	return self.AssetLibrary
end






function AssetLibraryManager:GetItemsOnSale()
	
end




local channel = game.ReplicatedStorage.Channels:WaitForChild("AssetLibraryManagerChannel")


function Recieve(player,action,...)
	print("received",action,player,...)
	local args = {...}
		
	if action == "GetAssetLibrary" then
		return AssetLibraryManager.AssetLibrary
		
	elseif action == "GetPetHatsLibrary" then
		return AssetLibraryManager:GetItemsInCategories("PetHats")
	
	elseif action == "GetFurnitureObject" then
		local object = AssetLibraryManager:GetAssetById(args[1]).Object:clone()
		object.PrimaryPart = object.Border
		object.Parent = game.ReplicatedStorage.StreamingFurnitureStorage
		object:MoveTo(Vector3.new(0,10000,0))
		Players[player].DraggingFurniture = object
		return object
		
	elseif action == "GetAssetPrice" then
		local asset = AssetLibraryManager:GetAssetById(args[1])
		if asset then
			return asset.Price
		end
	end
end



channel.OnServerEvent:connect(function(player,action,...)
	local response1,response2,response3 = Recieve(player,action,...)
	if response1 then
		channel:FireClient(player,action,response1,response2,response3)
	end
end)


print("ending")


return AssetLibraryManager
