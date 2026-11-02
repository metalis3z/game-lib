
local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Houses = Global.Houses
local Players = Global.Players
local House = require(script:WaitForChild("House"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))


print("Houses dependecies loaded")


Houses.AllHouses = {}
Houses.HouseList = {}




local HousePositions = {
	CFrame.new(-187.900223, 3.90998864, -331.899628, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(-43.9003983, 3.91014051, -331.899597, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(47.9000206, 3.91027427, -372.100189, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	CFrame.new(191.900177, 3.91033411, -372.100311, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	CFrame.new(-187.900406, 3.91003919, -415.899719, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(-43.9004021, 3.91007614, -415.899689, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(47.9000282, 3.91029358, -456.100311, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	CFrame.new(191.900223, 3.91038704, -456.099884, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	CFrame.new(-187.899933, 3.91010833, -499.899353, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(-43.9004822, 3.91007972, -499.899536, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	CFrame.new(47.9000969, 3.91033411, -540.100159, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	CFrame.new(191.900269, 3.91038132, -540.100586, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	
--not inverted
	CFrame.new(-187.899933, 3.91010833, -210.899323, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900406, 3.91003919, -126.899681, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900223, 3.90998864, -42.8996162, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.899933, 3.91010833, 78.5006714, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900406, 3.91003919, 162.500336, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900223, 3.90998864, 246.500351, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.899933, 3.91010833, 367.500641, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900406, 3.91003919, 451.500275, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-187.900223, 3.90998864, 535.500305, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004822, 3.91007972, -210.899506, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004059, 3.91007614, -126.899681, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9003906, 3.91014051, -42.8995857, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004822, 3.91007972, 78.5004883, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004059, 3.91007614, 162.500366, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9003906, 3.91014051, 246.500381, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004822, 3.91007972, 367.500458, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9004059, 3.91007614, 451.500275, 0, 0, -1, 0, 1, 0, 1, 0, 0),
CFrame.new(-43.9003906, 3.91014051, 535.500305, 0, 0, -1, 0, 1, 0, 1, 0, 0),



--inverted
CFrame.new(47.9000931, 3.91033411, -251.10022, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.900032, 3.91029358, -167.100311, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.9000168, 3.91027427, -83.1001816, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.9000931, 3.91033411, 38.2998619, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.900032, 3.91029358, 122.299721, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.9000168, 3.91027427, 206.29985, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.9000931, 3.91033411, 327.299713, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.900032, 3.91029358, 411.299652, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(47.9000168, 3.91027427, 495.299713, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900177, 3.91033411, 495.299591, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900208, 3.91038704, 411.300079, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900269, 3.91038132, 327.299286, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900177, 3.91033411, 206.299728, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900208, 3.91038704, 122.300148, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900269, 3.91038132, 38.2994347, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900177, 3.91033411, -83.1003036, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900208, 3.91038704, -167.099884, 0, 0, 1, 0, 1, 0, -1, 0, 0),
CFrame.new(191.900269, 3.91038132, -251.100647, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	
	
	
}



local InvertedHouseIndex = {
	false,
	false,
	true,
	true,
	false,
	false,
	true,
	true,
	false,
	false,
	true,
	true,
	
	
	false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,
	true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,

	
}

local Addresses = {
	"C1",
	"B1",
	"B2",
	"A1",
	"C2",
	"B3",
	"B4",
	"A2",
	"C3",
	"B5",
	"B6",
	"A3",
	
	--party
	"Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant","Vacant"
	
	
	
}



local NumberOfHouses = (Enums.IsPartyServer and 48) or 12

function Houses:Initialize()
	for i=1,NumberOfHouses do
		local house =  House.new(self,HousePositions[i],InvertedHouseIndex[i],Addresses[i],i)
		Houses.AllHouses[house.Object] = house
		Houses.AllHouses[house.Object]:LoadHouse()
		Houses.AllHouses[house.Object].Object.Name = "House" .. i
		Houses.AllHouses[house.Object].Index = i
		Houses.AllHouses[house.Object]:StartPlayerListUpdate()
		table.insert(Houses.HouseList,house)

	end
	workspace.House:Destroy() --remove template house
end


function Houses:GetHouseByOwner(player)
	for house,houseData in pairs(Houses.AllHouses) do
		if houseData.Owner == Players[player] then
			return houseData
		end
	end
end


function Houses:GetPlayersInHouseByOwner(player)
	local house = self:GetHouseByOwner(player)
	return house:GetPlayersInside()
	
end


function Houses:ReserveUnoccupiedHouse(Player)

	
	local reserved = false
	
--[[	if Debug.Enabled then
		reserved = true
		Houses.HouseList[Debug.HouseIndex]:SetOwner(Player)
		return Houses.HouseList[Debug.HouseIndex]
	end]]
	
	
	delay(5,function()
		if not reserved and Player and Player.Object and Player.Object.Parent then
			workspace.Main.DataStoreError:FireClient(Player.Object,"ERROR: There are no availabe houses. Try joining another server.")
			reserved = true
			error("There were not availble houses for player ")
		else
			reserved = true
		end
	end)
	
	while not reserved and Player and Player.Object and Player.Object.Parent do
	
		for _,houseData in ipairs(Houses.HouseList) do
			if houseData:GetOwner() == nil then
				houseData:SetOwner(Player)
				reserved = true
				return houseData
			end
		end
		wait(.1)
	end
	return nil
end


local channel = game.ReplicatedStorage.Channels:WaitForChild("HouseChannel")


function Recieve(player,action,...)
	local args = {...}
	
	local playerData = Players[player]
	if not playerData then return end
	
	local playerHouse = playerData.House
	if not playerHouse then return end
	
	print("received",action,player,...)
	
	
	if action == "GetPlayersInHouseByOwner" then
		return Houses:GetPlayersInHouseByOwner(player)
	
	elseif action == "KickPlayerFromHouse" then
		local kickPlayer = args[1]
		if playerHouse:IsPlayerInsideHouse(kickPlayer) then
			playerHouse:KickPlayerFromHouse(kickPlayer)
		end
		
	elseif action  == "PlaceFurniture" then
		local furnitureModel = args[1]
		local cframe = args[2]
		local assetId = args[3]
		playerHouse:PlaceFurniture(player,assetId,furnitureModel,cframe)
		
	elseif action == "PaintFurniture" then
		local part = args[1]
		local color = args[2]
		playerHouse:PaintFurniture(part,color)
		
	elseif action == "PaintHouse" then
		local part = args[1]
		local color = args[2]
		if part and part.Parent and part:IsDescendantOf(playerHouse.Object) then
			playerHouse:SetColor(part.Name,color)
		end
		
	elseif action == "DeleteFurniture" then
		playerHouse:DeleteFurniture(args[1])

		
	elseif action == "UpgradeHouse" then
		if playerHouse.Upgrade == "Backyard" then
			error("Can't upgrade backyard")
		end
		if playerData.UpgradePayments >= Enums.UpgradePrices[Enums.NextUpgradeName[playerHouse.Upgrade]] then
			playerData.UpgradePayments = 0
			local nextUpgradeName = Enums.NextUpgradeName[playerHouse.Upgrade]
			playerHouse:SetUpgrade(nextUpgradeName)
			workspace.Main.Chatted:FireAllClients(nil,playerData.Object.Name .. " upgraded their house.",false)

			return playerHouse.UpgradeModel
		end
		return false
			
			
	elseif action == "GarageUpgrade" then
		if playerHouse.GarageEnabled then
			playerHouse:LoadGarage()
			playerHouse:RefreshPaint()
			return playerHouse.UpgradeModel
		end
		return false
		
		
	elseif action == "SetWallFloor" then
		local assetId = args[1]
		if playerData.LocationHouse and playerData.LocationHouse == playerHouse then
			playerHouse:SetWallorFloor(playerData.Location,assetId)
		else
			print("NOT INSIDE HOUSE")
		end
	end
end



channel.OnServerEvent:connect(function(player,action,...)
	local response1,response2,response3 = Recieve(player,action,...)
	if response1 then
		channel:FireClient(player,action,response1,response2,response3)
	end
end)


setmetatable(Houses, {
	__index = Houses.AllHouses,
	__newindex = Houses.AllHouses
})


return Houses









