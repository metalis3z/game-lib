local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameData = ReplicatedStorage:WaitForChild("GameData")
local StartTether = GameData:WaitForChild("StartTether")

local partBlue = workspace:WaitForChild("PartBlue")
local partRed = workspace:WaitForChild("PartRed")

local TPpartBlue = workspace:WaitForChild("TPpartBLUE") -- Position de téléportation pour la part bleue
local TPpartRed = workspace:WaitForChild("TPpartRED") -- Position de téléportation pour la part rouge

local playerOnBlue = nil
local playerOnRed = nil

-- Fonction pour assigner un joueur à une équipe
local function assignTeam(player, teamName)
	local team = game:GetService("Teams"):FindFirstChild(teamName)
	if team then
		player.Team = team
	end
end

-- Fonction pour afficher le GUI Leave pour un joueur
local function showLeaveButton(player)
	local playerGui = player:WaitForChild("PlayerGui")
	local gameGui = playerGui:WaitForChild("GameGUI") -- On utilise le GUI existant GameGUI
	local leaveButton = gameGui:WaitForChild("Leave") -- Le bouton Leave dans GameGUI

	-- Assurer que le bouton est visible
	leaveButton.Visible = true

	-- Fonction pour quitter la part quand le joueur clique sur le bouton Leave
	leaveButton.MouseButton1Click:Connect(function()
		-- Vérifie dans quelle part le joueur se trouve
		if playerOnBlue == player then
			playerOnBlue = nil
		elseif playerOnRed == player then
			playerOnRed = nil
		end

		-- Réinitialise l'équipe du joueur et la position
		player.Team = nil
		player.Character:SetPrimaryPartCFrame(workspace.SpawnLocation.CFrame) -- Remet le joueur à l'emplacement de départ (par exemple)

		-- Masque le bouton Leave
		leaveButton.Visible = false

		print(player.Name .. " a quitté la part")
	end)
end

-- Fonction pour téléporter le joueur à la part bleue ou rouge
local function teleportPlayerToPart(player, part)
	local character = player.Character
	if not character then return end

	-- Si le joueur entre dans la part bleue, on le téléporte à TPpartBlue
	if part == partBlue then
		character:SetPrimaryPartCFrame(TPpartBlue.CFrame)
		print(player.Name .. " a été téléporté à TPpartBLUE")

		-- Si le joueur entre dans la part rouge, on le téléporte à TPpartRed
	elseif part == partRed then
		character:SetPrimaryPartCFrame(TPpartRed.CFrame)
		print(player.Name .. " a été téléporté à TPpartRED")
	end
end

-- Vérifie si les deux joueurs sont prêts
local function tryStartGame()
	if playerOnBlue and playerOnRed then
		print("2 joueurs détectés ! Début de la partie !")
		StartTether:Fire(playerOnBlue)
		task.wait(0.1)
		StartTether:Fire(playerOnRed)
	end
end

-- Réinitialisation si un joueur part
local function resetIfLeft(part, leftPlayer)
	if part == partBlue and playerOnBlue == leftPlayer then
		playerOnBlue = nil
	elseif part == partRed and playerOnRed == leftPlayer then
		playerOnRed = nil
	end
end

-- Gère le fait de marcher sur une part
local function setupPad(part, color)
	part.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if not player then return end

		-- Si c'est la part bleue et qu'il n'y a pas encore de Player1
		if color == "Blue" and not playerOnBlue then
			playerOnBlue = player
			assignTeam(player, "DuoBlue")  -- Assigne à l'équipe bleue
			print(player.Name .. " est Player1 sur la part bleue")
			showLeaveButton(player)  -- Affiche le bouton Leave pour Player1
			teleportPlayerToPart(player, part)  -- Téléporte le joueur à TPpartBlue

			-- Si c'est la part rouge et qu'il n'y a pas encore de Player2
		elseif color == "Red" and not playerOnRed then
			playerOnRed = player
			assignTeam(player, "DuoRed")  -- Assigne à l'équipe rouge
			print(player.Name .. " est Player2 sur la part rouge")
			showLeaveButton(player)  -- Affiche le bouton Leave pour Player2
			teleportPlayerToPart(player, part)  -- Téléporte le joueur à TPpartRed
		end

		-- Si les deux joueurs sont prêts, on lance le jeu
		tryStartGame()
	end)

	-- Gère le fait de quitter la part
	part.TouchEnded:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			resetIfLeft(part, player)
			print(player.Name .. " a quitté la part " .. color)
		end
	end)
end

-- Applique aux deux pads
setupPad(partBlue, "Blue")
setupPad(partRed, "Red")
