

local Players = game:GetService("Players")
local Network = require(script.Parent.Parent.Internal.Network)
local Signal = require(script.Parent.Parent.Parent.Signal)
local Utils = require(script.Parent.Parent.Internal.Utils)
local Graph = require(script.Parent.Parent.Internal.Graph)

require(script.Parent.Parent.Internal.Types)

local Freeze = require(script.Parent.Parent.Parent.Freeze)
local n1 = 0
local t1 = {}
local t2 = {}
local t3 = {}

t3.__index = t3

function t3.new(t4: {[any]: any})
	assert(type(t4.Channel) == "string", `"Channel" expected string, got { type(t4.Channel) }`)
	assert(t4.ReplicateTo, "ReplicateTo is required!")

	local ReplicateTo = t4.ReplicateTo
	local v13

	if n1 + 1 > 65535 or #t1 >= 16 then
		v13 = table.remove(t1, 1)
	else
		n1 += 1
		v13 = n1
	end

	assert(v13, "No available ID!")
	assert(v13 <= 65535, `ID limit reached! You already have { 65535 } ServerReplions!`)

	local v14 = setmetatable({
		Data = t4.Data,
		Channel = t4.Channel,
		Tags = if not t4.Tags then {} else t4.Tags,
		ReplicateTo = ReplicateTo,
		DisableAutoDestroy = t4.DisableAutoDestroy,
		_id = v13,
		_packedId = utf8.char(v13),
		_beforeDestroy = Signal.new(),
		_rootNode = Graph.createRootNode(),
		_replicateToChanged = Signal.new()
	}, t3)

	Network.sendTo(ReplicateTo, "Added", v14:_serialize())

	return v14
end
function t3.__tostring(p1)
	local Channel = p1.Channel
	local ReplicateTo = p1.ReplicateTo
	local v21

	if type(ReplicateTo) == "table" then
		local t5 = {}

		for v19, v20 in ReplicateTo do
			t5[v19] = v20.Name
		end

		v21 = table.concat(t5, ", ")
	else
		v21 = if typeof(ReplicateTo) ~= "Instance" then ReplicateTo else ReplicateTo.Name
	end

	return `Replion<{ Channel }:{ v21 }>`
end
function t3._serialize(p2)
	return {
		p2._packedId,
		p2.Channel,
		p2.Data,
		p2.ReplicateTo,
		p2.Tags
	}
end
function t3.BeforeDestroy(p3, p4)
	return p3._beforeDestroy:Connect(p4)
end
function t3.OnDataChange(p5, p6)
	return Graph.connect(p5._rootNode, "onDataChange", { "__root" }, p6)
end
function t3.OnChange(p7, p8, p9)
	return Graph.connect(p7._rootNode, "onChange", p8, p9)
end
function t3.Observe(p10, p11, p12)
	task.spawn(function()
		p12(p10:Get(p11), nil)
	end)

	return Graph.connect(p10._rootNode, "onChange", p11, p12)
end
function t3.OnArrayInsert(p13, p14, p15)
	return Graph.connect(p13._rootNode, "onArrayInsert", p14, p15)
end
function t3.OnArrayRemove(p16, p17, p18)
	return Graph.connect(p16._rootNode, "onArrayRemove", p17, p18)
end
function t3.SetReplicateTo(p19, p20)
	assert(p20 == "All" or (type(p20) == "table" or typeof(p20) == "Instance" and p20:IsA("Player")), "ReplicateTo must be a Player, a table of Players or \"All\"")

	local ReplicateTo = p19.ReplicateTo

	if ReplicateTo == p20 then
		return
	end

	local v42 = if ReplicateTo ~= "All" then if type(ReplicateTo) ~= "table" then { ReplicateTo } else ReplicateTo else Players:GetPlayers()
	local v43 = if p20 ~= "All" then if type(p20) ~= "table" then { p20 } else p20 else Players:GetPlayers()

	for _, v45 in v42 do
		if not table.find(v43, v45) then
			Network.sendTo(v45, "Removed", p19._packedId)
		end
	end

	for _, v47 in v43 do
		if not table.find(v42, v47) then
			Network.sendTo(v47, "Added", p19:_serialize())
		end
	end

	p19.ReplicateTo = p20
	p19._replicateToChanged:Fire(p20, ReplicateTo)
	Network.sendTo(p20, "UpdateReplicateTo", p19._packedId, p20)
