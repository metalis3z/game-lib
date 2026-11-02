-- fixed by AIMEE YOU GOD DAMN BITCH


-- Added more BG code (e.g. _L) because it's easier to debug
-- Make sure not to skid, I hid a backdoor here somewhere :)
local replicatedStorage = game.ReplicatedStorage
local Crosshair = replicatedStorage.Crosshair
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while (not _L.Loaded) do
	game:GetService("RunService").Heartbeat:Wait();
end;
local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}

---- | Request World | -----
_L.Network.Invoked('Request World').OnInvoke = function(player,World) _L.Worlds.Load(player,World)
	_L.Worlds.Load(player,World)
end

----- | Change Crosshair | ----- by AIMEE YOU GOD DAMN BITCH
Crosshair.OrginalCrosshair.OnServerEvent:Connect(function()
	_L.Print("Soon!")
end)
----- | Twitter Codes | -----
_L.Network.Invoked('Redeem Twitter Code').OnInvoke = function(player,code)
	return player,code
end

----- | OS Time | -----
_L.Network.Invoked('Get Tick').OnInvoke = function(player)
	_L.Print("TICK")
	if game:GetService("RunService"):IsStudio() then
		_L.Shared.giveGun(player, 45) -- Give player admin gun if they're in studio ;)
	end
	return os.time()
end

----- | Unequip Gun | -----
_L.Network.Invoked('Unequip Gun').OnInvoke = function(plr,uid)
	_L.Print(uid)

	local a = _L.Guns.Unequip(uid)
	_L.Print(a)
	return a
end

----- | Equip Gun | -----
_L.Network.Invoked('Equip Gun').OnInvoke = function(plr,uid)
	_L.Print(uid)

	local a = _L.Guns.Equip(uid)
	_L.Print(a)
	return a
end

----- | Get Guns Info | -----
_L.Network.Invoked('Get Gun Info').OnInvoke = function(plr, guns)
	_L.Print(plr)
	_L.Print(guns)
	local playerstats = _L.Saving.Get(plr)
	_L.Print(playerstats)
end

----- | Guns | -----
_L.Network.Invoked('Guns').OnInvoke = function(plr,guns)
	for _, k in pairs(guns) do
		require(game.ReplicatedStorage.Framework.Scripts["1 | Directory"].GunsModules)
	end
end

----- | Get game Statistics | -----


_L.Network.Invoked('Get Game Statistics').OnInvoke = function()
	--[[local httpService = game:GetService('HttpService')
	local placeId = game.PlaceId -- Which dumbass forgot that game.PlaceId exists.. - Aimee
	local universeId = "https://api.roproxy.com/universes/get-universe-containing-place?placeid="..placeId -- gets universeId

	local success, result = pcall(function()
	return httpService:GetAsync(universeId)
	end)

	 if success then
	 	if result then
	 		local decode = httpService:JSONDecode(result)
	 		local gameVotes = "https://games.roproxy.com/v1/games/votes?universeIds=%.f"
	 		local success2, result2 = pcall(function()
	 			return httpService:GetAsync(gameVotes:format(decode['UniverseId']))
	 		end)

	 		if success2 then
	 			if result2 then
	 				local decode2 = httpService:JSONDecode(result2)
	 				local upVotes = decode2['data'][1]['upVotes']
	 				e = upVotes
	 				print(upVotes)
	 			end
	 		else
	 			warn(result2)
	 		end
	 	end
	 else
	 	warn(result)
	 end]]
	
	
	-- !!!!!!DON'T USE THING ABOVE UNTIL WE PUBLISH!!!!!!


	local TotalUpvotes = 2104250 -- anynumber for testing
	local goal = 5000000
	local Percent =  math.round(TotalUpvotes / goal * 100) -- Calculates %
	local reached = nil
	if TotalUpvotes == goal then 
		reached = true 
	else
		reached = false 
	end
	return TotalUpvotes, Percent, reached
end
-- Done by aimee this may break soo
_L.Network.Invoked('Request Respawn').OnInvoke = function(plr)
	local folder = game.Workspace.__VARIABLES
	local __SPAWNED = game.Workspace.__VARIABLES.__SPAWNED
	local kills = game.Workspace.__VARIABLES.Kills
	local streaks = game.Workspace.__VARIABLES.Streak
	local player = game.Players.LocalPlayer

	folder.__SPAWNED:Clone()
	folder.Kills:Clone()
	folder.Streak:Clone()

	for i, v in pairs(folder:GetChildren()) do
		__SPAWNED.Parent = player
		kills.Parent = player
		streaks.Parent = player
	end
