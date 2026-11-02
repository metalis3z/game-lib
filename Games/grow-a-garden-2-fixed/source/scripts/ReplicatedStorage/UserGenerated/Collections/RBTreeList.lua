--credit to prince games studio
local function insertRight2(p1, p2) --[[ insertRight2 | Line: 78 ]]
	local Right2 = p1.Right2

	p2.Right2 = Right2
	p2.Left2 = p1
	p1.Right2 = p2
	Right2.Left2 = p2
end

local function unlink2(p1) --[[ unlink2 | Line: 86 ]]
	p1.Left2.Right2 = p1.Right2
	p1.Right2.Left2 = p1.Left2
end

local function unlink(p1) --[[ unlink | Line: 91 ]]
	p1.Left2.Right2 = p1.Right2
	p1.Right2.Left2 = p1.Left2
	p1.Left1 = nil
	p1.Right1 = nil
	p1.Left2 = nil
	p1.Right2 = nil
end

local function isRed(p1) --[[ isRed | Line: 101 ]]
	if p1 then
		return p1.Color1
	end

	return false
end

local function rotateLeft(p1) --[[ rotateLeft | Line: 109 ]]
	local Right1 = p1.Right1

	p1.Right1 = Right1.Left1
	Right1.Left1 = p1
	Right1.Color1 = p1.Color1
	p1.Color1 = true

	return Right1
end

local function rotateRight(p1) --[[ rotateRight | Line: 119 ]]
	local Left1 = p1.Left1

	p1.Left1 = Left1.Right1
	Left1.Right1 = p1
	Left1.Color1 = p1.Color1
	p1.Color1 = true

	return Left1
end

local function flipColors(p1) --[[ flipColors | Line: 129 ]]
	p1.Color1 = not p1.Color1

	local Left1 = p1.Left1

	Left1.Color1 = not Left1.Color1

	local Right1 = p1.Right1

	Right1.Color1 = not Right1.Color1
end

local function moveRedLeft(p1) --[[ moveRedLeft | Line: 139 ]]
	p1.Color1 = not p1.Color1

	local Left1 = p1.Left1

	Left1.Color1 = not Left1.Color1

	local Right1 = p1.Right1

	Right1.Color1 = not Right1.Color1

	local Left12 = p1.Right1.Left1

	if if Left12 then Left12.Color1 else false then
		local Right12 = p1.Right1
		local Left13 = Right12.Left1

		Right12.Left1 = Left13.Right1
		Left13.Right1 = Right12
		Left13.Color1 = Right12.Color1
		Right12.Color1 = true
		p1.Right1 = Left13

		local Right13 = p1.Right1

		p1.Right1 = Right13.Left1
		Right13.Left1 = p1
		Right13.Color1 = p1.Color1
		p1.Color1 = true
		Right13.Color1 = not Right13.Color1

		local Left14 = Right13.Left1

		Left14.Color1 = not Left14.Color1

		local Right14 = Right13.Right1

		Right14.Color1 = not Right14.Color1
		p1 = Right13
	end

	return p1
end

local function moveRedRight(p1) --[[ moveRedRight | Line: 151 ]]
	p1.Color1 = not p1.Color1

	local Left1 = p1.Left1

	Left1.Color1 = not Left1.Color1

	local Right1 = p1.Right1

	Right1.Color1 = not Right1.Color1

	local Left12 = p1.Left1.Left1

	if if Left12 then Left12.Color1 else false then
		local Left13 = p1.Left1

		p1.Left1 = Left13.Right1
		Left13.Right1 = p1
		Left13.Color1 = p1.Color1
		p1.Color1 = true
		Left13.Color1 = not Left13.Color1

		local Left14 = Left13.Left1

		Left14.Color1 = not Left14.Color1

		local Right12 = Left13.Right1

		Right12.Color1 = not Right12.Color1
		p1 = Left13
	end

	return p1
end

