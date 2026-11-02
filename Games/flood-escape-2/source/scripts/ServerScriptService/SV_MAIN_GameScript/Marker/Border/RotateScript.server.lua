local TweenService = game:GetService("TweenService")

local Border = script.Parent

if Border ~= nil then
	local _TweenInfo = TweenInfo.new(
		5,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.In,
		0,
		false
	)

	local Tween_Forward : Tween = TweenService:Create(Border, _TweenInfo, {Rotation = 360})
	local Tween_Back : Tween = TweenService:Create(Border, _TweenInfo, {Rotation = -360})

	task.spawn(function()
		while true do
			if Border ~= nil then
				Tween_Forward:Play()
				repeat task.wait() until Tween_Forward.PlaybackState == Enum.PlaybackState.Completed
				Tween_Back:Play()
				repeat task.wait() until Tween_Back.PlaybackState == Enum.PlaybackState.Completed
			end
		end
	end)
end