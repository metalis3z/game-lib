-- Script by XcorrectTheDev

local AnimDebounce = false
local Mouth = script.Parent
local Mouth1_2 = script.Parent.Parent.Mouth1_2

local tweenService = game:GetService("TweenService")

-- Mouth Animtion

local SizeState1 = {
	Size = Vector3.new(0.72, 0.582, 0.826)
}
local SizeState2 = {
	Size = Vector3.new(0.72, 0.582, 0.686)
}
local SizeState3 = {
	Size = Vector3.new(0.72, 0.582, 0.426)
}
local SizeState4 = {
	Size = Vector3.new(0.72, 0.582, 0.166)
}
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local Size1 = tweenService:Create(Mouth,TweenInfoo,SizeState1)
local Size2 = tweenService:Create(Mouth,TweenInfoo,SizeState2)
local Size3 = tweenService:Create(Mouth,TweenInfoo,SizeState3)
local Size4 = tweenService:Create(Mouth,TweenInfoo,SizeState4)
local Size1_2 = tweenService:Create(Mouth1_2,TweenInfoo,SizeState1)
local Size2_2 = tweenService:Create(Mouth1_2,TweenInfoo,SizeState2)
local Size3_2 = tweenService:Create(Mouth1_2,TweenInfoo,SizeState3)
local Size4_2 = tweenService:Create(Mouth1_2,TweenInfoo,SizeState4)
while true do
if not AnimDebounce then
AnimDebounce = true
for i = 1,math.random(1,5) do
			Size4:Play()
			Size4_2:Play()
			wait(5)
			Size2:Play()
			Size2_2:Play()
			wait(0.05)
			Size4:Play()
			Size4_2:Play()
			wait(2)
			Size3:Play()
			Size3_2:Play()
wait(math.random(0.05,1))
end
wait(math.random(8,16))
AnimDebounce = false
end
end