local function balance(p1) --[[ balance | Line: 161 ]]
	local Right1 = p1.Right1

	if if Right1 then Right1.Color1 else false then
		local Right12 = p1.Right1

		p1.Right1 = Right12.Left1
		Right12.Left1 = p1
		Right12.Color1 = p1.Color1
		p1.Color1 = true
		p1 = Right12
	end

	local Left1 = p1.Left1

	if if Left1 then Left1.Color1 else false then
		local Left12 = p1.Left1.Left1

		if if Left12 then Left12.Color1 else false then
			local Left13 = p1.Left1

			p1.Left1 = Left13.Right1
			Left13.Right1 = p1
			Left13.Color1 = p1.Color1
			p1.Color1 = true
			p1 = Left13
		end
	end

	local Left12 = p1.Left1

	if if Left12 then Left12.Color1 else false then
		local Right12 = p1.Right1

		if if Right12 then Right12.Color1 else false then
			p1.Color1 = not p1.Color1

			local Left13 = p1.Left1

			Left13.Color1 = not Left13.Color1

			local Right13 = p1.Right1

			Right13.Color1 = not Right13.Color1
		end
	end

	return p1
end

local function v1(p1) --[[ removeMin | Line: 174 | Upvalues: v1 (copy), balance (copy) ]]
	if not p1.Left1 then
		return nil, p1
	end

	local Left1 = p1.Left1

	if not (if Left1 then Left1.Color1 else false) then
		local Left12 = p1.Left1.Left1

		if not (if Left12 then Left12.Color1 else false) then
			p1.Color1 = not p1.Color1

			local Left13 = p1.Left1

			Left13.Color1 = not Left13.Color1

			local Right1 = p1.Right1

			Right1.Color1 = not Right1.Color1

			local Left14 = p1.Right1.Left1
			local v4

			if if Left14 then Left14.Color1 else false then
				local Right12 = p1.Right1
				local Left15 = Right12.Left1

				Right12.Left1 = Left15.Right1
				Left15.Right1 = Right12
				Left15.Color1 = Right12.Color1
				Right12.Color1 = true
				p1.Right1 = Left15

				local Right13 = p1.Right1

				p1.Right1 = Right13.Left1
				Right13.Left1 = p1
				Right13.Color1 = p1.Color1
				p1.Color1 = true
				Right13.Color1 = not Right13.Color1

				local Left16 = Right13.Left1

				Left16.Color1 = not Left16.Color1

				local Right14 = Right13.Right1

				Right14.Color1 = not Right14.Color1
				v4 = Right13
			else
				v4 = p1
			end

			p1 = v4
		end
	end

	local v5, v6 = v1(p1.Left1)

	p1.Left1 = v5

	return balance(p1), v6
end

local function v2(p1) --[[ removeMax | Line: 188 | Upvalues: v2 (copy), balance (copy) ]]
	local Left1 = p1.Left1

	if if Left1 then Left1.Color1 else false then
		local Left12 = p1.Left1

		p1.Left1 = Left12.Right1
		Left12.Right1 = p1
		Left12.Color1 = p1.Color1
		p1.Color1 = true
		p1 = Left12
	end

	if not p1.Right1 then
		return nil, p1
	end

	local Right1 = p1.Right1

	if not (if Right1 then Right1.Color1 else false) then
		local Left12 = p1.Right1.Left1

		if not (if Left12 then Left12.Color1 else false) then
			p1.Color1 = not p1.Color1

			local Left13 = p1.Left1

			Left13.Color1 = not Left13.Color1

			local Right12 = p1.Right1

			Right12.Color1 = not Right12.Color1

			local Left14 = p1.Left1.Left1
			local v5

			if if Left14 then Left14.Color1 else false then
				local Left15 = p1.Left1

				p1.Left1 = Left15.Right1
				Left15.Right1 = p1
				Left15.Color1 = p1.Color1
				p1.Color1 = true
				Left15.Color1 = not Left15.Color1

				local Left16 = Left15.Left1

				Left16.Color1 = not Left16.Color1

				local Right13 = Left15.Right1

				Right13.Color1 = not Right13.Color1
				v5 = Left15
			else
				v5 = p1
			end

			p1 = v5
		end
	end

	local v6, v7 = v2(p1.Right1)

	p1.Right1 = v6

	return balance(p1), v7
end

