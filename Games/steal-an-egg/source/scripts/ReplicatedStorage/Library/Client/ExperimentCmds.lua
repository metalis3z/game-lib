-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Definitions = require(ReplicatedStorage.Library.Experiments.Definitions)

require(ReplicatedStorage.Library.Experiments.Types)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Experiments = Network.NET_MAP.Experiments
local t = { 0.5, 1, 2, 4 }
local v1 = Log.new()
local v2 = Signal.new()
local t2 = {
	Revision = 0,
	Assignments = {}
}
local v3 = "Unresolved"
local v4 = nil
local v5 = 0
local v6 = nil
local t3 = {}

local function decodeSource(p1) --[[ decodeSource | Line: 47 ]]
	if p1 ~= "ConfigService" and (p1 ~= "Fallback" and p1 ~= "TestingOverride") then
		return nil
	end

	return p1
end

local function decodeAssignments(p1) --[[ decodeAssignments | Line: 55 | Upvalues: Definitions (copy) ]]
	if typeof(p1) ~= "table" then
		return {}
	end

	local t = {}

	for k, v in pairs(p1) do
		local v1

		if typeof(k) == "string" then
			local v2 = Definitions.Directory[k]

			if v2 ~= nil and typeof(v) == "table" then
				local Variant = v.Variant
				local Source = v.Source

				v1 = if Source == "ConfigService" or (Source == "Fallback" or Source == "TestingOverride") then Source else nil

				if typeof(Variant) == "string" and (v1 ~= nil and v2.PayloadByVariant[Variant] ~= nil) then
					t[k] = {
						Variant = Variant,
						Source = v1
					}
				end
			end
		end
	end

	return t
end

local function updateState(p1, p2, p3) --[[ updateState | Line: 92 | Upvalues: t2 (ref), v3 (ref), v4 (ref), v2 (copy) ]]
	local v1 = if t2.Revision == p1.Revision and v3 == p2 then if v4 == p3 then false else true else true

	t2 = p1
	v3 = p2
	v4 = p3

	if not v1 then
		return
	end

	v2:Fire()
end

local function applyState(p1) --[[ applyState | Line: 106 | Upvalues: v1 (copy), t2 (ref), decodeAssignments (copy), v3 (ref), v4 (ref), v2 (copy) ]]
	if typeof(p1) ~= "table" then
		v1:AtWarning():Log("[ExperimentCmds] Invalid experiment state payload", {
			PayloadType = typeof(p1)
		})

		return false
	end

	local Revision = p1.Revision

	if typeof(Revision) ~= "number" then
		v1:AtWarning():Log("[ExperimentCmds] Missing experiment state revision", p1)

		return false
	end

	if Revision < t2.Revision then
		return true
	end

	local t = {
		Revision = Revision,
		Assignments = decodeAssignments(p1.Assignments)
	}
	local v12 = if t2.Revision == t.Revision and v3 == "Resolved" then v4 ~= nil else true

	t2 = t
	v3 = "Resolved"
	v4 = nil

	if not v12 then
		return true
	end

	v2:Fire()

	return true
end

local function getDefinition(p1) --[[ getDefinition | Line: 132 | Upvalues: Definitions (copy) ]]
	return Definitions.GetDefinition(p1)
end

local function hasResolvedState() --[[ hasResolvedState | Line: 136 | Upvalues: v3 (ref) ]]
	return v3 == "Resolved"
end

local function scheduleRetryAfterFailure(p1) --[[ scheduleRetryAfterFailure | Line: 140 | Upvalues: v5 (ref), v3 (ref), v1 (copy), v4 (ref), v6 (ref) ]]
	task.delay(10, function() --[[ Line: 141 | Upvalues: p1 (copy), v5 (ref), v3 (ref), v1 (ref), v4 (ref), v6 (ref) ]]
		if p1 ~= v5 then
			return
		end

		if v3 ~= "ResolveFailed" then
			return
		end

		if not (v3 == "Resolved") then
			v1:AtInfo():Log("[ExperimentCmds] Retrying experiment resolve after failure", {
				ResolveRequestId = p1,
				LastResolveError = v4
			})
			v6()
		end
	end)
end

local function cloneAssignments(p1) --[[ cloneAssignments | Line: 158 ]]
	local t = {}

	for k, v in pairs(p1) do
		t[k] = {
			Variant = v.Variant,
			Source = v.Source
		}
	end

	return t
end

