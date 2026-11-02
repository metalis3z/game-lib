-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Functions")
local BinarySearch = require(Functions.BinarySearch)
local wcall = require(Functions.wcall)
local Asserts = require(Functions.Parent.Asserts)
local t = {
	DefaultPriority = 0
}
local t2 = {}

local function compareFn(p1, p2) --[[ compareFn | Line: 50 ]]
	return p1._priority - p2._priority
end

function t2.Disconnect(p1) --[[ Line: 55 | Upvalues: BinarySearch (copy), compareFn (copy) ]]
	p1._fn = nil

	local _container = p1._container

	if not _container then
		return
	end

	p1._container = nil
	BinarySearch.Remove(_container._list, compareFn, p1)
end
function t2.IsConnected(p1) --[[ Line: 65 ]]
	return p1._container ~= nil
end

local t3 = {
	_safeBackwardPropagateCallback = function(p1, p2, ...) --[[ _safeBackwardPropagateCallback | Line: 72 | Upvalues: Asserts (copy) ]]
		Asserts.func(p2)

		for i = #p1._list, 1, -1 do
			local v1 = p1._list[i]

			if v1 then
				p2(v1, ...)
			end
		end

		return p1
	end,
	Connect = function(p1, p2, p3) --[[ Line: 88 | Upvalues: Asserts (copy), t (copy), t2 (copy), BinarySearch (copy), compareFn (copy) ]]
		Asserts.func(p2)
		assert(if p3 == nil then true elseif type(p3) == "number" then true else false, "Priority must be a number or nil")

		local t3 = {
			_container = p1
		}

		t3._priority = if p3 then p3 else t.DefaultPriority
		t3._fn = p2

		local v3 = setmetatable(t3, {
			__index = t2
		})

		BinarySearch.InsertRight(p1._list, compareFn, v3)

		return v3
	end,
	Wait = function(p1, p2) --[[ Line: 105 ]]
		local v1 = nil
		local v2 = nil

		v2 = p1:Connect(function(...) --[[ Line: 109 | Upvalues: v2 (ref), v1 (ref) ]]
			v2:Disconnect()

			if v1 then
				return
			end

			v1 = table.pack(...)
		end, p2)

		while not v1 and v2:IsConnected() do
			task.wait()
		end

		v2:Disconnect()

		local v3 = v1 or {}

		return table.unpack(v3)
	end,
	WaitTimed = function(p1, p2, p3) --[[ Line: 125 | Upvalues: Asserts (copy) ]]
		Asserts.number(p2)

		local v1 = nil
		local v2 = nil

		v2 = p1:Connect(function(...) --[[ Line: 131 | Upvalues: v2 (ref), v1 (ref) ]]
			v2:Disconnect()

			if v1 then
				return
			end

			v1 = table.pack(...)
		end, p3)

		local v3 = os.clock() + p2

		while not v1 and (v2:IsConnected() and os.clock() < v3) do
			task.wait()
		end

		v2:Disconnect()

		local v4 = v1 or {}

		return table.unpack(v4)
	end,
	UnprotectedInvokeSync = function(p1, ...) --[[ Line: 149 ]]
		p1:_safeBackwardPropagateCallback(function(p1, ...) --[[ Line: 150 ]]
			local _fn = p1._fn

			if not _fn then
				return
			end

			local v1 = table.pack(_fn(...))

			if #v1 > 0 then
				return table.unpack(v1)
			end
		end, ...)
	end,
	InvokeSync = function(p1, ...) --[[ Line: 162 | Upvalues: wcall (copy) ]]
		p1:_safeBackwardPropagateCallback(function(p1, ...) --[[ Line: 163 | Upvalues: wcall (ref) ]]
			local _fn = p1._fn

			if not _fn then
				return
			end

			local v2, v3 = table.unpack(wcall(_fn, ...))

			if v2 and v3 then
				return v3
			end
		end, ...)
	end,
	FireAsync = function(p1, ...) --[[ Line: 175 ]]
		p1:_safeBackwardPropagateCallback(function(p1, ...) --[[ Line: 176 ]]
			local _fn = p1._fn

			if not _fn then
				return
			end

			task.spawn(_fn, ...)
		end, ...)
	end,
	Clean = function(p1) --[[ Line: 185 ]]
		p1:_safeBackwardPropagateCallback(function(p1) --[[ Line: 186 ]]
			p1:Disconnect()
		end)
		table.clear(p1._list)
	end,
	Destroy = function(p1) --[[ Line: 194 ]]
		p1:Clean()
		table.clear(p1)
		setmetatable(p1, nil)
	end
}

function t.new() --[[ Line: 201 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_list = {}
	}, {
		__index = t3
	})
end
function t.IsA(p1) --[[ Line: 210 | Upvalues: t3 (copy) ]]
	if type(p1) ~= "table" then
		return false
	end

	local v1 = getmetatable(p1)

	return if type(v1) == "table" then v1.__index == t3 else false
end

return t