local result = {}
for _, v in script:GetDescendants() do
	if v:IsA("ModuleScript") then
		local name = string.sub(v.Name, 1, 1):lower() .. string.sub(v.Name, 2, -1)
		result[name] = require(v)
	end
end
return result