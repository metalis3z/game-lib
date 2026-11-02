-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ZeroArray = require(script:WaitForChild("ZeroArray"))

function earcutLinked(p1, p2, p3, p4, p5, p6, p7) --[[ earcutLinked | Line: 4 | Upvalues: ZeroArray (copy) ]]
	if not p1 then
		return
	end

	if not p7 and p6 then
		indexCurve(p1, p4, p5, p6)
	end

	local v1 = p1

	while p1.prev ~= p1.next do
		local v2
		local v3 = false
		local prev = p1.prev
		local v4 = p1.next

		v2 = if p6 then isEarHashed(p1, p4, p5, p6) else isEar(p1)

		if v2 then
			ZeroArray.push(p2, prev.i / p3)
			ZeroArray.push(p2, p1.i / p3)
			ZeroArray.push(p2, v4.i / p3)
			removeNode(p1)
			p1 = v4.next
			v1 = v4.next
			v3 = true
		end

		if not v3 then
			if v4 == v1 then
				if not p7 then
					earcutLinked(filterPoints(v4), p2, p3, p4, p5, p6, 1)

					return
				end

				if p7 == 1 then
					earcutLinked(cureLocalIntersections(filterPoints(v4), p2, p3), p2, p3, p4, p5, p6, 2)

					return
				end

				if p7 == 2 then
					splitEarcut(v4, p2, p3, p4, p5, p6)

					return
				end

				break
			end

			p1 = v4
		end
	end
end
function splitEarcut(p1, p2, p3, p4, p5, p6) --[[ splitEarcut | Line: 72 ]]
	local v1 = p1

	while true do
		local v2 = v1.next.next

		while v2 ~= v1.prev do
			if v1.i ~= v2.i and isValidDiagonal(v1, v2) then
				local v3 = splitPolygon(v1, v2)
				local v4 = filterPoints(v1, v1.next)
				local v5 = filterPoints(v3, v3.next)

				earcutLinked(v4, p2, p3, p4, p5, p6)
				earcutLinked(v5, p2, p3, p4, p5, p6)

				return
			end

			v2 = v2.next
		end

		v1 = v1.next

		if v1 == p1 then
			return
		end
	end
end
function earcut(p1, p2, p3) --[[ earcut | Line: 97 | Upvalues: ZeroArray (copy) ]]
	local v1 = ZeroArray.new(p1)
	local v2 = ZeroArray.new(p2)
	local v3 = p3 or 2
	local v4

	if v2 then
		if #v2 > 0 then
			v2, v4 = true, v2
		else
			v2, v4 = false, v2
		end
	else
		v4 = v2
	end

	local v5, v6

	if v2 then
		v5 = v4[0] * v3

		if v5 then
			v6 = v1
		else
			v6 = v1
			v5 = #v1
		end
	else
		v6 = v1
		v5 = #v1
	end

	local v7 = linkedList(v6, 0, v5, v3, true)
	local v8 = ZeroArray.new({})

	if not v7 or v7.next == v7.prev then
		return {}
	end

	if v2 then
		v7 = eliminateHoles(v6, v4, v7, v3)
	end

	local v10, v11, v12

	if 80 * v3 < #v6 then
		v10 = v6[0]

		local v13 = v6[0]

		v11 = v6[1]

		local v14 = v6[1]
		local sum = v3

		while sum < v5 do
			local v15 = v6[sum]
			local v16 = v6[sum + 1]

			if v15 < v10 then
				v10 = v15
			end

			if v16 < v11 then
				v11 = v16
			end

			if v13 < v15 then
				v13 = v15
			end

			if v14 < v16 then
				v14 = v16
			end

			sum = sum + v3
		end

		local v17 = math.max(v13 - v10, v14 - v11)

		v12 = v17 ~= 0 and 1 / v17 or nil
	else
		v10 = nil
		v11 = nil
		v12 = nil
	end

	earcutLinked(v7, v8, v3, v10, v11, v12)

	return ZeroArray.getOneIndex(v8)
