


local v_u_1 = game:GetService("TweenService")
local v2 = require(script.Parent.Parent.Parent.Parent.CanvasGroup.List.ButtonFX)
local v_u_3 = script.Parent.Parent.Parent
v2(script.Parent)
script.Parent.Activated:Connect(function()
	v_u_1:Create(v_u_3, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["BackgroundTransparency"] = 1
	}):Play()
	v_u_1:Create(v_u_3.Frame.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
		["Scale"] = 0
	}):Play()
	task.delay(0.2, function()
		script.Parent.Parent.Parent.Visible = false
		script.Parent.Parent.Parent.Parent.CanvasGroup.List.ClipsDescendants = false
	end)
end)
