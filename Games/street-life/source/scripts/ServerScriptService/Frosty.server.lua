local Versions = {}

local Frosty = workspace:WaitForChild('Frosty')
local Misc = game:FindService('ReplicatedStorage'):WaitForChild('Misc')
local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

for _,v in next, Frosty:FindFirstChild('Versions'):GetChildren() do 
	table.insert(Versions, v:FindFirstChild('MeshPart').Color)
	local Clone = script:FindFirstChild('ProximityPrompt'):Clone()
	Clone.ObjectText = 'Grab'
	Clone.HoldDuration = .5
	Clone.Parent = v:FindFirstChild('MeshPart')
	Clone.Enabled = false
	Clone.Triggered:Connect(function(Player)
		local Extra = Player:WaitForChild('Extra')
		local Stored = Player:WaitForChild('stored')
		
		if Extra.Job.Value == 'Frosty' then
			if Frosty.NPCArea:FindFirstChild('NPC ' .. Player.Name) then
				if not Player:FindFirstChild('CurrentFrost') then
					local Bool = Instance.new('Color3Value')
					Bool.Value = v:FindFirstChild('MeshPart').Color
					Bool.Name = 'CurrentFrost'
					Bool.Parent = Player
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Throw away your current frost to grab a new one', 3)
				end
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Wait for a customer!', 3)
			end
		end
	end)
end

local Clone = script:FindFirstChild('ProximityPrompt'):Clone()
Clone.Parent = Frosty:FindFirstChild('Interact')
Clone.Triggered:Connect(function(Player)
	local Extra = Player:WaitForChild('Extra')
	local Stored = Player:WaitForChild('stored')

	if Extra.Job.Value == '' then
		Extra.Job.Value = 'Frosty'
		JobRemote:FireClient(Player, 'Frosty', Clone)
		NotifyRemote:FireClient(Player, 'Frosty Job Started.', 2)
		local Earned = Instance.new('IntValue', Player)
		Earned.Value = 0
		Earned.Name = 'FrostyJobEarned'
		task.wait(math.random(1, 3))
		while Player and Extra.Job.Value == 'Frosty' do
			if not Frosty.NPCArea:FindFirstChild('NPC ' .. Player.Name) then
				local Table = {}

				for _,v in next, game:FindService('ReplicatedStorage').Misc:GetChildren() do
					if v.Name == 'FrostNPC' then
						table.insert(Table, v)
					end
				end

				local NPC = Table[math.random(1, 3)]:Clone()
				NPC.Name = 'NPC ' .. Player.Name
				NPC.Parent = Frosty.NPCArea
				NPC:SetPrimaryPartCFrame(Frosty.NPCArea.CFrame)
				NPC:FindFirstChild('ColorValue').Value = Versions[math.random(1, #Versions)]
			end
			task.wait(math.random(3, 5))
		end
	elseif Extra.Job.Value == 'Frosty' then
		Extra.Job.Value = ''
		JobRemote:FireClient(Player, 'FrostyQuit', Clone)
		NotifyRemote:FireClient(Player, 'Frosty Job Ended.', 2)
		if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
		local MoneyEarned = Player:WaitForChild('FrostyJobEarned').Value
		local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
		Adder.Parent = Player.PlayerGui
		Adder.Amount.Text = '+$' .. tostring(MoneyEarned)
		Stored.Money.Value += MoneyEarned
		Player:FindFirstChild('FrostyJobEarned'):Destroy()
		if Frosty.NPCArea:FindFirstChild('NPC ' .. Player.Name) then
			Frosty.NPCArea:FindFirstChild('NPC ' .. Player.Name):Destroy()
		end
		for _,v in next, Frosty.NPCArea:GetChildren() do
			if v.Name == 'NPC ' .. Player.Name then
				v:Destroy()
			end
		end
		task.wait(2)
		for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
		Adder:Destroy()
	end
end)

game:FindService('Players').PlayerRemoving:Connect(function(Player)
	for _,v in next, Frosty.NPCArea:GetChildren() do
		if v.Name == 'NPC ' .. Player.Name then
			v:Destroy()
		end
	end
end)