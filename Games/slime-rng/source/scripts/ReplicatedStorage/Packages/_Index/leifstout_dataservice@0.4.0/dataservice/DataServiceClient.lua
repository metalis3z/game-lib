-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DataServiceClient, time of decompilation: Sun May  3 10:10:36 2026 ]]
if game:GetService("RunService"):IsServer() then
	return {}
end

local ParentParent = script.Parent.Parent
local Signal = require(ParentParent.Signal)
local Networker = require(ParentParent.Networker)
local DataServiceUtils = require(script.Parent.DataServiceUtils)
local Data = require(script.Parent.Data)
local v6 = Signal.new()
local t1 = {
	_data = nil,
	init = function(p1, p2) --[[ init ]] -- line: 42
		-- upvalues: Networker (copy)
		p1.networker = Networker.client.new("DataService", p1)

		if p2 then
			p1:_initData(p2)
		end

		p1:waitForData()
	end,
	fetch = function(p3, p4, b1: boolean?) --[[ fetch ]] -- line: 71
		local v13 = p3.networker:fetch("get", p4)

		if not b1 then
			p3._data:set(p4, v13)
		end

		return v13
	end,
	get = function(p5, p6) --[[ get ]] -- line: 96
		p5:waitForData()

		return p5._data:get(p6)
	end,
	set = function(p7, p8, p9) --[[ set ]] -- line: 118
		p7._data:set(p8, p9)
	end,
	update = function(p10, p11, p12: ((...any) -> ...any)) --[[ update ]] -- line: 142
		return p10._data:update(p11, p12)
	end,
	arrayInsert = function(p13, p14, p15, n1: number?) --[[ arrayInsert ]] -- line: 164
		p13._data:arrayInsert(p14, p15, n1)
	end,
	arrayRemove = function(p16, p17, n2: number) --[[ arrayRemove ]] -- line: 185
		return p16._data:arrayRemove(p17, n2)
	end,
	getChangedSignal = function(p18, p19) --[[ getChangedSignal ]] -- line: 204
		return p18._data:getChangedSignal(p19)
	end,
	getIndexChangedSignal = function(p20, p21) --[[ getIndexChangedSignal ]] -- line: 223
		return p20._data:getIndexChangedSignal(p21)
	end,
	getArrayInsertedSignal = function(p22, p23) --[[ getArrayInsertedSignal ]] -- line: 242
		return p22._data:getArrayInsertedSignal(p23)
	end,
	getArrayRemovedSignal = function(p24, p25) --[[ getArrayRemovedSignal ]] -- line: 261
		return p24._data:getArrayRemovedSignal(p25)
	end,
	waitForData = function(p26) --[[ waitForData ]] -- line: 273
		-- upvalues: v6 (copy)
		local _data = p26._data

		if _data then
			return _data
		end

		v6:Wait()

		return p26._data
	end,
	_initData = function(p27, p28) --[[ _initData ]] -- line: 283
		-- upvalues: Data (copy), v6 (copy)
		assert(p27._data == nil, "DataServiceClient: Data already initialized")
		p27._data = Data.new(p28)
		v6:Fire()
	end
}

t1[DataServiceUtils.enums.actions.set] = t1.set
t1[DataServiceUtils.enums.actions.arrayInsert] = t1.arrayInsert
t1[DataServiceUtils.enums.actions.arrayRemove] = t1.arrayRemove
t1[DataServiceUtils.enums.actions.init] = t1._initData

return t1
