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
local interval = math.random(7,12)

local MPH = 0
local lastRun = false

game.ReplicatedStorage.SENDSERVER.OnServerEvent:Connect(function(p,car,mph)
	
	--print("sendserver")
	if car and car == Car then
		local player = game.Players:GetPlayerFromCharacter(Car.DriveSeat.Occupant.Parent)
		local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")
		local Car = UI.Car.Value

		MPH = mph
	end
	
end)

while wait(interval) do
	
	--print("Is car running?")
	
	--if Car.Parent == game.Workspace then
	--	return
	--end	
	
	if Car.DriveSeat.Occupant then
		local player = game.Players:GetPlayerFromCharacter(Car.DriveSeat.Occupant.Parent)
		local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")	
		--local MPH = math.floor(UNITS[currentUnits].scaling*UI.Values.Velocity.Value.Magnitude) 
		if MPH ~= 0 then
			--print("reduce")
			local newFuel = Car.FUEL.Value - fuelDecre
			Car.FUEL.Value = math.clamp(newFuel,0,10)
			
			if Car.FUEL.Value == 0 then
			--	print("car shutting down, no fuel..")
				UI:FindFirstChild("FuelOut").Value = true
			end
			
		else
			--print(MPH)
		end
	else
		--print("No occupant!")
	end
	
	interval = math.random(7,12)
end