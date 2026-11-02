-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	__database = {
		Merged_Packages = {
			["Interact#Peach_Stars"] = { "Have#Stars" }
		},
		Error_Tokens = {
			INVALID_NODE = 1
		}
	}
}

function t.Filter_Progress(p1, p2) --[[ Filter_Progress | Line: 14 | Upvalues: t (copy) ]]
	local v1 = typeof(p2) == "table" and p2.Tensor or p2
	local v2 = t.__database.Merged_Packages[v1]

	if p1.Token ~= (((if v1 == "__Spoof" then true else false) or (if v2 then table.find(v2, p1.Token) else v2)) and p1.Token or v1) then
		return t.__database.Error_Tokens.INVALID_NODE
	end

	if typeof(p1) == "table" and (p1.Modifier == "IncrementProgress" and p1.State == "Active") then
		return p1.Progress
	end
end

return t