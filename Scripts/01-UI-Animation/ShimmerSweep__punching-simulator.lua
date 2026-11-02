-- Reference copy for study. Game: Punching Simulator (punching-simulator)
-- Original: StarterGui/Main/Left/Content/Store/Effect/LocalScript.client.lua  (client, 14 lines)
-- Categories: n/a
-- What it does: The classic shine sweep: tween a UIGradient Offset from (-1,0) to (1,0) every 2 s, then snap back.

local period = 2
local effect = script.Parent
local TweenService = game:GetService("TweenService")
local TInfo = TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)

coroutine.wrap(function()
	while wait(period) do
		local tween = TweenService:Create(effect.UIGradient,TInfo,{Offset = Vector2.new(1,0)})
		tween:Play()
		tween.Completed:Connect(function()
			effect.UIGradient.Offset = Vector2.new(-1,0)
		end)
	end
end)()