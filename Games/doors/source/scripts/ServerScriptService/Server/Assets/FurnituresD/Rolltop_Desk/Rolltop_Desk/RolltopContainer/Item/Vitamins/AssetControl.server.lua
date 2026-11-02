local ToolName = {"Vitamins"}
local Storage = game.ServerStorage

script.Parent.ModulePrompt.Triggered:connect(function(Player)
	if Player and Player.Character  then
		local Backpack = Player:WaitForChild("Backpack")
		for i = 1, #ToolName do
			local Tool = Storage:FindFirstChild(ToolName[i])
			if Tool then
				if Backpack:FindFirstChild("Vitamins") or Player.Character:FindFirstChild("Vitamins") then
					game.ReplicatedStorage.Bricks.KeyFull:FireClient(Player, "Vitamins", "x1")	
					return
				end
				Tool:clone().Parent = Backpack
				script.Parent:Destroy()
			end
		end
	end
end)