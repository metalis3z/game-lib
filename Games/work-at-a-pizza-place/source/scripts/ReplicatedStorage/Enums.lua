local Enums = {}

Enums.PizzaPlaceId =  10441465631   --main place
Enums.PizzaPlaceTestId = 142872308   --test place
Enums.PizzaPlacePrivateTestId = 359373636  --testing place for only me
Enums.PizzaPlaceInsideUniverseTestId = 531388577  -- internal update testing place - testing place inside main place universe
Enums.PizzaPlacePartyId = 4982880040
Enums.PizzaPlacePartyTestId = 191851816 --142872308

Enums.TestDataStoreVersion = 37
Enums.PrivateTestDataStoreVersion = 1
Enums.InternalTestDataStoreVersion = 3

Enums.MainGameId = (game.PlaceId == Enums.PizzaPlacePartyId and Enums.PizzaPlaceId) or  (game.PlaceId == Enums.PizzaPlacePartyTestId and Enums.PizzaPlaceTestId)
Enums.PartyServerId = (game.PlaceId == Enums.PizzaPlaceId and Enums.PizzaPlacePartyId) or (game.PlaceId == Enums.PizzaPlaceTestId and Enums.PizzaPlacePartyTestId)

Enums.VideoMakerPluginVersion = 2

Enums.SavedDataVersion = 1 --when I want to make changes to the structure of the saved data or make one time changes to saved data


local partyEnabledStudio = false
local gamepadEnabledStudio = false
local gamepadEnabledTestingPlace = false



if game:GetService("RunService"):IsServer() then
	
	
	Enums.DataStore = ((game.PlaceId == Enums.PizzaPlaceId or game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId or game.PlaceId == Enums.PizzaPlacePartyId) and game:GetService("DataStoreService"):GetDataStore("PizzaPlace1")) or
					  (game.PlaceId == Enums.PizzaPlaceTestId and game:GetService("DataStoreService"):GetDataStore("TestDataStore" ..  Enums.TestDataStoreVersion)) or
					  (game.PlaceId == Enums.PizzaPlacePrivateTestId and game:GetService("DataStoreService"):GetDataStore("PrivateTestDataStore" ..  Enums.PrivateTestDataStoreVersion)) or
					  (game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId and game:GetService("DataStoreService"):GetDataStore("InternalTestingDataStore" .. Enums.InternalTestDataStoreVersion))
	
	spawn(function()
		local entered
		entered = game.Players.PlayerAdded:connect(function(player)
			Enums.IsConsoleServer = workspace.Main.IsGamepadEnabled:InvokeClient(player,gamepadEnabledStudio)
			entered:disconnect()
		end)
		for _,player in ipairs(game.Players:GetPlayers()) do
			Enums.IsConsoleServer = workspace.Main.IsGamepadEnabled:InvokeClient(player,gamepadEnabledStudio)
			entered:disconnect()
		end
	end)


end

if game:GetService("RunService"):IsClient() or game:GetService("RunService"):IsStudio() then
	
	
	Enums.GamepadEnabled = game:GetService("GuiService"):IsTenFootInterface() or (game:GetService("RunService"):IsStudio() and gamepadEnabledStudio) or (game.PlaceId == Enums.PizzaPlaceTestId and gamepadEnabledTestingPlace)
	_G.GamepadEnabled = Enums.GamepadEnabled


	pcall(function()
		if  game:GetService("RunService"):IsStudio() then
			Enums.CanChat = true
		else
			Enums.CanChat = game:GetService("Chat"):CanUserChatAsync(game.Players.LocalPlayer.userId)
		end
	end)
	
end


Enums.ErrorLogTableName =  (game.PlaceId == Enums.PizzaPlaceId and "main_error_log") or
				           (game.PlaceId == Enums.PizzaPlaceTestId and "testing_error_log") or
					       (game.PlaceId == Enums.PizzaPlacePrivateTestId and "testing_error_log") or
				           (game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId and "internal_testing_error_log")


Enums.GlitchReportsTableName =  (game.PlaceId == Enums.PizzaPlaceId and "main_glitch_reports") or
				    		    ((game.PlaceId == Enums.PizzaPlaceTestId or game.PlaceId == 0)  and "testing_glitch_reports") or
								(game.PlaceId == Enums.PizzaPlacePrivateTestId and "testing_glitch_reports") or
				                (game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId and "internal_testing_glitch_reports")




Enums.CustomerStates = {
	WalkingToEntrance = "WalkingToEntrance",
	WalkingToCashier = "WalkingToCashier",
	WaitingForCashier = "WaitingForCashier",
	WalkingToTable = "WalkingToTable",
	SittingAtTable = "SittingAtTable",
	Leaving = "Leaving"
}

