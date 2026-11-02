local Car = script.Parent.Parent.Parent
local HPHealth = Car.Health

local seats = {Car.DriveSeat}
for i,v in pairs(Car:GetDescendants()) do
	if (v:IsA("Seat") or v:IsA("VehicleSeat")) and v~=Car.DriveSeat then
		--print("INSERTED A SEAT")
		table.insert(seats,v)
	end
end

function damageAllSeats()
	for ind,seat in seats do
		
		if seat.Occupant ~= nil then
			seat.Occupant:TakeDamage(30)
		end
		
	end
end

function addFire()
	if Car.FIREPART.Value:FindFirstChild("DefaultSmoke") then Car.FIREPART.Value:FindFirstChild("DefaultSmoke"):Destroy() end
	
	if not Car:FindFirstChild("FIREPART").Value:FindFirstChild("Fire") then
		local Fire,FireSmoke = game.ServerStorage.Cars.CarEffects.Fire,game.ServerStorage.Cars.CarEffects.FireSmoke

		Fire:Clone().Parent = Car:FindFirstChild("FIREPART").Value
		FireSmoke:Clone().Parent = Car:FindFirstChild("FIREPART").Value
	end
	
end

function addSmoke()
	if Car:FindFirstChild("FIREPART").Value:FindFirstChild("Fire") then return end
	if not Car.FIREPART.Value:FindFirstChild("DefaultSmoke") then
		local defaultSmoke = game.ServerStorage.Cars.CarEffects.DefaultSmoke:Clone()
		defaultSmoke.Parent = Car:FindFirstChild("FIREPART").Value
	end
end

spawn(function()
	while wait(0.5) do
		if HPHealth.Value == 0 then
			addFire()
		elseif HPHealth.Value <= 75 then
			addSmoke()
		end
	end	
end)

spawn(function()
	while wait(3) do
		if HPHealth.Value == 0 then
			damageAllSeats()
		end
	end
end)
