local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Sunucudan gelecek olan sinyali bekliyoruz
local FlashbangEvent = ReplicatedStorage:WaitForChild("FlashbangEvent")

FlashbangEvent.OnClientEvent:Connect(function(duration)
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	-- Beyaz ekranı oluşturuyoruz
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "FlashbangGui"
	screenGui.IgnoreGuiInset = true -- Ekranın en üstündeki barı da kaplasın
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.new(1, 1, 1) -- Beyaz
	frame.BorderSizePixel = 0
	frame.ZIndex = 10 -- Diğer her şeyin üstünde görünsün
	frame.Parent = screenGui

	-- Belirlenen süre kadar bekle (Örn: 3 saniye tam beyaz kalsın)
	task.wait(duration)

	-- Yavaşça saydamlaşarak kaybolma efekti (2 saniye sürer)
	local tween = TweenService:Create(frame, TweenInfo.new(2), {BackgroundTransparency = 1})
	tween:Play()

	tween.Completed:Connect(function()
		screenGui:Destroy()
	end)
end)