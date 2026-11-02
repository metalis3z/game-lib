local Worlds = {
	["Snow"] = {cost=10000, tp1={workspace:WaitForChild("SnowPortal1"):WaitForChild("Teleport")}, tp2 = {workspace:WaitForChild("Snow Map"):WaitForChild("SnowPortal2"):WaitForChild("Teleport")}, bonus=15},
	["Desert"] = {cost=2500, tp1={workspace:WaitForChild("DesertPortal1"):WaitForChild("Cave"):WaitForChild("Teleport")}, tp2={workspace:WaitForChild("Desert Map"):WaitForChild("DesertPortal2"):WaitForChild("Cave"):WaitForChild("Teleport")}, bonus=7},
	["Cave"] = {cost=250, tp1={workspace:WaitForChild("CaveEntrance"):WaitForChild("Teleport"), workspace:WaitForChild("CavePortal"):WaitForChild("Cave"):WaitForChild("Teleport")}, tp2={workspace:WaitForChild("Cave Map"):WaitForChild("CaveExit1"):WaitForChild("Teleport"), workspace:WaitForChild("Cave Map"):WaitForChild("CaveExit2"):WaitForChild("Teleport")}, bonus=3}
}

return Worlds
