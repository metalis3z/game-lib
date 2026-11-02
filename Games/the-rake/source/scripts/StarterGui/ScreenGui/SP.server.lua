local ts = game:GetService("TweenService")
local tweeninf = TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local invisbar1 = ts:Create(script.Parent.Stamina.Bar,tweeninf,{BackgroundTransparency = 1})
local invisbar2 = ts:Create(script.Parent.Stamina,tweeninf,{BackgroundTransparency = 1})
local invisbar3 = ts:Create(script.Parent.ImageLabelSP,tweeninf,{BackgroundTransparency = 1})
local invisbar4 = ts:Create(script.Parent.ImageLabelSP,tweeninf,{ImageTransparency = 1})
local appearbar1 = ts:Create(script.Parent.Stamina.Bar,tweeninf,{BackgroundTransparency = 0})
local appearbar2 = ts:Create(script.Parent.Stamina,tweeninf,{BackgroundTransparency = 0.3})
local appearbar3 = ts:Create(script.Parent.ImageLabelSP,tweeninf,{BackgroundTransparency = 0.3})
local appearbar4 = ts:Create(script.Parent.ImageLabelSP,tweeninf,{ImageTransparency = 0})

local plr = script.Parent.Parent.Parent
local char = plr.Character
local humanoid = char:FindFirstChild("Humanoid")

function _G.round(n)
return n - math.floor(n) >= 0.5 and math.ceil(n) or n - math.floor(n) < 0.5 and math.floor(n)
end

local Round = (_G.round(char.StaminaBar.Stamina.Value))

char.StaminaBar.Stamina.Changed:Connect(function()
	script.Parent.Stamina.Bar.Size = UDim2.new(char.StaminaBar.Stamina.Value/char.StaminaBar.MaxStamina.Value,0,1,0)
	Round = (_G.round(char.StaminaBar.Stamina.Value))
	
	if char.StaminaBar.Stamina.Value <= char.StaminaBar.MaxStamina.Value*0.99 then
		appearbar1:Play()
		appearbar2:Play()
		appearbar3:Play()
		appearbar4:Play()
	end	

	if char.StaminaBar.Stamina.Value >= char.StaminaBar.MaxStamina.Value*0.99 then
		invisbar1:Play()
		invisbar2:Play()
		invisbar3:Play()
		invisbar4:Play()
end
end)


