-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
return function(p_u_2, p3)
	-- upvalues: (copy) v_u_1
	local v_u_4 = {}
	local v_u_5 = false
	local v_u_6 = false
	local v_u_7 = p3 or 1.05
	if v_u_1[p_u_2] then
		return function() end
	end
	v_u_1[p_u_2] = true
	local v8 = p_u_2:IsA("ImageButton")
	if v8 then
		v8 = p_u_2.Image == "rbxassetid://12026054177"
	end
	local v_u_9 = nil
	if v8 then
		for _, v10 in p_u_2:GetChildren() do
			if v10:IsA("TextLabel") and v10.Text == "X" then
				v_u_9 = v10
				break
			end
		end
	end
	local v_u_11 = nil
	if v_u_9 and not v_u_9:FindFirstChildOfClass("UIScale") then
		v_u_11 = Instance.new("UIScale")
		v_u_11.Name = "ButtonUIScale"
		v_u_11.Parent = v_u_9
	elseif v_u_9 and v_u_9:FindFirstChildOfClass("UIScale") then
		v_u_11 = v_u_9:FindFirstChildOfClass("UIScale")
	end
	local v_u_12 = p_u_2:FindFirstChildOfClass("UIScale")
	if not v_u_12 then
		v_u_12 = Instance.new("UIScale")
		v_u_12.Name = "ButtonUIScale"
		v_u_12.Parent = p_u_2
	end
	local v13 = v_u_12
	assert(v13)
	local function v_u_14()
		-- upvalues: (ref) v_u_5, (ref) v_u_6, (ref) v_u_12, (ref) v_u_11, (ref) v_u_9
		if not v_u_5 then
			v_u_5 = not v_u_5
			v_u_6 = false
			require(script.Tween)(v_u_12, {
				["Scale"] = 0.9
			}, { 0.065, Enum.EasingStyle.Exponential, "Out" })
			if v_u_11 then
				require(script.Tween)(v_u_11, {
					["Scale"] = 0.9
				}, { 0.065, Enum.EasingStyle.Exponential, "Out" })
				require(script.Tween)(v_u_9, {
					["Position"] = UDim2.new(0.5, 0, 0.6, 0)
				}, { 0.065, Enum.EasingStyle.Exponential, "Out" })
			end
		end
	end
	local function v_u_15()
		-- upvalues: (ref) v_u_5, (ref) v_u_12, (ref) v_u_11, (ref) v_u_9
		if v_u_5 then
			v_u_5 = not v_u_5
			require(script.Tween)(v_u_12, {
				["Scale"] = 1
			}, { 0.25, Enum.EasingStyle.Circular, "Out" })
			if v_u_11 then
				require(script.Tween)(v_u_11, {
					["Scale"] = 1
				}, { 0.25, Enum.EasingStyle.Circular, "Out" })
				require(script.Tween)(v_u_9, {
					["Position"] = UDim2.new(0.5, 0, 0.5, 0)
				}, { 0.25, Enum.EasingStyle.Circular, "Out" })
			end
		end
	end
	local function v_u_16()
		-- upvalues: (ref) v_u_6, (ref) v_u_5, (ref) v_u_12, (ref) v_u_11, (ref) v_u_9
		if v_u_6 then
			v_u_6 = not v_u_6
			if v_u_5 then
				if v_u_5 and v_u_11 then
					require(script.Tween)(v_u_9, {
						["Position"] = UDim2.new(0.5, 0, 0.5, 0)
					}, { 0.035, Enum.EasingStyle.Circular, "Out" })
				end
			else
				require(script.Tween)(v_u_12, {
					["Scale"] = 1
				}, { 0.035, Enum.EasingStyle.Exponential, "Out" })
				if v_u_11 then
					require(script.Tween)(v_u_11, {
						["Scale"] = 1
					}, { 0.035, Enum.EasingStyle.Exponential, "Out" })
					return
				end
			end
		end
	end
	local function v_u_19()
		-- upvalues: (ref) v_u_6, (ref) v_u_5, (ref) v_u_12, (copy) v_u_7, (ref) v_u_11
		if not v_u_6 then
			v_u_6 = not v_u_6
			if not v_u_5 then
				local v17 = {
					["Scale"] = v_u_7
				}
				require(script.Tween)(v_u_12, v17, { 0.05, Enum.EasingStyle.Circular, "Out" })
				if v_u_11 then
					local v18 = {
						["Scale"] = v_u_7
					}
					require(script.Tween)(v_u_11, v18, { 0.05, Enum.EasingStyle.Circular, "Out" })
				end
			end
		end
	end
	(function()
		-- upvalues: (copy) v_u_4, (copy) p_u_2, (copy) v_u_14, (copy) v_u_15, (copy) v_u_19, (copy) v_u_16
		v_u_4[#v_u_4 + 1] = p_u_2.InputBegan:Connect(function(p20)
			-- upvalues: (ref) p_u_2, (ref) v_u_14
			if p_u_2.Active then
				local v21 = p20.UserInputType
				local v22 = p20.UserInputState
				local v23 = p20.KeyCode
				if v21 == Enum.UserInputType.MouseButton1 or v21 == Enum.UserInputType.Touch and v22 == Enum.UserInputState.Begin or v23 == Enum.KeyCode.ButtonA then
					v_u_14()
				end
			end
		end)
		v_u_4[#v_u_4 + 1] = p_u_2.InputEnded:Connect(function(p24)
			-- upvalues: (ref) p_u_2, (ref) v_u_15
			if p_u_2.Active then
				local v25 = p24.UserInputType
				local _ = p24.UserInputState
				local v26 = p24.KeyCode
				if v25 == Enum.UserInputType.MouseButton1 or (v25 == Enum.UserInputType.Touch or v26 == Enum.KeyCode.ButtonA) then
					v_u_15()
				end
			end
		end)
		v_u_4[#v_u_4 + 1] = p_u_2.MouseEnter:Connect(function()
			-- upvalues: (ref) p_u_2, (ref) v_u_19
			if p_u_2.Active then
				v_u_19()
			end
		end)
		v_u_4[#v_u_4 + 1] = p_u_2.MouseLeave:Connect(function()
			-- upvalues: (ref) p_u_2, (ref) v_u_16
			if p_u_2.Active then
				v_u_16()
			end
		end)
	end)()
	local v_u_27 = false
	local function v_u_29()
		-- upvalues: (ref) v_u_27, (copy) v_u_4, (ref) v_u_12, (ref) v_u_11, (ref) v_u_9, (ref) v_u_1, (copy) p_u_2
		if not v_u_27 then
			v_u_27 = true
			for _, v28 in ipairs(v_u_4) do
				v28:Disconnect()
			end
			if v_u_12 and v_u_12.Parent then
				v_u_12.Scale = 1
			end
			if v_u_11 then
				v_u_9.Position = UDim2.new(0.5, 0, 0.5, 0)
				v_u_11.Scale = 1
			end
			v_u_1[p_u_2] = nil
		end
	end
	local v30 = p_u_2.Destroying
	table.insert(v_u_4, v30:Connect(function()
		-- upvalues: (copy) v_u_29
		v_u_29()
	end))
	return v_u_29
end
