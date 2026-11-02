-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("TweenService")
function AnimateButton(p2, p3)
	-- upvalues: (copy) v_u_1
	v_u_1:Create(script.Parent, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
		["Rotation"] = p2
	}):Play()
	v_u_1:Create(script.Parent.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
		["Scale"] = p3
	}):Play()
end
script.Parent.MouseEnter:Connect(function()
	AnimateButton(-15, 1.1)
end)
script.Parent.MouseLeave:Connect(function()
	AnimateButton(0, 1)
end)
script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Visible = false
end)