local function v3(p1) --[[ height | Line: 205 | Upvalues: v3 (copy) ]]
	if p1 then
		return math.max(v3(p1.Left1), v3(p1.Right1)) + 1
	end

	return -1
end

local function v4(p1, p2, p3, p4) --[[ isBST | Line: 214 | Upvalues: v4 (copy) ]]
	if not p2 then
		return true
	end

	if p3 ~= nil and p1(p2.Key, p3) <= 0 then
		return false
	end

	if p4 ~= nil and p1(p2.Key, p4) >= 0 then
		return false
	end

	return v4(p1, p2.Left1, p3, p2.Key) and v4(p1, p2.Right1, p2.Key, p4)
end

local function v5(p1, p2, p3) --[[ remove | Line: 233 | Upvalues: v5 (copy), v1 (copy), balance (copy) ]]
	local v12

	if p2 then
		if p1(p2.Key, p3) > 0 then
			local Left1 = p2.Left1

			if not (if Left1 then Left1.Color1 else false) then
				local Left12 = p2.Left1.Left1

				if not (if Left12 then Left12.Color1 else false) then
					p2.Color1 = not p2.Color1

					local Left13 = p2.Left1

					Left13.Color1 = not Left13.Color1

					local Right1 = p2.Right1

					Right1.Color1 = not Right1.Color1

					local Left14 = p2.Right1.Left1
					local v52

					if if Left14 then Left14.Color1 else false then
						local Right12 = p2.Right1
						local Left15 = Right12.Left1

						Right12.Left1 = Left15.Right1
						Left15.Right1 = Right12
						Left15.Color1 = Right12.Color1
						Right12.Color1 = true
						p2.Right1 = Left15

						local Right13 = p2.Right1

						p2.Right1 = Right13.Left1
						Right13.Left1 = p2
						Right13.Color1 = p2.Color1
						p2.Color1 = true
						Right13.Color1 = not Right13.Color1

						local Left16 = Right13.Left1

						Left16.Color1 = not Left16.Color1

						local Right14 = Right13.Right1

						Right14.Color1 = not Right14.Color1
						v52 = Right13
					else
						v52 = p2
					end

					p2 = v52
				end
			end

			local v6, v7 = v5(p1, p2.Left1, p3)

			p2.Left1 = v6
			v12 = v7
		else
			local Left1 = p2.Left1

			if if Left1 then Left1.Color1 else false then
				local Left12 = p2.Left1

				p2.Left1 = Left12.Right1
				Left12.Right1 = p2
				Left12.Color1 = p2.Color1
				p2.Color1 = true
				p2 = Left12
			end

			if p1(p2.Key, p3) == 0 and not p2.Right1 then
				p2.Left2.Right2 = p2.Right2
				p2.Right2.Left2 = p2.Left2
				p2.Left1 = nil
				p2.Right1 = nil
				p2.Left2 = nil
				p2.Right2 = nil

				return nil, p2
			end

			if p2.Right1 then
				local Right1 = p2.Right1

				if not (if Right1 then Right1.Color1 else false) then
					local Left12 = p2.Right1.Left1

					if not (if Left12 then Left12.Color1 else false) then
						p2.Color1 = not p2.Color1

						local Left13 = p2.Left1

						Left13.Color1 = not Left13.Color1

						local Right12 = p2.Right1

						Right12.Color1 = not Right12.Color1

						local Left14 = p2.Left1.Left1
						local v122

						if if Left14 then Left14.Color1 else false then
							local Left15 = p2.Left1

							p2.Left1 = Left15.Right1
							Left15.Right1 = p2
							Left15.Color1 = p2.Color1
							p2.Color1 = true
							Left15.Color1 = not Left15.Color1

							local Left16 = Left15.Left1

							Left16.Color1 = not Left16.Color1

							local Right13 = Left15.Right1

							Right13.Color1 = not Right13.Color1
							v122 = Left15
						else
							v122 = p2
						end

						p2 = v122
					end
				end
			end

			if p1(p2.Key, p3) == 0 then
				local Left12 = p2.Left1
				local Right1 = p2.Right1
				local Color1 = p2.Color1

				p2.Left2.Right2 = p2.Right2
				p2.Right2.Left2 = p2.Left2
				p2.Left1 = nil
				p2.Right1 = nil
				p2.Left2 = nil
				p2.Right2 = nil

				if Left12 and Right1 then
					local v13, v14 = v1(Right1)

					v14.Right1 = v13
					v14.Left1 = Left12
					v14.Color1 = Color1
					p2, v12 = v14, p2
				else
					local v15 = Left12 or Right1

					v15.Color1 = Color1
					p2, v12 = v15, p2
				end
			else
				local v16, v17 = v5(p1, p2.Right1, p3)

				p2.Right1 = v16
				v12 = v17
			end
		end

		p2 = balance(p2)
	else
		v12 = nil
	end

	return p2, v12
