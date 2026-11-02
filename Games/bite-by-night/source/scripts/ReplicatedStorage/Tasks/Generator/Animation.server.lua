-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

script.Parent:GetAttributeChangedSignal("Progress"):Connect(function()
	if script.Parent:GetAttribute("Progress") >= 100 then
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake["Fan.L"], TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 999999), {
			["Transform"] = script.Parent.RootPart.BoxShake["Fan.L"].Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake["Fan.R"], TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 999999), {
			["Transform"] = script.Parent.RootPart.BoxShake["Fan.R"].Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake.FanUpper, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 999999), {
			["Transform"] = script.Parent.RootPart.BoxShake.FanUpper.Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
	else
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake["Fan.L"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Transform"] = script.Parent.RootPart.BoxShake["Fan.L"].Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake["Fan.R"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Transform"] = script.Parent.RootPart.BoxShake["Fan.R"].Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.RootPart.BoxShake.FanUpper, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["Transform"] = script.Parent.RootPart.BoxShake.FanUpper.Transform * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 0)
		}):Play()
	end
end)