end
function linkedList(p1, p2, p3, p4, p5) --[[ linkedList | Line: 157 ]]
	local v1 = nil

	if p5 == (if signedArea(p1, p2, p3, p4) > 0 then true else false) then
		local sum = p2

		while sum < p3 do
			sum, v1 = sum + p4, insertNode(sum, p1[sum], p1[sum + 1], v1)
		end
	else
		local sum = p3 - p4

		while p2 <= sum do
			sum, v1 = sum - p4, insertNode(sum, p1[sum], p1[sum + 1], v1)
		end
	end

	if v1 and equals(v1, v1.next) then
		removeNode(v1)
		v1 = v1.next
	end

	return v1
end
function filterPoints(p1, p2) --[[ filterPoints | Line: 183 ]]
	if not p1 then
		return p1
	end

	if not p2 then
		p2 = p1
	end

	local v1 = p1

	while true do
		local v2 = false

		if v1.steiner or not equals(v1, v1.next) and area(v1.prev, v1, v1.next) ~= 0 then
			v1 = v1.next

			if not v2 or v1 == p2 then
				return p2
			end
		else
			removeNode(v1)
			v1 = v1.prev

			if v1 == v1.next then
				p2 = v1

				return v1
			end

			v2 = true
			p2 = v1

			if not v2 or v1 == v1 then
				return v1
			end
		end
	end
end
function isEar(p1) --[[ isEar | Line: 214 ]]
	local prev = p1.prev
	local v1 = p1.next

	if area(prev, p1, v1) >= 0 then
		return false
	end

	local v2 = p1.next.next

	while v2 ~= p1.prev do
		if pointInTriangle(prev.x, prev.y, p1.x, p1.y, v1.x, v1.y, v2.x, v2.y) and area(v2.prev, v2, v2.next) >= 0 then
			return false
		end

		v2 = v2.next
	end

	return true
end
function isEarHashed(p1, p2, p3, p4) --[[ isEarHashed | Line: 236 ]]
	local prev = p1.prev
	local v1 = p1.next

	if area(prev, p1, v1) >= 0 then
		return false
	end

	local v6 = zOrder(prev.x < p1.x and (prev.x < v1.x and prev.x or v1.x) or (p1.x < v1.x and p1.x or v1.x), prev.y < p1.y and (prev.y < v1.y and prev.y or v1.y) or (p1.y < v1.y and p1.y or v1.y), p2, p3, p4)
	local v7 = zOrder(prev.x > p1.x and (prev.x > v1.x and prev.x or v1.x) or (p1.x > v1.x and p1.x or v1.x), prev.y > p1.y and (prev.y > v1.y and prev.y or v1.y) or (p1.y > v1.y and p1.y or v1.y), p2, p3, p4)
	local prevZ = p1.prevZ
	local nextZ = p1.nextZ

	while prevZ and (v6 <= prevZ.z and (nextZ and nextZ.z <= v7)) do
		if prevZ ~= p1.prev and (prevZ ~= p1.next and (pointInTriangle(prev.x, prev.y, p1.x, p1.y, v1.x, v1.y, prevZ.x, prevZ.y) and area(prevZ.prev, prevZ, prevZ.next) >= 0)) then
			return false
		end

		prevZ = prevZ.prevZ

		if nextZ ~= p1.prev and (nextZ ~= p1.next and (pointInTriangle(prev.x, prev.y, p1.x, p1.y, v1.x, v1.y, nextZ.x, nextZ.y) and area(nextZ.prev, nextZ, nextZ.next) >= 0)) then
			return false
		end

		nextZ = nextZ.nextZ
	end

	while prevZ and v6 <= prevZ.z do
		if prevZ ~= p1.prev and (prevZ ~= p1.next and (pointInTriangle(prev.x, prev.y, p1.x, p1.y, v1.x, v1.y, prevZ.x, prevZ.y) and area(prevZ.prev, prevZ, prevZ.next) >= 0)) then
			return false
		end

		prevZ = prevZ.prevZ
	end

	while nextZ and nextZ.z <= v7 do
		if nextZ ~= p1.prev and (nextZ ~= p1.next and (pointInTriangle(prev.x, prev.y, p1.x, p1.y, v1.x, v1.y, nextZ.x, nextZ.y) and area(nextZ.prev, nextZ, nextZ.next) >= 0)) then
			return false
		end

		nextZ = nextZ.nextZ
	end

	return true