end
function t3.Set(p21, p22, p23)
	local v51 = Utils.getPathTable(p22)
	local v52 = Freeze.Dictionary.getIn(p21.Data, v51)

	if Freeze.Dictionary.equals(v52, p23) then
		if _G.__DEV__ and type(v52) == "table" then
			local v53, v54 = debug.info(2, "sl")
			local v55 = `{ v53 }:{ v54 }`
			local v56 = Utils.getPathString(p22)

			if not t2[v55] then
				if v52 == p23 then
					warn(`Warning: Skipping Replion:Set('{ v56 }') due to identical table references.\n` .. `Consider using Replion:Update('{ v56 }') at { v53 }:{ v54 } instead.`)
				elseif v52 ~= p23 and type(p23) == "table" then
					warn(`Warning: Replion:Set('{ v56 }') detected a new table reference, but all values inside are identical.\n` .. `This may indicate the use of a shallow clone for the table at Replion:Get('{ v56 }') without properly cloning nested values. ` .. `Review your table cloning logic at { v53 }:{ v54 }.`)
				end

				t2[v55] = true
			end
		end

		return v52
	end

	if _G.__DEV__ and type(v52) == "table" and type(p23) == "table" then
		local v57 = Freeze.Dictionary.keys(v52)
		local v58 = Freeze.Dictionary.keys(p23)

		if Freeze.List.equals(v57, v58) then
			local v59, v60 = debug.info(2, "sl")
			local v61 = Utils.getPathString(p22)
			local v62 = `{ v59 }:{ v60 }`

			if not t2[v62] then
				t2[v62] = true

				local v63 = Freeze.Dictionary.filter(p23, function(p24, p25)
					return not Freeze.Dictionary.equals(v52[p25], p24)
				end)

				if Freeze.Dictionary.count(v63) ~= Freeze.Dictionary.count(p23) then
					local s1 = ""

					for v65, v66 in v63 do
						s1 ..= ("\n\t%* = %*,"):format(v65, v66)
					end

					warn("Warning: Sending a table with identical keys but different values to the client.\n" .. `Consider using Replion:Update('{ v61 }', \{{ s1 }\n}) at { v59 }:{ v60 } for optimized updates.`)
				end
			end
		end
	end

	local v67 = Freeze.Dictionary.setIn(p21.Data, v51, p23)
	local Data = p21.Data

	p21.Data = v67
	Network.sendTo(p21.ReplicateTo, "Set", p21._packedId, p22, p23)
	Graph.fireEvent(p21._rootNode, "onDataChange", "__root", v67, v51)
	Graph.fireChange(p21._rootNode, v51, v67, Data)

	return p23
end
function t3.Update(p26, p27, p28)
	local v72 = if not p28 then nil else Utils.getPathTable(p27)
	local v73 = if not v72 then p26.Data else Freeze.Dictionary.getIn(p26.Data, v72)
	local v74 = p28 or p27
	local v75 = Freeze.Dictionary.filter(v74, function(p29, p30)
		if not v73 then
			return true
		end

		return not Freeze.Dictionary.equals(v73[p30], p29)
	end)

	if next(v75) == nil then
		return
	end

	local Data = p26.Data
	local v77 = if not v72 then Freeze.Dictionary.merge(p26.Data, v75) else Freeze.Dictionary.mergeIn(p26.Data, v72, v75)

	p26.Data = v77
	Graph.fireEvent(p26._rootNode, "onDataChange", "__root", v77, v72)
	Graph.fireChange(p26._rootNode, v72, v77, Data)

	local v78 = table.maxn(v75)
	local u79 = nil

	if v78 > 0 then
		local n2 = 0

		for v81 in v75 do
			n2 += 1

			if v81 ~= n2 then
				u79 = true

				break
			end
		end

		u79 = u79 or n2 ~= v78

		if _G.__DEV__ and u79 then
			local v82, v83 = debug.info(2, "sl")
			local v84 = `{ v82 }:{ v83 }`

			if not t2[v84] then
				t2[v84] = true
				warn("Warning: You're trying to send an unordered array to the client, RemotesEvents can't send unordered arrays.\n" .. "The array will be transformed into a dictionary to be sent to the client.\n" .. `at { v82 }:{ v83 }`)
			end
		end
	end

	local v85 = Freeze.Dictionary.map(v75, function(p31, p32)
		local v148 = if p31 ~= Freeze.None then p31 else Utils.SerializedNone

		if u79 then
			return v148, (tostring(p32))
		end

		return v148, p32
	end)

	if not v72 then
		Network.sendTo(p26.ReplicateTo, "Update", p26._packedId, v85, nil, u79)
	else
		Network.sendTo(p26.ReplicateTo, "Update", p26._packedId, p27, v85, u79)
	end
end
function t3.Increase(p33, p34, p35)
	assert(type(p35) == "number", `"amount" expected number, got { type(p35) }`)

	local Expect = p33:GetExpect(p34, `"{ Utils.getPathString(p34) }" is not a valid path!`)

	if p35 == 0 then
		return Expect
	end

	if _G.__DEV__ and type(Expect) ~= "number" then
		local v90, v91 = debug.info(2, "sl")
		local v92 = `{ v90 }:{ v91 }`

		if not t2[v92] then
			t2[v92] = true
			warn(`Warning: Attempt to increase non-numeric value at "{ Utils.getPathString(p34) }"\n` .. `Check if the path is correct at { v90 }:{ v91 }.`)
		end

		return Expect
	end

	return p33:Set(p34, Expect + p35)
