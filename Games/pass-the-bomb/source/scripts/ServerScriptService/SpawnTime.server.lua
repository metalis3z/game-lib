SpawnDelayTime = 5



OnDeath_Callback = function(player) -- Optional function for anyone who wants some sort of code to run when the player dies and before they spawn

	print(player.Name .. " died. Awaiting respawn.")

end

game.Players.CharacterAutoLoads = false

game.Players.PlayerAdded:connect(function(p)
	p.CharacterAdded:connect(function(c)

		local t = time()
		while ((not c:FindFirstChild("Humanoid")) and ((time()-t) < 10)) do wait(0.2) end	-- Wait until Humanoid is present or amount of time waiting is more than 10 seconds


		if ((time()-t) >= 10) then print("Timeout error") -- If for some reason the Humanoid isn't found in 10 seconds, break the loop. No need to be stuck in an endless and useless loop.


		else
			c.Humanoid.Died:connect(function()
				if (type(OnDeath_Callback) == "function") then OnDeath_Callback(p) end
				wait(SpawnDelayTime)
				p:LoadCharacter(true)
			end)


		end
	end)
	wait(2)
	p:LoadCharacter(true)
end)