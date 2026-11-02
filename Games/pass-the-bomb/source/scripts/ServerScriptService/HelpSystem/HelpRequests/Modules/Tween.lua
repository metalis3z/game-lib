--[[

	Documentation:
	# Tween Module
	---------------
	Author:
	@ lightyns
	---------------
	Basically my one serves all Tween module for UIs lol.
	---------------
	Last Edited:
	# 2021-02-21

--]]

--# Service
local TweenService = game:GetService("TweenService")

--# Variables
local tweenInfos = {
	Default = TweenInfo.new(
		3,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	Quick = TweenInfo.new(
		0.3,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	Reverse = TweenInfo.new(
		3,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out,
		0,
		true,
		1
	)
}

--# Module
local Tween = {}

function Tween.Regular(instance, properties)
	local tween = TweenService:Create(instance, tweenInfos.Default, properties)
	tween:Play()
	return tween
end

function Tween.Quick(instance, properties)
	local tween = TweenService:Create(instance, tweenInfos.Quick, properties)
	tween:Play()
	return tween
end

function Tween.Reverse(instance, properties)
	local tween = TweenService:Create(instance, tweenInfos.Reverse, properties)
	tween:Play()
	return tween
end

function Tween.CustomSpeed(speed, instance, properties)
	local tweenInfo = TweenInfo.new(
		speed,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	)
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	return tween
end

return Tween