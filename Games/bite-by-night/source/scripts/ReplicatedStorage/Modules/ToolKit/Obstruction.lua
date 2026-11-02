-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_27 = {
	["GetBarriers"] = function(_)
		local v1 = next
		local v2, v3 = workspace.MAPS:GetDescendants()
		local v4 = {}
		for _, v5 in v1, v2, v3 do
			if v5:IsA("BasePart") and (v5.Transparency == 1 and v5.CanCollide) then
				local v6 = v5:FindFirstAncestorOfClass("Model")
				if not (v6 and (v6:FindFirstChildOfClass("Humanoid") or v6:FindFirstChildOfClass("AnimationController"))) then
					v4[#v4 + 1] = v5
				end
			end
		end
		return v4
	end,
	["GetObstructionInstances"] = function(_)
		local v7 = workspace.PLAYERS
		local v8 = workspace.IGNORE
		local v9 = next
		local v10, v11 = workspace:GetDescendants()
		local v12 = {}
		for _, v13 in v9, v10, v11 do
			if v13:IsA("BasePart") and (v13.CanCollide and (v13.Transparency < 1 and not (v13:IsDescendantOf(v7) or v13:IsDescendantOf(v8)))) then
				v12[#v12 + 1] = v13
			end
		end
		return v12
	end,
	["GetObstructionAllInstances"] = function(_)
		local v14 = workspace.PLAYERS
		local v15 = workspace.IGNORE
		local v16 = next
		local v17, v18 = workspace:GetDescendants()
		local v19 = {}
		for _, v20 in v16, v17, v18 do
			if v20:IsA("BasePart") and (v20.CanCollide and not (v20:IsDescendantOf(v14) or v20:IsDescendantOf(v15))) then
				v19[#v19 + 1] = v20
			end
		end
		return v19
	end,
	["CastObstruction"] = function(_, p21, p22, p23, p24)
		-- upvalues: (copy) v_u_27
		if not (p23 or p24) then
			p23 = v_u_27:GetObstructionInstances()
		end
		if not p24 then
			p24 = RaycastParams.new()
			p24.FilterType = Enum.RaycastFilterType.Include
			p24.FilterDescendantsInstances = p23
		end
		local v25 = workspace:Raycast(p21, p22, p24)
		local v26 = v25 and v25.Position or p21 + p22
		return (p21 - v26).Magnitude, p21, v26, v25, p23, p24
	end
}
return v_u_27