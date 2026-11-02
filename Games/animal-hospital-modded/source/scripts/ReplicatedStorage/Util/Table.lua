local t = {
	Size = function(p1) --[[ Size | Line: 3 ]]
		local count = 0

		for v1, v2 in next, p1 do
			count = count + 1
		end

		return count
	end,
	IsEmpty = function(p1) --[[ IsEmpty | Line: 11 ]]
		for v1, v2 in next, p1 do
			return
		end

		return true
	end,
	Scramble = function(p1, p2) --[[ Scramble | Line: 18 ]]
		local v1 = if p2 then p2 else #p1
		local v2 = v1

		for i = 1, v1 do
			local v3 = Random.new():NextInteger(1, v2)
			local v4 = p1[i]

			p1[i] = p1[v3]
			p1[v3] = v4
		end

		return p1
	end,
	DictionarySelectRandom = function(p1) --[[ DictionarySelectRandom | Line: 31 ]]
		local t = {}

		for k, v in pairs(p1) do
			table.insert(t, k)
		end

		if #t == 0 then
			return
		end

		if #t == 1 then
			local v1 = t[1]

			return v1, p1[v1]
		end

		local v2 = t[Random.new():NextInteger(1, #t)]

		return v2, p1[v2]
	end
}

function t.DeepCopy(p1) --[[ DeepCopy | Line: 53 | Upvalues: t (copy) ]]
	local t2 = {}

	for v1, v2 in next, p1 do
		if type(v2) == "table" then
			v2 = t.DeepCopy(v2)
		end

		t2[v1] = v2
	end

	return t2
end
function t.DeepPrint(p1) --[[ DeepPrint | Line: 65 | Upvalues: t (copy) ]]
	print("{ ")

	for v1, v2 in next, p1 do
		if type(v2) == "table" then
			print("[" .. v1 .. "] = ")
			t.DeepPrint(v2)

			continue
		end

		print("[" .. v1 .. "] =", v2)
	end

	print(" }")
end
function t.Copy(p1) --[[ Copy | Line: 79 ]]
	local t = {}

	for v1, v2 in next, p1 do
		t[v1] = v2
	end

	return t
end
function t.DeepSearch(p1, p2) --[[ DeepSearch | Line: 88 | Upvalues: t (copy) ]]
	local v1 = ""

	for v2, v3 in next, p1 do
		if type(v3) == "table" then
			v1 = v1 .. t.DeepSearch(v3, v2)
		end

		if type(v2) ~= "string" and type(v2) ~= "number" then
			v1 = v1 .. v2 .. type(v2) .. (p2 or "")
		end
	end

	return v1
end
function t.BindClean(p1, p2) --[[ BindClean | Line: 102 ]]
	game.Players.PlayerRemoving:Connect(function(p12) --[[ Line: 103 | Upvalues: p2 (copy), p1 (copy) ]]
		if p2 then
			p2(p12)
		end

		p1[p12] = nil
	end)
end

return t