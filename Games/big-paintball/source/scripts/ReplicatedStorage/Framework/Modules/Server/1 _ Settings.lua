--[[
                                                                        ....= = = .          
                                                    ....= = = = = -----===============          
                                 ....= = = = -----===================================          
            .....= = = = -----======================================================-         
       .-=======================================================================-         
       -=========================================================================         
       -============================================================-= ..    ..= ===         
       = ==================================--= = = ====== .       .-=====     ...     --        
       .=============---=== = = .=====-    -==     ====     .= = .    = ===     -===== = = --=        
        ==....          ==    -====-    = =-    -==     -====== --===.   = ===========.       
        -=         ..= = = ==.   = =====    .=-    = =.   .============.   .======-= = = -.       
        -======.   -=======     ..       .==    .==     ======== -= -==     -====-    ==        
        = =======    .======-              ==    .=-    = =====.   = ===     .= = .    = ==        
        .======-    ======-    --====    ===    .==-.    ...    = ====-= .      .= -==-       
         =======    -======    ======.   -==    ====-= .     .= ===========--========       
         -======.   = ======.   -====== ...-=== = = -===================================.      
         = =======  ..= ======----=====================================================       
         .========================================================================-       
         .=======================================================-----= = = = = ....           
          ===================================----= = = = = = .....       .    .= = ---= .          
          -===============-----= = = ......           .= = = .   --=======.  -==-= = = -=.         
           .= = .....            .= = = .     .====-    ====-   -==..      .==== ..             
                 = -====-=       =====.     ======   -==-==   -=== = = = = .   = -========          
               .==-= ..= =-=     .=== = ==.    -== = ==. === = ==.  = ===-= = = .        ..-==.        
               -==.           = ==. -=-    -=- = ==.==..==.  .==-        = =-= ..= -==         
               -==.  = ----=    -=== = -==-   = ==  -====  ===   .===-----==  .--====-= .         
               -===   ..= ==-  = ==--= = = ==-  = ==. .===-  -==    --= = = = = ...                    
                -==-= = = -===  ===.    = --=   = = .  ...                                       
                 .= ----. = =   ..                                                     
                 
                     
    Aimee's rbx.lua Framework [2022] - [2023]
    Written by Aimee - aimee@alyocord.com
    Developed with keyboards and pixie dust.
	
	-+-+-+- SPECIFICS -+-+-+-
	_L.Settings
	===========
	Holds a bunch of 'global' settings so they can be accessed very easily via _L.
	===========
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------|       Top       |--------
local Settings = {}

--------|     Setting     |--------

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------
local isStudio = game:GetService("RunService"):IsStudio()
--------|    Variables    |--------
local creditsVariable = nil
local productionCredits = 50000
local devCredits = 123456789
local totalKills = nil
local testingKills = 123456789
local productionKills = 0
local testMap -- Don't add any ='s to this! It's intended to be like this.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[ We check for studio so that we don't have to change settings like credits
Before publishing. Extremely useful, you can add as many variables to this as possible.

e.g.

if isStudio then
	credits = devstuff
	coolthing = true
	admin = yes
else
	credits = brokepeople
	coolthing = false
	admin = no
end
]]
-- 
if isStudio then -- Studio Check
	creditsVariable = devCredits -- If it's studio, set to devCredits variable
	totalKills = testingKills
	testMap = true
else
	cashVariable = productionCredits -- Otherwise, use the production variables
	totalKills = productionKills
	testMap = false
end

return {
	Rounds = {
		VoteTime = 10, 
		TDMRoundTime = 600, 
		KOTHRoundTime = 600, 
		FFARoundTime = 420, 
		KOTHMaxScore = 800, 
		SkipVoting = false, 
		EnableTestMap = testMap, 
		DefaultMap = "Bridge 2019"
	}, 
	DefaultStats = {
		Guns = {
			{
				n = "1", 
				kills = 0, 
				dmg = 0
			},
			--[[{
				n = "10", 
				kills = 0, 
				dmg = 0
			},]]
			{
				n = "11", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "12", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "13", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "14", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "15", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "16", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "17", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "18", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "19", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "2", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "20", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "21", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "23", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "24", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "25", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "27", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "28", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "29", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "3", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "30", 
				kills = 0, 
				dmg = 0
			},			{
				n = "31", 
				kills = 0, 
				dmg = 0
			},			{
				n = "32", 
				kills = 0, 
				dmg = 0
			},			{
				n = "33", 
				kills = 0, 
				dmg = 0
			},			{
				n = "34", 
				kills = 0, 
				dmg = 0
			},			{
				n = "35", 
				kills = 0, 
				dmg = 0
			},			{
				n = "36", 
				kills = 0, 
				dmg = 0
			},			{
				n = "37", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "38", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "39", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "4", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "40", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "41", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "42", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "44", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "46", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "47", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "48", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "49", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "5", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "50", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "51", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "52", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "53", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "56", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "57", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "58", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "59", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "6", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "60", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "61", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "62", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "63", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "694201", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "7", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "70", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "71", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "72", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "75", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "76", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "8", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "99", 
				kills = 0, 
				dmg = 0
			},
			{
				n = "45",
				kills = 999999,
				dmg = 999999999
			}
		}, 
		Equipped = "3", 
		Challenges = {}, 
		Level = 1, 
		Stars = 4, 
		CareerKills = totalKills, 
		OwnedStreaks = { "1","2","3","4","5","6","7","8","9" }, 
		Streaks = {
			["1"] = "1", 
			["2"] = "2", 
			["3"] = "3", 
			["4"] = "4",
			["5"] = "5", 
			["6"] = "6", 
			["7"] = "7", 
			["8"] = "8",
			["9"] = "9"
		}, 
		SlotCount = 5, 
		WinterKills = 0, 
		WinterKillsPartTwo = 0, 
		WinterKillsPartThree = 0, 
		GuassGunPromoRedeemed = false, 
		Credits = creditsVariable, 
		Gamepasses = {}, 
		LastSaveTimestamp = 0, 
		PlayingSession = false, 
		RobuxSpent = 0, 
		PaidPlayer = true, 
		HasPlayedBefore = false
	}, 
	Shop = {
		ExtraSlotPrice = 15000000
	}, 
	StatsVersion = "BetaStats", 
	SavePlayerID = 0, 
	DisableSaving = game:GetService("RunService"):IsStudio(), 
	DisableLoading = false, 
	SaveDebugging = false, 
	SaveDuration = 60, 
	ReplicateOtherStatsInstantly = false, 
	ReplicateOtherStatsBuffer = 0.33, 
	StatsNetworkingBlacklist = {}, 
	DatastoreDebug = false, -- set to true if issues
	DatastoreQueueWaitTime = 6, 
	DatastoreSetAttempts = 5, 
	DatastoreGetAttempts = 5, 
	DatastoreUpdateAttempts = 5, 
	DisableGamepassAutomaticOwnership = false, 
	BanVersion = 2, 
	AdminsBannable = false, 
	WarnTime = 259200, 
	SuperAdmins = { -1, -2, -3, 19717956, 40222641, 1210210, 63844404, 50801509, game.CreatorId }, 
	CustomChatTags = { {
		userIds = { game.CreatorId }, 
		tag = {
			tag = "\240\159\151\186\239\184\143Gavin", 
			tagColor = Color3.fromRGB(135, 255, 239)
		}
	} }
};
