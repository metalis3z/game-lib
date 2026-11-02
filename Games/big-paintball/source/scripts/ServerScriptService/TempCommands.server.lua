------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------
local isStudio = _L.Services.RunService:IsStudio()

--------|    Variables    |--------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

These are temporary commands for the game until we make a proper system.

All you have to do is add "elseif cmd == 'cmd' then" to add a new command.

I included an example of this below; go ahead and look at it!

- Aimee

]]
function TrackAdmin(player)
	player.Chatted:Connect(function(msg)

		-- roblox is terrible.... the live version of roblox
		-- has an extra ascii 13 character at the end of
		-- every string
		if msg:sub(#msg, #msg):byte() == 13 then
			msg = msg:sub(1, #msg - 1)
		end

		local separated = string.split(string.lower(msg), " ")
		local cmd = separated[2]
		local arg = separated[3]

		if not separated[1] or separated[1] ~= "/e" or not cmd then
			return
		end

		if cmd == "resetsave" then
			_L.Saving.Reset(player) -- hopefully works?
			wait(1.1)
			
			_L.Saving.Init(player)
			wait(0.5)
			player:Kick("Reset your stats")
		elseif cmd == "addkills" then
				if arg == "set" then
					local amount = tonumber(separated[4])
					if amount and amount >= 0 then
						_L.Shared.giveCredits(amount,player)
					end
				elseif arg == "player" and separated[4] and separated[5] then
					local chosenPlayer = string.split(msg, " ")[4]
					local giveTo = game.Players:FindFirstChild(chosenPlayer)
				    _L.Shared.giveCredits(giveTo, separated[5]) 
				else
					--- Give cash
					_L.Shared.giveCredits(player,9999999999)
				end
		elseif cmd == "test" then
			print("Add whatever you want!")
			
		elseif cmd == "test1" then
			print("See, all you have to do is add more elseif's!")
			
			
		end
	end)
end


game.Players.PlayerAdded:Connect(function(player)
	if isStudio then
		TrackAdmin(player)
	end
end)

--[[
If any issues with either, add
"or _L.Functions.SearchArray(_L.Settings.SuperAdmins, player.UserId)"
after "isStudio"

thx
]]
for _, player in ipairs(game.Players:GetPlayers()) do
	if isStudio then 
		TrackAdmin(player)
	end
end