end
function cureLocalIntersections(p1, p2, p3) --[[ cureLocalIntersections | Line: 311 | Upvalues: ZeroArray (copy) ]]
	local v1 = p1

	repeat
		local prev = v1.prev
		local v2 = v1.next.next

		if not equals(prev, v2) and (intersects(prev, v1, v1.next, v2) and (locallyInside(prev, v2) and locallyInside(v2, prev))) then
			ZeroArray.push(p2, prev.i / p3)
			ZeroArray.push(p2, v1.i / p3)
			ZeroArray.push(p2, v2.i / p3)
			removeNode(v1)
			removeNode(v1.next)
			v1 = v2
			p1 = v2
		end

		v1 = v1.next
	until v1 == p1

	return filterPoints(v1)
end
function eliminateHoles(p1, p2, p3, p4) --[[ eliminateHoles | Line: 336 | Upvalues: ZeroArray (copy) ]]
	local v1 = ZeroArray.new({})
	local count = 0
	local v2 = #p2

	while count < v2 do
		local v5 = linkedList(p1, p2[count] * p4, count < v2 - 1 and p2[count + 1] * p4 or #p1, p4, false)

		if v5 == v5.next then
			v5.steiner = true
		end

		ZeroArray.push(v1, getLeftmost(v5))
		count = count + 1
	end

	ZeroArray.sort(v1, compareX)

	local count2 = 0

	while count2 < #v1 do
		eliminateHole(v1[count2], p3)
		count2, p3 = count2 + 1, filterPoints(p3, p3.next)
	end

	return p3
end
function compareX(p1, p2) --[[ compareX | Line: 366 ]]
	return p1.x < p2.x
end
function eliminateHole(p1, p2) --[[ eliminateHole | Line: 371 ]]
	local v1 = findHoleBridge(p1, p2)

	if not v1 then
		return
	end

	local v2 = splitPolygon(v1, p1)

	filterPoints(v1, v1.next)
	filterPoints(v2, v2.next)
end
function findHoleBridge(p1, p2) --[[ findHoleBridge | Line: 383 ]]
	local x = p1.x
	local y = p1.y
	local v1, v2, v3 = p2, (-1 / 0), nil

	while true do
		local v4

		v1 = v1.next

		if v1 == p2 then
			if not v3 then
				return nil
			end

			if x == v2 then
				return v3
			end

			local x2 = v3.x
			local y2 = v3.y

			v5 = v3
			v6 = v3
			v7 = (1 / 0)

			repeat
				local v8, v9, v10, v11, v12

				if v5.x <= x and (x2 <= v5.x and x ~= v5.x) then
					local v13 = pointInTriangle

					v8 = if y < y2 and x then x else v2

					if y < y2 and v2 then
						v9 = y
						v10 = x2
						v11 = y2
						v12 = v2
					else
						v9 = y
						v10 = x2
						v11 = y2
						v12 = x
					end

					if v13(v8, v9, v10, v11, v12, y, v5.x, v5.y) then
						local v15 = math.abs(y - v5.y) / (x - v5.x)

						if locallyInside(v5, p1) and (v15 < v7 or v15 == v7 and (v5.x > v3.x or v5.x == v3.x and sectorContainsSector(v3, v5))) then
							v3 = v5
							v7 = v15
						end
					end
				end

				v5 = v5.next
			until v5 == v6

			return v3
		end

		if y <= v1.y and (v1.next.y <= y and v1.next.y ~= v1.y) then
			local v16 = v1.x + (y - v1.y) * (v1.next.x - v1.x) / (v1.next.y - v1.y)

			if v16 <= x and v2 < v16 then
				if v16 == x then
					if x == v1.y then
						return v1
					end

					if y == v1.next.y then
						return v1.next
					end
				end

				if v1.x < v1.next.x then
					v4 = v1
					v2 = v16
				else
					v2 = v16
					v4 = v1.next
				end

				v3 = v4
			end
		end
	end
end
function sectorContainsSector(p1, p2) --[[ sectorContainsSector | Line: 456 ]]
	return if area(p1.prev, p1, p2.prev) < 0 then area(p2.next, p1, p1.next) < 0 else false
end
function indexCurve(p1, p2, p3, p4) --[[ indexCurve | Line: 461 ]]
	local v1 = p1

	repeat
		if v1.z == nil then
			v1.z = zOrder(v1.x, v1.y, p2, p3, p4)
		end

		v1.prevZ = v1.prev
		v1.nextZ = v1.next
		v1 = v1.next
	until v1 == p1

	v1.prevZ.nextZ = nil
	v1.prevZ = nil
	sortLinked(v1)
end
function sortLinked(p1) --[[ sortLinked | Line: 480 ]]
	local v1 = 1

	while true do
		local v2, v3, v4

		v2, v3, v4, p1 = p1, 0, nil, nil

		while v2 do
			local count, count2, v5

			count, count2, v5, v3 = 0, 0, v2, v3 + 1

			while count < v1 do
				count2 = count2 + 1
				v5 = v5.nextZ

				if not v5 then
					break
				end

				count = count + 1
			end

			local v6 = v1

			while count2 > 0 or v6 > 0 and v5 do
				local v7, v8

				if count2 == 0 or v6 ~= 0 and (v5 and not (v2.z <= v5.z)) then
					v7 = v5.nextZ
					v8, v6 = v5, v6 - 1
				else
					v8, count2, v7, v2 = v2, count2 - 1, v5, v2.nextZ
				end

				if v4 then
					v4.nextZ = v8
				else
					p1 = v8
				end

				v8.prevZ = v4
				v5, v4 = v7, v8
			end

			v2 = v5
		end

		v4.nextZ = nil

		if v3 <= 1 then
			break
		end

		v1 = v1 * 2
	end

	return p1
end

local lshift = bit32.lshift
local bor = bit32.bor
local band = bit32.band

function zOrder(p1, p2, p3, p4, p5) --[[ zOrder | Line: 544 | Upvalues: lshift (copy), bor (copy), band (copy) ]]
	local v1 = 32767 * (p1 - p3) * p5
	local v2 = 32767 * (p2 - p4) * p5
	local v3 = band(bor(v1, (lshift(v1, 8))), 16711935)
	local v4 = band(bor(v3, (lshift(v3, 4))), 252645135)
	local v5 = band(bor(v4, (lshift(v4, 2))), 858993459)
	local v6 = band(bor(v5, (lshift(v5, 1))), 1431655765)
	local v7 = band(bor(v2, (lshift(v2, 8))), 16711935)
	local v8 = band(bor(v7, (lshift(v7, 4))), 252645135)
	local v9 = band(bor(v8, (lshift(v8, 2))), 858993459)

	return bor(v6, (lshift(band(bor(v9, (lshift(v9, 1))), 1431655765), 1)))
end
function getLeftmost(p1) --[[ getLeftmost | Line: 562 ]]
	local v1, v2 = p1, p1

	repeat
		if v1.x < v2.x or v1.x == v2.x and v1.y < v2.y then
			v2 = v1
		end

		v1 = v1.next
	until v1 == p1

	return v2
end
function pointInTriangle(p1, p2, p3, p4, p5, p6, p7, p8) --[[ pointInTriangle | Line: 576 ]]
	return if (p5 - p7) * (p2 - p8) - (p1 - p7) * (p6 - p8) >= 0 and (p1 - p7) * (p4 - p8) - (p3 - p7) * (p2 - p8) >= 0 then (p3 - p7) * (p6 - p8) - (p5 - p7) * (p4 - p8) >= 0 else false
end
function isValidDiagonal(p1, p2) --[[ isValidDiagonal | Line: 583 ]]
	local v1

	if p1.next.i == p2.i or p1.prev.i == p2.i then
		v1 = false
	else
		v1 = not intersectsPolygon(p1, p2)

		if v1 then
			v1 = locallyInside(p1, p2) and (locallyInside(p2, p1) and middleInside(p1, p2)) and (area(p1.prev, p1, p2.prev) or area(p1, p2.prev, p2)) or equals(p1, p2) and (if area(p1.prev, p1, p1.next) > 0 then area(p2.prev, p2, p2.next) > 0 else false)
		end
	end

	return v1
end
function area(p1, p2, p3) --[[ area | Line: 597 ]]
	return (p2.y - p1.y) * (p3.x - p2.x) - (p2.x - p1.x) * (p3.y - p2.y)
end
function equals(p1, p2) --[[ equals | Line: 602 ]]
	return if p1.x == p2.x then p1.y == p2.y else false
end
function intersects(p1, p2, p3, p4) --[[ intersects | Line: 607 ]]
	local v1 = sign(area(p1, p2, p3))
	local v2 = sign(area(p1, p2, p4))
	local v3 = sign(area(p3, p4, p1))
	local v4 = sign(area(p3, p4, p2))

	if v1 ~= v2 and v3 ~= v4 then
		return true
	end

	if v1 == 0 and onSegment(p1, p3, p2) then
		return true
	end

	if v2 == 0 and onSegment(p1, p4, p2) then
		return true
	end

	if v3 == 0 and onSegment(p3, p1, p4) then
		return true
	end

	return v4 == 0 and onSegment(p3, p2, p4) and true or false
end
function onSegment(p1, p2, p3) --[[ onSegment | Line: 634 ]]
	return if p2.x <= math.max(p1.x, p3.x) then if math.min(p1.x, p3.x) <= p2.x then if p2.y <= math.max(p1.y, p3.y) then math.min(p1.y, p3.y) <= p2.y else false else false else false
end
function sign(p1) --[[ sign | Line: 641 ]]
	if p1 > 0 then
		return 1
	end

	if p1 < 0 then
		return -1
	end

	return 0
end
function intersectsPolygon(p1, p2) --[[ intersectsPolygon | Line: 646 ]]
	local v1 = p1

	repeat
		if v1.i ~= p1.i and (v1.next.i ~= p1.i and (v1.i ~= p2.i and (v1.next.i ~= p2.i and intersects(v1, v1.next, p1, p2)))) then
			return true
		end

		v1 = v1.next
	until v1 == p1

	return false
end
function locallyInside(p1, p2) --[[ locallyInside | Line: 659 ]]
	if area(p1.prev, p1, p1.next) < 0 then
		return if area(p1, p2, p1.next) >= 0 then area(p1, p1.prev, p2) >= 0 else false
	end

	return if area(p1, p2, p1.prev) < 0 then true else area(p1, p1.next, p2) < 0
end
function middleInside(p1, p2) --[[ middleInside | Line: 667 ]]
	local v1 = (p1.x + p2.x) / 2
	local v2 = (p1.y + p2.y) / 2
	local v3, v4 = p1, false

	repeat
		local v5 = if v2 < v3.y then true else false

		if v5 ~= (if v2 < v3.next.y then true else false) and (v3.next.y ~= v3.y and v1 < (v3.next.x - v3.x) * (v2 - v3.y) / (v3.next.y - v3.y) + v3.x) then
			v4 = not v4
		end

		v3 = v3.next
	until v3 == p1

	return v4
end
function splitPolygon(p1, p2) --[[ splitPolygon | Line: 689 ]]
	local v1 = Node(p1.i, p1.x, p1.y)
	local v2 = Node(p2.i, p2.x, p2.y)
	local v3 = p1.next
	local prev = p2.prev

	p1.next = p2
	p2.prev = p1
	v1.next = v3
	v3.prev = v1
	v2.next = v1
	v1.prev = v2
	prev.next = v2
	v2.prev = prev

	return v2
end
function insertNode(p1, p2, p3, p4) --[[ insertNode | Line: 711 ]]
	local v1 = Node(p1, p2, p3)

	if p4 then
		v1.next = p4.next
		v1.prev = p4
		p4.next.prev = v1
		p4.next = v1
	else
		v1.prev = v1
		v1.next = v1
	end

	return v1
end
function removeNode(p1) --[[ removeNode | Line: 726 ]]
	p1.next.prev = p1.prev
	p1.prev.next = p1.next

	if p1.prevZ then
		p1.prevZ.nextZ = p1.nextZ
	end

	if not p1.nextZ then
		return
	end

	p1.nextZ.prevZ = p1.prevZ
end
function Node(p1, p2, p3) --[[ Node | Line: 738 ]]
	return {
		i = p1,
		x = p2,
		y = p3,
		prev = nil,
		next = nil,
		z = nil,
		prevZ = nil,
		nextZ = nil,
		steiner = false
	}
end
function deviation(p1, p2, p3, p4) --[[ deviation | Line: 767 | Upvalues: ZeroArray (copy) ]]
	local v1 = ZeroArray.new(p1)
	local v2 = ZeroArray.new(p2)
	local v3 = ZeroArray.new(p4)
	local v4

	if v2 then
		if #v2 > 0 then
			v2, v4 = true, v2
		else
			v2, v4 = false, v2
		end
	else
		v4 = v2
	end

	local v5, v6, v7

	if v2 then
		v5 = v4[0] * p3

		if v5 then
			v6 = v1
			v7 = v3
		else
			v7 = v3
			v6 = v1
			v5 = #v1
		end
	else
		v7 = v3
		v6 = v1
		v5 = #v1
	end

	local sum = math.abs((signedArea(v6, 0, v5, p3)))

	if v2 then
		local count = 0
		local v9 = #v4

		while count < v9 do
			sum = sum - math.abs((signedArea(v6, v4[count] * p3, count < v9 - 1 and v4[count + 1] * p3 or #v6, p3)))
			count = count + 1
		end
	end

	local sum2 = 0
	local sum3 = 0

	while sum2 < #v7 do
		local v13 = v7[sum2] * p3
		local v14 = v7[sum2 + 1] * p3
		local v15 = v7[sum2 + 2] * p3

		sum3 = sum3 + math.abs((v6[v13] - v6[v15]) * (v6[v14 + 1] - v6[v13 + 1]) - (v6[v13] - v6[v14]) * (v6[v15 + 1] - v6[v13 + 1]))
		sum2 = sum2 + 3
	end

	if sum == 0 and sum3 == 0 then
		return 0
	end

	return math.abs((sum3 - sum) / sum)
end
function signedArea(p1, p2, p3, p4) --[[ signedArea | Line: 806 ]]
	local sum, v1, sum2 = p2, p3 - p4, 0

	while sum < p3 do
		sum2 = sum2 + (p1[v1] - p1[sum]) * (p1[sum + 1] + p1[v1 + 1])
		sum, v1 = sum + p4, sum
	end

	return sum2
end
function flatten(p1) --[[ flatten | Line: 821 ]]
	local v1 = #p1[1][1]
	local t = {
		vertices = {},
		holes = {},
		dimensions = v1,
		max = {},
		min = {}
	}
	local sum = 1

	for i = 1, #p1 do
		for j = 1, #p1[i] do
			for k = 1, v1 do
				t.max[k] = math.max(t.max[k] or (-1 / 0), p1[i][j][k])
				t.min[k] = math.min(t.min[k] or (1 / 0), p1[i][j][k])
				table.insert(t.vertices, p1[i][j][k])
			end
		end

		if i > 1 then
			sum = sum + #p1[i - 1]
			table.insert(t.holes, sum)
		end
	end

	return t
end

local t = {
	Deviation = deviation,
	Flatten = flatten
}

return setmetatable(t, {
	__call = function(p1, ...) --[[ __call | Line: 850 ]]
		return earcut(...)
	end
})