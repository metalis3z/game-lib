local Notify = game:FindService('ReplicatedStorage'):WaitForChild('Notify')
local C4 = game:FindService('ReplicatedStorage'):WaitForChild('C4')
local BankCooldown = game:FindService('ReplicatedStorage'):WaitForChild('BankCooldown')
local BankRobbery = game:FindService('ReplicatedStorage'):WaitForChild('BankRobbery')
local BankTimeLeft = game:FindService('ReplicatedStorage'):WaitForChild('BankTimeLeft')

local ChangeEnabled = function(Argument)
	for _,v in next, workspace:WaitForChild('BankInteractions'):GetChildren() do
		if v:FindFirstChildOfClass('ProximityPrompt') then
			v:FindFirstChildOfClass('ProximityPrompt').Enabled = Argument
			if Argument == true then
				v.Transparency = 0
				for _,v in next, v:GetDescendants() do
					if v:IsA('BasePart') then
						v.Transparency  = 0
					end
				end
			end
		end
	end
end

C4.OnServerEvent:Connect(function(Player, Tool, String, Plant)
	if Player and Tool and String and Plant then
		if Tool.Name == 'C4' and Tool.Parent.Name ~= 'Backpack' then
			if BankCooldown.Value ~= 0 then return end
			if Plant.Name == 'Plant' and Plant:FindFirstChild('Decoy') then
				if Player.PlayerGui:FindFirstChild('Circle') then
					Player.PlayerGui:FindFirstChild('Circle'):Destroy()
				end
				if String == 'COMPLETED' then
					Tool:Destroy()
					Plant:FindFirstChild('ProximityPrompt').Enabled = false
					Plant:FindFirstChild('Decoy').Transparency = 0
					Plant:FindFirstChild('Decoy'):FindFirstChild('Beeping'):Play()
					Plant:FindFirstChild('BillboardGui').Enabled = false
					task.spawn(function()
						for _ = 1, 12 do
							Plant:FindFirstChild('Decoy'):FindFirstChild('Beeping').PlaybackSpeed += .015
							task.wait(.5)
						end
					end)
					task.wait(6)
					ChangeEnabled(true)
					workspace.BANKALARM:FindFirstChildOfClass('Sound'):Play()
					workspace.BANKALARMA:FindFirstChildOfClass('Sound'):Play()
					BankRobbery.Value = true
					BankTimeLeft.Value = 90
					Plant:FindFirstChild('Decoy'):FindFirstChild('Beeping'):Stop()
					Plant:FindFirstChild('Decoy'):FindFirstChild('Beeping').PlaybackSpeed = 1
					Plant:FindFirstChild('Decoy'):FindFirstChild('Explosion'):Play()
					local Explosion = Instance.new('Explosion', Plant:FindFirstChild('Decoy'))
					Explosion.Position = Plant.Position
					Explosion.BlastRadius = 15
					Explosion.BlastPressure = 40
					Explosion.DestroyJointRadiusPercent = 0
					Explosion.ExplosionType = Enum.ExplosionType.NoCraters
					Plant:FindFirstChild('Decoy').Transparency = 1
					for _,v in next, script:FindFirstChild('Object').Value:GetChildren() do
						if v:IsA('BasePart') then
							v.Transparency = 1
							v.CanQuery = false
							v.CanTouch = false
							v.CanCollide = false
						end
					end
					repeat task.wait(1) until BankTimeLeft.Value == 0
					workspace.BANKALARM:FindFirstChildOfClass('Sound'):Stop()
					workspace.BANKALARMA:FindFirstChildOfClass('Sound'):Stop()
					for _,v in next, script:FindFirstChild('Object').Value:GetChildren() do
						if v:IsA('BasePart') then
							v.Transparency = 0
							v.CanQuery = true
							v.CanTouch = true
							v.CanCollide = true
						end
					end
					ChangeEnabled(false)
					BankCooldown.Value = 600
					BankRobbery.Value = false
					Explosion:Destroy()
				end
			elseif String == 'FAILED' then
				Plant:FindFirstChild('BillboardGui'):FindFirstChild('TextLabel').Text = 'FAILED!'
				task.wait(2)
				Plant:FindFirstChild('BillboardGui').Enabled = false
				Plant:FindFirstChild('BillboardGui'):FindFirstChild('TextLabel').Text = 'PLANTING...'
				Plant:FindFirstChild('ProximityPrompt').Enabled = true
			end
		else
			Notify:FireClient(Player, 'EQUIP THE C4', 2)
		end
	else
		if Tool == 'ABC' and String == 3 then
			Player.Character:FindFirstChild('BankTotal').Value = 0
			if Player.Character:FindFirstChild('DuffelBag') then
				Player.Character:FindFirstChild('DuffelBag'):Destroy()
			end
		end 
	end
end)

for _,v in next, workspace:WaitForChild('BankInteractions'):GetChildren() do
	local Taken = Instance.new('BoolValue', v)
	Taken.Name = 'Taken'
	Taken.Value = false
	local Clone = script:FindFirstChild('ProximityPrompt'):Clone()
	Clone.Parent = v
	Clone.Enabled = false
	Clone.Triggered:Connect(function(Player)
		if Player and Player.Character and Player:FindFirstChild('Extra') then
			local BankTotal = Player.Character:FindFirstChild('BankTotal')
			if BankRobbery.Value == true and BankCooldown.Value == 0 and not Taken.Value then
				if BankTotal.Value >= 10 then return end
				if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 815682937) and BankTotal.Value >= 5 then
					game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 815682937)
					return
				end
				if not Player.Character:FindFirstChild('DuffelBag') then
					script:FindFirstChild('DuffelBag'):Clone().Parent = Player.Character
				end
				v.Transparency = 1
				for _,v in next, v:GetDescendants() do
					if v:IsA('BasePart') then
						v.Transparency  = 1
					end
				end
				Clone.Enabled = false
				BankTotal.Value += 1
			else
				Clone.Enabled = false
			end
		end
	end)
end

while task.wait(1) do
	if BankCooldown.Value > 0 then
		BankCooldown.Value -= 1
	end
	if BankTimeLeft.Value > 0 then
		BankTimeLeft.Value -= 1
	end
end