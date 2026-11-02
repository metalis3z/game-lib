-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return function(p1, p2)
	if p1:IsA("Model") then
		local v3 = Vector3.new(1, 1, 1) * (1 / 0)
		local v4 = -v3
		local v5 = p1:GetDescendants()
		if #v5 ~= 0 then
			for _, v6 in v5 do
				if v6:IsA("BasePart") and (not p1.PrimaryPart or (p1.PrimaryPart ~= v6 or v6.Transparency ~= 1)) and (not p2 or p2 > v6.Transparency) then
					local v7 = v6.CFrame
					local v8 = v6.Size
					local v9 = v8.X / 2
					local v10 = v8.Y / 2
					local v11 = v8.Z / 2
					local v12 = -v9
					local v13 = -v10
					local v14 = -v11
					for _, v15 in {
						v7 * Vector3.new(v12, v13, v14),
						v7 * Vector3.new(v9, v13, v14),
						v7 * Vector3.new(v12, v10, v14),
						v7 * Vector3.new(v9, v10, v14),
						v7 * Vector3.new(v12, v13, v11),
						v7 * Vector3.new(v9, v13, v11),
						v7 * Vector3.new(v12, v10, v11),
						v7 * Vector3.new(v9, v10, v11)
					} do
						local v16 = v3.X
						local v17 = v15.X
						local v18 = math.min(v16, v17)
						local v19 = v3.Y
						local v20 = v15.Y
						local v21 = math.min(v19, v20)
						local v22 = v3.Z
						local v23 = v15.Z
						local v24 = math.min(v22, v23)
						v3 = Vector3.new(v18, v21, v24)
						local v25 = v4.X
						local v26 = v15.X
						local v27 = math.max(v25, v26)
						local v28 = v4.Y
						local v29 = v15.Y
						local v30 = math.max(v28, v29)
						local v31 = v4.Z
						local v32 = v15.Z
						local v33 = math.max(v31, v32)
						v4 = Vector3.new(v27, v30, v33)
					end
				end
			end
			return {
				["Position"] = (v3 + v4) / 2,
				["Size"] = v4 - v3
			}
		end
	else
		warn("Expected a Model, got:", p1)
	end
end
