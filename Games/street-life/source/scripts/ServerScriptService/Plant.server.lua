local GrowCooldown = 180
local LeafsEarn = math.random(1750, 2250)

local CGrowCooldown = 360

for _,v in ipairs(workspace:WaitForChild('Plants'):GetChildren()) do
	if v:IsA('Model') and v.Name == 'Plant' and v:FindFirstChild('Leaf') then
		local Leaf = v:FindFirstChild('Leaf')
		Leaf.Size += Vector3.new(2, 2, 2) 
		Leaf.CFrame += Vector3.new(0, 1, 0)
		local Clone = script:FindFirstChild('Interact'):Clone()
		Clone.Parent = Leaf
		Clone.Triggered:Connect(function(Player)
			if not Clone.Enabled then return end
			if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('Humanoid') and not Player.Character:FindFirstChild('Harvesting') then
				if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') then
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = true
				end
				Clone.Enabled = false
				local Checker = Instance.new('BoolValue', Player.Character)
				Checker.Name = 'Harvesting'
				task.spawn(function()
					for _ = 1, 200 do
						Leaf.Size -= Vector3.new(.02, .02, .02)
						Leaf.CFrame -= Vector3.new(0, .01, 0)
						task.wait(.025)
					end
				end)
				local TextLabel = v:FindFirstChild('Part'):WaitForChild('BillboardGui'):WaitForChild('TextLabel')
				TextLabel.Parent.AlwaysOnTop = false
				TextLabel.Visible = true
				local Harvest = Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Harvest'))
				Harvest:Play()
				for _ = 1, 10 do
					if TextLabel.Text == 'Harvesting' then
						TextLabel.Text = 'Harvesting.'
					elseif TextLabel.Text == 'Harvesting.' then
						TextLabel.Text = 'Harvesting..'
					elseif TextLabel.Text == 'Harvesting..' then
						TextLabel.Text = 'Harvesting...'
					elseif TextLabel.Text == 'Harvesting...' then
						TextLabel.Text = 'Harvesting'
					end
					task.wait(.55)
				end
				if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') then
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = false
				end
				TextLabel.Visible = false
				if not Player:FindFirstChild('Harvested') then
					local Harvested = Instance.new('NumberValue', Player)
					Harvested.Name = 'Harvested'
					Harvested.Value = 1
				else
					Player:FindFirstChild('Harvested').Value += 1
				end
				task.wait(1)
				Checker:Destroy()
				task.wait(GrowCooldown - 1)
				for _ = 1, 200 do
					Leaf.Size += Vector3.new(.02, .02, .02)
					Leaf.CFrame += Vector3.new(0, .01, 0)
					task.wait(.025)
				end
				Harvest:Stop()
				task.wait(.5)
				Clone.Enabled = true
			end
		end)
	end
end

