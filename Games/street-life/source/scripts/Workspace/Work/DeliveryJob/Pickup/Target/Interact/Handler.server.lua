local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local Model = game:FindService('ReplicatedStorage').Misc:FindFirstChild('DeliveryFood')

script.Parent.Triggered:Connect(function(Player)
	local Extra = Player:WaitForChild('Extra')
	
	if not Player.Character:FindFirstChild('DeliveryFood') or Player.Backpack:FindFirstChild('DeliveryFood') then
		JobRemote:FireClient(Player, 'PickedUp', script.Parent)
		Model:Clone().Parent = Player.Character
		
		local Table = {}
		
		for _,v in next, game:FindService('ReplicatedStorage').Misc:GetChildren() do
			if v.Name == 'NPC' then
				table.insert(Table, v)
			end
		end
		
		local NPC = Table[math.random(1, 3)]:Clone()
		NPC.Parent = workspace
		NPC.Name = 'NPC ' .. Player.Name
		NPC:SetPrimaryPartCFrame(workspace.NPCPositions:GetChildren()[math.random(1, #workspace.NPCPositions:GetChildren())].CFrame)
		task.wait(45)
		if NPC and workspace:FindFirstChild('NPC ' .. Player.Name) then
			NPC:Destroy()
		end
	end
end)