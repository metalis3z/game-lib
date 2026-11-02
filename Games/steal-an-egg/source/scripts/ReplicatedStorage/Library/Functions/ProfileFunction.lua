-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local finally = require(script.Parent.finally)
local t = {}
local t2 = {}
local t3 = {
	"Tag",
	"Count",
	"Total",
	"Avg",
	"Max",
	"TotalBytes",
	"AvgBytes",
	"MaxBytes",
	"ByteRate"
}
local t4 = {
	80,
	10,
	10,
	10,
	10,
	10,
	10,
	10,
	10
}
local v1 = nil
local t5 = {
	["nil"] = 0,
	boolean = 1,
	number = 8,
	string = function(p1) --[[ Line: 31 ]]
		return #p1 * 2 + 4
	end,
	Instance = 8,
	["function"] = 8,
	thread = 8,
	userdata = 8,
	Vector2 = 8,
	Vector3 = 12,
	Color3 = 3,
	CFrame = 48,
	UDim = 8,
	UDim2 = 16,
	Enum = 4,
	EnumItem = 8,
	Ray = 24,
	Rect = 16,
	Region3 = 24,
	TweenInfo = 24,
	table = function(p1) --[[ Line: 50 | Upvalues: v1 (ref) ]]
		local sum = 8

		if #p1 > 0 then
			for i, v in ipairs(p1) do
				sum = sum + v1(v)
			end
		else
			for k, v in pairs(p1) do
				sum = sum + v1(k) + v1(v)
			end
		end

		return sum
	end
}

v1 = function(p1) --[[ Line: 65 | Upvalues: t5 (copy) ]]
	local v1 = t5[typeof(p1)]

	if not v1 then
		return 51
	end

	if type(v1) == "number" then
		return 1 + v1
	end

	local ok, result = pcall(v1, p1)

	if ok then
		return 1 + result
	end

	return 501
end
t2.ComputeSize = v1
function t2.Add(p1, p2) --[[ Add | Line: 83 | Upvalues: t (copy), v1 (ref), finally (copy) ]]
	assert(if type(p1) == "string" then true else false)
	assert(if type(p2) == "function" then true else false)

	local v3 = t[p1]

	if not v3 then
		v3 = {
			Count = 0,
			Total = 0,
			Avg = 0,
			Max = 0,
			TotalBytes = 0,
			AvgBytes = 0,
			MaxBytes = 0,
			Tag = p1
		}
		t[p1] = v3
	end

	return function(...) --[[ Line: 100 | Upvalues: v1 (ref), finally (ref), p2 (copy), p1 (copy), v3 (ref) ]]
		local v12 = v1(table.pack(...))
		local v2 = os.clock()

		return finally(p2, function() --[[ Line: 103 | Upvalues: v12 (copy), p1 (ref), v2 (copy), v3 (ref) ]]
			if v12 > 100000 then
				warn("[PacketProfiler] Packet of " .. v12 .. " sent for \'" .. p1 .. "\'!")
			end

			local v1 = os.clock()
			local v22 = v1 - v2
			local v4, v6

			if v3.First then
				local v32, v5, v7

				v3.Count = v3.Count + 1
				v3.Total = v3.Total + v22
				v3.Avg = v3.Total / v3.Count
				v32 = v3
				v4 = v3.Max
				v3.Max = math.max(v4, v22)
				v3.TotalBytes = v3.TotalBytes + v12
				v3.AvgBytes = v3.TotalBytes / v3.Count
				v5 = v3
				v6 = v3.MaxBytes
				v7 = v12
				v3.MaxBytes = math.max(v6, v12)

				return
			end

			v3.First = v1
			v3.Count = v3.Count + 1
			v3.Total = v3.Total + v22
			v3.Avg = v3.Total / v3.Count
			v4 = v3.Max
			v3.Max = math.max(v4, v22)
			v3.TotalBytes = v3.TotalBytes + v12
			v3.AvgBytes = v3.TotalBytes / v3.Count
			v6 = v3.MaxBytes
			v3.MaxBytes = math.max(v6, v12)
		end, ...)
	end
end
function t2.AddManually(p1, ...) --[[ AddManually | Line: 123 | Upvalues: t (copy), v1 (ref) ]]
	assert(type(p1) == "string")

	local v2 = t[p1]

	if not v2 then
		local t2 = {
			Count = 0,
			Total = 0,
			Avg = 0,
			Max = 0,
			TotalBytes = 0,
			AvgBytes = 0,
			MaxBytes = 0,
			Tag = p1
		}

		t[p1] = t2
		v2 = t2
	end

	local v3 = v1(table.pack(...))
	local v4 = os.clock()

	if not v2.First then
		v2.First = v4
	end

	v2.Count = v2.Count + 1
	v2.Total = v2.Total + 0
	v2.Avg = v2.Total / v2.Count
	v2.Max = math.max(v2.Max, 0)
	v2.TotalBytes = v2.TotalBytes + v3
	v2.AvgBytes = v2.TotalBytes / v2.Count
	v2.MaxBytes = math.max(v2.MaxBytes, v3)
end
function t2.Reset() --[[ Reset | Line: 153 | Upvalues: t (copy) ]]
	for k, v in pairs(t) do
		v.First = nil
		v.Count = 0
		v.Total = 0
		v.Avg = 0
		v.Max = 0
		v.TotalBytes = 0
		v.AvgBytes = 0
		v.MaxBytes = 0
	end
end
function t2.Print() --[[ Print | Line: 166 | Upvalues: t (copy), t3 (copy), t4 (copy) ]]
	if not next(t) then
		return
	end

	local list = {}

	for k, v in pairs(t) do
		table.insert(list, v)
	end

	table.sort(list, function(p1, p2) --[[ Line: 172 ]]
		return p1.TotalBytes > p2.TotalBytes
	end)

	local v1 = os.clock()
	local list2 = {}

	for i, v in ipairs(list) do
		if v.Count ~= 0 and v.First then
			table.insert(list2, {
				v.Tag,
				("%*"):format(string.format("%d", v.Count)),
				("%*ms"):format(string.format("%0.2f", v.Total * 1000)),
				("%*ms"):format(string.format("%0.2f", v.Avg * 1000)),
				("%*ms"):format(string.format("%0.2f", v.Max * 1000)),
				("%*kb"):format(string.format("%0.2f", v.TotalBytes / 1024)),
				("%*kb"):format(string.format("%0.2f", v.AvgBytes / 1024)),
				("%*kb"):format(string.format("%0.2f", v.MaxBytes / 1024)),
				("%*kb/s"):format(string.format("%0.2f", v.TotalBytes / (v1 - v.First) / 1024))
			})
		end
	end

	local v3 = "\n------------ BENCHMARKS ------------\n"

	for i, v in ipairs(t3) do
		v3 = v3 .. pad(v, t4[i])
	end

	local v4 = v3 .. "\n"

	for i, v in ipairs(list2) do
		for i2, v2 in ipairs(v) do
			v4 = v4 .. pad(tostring(v2), t4[i2])
		end

		v4 = v4 .. "\n"
	end

	for i, v in ipairs(t3) do
		v4 = v4 .. pad(v, t4[i])
	end

	print(v4 .. "\n------------ BENCHMARKS ------------\n")
end
function pad(p1, p2) --[[ pad | Line: 212 ]]
	local v1 = p1:len()

	if v1 < p2 then
		p1 = p1 .. string.rep(" ", p2 - v1)
	end

	return p1
end

return t2