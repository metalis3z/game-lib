--credit to quartz games studio
function _merge1(p1, p2, p3) --[[ _merge1 | Line: 96 ]]
	if not p2.Left then
		p2.Left = p3

		return p2
	end

	p2.Right = _merge(p1, p2.Right, p3)

	if p2.Left.Npl < p2.Right.Npl then
		local Left = p2.Left

		p2.Left = p2.Right
		p2.Right = Left
	end

	p2.Npl = p2.Right.Npl + 1

	return p2
end
function _merge(p1, p2, p3) --[[ _merge | Line: 119 ]]
	if not p2 then
		return p3
	end

	if not p3 then
		return p2
	end

	if p1(p2.Value, p3.Value) < 0 then
		return _merge1(p1, p2, p3)
	end

	return _merge1(p1, p3, p2)
end

local t = {}
local v1 = table.freeze({
	__index = t
})

function t.Merge(p1, p2) --[[ Merge | Line: 142 ]]
	if p1.Root == p2.Root then
		return
	end

	p1.Root = _merge(p1.Comparator, p1.Root, p2.Root)
	p2.Root = nil
end
function t.Insert(p1, p2) --[[ Insert | Line: 149 ]]
	p1.Root = _merge(p1.Comparator, {
		Npl = 0,
		Value = p2
	}, p1.Root)
end
function t.Min(p1) --[[ Min | Line: 156 ]]
	assert(p1.Root)

	return p1.Root.Value
end
function t.TryMin(p1) --[[ TryMin | Line: 161 ]]
	if p1.Root then
		return true, p1.Root.Value
	end

	return false, nil
end
function t.Pop(p1) --[[ Pop | Line: 168 ]]
	assert(p1.Root)

	local Root2 = p1.Root.Value

	p1.Root = _merge(p1.Comparator, p1.Root.Left, p1.Root.Right)

	return Root2
end
function t.TryPop(p1) --[[ TryPop | Line: 175 ]]
	if p1.Root then
		local Root = p1.Root.Value

		p1.Root = _merge(p1.Comparator, p1.Root.Left, p1.Root.Right)

		return true, Root
	end

	return false, nil
end
function t.PopFast(p1) --[[ PopFast | Line: 184 ]]
	p1.Root = _merge(p1.Comparator, p1.Root.Left, p1.Root.Right)
end
function t.Empty(p1) --[[ Empty | Line: 192 ]]
	return p1.Root == nil
end
function t.Clear(p1) --[[ Clear | Line: 196 ]]
	p1.Root = nil
end
table.freeze(t)

return table.freeze({
	Compare = function(p1, p2) --[[ Compare | Line: 205 ]]
		if p1 < p2 then
			return -1
		end

		if p2 < p1 then
			return 1
		end

		return 0
	end,
	new = function(p1, p2) --[[ new | Line: 211 | Upvalues: v1 (copy) ]]
		assert(type(p1) == "function")

		return setmetatable({
			Comparator = p1
		}, v1)
	end
})