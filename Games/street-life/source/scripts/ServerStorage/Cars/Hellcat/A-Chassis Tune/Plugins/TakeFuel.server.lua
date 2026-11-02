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

local fuelDecre = 0.1
local Car = script.Parent.Parent.Parent
local interval = math.random(5, 8)

local MPH = 0
local lastRun = false

game.ReplicatedStorage.FuelHandler.OnServerEvent:Connect(function(p,car,mph)
	if car and car == Car then
		if Car.DriveSeat.Occupant then
			local player = game.Players:GetPlayerFromCharacter(Car.DriveSeat.Occupant.Parent)
			local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")
			local Car = UI.Car.Value
			MPH = mph
		end
	end
end)

while wait(interval) do
	if Car.DriveSeat.Occupant then
		local player = game.Players:GetPlayerFromCharacter(Car.DriveSeat.Occupant.Parent)
		local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")	
		if MPH ~= 0 then
			local newFuel = Car.FUEL.Value - fuelDecre
			Car.FUEL.Value = math.clamp(newFuel, 0, 10)

			if Car.FUEL.Value == 0 then
				UI:FindFirstChild("FuelOut").Value = true
			end
		end
	end
	interval = math.random(5, 8)
end