local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local LocalServerDebugEnabled = true
return {
	Enabled = Enums.IsStudio or ((Enums.IsLocalClient or  Enums.IsLocalServer) and LocalServerDebugEnabled),
	LoadSavedData = false,
	LoadPlayerDataById = nil, --50557819,--187082186,--207010247,--69904520,
	SavingEnabled = false,
	FillInventory = true,
	IntroEnabled = false,
	AutoPressPlayButton = false,
	StartAsNewPlayer = false,
	Moneyz = 50000,
	JobTransitionSpeed = 1.3,  --1.3
	HouseSize = "Basement",
	MusicVolume = "0",
	HouseIndex = 1,   --  1-12 house index
	DayNightCycleDisabled = false,
	FastCycle = 10, --  1-60    1=fast, 60=normal speed
	TimeOfDay = nil,
	Season = nil,
	Holiday = nil,
	GarageEnabled = true,
	SimulateSlowInternet = 1, --kilobytes
	SavedData = nil,
	
}
