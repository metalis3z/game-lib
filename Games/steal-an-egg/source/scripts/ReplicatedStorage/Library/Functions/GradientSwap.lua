-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	for v1, v2 in p1:GetChildren() do
		if v2:IsA("UIGradient") then
			v2:Destroy()
		end
	end

	if p2 == nil then
		return nil
	end

	local v3 = p2:Clone()

	v3.Parent = p1

	return v3
end