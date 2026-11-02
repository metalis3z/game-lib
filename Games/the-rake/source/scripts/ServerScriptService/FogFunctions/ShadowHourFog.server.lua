local TweenService = game:GetService("TweenService")
local part = game.Lighting
local colorCorrection = part.ShadowHourColorCorrection  
local tweenInfoColor = TweenInfo.new(10,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweenInfoColor2 = TweenInfo.new(5,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

workspace.ShadowHourFog.Changed:Connect(function()
	local tween = TweenService:Create(part, tweenInfoColor, {FogColor = Color3.fromRGB(0, 0, 0) })
	local tween2 = TweenService:Create(part, tweenInfoColor, {Brightness = 4})
	local tween3 = TweenService:Create(colorCorrection, tweenInfoColor, {Brightness = -0.02})
	local tween4 = TweenService:Create(colorCorrection, tweenInfoColor, {Contrast = 0.04})
	local tween5 = TweenService:Create(part, tweenInfoColor, {ClockTime = 0})
	local tween6 = TweenService:Create(part, tweenInfoColor2, {FogColor = Color3.fromRGB(141, 141, 141) })
	local tween7 = TweenService:Create(part, tweenInfoColor, {Brightness = 2})
	local tween8 = TweenService:Create(colorCorrection, tweenInfoColor, {Brightness = 0})
	local tween9 = TweenService:Create(colorCorrection, tweenInfoColor, {Contrast = 0})
	local tween10 = TweenService:Create(part, tweenInfoColor, {ClockTime = 15})
	if workspace.ShadowHourFog.Value == 1 then
		tween:Play()
		tween2:Play()
		tween3:Play()
		tween4:Play()
		tween5:Play()
	elseif workspace.ShadowHourFog.Value == 2 then	
		tween6:Play()
		tween7:Play()
		tween8:Play()
		tween9:Play()
		tween10:Play()
	end
	end)