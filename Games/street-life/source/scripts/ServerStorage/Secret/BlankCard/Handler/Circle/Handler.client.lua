if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character or Player.CharacterAdded:Wait()

local Spin = script.Parent:FindFirstChild('Frame'):FindFirstChild('Spin')
local Hit = script.Parent:FindFirstChild('Frame'):FindFirstChild('Hit')
local Amount = script.Parent:FindFirstChild('Frame'):FindFirstChild('Amount')
local Key = script.Parent:FindFirstChild('Frame'):FindFirstChild('Key')

local First
local Hits = 1
local AmountMissed = 0
local Stopped = true
local GetRandomHit = function(Time)
	task.wait(.1)
	Stopped = false
	Hit.Visible = true
	Spin.Visible = true
	if Time == 1 then
		First = .85 + math.random() * (1.1 - .85)
		Hit.Position = UDim2.new(.05 + math.random() * (.5 - .05), 0, .5, 0)
		Hit.Size = UDim2.new(.05 + math.random() * (.06 - .05), 0, 1, 0)
		return
	elseif Time == 2 then
		First = .65 + math.random() * (.85 - .65)
		Hit.Position = UDim2.new(.05 + math.random() * (.5 - .05), 0, .5, 0)
		Hit.Size = UDim2.new(.04 + math.random() * (.05 - .04), 0, 1, 0)
		return
	elseif Time == 3 then
		First = .65 + math.random() * (.65 - .65)
		Hit.Position = UDim2.new(.05 + math.random() * (.5 - .05), 0, .5, 0)
		Hit.Size = UDim2.new(.05 + math.random() * (.04 - .05), 0, 1, 0)
		return
	end
end
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
if game:FindService('UserInputService').GamepadEnabled then
	Key.Text = 'R2'
elseif game:FindService('UserInputService').KeyboardEnabled then
	Key.Text = 'E'
elseif game:FindService('UserInputService').TouchEnabled then
	Key.Text = 'PRESS'
else
	Key.Text = 'PRESS / E'
end

game:GetService('UserInputService').InputBegan:Connect(function(input, isProcessed)
	if not isProcessed and (input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonR2 or input.UserInputType == Enum.UserInputType.Touch) then
		local gui1_topLeft = Spin.AbsolutePosition
		local gui1_bottomRight = gui1_topLeft + Spin.AbsoluteSize

		local gui2_topLeft = Hit.AbsolutePosition
		local gui2_bottomRight = gui2_topLeft + Hit.AbsoluteSize

		if ((gui1_topLeft.x < gui2_bottomRight.x and gui1_bottomRight.x > gui2_topLeft.x) and (gui1_topLeft.y < gui2_bottomRight.y and gui1_bottomRight.y > gui2_topLeft.y)) and Stopped == false then
			if not script.Press.IsPlaying then script.Press:Play() end
			if Hits ~= 3 then
				Amount.Text = Hits .. '/3'
				Amount.TextColor3 = Color3.fromRGB(0, 255, 0)
				Hits += 1
				Hit.Visible = false
				Spin.Visible = false
				Stopped = true
				task.wait(.5)
				Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
				GetRandomHit(Hits)
			else
				Amount.Text = Hits .. '/3'
				Amount.TextColor3 = Color3.fromRGB(0, 255, 0)
				Hit.Visible = false
				Spin.Visible = false
				Stopped = true
				local TheParent
				if game:FindService('Players').LocalPlayer.Character:FindFirstChild('BlankCard') then
					TheParent = game:FindService('Players').LocalPlayer.Character:FindFirstChild('BlankCard')
				else
					TheParent = Player.Backpack:FindFirstChild('BlankCard')
				end
				game:FindService('ReplicatedStorage'):FindFirstChild('Blank'):FireServer(TheParent, 'Test', true)
				task.wait(.1)
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				script.Parent:Destroy()
			end
		elseif Stopped == false then
			if not script.ERROR.IsPlaying and not script.Press.IsPlaying then script.ERROR:Play() end
			AmountMissed += 1
			Amount.Text = '0/3'
			Amount.TextColor3 = Color3.fromRGB(255, 0, 0)
			Hits = 1
			Hit.Visible = false
			Spin.Visible = false
			Stopped = true
			if AmountMissed ~= 10 then
				task.wait(.5)
				Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
				GetRandomHit(Hits)
			else
				task.wait(.15)
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
				if game:FindService('Players').LocalPlayer.Character:FindFirstChild('BlankCard') then
					game:FindService('Players').LocalPlayer.Character:FindFirstChild('BlankCard'):Destroy()
				else
					Player.Backpack:FindFirstChild('BlankCard'):Destroy()
				end
				script.Parent:Destroy()
			end
		end
	end
end)

GetRandomHit(Hits)
while task.wait() do
	if Stopped == false then
		Spin:TweenPosition(UDim2.new(.975, 0, 0.5, 0),
			Enum.EasingDirection.InOut,
			Enum.EasingStyle.Linear,
			First,
			true
		)
		task.wait(First)
		if Stopped == false then
			Spin:TweenPosition(UDim2.new(.025, 0, 0.5, 0),
				Enum.EasingDirection.InOut,
				Enum.EasingStyle.Linear,
				First,
				true
			)
			task.wait(First)
		end
	end
end