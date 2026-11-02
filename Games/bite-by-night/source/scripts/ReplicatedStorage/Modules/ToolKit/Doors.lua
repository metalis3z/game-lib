-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = math.sign
function v_u_1.GetClosestDoor(_, p3, p4)
	local v5 = not p4 and workspace.MAPS:FindFirstChild("GAME MAP")
	if v5 then
		v5 = workspace.MAPS["GAME MAP"]:FindFirstChild("Doors")
	end
	local v6 = (1 / 0)
	local v7 = nil
	for _, v8 in v5:GetChildren() do
		if v8:FindFirstChild("Root") then
			local v9 = (v8.Root.Position - p3).Magnitude
			if v9 < v6 then
				v7 = v8
				v6 = v9
			end
		end
	end
	return v7, v6
end
function v_u_1.IsBarricading(_, p10)
	return p10:HasTag("Barricading")
end
function v_u_1.IsDoorBarricaded(_, p11)
	return p11:GetAttribute("HOLD")
end
function v_u_1.GetDoorProduct(_, p12, p13)
	local v14 = p12.Root.Position - (typeof(p13) == "Vector3" and p13 and p13 or p13.HumanoidRootPart.Position)
	local v15 = v14.Magnitude == 0 and Vector3.new(0, 0, 0) or v14.Unit
	local v16 = p12.Root.CFrame.LookVector
	return v15:Dot(v16), v15, v16
end
function v_u_1.CompareCharacterVectors(_, p17, p18, p19)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	local v20 = v_u_1:GetDoorProduct(p17, p18)
	local v21 = v_u_1:GetDoorProduct(p17, p19)
	return v_u_2(v20) == v_u_2(v21), v20, v21
end
return v_u_1