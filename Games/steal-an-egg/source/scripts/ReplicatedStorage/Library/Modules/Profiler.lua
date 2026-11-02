-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	tags = {},
	tagStack = {}
}

function t.BeginSample(p1, p2) --[[ BeginSample | Line: 7 | Upvalues: t (copy) ]]
	local v1 = p1.tags[p2]

	if v1 == nil then
		v1 = {
			averages = {},
			average = 0,
			currentSample = 0
		}
		p1.tags[p2] = v1
	end

	v1._startTime = os.clock()
	table.insert(t.tagStack, p2)
end
function t.EndSample(p1) --[[ EndSample | Line: 22 | Upvalues: t (copy) ]]
	if #t.tagStack == 0 then
		warn("Profile tagstack already empty")

		return
	end

	local v1 = t.tags[t.tagStack[#t.tagStack]]

	table.remove(t.tagStack, #t.tagStack)
	v1.currentSample = os.clock() - v1._startTime
	table.insert(v1.averages, v1.currentSample)

	if not (#v1.averages > 10) then
		return
	end

	table.remove(v1.averages, 1)
end
function t.Print(p1, p2) --[[ Print | Line: 38 | Upvalues: t (copy) ]]
	local v1 = t.tags[p2]

	if v1 == nil then
		warn("Unknown tag")

		return
	end

	local sum = 0
	local count = 0

	for v2, v3 in v1.averages do
		sum = sum + v3
		count = count + 1
	end

	print(p2, string.format("%.3f", v1.currentSample * 1000) .. "ms avg:", string.format("%.3f", sum / count * 1000) .. "ms")
end

local _ = os.clock() + 1

return t