Enums.IngredientImages = {
	Cheese = "http://www.roblox.com/asset/?id=167850840",
	Pepperoni = "http://www.roblox.com/asset/?id=167850850",
	Sausage = "http://www.roblox.com/asset/?id=167850856",
	TomatoSauce = "http://www.roblox.com/asset/?id=167850867",
	MountainDew = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168143658",
	Dough = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=170260912",
	Box = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=170260735",
}

Enums.MenuItemImages = {
	Cheese = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168541857",
	Pepperoni = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168540808",
	Sausage = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168541778",
	MountainDew = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168143658",
}

Enums.Lanes = {
	Right = "Right",
	Left = "Left",
	DriveThrough = "DriveThrough"
}

Enums.Paychecks = {
	["Daily Check"] = 200,
	["Paycheck"] = nil,
	["Bonus Check from Manager"] = 150,
	["Starter Check"] = 500,
}


Enums.BaseURL = "http://www.roblox.com/asset/?id="

Enums.ModelBaseURL = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID="

Enums.PetPrice = 7000

local m = math.random(1,2)
if m == 1 then
Enums.FreeMode = false
end
if m == 2 then
Enums.FreeMode = true
end

Enums.IsTestPlace = game.PlaceId ~= Enums.PizzaPlaceId
Enums.IsLocalServer = game:GetService("RunService"):IsServer() and game:FindFirstChild("NetworkServer") and game:GetService("RunService"):IsStudio()
Enums.IsLocalClient = (game:GetService("RunService"):IsClient() and game:FindFirstChild("NetworkClient")) and game:GetService("RunService"):IsStudio()
Enums.IsStudio = game:GetService("RunService"):IsStudio() and not (Enums.IsLocalClient or Enums.IsLocalServer)
Enums.IsOnline = not game:GetService("RunService"):IsStudio()
Enums.IsPartyServer = (partyEnabledStudio and game:GetService("RunService"):IsStudio()) or (not game:GetService("RunService"):IsStudio() and (game.PlaceId == Enums.PizzaPlacePartyId or game.PlaceId == Enums.PizzaPlacePartyTestId))
_G.IsPartyServer = Enums.IsPartyServer


Enums.GamePasses = {
	HangGlider = {ProductId = (Enums.IsTestPlace and 38092751) or 38179412, LegacyGamePassId = (Enums.IsTestPlace and 148236947) or 148251062, ImageId = 494070763, Name = "Hang Glider", Price = 50, Category = "GamePasses",Index = 1,GearAssetId = 497501382},
	ManagerTeleport = {ProductId = (Enums.IsTestPlace and 38092778) or 19024608, LegacyGamePassId = (Enums.IsTestPlace and 148235831) or 148250798, ImageId = 494070799, Name = "Manager Teleport", Price = 80, Category = "GamePasses",Index = 2},
	GarageUpgrade = {ProductId = (Enums.IsTestPlace and 38092789) or 19024602, LegacyGamePassId = (Enums.IsTestPlace and 190451849) or 190452307, ImageId = 494070843, Name = "Garage Upgrade", Price = 145, Category = "GamePasses",Index = 3},
	DeliveryBike = {ProductId = (Enums.IsTestPlace and 38093024) or 19024607, LegacyGamePassId = nil, ImageId = 494070933, Name = "Delivery Bike", Price = 225, Category = "GamePasses",Index = 4,GearAssetId = 497502431},	
	PontoonBoat = {ProductId = (Enums.IsTestPlace and 38093265) or 19804017, LegacyGamePassId = (Enums.IsTestPlace and 282420913) or 282349566, ImageId = 494070979, Name = "Pontoon Boat", Price = 650, Category = "GamePasses",Index = 5},
	FullyUpgradedHouse = {ProductId = (Enums.IsTestPlace and 48492306) or 48492375, LegacyGamePassId = (Enums.IsTestPlace and 175370103) or 176687366, ImageId = 620781798, Name = "Fully Upgraded House", Price = 960, Category = "GamePasses",Index = 6},

}

Enums.BasementProductId = (Enums.IsTestPlace and 49728433) or 49728300


