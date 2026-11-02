local Settings = require(game:FindService('ReplicatedStorage'):WaitForChild('Gang Settings'))

Gang_Check = function(Player)
	if Player:FindFirstChild('stored'):FindFirstChild('Gang') then
		if Player:IsInGroup(Player:FindFirstChild('stored'):FindFirstChild('Gang').Value) then
			return Player:FindFirstChild('stored'):FindFirstChild('Gang').Value
		end
	end return nil
end

Gang_Info = function(Gang)
	if Gang ~= nil and Gang ~= '' then
		local Info = game:FindService('GroupService'):GetGroupInfoAsync(Gang)
		if Info then
			if Info.Name then return Info.Name end
		end
	end
	return nil
end

for _,v in next, workspace:WaitForChild('GZones'):GetChildren() do
	if v:IsA('MeshPart') and v:FindFirstChild('Gang') then
		local Interact = script:FindFirstChild('Interact'):Clone()
		local Handler, Gang, Timer, Collect = Interact:WaitForChild('Handler'), v:FindFirstChild('Gang'), v:WaitForChild('Time'), v:WaitForChild('Collect')
		Interact.CFrame = v.CFrame + Vector3.new(0, 3, 0)
		Interact.Parent = v
		Timer.Value = Settings.Config.Time
		Handler.Triggered:Connect(function(Player)
			local Check = Gang_Check(Player)
			if Check then
				local Current_Gang = tonumber(Gang.Value)
				local Gang_Name = Gang_Info(Current_Gang)
				if Gang_Name == nil then Gang_Name = 'NOBODY' end

				if Current_Gang ~= Check then
					local GUI = script:FindFirstChildOfClass('ScreenGui'):Clone()
					GUI.Main.Object.Value = v
					GUI.Main.Top.Text = '  Zone: ' .. v.Name
					GUI.Main.Bottom.Actual.Text = 'This zone is controlled by <b>' .. Gang_Name .. '</b> and by controlling zones you can claim rewards'
					GUI.Parent = Player:WaitForChild('PlayerGui')
					GUI.Main.Claim.MouseButton1Click:Connect(function()
						if Current_Gang ~= Check and Interact.BillboardGui.Enabled ~= true then
							GUI:Destroy()
							Handler.Enabled = false
							task.wait(.5)
							Interact.BillboardGui.Enabled = true
							for _ = 1, 100 do Interact.BillboardGui.TextLabel.Text = 'Taking Over... ' .. _ .. '/100%' task.wait(.1) end
							Timer.Value = Settings.Config.Time
							task.wait(.5)
							game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Your gang now controls the ' .. v.Name .. ' Zone', 2)
							Interact.BillboardGui.TextLabel.Text = ''
							Interact.BillboardGui.Enabled = false
							Gang.Value = Check
							Handler.Enabled = true
						end
					end)
					GUI.Main.Close.MouseButton1Click:Connect(function() GUI:Destroy() end)
					task.spawn(function() task.wait(60) if GUI ~= nil then GUI:Destroy() end end)
				else
					local GUI = script:FindFirstChildOfClass('ScreenGui'):Clone()
					GUI.Main.Object.Value = v
					GUI.Main.Top.Text = '  Zone: ' .. v.Name
					GUI.Main.Bottom.Actual.Text = 'This zone is controlled by <b>' .. Gang_Name .. '</b> and by controlling zones you can claim rewards'
					GUI.Parent = Player:WaitForChild('PlayerGui')
					GUI.Main.Claim.Text = 'COLLECT REWARD'
					GUI.Main.Claim.MouseButton1Click:Connect(function()
						if Collect.Value == true then
							Collect.Value = false
							local CashAmount = math.random(Settings.Config.Money_Gain.Min, Settings.Config.Money_Gain.Max)
							for _,v in next, game:FindService('Players'):GetPlayers() do
								if v:FindFirstChild('stored'):FindFirstChild('Gang') and v:FindFirstChild('stored'):FindFirstChild('Gang').Value == Current_Gang then
									game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Your Gang Collected ' .. tostring(CashAmount) .. ' Cash.', 3)
									v:FindFirstChild('stored'):FindFirstChild('Money').Value += CashAmount
								end
							end
						else
							game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You have to wait ' .. tostring(Timer.Value) .. ' second(s) before collecting the reward', 2)
						end
					end)
					GUI.Main.Close.MouseButton1Click:Connect(function() GUI:Destroy() end)
					task.spawn(function() task.wait(60) if GUI ~= nil then GUI:Destroy() end end)
				end
			else
				game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You arent in any gang.', 2)
			end
		end)
		
		task.spawn(function()
			while task.wait(1) do
				if Gang.Value ~= nil and Gang.Value ~= '' and not Collect.Value then
					if Timer.Value <= 0 then
						Timer.Value = Settings.Config.Time
						Collect.Value = true
					else
						Timer.Value -= 1
					end
				end
			end
		end)
	end
end

game:FindService('ReplicatedStorage'):FindFirstChild('Gang').OnServerEvent:Connect(function(Player, Gang)
	if Player and Gang then
		if tonumber(Gang) ~= nil or Gang == 0 then
			if Player:IsInGroup(Gang) or Gang == 0 then
				if Player:FindFirstChild('stored'):FindFirstChild('Gang') then
					Player:FindFirstChild('stored'):FindFirstChild('Gang').Value = Gang
				end
			end
		end
	end
end)