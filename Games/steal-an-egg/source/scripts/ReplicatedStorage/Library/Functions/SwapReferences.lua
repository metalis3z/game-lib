-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function trySwap(p1, p2, p3, p4) --[[ trySwap | Line: 1 ]]
	pcall(function() --[[ Line: 2 | Upvalues: p1 (copy), p2 (copy), p3 (copy), p4 (copy) ]]
		if p1[p2] ~= p3 then
			return
		end

		p1[p2] = p4
	end)
end

local function swap(p1, p2, p3) --[[ swap | Line: 9 ]]
	if p1:IsA("Model") then
		if p1.PrimaryPart == p2 then
			p1.PrimaryPart = p3
		end
	elseif p1:IsA("ObjectValue") and p1.Value == p2 then
		p1.Value = p3
	end

	local v1 = "Part0"

	pcall(function() --[[ Line: 2 | Upvalues: p1 (copy), v1 (copy), p2 (copy), p3 (copy) ]]
		if p1[v1] ~= p2 then
			return
		end

		p1[v1] = p3
	end)

	local v2 = "Part1"

	pcall(function() --[[ Line: 2 | Upvalues: p1 (copy), v2 (copy), p2 (copy), p3 (copy) ]]
		if p1[v2] ~= p2 then
			return
		end

		p1[v2] = p3
	end)

	local v3 = "Adornee"

	pcall(function() --[[ Line: 2 | Upvalues: p1 (copy), v3 (copy), p2 (copy), p3 (copy) ]]
		if p1[v3] ~= p2 then
			return
		end

		p1[v3] = p3
	end)

	for k, v in pairs(p1:GetAttributes()) do
		if v == p2 then
			p1:SetAttribute(k, p3)
		end
	end
end

return function(p1, p2, p3) --[[ Line: 27 | Upvalues: swap (copy) ]]
	swap(p1, p2, p3)

	for i, v in ipairs(p1:GetDescendants()) do
		swap(v, p2, p3)
	end
end