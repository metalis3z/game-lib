local RagdollService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local function now()
	return workspace:GetServerTimeNow()
end

local function getPlayer(character: Model): Player?
	return Players:GetPlayerFromCharacter(character)
end

-- Table pour tracker les threads de unragdoll en cours
local pendingUnragdoll = {}

local function clearRagdollState(player)
	-- Annuler le thread de unragdoll en attente
	if pendingUnragdoll[player.UserId] then
		task.cancel(pendingUnragdoll[player.UserId])
		pendingUnragdoll[player.UserId] = nil
	end
	player:SetAttribute("Ragdolled", nil)
	player:SetAttribute("RagdollEndTime", nil)
end

function RagdollService:Ragdoll(character: Model, duration: number?)
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local player = getPlayer(character)
	if not player then return end

	-- GodMode : immunité au ragdoll
	if player:GetAttribute("GodMode") == true then return end

	-- Ne pas re-ragdoll si déjà en cours
	if player:GetAttribute("Ragdolled") then return end

	duration = math.clamp(duration or 3, 0.1, 3)

	Ragdoll.Ragdoll(character)
	player:SetAttribute("Ragdolled", true)
	player:SetAttribute("RagdollEndTime", now() + duration)

	-- Unragdoll automatique garanti après la durée
	pendingUnragdoll[player.UserId] = task.delay(duration, function()
		pendingUnragdoll[player.UserId] = nil
		if player and player.Parent then
			if player.Character == character then
				RagdollService:Unragdoll(character)
			else
				clearRagdollState(player)
			end
		end
	end)
end

function RagdollService:Unragdoll(character: Model)
	if not character then return end

	local player = getPlayer(character)
	if not player then return end

	pcall(function() Ragdoll.Unragdoll(character) end)
	clearRagdollState(player)
end

function RagdollService:IsRagdolled(player: Player): boolean
	return player:GetAttribute("Ragdolled") == true
end

-- CLEF : nettoyer l'état ragdoll à chaque respawn
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		-- Reset immédiat à chaque spawn
		clearRagdollState(player)

		local humanoid = character:WaitForChild("Humanoid", 5)
		if humanoid then
			humanoid.Died:Connect(function()
				task.delay(0.1, function()
					if player and player.Parent then
						clearRagdollState(player)
					end
				end)
			end)
		end
	end)
end)

-- Nettoyer quand le joueur quitte
Players.PlayerRemoving:Connect(function(player)
	clearRagdollState(player)
	pendingUnragdoll[player.UserId] = nil
end)

-- Watchdog serveur : toutes les 5s vérifier les ragdolls expirés
task.spawn(function()
    while true do
        task.wait(5)
        local now = workspace:GetServerTimeNow()
        for _, player in ipairs(Players:GetPlayers()) do
            if player:GetAttribute("Ragdolled") then
                local endTime = player:GetAttribute("RagdollEndTime") or 0
                -- Si le ragdoll aurait dû se terminer depuis plus de 2s
                if now > endTime + 2 then
                    warn("[RagdollService] Watchdog: " .. player.Name .. " ragdoll expiré → force unragdoll")
                    if player.Character then
                        pcall(function() RagdollService:Unragdoll(player.Character) end)
                    else
                        clearRagdollState(player)
                    end
                end
            end
        end
    end
end)

return RagdollService
