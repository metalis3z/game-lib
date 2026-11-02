-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Library = ReplicatedStorage.Library
local Trove = require(Library.Modules.Packages.Trove)
local Signal = require(Library.Modules.Packages.Signal)
local DeepCopyFeatured = require(Library.Functions.DeepCopyFeatured)
local t = {
	__script = script,
	__cache = {},
	__creation_locks = {}
}

t.__index = t
function t.retrive_id(p1, p2) --[[ retrive_id | Line: 22 | Upvalues: HttpService (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	local v1 = typeof(p1.__unique_ecosystem_id) == "string" and p1.__unique_ecosystem_id or HttpService:GenerateGUID(false)

	if p2 then
		p1.__unique_ecosystem_id = v1
	end

	return v1
end
function t.determine_group(p1) --[[ determine_group | Line: 37 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	local t2 = {}

	for v1, v2 in p1 do
		local v3 = t.retrive_id(v2, true)

		if typeof(v3) == "string" then
			table.insert(t2, v3)
		end
	end

	table.sort(t2)

	return table.concat(t2, "|")
end
function t.create_yield_structure(p1) --[[ create_yield_structure | Line: 56 | Upvalues: Signal (copy), DeepCopyFeatured (copy) ]]
	local t = {
		__safe_boot = {
			__global_env_ready = false,
			__injection_marker = Signal.new(),
			__original = {},
			__wrapped = {}
		}
	}
	local v1 = typeof(p1) == "table" and DeepCopyFeatured(p1, t, nil, true) or t
	local t2 = {}

	local function Wrapper(p1) --[[ Wrapper | Line: 69 | Upvalues: v1 (copy) ]]
		return function(...) --[[ Line: 70 | Upvalues: v1 (ref), p1 (copy) ]]
			if v1.__safe_boot.__global_env_ready then
				return p1(...)
			end

			v1.__safe_boot.__injection_marker:Wait()

			return p1(...)
		end
	end

	function t2.__index(p1, p2) --[[ __index | Line: 79 | Upvalues: v1 (copy) ]]
		local v12 = v1.__safe_boot.__original[p2] or v1.__safe_boot.__wrapped[p2]

		if v12 then
			return v12
		end

		local v2 = v1
		local v3 = rawget(v2, p2)

		if typeof(v3) == "function" then
			local function f4(...) --[[ Line: 70 | Upvalues: v1 (ref), v3 (copy) ]]
				if v1.__safe_boot.__global_env_ready then
					return v3(...)
				end

				v1.__safe_boot.__injection_marker:Wait()

				return v3(...)
			end

			v1.__safe_boot.__wrapped[p2] = f4

			return f4
		end

		return v3
	end
	function t2.__newindex(p1, p2, p3) --[[ __newindex | Line: 97 | Upvalues: v1 (copy) ]]
		if typeof(p3) == "function" then
			v1.__safe_boot.__original[p2] = p3

			local v12 = v1

			local function f2(...) --[[ Line: 70 | Upvalues: v1 (ref), p3 (copy) ]]
				if v1.__safe_boot.__global_env_ready then
					return p3(...)
				end

				v1.__safe_boot.__injection_marker:Wait()

				return p3(...)
			end

			return rawset(v12, p2, f2)
		end

		return rawset(v1, p2, p3)
	end

	return setmetatable(v1, t2)
end
function t.new(p1, p2, p3) --[[ new | Line: 110 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local v1 = if typeof(p1) == "table" and p1 then p1 else {}
	local v2, v3

	if typeof(p3) == "string" and p3 then
		v2 = p3
		v3 = v1
	else
		v2 = "CYCLE_ONCE"
		v3 = v1
	end

	local v4, v5

	if typeof(p2) == "string" and p2 then
		v4 = p2
		v5 = v2
	else
		v4 = t.determine_group(v3)
		v5 = v2
	end

	if t.__cache[v4] then
		return t.__cache[v4]
	end

	local v6 = Trove.new()
	local v8 = setmetatable({
		__injected = false,
		__initialized = false,
		__deployed = false,
		__loading = false,
		Directory = v3,
		Group_Id = v4,
		Lifecycle = v5,
		Kernel = v6,
		__ecosystem = {},
		__loaded_signal_marker = v6:Add(Signal.new())
	}, t)

	t.__cache[v4] = v8

	return v8
end
function t.__get_node_state(p1, p2) --[[ __get_node_state | Line: 143 ]]
	if typeof(p2) ~= "table" then
		return
	end

	p2.__bootstrap_port = p2.__bootstrap_port or {}
	p2.__bootstrap_port.__global_ecosystem = p2.__bootstrap_port.__global_ecosystem or {}
	p2.__bootstrap_port[p1.Group_Id] = p2.__bootstrap_port[p1.Group_Id] or {}

	return p2.__bootstrap_port[p1.Group_Id]
end
function t.__verify_port(p1, p2, p3, p4, ...) --[[ __verify_port | Line: 155 ]]
	if typeof(p2) ~= "string" or typeof(p3) ~= "table" then
		return "__exit"
	end

	local v1 = p1:__get_node_state(p3)
	local v2 = if typeof(p4) == "table" and p4 then p4 else {}
	local v3, v4

	if v2.Global then
		v3 = p3.__bootstrap_port

		if v3 then
			v4 = v2
		else
			v3 = v1
			v4 = v2
		end
	else
		v3 = v1
		v4 = v2
	end

	if typeof(v3) ~= "table" then
		return
	end

	local v5 = v3[p2]

	if select("#", ...) ~= 0 then
		v3[p2] = ...
	end

	if v4.Cache then
		return v5
	end

	return v3[p2]
end
function t.__should_process(p1, p2, p3) --[[ __should_process | Line: 176 ]]
	if typeof(p2) ~= "table" or typeof(p3) == "string" and p1:__verify_port(p3, p2, {
		Cache = true
	}, true) then
		return
	end

	if p3 == "__injected" then
		return true
	end

	if p1.Lifecycle == "CYCLE_ONCE" then
		return not p1:__verify_port("__global_processed", p2, {
			Global = true
		})
	end

	if p1.Lifecycle ~= "DYNAMIC" then
		return true
	end

	local isNotGroup_Id = p1:__verify_port("__last_group", p2, {
		Global = true
	}) ~= p1.Group_Id

	return isNotGroup_Id
end
function t.__mark_node_processed(p1, p2) --[[ __mark_node_processed | Line: 197 ]]
	if typeof(p2) ~= "table" then
		return
	end

	if p1.Lifecycle == "CYCLE_ONCE" then
		p1:__verify_port("__global_processed", p2, {
			Global = true
		}, true)

		return
	end

	if p1.Lifecycle ~= "DYNAMIC" then
		return
	end

	p1:__verify_port("__last_group", p2, {
		Global = true
	}, p1.Group_Id)
end
function t.__run_lifecycle(p1, p2, p3, p4, ...) --[[ __run_lifecycle | Line: 210 ]]
	if p1[p3] then
		return p1
	end

	p1[p3] = true

	for k, v in pairs(p1.Directory) do
		if p1:__should_process(v, p3) then
			if p4 then
				p1:__mark_node_processed(v)
			end

			local v1 = v[p2]

			if typeof(v1) == "function" then
				local ok, result = pcall(v1, v, ...)

				if ok then
					print(p2 .. " success for module:", k)

					continue
				end

				warn(p2 .. " failed for module:", k, result)
			end
		end
	end

	return p1
end
function t.Inject(p1) --[[ Inject | Line: 246 | Upvalues: DeepCopyFeatured (copy) ]]
	if p1.__injected then
		return p1
	end

	p1.__injected = true

	for k, v in pairs(p1.Directory) do
		if p1:__should_process(v, "__injected") then
			DeepCopyFeatured(p1.Directory, v.__bootstrap_port.__global_ecosystem, nil, true, {
				[k] = true
			})

			if typeof(v.__safe_boot) == "table" then
				v.__global_env_ready = true
				v.__injection_marker:Fire()
			end
		end
	end

	return p1
end
function t.Initialize(p1, ...) --[[ Initialize | Line: 268 ]]
	return p1:__run_lifecycle("Initialize", "__initialized", false, ...)
end
function t.Deploy(p1, ...) --[[ Deploy | Line: 272 ]]
	return p1:__run_lifecycle("Deploy", "__deployed", true, ...)
end
function t.Bootstrap(p1, ...) --[[ Bootstrap | Line: 277 ]]
	if not p1.__bootstrapped then
		p1.__bootstrapped = true
		p1.__loading = true
		p1:Inject()
		p1:Initialize(...)
		p1:Deploy(...)
		p1.__loading = false
		p1.__loaded_signal_marker:Fire()
	end

	return p1
end
function t.Destroy(p1) --[[ Destroy | Line: 293 ]]
	if p1.__loading then
		p1.__loaded_signal_marker:Wait()
	end

	p1.Kernel:Destroy()
	table.clear(p1)
	setmetatable(p1, nil)
end

return t