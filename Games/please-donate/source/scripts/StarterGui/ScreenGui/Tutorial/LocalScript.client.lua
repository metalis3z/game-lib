
local TweenService = game:GetService("TweenService")

local Player = game.Players.LocalPlayer
local Remotes = require(game.ReplicatedStorage.Remotes)
local Camera = workspace.CurrentCamera

local Tutorial = script.Parent
local Pages = Tutorial.Frame.Pages
local PageLayout = Pages.UIPageLayout

local TI = TweenInfo.new(.5, Enum.EasingStyle.Quint)

Tutorial:GetPropertyChangedSignal("Visible"):Connect(function()
	--print(Remotes.Function("FetchCreateLink"):InvokeServer())
	--Pages.Tutorial2.TextBox.Text = Remotes.Function("FetchCreateLink"):InvokeServer()
	
	for i, v in pairs(Player.PlayerGui.ScreenGui:GetChildren()) do
		if v:GetAttribute("Default") then
			v.Visible = not Tutorial.Visible
		end
	end
	
	Tutorial.Illustration.Image = "rbxassetid://12987620247"
	Tutorial.Next.Text = "NEXT"

end)

Tutorial.Next.Activated:Connect(function()
	if PageLayout.CurrentPage == Pages.Tutorial1 then
		Tutorial.Illustration.Image = "rbxassetid://12987646310"
	elseif PageLayout.CurrentPage == Pages.Tutorial2 then
		Tutorial.Illustration.Image = "rbxassetid://12987791579"
	elseif PageLayout.CurrentPage == Pages.Tutorial4 then
		Tutorial.Next.Text = "CONTINUE"
		Tutorial.Illustration.Image = "rbxassetid://12987620247"
	elseif PageLayout.CurrentPage == Pages.Tutorial5 then
		Player.PlayerGui.ScreenGui.Tutorial.Visible = false
		Tutorial.Position = UDim2.new(0.5, 0, 0.55, 0)
		TweenService:Create(Camera, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {FieldOfView = 70}):Play()
		TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = 0}):Play()
	end
	PageLayout:Next()
end)
--221, 15, 228