wait(1)

local character = script.Parent
local player = game.Players:GetPlayerFromCharacter(character)
local humanoid = character:WaitForChild("Humanoid")

local sec = 20

local randomMessages = {"PUT IN A PACK!", "GET BACK!", "YOU DIED!", "HOW U GON GET CLOWNED LIKE THAT!", "CRITICAL CONDITION!", "SLIDE BACK!"}

humanoid.Died:Connect(function()	
	if player.PlayerGui:FindFirstChild("Dead").Enabled then return end
	humanoid:UnequipTools()
	local DEAD = player.PlayerGui:FindFirstChild("Dead")
	DEAD.Frame.randomMsg.Text = randomMessages[math.random(1,#randomMessages)]
	DEAD.Frame.respawnIn.Text = "You will respawn in "..tostring(sec).." seconds."
	DEAD.Enabled = true
	
	game.Lighting.Dead.Enabled = true
	
	repeat 
		task.wait(1) 
		sec = sec - 1
		local plur = "seconds"
		if sec == 0 then 
			game.Lighting.bt:FireServer("flipsyhi")
		end
		
		DEAD.Frame.respawnIn.Text = "You will respawn in "..tostring(sec).." "..plur.."."
		if sec == 0 then 
			DEAD.Frame.respawnIn.Text = "RESPAWNING..."
		end
	until sec <= 0
	
	while wait(1) do
		game.Lighting.bt:FireServer("flipsyhi")
	end	
end)