if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)
local Crosshair = Player:WaitForChild('stored'):WaitForChild('Crosshair')

local CurrentSettings = script.Parent:WaitForChild('CurrentSettings')
local MainFrame = script.Parent:WaitForChild('Frame')

local Camera = workspace.CurrentCamera

_G.FOV = 70
_G.GunFOV = 90
_G.Crosshair = '973818318 1.5'
_G.Effects = true
_G.Music = true
_G.Tracers = true

_G.Crosshair = Crosshair.Value
Crosshair.Changed:Connect(function()
	_G.Crosshair = Crosshair.Value
	local Split = string.split(_G.Crosshair, ' ')
	if Split[2] == nil or not Split[2] then
		_G.Crosshair = _G.Crosshair + ' 1.5'
	end
end)

local ToggleLowGFX = function(Argument, Frame)
	if Argument == true then
		for _,v in next, workspace:GetDescendants() do
			if (v.ClassName == 'Decal' or v.ClassName == 'Texture') and v.Parent.Name ~= 'Head' then
				v:Destroy()
			elseif v:IsA('BasePart') then
				if v.Material == Enum.Material.Concrete then
					v.Material = Enum.Material.Plastic
				elseif v.Material == Enum.Material.Brick then
					v.Material = Enum.Material.Plastic
				end
				if v.Name == 'Baseplate' then
					v.Material = Enum.Material.Concrete
				end
			elseif v:IsA('SurfaceAppearance') and (v.Parent.Name == 'Leaf' or v.Parent.Name == 'Trunk') then
				if v.Parent.Name == 'Leaf' then v.Parent:Destroy() end
				v:Destroy()
			end
		end
		for _,v in next, game:FindService('ReplicatedStorage'):FindFirstChild('Chunks'):GetDescendants() do
			if (v.ClassName == 'Decal' or v.ClassName == 'Texture') and v.Parent.Name ~= 'Head' then
				v:Destroy()
			elseif v:IsA('BasePart') then
				if v.Material == Enum.Material.Concrete then
					v.Material = Enum.Material.Plastic
				elseif v.Material == Enum.Material.Brick then
					v.Material = Enum.Material.Plastic
				end
				if v.Name == 'Baseplate' then
					v.Material = Enum.Material.Concrete
				end
			elseif v:IsA('SurfaceAppearance') and (v.Parent.Name == 'Leaf' or v.Parent.Name == 'Trunk') then
				if v.Parent.Name == 'Leaf' then v.Parent:Destroy() end
				v:Destroy()
			end
		end
		for _,v in next, workspace:WaitForChild('Map'):WaitForChild('Paths'):GetChildren() do
			v:Destroy()
		end
		game:FindService('Lighting').GlobalShadows = false
	elseif Argument == false then
		if not Frame:FindFirstChild('Warning').Visible then
			Frame:FindFirstChild('Warning').Visible = true
			task.wait(3)
			Frame:FindFirstChild('Warning').Visible = false
		end
		return
	end

	if CurrentSettings:FindFirstChild(Frame.Name) then
		local Button = Frame:FindFirstChildOfClass('TextButton')
		if Button.BackgroundColor3 == Color3.fromRGB(170, 0, 0) then
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			Button.Text = 'ENABLED'
		else
			Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			Button.Text = 'DISABLED'
		end
	end
end

local ToggleShadows = function(Argument, Frame)
	game:FindService('Lighting').GlobalShadows = Argument
	for _,v in next, workspace:GetDescendants() do
		if v:IsA('BasePart') then
			v.CastShadow = Argument
		end
	end
	for _,v in next, game:FindService('ReplicatedStorage'):FindFirstChild('Chunks'):GetDescendants() do
		if v:IsA('BasePart') then
			v.CastShadow = Argument
		end
	end

	if CurrentSettings:FindFirstChild(Frame.Name) then
		local Button = Frame:FindFirstChildOfClass('TextButton')
		if Button.BackgroundColor3 == Color3.fromRGB(170, 0, 0) then
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			Button.Text = 'ENABLED'
		else
			Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			Button.Text = 'DISABLED'
		end
	end
end

local ToggleEffects = function(Argument, Frame)
	if CurrentSettings:FindFirstChild(Frame.Name) then
		_G.Effects = Argument
		local Button = Frame:FindFirstChildOfClass('TextButton')
		if Button.BackgroundColor3 == Color3.fromRGB(170, 0, 0) then
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			Button.Text = 'ENABLED'
		else
			Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			Button.Text = 'DISABLED'
		end
	end
end

local ToggleMusic = function(Argument, Frame)
	if CurrentSettings:FindFirstChild(Frame.Name) then
		_G.Music = Argument
		local Button = Frame:FindFirstChildOfClass('TextButton')
		if Button.BackgroundColor3 == Color3.fromRGB(170, 0, 0) then
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			Button.Text = 'ENABLED'
		else
			Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			Button.Text = 'DISABLED'
		end
	end
