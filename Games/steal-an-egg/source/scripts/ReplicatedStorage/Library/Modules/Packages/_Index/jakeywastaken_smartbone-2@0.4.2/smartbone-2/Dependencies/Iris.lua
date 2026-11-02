-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Types)

local t = {}
local v1 = require(script.Internal)(t)

t.Disabled = false
t.Args = {}
t.Events = {}
function t.HasInit() --[[ HasInit | Line: 12 | Upvalues: v1 (copy) ]]
	return v1._started
end
function t.Init(p1, p2) --[[ Init | Line: 16 | Upvalues: v1 (copy), t (copy) ]]
	if p1 == nil then
		p1 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end

	if p2 == nil then
		p2 = game:GetService("RunService").Heartbeat
	end

	v1.parentInstance = p1

	local v12 = if v1._started == false then true else false

	assert(v12, "Iris.Init can only be called once.")
	v1._started = true
	v1._generateRootInstance()
	v1._generateSelectionImageObject()
	task.spawn(function() --[[ Line: 33 | Upvalues: p2 (ref), v1 (ref) ]]
		if typeof(p2) == "function" then
			while true do
				p2()
				v1._cycle()
			end
		else
			if p2 == nil then
				return
			end

			p2:Connect(function() --[[ Line: 40 | Upvalues: v1 (ref) ]]
				v1._cycle()
			end)
		end
	end)

	return t
end
function t.Connect(p1, p2) --[[ Connect | Line: 49 | Upvalues: v1 (copy) ]]
	local v12

	if v1._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(), the connected function will never run")
	end

	v12 = v1._connectedFunctions
	table.insert(v12, p2)
end
function t.Append(p1) --[[ Append | Line: 56 | Upvalues: v1 (copy) ]]
	local v12 = v1._GetParentWidget()

	p1.Parent = v1._config.Parent or v1._widgets[v12.type].ChildAdded(v12, {
		type = "userInstance"
	})
end
function t.End() --[[ End | Line: 68 | Upvalues: v1 (copy) ]]
	if v1._stackIndex ~= 1 then
		local v12

		v1._IDStack[v1._stackIndex] = nil
		v12 = v1
		v1._stackIndex = v1._stackIndex - 1

		return
	end

	error("Callback has too many calls to Iris.End()", 2)
end
function t.ForceRefresh() --[[ ForceRefresh | Line: 82 | Upvalues: v1 (copy) ]]
	v1._globalRefreshRequested = true
end
function t.UpdateGlobalConfig(p1) --[[ UpdateGlobalConfig | Line: 86 | Upvalues: v1 (copy), t (copy) ]]
	for v12, v2 in p1 do
		v1._rootConfig[v12] = v2
	end

	t.ForceRefresh()
end
function t.PushConfig(p1) --[[ PushConfig | Line: 93 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t.State(-1)

	if v12.value == -1 or v1._deepCompare(v12:get(), p1) == false then
		v12:set(p1)
	end

	v1._config = setmetatable(p1, {
		__index = v1._config
	})
end
function t.PopConfig() --[[ PopConfig | Line: 110 | Upvalues: v1 (copy) ]]
	v1._localRefreshActive = false
	v1._config = getmetatable(v1._config).__index
end
t.TemplateConfig = require(script.config)
t.UpdateGlobalConfig(t.TemplateConfig.colorDark)
t.UpdateGlobalConfig(t.TemplateConfig.sizeDefault)
t.UpdateGlobalConfig(t.TemplateConfig.utilityDefault)
v1._globalRefreshRequested = false
function t.PushId(p1) --[[ PushId | Line: 127 | Upvalues: v1 (copy) ]]
	assert(typeof(p1) == "string", "Iris expected Iris.PushId id to PushId to be a string.")
	v1._pushedId = tostring(p1)
end
function t.PopId() --[[ PopId | Line: 133 | Upvalues: v1 (copy) ]]
	v1._pushedId = nil
end
function t.SetNextWidgetID(p1) --[[ SetNextWidgetID | Line: 137 | Upvalues: v1 (copy) ]]
	v1._nextWidgetId = p1
end
function t.State(p1) --[[ State | Line: 147 | Upvalues: v1 (copy) ]]
	local v12 = v1._getID(2)

	if not v1._states[v12] then
		v1._states[v12] = {
			value = p1,
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		setmetatable(v1._states[v12], v1.StateClass)
	end

	return v1._states[v12]
end
function t.WeakState(p1) --[[ WeakState | Line: 161 | Upvalues: v1 (copy) ]]
	local v12 = v1._getID(2)

	if v1._states[v12] then
		if #v1._states[v12].ConnectedWidgets ~= 0 then
			return v1._states[v12]
		end

		v1._states[v12] = nil
	end

	v1._states[v12] = {
		value = p1,
		ConnectedWidgets = {},
		ConnectedFunctions = {}
	}
	setmetatable(v1._states[v12], v1.StateClass)

	return v1._states[v12]
end
function t.ComputedState(p1, p2) --[[ ComputedState | Line: 179 | Upvalues: v1 (copy) ]]
	local v12 = v1._getID(2)

	if not v1._states[v12] then
		v1._states[v12] = {
			value = p2(p1.value),
			ConnectedWidgets = {},
			ConnectedFunctions = {}
		}
		p1:onChange(function(p1) --[[ Line: 190 | Upvalues: v1 (ref), v12 (copy), p2 (copy) ]]
			v1._states[v12]:set(p2(p1))
		end)

		local v2 = v1._states[v12]
		local StateClass = v1.StateClass

		setmetatable(v2, StateClass)
	end

	return v1._states[v12]
end
t.ShowDemoWindow = require(script.demoWindow)(t)
require(script.widgets)(v1)
require(script.API)(t)

return t