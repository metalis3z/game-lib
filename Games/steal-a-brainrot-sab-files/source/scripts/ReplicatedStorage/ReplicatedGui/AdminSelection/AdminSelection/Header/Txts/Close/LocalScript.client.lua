local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
require(v1.Classes.AnimatedButton)
require(v1.Controllers.InterfaceController)
local v3 = require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll)
v3(script.Parent.Parent.Parent.Parent.UIGradient, 10)
v3(script.Parent.Parent.Parent.Parent.UIStroke.UIGradient, 10)
v3(script.Parent.Parent.Parent.Parent.Search.UIStroke.UIGradient, 10)
local v_u_4 = false
local v_u_5 = true
local v_u_6 = UDim2.new(0.5, 0, 0.5, 0)
local v_u_7 = UDim2.new(0.5, 0, -1, 0)
script.Parent.Parent.Parent.Parent.Position = v_u_7
script.Parent.Parent.Parent.Parent.Visible = true

function Toggle(p8)
	if v_u_5 then
		v_u_5 = false
		task.delay(0.2, function()
			v_u_5 = true
		end)
		if v_u_4 ~= p8 then
			if p8 ~= nil then
				v_u_4 = not p8
			end
			if v_u_4 then
				v_u_6 = script.Parent.Parent.Parent.Parent.Position
				local closeTween = v_u_2:Create(
					script.Parent.Parent.Parent.Parent,
					TweenInfo.new(0.2, Enum.EasingStyle.Sine),
					{ Position = v_u_7 }
				)
				closeTween:Play()
				closeTween.Completed:Once(function()
					if _G.AdminCleanupButtons then
						_G.AdminCleanupButtons()
					end
				end)
			else
				if _G.AdminRepopulate then
					_G.AdminRepopulate()
				end
				local v10 = {
					["Position"] = v_u_6
				}
				v_u_2:Create(script.Parent.Parent.Parent.Parent, TweenInfo.new(0.2, Enum.EasingStyle.Sine), v10):Play()
			end
			v_u_4 = not v_u_4
		end
	else
		return
	end
end

_G.AdminSelectionToggle = Toggle
require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.Main.ButtonFX)(script.Parent)
script.Parent.Activated:Connect(function()
	Toggle()
end)