end

local ToggleTracers = function(Argument, Frame)
	if CurrentSettings:FindFirstChild(Frame.Name) then
		_G.Tracers = Argument
		local Button = Frame:FindFirstChildOfClass('TextButton')
		if Button.BackgroundColor3 == Color3.fromRGB(170, 0, 0) then
			Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			Button.Text = 'ENABLED'
		else
			Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			Button.Text = 'DISABLED'
		end
	end
end

for _,v in next, MainFrame:GetChildren() do
	if v:IsA('Frame') and CurrentSettings:FindFirstChild(v.Name) then
		local Button, TextBox = v:FindFirstChildOfClass('TextButton'), v:FindFirstChildOfClass('TextBox')
		if Button and not TextBox then
			Button.MouseButton1Click:Connect(function()
				if v.Name == 'LowGFX' then
					if Button.Text == 'DISABLED' then
						ToggleLowGFX(true, v)
					else
						ToggleLowGFX(false, v)
					end
				elseif v.Name == 'Shadows' then
					if Button.Text == 'DISABLED' then
						ToggleShadows(true, v)
					else
						ToggleShadows(false, v)
					end
				elseif v.Name == 'Effects' then
					if Button.Text == 'DISABLED' then
						ToggleEffects(true, v)
					else
						ToggleEffects(false, v)
					end
				elseif v.Name == 'Music' then
					if Button.Text == 'DISABLED' then
						ToggleMusic(true, v)
					else
						ToggleMusic(false, v)
					end
				elseif v.Name == 'Tracers' then
					if Button.Text == 'DISABLED' then
						ToggleTracers(true, v)
					else
						ToggleTracers(false, v)
					end
				end
			end)
		elseif TextBox and not Button then
			if v.Name ~= 'Crosshair' and v.Name ~= 'CrosshairSize' then
				TextBox.FocusLost:Connect(function()
					if tonumber(TextBox.Text) ~= nil then
						if tonumber(TextBox.Text) < 70 then
							TextBox.Text = '70'
						elseif tonumber(TextBox.Text) > 120 then
							TextBox.Text = '120'
						end
						_G[v.Name] = tonumber(TextBox.Text)
						if v.Name == 'FOV' then Camera.FieldOfView = _G[v.Name] end
					else
						TextBox.Text = tostring(_G[v.Name])
					end
				end)
			end
		end
	end
end

local CrosshairText = MainFrame:FindFirstChild('Crosshair'):FindFirstChild('TextBox')
local CrosshairSize = MainFrame:FindFirstChild('CrosshairSize'):FindFirstChild('TextBox')
CrosshairText.FocusLost:Connect(function()
	if tonumber(CrosshairText.Text) ~= nil and CrosshairText.Text ~= '0' and CrosshairText.Text ~= '1' and CrosshairText.Text ~= '' then
	else
		CrosshairText.Text = '973818318'
	end
	if tonumber(CrosshairSize.Text) ~= nil then
		if tonumber(CrosshairSize.Text) < 0.1 then
			CrosshairSize.Text = '0.1'
		elseif tonumber(CrosshairSize.Text) > 2.5 then
			CrosshairSize.Text = '2.5'
		end
	else
		CrosshairSize.Text = '1'
	end
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('SaveCrosshair', CrosshairText.Text .. ' ' .. CrosshairSize.Text)
	if Player.PlayerGui:FindFirstChild('GunGUI') then
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').AnchorPoint = Vector2.new(0.5, 0.5)
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Position = UDim2.new(.5, 0, .5, 0)
		local Split = string.split(_G.Crosshair, ' ')
		if not Split[2] then
			_G.Crosshair = _G.Crosshair + ' 1.5'
		end
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Image = 'rbxthumb://type=Asset&id=' .. tostring(Split[1]) .. '&w=420&h=420'
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center.Rotation = 0
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel'):FindFirstChild('UIScale').Scale = tonumber(Split[2])
	end
end)

CrosshairSize.FocusLost:Connect(function()
	if tonumber(CrosshairText.Text) ~= nil and CrosshairText.Text ~= '0' and CrosshairText.Text ~= '1' and CrosshairText.Text ~= '' then
	else
		CrosshairText.Text = '973818318'
	end
	if tonumber(CrosshairSize.Text) ~= nil then
		if tonumber(CrosshairSize.Text) < 0.1 then
			CrosshairSize.Text = '0.1'
		elseif tonumber(CrosshairSize.Text) > 2.5 then
			CrosshairSize.Text = '2.5'
		end
	else
		CrosshairSize.Text = '1'
	end
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('SaveCrosshair', CrosshairText.Text .. ' ' .. CrosshairSize.Text)
	if Player.PlayerGui:FindFirstChild('GunGUI') then
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').AnchorPoint = Vector2.new(0.5, 0.5)
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Position = UDim2.new(.5, 0, .5, 0)
		local Split = string.split(_G.Crosshair, ' ')
		if not Split[2] then
			_G.Crosshair = _G.Crosshair + ' 1.5'
		end
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel').Image = 'rbxthumb://type=Asset&id=' .. tostring(Split[1]) .. '&w=420&h=420'
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center.Rotation = 0
		Player.PlayerGui.GunGUI:FindFirstChild('Crosshair'):FindFirstChild('Main').Center:FindFirstChild('ImageLabel'):FindFirstChild('UIScale').Scale = tonumber(Split[2])
	end
end)

