local ts = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local red = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(255, 0, 0)})
local pink = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(255, 0, 255)})
local green = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(0, 255, 0)})
local blue = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(0, 0, 255)})
local cyan = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(0, 255, 255)})
local yellow = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(255, 255, 0)})
local orange = ts:Create(script.Parent,tweeninfo,{Color = Color3.fromRGB(255, 85, 0)})
local Debounce = false

while wait() do
	if Debounce == false then
		Debounce = true
		red:Play()
		wait(1)
		pink:Play()
		wait(1)
		green:Play()
		wait(1)
		blue:Play()
		wait(1)
		cyan:Play()
		wait(1)
		yellow:Play()
		wait(1)
		orange:Play()
		wait(1)
		Debounce = false
	end
end