-- made by trogspidr :)

local TS = game:GetService("TweenService")

local TargetGUI = script.Parent.Parent.SpectateMain -- the gui that is getting moved/tweened
local Button = script.Parent -- the button that will activiate the tween
local TweenTime = 1.3 -- the time the tween takes
local EasingStyle = Enum.EasingStyle.Back -- to know what a easing style is go to roblox dev forum!

local DefaultPos = UDim2.new(8.5, 0, 2.5, 0) -- swap 0,0,0 with the position where the gui will reset back to
local TargetPos = UDim2.new(8.5, 0, 1.5, 0) -- swap 0,0,0 with the position where the gui will move to

local Tween1 = TS:Create(TargetGUI, TweenInfo.new(TweenTime, EasingStyle), { Position = TargetPos } )
local Tween2 = TS:Create(TargetGUI, TweenInfo.new(TweenTime, EasingStyle), { Position = DefaultPos } )

local Toggle = false

TargetGUI.Position = DefaultPos

Button.MouseButton1Click:Connect(function()
	if Toggle == false then
		Tween1:Play()
		Toggle = true
	else
		Tween2:Play()
		Toggle = false
	end
end)