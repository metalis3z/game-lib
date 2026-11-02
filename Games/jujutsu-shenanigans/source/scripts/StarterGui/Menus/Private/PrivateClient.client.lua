--PSE:FireServer('GiveAwk')
local RS = game.ReplicatedStorage

local Remotes = RS.Remotes
local ComRemotes = Remotes.Comunicator
local PSE = Remotes.Commands.Set

local Comunicator = ComRemotes.Set
local ComRemotes = Remotes.Comunicator
local Getter = ComRemotes.Get

local Player = game.Players.LocalPlayer

local Categories = script.Parent.Categories
local Items = script.Parent.Items
local Sound = script.Parent.Click
local ConfigFolder = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local CommandFolder = Player:FindFirstChild('Commands') or Player:WaitForChild('Commands', 10)

local function isOwner()
	return Player:GetAttribute("CheckedAdmin") == true --game.PrivateServerOwnerId == Player.UserId or
end

Categories.Players.MouseButton1Down:Connect(function()
	if not isOwner() then return end
	local Selected = Categories.Players.Select
	local serversel = Categories.Server.Select
	local PlayersSettings = Items.Players
	local serverSettings = Items.Server

	Selected.Visible = true
	PlayersSettings.Visible = true
	if serversel.Visible == true then
		serversel.Visible = false
	end

	if serverSettings.Visible == true then
		serverSettings.Visible = false
	end
end)

Categories.Server.MouseButton1Down:Connect(function()
	if not isOwner() then return end
	local Selected = Categories.Server.Select
	local serversel = Categories.Players.Select
	local PlayersSettings = Items.Server
	local serverSettings = Items.Players

	Selected.Visible = true
	PlayersSettings.Visible = true
	if serversel.Visible == true then
		serversel.Visible = false
	end

	if serverSettings.Visible == true then
		serverSettings.Visible = false
	end
end)

local function executeIfOwner(action)
	return function(...)
		if not isOwner() then return end
		action(...)
	end
end

Items.Server.Dummy1.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('SpawnDummy', { InitialHp = nil; ScriptName = nil })
	Sound:Play()
end))

Items.Server.Dummy2.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'AttackScript' })
	Sound:Play()
end))

Items.Server.Dummy3.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('SpawnDummy', { InitialHp = 1; ScriptName = nil })
	Sound:Play()
end))

Items.Server.Dummy4.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'BlockScript' })
	Sound:Play()
end))

Items.Server.Dummy5.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'BulletScript' })
	Sound:Play()
end))

Items.Server.Dummy6.Button.MouseButton1Down:Connect(executeIfOwner(function()
	Sound:Play()
	PSE:FireServer('ClearDummies')
end))

Items.Players.Players.GiveUlt.Button.MouseButton1Down:Connect(executeIfOwner(function()
	Sound:Play()
	PSE:FireServer('GiveAwk')
end))

Items.Players.Players.Respawn3.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('Respawn')
	Sound:Play()
end))

Items.Players.Players.Heal.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('Heal')
	Sound:Play()
end))

Items.Players.Players.Bring.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('Bring')
	Sound:Play()
end))

Items.Players.Players.Stun.Button.MouseButton1Down:Connect(executeIfOwner(function()
	PSE:FireServer('NoStun')
	Sound:Play()
end))

Items.Players.Players.CD.Toggle.Side.MouseButton1Down:Connect(function()
	local frame = Items.Players.Players.CD.Toggle

	if CommandFolder['NoCooldown'].Value == true then
		PSE:FireServer('NoCooldown')
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
	else
		PSE:FireServer('NoCooldown')
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	end

	Sound:Play()
end)

Items.Players.Players.Build.Toggle.Side.MouseButton1Down:Connect(executeIfOwner(function()
	local frame = Items.Players.Players.Build.Toggle
	if ConfigFolder['Build'].Value == true then
		Comunicator:FireServer('SetConfig', { CN = 'Build'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
		--[[local BuildFind = Player.Character:FindFirstChild("Build")
		BuildFind:Destroy()]]
	else
		Comunicator:FireServer('SetConfig', { CN = 'Build'; V = true })
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
		--[[local clone = script.Build:Clone()
		clone.Parent = Player.Character
		clone.Enabled = true]]
	end
	Sound:Play()
end))

Items.Server.OverPower.Toggle.Side.MouseButton1Down:Connect(executeIfOwner(function()
	local frame = Items.Server.OverPower.Toggle

	if ConfigFolder['OverPower'].Value == true then
		Comunicator:FireServer('SetConfig', { CN = 'OverPower'; V = false })
		frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(85, 0, 0)
		frame.Side.Position = UDim2.new(0.5, 0, 0, 0)
	else
		Comunicator:FireServer('SetConfig', { CN = 'OverPower'; V = true })
		frame.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
		frame.Side.BackgroundColor3 = Color3.fromRGB(169, 255, 189)
		frame.Side.Position = UDim2.new(0, 0, 0, 0)
	end

	Sound:Play()
end))






