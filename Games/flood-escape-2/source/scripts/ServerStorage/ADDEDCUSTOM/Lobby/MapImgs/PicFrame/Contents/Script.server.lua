-- Variables
local imageHolder = script.Parent.Holder
local mapImages = {}
local currentImageIndex = 0
local serverStorageService = game:GetService("ServerStorage")

-- Check Images
local function updateMapImages()
	mapImages = {} -- Reset Images
	local storedMaps = serverStorageService.Maps:GetChildren() -- Get Current Maps
	for _, mapModel in pairs(storedMaps) do
		if mapModel:IsA("Model") then
			local Settings = mapModel:WaitForChild("Settings")
			local mapImage = Settings:GetAttribute("MapImage") or Settings:FindFirstChild("MapImage") and Settings.MapImage.Value
			if mapImage and mapImage ~= 0 then
				table.insert(mapImages, mapImage)
			end
		end
	end
	-- Shuffle Images
	for i = 1, #mapImages do
		local randomIndex = math.random(1, #mapImages)
		mapImages[i], mapImages[randomIndex] = mapImages[randomIndex], mapImages[i]
	end
end

-- Initial Check
updateMapImages()

-- Listen For New Maps
serverStorageService.Maps.ChildAdded:Connect(function(child)
	if child:IsA("Model") then
		updateMapImages()
	end
end)

-- Listen For Map Removals
serverStorageService.Maps.ChildRemoved:Connect(function(child)
	if child:IsA("Model") then
		updateMapImages()
	end
end)

-- Display images
if #mapImages >= 1 then
	repeat
		currentImageIndex = (currentImageIndex % #mapImages) + 1
		imageHolder.Img1.Image = "rbxassetid://"..mapImages[currentImageIndex]
		for i = 1, 270 do
			imageHolder.Img1.ImageTransparency = 1 - (i / 30)
			imageHolder.Img2.ImageTransparency = i / 30
			imageHolder.Img1.Position = UDim2.fromScale(-(i / 270) * .76, 0)
			wait()
		end
		currentImageIndex = (currentImageIndex % #mapImages) + 1
		imageHolder.Img2.Image = "rbxassetid://"..mapImages[currentImageIndex]
		for i = 1, 270 do
			imageHolder.Img1.ImageTransparency = i / 30
			imageHolder.Img2.Position = UDim2.fromScale(-.76 + ((i / 270) * .76), 0)
			imageHolder.Img2.ImageTransparency = 1 - (i / 30)
			wait()
		end
	until nil
end