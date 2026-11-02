local cant = {'Fist', 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool', 'Box'}
local JoinTime = {}

game:FindService('Players').PlayerAdded:Connect(function(Player)
	local Waited = false
	local ForceField = Instance.new('ForceField', Player.Character or Player.CharacterAdded:Wait())
	if Player:IsInGroup(33159644) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800059564) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 780822224) then
		if Player:IsInGroup(33159644) and Player:GetRankInGroup(33159644) == 1 then return end
		Player.CharacterAdded:Connect(function(Character)
			if Player.Team == game.Teams.PD then
				Character:WaitForChild('HumanoidRootPart').Anchored = true
				task.wait(2)
				Character:WaitForChild('HumanoidRootPart').CFrame = workspace.POLICETP.CFrame
				task.wait(.5)
				Character:WaitForChild('HumanoidRootPart').Anchored = false
				task.wait(1)
				script:FindFirstChild('Radio'):Clone().Parent = Player.PlayerGui
			end
		end)
		Player.Chatted:Connect(function(Message)
			if string.lower(Message) == '/signin' and Player.Character and Waited == true and Player.Team == game.Teams.Civilians  then
				Player.Team = game.Teams.PD
				task.wait(.75)
				Player:LoadCharacter()
				task.wait(1)
				if Player:IsInGroup(33159644) then
					JoinTime[Player.UserId] = tick()
				end
			elseif (string.lower(Message) == '/signout' or string.lower(Message) == '/signoff') and Player.Character and Waited == true and Player.Team == game.Teams.PD then
				Player.Team = game.Teams.Civilians
				task.wait(.75)
				Player:LoadCharacter()
				if Player:IsInGroup(33159644) then
					local JoinTime = JoinTime[Player.UserId]
					if JoinTime then
						local currentTime = tick()
						local timeSpent = currentTime - JoinTime
						local minutesSpent = timeSpent / 60


						local data = {
							['embeds'] = {{
								['title'] = "**New Shift Log**",
								['description'] = "Player Who Ended Shift: " .. Player.Name,
								['color'] = 3447003,
								['url'] = "https://www.roblox.com/users/" .. Player.UserId .. "/profile",
								['fields'] = {
									{
										['name'] = "Time Spent",
										['value'] = math.floor(minutesSpent) .. 'm',
										['inline'] = true
									},
									{
										['name'] = "Rank",
										['value'] = tostring(Player:GetRoleInGroup(33159644)),
										['inline'] = true
									}
								}
							}}
						}
						local success, encodedData = pcall(function()
							return game:GetService('HttpService'):JSONEncode(data)
						end)

						if success then
							local successPost, response = pcall(function()
								return game:GetService('HttpService'):PostAsync("https://discord.com/api/webhooks/REDACTED", encodedData)
							end)
						end
						JoinTime[Player.UserId] = nil
					end
				end
			end
		end)
	end
	Player.Chatted:Connect(function(Message)
		if string.lower(Message) == '/respawn' and Player.Character and Waited == true then
			if Player.Character:FindFirstChild('Humanoid') then
				if Player.Character:FindFirstChild('Humanoid').Health >= 90 then
					Player:LoadCharacter()
				end
			end
		elseif string.lower(Message) == '/disable' then
			if Player:FindFirstChild('stored'):FindFirstChild('CustomEmoji').Value == '🛡️' then
				local Text = Player.Character:FindFirstChild('Head'):FindFirstChild('BillboardGui'):FindFirstChild('TextLabel')
				if Text and string.find(Text.Text, '[🛡️]') then
					Text.Text = string.gsub(Text.Text, '[🛡️%[%]]', '')
				end
			end
		elseif string.lower(Message) == '/enable' then
			if Player:FindFirstChild('stored'):FindFirstChild('CustomEmoji').Value == '🛡️' then
				local Text = Player.Character:FindFirstChild('Head'):FindFirstChild('BillboardGui'):FindFirstChild('TextLabel')
				if Text and not string.find(Text.Text, '[🛡️]') then
					Text.Text = '[🛡️]' .. Text.Text
				end
			end
		end
	end)
	task.wait(13)
	Waited = true
	task.wait(7)
	if Player.Character then
		if Player.Character:FindFirstChildOfClass('ForceField') then
			Player.Character:FindFirstChildOfClass('ForceField'):Destroy()
		end
	end
	if ForceField then
		ForceField:Destroy()
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote').OnServerEvent:Connect(function(Player, Message)
	Message = string.lower(Message)
	if Player.Character then
		if string.lower(Message) == '/signin' and Player.Character and Player.Team == game.Teams.Civilians then
			if Player:IsInGroup(33159644) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800059564) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 780822224) then
				if Player:IsInGroup(33159644) and Player:GetRankInGroup(33159644) == 1 then return end
				Player.Team = game.Teams.PD
				task.wait(.75)
				Player:LoadCharacter()
			end
		elseif string.lower(Message) == '/signout' and Player.Character and Player.Team == game.Teams.PD then
			if Player:IsInGroup(33159644) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800059564) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 780822224) then
				if Player:IsInGroup(33159644) and Player:GetRankInGroup(33159644) == 1 then return end
				Player.Team = game.Teams.Civilians
				task.wait(.75)
				Player:LoadCharacter()
				if Player:IsInGroup(33159644) then
					local JoinTime = JoinTime[Player.UserId]
					if JoinTime then
						local currentTime = tick()
						local timeSpent = currentTime - JoinTime
						local minutesSpent = timeSpent / 60


						local data = {
							['embeds'] = {{
								['title'] = "**New Shift Log**",
								['description'] = "Player Who Ended Shift: " .. Player.Name,
								['color'] = 3447003,
								['url'] = "https://www.roblox.com/users/" .. Player.UserId .. "/profile",
								['fields'] = {
									{
										['name'] = "Time Spent",
										['value'] = math.floor(minutesSpent) .. 'm',
										['inline'] = true
									},
									{
										['name'] = "Rank",
										['value'] = tostring(Player:GetRoleInGroup(33159644)),
										['inline'] = true
									}
								}
							}}
						}
						local success, encodedData = pcall(function()
							return game:GetService('HttpService'):JSONEncode(data)
						end)

						if success then
							local successPost, response = pcall(function()
								return game:GetService('HttpService'):PostAsync("https://discord.com/api/webhooks/REDACTED", encodedData)
							end)
						end
						JoinTime[Player.UserId] = nil
					end
				end
			end
		elseif string.lower(Message) == '/respawn' and Player.Character then
			if Player.Character:FindFirstChild('Humanoid') then
				if Player.Character:FindFirstChild('Humanoid').Health >= 90 then
					Player:LoadCharacter()
				end
			end
		elseif string.lower(Message) == '/drop' and Player.Character then
			if not Player.Character:FindFirstChildWhichIsA("Tool") then return end
			local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
			if Player.Character:FindFirstChild('Humanoid') and Player.Character:FindFirstChild('Humanoid').Health == 0 then return end
			if not table.find(cant, Tool.Name) and not Tool:FindFirstChild('POLICE') then
				local a = Instance.new("Animation", Player.Character)
				a.AnimationId = "rbxassetid://16210207065"
				local h = Player.Character:FindFirstChild("Humanoid")
				local t = h:LoadAnimation(a)
				t.Priority = Enum.AnimationPriority.Action4
				t:Play()
				wait(1)
				local Handle = Tool:FindFirstChild('Handle')		
				Tool.Parent = workspace
				Handle.CFrame = Handle.CFrame + Player.Character:FindFirstChild('HumanoidRootPart').CFrame.LookVector * 5
			end
		end
	end
end)

task.wait(60)

local Table = {}
local Amount = 0
while task.wait(600) do
	table.clear(Table)
	Table = {}
	for _,v in next, game:FindService('Players'):GetPlayers() do
		if v.Team == game.Teams.PD then
			Amount = Amount + 1
			table.insert(Table, v)
		end
	end
	if Amount >= 2 then
		for _,v in next, Table do
			if v.Team == game.Teams.PD and v:IsInGroup(33159644) then
				v:FindFirstChild('stored'):FindFirstChild('Money').Value += math.random(3000, 5000)
				if v:FindFirstChild('stored') then
					local XPValue = v:FindFirstChild('stored'):FindFirstChild('XP')
					local LevelValue = v:FindFirstChild('stored'):FindFirstChild('Level')
					if XPValue.Value + 20 >= 100 then
						if LevelValue.Value >= 200 then
						else
							LevelValue.Value += 1
							XPValue.Value = 0
						end
					else
						XPValue.Value += 20
					end
				end
			end
		end
	end
end
