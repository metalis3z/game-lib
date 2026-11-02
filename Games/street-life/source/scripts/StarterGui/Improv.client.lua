if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Head = Character:WaitForChild('Head')
local UserInputService = game:FindService('UserInputService')

local Shiftlock = Character:WaitForChild('Shiftlock')
local Remote = script:WaitForChild('RemoteEvent')
game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

if workspace.CurrentCamera:FindFirstChild('BlurEffect') then
	workspace.CurrentCamera:FindFirstChild('BlurEffect').Enabled = false
	workspace.CurrentCamera:FindFirstChild('BlurEffect').Size = 0
end

ClearAudios = function(Parent)
	for _,v in ipairs(Parent:GetDescendants()) do
		if v:IsA('Sound') then
			if v.Name == 'Sound' then
				v:Destroy()
			end
		end
	end
end

StopGunAnims = function()
	for _,v in next, Character.Humanoid:GetPlayingAnimationTracks() do 
		if string.lower(v.Name) == 'idleanim' or string.lower(v.Name) == 'toolnone' or string.lower(v.Name) == 'holddownanim' then
			v:Stop()
		end
	end
end

local Police = Head:WaitForChild('Police')

repeat task.wait(.1) until _G.FOV ~= nil
workspace.CurrentCamera.FieldOfView = _G.FOV
if game:FindService('UserInputService').MouseEnabled then
	game:FindFirstChild('UserInputService').MouseIconEnabled = true
end
game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

Character.ChildAdded:Connect(function(Child)
	if Child:FindFirstChild('GunScript_Local') then
		StopGunAnims()
		if Child then ClearAudios(Child:FindFirstChild('Handle')) end
		if Character:FindFirstChild('Highlight') then
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
	end
end)

Character.ChildRemoved:Connect(function(Child)
	if Child:FindFirstChild('GunScript_Local') then
		StopGunAnims()
		if Child then ClearAudios(Child:FindFirstChild('Handle')) end
		if Character:FindFirstChild('Highlight') then
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		else
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
	end
end)

Player.PlayerGui.ChildAdded:Connect(function(Child)
	if Child.Name == 'GunGUI' then
		if Player.PlayerGui:FindFirstChild('GunGUI') then
			Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').AnchorPoint = Vector2.new(0.5, 0.5)
			Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Position = UDim2.new(.5, 0, .5, 0)
			local Split = string.split(_G.Crosshair, ' ')
			if Split[2] == nil or not Split[2] then
				_G.Crosshair = _G.Crosshair + ' 1.5'
				Split = string.split(_G.Crosshair, ' ')
			end
			Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Image = 'rbxthumb://type=Asset&id=' .. tostring(Split[1]) .. '&w=420&h=420'
			Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center.Rotation = 0
			Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel'):FindFirstChild('UIScale').Scale = tonumber(Split[2])
		end
	end
end)


game:FindService('UserInputService'):GetPropertyChangedSignal('MouseBehavior'):Connect(function()
	if game:FindService('UserInputService').MouseBehavior == Enum.MouseBehavior.LockCenter then
		Remote:FireServer(Shiftlock, true)
	else
		Remote:FireServer(Shiftlock, false)
	end
end)

Character:WaitForChild('UpperTorso').ChildAdded:Connect(function(Child)
	if Child.Name == 'COMBATLOG' then
		game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end
end)

Character:WaitForChild('UpperTorso').ChildRemoved:Connect(function(Child)
	if Child.Name == 'COMBATLOG' then
		game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	elseif Child.Name == 'Circle' and Child:FindFirstChild('Object') then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end
end)

script.Parent:WaitForChild('Gang').Enabled = true
script.Parent:WaitForChild('RStore').Enabled = true

if game:FindService('Players').LocalPlayer.Team == game.Teams.PD then
	game.Players.PlayerAdded:Connect(function(Player)
		Player.CharacterAdded:Connect(function(Charry)
			local Head = Charry:WaitForChild('Head')
			local Police = Head:WaitForChild('Police')
			if Police then
				if Player.Team ==  game.Teams.PD then
					Police.Enabled = true
				end
			end
		end)
	end)
end

if game:FindService('Players').LocalPlayer.Team == game.Teams.PD then
	for _, v in pairs(game.Teams.PD:GetPlayers()) do
		if v ~= Player then
			local Char = v.Character or v.CharacterAdded:Wait()
			local Head = Char:WaitForChild('Head')
			local Police = Head:WaitForChild('Police')

			if Police then
				Police.Enabled = true
			end

			v.CharacterAdded:Connect(function(Charry)
				local Head = Charry:WaitForChild('Head')
				local Police = Head:WaitForChild('Police')

				if Police then
					if v.Team == game.Teams.PD then
						Police.Enabled = true
					end
				end
			end)
		end
	end
end


Police:GetPropertyChangedSignal('Enabled'):Connect(function()
	if Police.Enabled then
		Police.Enabled = false
	end
end)

Police:WaitForChild('ImageLabel'):GetPropertyChangedSignal('Visible'):Connect(function()
	if Police:WaitForChild('ImageLabel').Visible then
		Police:WaitForChild('ImageLabel').Visible = false
	end
end)