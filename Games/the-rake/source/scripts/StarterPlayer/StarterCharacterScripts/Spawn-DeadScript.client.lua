
local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
local spawned = ts:Create(game.Lighting.DeadEffect,tweenInfo,{Brightness = 0,Contrast = 0})
local died = ts:Create(game.Lighting.DeadEffect,tweenInfo,{Brightness = -1,Contrast = -0.5})

game.Lighting.DeadEffect.Brightness = -1
game.Lighting.DeadEffect.Contrast = -0.5
spawned:Play()

script.Parent.Humanoid.Died:Connect(function()
	died:Play()
	end)