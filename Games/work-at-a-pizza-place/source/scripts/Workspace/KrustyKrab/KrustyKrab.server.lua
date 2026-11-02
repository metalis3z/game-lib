local destination
if game.PlaceId == 142872308 then
	destination = 421058320
else
	destination = 257857728
end

local teleportSer = game:GetService("TeleportService")
local debounce = false
function touched(hit)
	if not debounce and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		debounce = true
		delay(10,function() debounce = false end)
		local players = {}
		for _,player in ipairs(game.Players:GetPlayers()) do
			if player:DistanceFromCharacter(hit.Parent.HumanoidRootPart.Position) < 85 then
				table.insert(players,player)
			end
		end
		
		local code = teleportSer:ReserveServer(destination)
		teleportSer:TeleportToPrivateServer (destination,code,players)
		
	end
end
script.Parent.TouchBlock.Touched:connect(touched)