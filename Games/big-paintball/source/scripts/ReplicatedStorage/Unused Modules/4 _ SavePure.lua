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
                 
                     
    Aimee's rbx.lua Framework [2022] - [2023]
    Written by Aimee - aimee@alyocord.com
    Developed with keyboards and pixie dust.
	
	-+-+-+- SPECIFICS -+-+-+-
	_L.Save
	===========
	Returns player save stats; cached or uncached.
	===========
		\\\ Returns player stats
		Save.Get(
			cached,					<-- |REQ|	Return cached version of save?						[defaults to: false]
		)
		
		\\\ Displays error screen and kicks player. Used internally only.
		Save.Error()
	===========
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
-- TODO: Commented out because this doesn't work, I blame the idiots who coded this.
--------|       Top       |--------
local Save = {}

--------|     Setting     |--------

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function Save.Get(getCache)
	if getCache then
		--- Cache doesn't exist! Usually a timing issue on init. Wait for it to exist :)
		if Save.Cache == nil then
			while (Save.Cache == nil) do  _L.Services.RunService.RenderStepped:wait()  end
		end
		
		--
		return Save.Cache
	else
		--- Grab the latest player stats from server
		local newStats = _L.Network.Invoke("Get Stats")
		--
		if newStats == "Error" then
			--- -SIRENS- Stats errored! -SIRENS-
			Save.Error()
		elseif newStats then
			--- Update cache
			Save.Cache = newStats
		end
		
		--
		return newStats
	end
end


function Save.Error()
	--- UH OH UH OH UH OH
	_L.Print("STATS WERE RETURNED AS ERROR!", true)
	
	--- Slaughter the player out of existence
	game.Players.LocalPlayer.Character = nil
	
	--- Let player know what's going on (commit countdown)
	local msg = Instance.new("Message")
	msg.Parent = game.Workspace
	--
	for i = 1, 10 do
		msg.Text = "Your save failed to load properly. Please try again later! [KICKING: " .. 10 - i .. " SECONDS TO PREVENT DATA LOSS]"
		wait(1)
	end
	--
	game.Players.LocalPlayer:Kick("Your save could not be loaded. You were kicked for safety measures; Try again later!")
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


_L.Network.Fired("New Stats"):Connect(function(...)
	--- New stats arrived from server!
	local args = {...}
	local newStats = args[1]
	--
	
	--if newStats == "Error" then
		--- -SIRENS- Stats errored! -SIRENS-
		--Save.Error()
	
	elseif newStats then
		--- Stats have successfuly arrived! Update cache and let client know.
		Save.Cache = newStats
		_L.Signal.Fire("Stats Changed", newStats)
	end
end)


_L.Network.Fired("Save Fail"):Connect(function(...)
	--- Periodic save failed. Let client know!
	_L.Message.New("Periodic save failed. If this message keeps popping up let us know!")
end)


Save.Get(false)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Save]]