local v_u_1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Packages.Observers)
local v_u_4 = require(v2.Packages.Trove)
local v_u_5 = {
	"StartX",
	"StartZ",
	"Direction",
	"FromLength",
	"ToLength",
	"TweenDuration",
	"TweenId",
	"ThicknessY",
	"PauseUntil"
}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = nil
local function v_u_14(p10)
	local v11 = {}
	for _, v12 in v_u_5 do
		local v13 = p10:GetAttribute(v12)
		if typeof(v13) ~= "number" and typeof(v13) ~= "Vector2" then
			return nil
		end
		v11[v12] = v13
	end
	v11.Elapsed = 0
	v11.Part = p10
	return v11
end
local function v_u_29(p15, p16)
	local v17 = p15.Part.Position.Y
	local v18 = p16 or p15.FromLength
	local v19 = (v18 - 1) * 0.5
	local v20
	if p15.Direction.X == 0 then
		local v21 = p15.StartX + 0.5
		local v22 = p15.StartZ + p15.Direction.Y * v19
		v20 = Vector3.new(v21, v17, v22)
	else
		local v23 = p15.StartX + p15.Direction.X * v19
		local v24 = p15.StartZ + 0.5
		v20 = Vector3.new(v23, v17, v24)
	end
	local v25 = p15.Direction.X == 0 and 2 or math.max(1, v18)
	local v26 = p15.Direction.Y == 0 and 2 or math.max(1, v18)
	local v27 = p15.Part
	local v28 = p15.ThicknessY
	v27.Size = Vector3.new(v25, v28, v26)
	p15.Part.CFrame = CFrame.new(v20)
end
local function v_u_44(p30)
	local v31 = v_u_14(p30)
	if v31 then
		local v32 = v31.TweenId
		if v_u_8[p30] == v32 then
			return
		else
			v_u_8[p30] = v32
			if workspace:GetServerTimeNow() < v31.PauseUntil then
				v_u_7[p30] = v31
				v_u_6[p30] = nil
			else
				v_u_6[p30] = v31
				v_u_7[p30] = nil
			end
			v_u_29(v31)
			if not (v_u_9 and v_u_9.Connected) then
				v_u_9 = v_u_1.PostSimulation:Connect(function(p33)
					debug.profilebegin("TreeRootAnimator:Step")
					if next(v_u_6) == nil and (v_u_9 ~= nil and v_u_9.Connected) then
						v_u_9:Disconnect()
						v_u_9 = nil
						debug.profileend()
					else
						local v34 = workspace:GetServerTimeNow()
						for v35, v36 in v_u_7 do
							if v36.PauseUntil <= v34 then
								v_u_6[v35] = v36
								v_u_7[v35] = nil
								v_u_29(v36)
							else
								v_u_29(v36)
							end
						end
						local v37 = 0
						for v38, v39 in v_u_6 do
							if v34 < v39.PauseUntil then
								v_u_7[v38] = v39
								v_u_6[v38] = nil
								v_u_29(v39)
							else
								v39.Elapsed = v39.Elapsed + p33
								local v40 = v39.TweenDuration
								local v41 = math.max(v40, 0.011111111111111112)
								local v42 = v39.Elapsed / v41
								local v43 = math.clamp(v42, 0, 1)
								v_u_29(v39, v39.FromLength + (v39.ToLength - v39.FromLength) * v43)
								if v43 >= 1 then
									v_u_6[v38] = nil
								end
							end
							v37 = v37 + 1
							if v37 >= 3 then
								break
							end
						end
						debug.profileend()
					end
				end)
			end
		end
	else
		return
	end
end
return v3.observeTag("RootRunTween", function(p_u_45)
	if not p_u_45:IsA("BasePart") then
		return nil
	end
	local v_u_46 = v_u_4.new()
	v_u_44(p_u_45)
	v_u_46:Add(p_u_45:GetAttributeChangedSignal("TweenId"):Connect(function()
		v_u_44(p_u_45)
	end))
	v_u_46:Add(p_u_45:GetAttributeChangedSignal("PauseUntil"):Connect(function()
		local v47 = p_u_45:GetAttribute("PauseUntil") or 0
		local v48 = workspace:GetServerTimeNow()
		local v49 = v_u_6[p_u_45]
		local v50 = v_u_7[p_u_45]
		if v48 < v47 then
			if v49 then
				v49.PauseUntil = v47
				v_u_7[p_u_45] = v49
				v_u_6[p_u_45] = nil
				v_u_29(v49)
			elseif v50 then
				v50.PauseUntil = v47
				v_u_29(v50)
			else
				local v51 = v_u_14(p_u_45)
				if v51 then
					v_u_7[p_u_45] = v51
					v_u_29(v51)
				end
			end
			if v_u_9 and v_u_9.Connected then
				return
			end
			v_u_9 = v_u_1.PostSimulation:Connect(function(p52)
				debug.profilebegin("TreeRootAnimator:Step")
				if next(v_u_6) == nil and (v_u_9 ~= nil and v_u_9.Connected) then
					v_u_9:Disconnect()
					v_u_9 = nil
					debug.profileend()
				else
					local v53 = workspace:GetServerTimeNow()
					for v54, v55 in v_u_7 do
						if v55.PauseUntil <= v53 then
							v_u_6[v54] = v55
							v_u_7[v54] = nil
							v_u_29(v55)
						else
							v_u_29(v55)
						end
					end
					local v56 = 0
					for v57, v58 in v_u_6 do
						if v53 < v58.PauseUntil then
							v_u_7[v57] = v58
							v_u_6[v57] = nil
							v_u_29(v58)
						else
							v58.Elapsed = v58.Elapsed + p52
							local v59 = v58.TweenDuration
							local v60 = math.max(v59, 0.011111111111111112)
							local v61 = v58.Elapsed / v60
							local v62 = math.clamp(v61, 0, 1)
							v_u_29(v58, v58.FromLength + (v58.ToLength - v58.FromLength) * v62)
							if v62 >= 1 then
								v_u_6[v57] = nil
							end
						end
						v56 = v56 + 1
						if v56 >= 3 then
							break
						end
					end
					debug.profileend()
				end
			end)
		end
	end))
	return function()
		v_u_46:Destroy()
		v_u_6[p_u_45] = nil
		v_u_8[p_u_45] = nil
	end
end)