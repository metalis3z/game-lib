local button = script.Parent.Button
local door1 = script.Parent.Door1
local door2 = script.Parent.Door2
local tweenInfo = TweenInfo.new(1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out)
local tweenService = game:GetService("TweenService")
local state = nil
local debounce = false

local open1 = tweenService:Create(door1, tweenInfo, {CFrame = script.Parent.Door1End.CFrame})
local open2 = tweenService:Create(door2, tweenInfo, {CFrame = script.Parent.Door2End.CFrame})
local close1 = tweenService:Create(door1, tweenInfo, {CFrame = door1.CFrame})
local close2 = tweenService:Create(door2, tweenInfo, {CFrame = door2.CFrame})

local function onClicked(player)
	if not debounce then
		if state == nil or state == "Closed" then
			debounce = true
			state = "Open"
			button.BrickColor = BrickColor.new("Really red")
			open1:Play()
			open2:Play()
			wait(3)
			close1:Play()
			close2:Play()
			wait(7)
			button.Color = Color3.fromRGB(0,255,0)
			debounce = false
			state = "Closed"
		end
	end
end

button.ClickDetector.MouseClick:Connect(onClicked)