local RS = game.ReplicatedStorage
local UIS = game:GetService("UserInputService")
local RNS = game["Run Service"]
local RPModules = RS.Modules
local TS = game:GetService("TweenService")

local IconModule = RPModules['Icon']
local Icon = require(IconModule)

--[[var61_upvw = Icon_upvr.new()
var61_upvw:lock()
var61_upvw:setRight()
workspace:GetAttributeChangedSignal("ServerRegion"):Connect(function() -- Line 190
	var61_upvw:setLabel(workspace:GetAttribute("ServerRegion"))
end)
var61_upvw:setLabel(workspace:GetAttribute("ServerRegion"))
elseif arg1_10 == false and var61_upvw then
	var61_upvw:destroy()
	var61_upvw = nil
end]]

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Camera = workspace.CurrentCamera

local ConfigFolder = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local ClickSound = script.Parent.Click

local Remotes = RS.Remotes
local ComRemotes = Remotes.Comunicator
local Comunicator = ComRemotes.Set
local ComRemotes = Remotes.Comunicator
local Getter = ComRemotes.Get

local scrollFrame = script.Parent:WaitForChild("ScrollingFrame", 5)

scrollFrame.Run.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame.Run.Toggle

	if ConfigFolder['Auto Run'].Value == true then
		Comunicator:FireServer('SetConfig', { CN = 'Auto Run'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	else
		Comunicator:FireServer('SetConfig', { CN = 'Auto Run'; V = true })
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
	end

	ClickSound:Play()
end)



scrollFrame.Use.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame.Use.Toggle
	
	if ConfigFolder['Auto Use'].Value == true then
		Comunicator:FireServer('SetConfig', { CN = 'Auto Use'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
        frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	else
		Comunicator:FireServer('SetConfig', { CN = 'Auto Use'; V = true })
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
		
	end

	ClickSound:Play()
end)

--[[scrollFrame.Music.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame.Music.Toggle

	if ConfigFolder['Auto Use'].Value == true then
		Comunicator:FireServer('SetConfig', { CN = 'Auto Use'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	else
		Comunicator:FireServer('SetConfig', { CN = 'Auto Use'; V = true })
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)

	end

	ClickSound:Play()
end)]]

scrollFrame.Gravity.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame.Gravity.Toggle
	
	local var105_upvw

	if ConfigFolder['Gravati'].Value == false then
		Comunicator:FireServer('SetConfig', { CN = 'Gravati'; V = true })
		
        frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
		
	else
		
		var105_upvw = nil
		Comunicator:FireServer('SetConfig', { CN = 'Gravati'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
		
		var105_upvw = RNS.RenderStepped:Connect(function()
			local CurrentCamera = workspace.CurrentCamera
			CurrentCamera.CFrame *= CFrame.Angles(0, 0, math.pi)
		end)
	end

	ClickSound:Play()
end)

scrollFrame.Goodnight.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame.Goodnight.Toggle

	local var105_upvw
	
	local fff = true

	if ConfigFolder['Night'].Value == false then
		var105_upvw = nil
		fff = true
		
		Comunicator:FireServer('SetConfig', { CN = 'Night'; V = true })

		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
		
		TS:Create(game.Lighting, TweenInfo.new(1), {
			ClockTime = 14.5;
			Ambient = Color3.new(1, 1, 1);
			OutdoorAmbient = Color3.new(1, 1, 1);
		}):Play()

	else
		fff = false
		
		Comunicator:FireServer('SetConfig', { CN = 'Night'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
		
		
		TS:Create(game.Lighting, TweenInfo.new(1), {
			ClockTime = 0;
			Ambient = Color3.new(0, 0, 0);
			OutdoorAmbient = Color3.fromRGB(40, 50, 75);
		}):Play()
	end

	ClickSound:Play()
end)
--[[scrollFrame["See current server region"].Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame["See current server region"].Toggle
	
	local var61_upvw
	
	if ConfigFolder.SeeServerRegion.Value == true then
	    var61_upvw = Icon.new()
	    var61_upvw:lock()
	    var61_upvw:setRight()
		var61_upvw:setLabel("ppd")
		
		Comunicator:FireServer('SetConfig', { CN = 'SeeServerRegion'; V = false })
	
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	elseif ConfigFolder.SeeServerRegion.Value == false and var61_upvw then
		Comunicator:FireServer('SetConfig', { CN = 'SeeServerRegion'; V = true })
		
	    var61_upvw:destroy()
	    var61_upvw = nil
		
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
	end

	ClickSound:Play()
end)]]

scrollFrame["See current FPS"].Toggle.Side.MouseButton1Down:Connect(function()
	local frame = scrollFrame["See current FPS"].Toggle
	
	local Fps = script.Parent.Parent.FPS

	if ConfigFolder.FPS.Value == true then
		Fps.Visible = true
		
		Comunicator:FireServer('SetConfig', { CN = 'FPS'; V = false })
		
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
		
		RNS.RenderStepped:Connect(function(arg1_12) -- Line 266
			Fps.Text = tostring(math.ceil(1 / arg1_12)).." FPS"
		end)
	elseif ConfigFolder.FPS.Value == false then
		
		Comunicator:FireServer('SetConfig', { CN = 'FPS'; V = true })
		
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
		
		Fps.Visible = false
	end
	
	ClickSound:Play()
end)
