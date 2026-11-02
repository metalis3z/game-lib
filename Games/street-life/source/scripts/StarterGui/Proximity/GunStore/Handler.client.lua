if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Level, XP = Stored:WaitForChild('Level'), Stored:WaitForChild('XP')
local PlayerGui = Player:FindFirstChild('PlayerGui')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid, HumanoidRootPart = Character:WaitForChild('Humanoid'), Character:WaitForChild('HumanoidRootPart')

local GBuy = game:FindService('ReplicatedStorage'):FindFirstChild('GBuy')
local Kaching, Error, Press = script:FindFirstChild('Kaching'), script:FindFirstChild('Error'), script:FindFirstChild('Press')

local function Tween(WhatToMove, WhereTo)
	local Tween2 = { 
		CFrame = WhereTo.CFrame 
	}
	local MovePart = game:FindService('TweenService'):Create(WhatToMove, TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false, 0), Tween2)
	MovePart:Play()
end

function TweenCamera(CFrame1)
	local Tween = game:GetService('TweenService'):Create(workspace.CurrentCamera, TweenInfo.new(.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out,0,false,0), {CFrame = CFrame1})
	Tween:Play()
end

local CurrentlyTouching = nil

workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
CurrentlyTouching = script.Parent.Wall.Value['1'].WeldPart
TweenCamera(CurrentlyTouching.Parent:FindFirstChild('CamPart').CFrame)
Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos2'))
task.wait(.1)
if CurrentlyTouching:FindFirstChild('Info') then
	CurrentlyTouching.Info.Enabled = true
end

local WasOn = false
if Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled then
	Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = false
	WasOn = true
end
Player.PlayerGui:FindFirstChild('RStore').Enabled = false
Player.PlayerGui:FindFirstChild('Gang').Enabled = false

for _,v in ipairs(script.Parent.Wall.Value:GetDescendants()) do
	if v:IsA('BillboardGui') then
		if v.Name == 'Info' then
			local Tool = v.Parent.Parent
			if Tool.Tool.Value  ~= 'StabVest' then
				local Price, Damage, FireRate, Capacity, Accuracy = Tool.Price, Tool.Damage, Tool.FireRate, Tool.Capacity, Tool.Accuracy

				v.Frame.DamageBar.Bar.Size = UDim2.new(Damage.Value * .01, 0, 1, 0)
				v.Frame.FireRateBar.Bar.Size = UDim2.new(FireRate.Value * .01, 0, 1, 0)
				v.Frame.CapacityBar.Bar.Size = UDim2.new(Capacity.Value * .01, 0, 1, 0)
				v.Frame.AccuracyBar.Bar.Size = UDim2.new(Accuracy.Value * .01, 0, 1, 0)
				v.Frame.Price.Text = '$' .. Price.Value
				v.Frame.Tool.Text = Tool.Tool.Value
			else
				v.Frame.Price.Text = '$' .. Tool.Price.Value
				v.Frame.Tool.Text = Tool.Tool.Value
			end 
		elseif v.Name == 'GunInfo' then
			v.Tool.Text = v.Parent.Parent.Tool.Value
			if v:FindFirstChild('Price') then
				v.Price.Text = '$' .. v.Parent.Parent.Price.Value
			end
			if v.Parent.Parent.Name ~= '1' then
				v.Enabled = true
			end
			if not v.Parent.Parent:FindFirstChild('Damage') and v.Parent.Parent.Name == '1' then
				v.Enabled = true
			elseif not v.Parent.Parent:FindFirstChild('Damage') and v.Parent.Parent.Name ~= '1' then
				v.Enabled = false
			end
		end
	end
end

script.Parent.Back.MouseButton1Click:Connect(function()
	Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos1'))
	if CurrentlyTouching:FindFirstChild('Info') then
		CurrentlyTouching:FindFirstChild('Info').Enabled = false
	end
	script.Parent.Purchase.Visible = false
	script.Parent.GFront.Visible = false
	script.Parent.GBack.Visible = false
	script.Parent.Back.Visible = false
	CurrentlyTouching = nil
	TweenCamera(Character:FindFirstChild('Head').CFrame)
	for _,v in ipairs(script.Parent.Wall.Value:GetDescendants()) do if v:IsA('BillboardGui') then v.Enabled = false end end
	task.wait(.2)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Track
	if PlayerGui:FindFirstChild('Adder') then PlayerGui:FindFirstChild('Adder'):Destroy() end
	if WasOn == true then Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = true end
	Player.PlayerGui:FindFirstChild('RStore').Enabled = true
	Player.PlayerGui:FindFirstChild('Gang').Enabled = true
	script.Parent:Destroy()
end)

