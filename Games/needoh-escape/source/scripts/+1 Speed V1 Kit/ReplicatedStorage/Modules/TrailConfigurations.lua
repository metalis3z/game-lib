--!strict
-- LOCATION: ReplicatedStorage/Modules/TrailConfigurations
local TrailConfigurations = {}
TrailConfigurations.Trails = {
	{
		ID = "OrangeTrail",
		Name = "Orange Trail",
		SpeedBoost = 1.5, 
		WinCost = 25,
		ProductId = 3604736844, 
		Color = ColorSequence.new(Color3.fromRGB(255, 85, 0)),
		Image = "rbxassetid://106953796028431", 
	},
	{
		ID = "BlueTrail",
		Name = "Blue Trail",
		SpeedBoost = 2,
		Range = 2, 
		WinCost = 50,
		ProductId = 3604736902 ,
		Color = ColorSequence.new(Color3.fromRGB(0, 170, 255)),
		Image = "rbxassetid://80823398251140",
	},
	{
		ID = "GreenTrail",
		Name = "Green Trail",
		SpeedBoost = 2.5,
		Range = 2, 
		WinCost = 75,
		ProductId = 3604736975,
		Color = ColorSequence.new(Color3.fromRGB(0, 255, 0)),
		Image = "rbxassetid://89306781652186",
	},
	{
		ID = "PurpleTrail",
		Name = "Purple Trail",
		Range = 2, 
		SpeedBoost = 2.75,
		WinCost = 100,
		ProductId = 3604737034,
		Color = ColorSequence.new(Color3.fromRGB(85, 0, 127)),
		Image = "rbxassetid://74735631371205",
	},
	{
		ID = "RainbowTrail",
		Name = "Rainbow Trail",
		Range = 3, 
		SpeedBoost = 5,
		WinCost = 125,
		ProductId = 3604737365,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)),
		}),
		Image = "rbxassetid://88071004661466",
	}
}
function TrailConfigurations.GetTrailById(id: string)
	for _, trail in ipairs(TrailConfigurations.Trails) do
		if trail.ID == id then return trail end
	end
	return nil
end
function TrailConfigurations.GetTrailByProductId(productId: number)
	for _, trail in ipairs(TrailConfigurations.Trails) do
		if trail.ProductId == productId then return trail end
	end
	return nil
end
return TrailConfigurations