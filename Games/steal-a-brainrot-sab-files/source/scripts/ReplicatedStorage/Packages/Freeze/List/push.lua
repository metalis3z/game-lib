

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze)

local function push(t1: {[any]: any}, ...)
	if #{ ... } == 0 then
		return t1
	end

	local v4 = table.clone(t1)

	for _, v6 in { ... } do
		table.insert(v4, v6)
	end

	return maybeFreeze(v4)
end

return push
