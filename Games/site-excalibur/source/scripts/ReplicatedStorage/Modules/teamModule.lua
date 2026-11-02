local ReplicatedStorage = game:GetService('ReplicatedStorage');
-----------------------------------------------------------------
local Assets = ReplicatedStorage:FindFirstChild('Assets');
local Morphs = Assets:FindFirstChild('Morphs')
-----------------------------------------------------------------
local teamModule = {};
-----------------------------------------------------------------
teamModule['TeamName'] = {
	
	teamAccess = {
			groups = {};
			gamepasses = {};
			users = {};
	};
	
	spawnSettings = {
	
		spawnHealth = math.huge; -- Base Health [ 100 ] / Max Health [ math.huge ]
		spawnStrength = 1; -- Base Strength [ 1 ] / Max Strength [ 3 ]
		spawnSpeed = 2; -- Base Speed [ 0 ] / Max Speed [ 2 ]
		spawnTools = {}; -- Tool Paths / Found in ServerStorage - Assets - Tools
		spawnClothing =  {
		
			Shirt = 1381371613; -- Regular Shirt ID / Found on URL
			Pants = 1197655585; -- Regular Pants ID / Found on URL
			Morph = Morphs:FindFirstChild('morphName'); -- Morph Asset found in ServerStorage -> Assets -> Morphs
			
		};
		
		spawnFunction = function(teamPlayer)
			
		end
		
	
	};
}



return teamModule
 