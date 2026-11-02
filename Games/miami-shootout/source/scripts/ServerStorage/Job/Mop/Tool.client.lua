local db = false

-- people can clip walls with this so I added this epic check

local backpackAllowed = true
local debounce = 2

script.Parent.Equipped:Connect(function()
	backpackAllowed = false
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,backpackAllowed)
	
	delay(debounce,function()
		if backpackAllowed == false then
			backpackAllowed = true
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,backpackAllowed)
		end	
	end)
end)

script.Parent.Activated:Connect(function()
	
	
	
	local plr = game.Players.LocalPlayer
	local char = plr.Character
	local HRP = char.PrimaryPart
	
	local RayOrigin = HRP.Position
	local RayDirection = Vector3.new(0, -100, 0)
	
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Whitelist
	Params.FilterDescendantsInstances = {game.Workspace.Trashpiles.Rest:GetChildren()}
	
	local Result = workspace:Raycast(RayOrigin, RayDirection, Params)
	
	if Result then
		if db then return end
		db = true
		local rayIns = Result.Instance 
		print("Hit "..rayIns:GetFullName())
		
		if rayIns:FindFirstChild("Decal") and rayIns.Decal.Transparency == 0 then
			
			print("ok")
			script.Parent.RemoteEvent:FireServer(rayIns)
			
		end	
		
		wait(3)
		db = false
	end
end)