Enums.Moneyz = {
	CoinsSmall = {ProductId = (Enums.IsTestPlace and 18938283) or 45123832, ImageId = 495062472, Name = "600", Amount = 600, Price = 10, Category = "Moneyz",Index = 1},
	CoinsMedium = {ProductId = (Enums.IsTestPlace and 18938295) or 45123935, ImageId = 495062622,  Name = "1,800", Amount = 1800, Price = 30, Category = "Moneyz",Index = 2},
	CoinsLarge = {ProductId = (Enums.IsTestPlace and 18938289) or 45123967, ImageId = 495062787, Name = "6,000", Amount = 6000, Price = 90, Category = "Moneyz",Index = 3},
	CoinsXL = {ProductId = (Enums.IsTestPlace and 18938299) or 45124003, ImageId = 495062871, Name = "23,100", Amount = 23100, Price = 320, Category = "Moneyz",Index = 4},
	CoinsChest = {ProductId = (Enums.IsTestPlace and 38148916) or 45124061, ImageId = 495062918, Name = "54,600", Amount = 54600, Price = 700, Category = "Moneyz",Index = 5},
	CoinsDoubleChest = {ProductId = (Enums.IsTestPlace and 38148945) or 23491618, ImageId = 495063013, Name = "252,000", Amount = 252000, Price = 3000, Category = "Moneyz",Index = 6},
	MoneyBag = {ProductId = (Enums.IsTestPlace and 19762535) or 45123732, ImageId = 495323030, Name = "6,000", Amount = 6000, Price = 90, Category = "Moneyz",Index = 7,GearAssetId = 495315981},
}




Enums.Admins = {
	["careypriceispro"]=1,
	["AdventurerZeTroll"]=2,
	["Dued1"]=3,
	["Dert41"]=4,
	["SheepDonut"] = 5,
	["jack123"]=5,
	["Player"] = 8,
	["jelloman"] = 10,
	["Player2"] = 10,
	["Player1"] = 10,
	["billsayshowdy"] = 11,
	["Dert51"] = 12
}

--[[ 750 base price
	CoinsSmall = {ProductId = (Enums.IsTestPlace and 18938283) or 22265334, ImageId = 495062472, Name = "750", Amount = 750, Price = 10, Category = "Moneyz",Index = 1},
	CoinsMedium = {ProductId = (Enums.IsTestPlace and 18938295) or 22265341, ImageId = 495062622,  Name = "2,250", Amount = 2250, Price = 30, Category = "Moneyz",Index = 2},
	CoinsLarge = {ProductId = (Enums.IsTestPlace and 18938289) or 22265344, ImageId = 495062787, Name = "7,450", Amount = 7450, Price = 90, Category = "Moneyz",Index = 3},
	CoinsXL = {ProductId = (Enums.IsTestPlace and 18938299) or 22265346, ImageId = 495062871, Name = "28,800", Amount = 28800, Price = 320, Category = "Moneyz",Index = 4},
	CoinsChest = {ProductId = (Enums.IsTestPlace and 38148916) or 18473377, ImageId = 495062918, Name = "68,300", Amount = 68300, Price = 700, Category = "Moneyz",Index = 5},
	CoinsDoubleChest = {ProductId = (Enums.IsTestPlace and 38148945) or 23491618, ImageId = 495063013, Name = "315,000", Amount = 315000, Price = 3000, Category = "Moneyz",Index = 6},
	MoneyBag = {ProductId = (Enums.IsTestPlace and 19762535) or 22265395, ImageId = 495323030, Name = "7,850", Amount = 7850, Price = 90, Category = "Moneyz",Index = 7,GearAssetId = 495315981},

--]]


Enums.PetProductId =(Enums.IsTestPlace and 30393855) or 19024606

Enums.UpgradePrices = {
	["Tiny"] = 700, --1000,  --10 Robux  
	["Small"] = 1200, --1000,  --10 Robux  
	["Medium"] = 3700, --2500,-- 25 Robux	  15
	["Large"] = 5200,--5000, --50 Robux  	   25
	["TwoStory"] = 9900, --100	 Robux		50
	["ThreeStory"] = 16000, --200 Robux 	100
	["Backyard"] = 	30000,	--300  Robux 	200
	["Basement"] = 	40000,	--300  Robux 	200
	["FourStory"] = 	45000,	--300  Robux 	200
	["Massive"] = 	100000,	--300  Robux 	200
	["Hotel"] = 	120000	--300  Robux 	200
}


Enums.UpgradeNameToIndex = {
	["Mini"] = 1,
	["Tiny"] = 2,
	["Small"] = 3,
	["Medium"] = 4,
	["Large"] = 5,
	["TwoStory"] = 6,
	["ThreeStory"] = 7,
	["Backyard"] = 8,
	["Basement"] = 9,
	["FourStory"] = 10,
	["Massive"] = 11,
	["Hotel"] = 12,
}