for _,v in ipairs(workspace:WaitForChild('Process'):GetChildren()) do
	if v:IsA('Model') and v.Name == 'Table' and v:FindFirstChild('Part') then
		local Clone = script:FindFirstChild('Interact'):Clone()
		Clone.ObjectText = 'Process Plant'
		Clone.Parent = v:FindFirstChild('Part')
		Clone.Triggered:Connect(function(Player)
			if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('Humanoid') then
				if Player:FindFirstChild('Harvested') and Player:FindFirstChild('Harvested').Value >= 10 then
					local AmountLeafs = 0
					for _,v in ipairs(Player.Backpack:GetChildren()) do
						if v.Name == 'Leafs' then
							AmountLeafs += 1
						end
					end
					if AmountLeafs >= 10 then
						game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Max Leaf Bags Reached (10).', 3)
						return
					end
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = true
					Clone.Enabled = false
					local TextLabel = v:FindFirstChild('BillboardGui'):FindFirstChild('TextLabel')
					TextLabel.Text = 'Processing'
					TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					task.spawn(function()
						for _ = 1, 10 do
							if TextLabel.Text == 'Processing' then
								TextLabel.Text = 'Processing.'
							elseif TextLabel.Text == 'Processing.' then
								TextLabel.Text = 'Processing..'
							elseif TextLabel.Text == 'Processing..' then
								TextLabel.Text = 'Processing...'
							elseif TextLabel.Text == 'Processing...' then
								TextLabel.Text = 'Processing'
							end
							task.wait(.3)
						end
					end)
					local Process = Player.Character:FindFirstChild('Humanoid').Animator:LoadAnimation(script:FindFirstChild('Process'))
					Process.Looped = false
					Process:Play()
					Player:FindFirstChild('Harvested').Value -= 10
					task.wait(3.5)
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = false
					TextLabel.Text = ''
					TextLabel.TextColor3 = Color3.fromRGB(0, 81, 12)
					Process:Stop()
					script:FindFirstChild('Leafs'):Clone().Parent = Player.Backpack
					if Player:FindFirstChild('stored') then
						local XPValue = Player:FindFirstChild('stored'):FindFirstChild('XP')
						local LevelValue = Player:FindFirstChild('stored'):FindFirstChild('Level')
						if XPValue.Value + 2 >= 100 then
							if LevelValue.Value >= 200 then
							else
								LevelValue.Value += 1
								XPValue.Value = 0
							end
						else
							XPValue.Value += 2
						end
					end
					task.wait(.5)
					Clone.Enabled = true
					TextLabel.Text = 'PROCESS HERE'
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You need atleast 10 harvested plants to process.', 3)
				end
			end
		end)
	end
end

local SugarStart = function(Player, Clone, v, Amount, UI)
	UI:Destroy()
	if Player and Clone and v and (Amount == 5 or Amount == 15) then
		Player.Character:FindFirstChild('HumanoidRootPart').Anchored = true
		Clone.Enabled = false
		local TextLabel = v:FindFirstChild('BillboardGui'):FindFirstChild('TextLabel')
		TextLabel.Text = 'Processing'
		TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
		task.spawn(function()
			for _ = 1, 10 do
				if TextLabel.Text == 'Processing' then
					TextLabel.Text = 'Processing.'
				elseif TextLabel.Text == 'Processing.' then
					TextLabel.Text = 'Processing..'
				elseif TextLabel.Text == 'Processing..' then
					TextLabel.Text = 'Processing...'
				elseif TextLabel.Text == 'Processing...' then
					TextLabel.Text = 'Processing'
				end
				task.wait(.3)
			end
		end)
		local Process = Player.Character:FindFirstChild('Humanoid').Animator:LoadAnimation(script:FindFirstChild('Process'))
		Process.Looped = false
		Process:Play()
		Process:AdjustSpeed(.5)
		Player:FindFirstChild('CHarvested').Value -= Amount
		task.wait(10)
		Player.Character:FindFirstChild('HumanoidRootPart').Anchored = false
		TextLabel.Text = ''
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		Process:Stop()
		if Amount == 5 then
			script:FindFirstChild('SugarBag'):Clone().Parent = Player.Backpack
		elseif Amount == 15 then
			script:FindFirstChild('LargeSugarBag'):Clone().Parent = Player.Backpack
		end
		if Player:FindFirstChild('stored') then
			local XPValue = Player:FindFirstChild('stored'):FindFirstChild('XP')
			local LevelValue = Player:FindFirstChild('stored'):FindFirstChild('Level')
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
		task.wait(.5)
		Clone.Enabled = true
		TextLabel.Text = 'PROCESS HERE'
	end
end

