local v_u_1 = require(script.Parent.FX_Modules.Tween)
local v_u_2 = require(script.Parent.FX_Modules.InteractSound)
local v_u_3 = {}
return function(p_u_4, p5)
	local v_u_6 = {}
	local v_u_7 = false
	local v_u_8 = false
	local v_u_9 = p5 or 1.05
	if v_u_3[p_u_4] then
		return function() end
	end
	v_u_3[p_u_4] = true
	local v10 = p_u_4:FindFirstChildOfClass("UIScale")
	if not v10 then
		v10 = Instance.new("UIScale")
		v10.Name = "ButtonUIScale"
		v10.Parent = p_u_4
	end
	local v_u_11 = v10
	local function v_u_12()
		if not v_u_7 then
			v_u_7 = true
			v_u_8 = false
			v_u_1(v_u_11, {
				["Scale"] = 0.9
			}, { 0.065, Enum.EasingStyle.Exponential, "Out" })
		end
	end
	local function v_u_13()
		if v_u_7 then
			v_u_7 = false
			v_u_1(v_u_11, {
				["Scale"] = 1
			}, { 0.25, Enum.EasingStyle.Circular, "Out" })
		end
	end
	local function v_u_14()
		if not (v_u_8 or v_u_7) then
			v_u_8 = true
			v_u_1(v_u_11, {
				["Scale"] = v_u_9
			}, { 0.05, Enum.EasingStyle.Circular, "Out" })
		end
	end
	local function v_u_15()
		if v_u_8 then
			v_u_8 = false
			v_u_1(v_u_11, {
				["Scale"] = 1
			}, { 0.035, Enum.EasingStyle.Exponential, "Out" })
		end
	end
	(function()
		v_u_6[#v_u_6 + 1] = p_u_4.InputBegan:Connect(function(p16)
			if p_u_4.Active and (p16.UserInputType == Enum.UserInputType.MouseButton1 or p16.UserInputType == Enum.UserInputType.Touch) then
				v_u_12()
			end
		end)
		v_u_6[#v_u_6 + 1] = p_u_4.InputEnded:Connect(function(p17)
			if p_u_4.Active and (p17.UserInputType == Enum.UserInputType.MouseButton1 or p17.UserInputType == Enum.UserInputType.Touch) then
				v_u_13()
			end
		end)
		v_u_6[#v_u_6 + 1] = p_u_4.MouseEnter:Connect(function()
			if p_u_4.Active and game.Players.LocalPlayer.PlayerGui:GetAttribute("Device") == "PC" then
				v_u_14()
			end
		end)
		v_u_6[#v_u_6 + 1] = p_u_4.MouseLeave:Connect(function()
			if p_u_4.Active and game.Players.LocalPlayer.PlayerGui:GetAttribute("Device") == "PC" then
				v_u_15()
			end
		end)
	end)()
	local v_u_18 = v_u_2(p_u_4, "mousedown", "rbxassetid://7000714975", 0.055, true)
	local v_u_19 = v_u_2(p_u_4, "mouseup", "rbxassetid://7000715003", 0.055, true)
	local v_u_20 = false
	local function v22()
		if not v_u_20 then
			v_u_20 = true
			for _, v21 in ipairs(v_u_6) do
				v21:Disconnect()
			end
			if v_u_11 and v_u_11.Parent then
				v_u_11.Scale = 1
			end
			v_u_18()
			v_u_19()
			v_u_3[p_u_4] = nil
		end
	end
	local v23 = p_u_4.Destroying
	table.insert(v_u_6, v23:Connect(v22))
	return v22
end
