--!strict

-- HideCharacter.lua v2.1 by VanillaEdge
-- Shove this directly in the car model, only one copy is needed.

local car = script.Parent

local function setTransparency(character: Instance, transparency: number)
	for _, part in character:GetDescendants() do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" or part:IsA("Decal") then
			part.Transparency = transparency
		end
	end
end

local function handleSeat(seat: VehicleSeat)
	local currentCharacter = nil

	seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		local occupant = seat.Occupant
		local character = occupant and occupant.Parent or currentCharacter :: Model
		if not character then return end
		
		local transparency = occupant and 1 or 0
		setTransparency(character, transparency)
		currentCharacter = occupant and occupant.Parent or nil
	end)
end

for _, seat in car:GetDescendants() do
	if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
		handleSeat(seat)
	end
end
