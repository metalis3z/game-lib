local TweenService = game:GetService("TweenService")

local verify = workspace:WaitForChild("Map"):WaitForChild("Index")
local logo = verify:WaitForChild("PetIndex")

local spininfo = TweenInfo.new(2,Enum.EasingStyle.Linear)
local infoPosition = TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, -1, true)

Spin1 = TweenService:Create(logo,spininfo,{CFrame = logo.CFrame * CFrame.Angles(0,math.rad(120),0)})
Spin2 = TweenService:Create(logo,spininfo,{CFrame = logo.CFrame * CFrame.Angles(0,math.rad(240),0)})
Spin3 = TweenService:Create(logo,spininfo,{CFrame = logo.CFrame * CFrame.Angles(0,math.rad(360),0)})

Spin1:Play()
Spin1.Completed:Connect(function()Spin2:Play() end)
Spin2.Completed:Connect(function()Spin3:Play() end)
Spin3.Completed:Connect(function()Spin1:Play() end)
TweenService:Create(logo, infoPosition, {Position = logo.Position + Vector3.new(0, .5, 0)}):Play()