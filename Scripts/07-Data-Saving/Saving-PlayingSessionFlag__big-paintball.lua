-- Reference copy for study. Game: BIG Paintball! Classic (big-paintball)
-- Original: ReplicatedStorage/Framework/Modules/Server/3 _ Saving.lua  (513 lines)
-- What it does: BIG Games saving: a PlayingSession flag in the save acts as a simple session lock (retry until the old server cleared it), new-stat backfill, staggered save loop, change-diff replication.

--[[
                                                                        ....:::.          
                                                    ....:::::-----==============:         
                                 ....::::-----==================================:         
            .....::::-----======================================================-         
       .-=======================================================================-         
       -=========================================================================         
       -============================================================-:..    ..:==:        
       :==================================--:::=====:.       .-====:    ...     --        
       .=============---==:::.=====-    -=:    ===:    .::.    :==:    -====:::--=        
        ==....          ==    -====-    :=-    -=:    -=====:--===.   :===========.       
        -=         ..:::==.   :=====    .=-    :=.   .============.   .======-:::-.       
        -======.   -======:    ..       .==    .=:    =======:-:-=:    -====-    =:       
        :======:   .======-              ==    .=-    :=====.   :==:    .::.    :=:       
        .======-    ======-    --====    ==:   .==-.    ...    :====-:.      .:-==-       
         =======    -======    ======.   -==    ====-:.     .:===========--========       
         -======.   :======.   -=====:...-==:::-===================================.      
         :======: ..:======----====================================================:      
         .========================================================================-       
         .=======================================================-----:::::....           
          ===================================----::::::.....       .    .::---:.          
          -===============-----:::......           .:::.   --=======.  -==-:::-=.         
           .::.....            .:::.     .====-    ====-   -==..      .===:..             
                 :-====-:      =====.     =====:  -==-==   -==:::::.   :-=======:         
               .==-:..:=-:    .==::==.    -=::==. ==::==.  :===-:::.        ..-==.        
               -==.           :==. -=-    -=- :==.==..==.  .==-        :=-:..:-==         
               -==.  :----:   -==::-==-   :==  -====  ==:  .===-----=: .--====-:.         
               -==:  ..:==-  :==--:::==-  :==. .===-  -=:   --:::::...                    
                -==-:::-===  ===.    :--:  ::.  ...                                       
                 .:----. ::  ..                                                     
                 
                     
    Thicc Games rbx.lua Framework [2022] - [2023]
    Written by Troy, Amy, and Experilux - team@thicc.games
    Developed with keyboards and pixie dust.
	
	-+-+-+- SPECIFICS -+-+-+-
	_L.Saving
	===========
	The most hacky but (somehow) secure way data is stored, recievied, and saved. Not very pretty, but it gets the job done.
	Most specific 'saving' issues are taken acount for - and have been tested to work in real scenerios. If data fails to save, recieve, etc.
	server and client will get warning and messages accordingly. Very efficient on datastore requests.
	
	Default stats are found under _L.Settings on Server.
	===========
		\\\ Get player's data
		Saving.Get(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Returns true if player is loaded (past intro)
		Saving.IsLoaded(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Save player's data to DataStore
		Saving.Save(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Load player's data from DataStore
		Saving.Retrieve(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Reset the player's data back to default stats
		Saving.Reset(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Clears player's data from local server manually
		Saving.Remove(
			player,					<-- |REQ|	Player instance
		)
		
		\\\ Initialize player's data. [For internal use only! Don't use this pls]
		Saving.Init(
			player,					<-- |REQ|	Player instance
		)
	===========
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------|       Top       |--------
local Saving = {}

--------|     Setting     |--------
local Debug = false
local saveDuration = 60
local savingWaitTimeout = 10
local debugSave = false

delay(1, function()
	if game:GetService("RunService"):IsStudio() then
		debugSave = true
	end
end)

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------
local datastore = _L.Services.DataStoreService:GetDataStore(debugSave == false and _L.Settings.StatsVersion or "NonSave0")
local rng = Random.new()
local things = game.Workspace:WaitForChild("__THINGS")
local isStudio = _L.Services.RunService:IsStudio() or _L.Services.RunService:IsRunMode()

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function Saving.Save(player, playerLeaving)
	--- Debug
	if debugSave then
		if Debug then
			_L.Print("Cancelled save for [bold]" .. player.Name .. "[/bold] because debugSave")
		end
		return true
	end

	--- Get session stats
	local stats = Saving.Get(player)

	--- Main
	if stats ~= nil then
		--- Attempt save
		local success = _L.Datastore.Update(datastore, player.UserId, function(oldSave)
			if oldSave ~= nil then
				local lastSaveTimestamp = oldSave.LastSaveTimestamp
				if Debug and lastSaveTimestamp ~= nil then
					_L.Print("Time elapsed since last save for [bold]" .. player.Name .. "[/bold]: " .. _L.Functions.TimeString((os.time() - lastSaveTimestamp)))
				end
			end

			--- Update save timestamp
			stats.LastSaveTimestamp = os.time()

			--- Update session timestamp
			stats.PlayingSession = not (playerLeaving or false)

			--
			return stats
		end)

		--- Debug prints
		if Debug then
			if success then
				_L.Print("Successfully saved [bold]" .. player.Name .. "[/bold]'s stats!")
			end
		end

		--- End function is save was completed!
		if success then
			return success
		end
	end

	_L.Print("Failed to save [bold]" .. player.Name .. "[/bold]'s stats", true)

	--- If the function reaches this point, save failed. Let client know this is not good :(
	coroutine.wrap(function()
		_L.Network.Fire("Save Fail", player)
	end)()

	--
	return false
end


function Saving.Retrieve(player)
	--- Variables
	local savedStats
	local attempts = 0
	local success = false
	local newPlayer = false

	--- Wait for most recent save
	while (attempts < 5 and (not success) and (not newPlayer)) do
		savedStats, success = _L.Datastore.Get(datastore, player.UserId)
		attempts = attempts + 1

		-- Not recent save!
		if savedStats and savedStats.PlayingSession and (not isStudio) then
			success = false
		elseif (not savedStats) and success then
			newPlayer = true
		end

		--- Delay
		if not success then
			wait(rng:NextNumber(5, 8))
		end
	end

	--- Stats were retrieved, but failed to get LATEST save. Probably didn't save correctly :/
	if savedStats and savedStats.PlayingSession then
		_L.Print("Stats were retrieved, but PlayingSession flag was saved as true. Ignore this if test session.", true)
		success = true
	end

	--- New player!
	if newPlayer then
		if Debug then
			_L.Print("New player, [bold]" .. player.Name .. "[/bold], joined the game!")
		end
		return {}
	end

	--- Debug prints
	if Debug then
		if success then
			if Debug then
				_L.Print("Successfully retrieved stats for [bold]" .. player.Name .. "[/bold]!")
			end
		else
			_L.Print("Failed to retrieve stats for [bold]" .. player.Name .. "[/bold]", true)
		end
	end

	if not success then
		return "Error"
	end

	--
	return savedStats
end


function Saving.Init(player)
	local function InitPlayer()
		--- Wait for any previous stats to be cleaned up (if player rejoins the same server too quickly)
		while (_L.Storage.Stats["u" .. player.UserId] ~= nil) or (player.Parent == nil) do  wait()  end 

		if _L.Storage.Stats["u" .. player.UserId] == nil and player then
			--- Retrieve stats
			local savedStats = Saving.Retrieve(player)

			--- Stats returned as error!
			if savedStats == "Error" then
				_L.Print("_L.Saving.Init | MAJOR ERROR: Stats returned error for [bold]" .. player.Name .. "[/bold]", true)
				_L.Network.Fire("New Stats", player, "Error")
				return false
			end

			--- Add default stats
			_L.Storage.Stats["u" .. player.UserId] = _L.Functions.CloneTable(_L.Settings.DefaultStats)

			--- Update stats with save
			if savedStats then
				--- Returning player
				_L.Storage.Stats["u" .. player.UserId] = savedStats

				--- Add any new stats that player didn't have prior
				for statN, statV in pairs(_L.Settings.DefaultStats) do
					if savedStats[statN] == nil then
						_L.Storage.Stats["u" .. player.UserId][statN] = (type(statV) == "table" and _L.Services.HttpService:JSONDecode(_L.Services.HttpService:JSONEncode(statV)) or statV)
					end
				end
			end

			--- Update 'playing session' to true
			_L.Storage.Stats["u" .. player.UserId].PlayingSession = true

			--- Let client know when stat(s) change
			local cachedStats = {}
			while player and player.Parent do
				if _L.Storage.Stats["u" .. player.UserId] then
					local send = false

					for statName, statValue in pairs(_L.Storage.Stats["u" .. player.UserId]) do
						if statName == "Bakery" then
							continue
						end

						local cachedStatValue = cachedStats[statName]
						if cachedStatValue == nil then
							send = true
							break
						else
							local isTable = (type(statValue) == "table")
							if isTable and _L.Services.HttpService:JSONEncode(statValue) ~= cachedStatValue then
								send = true
								break
							elseif (not isTable) and statValue ~= cachedStatValue then
								send = true
								break
							end
						end
					end

					local dataToSend = {}
					for statName, statValue in pairs(_L.Storage.Stats["u" .. player.UserId]) do
						if statName == "Bakery" then
							continue
						end

						dataToSend[statName] = statValue
						if type(statValue) == "table" then
							cachedStats[statName] = _L.Services.HttpService:JSONEncode(statValue)
						else
							cachedStats[statName] = statValue
						end
					end

					if send then
						_L.Network.Fire("New Stats", player, dataToSend)
					end

					-- old version
					--[[
					_L.Network.Fire("New Stats", player, _L.Storage.Stats["u" .. player.UserId])
					cachedStats = _L.Services.HttpService:JSONEncode(_L.Storage.Stats["u" .. player.UserId])
					]]
				end
				--
				_L.Services.RunService.Heartbeat:wait()
			end

			--
			return true
		end
	end

	--- Attempt to initialize stats
	local attempts = 0
	local success = false
	while (not success and attempts < 3 and player) do
		success = InitPlayer(player)
		wait()
		--
		if not success then
			attempts = attempts + 1
			wait(.5)
		end
	end

	--- Let player know stats failed to initialize
	if not success and player then
		_L.Print("MAJOR ERROR: Could not init [bold]" .. player.Name .. "[/bold]'s stats!", true)
		_L.Network.Fire("New Stats", player, "Error")
	end
end


function Saving.Get(player)
	--- Attempt to get session stats
	local stats = _L.Storage.Stats["u" .. player.UserId]

	--- If failed, attempt to get it again (10 tries)
	if not stats then
		pcall(function()
			local attempts = 0
			while (not stats) and attempts < 10 do
				attempts = attempts + 1
				stats = _L.Storage.Stats["u" .. player.UserId]

				if attempts >= 10 and Debug then
					_L.Print("Failed to index [bold]" .. player.Name .. "[/bold]'s stats", true)
				end

				wait()
			end
		end)
	end

	--
	return stats
end


function Saving.Remove(player)
	--- Remove session stats :(
	local success = pcall(function()
		if _L.Storage.Stats["u" .. player.UserId] ~= nil then
			_L.Storage.Stats["u" .. player.UserId] = nil
		end
	end)

	--- Failed to remove session stats wtf? Should never happen :/
	if not success then
		pcall(function()
			_L.Print("Failed to remove session stats for [bold]" .. player.Name .. "[/bold]!", true)
		end)
	end
end


function Saving.Reset(player)
	--- Reset the player's stats to the default stats
	if _L.Storage.Stats["u" .. player.UserId] then
		_L.Storage.Stats["u" .. player.UserId] = _L.Functions.CloneTable(_L.Settings.DefaultStats)
		Saving.Save(player)
	end
end


function Saving.IsLoaded(player)
	--- Check if player has loaded tag
	return (player and player:FindFirstChild("__LOADED") ~= nil)
end


------------------------------------------------------------------------------


local function PlayerAdded(player)
	--- Player joined! Initialize their stats.
	coroutine.wrap(function()
		Saving.Init(player)
	end)()
end


local function PlayerRemoving(player)
	--- Player left! Save their stats (as session ended)
	Saving.Save(player, true)

	--- Remove their stats after buffer time (to prevent accidental indexes erroring)
	wait(1)
	if game.Players:FindFirstChild(player.Name) == nil then
		Saving.Remove(player)
	end
end


------------------------------------------------------------------------------


--- Loop through players in server (just in-case existing players connected too fast)
for _, p in ipairs(game.Players:GetPlayers()) do  
	PlayerAdded(p)  
end   


--- Player added
game.Players.PlayerAdded:Connect(PlayerAdded)  


--- Player removing
game.Players.PlayerRemoving:Connect(PlayerRemoving)  


--- Attempt to save everyone's stats and show a server close message (TO:DO make update message more professional)
game.OnClose = function()
	if not debugSave then
		--- Save everyone's stats on server
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player then
				wait()
				Saving.Save(player, true)
			end
		end

		--- UPDATE HYPE WOOOOO
		local closeMsg = Instance.new("Message")
		closeMsg.Text = "New update is available! Rejoin :)"
		closeMsg.Parent = game.Workspace
		wait(3)
	end
end


------------------------------------------------------------------------------


--- Base save loop
coroutine.wrap(function()
	--- Save loop
	while true do
		--- Save everyone's stats :D
		pcall(function()
			for statsName, statsData in pairs(_L.Storage.Stats) do
				if statsName and statsData then
					--- Wait buffer time :)))
					wait(saveDuration / (#game.Players:GetPlayers()))

					--- Apparently optional in most games lol
					local playerId = tonumber(string.sub(statsName, 2))
					local player = game.Players:GetPlayerByUserId(playerId)
					if player then
						Saving.Save(player)
					end
				end
			end
		end)

		--
		wait()
	end
end)()


------------------------------------------------------------------------------


--- Return stats on invoke
_L.Network.Invoked("Get Stats").OnInvoke = function(player, ...)
	local args = {...}
	return (Saving.Get(player) or "Error")
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Saving
