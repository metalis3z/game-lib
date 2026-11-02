local sound = game.ReplicatedStorage.Punch:WaitForChild("Sound")
local animation = script.Animation

game.ReplicatedStorage:WaitForChild("Punch"):WaitForChild("Punch").OnServerInvoke = function(player)
	local IsPunchValue = player:WaitForChild("IsPunching")
	
	if IsPunchValue.Value == false then
		IsPunchValue.Value = true
		
		local anim = player.Character:WaitForChild("Humanoid"):LoadAnimation(animation)
		anim:Play()

		local OneTime = true

		local connection = player.Character:WaitForChild("Left Arm").Touched:Connect(function(hit)
			local hum = hit.Parent:FindFirstChild("Humanoid")

			if hum then
				if OneTime == true then
					OneTime = false
					--game.ReplicatedStorage.Punch.PlaySound:FireServer(hit.Parent.Humanoid)

					local PunchedValue = player:WaitForChild("Punched")
					PunchedValue.Value = true

					hum:TakeDamage(15)

					spawn(function()	
						local NewSound = sound:Clone()
						NewSound.Parent = player.Character["Left Arm"]
						NewSound:Play()

						local value = Instance.new("ObjectValue")
						value.Parent = hum
						value.Name = "creator"
						value.Value = player

						wait(2)

						NewSound:Destroy()
						value:Destroy()
					end)
				end
			end
		end)

		wait(1)

		connection:Disconnect()
		
		IsPunchValue.Value = false
		
		return
	end
end

