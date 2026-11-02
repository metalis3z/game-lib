--------|     Setting     |--------

--------|     Library     |--------
local _L -- do not add anything to this!

--------|    Reference    |--------
local remotes = workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES")
local remote = remotes:WaitForChild("INTRO")


--------|    Variables    |--------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Player is in the intro and trying to connect with the server to verify save data.
--- If everything returns true (player isn't banned, save loads, etc) then it is marked as 'playing'
function remote.OnServerInvoke(player)
	if not _L then
		_L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
		while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end
	end

	local playerStats = _L.Saving.Get(player)
	local foundSave = (playerStats ~= nil and playerStats ~= "Error")
	local isBanned = _L.Bans.IsBanned(player)
	local isWarned, warnTimer = _L.Bans.IsWarned(player)

	if (not foundSave) or (not player) then
		return false
	end

	if isBanned or isWarned then
		return true, true, warnTimer
	end

	if player:FindFirstChild("__LOADED") then
		return true
	end

	if player.Character then
		--- Remove forcefield
		local forcefield = player.Character:FindFirstChild("__FORCEFIELD")
		if forcefield then
			forcefield:Destroy()
		end

		--- Unanchor torso
		local torso = _L.Player.Get("Torso", player)
		if torso then
			torso.Anchored = false
		end
	end

	local loadedVar = _L.Functions.QuickValue(true)
	loadedVar.Name = "__LOADED"
	loadedVar.Parent = player

	return true
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Anchor and protect the player while in the intro
local function InitPlayer(player)
	--- Wait for player's character to load in
	while (player and player.Parent and (not player.Character)) do
		game:GetService("RunService").Heartbeat:Wait()
	end

	--- Runs just in case if the player respawns during loading sequence (happens in giant survival, for example)
	local function AnchorPlayer()
		local torso = player.Character:FindFirstChild("UpperTorso")

		if player and torso and not player:FindFirstChild("__LOADED") then
			torso.Anchored = true

			if not player.Character:FindFirstChild("__FORCEFIELD") then
				local forcefield = Instance.new("ForceField")
				forcefield.Name = "__FORCEFIELD"
				forcefield.Parent = player.Character
			end
		end
	end

	--- Check
	if player and player.Character and (not player:FindFirstChild("__LOADED")) then
		AnchorPlayer()
	end

	player.CharacterAdded:Connect(function()
		AnchorPlayer()
	end)
end


--- Player join
for _, player in ipairs(game.Players:GetPlayers()) do
	InitPlayer(player)
end
game.Players.PlayerAdded:Connect(function(player)
	InitPlayer(player)
end)
