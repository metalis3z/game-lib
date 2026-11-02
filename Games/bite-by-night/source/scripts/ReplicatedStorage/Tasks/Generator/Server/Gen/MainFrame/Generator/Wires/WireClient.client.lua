-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:GetMouse()
local v_u_6 = script.Parent
local v7 = v_u_6.AbsoluteSize.X ^ 2 + v_u_6.AbsoluteSize.Y ^ 2
local v_u_8 = math.sqrt(v7) * 1.15
local v9 = next
local v10, v11 = v_u_6.WiresStart:GetChildren()
for _, v12 in v9, v10, v11 do
	local v_u_13 = v_u_6.WireBoxes[v12.Name]
	local v_u_14 = v_u_6.WiresEnd[v12.Name]
	local v_u_15 = v_u_6[v12.Name]
	local v_u_16 = v_u_14.AbsolutePosition - v_u_6.AbsolutePosition + v_u_14.AbsoluteSize / 2
	local v_u_17 = v12.AbsolutePosition - v_u_6.AbsolutePosition + v12.AbsoluteSize / 2
	local v_u_18 = true
	local v_u_19 = nil
	local v_u_20 = nil
	local v_u_21 = 0
	local v_u_22 = 0
	local function v_u_45(p23, p24, p25)
		-- upvalues: (copy) v_u_15, (copy) v_u_17, (copy) v_u_8, (ref) v_u_21, (ref) v_u_22, (copy) v_u_6, (copy) v_u_14
		local v26 = v_u_15:GetControlPoints()
		local v27 = #v26
		v26[1].Position = UDim2.fromOffset(v_u_17.X, v_u_17.Y)
		v26[#v26].Position = UDim2.fromOffset(p23, p24)
		local v28 = p23 - v_u_17.X
		local v29 = p24 - v_u_17.Y
		local v30 = v28 ^ 2 + v29 ^ 2
		local v31 = math.sqrt(v30) / v_u_8
		local v32 = math.clamp(v31, 0, 1)
		v_u_22 = v_u_22 + ((1 - v31) * 150 * v32 - v_u_21) * 150 * p25
		local v33 = v_u_22
		local v34 = p25 * -2
		v_u_22 = v33 * math.exp(v34)
		v_u_21 = v_u_21 + v_u_22 * p25
		local v35 = v_u_21
		local v36 = v27 - 2
		for v37 = 1, v36 do
			local v38 = v37 / (v36 + 1)
			local v39 = v28 * v38 + v_u_17.X
			local v40 = v29 * v38 + v_u_17.Y + v35 * (v38 * 4 * (1 - v38))
			local v41 = v_u_6.AbsoluteSize.X - v_u_14.AbsoluteSize.X - 16
			local v42 = math.clamp(v39, 16, v41)
			local v43 = v_u_6.AbsoluteSize.Y - v_u_14.AbsoluteSize.Y - 16
			local v44 = math.clamp(v40, 16, v43)
			v26[v37 + 1].Position = UDim2.fromOffset(v42, v44)
		end
		v_u_15:SetControlPoints(v26)
		v_u_15.Visible = true
	end
	local function v_u_54()
		-- upvalues: (ref) v_u_19, (ref) v_u_20, (copy) v_u_14, (copy) v_u_16, (copy) v_u_2, (copy) v_u_45, (copy) v_u_15, (ref) v_u_21, (ref) v_u_22
		if v_u_19 then
			v_u_19:Disconnect()
			v_u_19 = nil
		end
		if v_u_20 then
			v_u_20:Disconnect()
		end
		local v46 = v_u_14.Position
		local v_u_47 = Vector2.new(v46.X.Offset, v46.Y.Offset)
		local v_u_48 = v_u_16
		local v_u_49 = 0
		v_u_20 = v_u_2.Heartbeat:Connect(function(p50)
			-- upvalues: (ref) v_u_49, (copy) v_u_47, (copy) v_u_48, (ref) v_u_14, (ref) v_u_45, (ref) v_u_20, (ref) v_u_15, (ref) v_u_21, (ref) v_u_22
			v_u_49 = v_u_49 + p50
			local v51 = v_u_49 / 0.25
			local v52 = math.clamp(v51, 0, 1)
			local v53 = v_u_47:Lerp(v_u_48, 1 - (1 - v52) ^ 3)
			v_u_14.Position = UDim2.fromOffset(v53.X, v53.Y)
			v_u_45(v53.X, v53.Y, p50)
			if v52 >= 1 then
				v_u_20:Disconnect()
				v_u_15.Visible = false
				v_u_21 = 0
				v_u_22 = 0
			end
		end)
	end
	v_u_14.Hitbox.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_18, (ref) v_u_19, (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4, (copy) v_u_13, (copy) v_u_6, (copy) v_u_14, (copy) v_u_45, (ref) v_u_22, (copy) v_u_54, (copy) v_u_17, (copy) v_u_8
		if v_u_18 then
			if v_u_19 then
				v_u_19:Disconnect()
			end
			v_u_19 = v_u_2.Heartbeat:Connect(function(p55)
				-- upvalues: (ref) v_u_5, (ref) v_u_3, (ref) v_u_19, (ref) v_u_4, (ref) v_u_13, (ref) v_u_18, (ref) v_u_6, (ref) v_u_14, (ref) v_u_45, (ref) v_u_22, (ref) v_u_2, (ref) v_u_54, (ref) v_u_17, (ref) v_u_8
				local v56 = Vector2.new(v_u_5.X, v_u_5.Y)
				if v_u_3:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
					local v57 = v56 - Vector2.new(v_u_6.AbsolutePosition.X + v_u_17.X, v_u_6.AbsolutePosition.Y + v_u_17.Y)
					local v58 = v57.X
					local v59 = v57.Y
					local v60 = v58 ^ 2 + v59 ^ 2
					local v61 = math.sqrt(v60)
					if v_u_8 < v61 then
						local v62 = v_u_8 / v61
						v58 = v58 * v62
						v59 = v59 * v62
					end
					local v63 = v58 + v_u_17.X
					local v64 = v_u_6.AbsoluteSize.X - v_u_14.AbsoluteSize.X - 16
					local v65 = math.clamp(v63, 16, v64)
					local v66 = v59 + v_u_17.Y
					local v67 = v_u_6.AbsoluteSize.Y - v_u_14.AbsoluteSize.Y - 16
					local v68 = math.clamp(v66, 16, v67)
					v_u_14.Position = UDim2.fromOffset(v65, v68)
					v_u_45(v65, v68, p55)
				else
					v_u_19:Disconnect()
					v_u_19 = nil
					local v69 = v_u_4.PlayerGui:GetGuiObjectsAtPosition(v_u_5.X, v_u_5.Y)
					for _, v70 in next, v69 do
						if v70 == v_u_13 then
							v_u_18 = false
							local v71 = v_u_13.ConnectHitbox.AbsolutePosition + Vector2.yAxis * v_u_13.ConnectHitbox.AbsoluteSize.Y / 2 - v_u_6.AbsolutePosition
							v_u_14.Position = UDim2.fromOffset(v71.X, v71.Y)
							v_u_45(v71.X, v71.Y, p55)
							local v_u_72 = v71.X
							local v_u_73 = v71.Y
							v_u_22 = v_u_22 + 120
							local v_u_74 = 0
							local v_u_75 = nil
							v_u_75 = v_u_2.Heartbeat:Connect(function(p76)
								-- upvalues: (ref) v_u_74, (ref) v_u_45, (copy) v_u_72, (copy) v_u_73, (ref) v_u_75
								v_u_74 = v_u_74 + p76
								v_u_45(v_u_72, v_u_73, p76)
								if v_u_74 >= 4 then
									v_u_75:Disconnect()
								end
							end)
							return
						end
					end
					v_u_54()
				end
			end)
		end
	end)
end