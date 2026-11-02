-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Janitor, time of decompilation: Sun May  3 10:09:36 2026 ]]
local Heartbeat = game:GetService("RunService").Heartbeat
local v2 = newproxy(true)

getmetatable(v2).__tostring = function() -- line: 31
	return "IndicesReference"
end

local v3 = newproxy(true)

getmetatable(v3).__tostring = function() -- line: 36
	return "LinkToInstanceIndex"
end

local t1 = {
	IGNORE_MEMORY_DEBUG = true,
	ClassName = "Janitor",
	__index = {
		CurrentlyCleaning = true,
		[v2] = nil
	}
}
local t2 = {
	["function"] = true,
	Promise = "cancel",
	RBXScriptConnection = "Disconnect"
}

function t1.new() -- line: 58
	-- upvalues: v2 (copy), t1 (copy)
	return (setmetatable({
		CurrentlyCleaning = false,
		[v2] = nil
	}, t1))
end
function t1.Is(p1) -- line: 65
	-- upvalues: t1 (copy)
	return type(p1) == "table" and getmetatable(p1) == t1
end

t1.is = t1.Is

function t1.__index.Add(p2, p3, p4, p5) -- line: 71
	-- upvalues: v2 (copy), t2 (copy)
	if p5 then
		p2:Remove(p5)

		local v15 = p2[v2]

		if not v15 then
			v15 = {}
			p2[v2] = v15
		end

		v15[p5] = p3
	end

	local v16 = typeof(p3)

	if v16 == "table" and string.match(tostring(p3), "Promise") then
		v16 = "Promise"
	end

	local v17 = p4 or (t2[v16] or "Destroy")

	if type(p3) ~= "function" and not p3[v17] then
		warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(p3), tostring(v17), debug.traceback(nil, 2)))
	end

	p2[p3] = {
		v17,
		(debug.traceback(""))
	}

	return p3
end

t1.__index.Give = t1.__index.Add

function t1.__index.AddPromise(p6, p7) -- line: 103
	local v20 = false

	if v20 then
		if not v20.is(p7) then
			error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof(p7), (tostring(p7))))
		end

		if p7:getStatus() == v20.Status.Started then
			local v21 = newproxy(false)
			local v22 = p6:Add(v20.new(function(p8, _, p10) -- line: 111
				-- upvalues: p7 (copy)
				if p10(function() -- line: 112
					-- upvalues: p7 (copy)
					p7:cancel()
				end) then
					return
				end

				p8(p7)
			end), "cancel", v21)

			v22:finallyCall(p6.Remove, p6, v21)

			return v22
		end

		return p7
	end

	return p7
end

t1.__index.GivePromise = t1.__index.AddPromise

function t1.__index.AddObject(p11, p12) -- line: 133
	local v25 = newproxy(false)
	local v26 = false

	if v26 and v26.is(p12) then
		if p12:getStatus() == v26.Status.Started then
			local v27 = p11:Add(v26.resolve(p12), "cancel", v25)

			v27:finallyCall(p11.Remove, p11, v25)

			return v27, v25
		end

		return p12
	end

	return p11:Add(p12, false, v25), v25
end

t1.__index.GiveObject = t1.__index.AddObject

function t1.__index.Remove(p13, p14) -- line: 151
	-- upvalues: v2 (copy)
	local v30 = p13[v2]

	if v30 then
		local v31 = v30[p14]

		if v31 then
			local v32 = p13[v31]
			local v33 = v32 and v32[1]

			if v33 then
				if v33 == true then
					v31()
				else
					local v34 = v31[v33]

					if v34 then
						v34(v31)
					end
				end

				p13[v31] = nil
			end

			v30[p14] = nil
		end
	end

	return p13
end
function t1.__index.Get(p15, p16) -- line: 180
	-- upvalues: v2 (copy)
	local v37 = p15[v2]

	if v37 then
		return v37[p16]
	end

	return nil