MainFrame:FindFirstChild('Reset').MouseButton1Click:Connect(function()
	game:FindService('Lighting').GlobalShadows = true
	for _,v in next, workspace:GetDescendants() do
		if v.ClassName == 'Decal' and v.Parent.Name ~= 'Head' and v.Transparency == 1 then
			v.Transparency = 0
		elseif v:IsA('BasePart') then
			v.CastShadow = true
			if v.Name == 'CONCRETE' and v.Material == Enum.Material.Plastic and v.Name ~= 'Handler' then
				v.Material = Enum.Material.Concrete
			elseif v.Name == 'BRICK' and v.Material == Enum.Material.Plastic and v.Name ~= 'Handler' then
				v.Material = Enum.Material.Brick
			end
		end
	end
	MainFrame:FindFirstChild('LowGFX').TextButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
	MainFrame:FindFirstChild('Shadows').TextButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	MainFrame:FindFirstChild('FOV').TextBox.Text = '70'
	_G.FOV = tonumber(MainFrame:FindFirstChild('FOV').TextBox.Text)
	MainFrame:FindFirstChild('GunFOV').TextBox.Text = '90'
	_G.GunFOV = tonumber(MainFrame:FindFirstChild('GunFOV').TextBox.Text)
	ToggleEffects(true, MainFrame:FindFirstChild('Effects'))
	ToggleMusic(true, MainFrame:FindFirstChild('Music'))
	ToggleTracers(true, MainFrame:FindFirstChild('Tracers'))
	Camera.FieldOfView = _G.FOV 
end)

MainFrame:FindFirstChild('Refresh').MouseButton1Click:Connect(function()
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('RefreshVehicle')
end)

local Cooldown = false
MainFrame:FindFirstChild('Avatar').MouseButton1Click:Connect(function()
	if Cooldown then return end
	if Humanoid.Health == 0 then return end
	if Character:FindFirstChild('Combat').Value then return end
	Cooldown = true
	if not Player:FindFirstChild('Girl') then
		game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('GIRL')
		MainFrame:FindFirstChild('Avatar').BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		MainFrame:FindFirstChild('Avatar').Text = 'BOY AVATAR'
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('BOY')
		MainFrame:FindFirstChild('Avatar').BackgroundColor3 = Color3.fromRGB(170, 0, 255)
		MainFrame:FindFirstChild('Avatar').Text = 'GIRL AVATAR'
	end
	task.wait(2)
	Cooldown = false
end)

if (game:FindService('UserInputService').TouchEnabled or game:FindService('UserInputService').GamepadEnabled) then
	repeat task.wait(3) until not game:FindService('ReplicatedFirst'):FindFirstChild('Intro')
	script.Parent.Enabled = true
	script.Parent.Frame.Visible = false
	
	script.Parent.Question.Visible = true
	script.Parent.Question.Yes.MouseButton1Click:Connect(function()
		script.Parent.Enabled = false
		script.Parent.Frame.Visible = true
		script.Parent.Question:Destroy()
		ToggleShadows(false, MainFrame:FindFirstChild('Shadows'))
		ToggleLowGFX(true, MainFrame:FindFirstChild('LowGFX'))
	end)
	script.Parent.Question.No.MouseButton1Click:Connect(function()
		script.Parent.Enabled = false
		script.Parent.Frame.Visible = true
		script.Parent.Question:Destroy()
	end)
	task.wait(45)
	if script.Parent:FindFirstChild('Question') then
		script.Parent.Enabled = false
		script.Parent.Frame.Visible = true
		script.Parent.Question:Destroy()
	    ToggleShadows(false, MainFrame:FindFirstChild('Shadows'))
		ToggleLowGFX(true, MainFrame:FindFirstChild('LowGFX'))
	end
end

ToggleTracers(false, MainFrame:FindFirstChild('Tracers'))

local Split = string.split(_G.Crosshair, ' ')
if Split[1] then CrosshairText.Text = Split[1] end
if Split[2] then CrosshairSize.Text = Split[2] end

if Split[2] ~= nil or not Split[2] then
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('SaveCrosshair', CrosshairText.Text .. ' 1.5')
end