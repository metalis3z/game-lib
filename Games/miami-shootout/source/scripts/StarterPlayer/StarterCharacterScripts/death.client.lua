wait(1)

local character = script.Parent
local player = game.Players:GetPlayerFromCharacter(character) -- script.Parent
local humanoid = character:WaitForChild("Humanoid")

local sec = 10

local randomMessages = {"GO GET BACK!"}

humanoid.Died:Connect(function()
	
	game.ReplicatedStorage.Dead:Play()
	
	local DEAD = player.PlayerGui:FindFirstChild("Dead")
	DEAD.Frame.randomMsg.Text = randomMessages[math.random(1,#randomMessages)]
	DEAD.Frame.respawnIn.Text = "You will respawn in "..tostring(sec).." seconds."
	DEAD.Enabled = true
	
	game.Lighting.Dead.Enabled = true
	
	repeat wait(1) 
		sec = sec - 1
		local plur = "seconds"
		if sec == 1 then
			plur = "second"
		end
		
		DEAD.Frame.respawnIn.Text = "You will respawn in "..tostring(sec).." "..plur.."."
	until sec <= 0
	
	while wait(1) do
		print("dead but not respawned")
		game.Lighting.bt:FireServer("ss")
	end	

	--game.Lighting.Dead.Enabled = false
end)