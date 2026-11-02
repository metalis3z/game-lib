--------|     Setting     |--------

--------|     Library     |--------
local _L; coroutine.wrap(function()  _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))  end)()

--------|    Reference    |--------
local assets = game.ReplicatedStorage:WaitForChild("Assets")

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Adds circular selects from part0 to part1 and connects them with a dotted line


return function(part1, part2, color)
	--- Variables (and force on primaryPart if parts are models)
	local part1 = (part1:IsA("Model") and part1.PrimaryPart or part1)
	local part2 = (part2:IsA("Model") and part2.PrimaryPart or part2)
	local color = color or Color3.new(1, 1, 1)
	local cancel = false
	
	--- Create selection instances
	local dottedLine = assets.Selection:FindFirstChild("DottedLine"):Clone()
	local selection1 = assets.Selection:FindFirstChild("SelectionCircle"):Clone()
	local selection2 = assets.Selection:FindFirstChild("SelectionCircle"):Clone()
	--
	local attachment1 = selection1:FindFirstChild("Attachment")
	local attachment2 = selection2:FindFirstChild("Attachment")
	dottedLine.Attachment0 = attachment1
	dottedLine.Attachment1 = attachment2
	dottedLine.Color = ColorSequence.new(color)
	
	--- Color
	selection1.Decal.Color3 = color
	selection2.Decal.Color3 = color
	
	--- Math
	local selectionPart1Axis = math.max(part1.Size.X, part1.Size.Z)
	local selectionPart2Axis = math.max(part2.Size.X, part2.Size.Z)
	selection1.Size = Vector3.new(selectionPart1Axis + 2, 0.05, selectionPart1Axis + 2)
	selection2.Size = Vector3.new(selectionPart2Axis + 2, 0.05, selectionPart2Axis + 2)
	attachment1.Position = Vector3.new(0, 0, -selection1.Size.Z / 2)
	attachment2.Position = Vector3.new(0, 0, -selection2.Size.Z / 2)
	
	--- Parent selection
	dottedLine.Parent = selection1
	selection1.Parent = game.Workspace.TG_Aw999YR31
	selection2.Parent = game.Workspace.TG_Aw999YR31
	
	--- Main
	coroutine.wrap(function()
		while (not cancel and part1.Parent and part2.Parent and selection1.Parent and selection2.Parent and dottedLine.Parent) do
			--- Vars
			local map = game.Workspace:WaitForChild("TG_M0001JJJA")
			
			--- Raycast math
			for i = 1, 2 do
				--- Grab the appropriate parts
				local loopPart = (i == 1 and part1 or part2)
				local loopSelectionPart = (i == 1 and selection1 or selection2) 
				
				--- Raycast for surface
				local ray = Ray.new(loopPart.CFrame.p, Vector3.new(0, -1, 0).Unit * 300)
				local rayPart, rayPosition, rayNormal = game.Workspace:FindPartOnRayWithWhitelist(ray, {map})
				
				--- Overly the selection
				if rayPart and rayPosition then
					loopSelectionPart.CFrame = CFrame.new(loopPart.Position.X, rayPosition.Y + 0, loopPart.Position.Z)
				end
			end
			
			--- Face attachments to avoid beam curve
			local selection1CF = CFrame.new(selection1.CFrame.p, selection2.CFrame.p)
			local selection2CF = CFrame.new(selection2.CFrame.p, selection1.CFrame.p)
			
			--- Remove Y axis of rotation
			local selection1ROT = {selection1CF:toOrientation()}
			local selection2ROT = {selection2CF:toOrientation()}
			selection1CF = CFrame.new(selection1CF.p) * CFrame.fromOrientation(0, selection1ROT[2], 0)
			selection2CF = CFrame.new(selection2CF.p) * CFrame.fromOrientation(0, selection2ROT[2], 0)
			
			--- Apply
			selection1.CFrame = selection1CF
			selection2.CFrame = selection2CF
			
			--- Wait
			_L.Services.RunService.Stepped:wait()
		end
		
		--- Remove selection effects
		selection1:Destroy()
		selection2:Destroy()
	end)()
	
	--
	return (function()  cancel = true  end)
end