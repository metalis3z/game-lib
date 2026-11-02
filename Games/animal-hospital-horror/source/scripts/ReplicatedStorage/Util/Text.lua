local t = {}
local TextService = game:GetService("TextService")
local t2 = {
	K = 1000,
	M = 1000000,
	B = 1000000000,
	Q = 1000000000000
}

function t.FormatNumber(p1) --[[ FormatNumber | Line: 5 | Upvalues: t2 (copy) ]]
	local v1 = 1
	local v2 = ""

	for v3, v4 in next, t2 do
		if v4 <= p1 and v1 < v4 then
			v1 = v4
			v2 = v3 .. "+"
		end
	end

	local v6 = #tostring((math.floor(p1 / v1)))

	return string.sub(tostring(p1 / v1), 1, v6 + 2) .. v2
end
t.AddUnits = t.FormatNumber
function t.DotsFromIterator(p1, p2) --[[ DotsFromIterator | Line: 21 ]]
	return string.rep(".", (p1 - 1) % (p2 or 3) + 1)
end
function t.AddCommas(p1) --[[ AddCommas | Line: 26 ]]
	local v2 = tostring((math.floor(p1)))
	local v3 = string.len(v2)

	if v3 / 3 >= 1 then
		local v4 = v2

		for i = 1, math.floor((v3 - 1) / 3) do
			local v5 = string.len(v4) - i * 3 - i + 1

			v4 = string.sub(v4, 1, v5) .. "," .. string.sub(v4, i * -3 - i + 1)
		end

		v2 = v4
	end

	return v2
end
function t.MaxLength(p1) --[[ MaxLength | Line: 41 ]]
	return string.sub(p1, 1, 22)
end
function t.FilterName(p1, p2) --[[ FilterName | Line: 45 | Upvalues: TextService (copy) ]]
	local v1 = TextService:FilterStringAsync(p2, p1.UserId)

	return v1:GetNonChatStringForBroadcastAsync(), v1
end
function t.Rainbowify(p1) --[[ Rainbowify | Line: 54 ]]
	local count = Random.new():NextNumber() * 16
	local v1 = ""

	for v2, v3 in utf8.graphemes(p1) do
		local v4 = p1:sub(v2, v3)
		local v5 = if v4 == " " then false else true

		v1 = v1 .. (if v5 then ("<font color=\"#%s\">%s</font>"):format(Color3.fromHSV(count / 16 % 1, 0.75, 1):ToHex(), v4) else v4)

		if v5 then
			count = count + 1
		end
	end

	return v1
end

return t