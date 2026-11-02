-- locals
local cloud1 = script.Parent.Clouds1

local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(
    1, --Time
    Enum.EasingStyle.Linear, --EasingStyle
    Enum.EasingDirection.Out, --EasingDirection
    0, --Repeat count
    false, --Reverses if true
    0 --Delay time
)
local tween = tweenService:Create(cloud1, tweenInfo, {Transparency = 1})
local tweenin = tweenService:Create(cloud1, tweenInfo, {Transparency = 0.347})
-----------------------------------
local cloud2 = script.Parent.Clouds2
cloud2.Transparency = 0.2
local tweenService2 = game:GetService("TweenService")
local tweenInfo2 = TweenInfo.new(
    1, --Time
    Enum.EasingStyle.Linear, --EasingStyle
    Enum.EasingDirection.Out, --EasingDirection
    0, --Repeat count
    false, --Reverses if true
    0 --Delay time
)
local tween2 = tweenService2:Create(cloud2, tweenInfo2, {Transparency = 1})
local tweenin2 = tweenService2:Create(cloud2, tweenInfo2, {Transparency = 0.2})
------------------------------------
local cloud3 = script.Parent.Clouds3
--setup
cloud3.Transparency = 1
--setup end
local tweenService3 = game:GetService("TweenService")
local tweenInfo3 = TweenInfo.new(
    1, --Time
    Enum.EasingStyle.Linear, --EasingStyle
    Enum.EasingDirection.Out, --EasingDirection
    0, --Repeat count
    false, --Reverses if true
    0 --Delay time
)
local tween3 = tweenService3:Create(cloud3, tweenInfo3, {Transparency = 1})
local tweenin3 = tweenService3:Create(cloud3, tweenInfo3, {Transparency = 0.2})
-------------------------------------

---cloud 1 movement
local function func1()
--print("looped1")
wait(0.2)
tween:Play()
wait(2)
tweenin:Play()
wait(2)
tween:Play() -- 6 secs
wait(2) 
tweenin:Play()
wait(2)
tween:Play()
wait(2)
tweenin:Play()
wait(2)
tween:Play() -- 14 secs
wait(2) 
tweenin:Play() -- 16 secs
wait(2)
tween:Play()
wait(2)
tweenin:Play()
wait(2)
tween:Play() 
wait(2)  
tweenin:Play() 
wait(2)
tween:Play() --26
end

---cloud 2 movement
local function func2()
--print("looped2")
tween2:Play()
wait(7) -- 6 secs
tweenin2:Play()
wait(7) -- 10 secs
tween2:Play()
wait(10) -- 26
end

-- cloud 3 movement
local function func3()
--print("looped3")
tweenin3:Play()
wait(7) 
tween3:Play()
wait(7)
tweenin3:Play()
wait(10)
tween3:Play()
end

while true do
spawn(func1)
spawn(func2)
spawn(func3)
wait(26)
end