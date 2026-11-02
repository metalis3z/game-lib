-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: janitor, time of decompilation: Sun May  3 10:10:31 2026 ]]
local FastDefer = require(script.FastDefer)
local Promise = require(script.Promise)
local v3 = setmetatable({}, {
	__tostring = function() --[[ __tostring ]] -- line: 17
		return "LinkToInstanceIndex"
	end
})
local t1 = {
	ClassName = "Janitor",
	CurrentlyCleaning = true,
	SuppressInstanceReDestroy = false,
	UnsafeThreadCleanup = false
}

t1.__index = t1

local v5 = setmetatable({}, {
	__mode = "ks"
})
local t2 = {
	["function"] = true,
	thread = true,
	RBXScriptConnection = "Disconnect"
}

function t1.new() -- line: 162
	-- upvalues: t1 (copy)
	return (setmetatable({
		CurrentlyCleaning = false
	}, t1))
end
function t1.Is(p1) -- line: 175
	-- upvalues: t1 (copy)
	return type(p1) == "table" and getmetatable(p1) == t1
end

t1.instanceof = t1.Is

local Destroy = game.Destroy

local function Remove(p2, p3) -- line: 193
	-- upvalues: v5 (copy), FastDefer (copy), Destroy (copy)
	local v15 = v5[p2]

	if v15 then
		local v16 = v15[p3]

		if not v16 then
			return p2
		end

		local v17 = p2[v16]

		if v17 then
			if v17 == true then
				if type(v16) == "function" then
					v16()
				else
					local v18 = nil

					if v16 ~= coroutine.running() then
						v18 = pcall(function() -- line: 210
							-- upvalues: v16 (copy)
							task.cancel(v16)
						end)
					end

					if not v18 then
						if p2.UnsafeThreadCleanup then
							FastDefer(function() -- line: 218
								-- upvalues: v16 (copy)
								task.cancel(v16)
							end)
						else
							task.defer(function() -- line: 222
								-- upvalues: v16 (copy)
								task.cancel(v16)
							end)
						end
					end
				end
			elseif v17 == "Destroy" then
				if p2.SuppressInstanceReDestroy and typeof(v16) == "Instance" then
					pcall(Destroy, v16)
				else
					local Destroy2 = v16.Destroy

					if Destroy2 then
						Destroy2(v16)
					end
				end
			elseif v17 == "Disconnect" then
				local Disconnect = v16.Disconnect

				if Disconnect then
					Disconnect(v16)
				end
			else
				local v21 = v16[v17]

				if v21 then
					v21(v16)
				end
			end

			p2[v16] = nil
		end

		v15[p3] = nil
	end

	return p2
end
local function Add(p4, p5, p6, p7) -- line: 262
	-- upvalues: Remove (copy), v5 (copy), t2 (copy)
	if p7 then
		Remove(p4, p7)

		local v26 = v5[p4]

		if not v26 then
			v26 = {}
			v5[p4] = v26
		end

		v26[p7] = p5
	end

	local v27 = typeof(p5)
	local v28 = p6 or (t2[v27] or "Destroy")

	if v27 == "function" or v27 == "thread" then
		if v28 ~= true then
			warn(string.format("Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*", v27, tostring(v28), debug.traceback(nil, 2)))
		end
	elseif not p5[v28] then
		warn(string.format("Object %* doesn't have method %*, are you sure you want to add it? Traceback: %*", tostring(p5), tostring(v28), debug.traceback(nil, 2)))
	end

	p4[p5] = v28

	return p5
end

t1.Add = Add

function t1.AddObject(t3: {[any]: any}, t4: {[any]: any}, p8, p9, ...) -- line: 415
	-- upvalues: Add (copy)
	return (Add(t3, t4.new(...), p8, p9))
end
function t1.Get(p10, p11) -- line: 419
	-- upvalues: v5 (copy)
	local v35 = v5[p10]

	if v35 then
		return v35[p11]
	end

	return nil
end
function t1.AddPromise(p12, p13, p14) -- line: 486
	-- upvalues: Promise (copy), Add (copy), v5 (copy), Remove (copy)
	if not Promise then
		return p13
	end

	if not Promise.is(p13) then
		error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %* (%*)) Traceback: %*", typeof(p13), tostring(p13), debug.traceback(nil, 2)))
	end

	if p13:getStatus() ~= Promise.Status.Started then
		return p13
	end

	local u39 = p14

	if u39 == nil then
		u39 = newproxy(false)
	end

	local v40 = Add(p12, Promise.new(function(p15, _, p17) -- line: 504
		-- upvalues: p13 (copy)
		if p17(function() -- line: 505
			-- upvalues: p13 (copy)
			p13:cancel()
		end) then
			return
		end

		p15(p13)
	end), "cancel", u39)

	v40:finally(function() -- line: 514
		-- upvalues: p12 (copy), u39 (ref), v5 (copy), v40 (copy), Remove (copy)
		local v99 = p12
		local v100 = u39
		local v101 = v5[v99]

		if ((if not v101 then nil else v101[v100])) == v40 then
			Remove(p12, u39)
		end
	end)

	return v40
end

t1.Remove = Remove

function t1.RemoveNoClean(p18, p19) -- line: 585
	-- upvalues: v5 (copy)
	local v43 = v5[p18]

	if v43 then
		local v44 = v43[p19]

		if v44 then
			p18[v44] = nil
			v43[p19] = nil
		end
	end

	return p18