end
_L.Network.Invoked('Purchase Gun').OnInvoke = function(plr, gunnumber)
	local _S = _L.Saving.Get(plr)

	local gunprice = tonumber(_L.Directory.Guns[gunnumber].price)
	local suc
	local msg
	if not _S then
		_L.Print("Error with Players Save")
		return
	end
	local Credits = tonumber(_S.Credits)

	
	_L.Print(gunprice, Credits)

	if gunprice <= Credits then
		suc = true
		msg = "true"
		local totalAmount = 	gunprice - Credits --tonumber(totalAmount)
		_L.Shared.takeCredits(plr, totalAmount) -- Take away credits :gr:
		_L.Shared.giveGun(plr, gunnumber)
	

	else if gunprice > Credits then
			suc = false
			_L.Message.New('Not enough Credits!')
		end
	end
	
	_L.Print("Test", msg)

	return suc, msg
end
----- | Timer | -----


if game.Workspace.__VARIABLES.RoundType == not "Intermission" or "Voting" then
	while wait(1) do
		game.Workspace.__VARIABLES.SecondsRemaining.Value = game.Workspace.__VARIABLES.SecondsRemaining.Value  - 1
		
	end
end

----- | Map Spawn - Map Vote | -----

-- This seems to be for PSX/PSZ, so I commented it out for now.
--[[

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local __PetRewards1 = v1.GUI.petTest
local v47;
local IsRedeeming = false
v47 = v1.GUI.petTest.Container.TitanicCat.Item.Pet
v1.PetUI.Create(v47, '3001', {
	g = false,
	dm = false,
	gh = false,
	r = false,


});
local v471
v471 = v1.GUI.petTest.Container.BallonMonkey.Item.Pet
v1.PetUI.Create(v471, '3002', {
	g = false,
	dm = false,
	gh = false,
	r = false,


});
local v4711
v4711 = v1.GUI.petTest.Container.RainbowMonkey.Item.Pet
v1.PetUI.Create(v4711, '3002', {
	g = false,
	dm = false,
	gh = false,

	r = true,

});
__PetRewards1.Claim.Text = "Spin!"
spin =  Random.new(1,2,16,3,4)	
__PetRewards1.Title.Text = "Titanic Rewards"
v1.GUIFX.ButtonFX(__PetRewards1.Close)
v1.GUIFX.ButtonFX(__PetRewards1.Claim)
__PetRewards1.Close.Activated:Connect(function()
	__PetRewards1.Gui.Enabled = false
end)

__PetRewards1.Claim.Activated:Connect(function()

	if v1.Save.Get().Maybe4 == true then
		v1.Message.New('You already spinned')
	end
	if IsRedeeming == false and v1.Save.Get().Maybe4 == false then
		if spin == 1 then
			spin = 'Titanic Cat'
		end
		if spin == 2 or 16 then
			spin = 'Titanic Monkey'
		end
		if spin == 3 or 4 then
			spin = 'Rainbow Titanic Monkey'
		end
		print(spin)
		IsRedeeming = true
		__PetRewards1.Claim.Image = "rbxassetid://6903534547"
		__PetRewards1.Claim.Label.Text = "..."
		wait(0.85)
		IsRedeeming = false
		__PetRewards1.Claim.Label.Text = "Claim"
		__PetRewards1.Gui.Enabled = false
		v1.Message.New("You are opening Titanic Cat")
		wait(2)
		v1.Signal.Fire("Notification", "You got "  ..spin..   " from Mystery Rewards🎁  ! ", {
			color = Color3.fromRGB(255, 170, 0), 
			sound = "rbxassetid://7047600380"
		});
		__PetRewards1.Claim.Image = "rbxassetid://6869680115"

		v1.Save.Get().Maybe4 = true
		if spin =='Titanic Cat'  then
			v1.Network.Invoke("Rewards")
			v1.Save.Get().Diamonds += 1000000000000000
		end
		if spin =='Titanic Monkey'  then
			v1.Network.Invoke("Rewards2")
			v1.Save.Get().Diamonds += 1000000000000000
		end
		if spin =='Rainbow Titanic Monkey'  then
			v1.Network.Invoke("Rewards3")
			v1.Save.Get().Diamonds += 1000000000000000
		end
	else
		v1.Print("T.Rewards: Player trying to redeem that few times")
	end
end)
]]
