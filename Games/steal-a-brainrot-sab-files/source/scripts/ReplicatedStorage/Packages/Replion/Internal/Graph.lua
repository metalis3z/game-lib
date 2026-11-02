

--!native
local Signal = require(script.Parent.Parent.Parent.Signal)

require(script.Parent.Types)

local t1 = {
	n = 0
}

local function get(t2: {[any]: any}?, s1: string)
	if not t2 or type(t2) ~= "table" then
		return nil
	end

	return t2[s1]
end
local function getPathTable(p1)
	if type(p1) == "table" then
		return p1
	end

	if type(p1) == "string" then
		return string.split(p1, ".")
	end

	return { p1 }
end
local function destroySignal(t3: {[any]: any}, s2: string)
	if not t3.events then
		return
	end

	local v11 = t3.events[s2]

	if not v11 then
		return
	end

	v11:Destroy()
	t3.events[s2] = nil

	if next(t3.events) then
		return
	end

	t3.events = nil

	while t3.parent do
		local parent = t3.parent

		if t3.events or t3.children and next(t3.children) then
			return
		end

		assert(parent.children, "Parent node has no children!")
		parent.children[t3.id] = nil
		t3 = parent
	end
end

function getSignal(t4: {[any]: any}?, s3: string, p2, b1: boolean?)
	local v18 = b1 == nil or b1

	if not t4 then
		error("You are trying to use a destroyed Replion!")
	end

	local v19, v20

	if type(p2) == "table" then
		v19 = nil
		v20 = nil
	elseif type(p2) == "string" then
		p2, v19, v20 = string.split(p2, ".")
	else
		p2 = { p2 }
		v19 = nil
		v20 = nil
	end

	for _, v22 in p2, v19, v20 do
		if not t4.children or not t4.children[v22] then
			if not v18 then
				return nil
			end

			local v23 = t4.children or {}

			v23[v22] = {
				parent = t4,
				id = v22
			}
			t4.children = v23
		end

		t4 = if not t4.children then nil else t4.children[v22]

		if not t4 then
			return nil
		end
	end

	local events = t4.events

	if v18 and (not events or not events[s3]) then
		local v25 = Signal.new()
		local Connect = v25.Connect

		function v25.Connect(p3, p4)
			local v84 = Connect(p3, p4)
			local Disconnect = v84.Disconnect

			function v84.Disconnect(p5)
				Disconnect(p5)

				if not v25._handlerListHead then
					destroySignal(t4, s3)
				end
			end

			v84.Destroy = v84.Disconnect

			return v84
		end

		if not events then
			events = {
				[s3] = v25
			}
			t4.events = events
		else
			events[s3] = v25
		end
	end

	return if not events then nil else events[s3]
end
function fireEvent(t5: {[any]: any}?, s4: string, p6, ...)
	assert(t5, "You cannot connect to a destroyed Replion!")

	local v30 = getSignal(t5, s4, p6, false)

	if v30 then
		v30:Fire(...)
	end
end
function connect(t6: {[any]: any}?, s5: string, p7, p8: ((...any) -> ...any))
	assert(t6, "You cannot connect to a destroyed Replion!")

	if _G.__DEV__ and not _G.__IGNORE_INSTANCES_WARNING__ then
		local v35 = false
		local v36, v37, v38

		if type(p7) == "table" then
			v36 = p7
			v37 = nil
			v38 = nil
		elseif type(p7) == "string" then
			v36, v37, v38 = string.split(p7, ".")
		else
			v36 = { p7 }
			v37 = nil
			v38 = nil
		end

		for _, v40 in v36, v37, v38 do
			if typeof(v40) == "Instance" then
				v35 = true

				break
			end
		end

		if v35 then
			local v41, v42 = debug.info(3, "sl")

			task.spawn(error, `[Memory Leak Warning] Instance used as a Connection index at { v41 }:{ v42 }. ` .. "Using Instances will cause memory leaks as Replion cannot automatically " .. "dispose of such connections. Consider using a string or number as your index to prevent this issue.")
		end
	end

	return assert(getSignal(t6, s5, p7), "Signal does not exist!"):Connect(p8)
end

return {
	createRootNode = function()
		local v69 = t1

		v69.n = v69.n + 1

		local t7 = {
			children = {}
		}

		t1[t1.n] = t7

		return t7
	end,
	destroyRootNode = function(t8: {[any]: any}?)
		if not t8 then
			return
		end

		local v72 = table.find(t1, t8)

		if not v72 then
			return
		end

		t1[v72] = t1[t1.n]
		t1[t1.n] = nil

		local v73 = t1

		v73.n = v73.n - 1

		local t9 = { t8 }
		local n1 = 1
		local n2 = 1

		while n1 <= n2 do
			local v77 = t9[n1]

			n1 += 1

			if v77.events then
				for _, v79 in v77.events do
					v79:Destroy()
				end

				v77.events = nil
			end

			if v77.children then
				for _, v81 in v77.children do
					n2 += 1
					t9[n2] = v81
				end
			end

			v77.children = nil
			v77.parent = nil
		end
	end,
	getSignal = getSignal,
	fireChange = function(t10: {[any]: any}?, p9, p10, p11)
		assert(t10, "You cannot connect to a destroyed Replion!")

		if not t10.children then
			return
		end

		if p9 then
			local v47 = if type(p9) ~= "table" then if type(p9) ~= "string" then { p9 } else string.split(p9, ".") else p9
			local v48 = t10
			local v49 = p10
			local v50 = p11

			for i = 1, #v47 + 1 do
				if v48.events and v48.events.onChange then
					if v49 ~= v50 then
						v48.events.onChange:Fire(v49, v50)
					end

					t10 = v48
					p10 = v49
					p11 = v50
				end

				if not (i <= #v47) then
					continue
				end

				local v52 = v47[i]

				if not v48.children or not v48.children[v52] then
					return
				end

				v48 = v48.children[v52]
				v49 = if not not v49 and type(v49) == "table" then v49[v52] else nil
				v50 = if not not v50 and type(v50) == "table" then v50[v52] else nil
			end
		end

		local n3 = 1
		local n4 = 0
		local t11 = {}
		local t12 = {}
		local t13 = {}

		if not p9 then
			n4 = 1
			t11[1] = t10
			t12[1] = p10
			t13[1] = p11
		else
			if not t10.children or type(p10) ~= "table" or type(p11) ~= "table" then
				return
			end

			for v58, v59 in t10.children do
				local v60 = p10[v58]
				local v61 = p11[v58]

				if v60 ~= v61 then
					n4 += 1
					t11[n4] = v59
					t12[n4] = v60
					t13[n4] = v61
				end
			end
		end

		while n3 <= n4 do
			local v62 = t11[n3]
			local v63 = t12[n3]
			local v64 = t13[n3]

			n3 += 1

			if v62.events and v62.events.onChange then
				v62.events.onChange:Fire(v63, v64)
			end

			if v62.children and type(v63) == "table" and type(v64) == "table" then
				for v65, v66 in v62.children do
					local v67 = v63[v65]
					local v68 = v64[v65]

					if v67 ~= v68 then
						n4 += 1
						t11[n4] = v66
						t12[n4] = v67
						t13[n4] = v68
					end
				end
			end
		end
	end,
	fireEvent = fireEvent,
	connect = connect
}
