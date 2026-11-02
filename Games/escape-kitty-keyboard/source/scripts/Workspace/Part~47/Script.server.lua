local part = script.Parent -- la part qui sert de piège

game.Players.RespawnTime = 0.1 -- respawn quasi instantané pour tout le jeu

local debounce = {}

part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if humanoid and rootPart and not debounce[character] then
		debounce[character] = true

		-- FLING violent
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.Velocity = Vector3.new(
			math.random(-300, 300),
			400,
			math.random(-300, 300)
		)
		bodyVelocity.Parent = rootPart

		game:GetService("Debris"):AddItem(bodyVelocity, 0.5)

		-- Tue le joueur 2 secondes après
		task.delay(2, function()
			if humanoid and humanoid.Health > 0 then
				humanoid.Health = 0
			end
			debounce[character] = nil
		end)
	end
end)