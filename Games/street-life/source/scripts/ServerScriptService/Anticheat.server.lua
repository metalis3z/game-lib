local Whitelist = {
	'diesel_bcr',
	'MRbubbleBalz',
	'RXM4L',
	'lukeberrbest',
	'Nicklasrosen',
	'Yshamz29',
	'datjjvic2',
	'fakeflipsy',
	'SinfulFrmLFS',
	'3xclus1ve_i',
	'MrOpppy',
	'mohamedcam121',
	'aBrk_Monster',
	'TotallyNotXerox',
	'Lightitupjay',
	'imagination_king60',
	'Mc2drippy7',
	'Zosmula',
	'hundomell',
	'spitztll',
	'alexander1235463',
	'itzzdomm',
	'Syncz0113',
	'yoboi_bob477',
	'4EHoodRich',
	'Heihachi3881',
	'king_omarxxx',
	'Samcoolboy102',
	'LOL2CXMP',
	'krissware',
	'checkfruad',
	'Xx_exch0',
	'29Tyrese1',
	'CR8ZI4U',
	'reliableinternet',
	'1_IZB',
	'RxckyOverHeaven',
	'jerrydjdj'
}

local ReplicatedStorage = game:FindService('ReplicatedStorage')
local HttpService = game:FindService('HttpService')
game:FindService('Players').PlayerAdded:Connect(function(Player)
	local Enter = Instance.new('BoolValue', Player)
	Enter.Name = 'Enter'
	Player.CharacterAdded:Connect(function(Character)
		if table.find(Whitelist, Player.Name) then return end
		Character:WaitForChild('HumanoidRootPart')
		Character:WaitForChild('Humanoid')

		--[[
		local AnticheatClone = script:WaitForChild('ClientSided Anticheat'):Clone()
		AnticheatClone.Name = tostring(math.random(0, 9e5))
		AnticheatClone.Parent = Character
		AnticheatClone.Enabled = true

		for _,v in ipairs(Player:WaitForChild('Backpack'):GetChildren()) do
			if v:IsA('LocalScript') and string.find(v.Name, '%d') and string.find(v.Name, 'Camera') then
				v:Destroy()
				return
			end
		end

		local AnticheatCheckerClone = script:WaitForChild('ClientSided Anticheat Checker'):Clone()
		AnticheatCheckerClone.Name = 'Camera ' .. tostring(math.random(1313, 5832))
		AnticheatCheckerClone.Parent = Player:WaitForChild('Backpack')
		AnticheatCheckerClone.Enabled = true
		]]
		task.wait(10)

		local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
		local Humanoid = Character:WaitForChild('Humanoid')

		Character.ChildRemoved:Connect(function(Child)
			if Child.Name == 'HumanoidRootPart' then
				if Child:FindFirstChild('Humanoid') then
					if Child:FindFirstChild('Humanoid').Health > 0 then
						Player:LoadCharacter() 
						Player:Kick()
					end
				end
			end
		end)

		local Check = 0 
		while (true) do
			local FirstCFrame = HumanoidRootPart.Position
			task.wait(1)
			local SecondCFrame = HumanoidRootPart.Position
			local CFrameDifference = (FirstCFrame - SecondCFrame).Magnitude 

			if CFrameDifference < 0 then
				CFrameDifference =  (FirstCFrame - SecondCFrame) * (-1)
			end

			if CFrameDifference > 30 and not Character:WaitForChild('InCar').Value and not Player:WaitForChild('Enter').Value then
				if Character:FindFirstChild('Humanoid').Health > 0 then
					if Check >= 2 then HumanoidRootPart.Position = FirstCFrame end
					Check += 1
					if Check >= 4 then Player:LoadCharacter() return end
					task.delay(60, function() Check -= 1 end)
				end
			end

			if HumanoidRootPart.CFrame.X > 5000 or HumanoidRootPart.CFrame.X < -5000 or HumanoidRootPart.CFrame.Z > 5000 or HumanoidRootPart.CFrame.Z < -5000 then
				Player:LoadCharacter() 
				return
			end
		end
	end)
end)


local Remote = Instance.new('RemoteEvent', ReplicatedStorage)
Remote.Name = tostring(math.random(0, 9e5))

Remote.OnServerEvent:Connect(function(Player, Name)
	if table.find(Whitelist, Player.Name) then return end
	if Name == Remote.Name then
		Player:Kick('Exploits Detected.')
	else
		game:GetService('HttpService'):PostAsync("https://discord.com/api/webhooks/REDACTED",
		    game:GetService('HttpService'):JSONEncode({
			    content = 'Player "' .. tostring(Player.Name) .. '" tried to fire remote'
		    })
		)   
		Player:Kick('Exploits Detected.')
	end
end)

for _,v in next, game:FindService('ServerStorage'):GetChildren() do
	if v:IsA('Tool') and v:FindFirstChild('Setting') then
		Table = require(v:FindFirstChild('Setting')) or {}
		if Table then table.freeze(Table) end
	end
end