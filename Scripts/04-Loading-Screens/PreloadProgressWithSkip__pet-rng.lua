-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: ReplicatedFirst/LoadingClient.client.luau  (client, 60 lines)
-- Categories: loading-screen 33.3
-- What it does: Clones a prepared Loading ScreenGui, preloads every descendant of game one by one, updates a % label and tweened bar, offers a Skip button, plays a sound when finished.

--//Services\\--

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local LoadingGui = script:WaitForChild("Loading")

local Assets = game:GetDescendants()

local ClonedLoadingScreen = LoadingGui:Clone()
ClonedLoadingScreen.Enabled = true
ClonedLoadingScreen.Parent = PlayerGui

local Percentage = ClonedLoadingScreen.LoadingFrame.LoadingBar:WaitForChild("Percentage")
local LoadingBar = ClonedLoadingScreen.LoadingFrame:WaitForChild("LoadingBar")
local Skip = ClonedLoadingScreen.LoadingFrame:WaitForChild("Skip")

--//Functions\\--

ReplicatedFirst:RemoveDefaultLoadingScreen()

TweenService:Create(ClonedLoadingScreen.LoadingFrame:WaitForChild("Icon"),
	TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0),
	{Position = ClonedLoadingScreen.LoadingFrame:WaitForChild("Icon").Position - UDim2.new(0,0,0.1,0)}):Play()

TweenService:Create(ClonedLoadingScreen.LoadingFrame:WaitForChild("Pattern"),
	TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, true, 0.2),
	{Position = ClonedLoadingScreen.LoadingFrame:WaitForChild("Pattern").Position + UDim2.new(0.7,0,0.7,0)}):Play()

Skip.MouseButton1Click:Connect(function()
	ClonedLoadingScreen.Enabled = false
end)


for i = 1, #Assets do
	local asset = Assets[i]
	local percentage = math.round(i / #Assets * 100)

	ContentProvider:PreloadAsync({asset})

	Percentage.Text = percentage .. "/100%"

	TweenService:Create(LoadingBar.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromScale(percentage / 100, 1)}):Play()

	if i % 3 == 0 then
		task.wait()
	end

	if Percentage.Text == "97/100%" then 
		ClonedLoadingScreen.Enabled = false
	end

	if i == #Assets then
		task.wait(1)
		game:GetService("SoundService"):WaitForChild("Main"):WaitForChild("Interface"):FindFirstChild("LoadingSound"):Play()
	end
end