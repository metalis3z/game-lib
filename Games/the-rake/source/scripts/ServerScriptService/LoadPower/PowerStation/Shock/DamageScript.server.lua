local TweenService = game:GetService("TweenService")
local Info1 = TweenInfo.new(0.7,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
local ActiveTween = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(144, 147, 166)})
local DeactiveTween = TweenService:Create(script.Parent,Info1,{Color = Color3.fromRGB(91, 93, 105)})

local ZapParticle = script.Parent.ZapParticle
local ZapParticle2 = script.Parent.ZapParticle2

local Debounce = false 
local Active = false
local Damage = 20

ZapParticle.Enabled = false
ZapParticle2.Enabled = false

script.Parent.Touched:Connect(function(Part)
if Part.Parent ~= nil then
if Debounce == false and Part.Parent:findFirstChild("Humanoid") ~= nil and Active == true then 
Debounce = true
script.Parent.GetShocked:Play()
ZapParticle2.Enabled = true
Part.Parent:findFirstChild("Humanoid"):TakeDamage(Damage) 
wait(1)
Debounce = false 
end 
end 
end)

while wait() do
	wait(2)
	Active = true
	ActiveTween:Play()
	ZapParticle.Enabled = true
	wait(1)
	Active = false
	DeactiveTween:Play()
	ZapParticle.Enabled = true
	ZapParticle2.Enabled = false
end