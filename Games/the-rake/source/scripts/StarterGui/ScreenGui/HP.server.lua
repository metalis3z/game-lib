local ts = game:GetService("TweenService")
local tweeninf = TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local invisbar1 = ts:Create(script.Parent.Health.Bar,tweeninf,{BackgroundTransparency = 1})
local invisbar2 = ts:Create(script.Parent.Health,tweeninf,{BackgroundTransparency = 1})
local invisbar3 = ts:Create(script.Parent.ImageLabelHP,tweeninf,{BackgroundTransparency = 1})
local invisbar4 = ts:Create(script.Parent.ImageLabelHP,tweeninf,{ImageTransparency = 1})
local appearbar1 = ts:Create(script.Parent.Health.Bar,tweeninf,{BackgroundTransparency = 0})
local appearbar2 = ts:Create(script.Parent.Health,tweeninf,{BackgroundTransparency = 0.3})
local appearbar3 = ts:Create(script.Parent.ImageLabelHP,tweeninf,{BackgroundTransparency = 0.3})
local appearbar4 = ts:Create(script.Parent.ImageLabelHP,tweeninf,{ImageTransparency = 0})

function _G.round(n)
return n - math.floor(n) >= 0.5 and math.ceil(n) or n - math.floor(n) < 0.5 and math.floor(n)
end

wait(0.5)
local char = script.Parent.Parent.Parent.Character
local hum = char.Humanoid
local Round = (_G.round(hum.Health))

hum.Changed:connect(function()
script.Parent.Health.Bar.Size = UDim2.new(hum.Health/hum.MaxHealth,0,1,0)
Round = (_G.round(hum.Health))

if hum.Health <= hum.MaxHealth*0.99  then
	appearbar1:Play()
	appearbar2:Play()
	appearbar3:Play()
	appearbar4:Play()
end

if hum.Health >= hum.MaxHealth*0.99 then
	invisbar1:Play()
	invisbar2:Play()
	invisbar3:Play()
	invisbar4:Play()
end
end)
