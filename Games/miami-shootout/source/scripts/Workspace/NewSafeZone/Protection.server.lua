-- uses candamage module now --
local canDamage = require(game.ServerScriptService.VisualizeBulletScript.DamageModule)

-- script --
local setting = require(script.Parent.Settings)
local ZoneModule = require(game.Workspace.Zone)

local combatTimer, enterTimer, lastTimer = setting.CombatTimer, setting.Timer, setting.ProtectionLasts

local safeZones = game.Workspace.NewSafeZone.Zones:GetChildren()

local zones = {}
local zoneInd = {}
local zoneFuncs = {}
local zoneFuncInd = {}

local safezoneValues = {}
local protected = {}
local protectedTimes = {}

local protectedCooldowns = {}

_G.protected = {}

function isOnCooldown(player)
	local combatTimer = protectedCooldowns[player]

	if not combatTimer then return false end

	local timeLeft = string.gsub(tostring(math.round(time() - combatTimer)),"-","")

	timeLeft = tonumber(enterTimer) - tonumber(timeLeft)

	if timeLeft > 0 then
		return timeLeft
	else
		return false
	end
end

function protectionStatus(player, status)
	if status == "protect" then
		_G.protected[player] = true
		local shield = script.Parent.Shield:Clone()
		shield.Parent = player.Character.PrimaryPart
	else
		if isOnCooldown(player) == false then protectedCooldowns[player] = time() end
		_G.protected[player] = nil
		game.ReplicatedStorage.CServer:FireClient(player,"immunityExpire","remove")
		for i,v in pairs(player.Character.PrimaryPart:GetChildren()) do
			if v.Name == "Shield" then
				v:Destroy()
			end
		end
	end
end

function isInCombat(player)
	local combatTimer = _G.combatTimers[player.Character.Humanoid]
	
	if not combatTimer then return false end
	
	local timeLeft = string.gsub(tostring(math.round(combatTimer - time())),"-","")
	
	if tonumber(timeLeft) <= tonumber(combatTimer) then
		return true
	else
		return false
	end
end

function grantImmunity(player,zone)
	print("giving immunity to player")
	protectionStatus(player, "protect")
	local timer = lastTimer
	repeat wait(1) 
		timer = timer - 1
		game.ReplicatedStorage.CServer:FireClient(player,"immunityExpire",timer)
	until not zone:findPlayer(player) or timer <= 0
	print("Immunity expired!")
	protectionStatus(player, "unprotect")
	if not protectedCooldowns[player] then protectedCooldowns[player] = time() end
	wait()
	if zone:findPlayer(player) then
	local cooldown = isOnCooldown(player)
		if cooldown ~= false then
			repeat wait(1) 
				local updatedCooldown = isOnCooldown(player)
				if updatedCooldown ~= false then
					game.ReplicatedStorage.CServer:FireClient(player,"immunityExpire",math.round(updatedCooldown),"cooldown")
				end
			until not zone:findPlayer(player) or isOnCooldown(player) == false
			if zone:findPlayer(player) then spawn(function() grantImmunity(player,zone) end) end
		end
	end
end

for index, safezone in pairs(safeZones) do
	
	-- [[construct]] --
	-- index - number of current iteration
	-- safezone - the safezone part of the current iteration
	
	zones[index] = safezone
	zoneInd[safezone.Name] = index
	
	-- create the zone
	local newZone = ZoneModule.new(safezone)
	zoneFuncs[index] = newZone
	zoneFuncInd[safezone.Name] = newZone
	
	newZone.playerEntered:Connect(function(player)
		local cooldown = isOnCooldown(player)
		
		if cooldown ~= false then
			repeat wait(1) 
				local updatedCooldown = isOnCooldown(player)
				if updatedCooldown ~= false then
					game.ReplicatedStorage.CServer:FireClient(player,"immunityExpire",math.round(updatedCooldown),"cooldown")
				end
			until not newZone:findPlayer(player) or isOnCooldown(player) == false
		end
		
		--local inCombat = isInCombat(player)
		--if not inCombat then
			spawn(function() grantImmunity(player,newZone) end)
		--else
		--	local updatedCombat = isInCombat(player)
		--	if updatedCombat ~= false then
		--		repeat wait(1) 
		--			local updatedCombat = isInCombat(player)
		--			if updatedCombat ~= false then
		--				game.ReplicatedStorage.CServer:FireClient(player,"immunityExpire","You are in combat and cannot receive immunity (25 seconds)","customtext")
		--			end
		--		until not newZone:findPlayer(player) or isInCombat(player) == false
		--		if newZone:findPlayer(player) then spawn(function() grantImmunity(player,newZone) end) end
		--		return
		--	end
		--end
	end)
	
	newZone.playerExited:Connect(function(player)
		protectionStatus(player, "unprotect")
	end)
	
end

while wait(1) do
	--print("Checking players for exploited or glitched immunity...")
	for i,v in pairs(game.Players:GetPlayers()) do
		
		local isInGunStore = zoneFuncInd["GunSafeZone"]:findPlayer(v)
		
		local function removeProtection()
			if _G.protected[v] then
				_G.protected[v] = nil
			end
			game.ReplicatedStorage.CServer:FireClient(v,"immunityExpire","remove")

			if v.Character and v.Character.PrimaryPart and v.Character.PrimaryPart:FindFirstChild("Shield") then
				v.Character.PrimaryPart:FindFirstChild("Shield"):Destroy()
			end
		end
		
		if not isInGunStore then
			removeProtection()
		end
		
		if isOnCooldown(v) and _G.protected[v] then
			removeProtection()
		end
		
	end
end

--[[
local loops = {}

-- Protection Timer Loop
spawn(function()
	
	loops[1] = true
	local loopTime = 1
	
	while wait(loopTime) do
		if loops[1] == true then
			
		end
	end
	
end)

spawn(function()
	
	loops[2] = true
	local loopTime = 300
	
	while wait(loopTime) do
		if loops[2] == true then
			
		end
	end
	
end)
--]]