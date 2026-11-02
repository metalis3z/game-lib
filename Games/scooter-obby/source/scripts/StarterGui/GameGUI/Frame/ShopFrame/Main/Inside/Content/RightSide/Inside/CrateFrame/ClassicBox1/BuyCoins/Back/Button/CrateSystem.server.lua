local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local runs = game:GetService("RunService")
local camera = workspace.CurrentCamera
local isRunning = false
player:WaitForChild("PlayerGui"):WaitForChild("Confirmation", 60)
local confirmation = player.PlayerGui.Confirmation

script.Parent.Activated:Connect(function()
	if script:FindFirstChild("Debounce") then
		return
	end
	if player.PlayerGui.NewScooter.Black.BackgroundTransparency == 1 then
		confirmation.Enabled = true
		confirmation.BoxConfirmation.Main.Inside.Content.Label.Text = "Are you sure you want to purchase Skin Box #1?"
		confirmation.Decision.Value = ""
		local decisionMade = false
		confirmation.Decision.Changed:Connect(function()
			decisionMade = true
		end)
		repeat
			wait(0.01)
		until decisionMade
		local debounce = Instance.new("BoolValue", script)
		debounce.Name = "Debounce"
		game:GetService("Debris"):AddItem(debounce, 1)
		if confirmation.Decision.Value == "Yes" then
			confirmation.Enabled = false
			if #workspace.Boxes:GetChildren() == 0 then
				isRunning = false
			end
			if player:WaitForChild("leaderstats").Coins.Value >= 3000 and not isRunning then
				player.PlayerGui.GameGUI.Enabled = false
				rs.RemoteEvents.crateRequest:FireServer()
				game:GetService("Debris"):AddItem()
			end
		else
			confirmation.Enabled = false
		end
	end
end)

local UserInputService = game:GetService("UserInputService")
local lastInteractionTime = 0
local cooldownTime = 1 -- 1 second cooldown

