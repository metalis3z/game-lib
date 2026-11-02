local t = {}

t.__index = t

local v1 = Random.new()

function DeepCopy(p1) --[[ DeepCopy | Line: 5 ]]
	local t = {}

	for v1, v2 in next, p1 do
		if type(v2) == "table" then
			v2 = DeepCopy(v2)
		end

		t[v1] = v2
	end

	return t
end
function t.new(p1, p2) --[[ new | Line: 17 | Upvalues: t (copy) ]]
	local t2 = {
		items = p1
	}

	t2.size = if p2 then p2 else #p1
	t2.q = {}
	t2.i = 1
	setmetatable(t2, t)

	return t2
end
function t.Shuffle(p1) --[[ Shuffle | Line: 30 | Upvalues: v1 (copy) ]]
	local v12 = DeepCopy(p1.items)
	local t = {}
	local t2 = {}

	for i = 1, p1.size do
		local sum = 0

		for i2, v in ipairs(v12) do
			sum = sum + v.w
		end

		local sum2 = v1:NextInteger(1, sum)

		for i2, v in ipairs(v12) do
			t[i2] = t[i2] or 0
			sum2 = sum2 - v.w

			if sum2 < 0 then
				t2[#t2 + 1] = v
				t[i2] = t[i2] + 1

				if v.max and t[i2] == v.max then
					table.remove(v12, i2)
				end

				break
			end
		end
	end

	p1.q = t2
	p1.i = 1
end
function t.GetNext(p1) --[[ GetNext | Line: 60 ]]
	if p1.i > #p1.q then
		p1:Shuffle()
	end

	local v1 = p1.q[p1.i]

	p1.i = p1.i + 1

	return v1
end

return t