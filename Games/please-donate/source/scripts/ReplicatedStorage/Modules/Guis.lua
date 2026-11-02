
local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local TweenService = game:GetService('TweenService')

local FrameTI = TweenInfo.new(.5, Enum.EasingStyle.Quint)
--local Fade = TweenInfo.new(1)
--local PopupTI = TweenInfo.new(.5, Enum.EasingStyle.Quart)

--local Popup = Player.PlayerGui:WaitForChild("ScreenGui").TextPopup
--local PopupFadeTween =  TweenService:Create(Popup, Fade, {TextTransparency = 1})

local Guis = {}

function Guis.Transaction(Name, Price)
	
end

function Guis.StartLoading()
	TweenService:Create(Player.PlayerGui.ScreenGui.Loading, TweenInfo.new(.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.35}):Play()
	TweenService:Create(Player.PlayerGui.ScreenGui.Loading.ImageLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
end

function Guis.StopLoading()
	TweenService:Create(Player.PlayerGui.ScreenGui.Loading, TweenInfo.new(.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(Player.PlayerGui.ScreenGui.Loading.ImageLabel, TweenInfo.new(.25, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
end

local Templates = game.ReplicatedStorage.Templates

function Guis.TextPopup(Text, Color)
	coroutine.wrap(function()
		--Popup.Text = Text
		--Popup.TextColor3 = Color or Color3.fromRGB(255, 255, 255)
		--PopupFadeTween:Cancel()
		--Popup.TextTransparency = 0
		--Popup.Position = UDim2.fromScale(.5, .9)
		--TweenService:Create(Popup, PopupTI, {Position = UDim2.fromScale(.5, .8)}):Play()
		--task.wait(PopupTI.Time)
		--print(5)

		--PopupFadeTween:Play()	

		local TextPopup = Templates.PopupTemplate:Clone()
		TextPopup.Text = Text
		TextPopup.TextColor3 = Color or Color3.fromRGB(255, 255, 255)
		TextPopup.Parent = Player.PlayerGui.ScreenGui
		TweenService:Create(TextPopup, TweenInfo.new(.9, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(0, .8)}):Play()
		task.wait(.75)
		TweenService:Create(TextPopup, TweenInfo.new(3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
		task.wait(2)
		TextPopup:Destroy()

		
	end)()
end

game.ReplicatedStorage.Events.TextPopup.OnClientEvent:Connect(Guis.TextPopup)

function Guis.CloseAllFrame(Exception)
	for i, v in pairs(Player.PlayerGui.ScreenGui:GetChildren()) do
		if v:IsA("Frame") and not v:GetAttribute("DontDisable") and v ~= Exception then
			v.Visible = false
		end
	end
end

function Guis.OpenFrame(Frame)
	
	local StartPosition = UDim2.fromScale(.5, .53)
	local FOV = 60
	
	Frame.Visible = true
	Frame.Position = StartPosition		
	TweenService:Create(Camera, FrameTI, {FieldOfView = FOV}):Play()
	TweenService:Create(Frame, FrameTI, {Position = UDim2.fromScale(.5, .5)}):Play()
	Guis.CloseAllFrame(Frame)
	
end

function Guis.CloseFrame(Frame)
	Frame.Visible = false
	TweenService:Create(Camera, FrameTI, {FieldOfView = 70}):Play()
end

function Guis.PopupAlert(Text)
	Player.PlayerGui.ScreenGui.PopupAlert.TextLabel.Text = Text
	Guis.OpenFrame(Player.PlayerGui.ScreenGui.PopupAlert)

end

return Guis