end

local function v6(p1, p2, p3, p4, p5) --[[ insert | Line: 280 | Upvalues: v6 (copy), balance (copy) ]]
	if not p2 then
		local t = {
			Color1 = true,
			Left2 = nil,
			Right2 = nil,
			Key = p4,
			Value = p5
		}
		local Right2 = p3.Right2

		t.Right2 = Right2
		t.Left2 = p3
		p3.Right2 = t
		Right2.Left2 = t

		return t, t, true
	end

	local v1 = false
	local v2 = p1(p2.Key, p4)
	local v3

	if v2 == 0 then
		p2.Value = p5
		v3 = p2
	else
		if v2 > 0 then
			local v4, v5, v62 = v6(p1, p2.Left1, p2.Left2, p4, p5)

			p2.Left1 = v4
			v1 = v62
			v3 = v5
		else
			local v7, v8, v9 = v6(p1, p2.Right1, p2, p4, p5)

			p2.Right1 = v7
			v1 = v9
			v3 = v8
		end

		if v1 then
			p2 = balance(p2)
		end
	end

	return p2, v3, v1
end

local function v7(p1, p2) --[[ isBalanced | Line: 317 | Upvalues: v7 (copy) ]]
	if p1 then
		if not (if p1 then p1.Color1 else false) then
			p2 = p2 - 1
		end

		return v7(p1.Left1, p2) and v7(p1.Right1, p2)
	end

	return p2 == 0
end

local function v8(p1) --[[ size | Line: 330 | Upvalues: v8 (copy) ]]
	local v1 = 0

	if p1 then
		v1 = v1 + 1 + v8(p1.Left1) + v8(p1.Right1)
	end

	return v1
end

local function v9(p1, p2) --[[ selectRank | Line: 340 | Upvalues: v8 (copy), v9 (copy) ]]
	if not p1 then
		return nil
	end

	local Left1 = p1.Left1
	local v1 = 0

	if Left1 then
		v1 = v1 + 1 + v8(Left1.Left1) + v8(Left1.Right1)
	end

	if p2 < v1 then
		return v9(p1.Left1, p2)
	end

	if v1 < p2 then
		return v9(p1.Right1, p2 - v1 - 1)
	end

	return p1.Key
end

local function v10(p1, p2, p3) --[[ rank | Line: 354 | Upvalues: v10 (copy), v8 (copy) ]]
	if not p3 then
		return 0
	end

	local v1 = p1(p3.Key, p2)

	if v1 > 0 then
		return v10(p1, p2, p3.Left1)
	end

	if v1 < 0 then
		local Left1 = p3.Left1
		local v2 = 0

		if Left1 then
			v2 = v2 + 1 + v8(Left1.Left1) + v8(Left1.Right1)
		end

		return v2 + 1 + v10(p1, p2, p3.Right1)
	end

	local Left1 = p3.Left1
	local v3 = 0

	if Left1 then
		v3 = v3 + 1 + v8(Left1.Left1) + v8(Left1.Right1)
	end

	return v3
end

local function v11(p1, p2) --[[ is23 | Line: 368 | Upvalues: v11 (copy) ]]
	if not p2 then
		return true
	end

	local Right1 = p2.Right1

	if if Right1 then Right1.Color1 else false then
		return false
	end

	if p2 ~= p1 and (if p2 then p2.Color1 else false) then
		local Left1 = p2.Left1

		if if Left1 then Left1.Color1 else false then
			return false
		end
	end

	return v11(p1, p2.Left1) and v11(p2.Right1)
