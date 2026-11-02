local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

--dont allow anyone to steal truck during tutorial
local added = script.Parent.ChildAdded:connect(function(obj)
	if obj.Name == "SeatWeld" then
		local player = game.Players:GetPlayerFromCharacter(obj.Part1.Parent)
		if player then
			if obj.Part1.Parent.Name ~= script.Player.Value.Name then
				wait()
	
				script.Parent.Disabled = true
				obj.Part1.Parent.Humanoid.Sit = false
				
				obj.Part1.Parent.Humanoid.Jump = true
				wait(.1)
				script.Parent.Disabled = false
				Dialog:ShowMessage(player,"Sorry","A player needs this truck for the tutorial.")
			else
				workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"InDriversSeat",true)
			end
		end
	end
end)


local removed = script.Parent.ChildRemoved:connect(function(obj)
	if obj.Name == "SeatWeld" then
		local player = game.Players:GetPlayerFromCharacter(obj.Part1.Parent)
		if player then
			if obj.Part1.Parent.Name == script.Player.Value.Name then
				workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"SeatWeldDestroyed",true)
			end
		end
	end
end)

wait(300) --timeout
added:disconnect()
script:Destroy()