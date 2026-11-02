if not game:IsLoaded() then game.Loaded:Wait() end task.wait(2)

for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA('ProximityPrompt') then
		if v.Name == 'ATM' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				if not Player.PlayerGui:FindFirstChild('BetterATM') then
					local GUI = game:GetService('ReplicatedStorage'):FindFirstChild('BetterATM'):Clone()
					GUI:FindFirstChild('Frame').Misc.Part.Value = v.Parent
					GUI.Parent = Player.PlayerGui
					GUI.Enabled = true
				end
			end)
		elseif v.Name == 'Blank' then
			v.Enabled = false
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				if Character:FindFirstChild('ActiveCard') then
					if Player.PlayerGui:FindFirstChild('BetterATM') then Player.PlayerGui:FindFirstChild('BetterATM'):Destroy() end
					game:FindService('ReplicatedStorage').Blank:FireServer(Character:FindFirstChild('ActiveCard'), v)
					v.Enabled = false
					task.wait(2)
					repeat task.wait(.1) until Player.Character.HumanoidRootPart.Anchored == false
					v.Parent:FindFirstChild('ATM').Enabled = true
				end
			end)
		elseif v.Name == 'Store' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				local Clone = game:FindService('ReplicatedStorage').Store:Clone()
				if v.Parent.Parent.Name == 'DNPC' then
					Clone.Frame.Namey.Text = 'Deli Store'
				elseif v.Parent.Parent.Name == 'GNPC' then
					Clone.Frame.Namey.Text = 'Gas Station Store'
				elseif v.Parent.Parent.Name == 'DDNPC' then
					Clone.Frame.Namey.Text = 'Deminos Store'
				elseif v.Parent.Parent.Name == 'NightNPC' then
					Clone.Frame.Namey.Text = 'NightClub Store'
				end
				Clone.Parent = Player.PlayerGui
				Clone.Enabled = true
				v.Enabled = false
				Clone.Frame.Object.Value = v
			end)
		elseif v.Name == 'PUStore' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				local Clone = game:FindService('ReplicatedStorage').PUStore:Clone()
				Clone.Parent = Player.PlayerGui
				Clone.Enabled = true
				v.Enabled = false
				Clone.Frame.Object.Value = v
			end)
		elseif v.Name == 'HStore' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				local Clone = game:FindService('ReplicatedStorage').HStore:Clone()
				Clone.Parent = Player.PlayerGui
				Clone.Enabled = true
				v.Enabled = false
				Clone.Frame.Object.Value = v
			end)			
		elseif v.Name == 'GStore' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				local Clone = game:FindService('ReplicatedStorage').GStore:Clone()
				Clone.Parent = Player.PlayerGui
				Clone.Enabled = true
				v.Enabled = false
				Clone.Frame.Object.Value = v
			end)			
		elseif v.Name == 'GunInteract' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				if not Player.PlayerGui:FindFirstChild('GunStore') then
					local Clone = script.GunStore:Clone()
					Clone.Parent = Player.PlayerGui
					Clone.Wall.Value = v.Parent:FindFirstChild('Object').Value
					Clone.Enabled = true
					Clone.Handler.Enabled = true
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				end
			end)
		elseif v.Name == 'CarDealer' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				if Player.PlayerGui:FindFirstChild('CarDealerGui') then Player.PlayerGui:FindFirstChild('CarDealerGui'):Destroy() end
				if not Player.PlayerGui:FindFirstChild('CarDealerGui') then
					local Clone = script.CarDealerGui:Clone()
					Clone.Parent = Player.PlayerGui
					Clone.Enabled = true
					Clone.Handler.Enabled = true
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				end
			end)
		elseif v.Name == 'IDealer' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled or Character.Humanoid.Sit then return end
				if Player.PlayerGui:FindFirstChild('IDealerGui') then Player.PlayerGui:FindFirstChild('IDealerGui'):Destroy() end
				if not Player.PlayerGui:FindFirstChild('IDealerGui') then
					local Clone = script.IDealerGui:Clone()
					Clone.Parent = Player.PlayerGui
					Clone.Enabled = true
					Clone.Handler.Enabled = true
					Clone.Object.Value = v
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
					v.Enabled = false
				end
			end)
		elseif v.Name == 'Garage' then
			v.Enabled = true
			v.Triggered:Connect(function(Player)
				local Character = Player.Character or Player.CharacterAdded:Wait()
				if not Character or not v.Enabled then return end
				local Humanoid = Character:WaitForChild('Humanoid')
				if not Humanoid then return end
				if Player.PlayerGui:FindFirstChild('GarageUI') then Player.PlayerGui:FindFirstChild('GarageUI'):Destroy() return end
				if not Player.PlayerGui:FindFirstChild('GarageUI') then
					if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car") then
						if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChildOfClass('VehicleSeat').Occupant ~= nil and workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChildOfClass('VehicleSeat').Occupant.Parent == Character then
							if workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value == 'PDCar' or workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value == 'Scooter' or workspace:FindFirstChild('CivCars'):FindFirstChild(Player.Name .. "'s Car"):FindFirstChild('CarType').Value == 'PDCar2' then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You cant customize this vehicle.', 3)
								return
							end
							local Clone = script.GarageUI:Clone()
							Clone.Parent = Player.PlayerGui
							Clone.Object.Value = v
							Clone.Enabled = true
							Clone.Handler.Enabled = true
							game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
							v.Enabled = false
						else
							game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You arent inside of you car.', 3)
							return
						end
					else
						game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('No Car Found.', 3)
						return
					end
				end
			end)
		elseif v.Parent.Parent == workspace.Teleports then
			if v.Name == 'Teleport' then
				if v.Parent.Name == 'Apartment1' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment1In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Apartment1In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment1').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Apartment2' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment2In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Apartment2In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment2').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Apartment3' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment3In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Apartment3In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Apartment3').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.5)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'PD' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('PDin').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	
				elseif v.Parent.Name == 'PDin' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							if Player.PlayerGui:FindFirstChild('Locker') then
								Player.PlayerGui:FindFirstChild('Locker'):Destroy()
							end
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('PD').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	

				elseif v.Parent.Name == 'Turf1' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf1In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Turf1In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf1').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Turf2' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf2In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Turf2In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf2').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)

				elseif v.Parent.Name == 'Turf3' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(12817719) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf3In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Turf3In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Turf3').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	
				elseif v.Parent.Name == 'Kta' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(33949387) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if  Player:GetRankInGroup(33949387) < 4 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('NOT HIGH ENOUGH RANK', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('KtaIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'KtaIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Kta').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FBA' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FBAIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FBAIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FBA').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '4M' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('4MIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '4MIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('4M').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'EOK' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(32346635) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(32346635) < 6 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('YOU HAVE TO BE ELITE RANK OR ABOVE TO ENTER!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('EOKIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'EOKIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('EOK').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Fno' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FnoIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FnoIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Fno').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '9block' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('9blockIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '9blockIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('9block').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '1B' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('1BIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '1BIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('1B').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'EBG' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('EBGIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'EBGIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('EBG').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'STB' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('STBIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'STBIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('STB').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Evil' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(34002360) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(34002360) < 3 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('YOU HAVE TO BE A HIGHER RANK TO ENTER!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('EvilIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'EvilIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Evil').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Ruthless' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RuthlessIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RuthlessIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Ruthless').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'THM' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('THMIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'THMIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('THM').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TFK' then
					v.Triggered:Connect(function(Player)
						if not Player:IsInGroup(32865491) then 
							game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
							return 
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TFKIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TFKIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TFK').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TD' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TDIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TDIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TD').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'GM' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('GMIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'GMIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('GM').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FFH' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FFHIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FFHIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FFH').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'YGG' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('YGGIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'YGGIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('YGG').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'ABZ' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('ABZIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'ABZIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('ABZ').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'OTB' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('OTBIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'OTBIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('OTB').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Star' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(10030562) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('StarIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'StarIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Star').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'YCP' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('YCPIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'YCPIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('YCP').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CS' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CSIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CSIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CS').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CG' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CGIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CGIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CG').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '600' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('600In').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == '600In' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('600').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Rev' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(15021038) then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(15021038) < 30 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('RANK NOT HIGH ENOUGH!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RevIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RevIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Rev').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Shot' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('ShotIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'ShotIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Shot').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RDO' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(34234737) then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(34234737) < 3 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('RANK NOT HIGH ENOUGH!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RDOIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RDOIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RDO').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'HTB' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('HTBIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'HTBIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('HTB').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FM' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FMIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'FMIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('FM').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	
				elseif v.Parent.Name == 'AG' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('AGIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'AGIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('AG').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	
				elseif v.Parent.Name == 'LK' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('LKIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'LKIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('LK').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'AOT' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('AOTIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'AOTIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('AOT').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)		
				elseif v.Parent.Name == 'Lac' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(6288849) then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(6288849) < 6 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('RANK NOT HIGH ENOUGH!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('LacIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'LacIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Lac').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RED' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(33246308) then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
							if Player:GetRankInGroup(33246308) < 5 then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('RANK NOT HIGH ENOUGH!', 3)
								return
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('REDIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'REDIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RED').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'DD' then
					v.Triggered:Connect(function(Player)
						if not Player:IsInGroup(33908647) then
							game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
							return 
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('DDIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'DDIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('DD').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TurfApt' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TurfAptIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TurfAptIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TurfApt').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TB' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(17259706) then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TBIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TBIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TB').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Loe' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('LoeIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'LoeIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Loe').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Ruined' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('RuinedIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'RuinedIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Ruined').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)	
				elseif v.Parent.Name == 'Keo' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('KeoIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'KeoIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Keo').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TYB' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TYBIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'TYBIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('TYB').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CHK' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CHKIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CHKIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CHK').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'NR' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('NRIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'NRIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('NR').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Kos' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(34765220) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('KosIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'KosIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Kos').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'Ctrl' then
					v.Triggered:Connect(function(Player)
						if Player.Team == game.Teams.Civilians then
							if not Player:IsInGroup(34619750) then 
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('You must be in the group to enter!', 3)
								return 
							end
						end
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('CtrlIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'CtrlIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Ctrl').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'NightClub' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('NightClubIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'NightClubIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('NightClub').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
						end
					end)
				elseif v.Parent.Name == 'HemfulLab' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('HemfulLabIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
							Player.PlayerGui.Harvested.Sugar.Visible = true
							Player.PlayerGui.Harvested.TextLabel.Visible = true
							Player.PlayerGui.Harvested.Enabled = true
						end
					end)
				elseif v.Parent.Name == 'HemfulLabIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('HemfulLab').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
							Player.PlayerGui.Harvested.Sugar.Visible = false
							Player.PlayerGui.Harvested.TextLabel.Visible = false
							Player.PlayerGui.Harvested.Enabled = false
						end
					end)
				elseif v.Parent.Name == 'Vault' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if game:FindService('ReplicatedStorage'):WaitForChild('BankRobbery').Value == false then
							if not Player.Character:FindFirstChild('C4') and not Player.Backpack:FindFirstChild('C4') then
								game:FindService('ReplicatedStorage'):WaitForChild('Notify'):FireServer('YOU DONT HAVE C4 / Bank Robbery Hasnt Started', 3)
								return
							end
						end
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('VaultIn').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							if Player.Character:FindFirstChild('ArrowHandler') then Player.Character:FindFirstChild('ArrowHandler'):Destroy() end
							if Player.Character:FindFirstChild('Arrow') then Player.Character:FindFirstChild('Arrow'):Destroy() end
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
							if Player.Character:FindFirstChild('BankTotal').Value == 0 then
								Player.PlayerGui.BankRobbery:FindFirstChild('Frame').Visible = false
							end
							if game:FindService('ReplicatedStorage'):FindFirstChild('BankTimeLeft').Value == 0 then
								Player.PlayerGui.BankRobbery:FindFirstChild('TextLabel').Visible = false
								Player.PlayerGui.BankRobbery:FindFirstChild('Frame').Visible = false
							end
							Player.PlayerGui.BankRobbery.Enabled = true
							Player.Character:FindFirstChild('InsideVault').Value = true
						end
					end)
				elseif v.Parent.Name == 'VaultIn' then
					v.Triggered:Connect(function(Player)
						local Character = Player.Character or Player.CharacterAdded:Wait()
						if not Character or not v.Enabled or Character.Humanoid.Sit then return end
						local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
						if not Player.PlayerGui:FindFirstChild('Fade') and HumanoidRootPart then
							local GUI = script.Fade:Clone()
							GUI.Parent = Player.PlayerGui
							GUI.Enabled = true
							GUI.Door:Play()
							repeat GUI.Frame.BackgroundTransparency -= .1 task.wait(.01) until GUI.Frame.BackgroundTransparency <= 0
							HumanoidRootPart.Anchored = true
							HumanoidRootPart.CFrame = v.Parent.Parent:FindFirstChild('Vault').CFrame
							task.wait(1)
							repeat GUI.Frame.BackgroundTransparency += .1 task.wait(.01) until GUI.Frame.BackgroundTransparency >= 1
							task.wait(.25)
							HumanoidRootPart.Anchored = false
							GUI:Destroy()
							Player.PlayerGui.BankRobbery.Enabled = false
							if Player.Character:FindFirstChild('BankTotal').Value > 0 then
								game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireServer('SELL THE LOOT AT THE MARKED POSITION!', 3)
							end
							if Player.Character:FindFirstChild('BankTotal').Value >= 1 then
								if Player.Character:FindFirstChild('ArrowHandler') then Player.Character:FindFirstChild('ArrowHandler'):Destroy() end
								if Player.Character:FindFirstChild('Arrow') then Player.Character:FindFirstChild('Arrow'):Destroy() end
								task.wait(.5)
								local Clone = script:FindFirstChild('ArrowHandler'):Clone()
								Clone.Parent = Player.Character
								Clone.Target.Value = v.Parent:FindFirstChildOfClass('ObjectValue').Value
								Clone.Enabled = true
							end
							Player.Character:FindFirstChild('InsideVault').Value = false
						end
					end)
				end
			end
		end
	end
end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.CharacterAdded:Wait()
local Extra = Player:WaitForChild('Extra')
Character:WaitForChild('Humanoid')
task.wait(3)
workspace:WaitForChild('Work'):WaitForChild('DeliveryJob'):WaitForChild('Pickup'):WaitForChild('Target'):WaitForChild('Interact')

if Extra.Job == 'Delivery' then
	workspace.Work.DeliveryJob.Pickup.Target.Interact = true
	workspace.Work.DeliveryJob.Pickup:WaitForChild('Ye').BillboardGui.Enabled = true
else
	workspace.Work.DeliveryJob.Pickup.Target.Interact = false
	workspace.Work.DeliveryJob.Pickup:WaitForChild('Ye').BillboardGui.Enabled = false
end