local function requestInitialState(p1) --[[ requestInitialState | Line: 169 | Upvalues: t (copy), v5 (ref), v3 (ref), t2 (ref), v4 (ref), v2 (copy), Network (copy), Experiments (copy), applyState (copy), v1 (copy), v6 (ref) ]]
	local v12 = nil

	for i, v in ipairs(t) do
		local v22, v32

		if p1 ~= v5 then
			return
		end

		if if v3 == "Resolved" then true else false then
			return
		end

		local v52 = t2

		if t2.Revision == v52.Revision and v3 == "Resolving" then
			if v4 == v12 then
				v22 = v12
				v32 = false
			else
				v22 = v12
				v32 = true
			end
		else
			v22 = v12
			v32 = true
		end

		t2 = v52
		v3 = "Resolving"
		v4 = v22

		if v32 then
			v2:Fire()
		end

		local ok, result = pcall(function() --[[ Line: 179 | Upvalues: Network (ref), Experiments (ref) ]]
			return Network.Invoke(Experiments.GET)
		end)

		if p1 ~= v5 then
			return
		end

		if if v3 == "Resolved" then true else false then
			return
		end

		if ok and applyState(result) then
			return
		end

		v12 = if ok then "Invalid experiment state payload" else tostring(result)
		v1:AtWarning():Log("[ExperimentCmds] Failed to fetch initial experiment state", {
			Attempt = i,
			Error = v12
		})

		if i < #t then
			task.wait(v)
		end
	end

	if p1 ~= v5 then
		return
	end

	local v8 = v3 == "Resolved"

	if v8 then
		return
	end

	local v9 = t2
	local v10, v11

	if t2.Revision == v9.Revision and v3 == "ResolveFailed" then
		if v4 == v12 then
			v10 = v12
			v11 = false
		else
			v10 = v12
			v11 = true
		end
	else
		v10 = v12
		v11 = true
	end

	t2 = v9
	v3 = "ResolveFailed"
	v4 = v10

	if v11 then
		v2:Fire()
	end

	task.delay(10, function() --[[ Line: 141 | Upvalues: p1 (copy), v5 (ref), v3 (ref), v1 (ref), v4 (ref), v6 (ref) ]]
		if p1 ~= v5 then
			return
		end

		if v3 ~= "ResolveFailed" then
			return
		end

		if not (v3 == "Resolved") then
			v1:AtInfo():Log("[ExperimentCmds] Retrying experiment resolve after failure", {
				ResolveRequestId = p1,
				LastResolveError = v4
			})
			v6()
		end
	end)
end

v6 = function() --[[ Line: 210 | Upvalues: v5 (ref), requestInitialState (copy) ]]
	v5 = v5 + 1

	local v1 = v5

	task.spawn(function() --[[ Line: 213 | Upvalues: requestInitialState (ref), v1 (copy) ]]
		requestInitialState(v1)
	end)
end
Network.Fired(Experiments.UPDATE):Connect(function(p1) --[[ Line: 218 | Upvalues: applyState (copy) ]]
	applyState(p1)
end)
v6()
t3.Changed = v2
function t3.HasResolved() --[[ HasResolved | Line: 226 | Upvalues: v3 (ref) ]]
	return v3 == "Resolved"
end
function t3.GetStatus() --[[ GetStatus | Line: 230 | Upvalues: v3 (ref) ]]
	return v3
end
function t3.GetLastResolveError() --[[ GetLastResolveError | Line: 234 | Upvalues: v4 (ref) ]]
	return v4
end
function t3.RetryResolve() --[[ RetryResolve | Line: 238 | Upvalues: v6 (ref) ]]
	v6()
end
function t3.TryGetVariant(p1) --[[ TryGetVariant | Line: 242 | Upvalues: Asserts (copy), t2 (ref), v3 (ref), Definitions (copy) ]]
	Asserts.string(p1)

	local v1 = t2.Assignments[p1]

	if v1 ~= nil then
		return {
			Status = "Resolved",
			Variant = v1.Variant,
			Source = v1.Source
		}
	end

	if v3 == "Resolved" then
		return {
			Status = "Resolved",
			Source = "Fallback",
			Variant = Definitions.GetDefinition(p1).DefaultVariant
		}
	end

	return {
		Variant = nil,
		Source = nil,
		Status = v3
	}
end
function t3.GetVariant(p1) --[[ GetVariant | Line: 269 | Upvalues: t3 (copy) ]]
	local v1 = t3.TryGetVariant(p1)

	if v1.Status == "Resolved" then
		return v1.Variant
	end

	return nil
end
function t3.IsVariant(p1, p2) --[[ IsVariant | Line: 278 | Upvalues: Asserts (copy), t3 (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)

	local v1 = t3.TryGetVariant(p1)

	return if v1.Status == "Resolved" then v1.Variant == p2 else false
end
function t3.GetPayload(p1) --[[ GetPayload | Line: 286 | Upvalues: Asserts (copy), t3 (copy), Definitions (copy) ]]
	Asserts.string(p1)

	local v1 = t3.TryGetVariant(p1)

	if v1.Status == "Resolved" and v1.Variant ~= nil then
		return table.clone(Definitions.GetDefinition(p1).PayloadByVariant[v1.Variant])
	end

	return nil
end
function t3.GetDebugAssignments() --[[ GetDebugAssignments | Line: 298 | Upvalues: cloneAssignments (copy), t2 (ref) ]]
	return cloneAssignments(t2.Assignments)
end
function t3.ShouldShowFakeTutorialUI() --[[ ShouldShowFakeTutorialUI | Line: 302 | Upvalues: t3 (copy), Definitions (copy) ]]
	local v1 = t3.GetPayload(Definitions.Ids.FakeTutorialMatchOnboarding)

	if v1 == nil then
		return nil
	end

	return v1.RouteToFakeTutorial == true
end

return t3