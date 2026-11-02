return function(p1, p2, p_u_3, p4, p5)
	local v_u_6 = {}
	local v7 = string.lower(p2)
	local v_u_8 = p4 or 0.15
	local v_u_9
	if p5 == nil then
		v_u_9 = false
	else
		v_u_9 = p5 or false
	end
	local function v_u_11()
		local v_u_10 = Instance.new("Sound")
		v_u_10.Parent = script
		v_u_10.SoundId = p_u_3
		v_u_10.PlaybackSpeed = v_u_9 and math.random(95, 105) / 100 or 1
		v_u_10.Volume = v_u_8 * 2
		v_u_10:Play()
		v_u_10.Played:Connect(function()
			v_u_10:Destroy()
		end)
	end
	if v7 == "mousedown" then
		v_u_6[#v_u_6 + 1] = p1.InputBegan:Connect(function(p12)
			if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch and p12.UserInputState == Enum.UserInputState.Begin or p12.KeyCode == Enum.KeyCode.ButtonA then
				v_u_11()
			end
		end)
	elseif v7 == "mouseup" then
		v_u_6[#v_u_6 + 1] = p1.InputEnded:Connect(function(p13)
			if p13.UserInputType == Enum.UserInputType.MouseButton1 or p13.UserInputType == Enum.UserInputType.Touch and p13.UserInputState == Enum.UserInputState.End or p13.KeyCode == Enum.KeyCode.ButtonA then
				v_u_11()
			end
		end)
	elseif v7 == "mouseenter" then
		v_u_6[#v_u_6 + 1] = p1.MouseEnter:Connect(function()
			v_u_11()
		end)
	elseif v7 == "mouseleave" then
		v_u_6[#v_u_6 + 1] = p1.MouseLeave:Connect(function()
			v_u_11()
		end)
	elseif v7 == "mouseclick" then
		v_u_6[#v_u_6 + 1] = p1.Activated:Connect(function()
			v_u_11()
		end)
	end
	return function()
		for _, v14 in ipairs(v_u_6) do
			v14:Disconnect()
		end
	end
end
