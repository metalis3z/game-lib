--//SERVICE\\--
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local MarketplaceService = game:GetService('MarketplaceService')

--//VARIABLES\\--
local ScreenGui = script.Parent
local Frame = ScreenGui:WaitForChild('Frame')
local Bar = Frame:WaitForChild('Bar')
local Icon = Frame:WaitForChild('Icon')
local FrameColor1 = Frame:WaitForChild('Color1')
local FrameColor2 = Frame:WaitForChild('Color2')
local FrameColor3 = Frame:WaitForChild('Color3')

local Sound1 = script:WaitForChild('Sound1')

local TimeBetweenColors = 0.8

--//FUNCTIONS\\--
local function SetUp()
	Icon.ImageTransparency = 1
	Bar.BackgroundTransparency = 1
	
	Frame.Visible = true
	
	FrameColor1.Position = UDim2.fromScale(-1,0)
	FrameColor2.Position = UDim2.fromScale(1,0)
	FrameColor3.Position = UDim2.fromScale(0,-1)
	
	FrameColor1.Visible = true
	FrameColor2.Visible = true
	FrameColor3.Visible = true
	Icon.Visible = true
end

local function PlayAnimation()
	TweenService:Create(Icon,TweenInfo.new(1.5),{ImageTransparency = 0}):Play()
	task.delay(1.2,function()
		TweenService:Create(Bar,TweenInfo.new(0.3),{BackgroundTransparency = 1}):Play()
	end)
	TweenService:Create(Bar,TweenInfo.new(0.8),{BackgroundTransparency = 0.2}):Play()
	task.wait(1.5)
	TweenService:Create(FrameColor1,TweenInfo.new(TimeBetweenColors),{Position = UDim2.fromScale(0,0)}):Play()
	Sound1:Play()
	task.wait(TimeBetweenColors)
	TweenService:Create(FrameColor2,TweenInfo.new(TimeBetweenColors),{Position = UDim2.fromScale(0,0)}):Play()
	Sound1:Play()
	task.wait(TimeBetweenColors)
	TweenService:Create(FrameColor3,TweenInfo.new(TimeBetweenColors),{Position = UDim2.fromScale(0,0)}):Play()
	Sound1:Play()
	task.delay(TimeBetweenColors,function()
		
	end)
	task.wait(2)
	FrameColor1.Visible = false
	FrameColor2.Visible = false
	Frame.Transparency = 1
	TweenService:Create(FrameColor3,TweenInfo.new(1),{Transparency = 1}):Play()
	TweenService:Create(Icon,TweenInfo.new(1),{ImageTransparency = 1}):Play()
	task.wait(1)
	FrameColor3.Visible = false
	Icon.Visible = false
	Frame.Visible = false
end

--//  MAIN  \\-- 
SetUp()
task.wait(1)
PlayAnimation()