end
function t1.RemoveList(p20, ...) -- line: 640
	-- upvalues: v5 (copy), Remove (copy)
	if v5[p20] then
		local v46 = select("#", ...)

		if v46 == 1 then
			return (Remove(p20, ...))
		end

		if v46 == 2 then
			local v47, v48 = ...

			Remove(p20, v47)
			Remove(p20, v48)

			return p20
		end

		if v46 == 3 then
			local v49, v50, v51 = ...

			Remove(p20, v49)
			Remove(p20, v50)
			Remove(p20, v51)

			return p20
		end

		for i = 1, v46 do
			local v53 = select(i, ...)

			Remove(p20, v53)
		end
	end

	return p20
end
function t1.RemoveListNoClean(p21, ...) -- line: 711
	-- upvalues: v5 (copy)
	local v55 = v5[p21]

	if v55 then
		local v56 = select("#", ...)

		if v56 == 1 then
			local v57 = ...
			local v58 = v55[v57]

			if v58 then
				p21[v58] = nil
				v55[v57] = nil
			end

			return p21
		end

		if v56 == 2 then
			local v59, v60 = ...
			local v61 = v55[v59]

			if v61 then
				p21[v61] = nil
				v55[v59] = nil
			end

			local v62 = v55[v60]

			if v62 then
				p21[v62] = nil
				v55[v60] = nil
			end

			return p21
		end

		if v56 == 3 then
			local v63, v64, v65 = ...
			local v66 = v55[v63]

			if v66 then
				p21[v66] = nil
				v55[v63] = nil
			end

			local v67 = v55[v64]

			if v67 then
				p21[v67] = nil
				v55[v64] = nil
			end

			local v68 = v55[v65]

			if v68 then
				p21[v68] = nil
				v55[v65] = nil
			end

			return p21
		end

		for i = 1, v56 do
			local v70 = select(i, ...)
			local v71 = v55[v70]

			if v71 then
				p21[v71] = nil
				v55[v70] = nil
			end
		end
	end

	return p21
end
function t1.GetAll(p22) -- line: 796
	-- upvalues: v5 (copy)
	local v73 = v5[p22]

	if v73 then
		return (table.freeze(table.clone(v73)))
	end

	return {}
end

local function Cleanup(p23) -- line: 824
	-- upvalues: FastDefer (copy), Destroy (copy), v5 (copy)
	if not p23.CurrentlyCleaning then
		local SuppressInstanceReDestroy = p23.SuppressInstanceReDestroy
		local UnsafeThreadCleanup = p23.UnsafeThreadCleanup

		p23.CurrentlyCleaning = nil
		p23.SuppressInstanceReDestroy = nil
		p23.UnsafeThreadCleanup = nil

		local u77, v78 = next(p23)

		while u77 and v78 do
			if v78 == true then
				if type(u77) == "function" then
					u77()
				else
					local v79 = nil

					if coroutine.running() ~= u77 then
						v79 = pcall(function() -- line: 841
							-- upvalues: u77 (ref)
							task.cancel(u77)
						end)
					end

					if not v79 then
						local v80 = u77

						if UnsafeThreadCleanup then
							FastDefer(function() -- line: 849
								-- upvalues: v80 (copy)
								task.cancel(v80)
							end)
						else
							task.defer(function() -- line: 853
								-- upvalues: v80 (copy)
								task.cancel(v80)
							end)
						end
					end
				end
			elseif v78 == "Destroy" then
				if p23.SuppressInstanceReDestroy and typeof(u77) == "Instance" then
					pcall(Destroy, u77)
				else
					local Destroy3 = u77.Destroy

					if Destroy3 then
						Destroy3(u77)
					end
				end
			elseif v78 == "Disconnect" then
				local Disconnect = u77.Disconnect

				if Disconnect then
					Disconnect(u77)
				end
			else
				local v83 = u77[v78]

				if v83 then
					v83(u77)
				end
			end

			p23[u77] = nil

			local v84

			v84, v78 = next(p23, u77)
			u77 = v84
		end

		local v85 = v5[p23]

		if v85 then
			table.clear(v85)
			v5[p23] = nil
		end

		p23.CurrentlyCleaning = false
		p23.SuppressInstanceReDestroy = SuppressInstanceReDestroy
		p23.UnsafeThreadCleanup = UnsafeThreadCleanup
	end
end

t1.Cleanup = Cleanup

function t1.Destroy(p24) -- line: 907
	-- upvalues: Cleanup (copy)
	Cleanup(p24)
	table.clear(p24)
	setmetatable(p24, nil)
end

t1.__call = Cleanup

local function LinkToInstance(p25, p26, b1: boolean?) -- line: 915
	-- upvalues: v3 (copy), Add (copy), Cleanup (copy)
	local v90 = if not b1 then v3 else newproxy(false)

	return (Add(p25, p26.Destroying:Connect(function() -- line: 918
		-- upvalues: Cleanup (copy), p25 (copy)
		Cleanup(p25)
	end), "Disconnect", v90))
end

t1.LinkToInstance = LinkToInstance
t1.LegacyLinkToInstance = LinkToInstance

function t1.LinkToInstances(p27, ...) -- line: 981
	-- upvalues: t1 (copy), LinkToInstance (copy)
	local v92 = t1.new()

	for i = 1, select("#", ...) do
		local v94 = select(i, ...)

		if typeof(v94) == "Instance" then
			v92:Add(LinkToInstance(p27, v94, true), "Disconnect")
		end
	end

	return v92
end
function t1.__tostring(_) -- line: 995
	return "Janitor"
end

return t1