end
function t1.__index.Cleanup(p17) -- line: 188
	-- upvalues: v2 (copy)
	if not p17.CurrentlyCleaning then
		p17.CurrentlyCleaning = nil

		for k, v in next, p17 do
			if k ~= v2 then
				local v41 = type(k)

				if v41 == "string" or v41 == "number" then
					p17[k] = nil
				else
					local v42 = v[1]
					local v43 = v[2]

					if v42 == true then
						local ok, result = pcall(k)

						if not ok then
							local trace = debug.traceback("", 3)

							warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. trace .. "" .. v43)
						end
					else
						local v47 = k[v42]

						if v47 then
							local ok, result = pcall(v47, k)
							local v50 = typeof(k) == "Instance" and v47 == "Destroy"

							if not ok and not v50 then
								local trace = debug.traceback("", 3)

								warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. trace .. "" .. v43)
							end
						end
					end

					p17[k] = nil
				end
			end
		end

		local v52 = p17[v2]

		if v52 then
			for k in next, v52 do
				v52[k] = nil
			end

			p17[v2] = {}
		end

		p17.CurrentlyCleaning = false
	end
end

t1.__index.Clean = t1.__index.Cleanup

function t1.__index.Destroy(p18) -- line: 244
	p18:Cleanup()
end

t1.__call = t1.__index.Cleanup

local t3 = {
	Connected = true
}

t3.__index = t3

function t3.Disconnect(p19) -- line: 254
	if p19.Connected then
		p19.Connected = false
		p19.Connection:Disconnect()
	end
end
function t3.__tostring(p20) -- line: 261
	return "Disconnect<" .. tostring(p20.Connected) .. ">"
end
function t1.__index.LinkToInstance(p21, p22, p23) -- line: 265
	-- upvalues: v3 (copy), t3 (copy), Heartbeat (copy)
	local connection = nil
	local v61 = p23 and newproxy(false) or v3
	local u62 = p22.Parent == nil
	local v63 = setmetatable({}, t3)

	connection = p22.AncestryChanged:Connect(function(_, parent) --[[ ChangedFunction ]] -- line: 271
		-- upvalues: v63 (copy), u62 (ref), Heartbeat (copy), connection (ref), p21 (copy)
		if v63.Connected then
			u62 = parent == nil

			if u62 then
				coroutine.wrap(function() -- line: 277
					-- upvalues: Heartbeat (copy), v63 (copy), connection (ref), p21 (copy), u62 (ref)
					Heartbeat:Wait()

					if not v63.Connected then
						return
					end

					if not connection.Connected then
						p21:Cleanup()

						return
					end

					while u62 and connection.Connected and v63.Connected do
						Heartbeat:Wait()
					end

					if v63.Connected and u62 then
						p21:Cleanup()
					end
				end)()
			end
		end
	end)
	v63.Connection = connection

	if u62 then
		local p22Parent = p22.Parent

		if v63.Connected then
			u62 = p22Parent == nil

			if u62 then
				coroutine.wrap(function() -- line: 277
					-- upvalues: Heartbeat (copy), v63 (copy), connection (ref), p21 (copy), u62 (ref)
					Heartbeat:Wait()

					if not v63.Connected then
						return
					end

					if not connection.Connected then
						p21:Cleanup()

						return
					end

					while u62 and connection.Connected and v63.Connected do
						Heartbeat:Wait()
					end

					if v63.Connected and u62 then
						p21:Cleanup()
					end
				end)()
			end
		end
	end

	return p21:Add(v63, "Disconnect", v61)
end
function t1.__index.LinkToInstances(p25, ...) -- line: 308
	-- upvalues: t1 (copy)
	local v66 = t1.new()

	for _, v in ipairs({ ... }) do
		v66:Add(p25:LinkToInstance(v, true), "Disconnect")
	end

	return v66
end

for k, v in next, t1.__index do
	local v9 = string.sub(string.lower(k), 1, 1) .. string.sub(k, 2)

	t1.__index[v9] = v
end

return t1
