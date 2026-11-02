-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = nil

local function merge(p1, p2, p3) --[[ merge | Line: 5 | Upvalues: v1 (ref) ]]
	if not p2 then
		return p3
	end

	if not p3 then
		return p2
	end

	if p1(p2.element, p3.element) < 0 then
		return v1(p1, p2, p3)
	end

	return v1(p1, p3, p2)
end

v1 = function(p1, p2, p3) --[[ mergeRoot | Line: 18 | Upvalues: v1 (ref) ]]
	if not p2.left then
		p2.left = p3

		return p2
	end

	local right = p2.right

	p2.right = if right then if p3 then if p1(right.element, p3.element) < 0 then v1(p1, right, p3) else v1(p1, p3, right) else right else p3

	if p2.left.npl < p2.right.npl then
		local left = p2.left

		p2.left = p2.right
		p2.right = left
	end

	p2.npl = p2.right.npl + 1

	return p2
end
function t.new(p1) --[[ new | Line: 34 | Upvalues: v1 (ref) ]]
	assert(typeof(p1) == "function")

	local t = {
		root = nil
	}

	function t.merge(p12) --[[ merge | Line: 38 | Upvalues: t (copy), p1 (copy), v1 (ref) ]]
		if t.root == p12.root then
			return
		end

		local v2 = p1
		local root = t.root
		local root2 = p12.root

		t.root = if root then if root2 then if v2(root.element, root2.element) < 0 then v1(v2, root, root2) else v1(v2, root2, root) else root else root2
		p12.root = nil
	end

	local function insert(p12) --[[ insert | Line: 45 | Upvalues: t (copy), p1 (copy), v1 (ref) ]]
		local v2 = p1
		local t2 = {
			npl = 0,
			element = p12
		}
		local root = t.root

		t.root = if t2 then if root then if v2(t2.element, root.element) < 0 then v1(v2, t2, root) else v1(v2, root, t2) else t2 else root
	end

	local function min() --[[ min | Line: 49 | Upvalues: t (copy) ]]
		assert(t.root)

		return t.root.element
	end

	local function tryMin() --[[ tryMin | Line: 54 | Upvalues: t (copy) ]]
		if t.root then
			return true, t.root.element
		end

		return false
	end

	local function pop() --[[ pop | Line: 61 | Upvalues: t (copy), p1 (copy), v1 (ref) ]]
		assert(t.root)

		local v2 = p1
		local left = t.root.left
		local right = t.root.right

		t.root = if left then if right then if v2(left.element, right.element) < 0 then v1(v2, left, right) else v1(v2, right, left) else left else right

		return t.root.element
	end

	local function tryPop() --[[ tryPop | Line: 68 | Upvalues: t (copy), p1 (copy), v1 (ref) ]]
		if not t.root then
			return false, nil
		end

		local v2 = p1
		local left = t.root.left
		local right = t.root.right

		t.root = if left then if right then if v2(left.element, right.element) < 0 then v1(v2, left, right) else v1(v2, right, left) else left else right

		return true, t.root.element
	end

	local function popFast() --[[ popFast | Line: 77 | Upvalues: t (copy), p1 (copy), v1 (ref) ]]
		local v2 = p1
		local left = t.root.left
		local right = t.root.right

		t.root = if left then if right then if v2(left.element, right.element) < 0 then v1(v2, left, right) else v1(v2, right, left) else left else right
	end

	local function empty() --[[ empty | Line: 81 | Upvalues: t (copy) ]]
		return t.root == nil
	end

	local function clear() --[[ clear | Line: 85 | Upvalues: t (copy) ]]
		t.root = nil
	end

	t.insert = insert
	t.min = min
	t.tryMin = tryMin
	t.pop = pop
	t.tryPop = tryPop
	t.popFast = popFast
	t.empty = empty
	t.clear = clear

	return t
end

return t