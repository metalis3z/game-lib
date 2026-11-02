--// Services \\--

local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local Debris = game.Debris



--// Remotes \\--

local RpRemotes = RS.Remotes


local AwakeningRemotes = RpRemotes.Awakening

local AwakeningSet = AwakeningRemotes.Set
local AwakeningGet = AwakeningRemotes.Get



--// Player \\--

local Player: Player = Players.LocalPlayer
local Moveset: StringValue = Player:WaitForChild('Configuration', 5):WaitForChild('Moveset', 5)
local Character = Player.Character or Player.CharacterAdded:Wait()
Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character
end)

local AwakeningProgress: NumberValue = Player.AwakeningProgress
local DoubleAwakeningProgress: NumberValue = Player.DoubleAwakeningProgress


--// Events \\--

local MovesetChanged = Moveset:GetPropertyChangedSignal('Value')
local AwkProgChanged = AwakeningProgress:GetPropertyChangedSignal('Value')
local DoubleAwkProgChanged = AwakeningProgress:GetPropertyChangedSignal('Value')
local IB = UIS.InputBegan
local AwkSetEvent = AwakeningSet.OnClientEvent


--// Variables \\--

local UltNames = {
	['Honored One'] = 'Six Eyes';
	['Vessel'] = 'King of Curses';
	['Perfection'] = 'Soul';
}

local UltBarGradients = {
	['Honored One'] = {Color3.fromRGB(0, 170, 255), Color3.fromRGB(255, 255, 255)};
	['Vessel'] = {Color3.fromRGB(229, 0, 4), Color3.fromRGB(158, 0, 3)};
	['Perfection'] = {Color3.fromRGB(154, 4, 229), Color3.fromRGB(112, 2, 255)};
}

--// GUI \\--

local GUI = script.Parent
local BarFrame = GUI.UltimateBar
local UltKey = BarFrame.UltKey
local CurrentTween: Tween


--// Functions \\--

local function SetUltName()
	local ultName: string = UltNames[Moveset.Value]
	
	if ultName then
		ultName = ultName:upper()
		
		BarFrame.UltName.Text = ultName
		
	else
		BarFrame.UltName.Text = "?"
	end
end

local function ActivateAwk()
	if AwakeningProgress.Value < 100 or Character:HasTag('Stunned') or Character:HasTag('Awakened') and Character:HasTag('dbAwakened') then return end
	
	AwakeningSet:FireServer('Awakening')
	UltKey.Visible = false
end

local function dbActivateAwk()
	if DoubleAwakeningProgress.Value < 100 or Character:HasTag('Stunned') and Character:HasTag('dbAwakened') then return end
	AwakeningSet:FireServer('DoubleAwakening')
end

local function SetUltColor()
	local gradient = BarFrame.Progress.Bar.Fill:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient", BarFrame.Progress.Bar.Fill)
	local colors = UltBarGradients[Moveset.Value] or {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)}  -- Default to white gradient
	gradient.Color = ColorSequence.new(colors[1], colors[2])
	gradient.Transparency = NumberSequence.new(0)  -- Ensure the gradient is fully visible
end

local function Rainbowcolor(BarFrame228)
	while BarFrame228.Visible == true do task.wait(1/20)
		for i = 1, 4 do
			BarFrame228.BackgroundColor3 = Color3.fromHSV(tick() % 20/20, 1, 1)
		end
	end
	if (not BarFrame228.Visible) == true then
		for i = 1, 20 do
			BarFrame228.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
end

--// Connections \\--

DoubleAwkProgChanged:Connect(function()
	local FinalXSize = DoubleAwakeningProgress.Value / 100

	if FinalXSize > 1 then
		FinalXSize = 1
	end
	
	local BarFrame2 = BarFrame.DoubleProgress.Bar

	BarFrame.DoubleProgress.Bar:TweenSize(UDim2.fromScale(FinalXSize, 1), nil, nil, .4, true)
	
	---Rainbowcolor(BarFrame2)

	if DoubleAwakeningProgress.Value >= 100 then
		dbActivateAwk()
	end
end)

AwkProgChanged:Connect(function()
	local FinalXSize = AwakeningProgress.Value / 100

	if FinalXSize > 1 then
		FinalXSize = 1
	end

	BarFrame.Progress.Bar:TweenSize(UDim2.fromScale(FinalXSize, 1), nil, nil, .4, true)

	if AwakeningProgress.Value >= 100 then
		UltKey.Visible = true

		local Light = script.Light:Clone()
		Light.Parent = Character.Torso
		Debris:AddItem(Light, 2)
		
		local HLight = script.HLight:Clone()
		HLight.Parent = Character
		Debris:AddItem(HLight, 2)

		TS:Create(Light, TweenInfo.new(2, Enum.EasingStyle.Linear), { Brightness = 0 }):Play()
		TS:Create(HLight, TweenInfo.new(2, Enum.EasingStyle.Linear), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
	else
		UltKey.Visible = false
	end
end)


IB:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	SetUltColor()
	if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.DPadUp then
		ActivateAwk()
	end
end)

BarFrame.ActivateButton.Activated:Connect(ActivateAwk)

MovesetChanged:Connect(SetUltName)

SetUltName()

shared.triggerAwkbar = function(State)
	if State == true then
		BarFrame:TweenPosition(UDim2.new(0.5, 0, 1, -100), nil, nil, .5, true)
	else
		BarFrame:TweenPosition(UDim2.new(0.5, 0, 1, 25), nil, nil, .5, true)
	end
end
