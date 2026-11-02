--//AC6 Ported Plugin [SS6]//--
--//SecondLogic x INSPARE 2017//--

-- Corsa Edition: Modified RTRA Tires so they're less crake
-- For now, I recommend not messing with tires. Feedback is highly suggested.
-- Modified by Genesis_kun

local _Select = "Slicks"

-- Current presets:

-- LowProfile
-- AllSeason
-- Summer 
-- Sport
-- Performance
-- StreetSemiSlicks
-- TrackSemiSlicks
-- Slicks
-- Rally
-- Winters

-- Read notes below for an explanation on tire behavior. 
-- If you spell the presets wrong or do not select any presets it will default to LowProfile so please check it.

local _LowProfile = {

--[[ LOW PROFILE - Low grip tires made for low HP drifting/sliding

--Details : Overall Bad Performance
          : Really fun for cars that have less than 200HP

--Notes : 0.40130597014   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.39862759643   Friction on Concrete
          0.38657270029   Min Friction on Concrete
          0.37321428571   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.34945652173   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.3095          Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.38657270029   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)
--]]

	TireWearOn         = true    ,

	--Friction and Wear
	FWearSpeed			= .00125, 
	FTargetFriction   	= .3875 ,
	FMinFriction      	= 0.375 ,
	RWearSpeed        	= .00125, 
	RTargetFriction    	= .3875 ,
	RMinFriction    	= 0.375 ,

	--Tire Slip
	TCSOffRatio        	= 1/1   ,
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.25,  

	--Wheel Properties
	FFrictionWeight    	= 8.125 , 
	RFrictionWeight    	= 8.125 , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _AllSeason = {

--[[ ALL SEASON - Adequate performance in Winter/Summer

--Details : Worse than Summer in Normal Driving Conditions
          : Slightly Better Performance than Summer in the Wet
          : Superior to Summer in Snow

--Notes : 0.44756097561   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.44514563106   Friction on Concrete
          0.43300970873   Min Friction on Concrete
          0.40833333333   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.38461538461   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.34642857142   Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.32166666666   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = true    ,

	--Friction and Wear
	FWearSpeed			= .005   , 
	FTargetFriction   	= .4375  ,
	FMinFriction      	= .425   ,

	RWearSpeed        	= .005   , 
	RTargetFriction    	= .4375  ,
	RMinFriction    	= .425   ,

	--Tire Slip
	TCSOffRatio        	= 1/1   ,
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.275,  

	--Wheel Properties
	FFrictionWeight    	= 10    , 
	RFrictionWeight    	= 10    , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _Summer = {

--[[ SUMMER - For standard everyday use in Summer

--Details : Better than AllSeasons in Normal Driving Conditions
          : Slightly Worse Performance than AllSeason in the Wet
          : Worse than AllSeasons in Snow

--Notes  :0.46904761904   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.46415094339   Friction on Concrete
          0.4287735849    Min Friction on Concrete
          0.4             Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.36666666666   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.315           Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.275           Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = true    ,

	--Friction and Wear
	FWearSpeed			= .00875  , 
	FTargetFriction   	= .45     , 
	FMinFriction      	= .4125   ,

	RWearSpeed        	= .00875  , 
	RTargetFriction    	= .45	  ,
	RMinFriction    	= .4125   ,

	--Tire Slip
	TCSOffRatio        	= 1/1   ,
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.2875,  

	--Wheel Properties
	FFrictionWeight    	= 5     , 
	RFrictionWeight    	= 5     , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _Sport = { 

--[[ SPORT - Tires designed for Spirited driving.

--Details : Reccomended for 350-500HP cars

--Notes : 0.53181818181   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.52142857142   Friction on Concrete
          0.42098214285   Min Friction on Concrete
          0.4             Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.35714285714	  Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.29375         Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.24722222222   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = true    ,

	--Friction and Wear
	FWearSpeed			= .0375    , 
	FTargetFriction   	= .5       , 
	FMinFriction      	= 0.3875   ,

	RWearSpeed        	= .0375    , 
	RTargetFriction    	= .5       ,
	RMinFriction    	= 0.3875   ,

	--Tire Slip
	TCSOffRatio        	= 1/1   ,
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.3125,  

	--Wheel Properties
	FFrictionWeight    	= 2.5   , 
	RFrictionWeight    	= 2.5   , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _Performance = { 

--[[ PERFORMANCE - Tires designed for Performance driving.

--Details : Recommended for Performance cars made for the Street
          : For cars with 500-700HP

--Notes : 0.625           Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.59423076923   Friction on Concrete
          0.41153846153   Min Friction on Concrete
          0.38541666666   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.33620689655   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.26470588235   Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.21474358974   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)
--]]

	TireWearOn         = true    ,

	--Friction and Wear
	FWearSpeed			= .09375  , 
	FTargetFriction   	= .5625   , 
	FMinFriction      	= 0.325   ,

	RWearSpeed        	= .09375  , 
	RTargetFriction    	= .5625   ,
	RMinFriction    	= 0.325   ,

	--Tire Slip
	TCSOffRatio        	= 1/1   ,
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.3375,

	--Wheel Properties
	FFrictionWeight    	= 1.0   , 
	RFrictionWeight    	= 1.0   , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _StreetSemiSlicks = { 

--[[ STREET SEMI SLICKS - Tires for road-legal Track cars.
	
--Details : Street Legal Semi-Slicks
          : Avoid Running this on the Street due to High Tire Wear

--Notes : 0.69166666666   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.6453125       Friction on Concrete
          0.3953125       Min Friction on Concrete
          0.37386363636   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.32314814814   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.24921875      Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.19864864864   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = false    ,

	--Friction and Wear
	FWearSpeed			= .1875  , 
	FTargetFriction   	= .6125  , 
	FMinFriction      	= 0.2125 ,

	RWearSpeed        	= .1875  , 
	RTargetFriction    	= .6125  ,
	RMinFriction    	= 0.2125 ,

	--Tire Slip
	TCSOffRatio        	= 1/1    ,
	WheelLockRatio    	= 1/6    , 
	WheelspinRatio    	= 1/1.35 ,  

	--Wheel Properties
	FFrictionWeight    	= 0.5   , 
	RFrictionWeight    	= 0.5   , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _TrackSemiSlicks = {

--[[ TRACK SEMI SLICKS - Tires for specifcially made Track cars.
	
--Details : Better than Street Semi Slicks
          : Only legal for Track usage

--Notes : 0.7375          Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.67916666666   Friction on Concrete
          0.3875          Min Friction on Concrete
          0.37180232558   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.32051886792   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.24583333333   Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.19503424657   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = true   ,

	--Friction and Wear
	FWearSpeed        	= .3125  ,
	FTargetFriction   	= .65  , 
	FMinFriction      	= 0.1375 ,

	RWearSpeed        	= .3125  , 
	RTargetFriction    	= .65    , 
	RMinFriction    	= 0.1375 , 

	--Tire Slip
	TCSOffRatio        	= 1/1    , 
	WheelLockRatio    	= 1/6    , 
	WheelspinRatio   	= 1/1.3625,  

	--Wheel Properties
	FFrictionWeight    	= 0.375 , 
	RFrictionWeight    	= 0.375 , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0 , 
	RElasticity        	= 0 , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}


local _Slicks = {

--[[ SLICKS - Tires designed strictly for the Track

--Details : Grippiest on Asphalt and Concrete 
          : Literally don't bother driving it in the Wet
          : EXTREMELY HIGH TIRE WEAR
          : Only legal for Track usage

--Notes : 0.79375         Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.71704545454   Friction on Concrete
          0.38181818181   Min Friction on Concrete
          0.36845238095   Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.31682692307   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.24153225806   Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.190625        Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)
          

--]]

	TireWearOn         = false   ,

	--Friction and Wear
	FWearSpeed        	= .4375 , 
	FTargetFriction    	= .7375 , 
	FMinFriction     	= 0     ,

	RWearSpeed        	= .4375 , 
	RTargetFriction    	= .7375 , 
	RMinFriction    	= 0     ,

	--Tire Slip
	TCSOffRatio        	= 1     , 
	WheelLockRatio    	= 1/6   , 
	WheelspinRatio    	= 1/1.375,  

	--Wheel Properties
	FFrictionWeight    	= 0.25  , 
	RFrictionWeight    	= 0.25  , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1    	, 
	RElastWeight    	= 1    	, 
	FLgcyElWeight    	= 10   	, 
	RLgcyElWeight    	= 10   	, 

	--Wear Regen
	RegenSpeed        = 3.6		, 
}

local _Rally = { 

--[[ RALLY - Tires made for Rallying

--Details : NOT STREET LEGAL AT ALL
          : Superior Snow Performance to Everything except Winters
          : Comparable Performance to Performance Tires in Normal Driving Conditions
          : EXTREMELY HIGH TIRE WEAR

--Notes : 0.59596774193   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.59182692307   Friction on Concrete
          0.3875          Min Friction on Concrete
          0.4925          Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.45681818181   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.40625         Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.36538461538   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = false    ,

	--Friction and Wear
	FWearSpeed			= .2125     , 
	FTargetFriction   	= .5875   	, 
	FMinFriction      	= 0.3875    ,

	RWearSpeed        	= .2125     , 
	RTargetFriction    	= .5875     ,
	RMinFriction    	= 0.3875    ,

	--Tire Slip
	TCSOffRatio        	= 1/1    ,
	WheelLockRatio    	= 1/6    , 
	WheelspinRatio    	= 1/1.325,  

	--Wheel Properties
	FFrictionWeight    	= 7.5   , 
	RFrictionWeight    	= 7.5   , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

local _Winters = { 

--[[ SNOW - Tires made for Snow driving

--Details : Street Legal? Yes
          : Best Snow Performance
          : Performs worse AllSeason and Summer Tires under Normal Driving Conditions
          : High Tire Wear
          

--Notes : 0.42641196013   Friction on 0.85 Friction and 0.25 Friction Weight (Simulated Asphalt)
          0.42609561753   Friction on Concrete
          0.41364541832   Min Friction on Concrete
          0.4203125       Friction on 0.35  Friction and 5 Friction Weight (Edited Grass)
          0.41538461538   Friction on 0.30  Friction and 6.25 Friction Weight (Simulated Light Showers)
          0.40681818181   Friction on 0.225 Friction and 7.5 Friction Weight (Simulated Heavy Downpour)
          0.39888059701   Friction on 0.175 Friction and 8.75 Friction Weight (Simulated Snow)

--]]

	TireWearOn         = false    ,

	--Friction and Wear
	FWearSpeed			= .0075  , 
	FTargetFriction   	= .425   , 
	FMinFriction      	= 0.4125 ,

	RWearSpeed        	= .0075  , 
	RTargetFriction    	= .425   ,
	RMinFriction    	= 0.4125 ,

	--Tire Slip
	TCSOffRatio        	= 1/1    ,
	WheelLockRatio    	= 1/6    , 
	WheelspinRatio    	= 1/1.2625,  

	--Wheel Properties
	FFrictionWeight    	= 75    , 
	RFrictionWeight    	= 75    , 
	FLgcyFrWeight    	= 0     , 
	RLgcyFrWeight    	= 0     , 

	FElasticity        	= 0     , 
	RElasticity        	= 0     , 
	FLgcyElasticity    	= 0     , 
	RLgcyElasticity    	= 0     , 

	FElastWeight    	= 1     , 
	RElastWeight    	= 1     , 
	FLgcyElWeight    	= 10    , 
	RLgcyElWeight    	= 10    , 

	--Wear Regen
	RegenSpeed        	= 3.6	, 
}

--leave everything down here alone

local car = script.Parent.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])
local cValues = script.Parent.Parent:WaitForChild("Values")
local Compound = script.Parent.COMPOUND


if _Select == "Slicks" then
	_WHEELTUNE = _Slicks
	Compound.Text = "Compound: " .. _Select
elseif _Select == "TrackSemiSlicks" then
	_WHEELTUNE = _TrackSemiSlicks
	Compound.Text = "Compound: " .. _Select
elseif _Select == "StreetSemiSlicks" then
	_WHEELTUNE = _StreetSemiSlicks
	Compound.Text = "Compound: " .. _Select
elseif _Select == "Performance" then
	_WHEELTUNE = _Performance
	Compound.Text = "Compound: " .. _Select
elseif _Select == "Sport" then
	_WHEELTUNE =  _Sport
	Compound.Text = "Compound: " .. _Select
elseif _Select == "Summer" then
	_WHEELTUNE = _Summer
	Compound.Text = "Compound: " .. _Select
elseif _Select == "AllSeason" then
	_WHEELTUNE = _AllSeason
	Compound.Text = "Compound: " .. _Select
elseif _Select == "Rally" then
	_WHEELTUNE = _Rally
	Compound.Text = "Compound: " .. _Select
elseif _Select == "Winters" then
	_WHEELTUNE = _Winters
	Compound.Text = "Compound: " .. _Select
else 
	_WHEELTUNE = _LowProfile
	Compound.Text = "Compound: " .. _Select
end

car.DriveSeat.TireStats.Fwear.Value = _WHEELTUNE.FWearSpeed
car.DriveSeat.TireStats.Ffriction.Value = _WHEELTUNE.FTargetFriction
car.DriveSeat.TireStats.Fminfriction.Value = _WHEELTUNE.FMinFriction
car.DriveSeat.TireStats.Ffweight.Value = _WHEELTUNE.FFrictionWeight

car.DriveSeat.TireStats.Rwear.Value = _WHEELTUNE.RWearSpeed
car.DriveSeat.TireStats.Rfriction.Value = _WHEELTUNE.RTargetFriction
car.DriveSeat.TireStats.Rminfriction.Value = _WHEELTUNE.RMinFriction
car.DriveSeat.TireStats.Rfweight.Value = _WHEELTUNE.RFrictionWeight

car.DriveSeat.TireStats.TCS.Value = _WHEELTUNE.TCSOffRatio
car.DriveSeat.TireStats.Lock.Value = _WHEELTUNE.WheelLockRatio
car.DriveSeat.TireStats.Spin.Value = _WHEELTUNE.WheelspinRatio
car.DriveSeat.TireStats.Reg.Value = _WHEELTUNE.RegenSpeed

--Wheels Array
local fDensity = _Tune.FWheelDensity
local rDensity = _Tune.RWheelDensity
local fFwght = _WHEELTUNE.FFrictionWeight
local rFwght = _WHEELTUNE.RFrictionWeight
local fElast = _WHEELTUNE.FElasticity
local rElast = _WHEELTUNE.RElasticity
local fEwght = _WHEELTUNE.FElastWeight
local rEwght = _WHEELTUNE.RElastWeight
if not workspace:PGSIsEnabled() then
	fDensity = _Tune.FWLgcyDensity
	rDensity = _Tune.RWLgcyDensity
	fFwght = _WHEELTUNE.FLgcyFrWeight
	rFwght = _WHEELTUNE.FLgcyFrWeight
	fElast = _WHEELTUNE.FLgcyElasticity
	rElast = _WHEELTUNE.RLgcyElasticity
	fEwght = _WHEELTUNE.FLgcyElWeight
	rEwght = _WHEELTUNE.RLgcyElWeight
end
local Wheels = {}
for i,v in pairs(car.Wheels:GetChildren()) do
	local w = {}
	w.wheel = v
	local ca
	w.x = 0
	if v.Name == "FL" or v.Name == "FR" or v.Name == "F" then
		ca = (12-math.abs(_Tune.FCamber))/15
		w.x = fDensity
		w.BaseHeat = _WHEELTUNE.FTargetFriction-_WHEELTUNE.FMinFriction
		w.WearSpeed = _WHEELTUNE.FWearSpeed
		w.fWeight = fFwght
		w.elast = fElast
		w.eWeight = fEwght
	else
		ca = (12-math.abs(_Tune.RCamber))/15
		w.x = rDensity
		w.BaseHeat = _WHEELTUNE.RTargetFriction-_WHEELTUNE.RMinFriction
		w.WearSpeed = _WHEELTUNE.RWearSpeed
		w.fWeight = rFwght
		w.elast = rElast
		w.eWeight = rEwght
	end
	--if car:FindFirstChild("WearData")~=nil then
	--	w.Heat = math.min(w.BaseHeat,car.WearData[v.Name].Value+(((tick()-car.WearData.STime.Value)*_WHEELTUNE.RegenSpeed*15/10000)))
	--else
	w.Heat = w.BaseHeat
	--end
	w.stress = 0
	table.insert(Wheels,w)
end

--Close/Store Wear Data
car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		local wD=car:FindFirstChild("WearData")
		if car:FindFirstChild("WearData")==nil then
			wD = script.Parent.WearData:Clone()
			wD.Parent=car
		end
		for i,v in pairs(Wheels) do
			wD[v.wheel.Name].Value = v.Heat
		end
		wD.STime.Value=tick()
	end
end)

--Runtime Loop
while wait() do
	for i,v in pairs(Wheels) do
		--Vars
		local speed = car.DriveSeat.Velocity.Magnitude
		local wheel = v.wheel.RotVelocity.Magnitude
		local z = 0		
		local deg = 0.000126

		--Tire Wear
		local cspeed = (speed/1.298)*(2.6/v.wheel.Size.Y) 
		local wdif = math.abs(wheel-cspeed)
		if _WHEELTUNE.TireWearOn then
			if speed < 4 then
				--Wear Regen
				v.Heat = math.min(v.Heat + _WHEELTUNE.RegenSpeed/10000,v.BaseHeat)
			else
				--Tire Wear
				if wdif > 1 then
					v.Heat = v.Heat - wdif*deg*v.WearSpeed/28
				elseif v.Heat >= v.BaseHeat then
					v.Heat = v.BaseHeat
				end
			end
		end

		--Apply Friction
		if v.wheel.Name == "FL" or v.wheel.Name == "FR" or v.wheel.Name == "F" then
			z = _WHEELTUNE.FMinFriction+v.Heat
			deg = ((deg - 0.0001188*cValues.Brake.Value)*(1-math.abs(cValues.SteerC.Value))) + 0.00000126*math.abs(cValues.SteerC.Value)
		else
			z = _WHEELTUNE.RMinFriction+v.Heat
		end

		--Tire Slip
		if math.ceil((wheel/0.774/speed)*100) < 8 then
			--Lock Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelLockRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif (_Tune.TCSEnabled and cValues.TCS.Value == false and math.ceil((wheel/0.774/speed)*100) > 80) then
			--TCS Off
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.TCSOffRatio,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.max(v.Heat,0)
		elseif math.ceil((wheel/0.774/speed)*100) > 130 then
			--Wheelspin
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z*_WHEELTUNE.WheelspinRatio,v.elast,v.fWeight,v.eWeight)		
			v.Heat = math.max(v.Heat,0)
		else
			--No Slip
			v.wheel.CustomPhysicalProperties = PhysicalProperties.new(v.x,z,v.elast,v.fWeight,v.eWeight)
			v.Heat = math.min(v.Heat,v.BaseHeat)
		end 

		--Update UI
		local vstress = math.abs(((((wdif+cspeed)/0.774)*0.774)-cspeed)/15)
		if vstress > 0.05 and vstress > v.stress then 
			v.stress = math.min(v.stress + 0.03,1)
		else
			v.stress = math.max(v.stress - 0.03,vstress)	
		end
		script.Parent:WaitForChild("Tires")
		local UI = script.Parent.Tires[v.wheel.Name]
		UI.First.Second.Image.ImageColor3 = Color3.new(math.min((v.stress*1.0),1), 1-v.stress, 0)
		UI.First.Position = UDim2.new(0,0,1-v.Heat/v.BaseHeat,0)
		UI.First.Second.Position = UDim2.new(0,0,v.Heat/v.BaseHeat,0)
	end
end