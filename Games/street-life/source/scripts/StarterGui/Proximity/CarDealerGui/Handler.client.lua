if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Level, XP = Stored:WaitForChild('Level'), Stored:WaitForChild('XP')
local PlayerGui = Player:FindFirstChild('PlayerGui')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid, HumanoidRootPart = Character:WaitForChild('Humanoid'), Character:WaitForChild('HumanoidRootPart')

local Kaching, Error, Press = script:FindFirstChild('Kaching'), script:FindFirstChild('Error'), script:FindFirstChild('Press')
local Cars = game:FindService('ReplicatedStorage').Cars
local Interact = script.Parent:WaitForChild('Interact')
local Close = script.Parent.Close
local Purchase, Price, Car, Rating = Interact:FindFirstChild('Purchase'), Interact:FindFirstChild('Price'), Interact:FindFirstChild('Car'), Interact:FindFirstChild('Rating')

local GetCarInfo = game:FindService('ReplicatedStorage').GetCarInfo

local Ratings = {
	['Scooter'] = '★☆☆☆☆',
	['Sedan']  = '★★☆☆☆',
	['RS3']  = '★★★☆☆',
	['GLE53'] = '★★★★☆',
	['DirtBike'] = '★★★☆☆',
	['Hellcat'] = '★★★★☆',
	['RS6'] = '★★★★☆',
	['CLS'] = '★★★★☆',
	['M2'] = '★★★★★',
	['Urus'] = '★★★★★',
	['RollsRoyce'] = '★★★☆☆',
	['Trackhawk'] = '★★★★★'
}

local Premium = {
	'M2',
	'Urus'
}

local CurrentlyShowing = nil
local Cooldown = false

ShowCar = function(Name)
	local Extra = Vector3.new(0, 1.6 ,0)

	if Name == 'Scooter' then
		Extra = Vector3.new(0, 1.75 ,0)
	elseif Name == 'Hellcat' then
		Vector3.new(0, 1.5 ,0)
	elseif Name == 'DirtBike' then
		Extra = Vector3.new(0, 3 ,0)
	end

	if Cars:FindFirstChild(Name) then
		local CarInfo = GetCarInfo:InvokeServer(Name)
		if CarInfo == true then
			Purchase.Text = 'SPAWN'
		else
			Purchase.Text = 'PURCHASE'
		end
		workspace.Garage.CarPosition:ClearAllChildren()
		local Clone = Cars:FindFirstChild(Name):Clone()
		Clone.Parent = workspace.Garage.CarPosition
		Clone:SetPrimaryPartCFrame(workspace.Garage.CarPosition.CFrame + Extra)
		if not Interact.Visible then Interact.Visible = true end
		Car.Text = Name
		Price.Text = '$' .. Cars[Name]:FindFirstChild('Price').Value
		Rating.Text = 'Rating: ' .. Ratings[Name]
		CurrentlyShowing = Name
		if table.find(Premium, CurrentlyShowing) then
			Rating.TextColor3 = Color3.fromRGB(255, 255, 0)
		else
			Rating.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end
end

workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
workspace.CurrentCamera.CFrame = workspace.Garage.Camera.CFrame

local WasOn = false
if Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled then
	Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = false
	WasOn = true
end

Player.PlayerGui:FindFirstChild('RStore').Enabled = false
Player.PlayerGui:FindFirstChild('Gang').Enabled = false

for _,v in ipairs(Cars:GetChildren()) do
	if v:IsA('Model') then
		local Clone = script.Parent.ButtonClone:Clone()
		Clone.Parent = script.Parent.List
		Clone.Text = v.Name
		Clone.Name = v.Name
		if table.find(Premium, Clone.Text) then
			Clone.TextColor3 = Color3.fromRGB(255, 255, 0)
			Clone.Around.Color = Color3.fromRGB(255, 255, 0)
		end
		local CarInfo = GetCarInfo:InvokeServer(Clone.Text)
		if CarInfo == false then
			Clone.Price.Text = '$' .. v:FindFirstChild('Price').Value
			if Stored.Money.Value >= v:FindFirstChild('Price').Value then
				Clone.Price.TextColor3 = Color3.fromRGB(0, 255, 0)
			else
				Clone.Price.TextColor3 = Color3.fromRGB(255, 0, 0)
			end
		elseif CarInfo == true then
			Clone.Price.Text = 'OWNED'
			Clone.Price.TextColor3 = Color3.fromRGB(0, 255, 0)
		end
		Clone.Visible = true
		Clone.MouseButton1Click:Connect(function()
			if CurrentlyShowing ~= Clone.Text then
				if not script.Press.IsPlaying then script.Press:Play() end
				ShowCar(Clone.Text)
				if table.find(Premium, CurrentlyShowing) then
					if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
						script.Parent.Premium.Visible = true
						return
					end
				else
					script.Parent.Premium.Visible = false
				end
				if Cars:FindFirstChild(Clone.Text):FindFirstChild('Level') then
					local LevelNeeded = Cars:FindFirstChild(Clone.Text):FindFirstChild('Level').Value
					if Level.Value >= LevelNeeded then
						script.Parent.Level.Visible = false
					else
						script.Parent.Level.Text = 'LEVEL ' .. LevelNeeded .. ' NEEDED'
						script.Parent.Level.Visible = true
						return
					end
				else
					script.Parent.Level.Visible = false
				end
			end
		end)
	end
