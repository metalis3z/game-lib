local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("RunService")
v3:IsServer()
local v_u_4 = v3:IsClient()
return function(p5, p_u_6, _)
	local v_u_7 = {}
	local function v26(p_u_8)
		local v9 = p_u_8:IsA("Tool")
		local v10 = ("tried to wrap %*"):format(p_u_8)
		assert(v9, v10)
		local v_u_11 = nil
		if v_u_4 then
			local function v15()
				local v12 = p_u_8
				if not v12:FindFirstAncestorOfClass("Player") then
					v_u_2:GetPlayerFromCharacter(v12.Parent)
				end
				if p_u_8.Parent and (p_u_8.Parent == v_u_2.LocalPlayer:FindFirstChild("Backpack") or p_u_8.Parent == v_u_2.LocalPlayer.Character) then
					if not v_u_11 then
						local v13 = p_u_6(p_u_8)
						local v14 = ("no cleanup function given for tool %*"):format(p_u_8)
						assert(v13, v14)
						v_u_11 = v13
						v_u_7[p_u_8] = v_u_11
					end
				else
					if v_u_11 then
						task.spawn(v_u_11)
						v_u_11 = nil
						v_u_7[p_u_8] = nil
					end
					return
				end
			end
			if not p_u_8:FindFirstAncestorOfClass("Player") then
				v_u_2:GetPlayerFromCharacter(p_u_8.Parent)
			end
			if p_u_8.Parent and (p_u_8.Parent == v_u_2.LocalPlayer:FindFirstChild("Backpack") or p_u_8.Parent == v_u_2.LocalPlayer.Character) then
				if not v_u_11 then
					local v16 = p_u_6(p_u_8)
					local v17 = ("no cleanup function given for tool %*"):format(p_u_8)
					assert(v16, v17)
					v_u_11 = v16
					v_u_7[p_u_8] = v_u_11
				end
			elseif v_u_11 then
				task.spawn(v_u_11)
				v_u_11 = nil
				v_u_7[p_u_8] = nil
			end
			p_u_8.AncestryChanged:Connect(v15)
		else
			local function v22()
				local v18 = p_u_8
				local v19 = v18:FindFirstAncestorOfClass("Player") or v_u_2:GetPlayerFromCharacter(v18.Parent)
				if v19 and (p_u_8.Parent == v19.Character or p_u_8.Parent == v19:FindFirstChild("Backpack")) then
					if not v_u_11 then
						local v20 = p_u_6(p_u_8)
						local v21 = ("no cleanup function given for tool %*"):format(p_u_8)
						assert(v20, v21)
						v_u_11 = v20
						v_u_7[p_u_8] = v_u_11
					end
				else
					if v_u_11 then
						task.spawn(v_u_11)
						v_u_11 = nil
						v_u_7[p_u_8] = nil
					end
					return
				end
			end
			local v23 = p_u_8:FindFirstAncestorOfClass("Player") or v_u_2:GetPlayerFromCharacter(p_u_8.Parent)
			if v23 and (p_u_8.Parent == v23.Character or p_u_8.Parent == v23:FindFirstChild("Backpack")) then
				if not v_u_11 then
					local v24 = p_u_6(p_u_8)
					local v25 = ("no cleanup function given for tool %*"):format(p_u_8)
					assert(v24, v25)
					v_u_11 = v24
					v_u_7[p_u_8] = v_u_11
				end
			elseif v_u_11 then
				task.spawn(v_u_11)
				v_u_11 = nil
				v_u_7[p_u_8] = nil
			end
			p_u_8.AncestryChanged:Connect(v22)
		end
	end
	local v27 = ("Tool_%*"):format(p5)
	for _, v28 in v_u_1:GetTagged(v27) do
		task.spawn(v26, v28)
	end
	v_u_1:GetInstanceAddedSignal(v27):Connect(v26)
	v_u_1:GetInstanceRemovedSignal(v27):Connect(function(p29)
		if v_u_7[p29] then
			v_u_7[p29]()
			v_u_7[p29] = nil
		end
	end)
end