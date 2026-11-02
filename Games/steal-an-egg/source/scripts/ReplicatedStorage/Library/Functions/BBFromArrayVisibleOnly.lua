-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local BBFromArray = require(script.Parent.BBFromArray)

return function(p1) --[[ Line: 7 | Upvalues: BBFromArray (copy) ]]
	assert(if typeof(p1) == "Instance" then p1:IsA("Model") or p1:IsA("Tool") else false, "Expected argument #1 to be a Model or Tool")

	local t = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency < 1 then
			table.insert(t, v)
		end
	end

	if #t == 0 then
		return p1:GetPivot(), Vector3.new(0, 0, 0)
	end

	return BBFromArray(t)
end