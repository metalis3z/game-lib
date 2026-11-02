--credit to leon games studio
local t = {
	5073759,
}
local t2 = {}

for v1, v2 in t do
	t2[v2] = true
end

return table.freeze({
	List = t,
	IsAllowed = function(p1) --[[ IsAllowed | Line: 39 | Upvalues: t2 (copy) ]]
		return t2[p1] == true
	end
})