local ToolName = {"SkeletonKey"}
local Storage = game.ServerStorage
local ProximityPrompt = script.Parent

ProximityPrompt.Triggered:connect(function(Player)
	if Player and Player.Character  then
		local Backpack = Player:WaitForChild("Backpack")
		for i = 1, #ToolName do
			local Tool = Storage:FindFirstChild(ToolName[i])
			if Tool then
				if Backpack:FindFirstChild("SkeletonKey") or Player.Character:FindFirstChild("SkeletonKey") then
					return
				end
				Tool:clone().Parent = Backpack
				Tool:Destroy()
			end
		end
	end
end)
