

if script:IsDescendantOf(workspace) then
	local v_u_1 = script.Parent
	local function v_u_3()
		v_u_1.Rotation = 0
		local v2 = game:GetService("TweenService"):Create(v_u_1, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			["Rotation"] = 360
		})
		v2.Completed:Connect(v_u_3)
		v2:Play()
	end
	v_u_3()
end
