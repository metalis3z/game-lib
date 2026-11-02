if not game:IsLoaded() then game.Loaded:Wait() end

local IDs = {
	['1911'] = 1819589020,
	['Glock17'] = 1819588819,
	['FN 5.7'] = 1819589245,
	['Mac'] = 1819589817,
	['ARPDrum'] = 1819589455,
	['Draco'] = 1819589657
}

local Cash = {
	--// CASH
	1897020993, -- 1K Cash
	1897024605, -- 2K Cash
	1896736515, -- 5K Cash
	1896744959 , -- 10K Cash
}

local LevelsList = {
	1896711055, -- 5 Levels
	1896720384, -- 10 Levels
	1896707824, -- 15 Levels
	1896708551, -- 20 Levels
}

local OneTime = {
	1897070383, -- 1911
	1896744724, -- FN 5.7
	1896765014, -- Glock17
	1896765936, -- Mac
	1896736723, -- ARP
	1896759694, -- Draco
}

local Spawns = {
	1891649550, -- Draco
	1891648185, -- HoneyBadger
	1891646284, -- GlockSwitch
	1891661296, -- Knife
	1891654265, -- Mac
	1891657563, -- Glock17
}

local C_1000 = 1819590191
local C_2000 = 1819590388
local C_5000 = 1819590588
local C_10000 = 1819590764

local L_5 = 1819591082
local L_10 = 1819591289
local L_15 = 1819591468
local L_20 = 1819591629

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local Press = script:FindFirstChild('Press')

local Frame = script.Parent:FindFirstChild('Frame')
local Levels = Frame:FindFirstChild('Levels')
local Open, Close = script.Parent:FindFirstChild('Open'), Frame:FindFirstChild('Close')

local TextUser = Levels:FindFirstChild('TextUser')

local Giftings = require(game:FindService('ReplicatedStorage'):FindFirstChild('Giftable'))

local function FindPlayer(String)
		local List = {}
		for _,v in pairs(game:GetService("Players"):GetChildren()) do
			if (string.sub(string.lower(v.Name),1,string.len(String))) == string.lower(String) then
				if v ~= Player then
					table.insert(List, v)
				end
			end
		end
		if List[1] then
			return List or {}
		else
			return nil
		end
end

for _,v in ipairs(Frame:GetChildren()) do
	if v:IsA('TextButton') then
		if IDs[v.Name] then
			v.MouseButton1Click:Connect(function()
				game:FindService('MarketplaceService'):PromptProductPurchase(Player, IDs[v.Name])
			end)
		end
	end
end

Frame['1000'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, C_1000)
end)

Frame['2000'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, C_2000)
end)

Frame['5000'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, C_5000)
end)

Frame['10000'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, C_10000)
end)

Levels['5'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, L_5)
end)

Levels['10'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, L_10)
end)

Levels['15'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, L_15)
end)

Levels['20'].MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, L_20)
end)

Open.MouseButton1Click:Connect(function()
	Press:Play()
	Frame.Visible = not Frame.Visible
end)

Open.MouseEnter:Connect(function()
	Open.Around.Thickness = 3
end)

Open.MouseLeave:Connect(function()
	Open.Around.Thickness = 2
end)

Close.MouseButton1Click:Connect(function()
	Press:Play()
	if Close.Visible then
		Frame.Visible = false
	end
end)

Close.MouseEnter:Connect(function()
	Close.Around.Thickness = 3
end)

Close.MouseLeave:Connect(function()
	Close.Around.Thickness = 2
end)

for _,v in next, Giftings do
	local Clone = TextUser.Template:Clone()
	if table.find(Cash, v) then
		Clone.Parent = TextUser:FindFirstChild('CASHList')
	elseif table.find(LevelsList, v) then
		Clone.Parent = TextUser:FindFirstChild('LEVELSList')
	elseif table.find(OneTime, v) then
		Clone.Parent = TextUser:FindFirstChild('ONCEList')
	elseif table.find(Spawns, v) then
		Clone.Parent = TextUser:FindFirstChild('SPAWNSList')
	end
	local Info = game:FindService('MarketplaceService'):GetProductInfo(v, Enum.InfoType.Product)
	Clone.Text = Info.DisplayName
	Clone.Visible = true
	Clone.BackgroundColor3 = Color3.fromRGB(13, 255, 0)
	Clone.MouseButton1Click:Connect(function()
		for _,v in next, Levels:FindFirstChild('Press'):GetChildren() do
			v.Visible = false
		end
		Clone.Parent.Visible = false
		if game:FindService('Players')[TextUser.Text] then game:FindService('ReplicatedStorage'):FindFirstChild('Gifting'):FireServer(v, game:FindService('Players')[TextUser.Text].UserId) end
		TextUser.Text = ''
	end)
	task.wait(.1)
end

TextUser:GetPropertyChangedSignal('Text'):Connect(function()
	if TextUser.Text == '' then 
		for _,v in next, Levels:FindFirstChild('Press'):GetChildren() do
			v.Visible = false
		end
		TextUser:FindFirstChild('CASHList').Visible = false
		TextUser:FindFirstChild('LEVELSList').Visible = false
		TextUser:FindFirstChild('SPAWNSList').Visible = false
		TextUser:FindFirstChild('ONCEList').Visible = false
		TextUser:FindFirstChild('UserList').Visible = false
		return
	end
	local CurrentText = TextUser.Text

	if game:FindService('Players'):FindFirstChild(CurrentText) then
		TextUser:FindFirstChild('CASHList').Visible = true
		for _,v in next, Levels:FindFirstChild('Press'):GetChildren() do
			v.Visible = true
		end
		return
	end	

	local Players = FindPlayer(CurrentText)

	if Players and Players ~= nil then
		for _,v in next, TextUser:FindFirstChild('UserList'):GetChildren() do if v:IsA('TextButton') then v:Destroy() end end
		for _,v in next, Players do
			local Clone = TextUser.Template:Clone()
			Clone.Parent = TextUser:FindFirstChild('UserList')
			Clone.Text = v.Name
			Clone.Visible = true
			Clone.MouseButton1Click:Connect(function()
				for _,v in next, TextUser:FindFirstChild('UserList'):GetChildren() do if v:IsA('TextButton') then v:Destroy() end end
				TextUser.Text = v.Name
				TextUser:FindFirstChild('CASHList').Visible = true
				for _,v in next, Levels:FindFirstChild('Press'):GetChildren() do
					v.Visible = true
				end
				TextUser:FindFirstChild('UserList').Visible = false
			end)
		end
		TextUser:FindFirstChild('UserList').Visible = true
	end
end)

for _,v in next, Levels.Press:GetChildren() do
	if v:IsA('TextButton') then
		v.MouseButton1Click:Connect(function()
			TextUser:FindFirstChild(v.Name .. 'List').Visible = true
			for _,vv in next, TextUser:GetChildren() do
				if vv:IsA('ScrollingFrame') and vv.Name ~= v.Name .. 'List' then
					vv.Visible = false
				end
			end
		end)
	end
end

local t = 20

local tick = tick
game:GetService("RunService"):BindToRenderStep("Rainbow", 1000, function()
	local hue = tick() % t / t
	local color = Color3.fromHSV(hue, 1, 1)
	Open.Main.Color = color
	Open.Inside.TextColor3 = color
	Levels.Gifting.TextColor3 = color
	Open.TextColor3 = color
end)