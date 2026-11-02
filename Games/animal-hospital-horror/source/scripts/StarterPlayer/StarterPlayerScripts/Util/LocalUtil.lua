local t = {}

for v1, v2 in next, script.Parent:GetChildren() do
	if v2 ~= script then
		t[v2.Name] = require(v2)
	end
end

return t