end
function t3.Decrease(p36, p37, p38)
	return p36:Increase(p37, -p38)
end
function t3.Insert(p39, p40, p41, p42)
	local v100 = Utils.getPathTable(p40)
	local Expect = p39:GetExpect(p40, `"{ Utils.getPathString(p40) }" is not a valid path!`)
	local v102 = p42 or #Expect + 1
	local v103 = table.clone(Expect)

	table.insert(v103, v102, p41)

	local Data = p39.Data
	local v105 = Freeze.Dictionary.setIn(p39.Data, v100, v103)

	p39.Data = v105
	Graph.fireEvent(p39._rootNode, "onDataChange", "__root", v105, v100)
	Graph.fireEvent(p39._rootNode, "onArrayInsert", v100, v102, p41)
	Graph.fireChange(p39._rootNode, v100, v105, Data)
	Network.sendTo(p39.ReplicateTo, "ArrayUpdate", p39._packedId, "i", p40, p41, p42)
end
function t3.Remove(p43, p44, p45)
	local v109 = Utils.getPathTable(p44)
	local Expect = p43:GetExpect(p44, `"{ Utils.getPathString(p44) }" is not a valid path!`)
	local v111 = p45 or #Expect
	local v112 = Expect[v111]
	local v113 = table.clone(Expect)

	table.remove(v113, v111)

	local Data = p43.Data
	local v115 = Freeze.Dictionary.setIn(p43.Data, v109, v113)

	p43.Data = v115
	Graph.fireEvent(p43._rootNode, "onDataChange", "__root", v115, v109)
	Graph.fireEvent(p43._rootNode, "onArrayRemove", p44, v111, v112)
	Graph.fireChange(p43._rootNode, v109, v115, Data)
	Network.sendTo(p43.ReplicateTo, "ArrayUpdate", p43._packedId, "r", p44, p45)

	return v112
end
function t3.Clear(p46, p47)
	local Expect = p46:GetExpect(p47, `"{ Utils.getPathString(p47) }" is not a valid path!`)

	if next(Expect) == nil then
		return
	end

	local v119 = Utils.getPathTable(p47)
	local Data = p46.Data
	local v121 = Freeze.Dictionary.setIn(p46.Data, v119, {})

	p46.Data = v121
	Graph.fireEvent(p46._rootNode, "onDataChange", "__root", v121, v119)
	Graph.fireChange(p46._rootNode, v119, v121, Data)
	Network.sendTo(p46.ReplicateTo, "ArrayUpdate", p46._packedId, "c", p47)
end
function t3.Find(p48, p49, p50)
	local v125 = p48:Get(p49)

	if not v125 then
		return
	end

	local v126 = table.find(v125, p50)

	if not v126 then
		return
	end

	return v126, p50
end
function t3.Get(p51, p52)
	assert(p52, "Path is required!")

	local v129 = Utils.getPathTable(p52)
	local v130 = Freeze.Dictionary.getIn(p51.Data, v129)

	if _G.__DEV__ and v130 == nil then
		for v131, v132 in v129 do
			if type(v132) == "string" then
				local v133 = Utils.trimString(v132)

				if v133 ~= v132 then
					local v134 = Freeze.List.set(v129, v131, v133)

					if Freeze.Dictionary.getIn(p51.Data, v134) then
						local v135, v136 = debug.info(2, "sl")

						warn(`Warning: the path "{ Utils.getPathString(p52) }" has a key with leading or trailing whitespaces.\n` .. `This is likely a mistake, consider using "{ Utils.getPathString(v134) }" at { v135 }:{ v136 } instead.`)
					end
				end
			end
		end
	end

	return v130
end
function t3.GetExpect(p53, p54, p55)
	assert(p54, "Path is required!")

	if not p55 then
		p55 = `"{ Utils.getPathString(p54) }" is not a valid path!`
	end

	local v140 = p53:Get(p54)

	if v140 == nil then
		error(p55)
	end

	return v140
end
function t3.Destroy(p56)
	if p56.Destroyed then
		return
	end

	p56._beforeDestroy:Fire()
	p56._beforeDestroy:DisconnectAll()
	p56._replicateToChanged:Destroy()
	Graph.destroyRootNode(p56._rootNode)
	p56._rootNode = nil
	p56.Destroyed = true
	Network.sendTo(p56.ReplicateTo, "Removed", p56._packedId)

	if table.find(t1, p56._id) == nil then
		table.insert(t1, p56._id)
	end
end

return t3
