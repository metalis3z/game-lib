local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local event = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("StartTether")

local tetheredPlayers = {}

local function tetherPlayers(player1, player2)
	local char1 = player1.Character
	local char2 = player2.Character
	if not (char1 and char2) then return end

	local root1 = char1:FindFirstChild("HumanoidRootPart")
	local root2 = char2:FindFirstChild("HumanoidRootPart")
	if not (root1 and root2) then return end

	-- Attachments
	local att1 = Instance.new("Attachment", root1)
	local att2 = Instance.new("Attachment", root2)

	-- Corde
	local rope = Instance.new("RopeConstraint")
	rope.Attachment0 = att1
	rope.Attachment1 = att2
	rope.Length = 20
	rope.Visible = true
	rope.Thickness = 0.15
	rope.Parent = root1

	-- Stockage
	tetheredPlayers[player1] = { other = player2, rope = rope, attachments = {att1, att2} }
	tetheredPlayers[player2] = { other = player1, rope = rope, attachments = {att1, att2} }

	print("🪢", player1.Name, "et", player2.Name, "sont attachés")

	-- Distance check
	while rope.Parent do
		task.wait(0.25)
		if (root1.Position - root2.Position).Magnitude > rope.Length + 5 then
			print("💥 Corde cassée ! Retour lobby.")
			for _, plr in ipairs({player1, player2}) do
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.Position = Vector3.new(0, 10, 0) -- Lobby
				end
			end
			rope:Destroy()
			att1:Destroy()
			att2:Destroy()
			tetheredPlayers[player1] = nil
			tetheredPlayers[player2] = nil
			break
		end
	end
end

-- Quand un joueur appelle StartTether
event.OnServerEvent:Connect(function(player)
	local alreadyTethered = tetheredPlayers[player]
	if alreadyTethered then return end

	-- Trouve son binôme
	for _, other in pairs(Players:GetPlayers()) do
		if other ~= player and not tetheredPlayers[other] then
			tetherPlayers(player, other)
			break
		end
	end
end)

-- Fonction pour appliquer la glissade
local function applyGlidingEffect(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			-- Réduit la friction
			humanoid.PlatformStand = true  -- Désactive certaines actions comme sauter
			humanoid.WalkSpeed = 16 -- Tu peux ajuster la vitesse si nécessaire

			-- Réduit la friction
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)  -- Forces maximales sur les axes
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)  -- On veut que le joueur glisse
			bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
		end
	end
end

-- Appelons la glissade pour le joueur traîné
applyGlidingEffect(player2) -- C'est le joueur traîné (l'autre joueur)

-- Désactive la possibilité de sauter et de courir pour le traîné
local function disableTrailedPlayerControls(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.JumpPower = 0 
			humanoid.Sit = true 
		end
	end
end


disableTrailedPlayerControls(player2)


local function activateRagdoll(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.PlatformStand = true
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			humanoid:Destroy() 
		end
	end
end


activateRagdoll(player2)

local function resetPlayer(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false  
			humanoid.JumpPower = 50  
			humanoid.Sit = false  
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
	end

	-- Supprime les effets de glissade (BodyVelocity)
	local bodyVelocity = character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity")
	if bodyVelocity then
		bodyVelocity:Destroy()
	end
end

-- Applique la réinitialisation à chaque joueur
resetPlayer(player1)
resetPlayer(player2)