for _,v in next, workspace:WaitForChild('CPlants'):GetChildren() do
	if v:IsA('Model') and v:FindFirstChild('Fern_OuterLeaves') then
		local Leaf = v:FindFirstChild('Fern_OuterLeaves')
		Leaf.Size += Vector3.new(4, 4, 4) 
		Leaf.CFrame += Vector3.new(0, 1.55, 0)
		local Clone = script:FindFirstChild('Interact'):Clone()
		Clone.Parent = Leaf
		Clone.Triggered:Connect(function(Player)
			if not Clone.Enabled then return end
			if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('Humanoid') and not Player.Character:FindFirstChild('Harvesting') then
				if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') then
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = true
				end
				Clone.Enabled = false
				local Checker = Instance.new('BoolValue', Player.Character)
				Checker.Name = 'Harvesting'
				task.spawn(function()
					for _ = 1, 200 do
						Leaf.Size -= Vector3.new(.02, .02, .02)
						Leaf.CFrame -= Vector3.new(0, .008, 0)
						task.wait(.0425)
					end
				end)
				local TextLabel = v:FindFirstChild('Part'):WaitForChild('BillboardGui'):WaitForChild('TextLabel')
				TextLabel.Parent.AlwaysOnTop = false
				TextLabel.Visible = true
				local Harvest = Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Harvest'))
				Harvest:Play()
				Harvest:AdjustSpeed(.35)
				for _ = 1, 30 do
					if TextLabel.Text == 'Harvesting' then
						TextLabel.Text = 'Harvesting.'
					elseif TextLabel.Text == 'Harvesting.' then
						TextLabel.Text = 'Harvesting..'
					elseif TextLabel.Text == 'Harvesting..' then
						TextLabel.Text = 'Harvesting...'
					elseif TextLabel.Text == 'Harvesting...' then
						TextLabel.Text = 'Harvesting'
					end
					task.wait(.5)
				end
				if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') then
					Player.Character:FindFirstChild('HumanoidRootPart').Anchored = false
				end
				TextLabel.Visible = false
				if not Player:FindFirstChild('CHarvested') then
					local Harvested = Instance.new('NumberValue', Player)
					Harvested.Name = 'CHarvested'
					Harvested.Value = 1
				else
					Player:FindFirstChild('CHarvested').Value += 1
				end
				task.wait(1)
				Checker:Destroy()
				task.wait(CGrowCooldown - 1)
				for _ = 1, 200 do
					Leaf.Size += Vector3.new(.02, .02, .02)
					Leaf.CFrame += Vector3.new(0, .008, 0)
					task.wait(.06)
				end
				Harvest:Stop()
				task.wait(.5)
				Clone.Enabled = true
			end
		end)
	end
end

for _,v in ipairs(workspace:WaitForChild('Sugars'):GetChildren()) do
	if v:IsA('Model') and v.Name == 'Top' and v:FindFirstChild('MainPart') then
		local Clone = script:FindFirstChild('Interact'):Clone()
		Clone.ObjectText = 'Process Sugar'
		Clone.MaxActivationDistance = 7
		Clone.Parent = v:FindFirstChild('MainPart')
		Clone.Triggered:Connect(function(Player)
			if Player.Character and Player.Character:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('Humanoid') then
				if Player:FindFirstChild('CHarvested') and Player:FindFirstChild('CHarvested').Value >= 5 then
					local Question = script:FindFirstChild('SugarQuestion'):Clone()
					Question.Parent = Player.PlayerGui
					Question:FindFirstChildOfClass('Frame'):FindFirstChild('5').MouseButton1Click:Connect(function()
						SugarStart(Player, Clone, Clone.Parent, 5, Question)
					end)
					Question:FindFirstChildOfClass('Frame'):FindFirstChild('15').MouseButton1Click:Connect(function()
						if Player:FindFirstChild('CHarvested').Value >= 15 then
							SugarStart(Player, Clone, Clone.Parent, 15, Question)
						else
							game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You need atleast 15 sugar plants to process.', 5)
						end
					end)
				else
					game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You need atleast 5 sugar plants to process.', 5)
				end
			end
		end)
	end
end

