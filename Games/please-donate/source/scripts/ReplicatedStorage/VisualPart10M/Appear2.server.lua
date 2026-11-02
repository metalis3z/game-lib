local VisualPart = script.Parent
VisualPart.ApplauseLoop:Play()
	VisualPart.ChimeLoop:Play()
	VisualPart.CoinsLoop:Play()
	game.TweenService:Create(VisualPart,TweenInfo.new(15),{Position = Vector3.new(28.857, 270, 110.348)}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.RobuxLogo, TweenInfo.new(10, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0), {
		Size = UDim2.fromScale(1, 1)
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.RobuxLogo, TweenInfo.new(15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0), {
		Rotation = 0
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.Star, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0), {
		Size = UDim2.fromScale(1.5, 1.5)
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.Star, TweenInfo.new(15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
		Rotation = 360
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.BottomText, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.6), {
		Size = UDim2.fromScale(1.5, 0.1), 
		Position = UDim2.fromScale(0.5, 0.59)
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.MiddleText, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.4), {
		Size = UDim2.fromScale(1, 1)
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.TopText, TweenInfo.new(5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0.2), {
		Size = UDim2.fromScale(1.5, 0.1), 
		Position = UDim2.fromScale(0.5, 0.41)
	}):Play()
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame.Star, TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 5), {
		ImageTransparency = 1, 
		ImageColor3 = Color3.fromRGB(0, 255, 255)
	}):Play()
	wait(25)
	game:GetService("TweenService"):Create(VisualPart.BillboardGuiAnimation.Frame, TweenInfo.new(15, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
		Size = UDim2.fromScale(0,0)
}):Play()
game:GetService("TweenService"):Create(VisualPart.Attachment.ParticleEmitter, TweenInfo.new(15, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
	Rate = 0
}):Play()
game:GetService("TweenService"):Create(VisualPart.ApplauseLoop, TweenInfo.new(17, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
	Volume = 0
}):Play()
game:GetService("TweenService"):Create(VisualPart.ChimeLoop, TweenInfo.new(17, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
	Volume = 0
}):Play()
game:GetService("TweenService"):Create(VisualPart.CoinsLoop, TweenInfo.new(17, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, 0.2), {
	Volume = 0
}):Play()