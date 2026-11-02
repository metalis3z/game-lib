if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart', true)

local Stored = Player:WaitForChild('stored')
local Info, Interact, Misc = script.Parent:FindFirstChild('Info'), script.Parent:FindFirstChild('Interact'), script.Parent:FindFirstChild('Misc')
local FirstWithdraw, FirstDeposit = Interact.Withdraw, Interact.Deposit
local Withdraw, Deposit = Interact.FrameWithdraw.Withdraw, Interact.FrameDeposit.Deposit

local Remote = game:FindService('ReplicatedStorage').ATM

script.Parent.User.Text = Player.Name
script.Parent.Balance.Text = 'Account Balance $' .. Stored:FindFirstChild('Bank').Value

spawn(function()
	task.wait(2)
	while task.wait(.5) do
		if HumanoidRootPart then
			if (HumanoidRootPart.Position - (Misc:WaitForChild('Part').Value).Position).Magnitude >= 12.5 then
				Misc:WaitForChild('Part').Value:FindFirstChild('ATM').Enabled = true
				script.Parent.Parent:Destroy()
			end
		else
			Misc:WaitForChild('Part').Value:FindFirstChild('ATM').Enabled = true
			script.Parent.Parent:Destroy()
		end
	end
end)

Misc:WaitForChild('Part').Value:FindFirstChild('ATM').Enabled = false

script.Parent.Close.MouseButton1Click:Connect(function()
	Misc:FindFirstChild('Click'):Play() task.wait(.1)
	Misc:WaitForChild('Part').Value:FindFirstChild('ATM').Enabled = true
	script.Parent.Parent:Destroy()
end)

FirstWithdraw.MouseButton1Click:Connect(function()
	Misc:FindFirstChild('Click'):Play() task.wait(.1)	
	FirstWithdraw.Visible = false
	FirstDeposit.Visible = false
	Withdraw.Parent.Visible = true
end)

FirstDeposit.MouseButton1Click:Connect(function()
	Misc:FindFirstChild('Click'):Play() task.wait(.1)
	FirstWithdraw.Visible = false
	FirstDeposit.Visible = false
	Deposit.Parent.Visible = true
end)

local Cooldown = false
Deposit.MouseButton1Click:Connect(function()
	if Cooldown or Deposit.Parent.Amount.Text == '' or tonumber(Deposit.Parent.Amount.Text) == nil then return end
	Cooldown = true
	local Amount = tonumber(math.floor(Deposit.Parent.Amount.Text))

	if Stored.Money.Value >= Amount and Amount > 0 and Amount and Stored.Bank.Value + Amount <= 3000000 then
		if Amount > 100000 then
			script.Parent.Output.Text = 'Max 100K!'
			Misc.Error:Play()
			return
		end 
		
		if Stored.Bank.Value + Amount >= 3000000 then
			script.Parent.Output.Text = 'Max 3M in your bank!'
			Misc.Error:Play()
			return
		end
		script.Parent.Output.Text = 'Succesfully deposited $' .. Amount
		Remote:FireServer('Deposit', Amount)
		Misc.Approved:Play()
		Deposit.Parent.Amount.Text = ''
		task.wait(.2)
		script.Parent.Balance.Text = 'Account Balance $' .. Stored:FindFirstChild('Bank').Value
	else
		script.Parent.Output.Text = 'Failed to deposit amount'
		Misc.Error:Play()
	end
	
	task.wait(1.5)
	Cooldown = false
	script.Parent.Output.Text = ''
end)

Deposit.Parent.Return.MouseButton1Click:Connect(function()
	Misc:FindFirstChild('Click'):Play() task.wait(.1)
	Deposit.Parent.Visible = false
	Deposit.Parent.Amount.Text = ''
	FirstDeposit.Visible = true
	FirstWithdraw.Visible = true
end)

Withdraw.Parent.Return.MouseButton1Click:Connect(function()
	Misc:FindFirstChild('Click'):Play() task.wait(.1)
	Withdraw.Parent.Visible = false
	Withdraw.Parent.Amount.Text = ''
	FirstDeposit.Visible = true
	FirstWithdraw.Visible = true
end)

Withdraw.MouseButton1Click:Connect(function()
	if Cooldown or Withdraw.Parent.Amount.Text == '' or tonumber(Withdraw.Parent.Amount.Text) == nil then return end
	Cooldown = true
	local Amount = tonumber(math.floor(Withdraw.Parent.Amount.Text))

	if Stored.Bank.Value >= Amount and Amount > 0 and Amount then
		if Amount > 100000 then
			script.Parent.Output.Text = 'Max 100K!'
			Misc.Error:Play()
			return
		end
		if Stored.Money.Value + Amount >= 2000000 then
			script.Parent.Output.Text = 'Max 2M in your wallet!'
			Misc.Error:Play()
			return
		end
		script.Parent.Output.Text = 'Succesfully withdrew $' .. Amount
		Remote:FireServer('Withdraw', Amount)
		Misc.Approved:Play()
		Withdraw.Parent.Amount.Text = ''
		task.wait(.2)
		script.Parent.Balance.Text = 'Account Balance $' .. Stored:FindFirstChild('Bank').Value
	else
		script.Parent.Output.Text = 'Failed to withdraw amount'
		Misc.Error:Play()
	end	
	
	task.wait(1.5)
	Cooldown = false
	script.Parent.Output.Text = ''
end)

Stored:FindFirstChild('Bank'):GetPropertyChangedSignal('Value'):Connect(function()
	script.Parent.Balance.Text = 'Account Balance $' .. Stored:FindFirstChild('Bank').Value
end)