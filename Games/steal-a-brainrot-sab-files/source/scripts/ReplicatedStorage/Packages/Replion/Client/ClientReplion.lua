

local Freeze = require(script.Parent.Parent.Parent.Freeze)
local Utils = require(script.Parent.Parent.Internal.Utils)
local Signal = require(script.Parent.Parent.Parent.Signal)

require(script.Parent.Parent.Internal.Types)

local Graph = require(script.Parent.Parent.Internal.Graph)
local t1 = {}

t1.__index = t1

function t1.new(p1)
	return (setmetatable({
		Data = p1[3],
		Tags = p1[5],
		ReplicateTo = p1[4],
		_channel = p1[2],
		_beforeDestroy = Signal.new(),
		_rootNode = Graph.createRootNode()
	}, t1))
end
function t1.__tostring(p2)
	return `Replion<{ p2._channel }>`
end
function t1.BeforeDestroy(p3, p4)
	return p3._beforeDestroy:Connect(p4)
end
function t1.OnDataChange(p5, p6)
	return Graph.connect(p5._rootNode, "onDataChange", "__root", p6)
end
function t1.OnChange(p7, p8, p9)
	return Graph.connect(p7._rootNode, "onChange", p8, p9)
end
function t1.Observe(p10, p11, p12)
	task.spawn(function()
		p12(p10:Get(p11), nil)
	end)

	return Graph.connect(p10._rootNode, "onChange", p11, p12)
end
function t1.OnArrayInsert(p13, p14, p15)
	return Graph.connect(p13._rootNode, "onArrayInsert", p14, p15)
end
function t1.OnArrayRemove(p16, p17, p18)
	return Graph.connect(p16._rootNode, "onArrayRemove", p17, p18)
end
function t1._set(p19, p20, p21)
	local v27 = Utils.getPathTable(p20)

	if p21 == Freeze.Dictionary.getIn(p19.Data, v27) then
		return p21
	end

	local v28 = Freeze.Dictionary.setIn(p19.Data, v27, p21)
	local Data = p19.Data

	p19.Data = v28
	Graph.fireEvent(p19._rootNode, "onDataChange", "__root", v28, v27)
	Graph.fireChange(p19._rootNode, v27, v28, Data)

	return p21
end
function t1._update(p22, p23, p24, p25)
	local v34 = Freeze.Dictionary.map(p24 or p23, function(p26, p27)
		local v83 = if p26 ~= Utils.SerializedNone then p26 else Freeze.None

		if p25 then
			return v83, (tonumber(p27))
		end

		return v83, p27
	end)
	local v35 = Utils.getPathTable(p23)
	local Data = p22.Data
	local v37 = if p24 ~= nil then Freeze.Dictionary.mergeIn(p22.Data, v35, v34) else Freeze.Dictionary.merge(p22.Data, v34)

	p22.Data = v37
	Graph.fireEvent(p22._rootNode, "onDataChange", "__root", v37, v35)
	Graph.fireChange(p22._rootNode, v35, v37, Data)
end
function t1._increase(p28, p29, p30)
	return p28:_set(p29, p28:GetExpect(p29) + p30)
end
function t1._decrease(p31, p32, p33)
	return p31:_increase(p32, -p33)
end
function t1._insert(p34, p35, p36, p37)
	local v48 = Utils.getPathTable(p35)
	local v49 = assert(Freeze.Dictionary.getIn(p34.Data, v48), `"{ Utils.getPathString(p35) }" is not a valid path!`)
	local v50 = p37 or #v49 + 1
	local v51 = Freeze.List.insert(v49, v50, p36)
	local Data = p34.Data
	local v53 = Freeze.Dictionary.setIn(p34.Data, v48, v51)

	p34.Data = v53
	Graph.fireEvent(p34._rootNode, "onDataChange", "__root", v53, v48)
	Graph.fireEvent(p34._rootNode, "onArrayInsert", v48, v50, p36)
	Graph.fireChange(p34._rootNode, v48, v53, Data)
end
function t1._remove(p38, p39, p40)
	local v57 = Utils.getPathTable(p39)
	local Expect = p38:GetExpect(p39, `"{ Utils.getPathString(p39) }" is not a valid path!`)
	local v59 = p40 or #Expect
	local v60 = Expect[v59]
	local v61 = Freeze.List.remove(Expect, v59)
	local Data = p38.Data
	local v63 = Freeze.Dictionary.setIn(p38.Data, v57, v61)

	p38.Data = v63
	Graph.fireEvent(p38._rootNode, "onDataChange", "__root", v63, v57)
	Graph.fireEvent(p38._rootNode, "onArrayRemove", p39, v59, v60)
	Graph.fireChange(p38._rootNode, v57, v63, Data)

	return v60
end
function t1._clear(p41, p42)
	local v66 = Utils.getPathTable(p42)
	local Data = p41.Data
	local v68 = Freeze.Dictionary.setIn(p41.Data, v66, {})

	p41.Data = v68
	Graph.fireEvent(p41._rootNode, "onDataChange", "__root", v68, v66)
	Graph.fireChange(p41._rootNode, v66, v68, Data)
end
function t1.Find(p43, p44, p45)
	local v72 = p43:Get(p44)

	if not v72 then
		return
	end

	local v73 = table.find(v72, p45)

	if not v73 then
		return
	end

	return v73, p45
end
function t1.Get(p46, p47)
	return Freeze.Dictionary.getIn(p46.Data, Utils.getPathTable(p47))
end
function t1.GetExpect(p48, p49, p50)
	assert(p49, "Path is required!")

	if not p50 then
		p50 = `"{ Utils.getPathString(p49) }" is not a valid path!`
	end

	local v79 = p48:Get(p49)

	if v79 == nil then
		error(p50)
	end

	return v79
end
function t1.Destroy(p51)
	if p51.Destroyed then
		return
	end

	p51._beforeDestroy:Fire()
	p51._beforeDestroy:DisconnectAll()
	Graph.destroyRootNode(p51._rootNode)
	p51._rootNode = nil
	p51.Destroyed = true
end

return t1
