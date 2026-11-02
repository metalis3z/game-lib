local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkModule = require(ReplicatedStorage.Packages.Net)

if not RunService:IsServer() then
	return NetworkModule:Invoke("BrainrotToCupid/RequestList")
end

local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CupidsMachineData =
	require(ServerStorage.Modules.CupidsMachineData)

local CommandsService =
	require(ServerScriptService.Services.CommandsService)

local RecipeNameList = {}

for _, RecipeData in CupidsMachineData.Recipes do
	local RecipeName = RecipeData.Name
	table.insert(RecipeNameList, RecipeName)
end

NetworkModule:Handle("BrainrotToCupid/RequestList", function(Player)
	local PlayerRole = CommandsService:GetRoleAsync(Player)

	if PlayerRole ~= "Dev" and PlayerRole ~= "Lead" then
		return {}
	end

	return RecipeNameList
end)

return RecipeNameList