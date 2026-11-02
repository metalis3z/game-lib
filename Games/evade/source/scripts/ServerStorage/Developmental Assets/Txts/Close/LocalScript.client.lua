-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = require(v1.Classes.AnimatedButton)
require(v1.Controllers.InterfaceController)
local v4 = script.Admin
v4.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.LeftCenter.LeftCenter.Buttons
local v5 = require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.GradientScroll)
v5(script.Parent.Parent.Parent.Parent.UIGradient, 10)
v5(script.Parent.Parent.Parent.Parent.UIStroke.UIGradient, 10)
v5(v4.UIGradient, 3)
local v_u_6 = false
local v_u_7 = true
local v_u_8 = UDim2.new(0.5, 0, 0.5, 0)
local v_u_9 = UDim2.new(0.5, 0, -1, 0)
script.Parent.Parent.Parent.Parent.Position = v_u_9
script.Parent.Parent.Parent.Parent.Visible = true
function Toggle()
	-- upvalues: (ref) v_u_7, (ref) v_u_6, (ref) v_u_8, (copy) v_u_9, (copy) v_u_2
	if v_u_7 then
		v_u_7 = false
		task.delay(0.2, function()
			-- upvalues: (ref) v_u_7
			v_u_7 = true
		end)
		if v_u_6 then
			v_u_8 = script.Parent.Parent.Parent.Parent.Position
			local v10 = {
				["Position"] = v_u_9
			}
			v_u_2:Create(script.Parent.Parent.Parent.Parent, TweenInfo.new(0.2, Enum.EasingStyle.Sine), v10):Play()
		else
			local v11 = {
				["Position"] = v_u_8
			}
			v_u_2:Create(script.Parent.Parent.Parent.Parent, TweenInfo.new(0.2, Enum.EasingStyle.Sine), v11):Play()
		end
		v_u_6 = not v_u_6
	end
end
local v12 = v3.new(v4)
v12:Animate()
v12.OnActivated:Connect(Toggle)
require(script.Parent.Parent.Parent.Parent.Content.CanvasGroup.List.ButtonFX)(script.Parent)
script.Parent.Activated:Connect(Toggle)
