local module = function(Conch, Config)
	Conch.register("fly", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				{
					kind = "argument",
					type = "player",
					name = "Player",
					description = "Le joueur cible (ou 'me' pour soi-même)"
				},
				{
					kind = "argument",
					type = "string",
					name = "State",
					description = "On / Off / Toggle",
					options = { "On", "Off", "Toggle" }
				}
			}
		end,

		callback = function(targetPlayer, state)
			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")

			-- Gestion de "me"
			if targetPlayer == "me" then
				targetPlayer = Conch.getExecutor()
			end

			if not targetPlayer or typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "❌ Joueur invalide. Utilise 'me' ou un nom de joueur."
			end

			local character = targetPlayer.Character
			if not character or not character.Parent then
				return false, "❌ Le joueur n'a pas de personnage valide."
			end

			local humanoid = character:FindFirstChild("Humanoid")
			if not humanoid then
				return false, "❌ Le personnage n'a pas de Humanoid."
			end

			-- Vérifier l'état actuel du vol
			local isFlying = false
			local bodyVelocity = character:FindFirstChild("FlyVelocity")
			local bodyGyro = character:FindFirstChild("FlyGyro")
			if bodyVelocity and bodyGyro then
				isFlying = true
			end

			-- Déterminer le nouvel état
			local newState
			if string.lower(state) == "on" then
				newState = true
			elseif string.lower(state) == "off" then
				newState = false
			elseif string.lower(state) == "toggle" then
				newState = not isFlying
			else
				return false, "❌ État invalide. Utilise On, Off ou Toggle."
			end

			-- Si on veut activer le vol
			if newState and not isFlying then
				-- Supprimer les anciens objets au cas où
				if bodyVelocity then bodyVelocity:Destroy() end
				if bodyGyro then bodyGyro:Destroy() end

				-- Désactiver la gravité et la détection des plateformes
				humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
				humanoid.PlatformStand = true
				humanoid.AutoRotate = false

				-- Créer BodyVelocity pour déplacement
				local bv = Instance.new("BodyVelocity")
				bv.Name = "FlyVelocity"
				bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
				bv.P = 1000
				bv.Velocity = Vector3.new(0, 0, 0)
				bv.Parent = character

				-- Créer BodyGyro pour contrôle de rotation
				local bg = Instance.new("BodyGyro")
				bg.Name = "FlyGyro"
				bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
				bg.P = 10000
				bg.D = 500
				bg.CFrame = character.PrimaryPart.CFrame
				bg.Parent = character

				-- Variable pour suivre le vol
				local flyData = Instance.new("BoolValue")
				flyData.Name = "IsFlying"
				flyData.Value = true
				flyData.Parent = character

				-- Connection pour mettre à jour le mouvement
				local connection
				connection = RunService.Heartbeat:Connect(function(dt)
					if not character or not character.Parent then
						connection:Disconnect()
						return
					end

					local bv = character:FindFirstChild("FlyVelocity")
					local bg = character:FindFirstChild("FlyGyro")
					if not bv or not bg then
						connection:Disconnect()
						return
					end

					-- Récupérer les entrées du joueur
					local moveDirection = Vector3.new(0, 0, 0)
					local rootPart = character.PrimaryPart
					if not rootPart then return end

					-- Contrôle WASD via HumanoidMoveDirection
					local moveVec = humanoid.MoveDirection
					if moveVec.Magnitude > 0 then
						-- Vitesse de vol (configurable)
						local flySpeed = 50
						moveDirection = moveVec * flySpeed
					end

					-- Contrôle de la hauteur (Espace pour monter, Shift pour descendre)
					local up = 0
					local down = 0

					-- Détection des touches via UserInputService est compliquée en serveur
					-- On utilise plutôt des événements client -> serveur
					-- Mais pour simplifier, on monte/descend avec le mouvement vertical du joystick
					-- Ou on garde la hauteur actuelle

					-- Garder la hauteur actuelle si pas de mouvement vertical
					local currentVel = bv.Velocity
					local newVel = moveDirection
					newVel = Vector3.new(newVel.X, currentVel.Y, newVel.Z)
					bv.Velocity = newVel

					-- Gyro pour regarder dans la direction du mouvement
					if moveVec.Magnitude > 0.1 then
						local lookDir = moveVec.Unit
						local upVec = Vector3.new(0, 1, 0)
						local lookCFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + lookDir, upVec)
						bg.CFrame = lookCFrame
					end
				end)

				-- Stocker la connection pour pouvoir l'arrêter plus tard
				local flyConnection = Instance.new("ObjectValue")
				flyConnection.Name = "FlyConnection"
				flyConnection.Value = connection
				flyConnection.Parent = character

				return string.format("✅ Vol activé pour %s ! Utilise WASD pour te déplacer.", targetPlayer.Name)

				-- Si on veut désactiver le vol
			elseif not newState and isFlying then
				-- Supprimer les BodyVelocity/BodyGyro
				if bodyVelocity then bodyVelocity:Destroy() end
				if bodyGyro then bodyGyro:Destroy() end

				-- Réactiver les états du Humanoid
				humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
				humanoid.PlatformStand = false
				humanoid.AutoRotate = true

				-- Supprimer les objets de vol
				local flyData = character:FindFirstChild("IsFlying")
				if flyData then flyData:Destroy() end

				local flyConnection = character:FindFirstChild("FlyConnection")
				if flyConnection then
					local conn = flyConnection.Value
					if conn then conn:Disconnect() end
					flyConnection:Destroy()
				end

				return string.format("✅ Vol désactivé pour %s.", targetPlayer.Name)

			else
				return string.format("ℹ️ Le vol est déjà %s pour %s.", isFlying and "activé" or "désactivé", targetPlayer.Name)
			end
		end
	})

	-- Alias pour plus de commodité
	Conch.register("f", {
		alias = "fly"
	})
end

return module