script.Parent.GFront.MouseButton1Click:Connect(function()
	if CurrentlyTouching ~= nil then
		local Current = tonumber(CurrentlyTouching.Parent.Name)
		local NewCurrent = CurrentlyTouching.Parent.Parent:FindFirstChild(tostring(Current + 1))
		if Current and NewCurrent then
			CurrentlyTouching:FindFirstChild('GunInfo').Enabled = true
			if CurrentlyTouching:FindFirstChild('Info') then
				CurrentlyTouching:FindFirstChild('Info').Enabled = false
			else
				CurrentlyTouching:FindFirstChild('GunInfo').Enabled = false
			end
			Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos1'))

			CurrentlyTouching = NewCurrent:FindFirstChild('WeldPart')
			if CurrentlyTouching.Parent.Name == '15' or CurrentlyTouching.Parent.Name == '16' or CurrentlyTouching.Parent.Name == '17' or CurrentlyTouching.Parent.Name == '18' then
				if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
					script.Parent.Premium.Visible = true
				end
			else
				script.Parent.Premium.Visible = false
			end
			if CurrentlyTouching.Parent:FindFirstChild('Level') then
				local LevelNeeded = CurrentlyTouching.Parent:FindFirstChild('Level').Value
				if Level.Value >= LevelNeeded then
					script.Parent.Level.Visible = false
				else
					script.Parent.Level.Text = 'LEVEL ' .. LevelNeeded .. ' NEEDED'
					script.Parent.Level.Visible = true
				end
			else
				script.Parent.Level.Visible = false
			end
			CurrentlyTouching:FindFirstChild('GunInfo').Enabled = false
			if CurrentlyTouching:FindFirstChild('Info') then
				CurrentlyTouching:FindFirstChild('Info').Enabled = true
			else
				CurrentlyTouching:FindFirstChild('GunInfo').Enabled = true
			end
			TweenCamera(CurrentlyTouching.Parent:FindFirstChild('CamPart').CFrame)
			Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos2'))
		end
	end
end)

script.Parent.GBack.MouseButton1Click:Connect(function()
	if CurrentlyTouching ~= nil then
		local Current = tonumber(CurrentlyTouching.Parent.Name)
		local NewCurrent = CurrentlyTouching.Parent.Parent:FindFirstChild(tostring(Current - 1))
		if Current and NewCurrent then
			CurrentlyTouching:FindFirstChild('GunInfo').Enabled = true
			if CurrentlyTouching:FindFirstChild('Info') then
				CurrentlyTouching:FindFirstChild('Info').Enabled = false
			else
				CurrentlyTouching:FindFirstChild('GunInfo').Enabled = false
			end
			Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos1'))

			CurrentlyTouching = NewCurrent:FindFirstChild('WeldPart')
			if CurrentlyTouching.Parent.Name == '15' or CurrentlyTouching.Parent.Name == '16' or CurrentlyTouching.Parent.Name == '17' or CurrentlyTouching.Parent.Name == '18' then
				if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
					script.Parent.Premium.Visible = true
				end
			else
				script.Parent.Premium.Visible = false
			end
			if CurrentlyTouching.Parent:FindFirstChild('Level') then
				local LevelNeeded = CurrentlyTouching.Parent:FindFirstChild('Level').Value
				if Level.Value >= LevelNeeded then
					script.Parent.Level.Visible = false
				else
					script.Parent.Level.Text = 'LEVEL ' .. LevelNeeded .. ' NEEDED'
					script.Parent.Level.Visible = true
				end
			else
				script.Parent.Level.Visible = false
			end
			CurrentlyTouching:FindFirstChild('GunInfo').Enabled = false
			if CurrentlyTouching:FindFirstChild('Info') then
				CurrentlyTouching:FindFirstChild('Info').Enabled = true
			else
				CurrentlyTouching:FindFirstChild('GunInfo').Enabled = true
			end
			TweenCamera(CurrentlyTouching.Parent:FindFirstChild('CamPart').CFrame)
			Tween(CurrentlyTouching, CurrentlyTouching.Parent:FindFirstChild('Pos2'))
		end
	end
end)

script.Parent.Purchase.MouseButton1Click:Connect(function()
	if CurrentlyTouching ~= nil then
		if Stored.Money.Value >= CurrentlyTouching.Parent.Price.Value then
			if (CurrentlyTouching.Parent.Name == '15' or CurrentlyTouching.Parent.Name == '16' or CurrentlyTouching.Parent.Name == '17' or CurrentlyTouching.Parent.Name == '18') and not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
				game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 834486805)
				if not Error.IsPlaying then Error:Play() end
				return
			end
			if CurrentlyTouching.Parent:FindFirstChild('Level') then
				local LevelNeeded = CurrentlyTouching.Parent:FindFirstChild('Level').Value
				if Level.Value >= LevelNeeded then
					script.Parent.Level.Visible = false
				else
					script.Parent.Level.Text = 'LEVEL ' .. LevelNeeded .. ' NEEDED'
					script.Parent.Level.Visible = true
					if not Error.IsPlaying then Error:Play() end
					return
				end
			else
				script.Parent.Level.Visible = false
			end
			GBuy:FireServer(CurrentlyTouching.Parent.Tool.Value, CurrentlyTouching.Parent.Price.Value)
			Kaching:Play()
			if PlayerGui:FindFirstChild('Adder') then PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = '-$' .. tostring(CurrentlyTouching.Parent.Price.Value)
			Adder.Amount.TextColor3 = Color3.fromRGB(255, 0, 4)
			task.wait(2)
			for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
			Adder:Destroy()
		else
			if not Error.IsPlaying then Error:Play() end
		end
	end
end)	

for _,v in next, script.Parent:GetChildren() do
	if v:IsA('TextButton') then
		v.MouseEnter:Connect(function()
			v.UIStroke.Thickness = 3
		end)
		v.MouseLeave:Connect(function()
			v.UIStroke.Thickness = 2
		end)
		if v.Name ~= 'Purchase' then
			v.MouseButton1Click:Connect(function()
				if not Press.IsPlaying then Press:Play() end
			end)
		end
	end
end
