local TweenService = game:GetService("TweenService")
local part = game.Lighting
local colorCorrection = part.MikeHourColorCorrection  
local tweenInfoColor = TweenInfo.new(13,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweenInfoColor2 = TweenInfo.new(8,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

workspace.MikeHourFog.Changed:Connect(function()
	local tween = TweenService:Create(part, tweenInfoColor, {FogColor = Color3.fromRGB(100,0,255) })
	local tween2 = TweenService:Create(colorCorrection, tweenInfoColor, {TintColor = Color3.fromRGB(200,150,255) })
	local tween4 = TweenService:Create(colorCorrection, tweenInfoColor, {Contrast = 0.08})
	local tween6 = TweenService:Create(part, tweenInfoColor2, {FogColor = Color3.fromRGB(141, 141, 141) })
	local tween7 = TweenService:Create(colorCorrection, tweenInfoColor2, {TintColor = Color3.fromRGB(255, 255, 255) })
	local tween9 = TweenService:Create(colorCorrection, tweenInfoColor, {Contrast = 0})
	if workspace.MikeHourFog.Value == 1 then
		tween:Play()
		tween2:Play()
		tween4:Play()
	elseif workspace.MikeHourFog.Value == 2 then	
		tween6:Play()
		tween7:Play()
		tween9:Play()
	end
	end)