end

local t = {}
local v12 = table.freeze({
	__index = t
})

function t.Insert(p1, p2, p3) --[[ Insert | Line: 387 | Upvalues: v6 (copy) ]]
	local v1, v2, v3 = v6(p1.Comparator, p1.Root, p1.List, p2, p3)

	v1.Color1 = false
	p1.Root = v1

	if not v3 then
		return v2, v3
	end

	p1.Size = p1.Size + 1

	return v2, v3
end
function t.Remove(p1, p2) --[[ Remove | Line: 403 | Upvalues: v5 (copy) ]]
	local Root = p1.Root
	local v1

	if Root then
		local Left1 = Root.Left1

		if not (if Left1 then Left1.Color1 else false) then
			local Right1 = Root.Right1

			if not (if Right1 then Right1.Color1 else false) then
				Root.Color1 = true
			end
		end

		local v4, v52 = v5(p1.Comparator, Root, p2)

		if v4 then
			v4.Color1 = false
		end

		p1.Root = v4

		if v52 then
			p1.Size = p1.Size - 1
		end

		v1 = v52
	else
		v1 = nil
	end

	return v1
end
function t.RemoveMin(p1) --[[ RemoveMin | Line: 423 | Upvalues: v1 (copy) ]]
	local Root = p1.Root
	local v12

	if Root then
		local Left1 = Root.Left1

		if not (if Left1 then Left1.Color1 else false) then
			local Right1 = Root.Right1

			if not (if Right1 then Right1.Color1 else false) then
				Root.Color1 = true
			end
		end

		local v4, v5 = v1(Root)

		if v4 then
			v4.Color1 = false
		end

		p1.Root = v4

		if v5 then
			p1.Size = p1.Size - 1
		end

		v12 = v5
	else
		v12 = nil
	end

	return v12
end
function t.RemoveMax(p1) --[[ RemoveMax | Line: 442 | Upvalues: v2 (copy) ]]
	local Root = p1.Root
	local v1

	if Root then
		local Left1 = Root.Left1

		if not (if Left1 then Left1.Color1 else false) then
			local Right1 = Root.Right1

			if not (if Right1 then Right1.Color1 else false) then
				Root.Color1 = true
			end
		end

		local v4, v5 = v2(Root)

		if v4 then
			v4.Color1 = false
		end

		p1.Root = v4

		if v5 then
			p1.Size = p1.Size - 1
		end

		v1 = v5
	else
		v1 = nil
	end

	return v1
end
function t.Min(p1) --[[ Min | Line: 462 ]]
	local List = p1.List
	local Left1 = List.Left1

	if Left1 == List then
		return nil
	end

	return Left1
end
function t.Max(p1) --[[ Max | Line: 471 ]]
	local List = p1.List
	local Right1 = List.Right1

	if Right1 == List then
		return nil
	end

	return Right1
end
function t.GetSize(p1) --[[ GetSize | Line: 481 ]]
	return p1.Size
end
function t.ForEach(p1, p2) --[[ ForEach | Line: 485 ]]
	assert(if type(p2) == "function" then true else false)

	local List = p1.List
	local v2 = List

	while true do
		v2 = v2.Right2

		if v2 == List then
			break
		end

		p2(v2.Key, v2.Value)
	end
end
function t.Next(p1, p2) --[[ Next | Line: 498 ]]
	local Right2 = (if p2 == nil then p1.List else p2).Right2

	if Right2 == p1.List then
		return nil, nil
	end

	return Right2, Right2
end
function t.Iterator(p1) --[[ Iterator | Line: 508 ]]
	return p1.Next, p1
end
function t.IsBST(p1) --[[ IsBST | Line: 512 | Upvalues: v4 (copy) ]]
	local Comparator = p1.Comparator
	local Root = p1.Root
	local v1

	if Root then
		local v2 = v4(Comparator, Root.Left1, nil, Root.Key)

		if v2 then
			return v4(Comparator, Root.Right1, Root.Key, nil)
		end

		v1 = v2
	else
		v1 = true
	end

	return v1