rs.RemoteEvents.crateRequest.OnClientEvent:Connect(function(item, rarity, duplicate, typeOfItem)
	if isRunning then
		repeat
			wait(0.05)
		until not isRunning
	end
	if typeOfItem == "UGC" then
		if isRunning == false then
			isRunning = true
			local currentTime = tick()

			if currentTime - lastInteractionTime >= cooldownTime then
				lastInteractionTime = currentTime

				player.PlayerGui.GameGUI.Enabled = false
				local box = rs.BoxParts.BoxAnim:Clone()
				box.Sound:Play()
				for i, v in pairs(workspace.Boxes:GetChildren()) do
					v:Destroy()
				end
				box.Parent = workspace.Boxes
				local animation = box.AnimationController:LoadAnimation(box.Open)
				animation.Looped = false
				animation:Play()

				runs:BindToRenderStep("openingBind", 1, function()
					if not box then
						return
					end
					box:PivotTo(camera.CFrame - (camera.CFrame.LookVector * 15))
					if not box:FindFirstChild("Model") then
						return
					else
						box.Model.Beam2.light.Transparency = NumberSequence.new(box.Model.Beam2.light.TransparencyValue.Value)
					end
				end)

				wait(0.5)

				local colorSequences = {
					Common = ColorSequence.new(Color3.new(1, 1, 1)),
					Uncommon = ColorSequence.new(Color3.new(0, 1, 0)),
					Rare = ColorSequence.new(Color3.new(0, 0.34902, 1)),
					Epic = ColorSequence.new(Color3.new(0.615686, 0, 1)),
					Legendary = ColorSequence.new(Color3.new(1, 0.835294, 0)),
					UGC = ColorSequence.new(Color3.new(1, 0, 0)),
				}

				if box:FindFirstChild("Model") then
					box.Model.Beam2.light.Color = ColorSequence.new(Color3.new(1, 0, 0))
				end
				player.PlayerGui.Color.Frame.BackgroundTransparency = 1
				player.PlayerGui.Color.Frame.BackgroundColor3 = Color3.new(1,0,0)

				local tweenInfo = TweenInfo.new(0.6)
				if not box:FindFirstChild("Model") then
					return
				end
				local tween = game.TweenService:Create(box.Model.Beam2.light.TransparencyValue, tweenInfo, {Value = 0}):Play()
				wait(0.5)

				local tween2 = game.TweenService:Create(player.PlayerGui.Color.Frame, tweenInfo, {BackgroundTransparency = 0}):Play()
				wait(0.6)

				player.PlayerGui.GameGUI.Enabled = true
				player.PlayerGui.NewUGC.Enabled = true
				player.PlayerGui.NewUGC.Frame.Frame.Duplicate.Visible = duplicate
				player.PlayerGui.NewUGC.Frame.Frame.Duplicate.TextTransparency = 0
				player.PlayerGui.NewUGC.Frame.Frame.Duplicate.UIStroke.Transparency = 0
				player.PlayerGui.NewUGC.Black.BackgroundTransparency = 0.65
				player.PlayerGui.NewUGC.Frame.BackgroundTransparency = 1
				player.PlayerGui.NewUGC.Frame.Frame.BackgroundTransparency = .45
				player.PlayerGui.NewUGC.Frame.Frame.NameLabel.TextTransparency = 0
				player.PlayerGui.NewUGC.Frame.Frame.NameLabel.UIStroke.Transparency = 0
				player.PlayerGui.NewUGC.Frame.Frame.Rarity.TextTransparency = 0
				player.PlayerGui.NewUGC.Frame.Frame.Rarity.UIStroke.Transparency = 0
				player.PlayerGui.NewUGC.Frame.Frame.IconHolder.BackgroundTransparency = 0
				local id = tonumber(item)
				local ms = game:GetService("MarketplaceService")
				local info = ms:GetProductInfo(id, Enum.InfoType.Asset)
				player.PlayerGui.NewUGC.Frame.Frame.NameLabel.Text = info.Name
				player.PlayerGui.NewUGC.Frame.Frame.IconHolder.ImageLabel.Image = "rbxthumb://type=Asset&id=" .. id .. "&w=420&h=420"
				wait(0.1)
				local tween2 = game.TweenService:Create(player.PlayerGui.Color.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				wait(2)
				runs:UnbindFromRenderStep("openingBind")
				local tweenInfo = TweenInfo.new(1)
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Black, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.NameLabel, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.Duplicate, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.Duplicate.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.Rarity, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.Rarity.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.NameLabel.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.IconHolder, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewUGC.Frame.Frame.IconHolder.ImageLabel, tweenInfo, {ImageTransparency = 1}):Play()
				box:Destroy()
				isRunning = false
			end
		end
	else
		if isRunning == false then
			isRunning = true
			local currentTime = tick()

			if currentTime - lastInteractionTime >= cooldownTime then
				lastInteractionTime = currentTime

				player.PlayerGui.GameGUI.Enabled = false
				local box = rs.BoxParts.BoxAnim:Clone()
				box.Sound:Play()
				for i, v in pairs(workspace.Boxes:GetChildren()) do
					v:Destroy()
				end
				box.Parent = workspace.Boxes
				local animation = box.AnimationController:LoadAnimation(box.Open)
				animation.Looped = false
				animation:Play()

				runs:BindToRenderStep("openingBind", 1, function()
					if not box then
						return
					end
					box:PivotTo(camera.CFrame - (camera.CFrame.LookVector * 15))
					if not box:FindFirstChild("Model") then
						return
					else
						box.Model.Beam2.light.Transparency = NumberSequence.new(box.Model.Beam2.light.TransparencyValue.Value)
					end
				end)

				wait(0.5)

				local colorSequences = {
					Common = ColorSequence.new(Color3.new(1, 1, 1)),
					Uncommon = ColorSequence.new(Color3.new(0, 1, 0)),
					Rare = ColorSequence.new(Color3.new(0, 0.34902, 1)),
					Epic = ColorSequence.new(Color3.new(0.615686, 0, 1)),
					Legendary = ColorSequence.new(Color3.new(1, 0.835294, 0)),
				}

				local brickColors = {
					Common = Color3.new(1, 1, 1),
					Uncommon = Color3.new(0, 1, 0),
					Rare = Color3.new(0, 0.34902, 1),
					Epic = Color3.new(0.615686, 0, 1),
					Legendary = Color3.new(1, 0.835294, 0),
					Mythic = Color3.new(0.984314, 1, 0)
				}

				if box:FindFirstChild("Model") then
					box.Model.Beam2.light.Color = colorSequences[rarity]
				end
				if brickColors[rarity] then
					player.PlayerGui.Color.Frame.BackgroundColor3 = brickColors[rarity]
				end
				player.PlayerGui.Color.Frame.BackgroundTransparency = 1

				local tweenInfo = TweenInfo.new(0.6)
				if not box:FindFirstChild("Model") then
					return
				end
				local tween = game.TweenService:Create(box.Model.Beam2.light.TransparencyValue, tweenInfo, {Value = 0}):Play()
				wait(0.5)

				local tween2 = game.TweenService:Create(player.PlayerGui.Color.Frame, tweenInfo, {BackgroundTransparency = 0}):Play()
				wait(0.6)

				player.PlayerGui.GameGUI.Enabled = true
				player.PlayerGui.NewScooter.Enabled = true
				player.PlayerGui.NewScooter.Frame.Frame.Duplicate.Visible = duplicate
				player.PlayerGui.NewScooter.Frame.Frame.Duplicate.TextTransparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.Duplicate.UIStroke.Transparency = 0
				player.PlayerGui.NewScooter.Black.BackgroundTransparency = 0.65
				player.PlayerGui.NewScooter.Frame.BackgroundTransparency = 1
				player.PlayerGui.NewScooter.Frame.Frame.BackgroundTransparency = .45
				player.PlayerGui.NewScooter.Frame.Frame.NameLabel.TextTransparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.NameLabel.UIStroke.Transparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.Rarity.TextTransparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.Rarity.UIStroke.Transparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.IconHolder.BackgroundTransparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.IconHolder.Icon.ImageTransparency = 0
				player.PlayerGui.NewScooter.Frame.Frame.Rarity.Text = rarity
				player.PlayerGui.NewScooter.Frame.Frame.Rarity.UIStroke.Color = brickColors[rarity]
				if rarity == "Common" then
					player.PlayerGui.NewScooter.Frame.Frame.Rarity.UIStroke.Color = Color3.new(0.560784, 0.560784, 0.560784)
				end
				player.PlayerGui.NewScooter.Frame.Frame.NameLabel.Text = rs.Resource.SkinnedScooters[item].UIName.Value
				for i,v in pairs(player.PlayerGui.NewScooter.Frame.Frame.IconHolder.Icon:GetChildren()) do
					if v:IsA("Camera") then
					else
						v:Destroy()
					end
				end
				local scooterModel = rs.Resource.SkinnedScooters[item]:Clone()
				scooterModel.Parent = player.PlayerGui.NewScooter.Frame.Frame.IconHolder.Icon
				wait(0.1)
				local tween2 = game.TweenService:Create(player.PlayerGui.Color.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				wait(2)
				runs:UnbindFromRenderStep("openingBind")
				local tweenInfo = TweenInfo.new(1)
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Black, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.NameLabel, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.Duplicate, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.Duplicate.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.Rarity, tweenInfo, {TextTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.Rarity.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.NameLabel.UIStroke, tweenInfo, {Transparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.IconHolder, tweenInfo, {BackgroundTransparency = 1}):Play()
				game:GetService("TweenService"):Create(player.PlayerGui.NewScooter.Frame.Frame.IconHolder.Icon, tweenInfo, {ImageTransparency = 1}):Play()
				box:Destroy()
				isRunning = false
			end
		end
	end
end)