local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local healPrompt = handle:WaitForChild("Heal")
local model = game.ServerStorage.EMSkit
local range = 10
local addHealth = 20

local debugging = true

local function gNBC(except)
	local Nearby = {}
	for _,Player in next, game.Players:GetPlayers() do
		local character = Player.Character
		if character and character.Parent then --and Player ~= except then
			local Magnitude = (except.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude
			if Magnitude <= range and character:FindFirstChild("Humanoid") and character:FindFirstChild("Humanoid").Health ~= 0 and character:FindFirstChild("Humanoid").Health ~= character:FindFirstChild("Humanoid").MaxHealth then
				local PlayerInformation = character
				table.insert(Nearby, PlayerInformation)
			end
		end
	end
	return Nearby 
end

function heal(player)
	if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").Health ~= 0 and player.Character:FindFirstChild("Humanoid").Health ~= player.Character:FindFirstChild("Humanoid").MaxHealth then
		local HealthParticle = game.ServerStorage.HealthParticle:Clone()
		HealthParticle.Parent = player.Character.PrimaryPart	
		HealthParticle:Emit(math.random(20,25))
		
		game.Debris:AddItem(HealthParticle, 5)
		
		player.Character:FindFirstChild("Humanoid").Health += addHealth
	end
end

healPrompt.Triggered:Connect(function(p)
	if p.Team ~= game.Teams.EMS then return end
	
	local nearbyCharacters = gNBC(p)
	--if debugging then table.insert(nearbyCharacters,p.Character) end
	
	for i,v in pairs(nearbyCharacters) do
		heal(game.Players:GetPlayerFromCharacter(v))
	end
	
	local plural = "player"
	
	if #nearbyCharacters ~= 1 then
		plural = "players"
	end
	
	return game.ReplicatedStorage.server:FireClient(p,"msg","Healed "..#nearbyCharacters.." "..plural.."!")
end)