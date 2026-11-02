local RemoteEvent = script.Parent:WaitForChild("RemoteEvent")
local Using = false
local TargetTorso

function CheckForChar(Part)
	if Part.Parent:IsA'Model' and Part.Parent:FindFirstChildOfClass'Humanoid' then
		local Char = Part.Parent
		local Torso
		if Char:FindFirstChild'Torso' then
			Torso = Char.Torso
		else 
			Torso = Char.UpperTorso
		end
		TargetTorso = Torso
		script.Parent.Suspect.Value = TargetTorso.Parent.Name
		return Char
	end
end

function CheckForTorso(player)
	local Char = player.Character
	if Char:FindFirstChild'Torso' then
		return Char.Torso
	else 
		return Char.UpperTorso
	end
end

RemoteEvent.OnServerEvent:Connect(function(player, one, two, Tool)
	if one == 'Cuff' then	
		if (player:IsInGroup(33159644) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(player.UserId, 800059564) or (game:FindService('MarketplaceService'):UserOwnsGamePassAsync(player.UserId, 780822224)) and player.Team == game.Teams.PD) then
			if player:IsInGroup(33159644) and player:GetRankInGroup(33159644) == 1 then return end
			local Target = CheckForChar(two)		
			local PlayerTorso = CheckForTorso(player)

			if Target then
				Using = true
				local new = Instance.new("BoolValue")
				new.Name = "RAGDOLLED"
				new.Value = true
				new.Parent = Target
				RemoteEvent:FireClient(player, 'Use')
				spawn(function()
					while Using and task.wait() do
						TargetTorso.Anchored = true
						TargetTorso.CanCollide = false
						TargetTorso.Parent.Head.CanCollide = false
						TargetTorso.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new( 0, 0, -3 )
						if not TargetTorso then
							Using = false	
							if TargetTorso.Parent:FindFirstChild("RAGDOLLED") then
								TargetTorso.Parent:FindFirstChild("RAGDOLLED"):Destroy()
							end
							wait()
							TargetTorso.Anchored = false
							TargetTorso.CanCollide = true
							if player.PlayerGui:FindFirstChild('JailUI') then
								player.PlayerGui:FindFirstChild('JailUI'):Destroy()
							end
							script.Parent.Suspect.Value = ''
							Using = false		
							RemoteEvent:FireClient(player, 'STOP')
							break
						end
					end				
				end)			
			end

			if Tool.Parent:IsA('Model') and Tool ~= nil and Target then
				local Target = game:FindService('Players'):GetPlayerFromCharacter(Target)
				if Target.Character:FindFirstChild('Humanoid').Health == 0 or Target == nil then return end
				if player.PlayerGui:FindFirstChild('JailUI') then
					player.PlayerGui:FindFirstChild('JailUI'):Destroy()
				end
				local ui = script.JailUI:Clone()
				ui.Parent = player.PlayerGui
				local Jailed = Target:WaitForChild('stored'):WaitForChild('Jailed')
				ui.Frame["180"].MouseButton1Down:Connect(function()
					Jailed.Value = 180
					wait(0.5)
					Target:LoadCharacter()
					if player:FindFirstChild('stored') then
						local XPValue = player:FindFirstChild('stored'):FindFirstChild('XP')
						local LevelValue = player:FindFirstChild('stored'):FindFirstChild('Level')
						if XPValue.Value + 5 >= 100 then
							if LevelValue.Value >= 200 then
							else
								LevelValue.Value += 1
								XPValue.Value = 0
							end
						else
							XPValue.Value += 5
						end
					end
					ui:Destroy()
				end)
				if player:IsInGroup(33159644) then
					ui.Frame["300"].MouseButton1Down:Connect(function()
						Jailed.Value = 300
						wait(0.5)
						Target:LoadCharacter()
						if player:FindFirstChild('stored') then
							local XPValue = player:FindFirstChild('stored'):FindFirstChild('XP')
							local LevelValue = player:FindFirstChild('stored'):FindFirstChild('Level')
							if XPValue.Value + 5 >= 100 then
								if LevelValue.Value >= 200 then
								else
									LevelValue.Value += 1
									XPValue.Value = 0
								end
							else
								XPValue.Value += 5
							end
						end
						ui:Destroy()
					end)
					ui.Frame["600"].MouseButton1Down:Connect(function()
						Jailed.Value = 600
						wait(0.5)
						Target:LoadCharacter()
						if player:FindFirstChild('stored') then
							local XPValue = player:FindFirstChild('stored'):FindFirstChild('XP')
							local LevelValue = player:FindFirstChild('stored'):FindFirstChild('Level')
							if XPValue.Value + 5 >= 100 then
								if LevelValue.Value >= 200 then
								else
									LevelValue.Value += 1
									XPValue.Value = 0
								end
							else
								XPValue.Value += 5
							end
						end
						ui:Destroy()
					end)
				end

				if Target.Backpack ~= nil then
					for i,v in pairs(Target.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							local Clone = ui.Frame.Frame.TextButton:Clone()
							Clone.Text = v.Name
							Clone.Visible = true
							Clone.Parent = ui.Frame.Frame.Aaaa
							Clone.MouseButton1Click:Connect(function()
								if Target.Backpack:FindFirstChild(Clone.Text) and Clone.Text ~= 'Fist' and Clone.Text ~= 'Phone' then
									Target.Backpack:FindFirstChild(Clone.Text):Destroy()
									Clone:Destroy()
								end
							end)
						end
					end
				end
				ui.Frame.TheGuy.Text = Target.Name
				if Target.Character:FindFirstChildOfClass('Tool') then
					Target.Character:FindFirstChildOfClass('Tool').Parent = Target.Backpack
				end
				ui.Frame.Close.MouseButton1Click:Connect(function()
					Using = false	
					if TargetTorso.Parent:FindFirstChild("RAGDOLLED") then
						TargetTorso.Parent:FindFirstChild("RAGDOLLED"):Destroy()
					end
					wait()
					TargetTorso.Anchored = false
					TargetTorso.CanCollide = true
					script.Parent.Suspect.Value = ''
					RemoteEvent:FireClient(player, 'STOP')
					ui:Destroy()
				end)
			end
		end
	elseif one == 'UnCuff' then	

		Using = false	
		if TargetTorso.Parent:FindFirstChild("RAGDOLLED") then
			TargetTorso.Parent:FindFirstChild("RAGDOLLED"):Destroy()
		end
		wait()
		TargetTorso.Anchored = false
		TargetTorso.CanCollide = true
		script.Parent.Suspect.Value = ''
		RemoteEvent:FireClient(player, 'STOP')
		if player.PlayerGui:FindFirstChild('JailUI') then
			player.PlayerGui:FindFirstChild('JailUI'):Destroy()
		end
	end
end)

script.Parent.releas.Event:Connect(function()
	Using = false		
	wait()
	TargetTorso.Anchored = false
	TargetTorso.CanCollide = true
	script.Parent.Suspect.Value = ''	
end)