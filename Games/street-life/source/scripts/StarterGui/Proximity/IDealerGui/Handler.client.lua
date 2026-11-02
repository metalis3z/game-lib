if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

local Buy = game:FindService('ReplicatedStorage'):FindFirstChild('Buy')
local Kaching, Error, Press = script:FindFirstChild('Kaching'), script:FindFirstChild('Error'), script:FindFirstChild('Press')
local NotifyRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

local Prices = {
	['Balaclava'] = 40,
	['MentosBag'] = 300,
	['BlankCard'] = 1000,
	['C4'] = 2000,
	['Bat'] = 750
}

spawn(function()
	task.wait(2)
	script.Parent:WaitForChild('Object')
	while task.wait(.5) do
		if script.Parent:WaitForChild('Object').Value then
			if HumanoidRootPart then
				if (HumanoidRootPart.Position - (script.Parent:WaitForChild('Object').Value.Parent:FindFirstChild('HumanoidRootPart')).Position).Magnitude >= 10 then
					script.Parent:WaitForChild('Object').Value.Enabled = true
					game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
					script.Parent:Destroy()
				end
			else
				script.Parent:WaitForChild('Object').Value.Enabled = true
				game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				script.Parent:Destroy()
			end
		end
	end
end)

for _,v in next, script.Parent:FindFirstChild('Frame'):GetChildren() do
	if v:IsA('TextButton') then
		if Prices[v.Name] then
			if v.Name ~= 'BlankCard' and v.Name ~= 'C4' then
				v.MouseButton1Click:Connect(function()
					if Stored.Money.Value >= Prices[v.Name] then
						Buy:FireServer(v.Name, Prices[v.Name])
						if not Kaching.IsPlaying then Kaching:Play() end
					else
						if not Error.IsPlaying then Error:Play() end
					end
				end)
				v.MouseEnter:Connect(function()
					v.Around.Thickness = 3
					if not Press.IsPlaying then Press:Play() end
				end)
				v.MouseLeave:Connect(function()
					v.Around.Thickness = 2
				end)
			elseif v.Name == 'BlankCard' then
				v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value) .. ' LEFT!'
				v.MouseButton1Click:Connect(function()
					if Stored.Money.Value >= Prices[v.Name] then
						if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800418473) or game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 793533527) then
							if workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value ~= 0 then
								Buy:FireServer(v.Name, Prices[v.Name])
								v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value) .. ' LEFT!'
								if not Kaching.IsPlaying then Kaching:Play() end
								task.wait(.25)
								v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('Amount').Value) .. ' LEFT!'
							else
								NotifyRemote:FireServer('0 STOCK LEFT!' , 2)
								if not Error.IsPlaying then Error:Play() end
							end
						else
							if not Error.IsPlaying then Error:Play() end
							game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 800418473)
						end
					else
						if not Error.IsPlaying then Error:Play() end
					end
				end)
				v.MouseEnter:Connect(function()
					v.Around.Thickness = 3
					if not Press.IsPlaying then Press:Play() end
				end)
				v.MouseLeave:Connect(function()
					v.Around.Thickness = 2
				end)
			elseif v.Name == 'C4' then
				v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value) .. ' LEFT!'
				v.MouseButton1Click:Connect(function()
					if Stored.Money.Value >= Prices[v.Name] then
						if workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value ~= 0 then
							Buy:FireServer(v.Name, Prices[v.Name])
							v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value) .. ' LEFT!'
							if not Kaching.IsPlaying then Kaching:Play() end
							task.wait(.25)
							v:FindFirstChild('Info').Text = tostring(workspace:FindFirstChild('IllegalDealer'):FindFirstChild('CAmount').Value) .. ' LEFT!'
						else
							NotifyRemote:FireServer('0 STOCK LEFT!' , 2)
							if not Error.IsPlaying then Error:Play() end
						end
					else
						if not Error.IsPlaying then Error:Play() end
					end
				end)
				v.MouseEnter:Connect(function()
					v.Around.Thickness = 3
					if not Press.IsPlaying then Press:Play() end
				end)
				v.MouseLeave:Connect(function()
					v.Around.Thickness = 2
				end)
			end
		end
	end
end

script.Parent:FindFirstChild('Frame').Close.MouseButton1Click:Connect(function()
	if not Press.IsPlaying then Press:Play() end
	script.Parent:WaitForChild('Object').Value.Enabled = true
	game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	script.Parent:Destroy()
end)