-- Give to player if player spawned or joined if used rake theme is true

AddGui = (function(Player)
	local GuiClone = script:FindFirstChild("ThemeGui"):Clone()
	if not Player.Character then 
		Player.CharacterAdded:wait()
	end
	if Player:findFirstChild("PlayerGui"):FindFirstChild(GuiClone.Name) then
		Player:findFirstChild("PlayerGui"):FindFirstChild(GuiClone.Name):Destroy()
	end
	GuiClone.Parent = Player:findFirstChild("PlayerGui")
	GuiClone.MainRakeTheme.Disabled = false
end)


function isplr(child)
	if game.Players:findFirstChild(child.Name) or child.Name == "Monster" then
	for _,v in next, game.Players:GetPlayers() do
	AddGui(v)
end
	end
end

game.Players.PlayerAdded:Connect(isplr)
game.Workspace.ChildAdded:connect(isplr)

wait(1)
for _,v in next, game.Players:GetPlayers() do
	AddGui(v)
end

-- Script by XcorrectTheDev