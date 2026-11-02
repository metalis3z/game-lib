local TweenService = game:GetService("TweenService")
local part = game.Lighting
local colorCorrection = part.BloodHourColorCorrection
local tweenInfoColor = TweenInfo.new(13,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
local tweenInfoColor2 = TweenInfo.new(5,Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

workspace.BloodHourFog.Changed:Connect(function()
	local tween = TweenService:Create(part, tweenInfoColor, {FogColor = Color3.fromRGB(141, 141, 141) })
	local tween2 = TweenService:Create(colorCorrection, tweenInfoColor, {TintColor = Color3.fromRGB(255, 0, 0),Contrast = 1 })
	local tween5 = TweenService:Create(part, tweenInfoColor2, {FogColor = Color3.fromRGB(181, 181, 181) })
	local tween6 = TweenService:Create(colorCorrection, tweenInfoColor2, {TintColor = Color3.fromRGB(255, 255, 255),Contrast = 0 })
	if workspace.BloodHourFog.Value == 1 then
		tween:Play()
		tween2:Play()
	elseif workspace.BloodHourFog.Value == 2 then	
		tween5:Play()
		tween6:Play()
	end
	end)