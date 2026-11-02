-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("TweenService")
local v2 = require(script.Parent.Parent.Parent.Parent.CanvasGroup.List.ButtonFX)
local v_u_3 = script.Parent.Parent.Parent
v2(script.Parent)
script.Parent.Activated:Connect(function()
	-- upvalues: (copy) v_u_1, (copy) v_u_3
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
