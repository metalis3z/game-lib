game:GetService("RunService").RenderStepped:Connect(function()
	script.Parent.Size = UDim2.fromScale(workspace.RobuxHammerGiant.DiamondHammer.Handle.BaseCenter.Impact_Impact.PlaybackLoudness * 0.01,0,workspace.RobuxHammerGiant.DiamondHammer.Handle.BaseCenter.Impact_Impact.PlaybackLoudness * 0.01,0)
end)