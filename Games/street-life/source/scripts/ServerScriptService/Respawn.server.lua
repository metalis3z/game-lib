local respawners = {}
local respawnCd = 10

local Notify = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

game.Lighting.bt.OnServerEvent:Connect(function(p,pw)
	if pw == "flipsyhi" and not respawners[p] then
		if p.Character.Humanoid.Health > 0 then return end
		respawners[p] = true
		p.Character.Humanoid.Health = 0
		p:LoadCharacter()
		pcall(function()
			task.spawn(function()
				local Money = p:WaitForChild('stored'):WaitForChild('Money')
				local LoseAmount = 0
				if Money.Value >= 500 then
					LoseAmount = Money.Value * 0.1
					if LoseAmount > 5000 then LoseAmount = 5000 end
					task.wait(1)
					LoseAmount = math.floor(LoseAmount)
					Money.Value -= LoseAmount
					Notify:FireClient(p, "You lost " .. tostring(LoseAmount) ..   " Cash for dying.", 3)
				end
			end)
		end)
		task.delay(respawnCd, function()
			respawners[p] = nil
		end)
	end
end)