-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Data, time of decompilation: Sun May  3 10:10:36 2026 ]]
local ParentParent = script.Parent.Parent
local Signal = require(ParentParent.Signal)
local t1 = {}

t1.__index = t1

function t1.new(p1) -- line: 31
	-- upvalues: t1 (copy)
	local t2 = {
		_data = p1,
		_signals = {
			changed = {},
			indexChanged = {},
			arrayInserted = {},
			arrayRemoved = {}
		},
		_weakSignals = {
			changed = setmetatable({}, {
				__mode = "v"
			}),
			indexChanged = setmetatable({}, {
				__mode = "v"
			}),
			arrayInserted = setmetatable({}, {
				__mode = "v"
			}),
			arrayRemoved = setmetatable({}, {
				__mode = "v"
			})
		}
	}

	setmetatable(t2, t1)

	return t2
end

local function pathToString(p2) -- line: 53
	if type(p2) == "string" then
		return p2
	end

	local s1 = ""
	local v9 = #p2

	for i, v in ipairs(p2) do
		if type(v) == "number" then
			s1 ..= "#"
		end

		s1 ..= v

		if i < v9 then
			s1 ..= "."
		end
	end

	return s1
end

function t1.get(p3, p4) -- line: 74
	if not p4 then
		return p3._data
	end

	local _data = p3._data

	if type(p4) == "string" then
		return _data[p4]
	end

	for _, v in ipairs(p4) do
		_data = _data[v]
	end

	return _data
end
function t1.set(p5, p6, p7) -- line: 91
	local _data = p5._data

	if type(p6) == "string" then
		local v21 = _data[p6]

		_data[p6] = p7
		p5:_firePathChangedSignals(p6, v21)

		return
	end

	for i = 1, #p6 - 1 do
		_data = _data[p6[i]]
	end

	local v23 = _data[p6[#p6]]

	_data[p6[#p6]] = p7
	p5:_firePathChangedSignals(p6, v23)
end
function t1.update(p8, p9, p10: ((...any) -> ...any)) -- line: 109
	local v27 = p10((p8:get(p9)))

	p8:set(p9, v27)

	return v27
end
function t1.arrayInsert(p11, p12, p13, n1: number?) -- line: 116
	local v32 = p11:get(p12)

	assert(type(v32) == "table", "Data at path is not a table")

	if n1 then
		table.insert(v32, n1, p13)
	else
		table.insert(v32, p13)
	end

	local v33 = p11:_firePathChangedSignals(p12)
	local v34 = p11._signals.arrayInserted[v33]

	if v34 then
		v34:Fire(n1 or #v32, p13)
	end
end
function t1.arrayRemove(p14, p15, n2: number) -- line: 134
	local v38 = p14:get(p15)

	assert(type(v38) == "table", "Data at path is not a table")

	local v39 = table.remove(v38, n2)
	local v40 = p14:_firePathChangedSignals(p15)
	local v41 = p14._signals.arrayRemoved[v40]

	if v41 then
		v41:Fire(n2, v39)
	end

	return v39
end
function t1.getChangedSignal(p16, p17) -- line: 148
	return p16:_getSignal(p17, "changed")
end
function t1.getIndexChangedSignal(p18, p19) -- line: 152
	return p18:_getSignal(p19, "indexChanged")
end
function t1.getArrayInsertedSignal(p20, p21) -- line: 156
	return p20:_getSignal(p21, "arrayInserted")
end
function t1.getArrayRemovedSignal(p22, p23) -- line: 160
	return p22:_getSignal(p23, "arrayRemoved")
end
function t1._firePathChangedSignals(p24, p25, p26) -- line: 164
	if type(p25) == "string" then
		p24:_fireChangedSignal(p25, p24:get(p25), p26)

		return p25
	end

	local _data = p24._data
	local s2 = ""

	for i, v in ipairs(p25) do
		_data = _data[v]

		if i > 1 then
			p24:_fireIndexChangedSignal(s2, v, _data, p26)
			s2 ..= "."
		end

		if type(v) == "number" then
			s2 ..= "#"
		end

		s2 ..= v
		p24:_fireChangedSignal(s2, _data, p26)
	end

	return s2
end
function t1._fireChangedSignal(p27, s3: string, p28, p29) -- line: 192
	local v61 = p27._signals.changed[s3]

	if v61 then
		v61:Fire(p28, p29)
	end
end
function t1._fireIndexChangedSignal(p30, s4: string, p31, p32, p33) -- line: 199
	local v67 = p30._signals.indexChanged[s4]

	if v67 then
		v67:Fire(p31, p32, p33)
	end
end
function t1._getSignal(p34, p35, s5: string) -- line: 212
	-- upvalues: pathToString (copy), Signal (copy)
	local v71 = pathToString(p35)
	local v72 = p34._weakSignals[s5]
	local v73 = v72[v71]

	if v73 then
		return v73
	end

	local u74 = Signal.new()

	v72[v71] = u74

	local t3 = {
		Connect = u74.Connect,
		Once = u74.Once
	}
	local n3 = 0
	local v77 = p34._signals[s5]

	for v78, v79 in t3 do
		u74[v78] = function(_, p37: ((...any) -> ...any)) -- line: 227
			-- upvalues: v79 (copy), u74 (ref), n3 (ref), v77 (copy), v71 (copy)
			local v89 = v79(u74, p37)

			n3 += 1
			v77[v71] = u74

			local Disconnect = v89.Disconnect

			function v89.Disconnect() -- line: 233
				-- upvalues: v89 (copy), n3 (ref), v77 (copy), v71 (copy), Disconnect (copy)
				if v89.Connected then
					n3 -= 1

					if n3 <= 0 then
						v77[v71] = nil
					end
				end

				Disconnect(v89)
			end

			v89.Destroy = v89.Disconnect

			return v89
		end
	end

	local Destroy = u74.Destroy

	function u74.Destroy() -- line: 249
		-- upvalues: n3 (ref), v77 (copy), v71 (copy), v72 (copy), Destroy (copy), u74 (ref)
		n3 = 0
		v77[v71] = nil
		v72[v71] = nil
		Destroy(u74)
	end

	local DisconnectAll = u74.DisconnectAll

	function u74.DisconnectAll() -- line: 257
		-- upvalues: n3 (ref), v77 (copy), v71 (copy), DisconnectAll (copy), u74 (ref)
		n3 = 0
		v77[v71] = nil
		DisconnectAll(u74)
	end

	return u74
end
function t1.destroy(p38) -- line: 266
	for _, v84 in p38._signals do
		for _, v86 in v84 do
			v86:Destroy()
		end
	end

	p38._signals = nil
end

return t1