end
function t.IsSizeConsistent(p1) --[[ IsSizeConsistent | Line: 516 | Upvalues: v8 (copy) ]]
	local Size = p1.Size
	local Root = p1.Root
	local v1 = 0

	if Root then
		v1 = v1 + 1 + v8(Root.Left1) + v8(Root.Right1)
	end

	if Size ~= v1 then
		return false
	end

	local List = p1.List
	local v2, count = List, 0

	while true do
		v2 = v2.Right2

		if v2 == List then
			break
		end

		count = count + 1
	end

	return Size == count
end
function t.IsRankConsistent(p1) --[[ IsRankConsistent | Line: 538 | Upvalues: v8 (copy), v9 (copy), v10 (copy) ]]
	for i = 0, p1.Size - 1 do
		local v1
		local Root = p1.Root

		if Root then
			local Left1 = Root.Left1
			local v2 = 0

			if Left1 then
				v2 = v2 + 1 + v8(Left1.Left1) + v8(Left1.Right1)
			end

			v1 = if i < v2 then v9(Root.Left1, i) elseif v2 < i then v9(Root.Right1, i - v2 - 1) else Root.Key
		else
			v1 = nil
		end

		if i ~= v10(p1.Comparator, v1, p1.Root) then
			return false
		end
	end

	p1:ForEach(function(p12, p2) --[[ Line: 548 | Upvalues: v10 (ref), p1 (copy), v8 (ref), v9 (ref) ]]
		local v1 = v10(p1.Comparator, p12, p1.Root)
		local Root = p1.Root
		local v2

		if Root then
			local Left1 = Root.Left1
			local v3 = 0

			if Left1 then
				v3 = v3 + 1 + v8(Left1.Left1) + v8(Left1.Right1)
			end

			v2 = if v1 < v3 then v9(Root.Left1, v1) elseif v3 < v1 then v9(Root.Right1, v1 - v3 - 1) else Root.Key
		else
			v2 = nil
		end

		if p1.Comparator(v2, p12) == 0 then
			return
		end

		return false
	end)

	return true
end
function t.Is23(p1) --[[ Is23 | Line: 558 | Upvalues: v11 (copy) ]]
	return v11(p1.Root, p1.Root)
end
function t.IsBalanced(p1) --[[ IsBalanced | Line: 562 | Upvalues: v7 (copy) ]]
	local Root = p1.Root
	local v1, count = Root, 0

	while v1 do
		if not (if v1 then v1.Color1 else false) then
			count = count + 1
		end

		v1 = v1.Left1
	end

	local v3

	if Root then
		local v5 = if if Root then Root.Color1 else false then count else count - 1
		local v6 = v7(Root.Left1, v5)

		if v6 then
			return v7(Root.Right1, v5)
		end

		v3 = v6
	else
		v3 = count == 0
	end

	return v3
end
function t.Check(p1) --[[ Check | Line: 575 ]]
	if not p1:IsBST() then
		return false, "Not in symmetric order"
	end

	if not p1:IsSizeConsistent() then
		return false, "Subtree counts not consistent"
	end

	if not p1:IsRankConsistent() then
		return false, "Ranks not consistent"
	end

	if not p1:Is23() then
		return false, "Not a 2-3 tree"
	end

	if p1:IsBalanced() then
		return true
	end

	return false, "Not balanced"
end
table.freeze(t)

return table.freeze({
	Compare = function(p1, p2) --[[ Compare | Line: 599 ]]
		if p1 < p2 then
			return -1
		end

		if p2 < p1 then
			return 1
		end

		return 0
	end,
	new = function(p1, p2, p3) --[[ new | Line: 605 | Upvalues: v12 (copy) ]]
		assert(type(p1) == "function")

		local t = {
			Color1 = false,
			Key = nil,
			Value = nil
		}

		t.Left2 = t
		t.Right2 = t

		return setmetatable({
			Root = nil,
			Size = 0,
			Comparator = p1,
			List = t
		}, v12)
	end
})