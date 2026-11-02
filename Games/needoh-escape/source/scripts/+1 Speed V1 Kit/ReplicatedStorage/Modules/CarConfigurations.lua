--!strict
-- LOCATION: ReplicatedStorage/Modules/CarConfigurations

local CarConfigurations = {}

CarConfigurations.Cars = {
}

function CarConfigurations.GetCarById(id: string)
	for _, car in ipairs(CarConfigurations.Cars) do
		if car.ID == id then return car end
	end
	return nil
end

function CarConfigurations.GetCarByProductId(productId: number)
	for _, car in ipairs(CarConfigurations.Cars) do
		if car.ProductId == productId then return car end
	end
	return nil
end

return CarConfigurations