end

Purchase.MouseButton1Click:Connect(function()
	if CurrentlyShowing ~= nil then
		if Cars:FindFirstChild(CurrentlyShowing) then
			if Cooldown == true then task.wait(.5) end
			local CarInfo = GetCarInfo:InvokeServer(CurrentlyShowing)
			if CarInfo == true then
				if table.find(Premium, CurrentlyShowing) then
					if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
						game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 834486805)
						if not Error.IsPlaying then Error:Play() end
						return
					end
				end
				if Cars:FindFirstChild(CurrentlyShowing):FindFirstChild('Level') then
					local LevelNeeded = Cars:FindFirstChild(CurrentlyShowing):FindFirstChild('Level').Value
					if Level.Value >= LevelNeeded then
						script.Parent.Level.Visible = false
					else
						if not Error.IsPlaying then Error:Play() end
						return
					end
				end
				game:FindService('ReplicatedStorage').CarHandler:FireServer('Spawn', CurrentlyShowing)
				workspace.CurrentCamera.CameraType = Enum.CameraType.Track
				workspace.CurrentCamera.CFrame = HumanoidRootPart.CFrame
				script.Parent.Enabled = false
				task.spawn(function()
					if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
					local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
					Adder.Parent = Player.PlayerGui
					Adder.Amount.Text = 'SPAWNED ' .. string.upper(CurrentlyShowing)
					Adder.Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
					task.wait(2)
					for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
					Adder:Destroy()
				end)
				if Player.Character:FindFirstChild('ArrowHandler') then Player.Character:FindFirstChild('ArrowHandler'):Destroy() end
				if Player.Character:FindFirstChild('Arrow') then Player.Character:FindFirstChild('Arrow'):Destroy() end
				task.wait(.5)
				local Clone = script:FindFirstChild('ArrowHandler'):Clone()
				Clone.Parent = Player.Character
				Clone.Target.Value = workspace.CivCars:WaitForChild(Player.Name .. "'s Car"):WaitForChild('DriveSeat')
				Clone.Enabled = true
				task.wait(3)
				if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
				if WasOn == true then Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = true end
				Player.PlayerGui:FindFirstChild('RStore').Enabled = true
				Player.PlayerGui:FindFirstChild('Gang').Enabled = true
				workspace.Garage.CarPosition:ClearAllChildren()
				CurrentlyShowing = nil
				script.Parent:Destroy()
			else
				if Cooldown == true then return end
				Cooldown = true
				if table.find(Premium, CurrentlyShowing) then
					if not game:FindFirstChild('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 834486805) then
						game:FindFirstChild('MarketplaceService'):PromptGamePassPurchase(Player, 834486805)
						if not Error.IsPlaying then Error:Play() end
						return
					end
				end
				if Stored.Money.Value >= Cars[CurrentlyShowing]:FindFirstChild('Price').Value then
					game:FindService('ReplicatedStorage').CarHandler:FireServer('Buy', CurrentlyShowing)
					Purchase.Text = 'SPAWN'
					script.Parent.List[CurrentlyShowing].Price.Text = 'OWNED'
					script.Parent.List[CurrentlyShowing].Price.TextColor3 = Color3.fromRGB(0, 255, 0)
				else
					if not script.Error.IsPlaying then script.Error:Play() end
				end
				if WasOn == true then Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = true end
				Player.PlayerGui:FindFirstChild('RStore').Enabled = true
				Player.PlayerGui:FindFirstChild('Gang').Enabled = true
				task.wait(2)
				Cooldown = false
				
			end
		end
	end
end)

Close.MouseButton1Click:Connect(function()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Track
	workspace.CurrentCamera.CFrame = HumanoidRootPart.CFrame
	if PlayerGui:FindFirstChild('Adder') then PlayerGui:FindFirstChild('Adder'):Destroy() end
	if WasOn == true then Player.PlayerGui:FindFirstChild('ShiftLockButton').Enabled = true end
	Player.PlayerGui:FindFirstChild('RStore').Enabled = true
	Player.PlayerGui:FindFirstChild('Gang').Enabled = true
	workspace.Garage.CarPosition:ClearAllChildren()
	CurrentlyShowing = nil
	script.Parent:Destroy()
end)