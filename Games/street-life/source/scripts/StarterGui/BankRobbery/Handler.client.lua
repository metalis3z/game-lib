if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local BankTimeLeft = game:FindService('ReplicatedStorage'):WaitForChild('BankTimeLeft')
local Character = Player.Character or Player.CharacterAdded:Wait() 
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
local BankTotal = Character:WaitForChild('BankTotal')
local InsideVault = Character:WaitForChild('InsideVault')

local BagFrame = script.Parent:FindFirstChild('Frame')

local MaxAmount = 5
if game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 815682937) then
	MaxAmount = 10
end

script.Parent.TextLabel.Text = ''
BankTimeLeft:GetPropertyChangedSignal('Value'):Connect(function()
	script.Parent.TextLabel.Text = BankTimeLeft.Value .. ' SECONDS LEFT'
	if InsideVault.Value == true then
		script.Parent.TextLabel.Visible = true
	end
	if BankTimeLeft.Value == 0 then
		if InsideVault.Value == true then
			script.Parent.TextLabel.Visible = false
			BagFrame.Visible = false
			script.Parent.Enabled = false
			if Player.Character:FindFirstChild('ArrowHandler') then Player.Character:FindFirstChild('ArrowHandler'):Destroy() end
			if Player.Character:FindFirstChild('Arrow') then Player.Character:FindFirstChild('Arrow'):Destroy() end
			game:FindService('ReplicatedStorage'):FindFirstChild('C4'):FireServer('ABC', 3)
			HumanoidRootPart.Anchored = true
			HumanoidRootPart.CFrame = workspace:FindFirstChild('Teleports'):FindFirstChild('Vault').CFrame
			InsideVault.Value = false
			task.wait(.5)
			HumanoidRootPart.Anchored = false
		else
			script.Parent.TextLabel.Visible = false
			BagFrame.Visible = false
			script.Parent.Enabled = false
		end
	end 
end)

BagFrame:FindFirstChild('TextButton').MouseButton1Click:Connect(function()
	game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 815682937)
end)

BankTotal:GetPropertyChangedSignal('Value'):Connect(function()
	if BankTotal.Value == 0 then
		BagFrame.Visible = false
		return
	else
		BagFrame:FindFirstChild('Filler'):FindFirstChild('Inside').Visible = true
		BagFrame:FindFirstChild('Filler'):FindFirstChild('TextLabel').Text = tostring(BankTotal.Value) .. '/' .. tostring(MaxAmount)
		BagFrame:FindFirstChild('Filler'):FindFirstChild('Inside').Size = UDim2.new(BankTotal.Value * .1, 0, 1, 0)
		BagFrame.Visible = true
	end
end)