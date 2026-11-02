local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 230				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 370				,
		spInc			= 40				, -- Increment between labelled notches
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 400				,
		spInc			= 40				, -- Increment between labelled notches
	}
}

local currentUnits = 1

local Player = game.Players.LocalPlayer
local GUI = Player.PlayerGui:WaitForChild("A-Chassis Interface")

GUI.Values.Velocity.Changed:connect(function(property)
script.Parent.Frame.Speed.Text = "Speed: "..math.floor(UNITS[currentUnits].scaling*GUI.Values.Velocity.Value.Magnitude) .. " "..UNITS[currentUnits].units
end)