local UNITS	= {								--Click on speed to change units
	--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (80/75)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 430				,
		spInc			= 100			, -- Increment between labelled notches
	},

	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 470				,
		spInc			= 40				, -- Increment between labelled notches
	},

	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 600				,
		spInc			= 40				, -- Increment between labelled notches
	}
}

local currentUnits = 1

local Player = game.Players.LocalPlayer
local GUI = Player.PlayerGui:WaitForChild("A-Chassis Interface")
local car = script.Parent.Car.Value
local maxFuel = 10
local updatedTo = 10

function updateFuel()
	local newValue = car.FUEL.Value
	updatedTo = newValue
	local UI = Player.PlayerGui
	if UI:FindFirstChild("CarGui") then
		local bar = UI:FindFirstChild("CarGui"):FindFirstChild("Frame"):FindFirstChild("FuelBG"):FindFirstChild("FuelOverlay")
		bar:TweenSize(UDim2.new(newValue / maxFuel, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.05, true)
	end
end

local lastMPH = 0

GUI.Values.Velocity.Changed:connect(function(property)
	if car.DriveSeat.Occupant then
		local player = game.Players:GetPlayerFromCharacter(car.DriveSeat.Occupant.Parent)
		local MPH = math.floor(UNITS[currentUnits].scaling*GUI.Values.Velocity.Value.Magnitude)
		lastMPH = MPH
		player.PlayerGui:FindFirstChild("CarGui").Frame.MPH.Text = MPH .. " mph"
	end	
end)

car.FUEL.Changed:Connect(updateFuel)

while wait(1) do
	spawn(function()
		if updatedTo ~= car.FUEL.Value then
			updateFuel()
		end
		game.ReplicatedStorage.SENDSERVER:FireServer(car,lastMPH)
	end)
end