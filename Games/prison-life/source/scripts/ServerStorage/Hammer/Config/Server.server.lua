local config = script.Parent
local configs = require(config)

local damage = configs.damages
local spread = configs.spread

local Remote = config:WaitForChild("RemoteFunction")
local Handle = config.Parent:WaitForChild("Handle")

local isOn = false

Remote.OnServerInvoke = function(player)
	local touch = Handle.Touched:Connect(function(hit)
		local Humanoid = hit.Parent:FindFirstChild("Humanoid")
		
		if Humanoid then
			
			if isOn == false then
				isOn = true
				
				local Eplayer = game.Players:GetPlayerFromCharacter(hit.Parent)

				if Eplayer ~= nil then
					if Eplayer.Team ~= player.Team then
						Humanoid.Health = Humanoid.Health -damage --For Player
						--print("player")
					end
				else
					Humanoid.Health = Humanoid.Health -damage --For NPC
					--print("npc")
				end
			end
		end
	end)
	
	wait(spread)
	touch:Disconnect()
	
	isOn = false
	
	return
end