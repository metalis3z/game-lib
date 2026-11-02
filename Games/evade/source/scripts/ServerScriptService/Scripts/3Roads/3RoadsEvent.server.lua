local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Stock = workspace:WaitForChild("Events"):WaitForChild("Stock")
local Shop = workspace:WaitForChild("Shop")
local Codes = workspace:WaitForChild("Map"):WaitForChild("Codes")
local RadioactiveSpin = workspace:WaitForChild("RadioactiveSpinWheels")
local RobuxShop = workspace:WaitForChild("RobuxShop")
local EventBoard = workspace:WaitForChild("EventBoard")
local Model1 = workspace:WaitForChild("Map"):WaitForChild("Model1")
local StealsBoard = workspace:WaitForChild("Map"):WaitForChild("StealsBoard")
local CoinsBoard = workspace:WaitForChild("Map"):WaitForChild("CoinsBoard")
local AdventCalendar = workspace:WaitForChild("AdventCalendar")
local FestiveLuckyBlock = workspace:WaitForChild("Events"):WaitForChild("Festive Lucky Block")
local FuseMachine = workspace:WaitForChild("FuseMachine")

local originalCFrames = {
	Stock = Stock:GetPivot(),
	Shop = Shop:GetPivot(),
	Codes = Codes:GetPivot(),
	RadioactiveSpin = RadioactiveSpin:GetPivot(),
	RobuxShop = RobuxShop:GetPivot(),
	EventBoard = EventBoard:GetPivot(),
	Model1 = Model1:GetPivot(),
	StealsBoard = StealsBoard:GetPivot(),
	CoinsBoard = CoinsBoard:GetPivot(),
	AdventCalendar = AdventCalendar:GetPivot(),
	FestiveLuckyBlock = FestiveLuckyBlock:GetPivot(),
	FuseMachine = FuseMachine:GetPivot()
}

local targetCFrames = {
	Stock = CFrame.new(-363.109, -5.042, 13.906),
	Shop = CFrame.new(-358.752, -5, 53.406) * CFrame.Angles(0, math.rad(-180), 0),
	Codes = CFrame.new(-355.752, 4.25, -138.594),
	RadioactiveSpin = CFrame.new(-462.315, -5.729, 75.205) * CFrame.Angles(0, math.rad(-90), 0),
	RobuxShop = CFrame.new(-462.752, -5, 53.406),
	EventBoard = CFrame.new(-462.167, -3.532, 30.427) * CFrame.fromEulerAnglesYXZ(math.rad(90), math.rad(90), math.rad(0)),
	Model1 = CFrame.new(0, 100000, 0) * CFrame.Angles(0, math.rad(0), 0),
	StealsBoard = CFrame.new(-363.752, 4.75, 258.906) * CFrame.Angles(0, math.rad(180), 0),
	CoinsBoard = CFrame.new(-457.752, 4.75, 258.906) * CFrame.Angles(0, math.rad(180), 0),
	AdventCalendar = CFrame.new(-363.59, 4.351, 30.622) * CFrame.Angles(0, math.rad(-180), 0),
	FestiveLuckyBlock = CFrame.new(-461.646, -9.5, 12.906 )* CFrame.Angles(0, math.rad(180), 0),
	FuseMachine = CFrame.new(-356.75, -9, 85.805) * CFrame.Angles(0, math.rad(-180), 0)
}

local function moveModels(toTarget)
	if toTarget then
		Stock:PivotTo(targetCFrames.Stock)
		Shop:PivotTo(targetCFrames.Shop)
		Codes:PivotTo(targetCFrames.Codes)
		RadioactiveSpin:PivotTo(targetCFrames.RadioactiveSpin)
		RobuxShop:PivotTo(targetCFrames.RobuxShop)
		EventBoard:PivotTo(targetCFrames.EventBoard)
		Model1:PivotTo(targetCFrames.Model1)
		StealsBoard:PivotTo(targetCFrames.StealsBoard)
		CoinsBoard:PivotTo(targetCFrames.CoinsBoard)
		AdventCalendar:PivotTo(targetCFrames.AdventCalendar)
		FestiveLuckyBlock:PivotTo(targetCFrames.FestiveLuckyBlock)
		FuseMachine:PivotTo(targetCFrames.FuseMachine)
	else
		Stock:PivotTo(originalCFrames.Stock)
		Shop:PivotTo(originalCFrames.Shop)
		Codes:PivotTo(originalCFrames.Codes)
		RadioactiveSpin:PivotTo(originalCFrames.RadioactiveSpin)
		RobuxShop:PivotTo(originalCFrames.RobuxShop)
		EventBoard:PivotTo(originalCFrames.EventBoard)
		Model1:PivotTo(originalCFrames.Model1)
		StealsBoard:PivotTo(originalCFrames.StealsBoard)
		CoinsBoard:PivotTo(originalCFrames.CoinsBoard)
		AdventCalendar:PivotTo(originalCFrames.AdventCalendar)
		FestiveLuckyBlock:PivotTo(originalCFrames.FestiveLuckyBlock)
		FuseMachine:PivotTo(originalCFrames.FuseMachine)
	end
end

ReplicatedStorage:GetAttributeChangedSignal("3RoadsEvent"):Connect(function()
	local value = ReplicatedStorage:GetAttribute("3RoadsEvent")
	moveModels(value)
end)

moveModels(ReplicatedStorage:GetAttribute("3RoadsEvent"))