local InsertService = game:GetService("InsertService")

-- Configuration
local zombieModel = script.Parent -- Adjust this to point to your Zombie model
local accessoryIds = {
	14393954575, -- Example: Pal Hair
	73365705486556, -- Example: Pal Hair
	17613552529, -- Example: Pal Hair
	109601767460422, -- Example: Golden Headphones
	-- Add as many IDs as you like here
}

local function equipRandomAccessory(character)
	-- Pick a random ID from the list
	local randomIndex = math.random(1, #accessoryIds)
	local assetId = accessoryIds[randomIndex]

	local success, model = pcall(function()
		return InsertService:LoadAsset(assetId)
	end)

	if success and model then
		-- InsertService returns a Model containing the Accessory
		local accessory = model:FindFirstChildOfClass("Accessory")
		if accessory then
			accessory.Parent = character
			print("Equipped accessory ID: " .. assetId)
		end
		-- Clean up the temporary container model
		model:Destroy()
	else
		warn("Failed to load accessory ID: " .. assetId)
	end
end

-- Run the function
equipRandomAccessory(zombieModel)