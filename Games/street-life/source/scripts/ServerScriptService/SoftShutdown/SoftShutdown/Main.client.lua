local blur = Instance.new("BlurEffect")
blur.Parent = game.Lighting
blur.Size = 0
game:GetService("TweenService"):Create(blur, TweenInfo.new(.5, Enum.EasingStyle.Quint), {Size = 24}):Play()