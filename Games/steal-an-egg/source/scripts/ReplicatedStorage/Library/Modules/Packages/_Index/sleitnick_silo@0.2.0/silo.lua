-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TableWatcher = require(script.TableWatcher)
local Util = require(script.Util)
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 86 | Upvalues: t (copy), Util (copy), TableWatcher (copy) ]]
	local v2 = setmetatable({}, t)

	v2._DefaultState = Util.DeepFreeze(Util.DeepCopy(p1))
	v2._State = Util.DeepFreeze(Util.DeepCopy(p1))
	v2._Modifiers = {}
	v2._Dispatching = false
	v2._Parent = v2
	v2._Subscribers = {}
	v2.Actions = {}

	if p2 then
		for v3, v4 in p2 do
			v2._Modifiers[v3] = function(p1, p2) --[[ Line: 101 | Upvalues: TableWatcher (ref), v4 (copy) ]]
				local v1 = TableWatcher(p1)

				v4(v1, p2)

				return v1()
			end
			v2.Actions[v3] = function(p1) --[[ Line: 109 | Upvalues: v3 (copy) ]]
				return {
					Name = v3,
					Payload = p1
				}
			end
		end
	end

	return v2
end
function t.combine(p1, p2) --[[ combine | Line: 126 | Upvalues: t (copy), Util (copy) ]]
	local t2 = {}

	for v1, v2 in p1 do
		if v2._Dispatching then
			error("cannot combine silos from a modifier", 2)
		end

		t2[v1] = v2:GetState()
	end

	local Extend = Util.Extend
	local v5 = t.new(Extend(t2, if p2 then p2 else {}))

	for v6, v7 in p1 do
		v7._Parent = v5

		for v8, v9 in v7._Modifiers do
			v5._Modifiers[("%*/%*"):format(v6, v8)] = function(p1, p2) --[[ Line: 144 | Upvalues: Util (ref), v6 (copy), v9 (copy) ]]
				return Util.Extend(p1, {
					[v6] = v9(p1[v6], p2)
				})
			end
		end

		for v11 in v7.Actions do
			if v5.Actions[v11] ~= nil then
				error(("duplicate action name %* found when combining silos"):format(v11), 2)
			end

			local v12 = ("%*/%*"):format(v6, v11)

			v7.Actions[v11] = function(p1) --[[ Line: 157 | Upvalues: v12 (copy) ]]
				return {
					Name = v12,
					Payload = p1
				}
			end
			v5.Actions[v11] = v7.Actions[v11]
		end
	end

	return v5
end
function t.GetState(p1) --[[ GetState | Line: 177 ]]
	if p1._Parent == p1 then
		return p1._State
	end

	error("can only get state from top-level silo", 2)
end
function t.Dispatch(p1, p2) --[[ Dispatch | Line: 191 | Upvalues: Util (copy) ]]
	if p1._Dispatching then
		error("cannot dispatch from a modifier", 2)
	end

	if p1._Parent ~= p1 then
		error("can only dispatch from top-level silo", 2)
	end

	p1._Dispatching = true

	local _State = p1._State
	local v1 = p1._Modifiers[p2.Name]
	local v2 = if v1 then v1(_State, p2.Payload) else _State

	p1._Dispatching = false

	if v2 == _State then
		return
	end

	p1._State = Util.DeepFreeze(v2)

	for v4, v5 in p1._Subscribers do
		v5(v2, _State)
	end
end
function t.Subscribe(p1, p2) --[[ Subscribe | Line: 235 ]]
	if p1._Dispatching then
		error("cannot subscribe from within a modifier", 2)
	end

	if p1._Parent ~= p1 then
		error("can only subscribe on top-level silo", 2)
	end

	if not table.find(p1._Subscribers, p2) then
		local v1

		v1 = p1._Subscribers
		table.insert(v1, p2)

		return function() --[[ Line: 249 | Upvalues: p1 (copy), p2 (copy) ]]
			local v1 = table.find(p1._Subscribers, p2)

			if v1 then
				table.remove(p1._Subscribers, v1)
			end
		end
	end

	error("cannot subscribe same function more than once", 2)
end
function t.Watch(p1, p2, p3) --[[ Watch | Line: 276 ]]
	local v1 = p2(p1:GetState())
	local v2 = p1:Subscribe(function(p1) --[[ Line: 279 | Upvalues: p2 (copy), v1 (ref), p3 (copy) ]]
		local v12 = p2(p1)

		if v12 ~= v1 then
			v1 = v12
			p3(v12)
		end
	end)

	p3(v1)

	return v2
end
function t.ResetToDefaultState(p1) --[[ ResetToDefaultState | Line: 315 | Upvalues: Util (copy) ]]
	if p1._Dispatching then
		error("cannot reset state from within a modifier", 2)
	end

	if p1._Parent ~= p1 then
		error("can only reset state on top-level silo", 2)
	end

	local _State = p1._State

	if p1._DefaultState == _State then
		return
	end

	p1._State = Util.DeepFreeze(Util.DeepCopy(p1._DefaultState))

	for v1, v2 in p1._Subscribers do
		v2(p1._State, _State)
	end
end

return {
	new = t.new,
	combine = t.combine
}