--model ids, not decal
Enums.HouseImages = {
	["Mini"] = 4982501076,
	["Tiny"] = 488979934,
	["Small"] = 488993435,
	["Medium"] = 488992644,
	["Large"] = 488992161,
	["TwoStory"] = 488991678,
	["ThreeStory"] = 488991353,
	["Backyard"] = 488993764,
	["Basement"] = 658078386,
	["FourStory"] = 4624216058,
	["Massive"] = 4632136147,
	["Hotel"] = 4636005432,
}

Enums.MaxNumFurniture = {
	["Mini"] = 3,
	["Tiny"] = 16,
	["Small"] = 32,
	["Medium"] = 70,
	["Large"] = 85,
	["TwoStory"] = 150,
	["ThreeStory"] = 230,
	["Backyard"] = 290,
	["Basement"] = 390,
	["FourStory"] = 420,
	["Massive"] = 700,
	["Hotel"] = 1000,
}



Enums.ExtendedHouseName = {
	["Mini"] = "Mini House",
	["Tiny"] = "Tiny House",
	["Small"] =  "Small House",
	["Medium"] =  "Medium House",
	["Large"] =  "Large House",
	["TwoStory"] =  "2 Story House",
	["ThreeStory"] =  "3 Story House",
	["Backyard"] =  "Backyard",
	["Basement"] =  "Basement",
	["FourStory"] =  "4 Story House",
	["Massive"] =  "Massive House",
	["Hotel"] =  "Hotel",
}

Enums.NextUpgradeName = {
	["Mini"] = "Tiny",
	["Tiny"] = "Small",
	["Small"] =  "Medium",
	["Medium"] =  "Large",
	["Large"] =  "TwoStory",
	["TwoStory"] =  "ThreeStory",
	["ThreeStory"] =  "Backyard",
	["Backyard"] =  "Basement",
	["Basement"] =  "FourStory",
	["FourStory"] =  "Massive",
	["Massive"] =  "Hotel",
	["Hotel"] =  nil,
}


Enums.HouseSizes = {
	"Mini",
	"Tiny",
	"Small",
	"Medium",
	"Large",
	"TwoStory",
	"ThreeStory",
	"Backyard",
	"Basement",
	"FourStory",
	"Massive",
	"Hotel"
}




Enums.CategoryToType = {
	["Hats"] = "Clothing",
	["Gear"] = "Gear",
	["Shirts"] = "Clothing",
	["Pants"] = "Clothing",
	["Packages"] = "Clothing",
	["Walls"] = "WallsFloors",
	["Floors"] = "WallsFloors",
	["Beds"] = "Furniture",
	["Lights"] = "Furniture",
	["Seats"] = "Furniture",
	["Tables"] = "Furniture",
	["Kitchen/Bath"] = "Furniture",
	["Decoration"] = "Furniture",
	["Entertainment"] = "Furniture",
	["Collectables"] = "Furniture",
	["Customization"] = "Furniture",
	["Holiday"] = "Furniture",
	["Backyard only"] = "Furniture",
	["Music Players"] = "Furniture",
	["PetHats"] = "PetHats"

}

Enums.TypeToCategoryList = {
	["Clothing"] = {"Hats","Shirts","Pants","Packages"},
	["WallsFloors"] = {"Walls","Floors"},
	["Furniture"] = {"All","Beds","Lights","Seats","Tables","Kitchen/Bath","Decoration","Entertainment","Collectables","Customization","Holiday","Backyard only","Music Players"},
	["Gear"] = {},
	["Vehicles"] = {},
	["GamePasses"] = {},
	["Moneyz"] = {},

}

Enums.TypeToCatalogCategoryList = {
	["Clothing"] = {"Hats","Shirts","Pants","Packages"},
	["WallsFloors"] = {"Walls","Floors"},
	["Furniture"] = {"Beds","Lights","Seats","Tables","Kitchen/Bath","Decoration","Entertainment","Collectables","Customization","Holiday","Backyard only","Music Players"},
	["Gear"] = {},
	["Vehicles"] = {},
	["GamePasses"] = {},
	["Moneyz"] = {},

}

Enums.TeamNameToBrickColor = {
	["Cashier"] = 21,
	["Cook"] = 24,
	["Delivery"] = 23,
	["Manager"] = 37, 
	["On Break"] = 194, 
	["Pizza Boxer"] = 106, 
	["Supplier"] = 1
}


Enums.BrickColorToTeamName = {
	[21] = "Cashier",
	[24] = "Cook",
	[23] = "Delivery",
	[37] = "Manager", 
	[194] = "On Break", 
	[106] = "Pizza Boxer", 
	[1] = "Supplier"
}



return Enums
