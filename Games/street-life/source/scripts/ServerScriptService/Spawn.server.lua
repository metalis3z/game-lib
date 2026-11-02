game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		local hum = c:WaitForChild("Humanoid")
		task.spawn(function()
			task.wait(1)
			if p:FindFirstChild('Backpack'):FindFirstChild('Fist') then p:FindFirstChild('Backpack'):FindFirstChild('Fist'):Destroy() end
			if p:FindFirstChild('Backpack'):FindFirstChild('Phone') then p:FindFirstChild('Backpack'):FindFirstChild('Phone'):Destroy() end 
			game:FindService('ServerStorage'):FindFirstChild('Fist'):Clone().Parent = p:FindFirstChild('Backpack')
			game:FindService('ServerStorage'):FindFirstChild('Phone'):Clone().Parent = p:FindFirstChild('Backpack')
		end)
		
		if p:FindFirstChild('Girl') then
			local girlModel = script:FindFirstChild('Girl')

			if girlModel then
				task.wait(1)
				for _, part in ipairs(c:GetChildren()) do
					local replacementPart = girlModel:FindFirstChild(part.Name)
					if replacementPart and replacementPart:IsA('MeshPart') then
						hum:ReplaceBodyPartR15(Enum.BodyPartR15[part.Name], replacementPart:Clone())
					end
				end
				task.wait(1)
				pcall(function()
					c.LeftLowerLeg.Size *= .85
					c.LeftUpperLeg.Size *= .85
					c.LeftFoot.Size *= .85
					c.RightLowerLeg.Size *= .85
					c.RightUpperLeg.Size *= .85
					c.RightFoot.Size *= .85
				end)
			end
		end

		hum.Died:Connect(function()
			local tools = p.Backpack:GetChildren()
			local hand = p.Character:FindFirstChildWhichIsA("Tool")
			if hand then
				table.insert(tools,hand)
			end

			for i,v in pairs(tools) do
				if v:IsA("Tool") then v.CanBeDropped = false end
			end
		end)
	end)
end)

local used = {}

game.ReplicatedStorage.SpawnCharacter.OnServerEvent:Connect(function(p)
	if used[p] then return end
	used[p] = true
	p:LoadCharacter()
end)

game.Players.PlayerRemoving:Connect(function(p)
	if used[p] then used[p] = nil end
end)

for _,v in ipairs(workspace:GetDescendants()) do
	if v.Name == 'Safe' and v.Parent.Name == 'Door' then
		local Clone = script:FindFirstChildOfClass('ProximityPrompt'):Clone()
		Clone.Parent = v:FindFirstChild('Func')
		Clone.Triggered:Connect(function(Player)
			if v.Parent:FindFirstChild('Owner') then
				if v.Parent:FindFirstChild('Owner').Value == Player.Name then
					if not Player.PlayerGui:FindFirstChild('Safe') then
						local SafeClone = script:FindFirstChild('Safe'):Clone()
						SafeClone.Parent = Player:FindFirstChild('PlayerGui')
						SafeClone.Frame:FindFirstChild('Handler').Enabled = true
						SafeClone.Enabled = true
						SafeClone.Frame.Close.MouseButton1Click:Connect(function()
							SafeClone:Destroy()
						end)
					end
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'This isnt your apartment!', 3)
				end
			end
		end)
	end
end