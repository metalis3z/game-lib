--Variables
local Command = "/headless" or "/headless "
local LeaveCommand = "/unheadless" or "/unheadless "

--Functions
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr) 
		player.Chatted:Connect(function(msg) 
	--Main Script		
				if msg == Command then 
				player.Character.Head.Transparency = 1
				player.Character.Head.face.Transparency = 1
			else
				if player.Character.Head.Transparency == 1 then 
					if msg == LeaveCommand then
						player.Character.Head.Transparency = 0 
						player.Character.Head.face.Transparency = 0 
					end
				end
			end
		end)
	end)
end)