for _,v in ipairs(workspace:GetChildren()) do
	if v.Name == 'ZANPC' then
		if v:FindFirstChild('Humanoid') then
			local NPCANim = v:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Lean'))
			NPCANim:Play()
			local Clone = script:FindFirstChild('Interact'):Clone()
			Clone.Parent = v:FindFirstChild('UpperTorso')
			Clone.ObjectText = 'Sell Leafs ($'.. LeafsEarn .. ')'
			Clone.MaxActivationDistance = 5
			Clone.HoldDuration = .5
			Clone.Triggered:Connect(function(Player)
				if Player.Character and Player.Character:FindFirstChild('Humanoid') and Player:FindFirstChild('stored') then
					if Player.Character:FindFirstChild('Leafs') then
						local Tool = Player.Character:FindFirstChild('Leafs')
						Clone.Enabled = false
						NPCANim:Stop()
						Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						v:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						Player.stored.Money.Value += LeafsEarn
						v:FindFirstChild('Head'):FindFirstChild('Kaching'):Play()
						task.wait(.75)
						Tool.Parent = v
						task.spawn(function()
							if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
							local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
							Adder.Parent = Player.PlayerGui
							Adder.Amount.Text = '+$' .. tostring(LeafsEarn)
							task.wait(.75)
							Tool:Destroy()
							task.wait(1.25)
							for _ = 1, 100 do 
								if Adder and Adder:FindFirstChild('Amount') then 
									Adder.Amount.TextTransparency += .01 
									Adder.Amount.UIStroke.Transparency += .01
									task.wait(.01) 
								end 
							end
							Adder:Destroy()
						end)
						for _,v in ipairs(Player.Character:FindFirstChild('Humanoid').Animator:GetPlayingAnimationTracks()) do v:Stop() end
						task.wait(1)
						NPCANim:Play()
						task.wait(.75)
						Clone.Enabled = true
					elseif Player.Character:FindFirstChild('SugarBag') then
						local Tool = Player.Character:FindFirstChild('SugarBag')
						Clone.Enabled = false
						NPCANim:Stop()
						Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						v:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						Player.stored.Money.Value += 5000
						v:FindFirstChild('Head'):FindFirstChild('Kaching'):Play()
						task.wait(.75)
						Tool.Parent = v
						task.spawn(function()
							if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
							local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
							Adder.Parent = Player.PlayerGui
							Adder.Amount.Text = '+$5000'
							task.wait(.75)
							Tool:Destroy()
							task.wait(1.25)
							for _ = 1, 100 do 
								if Adder and Adder:FindFirstChild('Amount') then 
									Adder.Amount.TextTransparency += .01 
									Adder.Amount.UIStroke.Transparency += .01
									task.wait(.01) 
								end 
							end
							Adder:Destroy()
						end)
						for _,v in ipairs(Player.Character:FindFirstChild('Humanoid').Animator:GetPlayingAnimationTracks()) do v:Stop() end
						task.wait(1)
						NPCANim:Play()
						task.wait(.75)
						Clone.Enabled = true
					elseif Player.Character:FindFirstChild('LargeSugarBag') then
						local Tool = Player.Character:FindFirstChild('LargeSugarBag')
						Clone.Enabled = false
						NPCANim:Stop()
						Player.Character:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						v:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Takes')):Play()
						Player.stored.Money.Value += 20000
						v:FindFirstChild('Head'):FindFirstChild('Kaching'):Play()
						task.wait(.75)
						Tool.Parent = v
						task.spawn(function()
							if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
							local Adder = game:FindService('ReplicatedStorage').Misc.Adder:Clone()
							Adder.Parent = Player.PlayerGui
							Adder.Amount.Text = '+$20000'
							task.wait(.75)
							Tool:Destroy()
							task.wait(1.25)
							for _ = 1, 100 do 
								if Adder and Adder:FindFirstChild('Amount') then 
									Adder.Amount.TextTransparency += .01 
									Adder.Amount.UIStroke.Transparency += .01
									task.wait(.01) 
								end 
							end
							Adder:Destroy()
						end)
						for _,v in ipairs(Player.Character:FindFirstChild('Humanoid').Animator:GetPlayingAnimationTracks()) do v:Stop() end
						task.wait(1)
						NPCANim:Play()
						task.wait(.75)
						Clone.Enabled = true
					end
				end
			end)
		end
	elseif v.Name == 'IllegalDealer' then
		if v:FindFirstChild('Humanoid') then
			local NPCANim = v:FindFirstChild('Humanoid'):LoadAnimation(script:FindFirstChild('Lean'))
			NPCANim:Play()
		end
	end
end