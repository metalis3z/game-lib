local v_u_1 = require(script.Parent.FX_Modules.Tween)
return function(p_u_2, p3, p4, p_u_5)
	local v_u_6 = p3 or 1.75
	local v_u_7 = p4 or 1
	local v_u_8 = p_u_2:FindFirstAncestorOfClass("ScreenGui") or (p_u_2:FindFirstAncestorOfClass("BillboardGui") or p_u_2:FindFirstAncestorOfClass("SurfaceGui"))
	if not v_u_8 then
		return function() end
	end
	assert(v_u_8)
	local v9 = p_u_2:FindFirstChild("ShimmerImage")
	if v9 then
		v9.Visible = true
	end
	local v_u_10 = v9 or script.Shimmer:Clone()
	local v_u_11 = v_u_10:FindFirstChild("UIGradient")
	v_u_10.Parent = p_u_2
	local function v_u_12()
		v_u_11.Offset = Vector2.new(-1, 0)
		v_u_1(v_u_11, {
			["Offset"] = Vector2.new(1, 0)
		}, { v_u_7, "Quad", "InOut" })
	end
	local v_u_13 = false
	task.spawn(function()
		if p_u_5 then
			v_u_12()
			task.wait(v_u_7)
			if v_u_12 then
				v_u_12.Visible = false
			else
				v_u_10:Destroy()
			end
		else
			while not v_u_13 and p_u_2.Parent do
				if v_u_8.Enabled then
					v_u_12()
				end
				wait(v_u_6)
			end
			return
		end
	end)
	return function()
		if v_u_12 then
			v_u_12.Visible = false
		else
			v_u_10:Destroy()
		end
		v_u_13 = true
	end
end
