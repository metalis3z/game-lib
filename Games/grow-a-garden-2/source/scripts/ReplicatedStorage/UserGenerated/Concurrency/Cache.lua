--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local DeepFreeze = require(game.ReplicatedStorage.UserGenerated.Collections.DeepFreeze)
local Lock = require(game.ReplicatedStorage.UserGenerated.Concurrency.Lock)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)

local function ValueAge(p1, p2) --[[ ValueAge | Line: 38 ]]
	local RetrievedAt = p1.RetrievedAt

	if RetrievedAt then
		return p2 - RetrievedAt
	end

	return nil
end

local function AttemptAge(p1, p2) --[[ AttemptAge | Line: 46 ]]
	local AttemptedAt = p1.AttemptedAt

	if AttemptedAt then
		return p2 - AttemptedAt
	end

	return (1 / 0)
end

local t = {
	RemoveUsedAt = function(p1, p2) --[[ RemoveUsedAt | Line: 89 ]] end,
	InsertUsedAt = function(p1, p2) --[[ InsertUsedAt | Line: 93 ]] end,
	SetUsedAt = function(p1, p2, p3) --[[ SetUsedAt | Line: 97 ]]
		p1:RemoveUsedAt(p2)
		p2.UsedAt = p3
		p1:InsertUsedAt(p2)
	end,
	Get = function(p1, p2) --[[ Get | Line: 109 ]]
		local v2 = p1.Cache[p1.AssertKey(p2)]

		if not v2 then
			return nil
		end

		local v3 = os.clock()
		local RetrievedAt = v2.RetrievedAt
		local v4 = if RetrievedAt then v3 - RetrievedAt else nil

		if not v4 or p1.MaxAge <= v4 and not p1.ReturnStale then
			return nil
		end

		p1:SetUsedAt(v2, v3)

		return v2.Value
	end
}

function AsyncCallback(p1, p2, p3, p4) --[[ AsyncCallback | Line: 124 | Upvalues: DeepFreeze (copy) ]]
	local RetrievedAt = p2.RetrievedAt
	local v1 = if RetrievedAt then p4 - RetrievedAt else nil

	if v1 and v1 < p1.MaxAge then
		return p2.Value
	end

	local AttemptedAt = p2.AttemptedAt

	if (if AttemptedAt then p4 - AttemptedAt else (1 / 0)) < p1.FailureRetryDelay then
		if p1.ReturnStale then
			return p2.Value
		end

		return nil
	end

	p2.AttemptedAt = p4

	local ok, result = pcall(p1.Callback, p3)
	local v3 = os.clock()

	p2.AttemptedAt = v3
	p1:SetUsedAt(p2, v3)

	if ok then
		if p1.Freeze then
			result = DeepFreeze(result)
		end

		p2.Value = result
		p2.RetrievedAt = v3
		p1.Updated:Fire(p3)

		return result
	end

	if p1.ReturnStale then
		return p2.Value
	end

	return nil
end
function t.GetAsync(p1, p2) --[[ GetAsync | Line: 156 | Upvalues: Lock (copy) ]]
	local v1 = os.clock()
	local v2 = p1.AssertKey(p2)
	local v3 = p1.Cache[v2]

	if v3 then
		p1:SetUsedAt(v3, v1)
	else
		local t = {
			Lock = Lock.new(),
			UsedAt = v1
		}

		p1.Cache[v2] = t
		p1:InsertUsedAt(t)
		v3 = t
	end

	return v3.Lock:Call(AsyncCallback, p1, v3, p2, v1)
end
function t.Delete(p1, p2) --[[ Delete | Line: 174 ]]
	local v1 = p1.AssertKey(p2)

	if not p1.Cache[v1] then
		return
	end

	p1.Cache[v1] = nil
	p1.Deleted:Fire(p2)
end

local v1 = table.freeze({
	__index = table.freeze(t)
})
local v2 = Asserts.Table({
	Callback = Asserts.Function,
	AssertKey = Asserts.Function,
	MaxAge = Asserts.Optional(Asserts.NonNegative),
	FailureRetryDelay = Asserts.Optional(Asserts.NonNegative),
	ReturnStale = Asserts.Optional(Asserts.Boolean),
	Freeze = Asserts.Optional(Asserts.Boolean)
})

return table.freeze({
	new = function(p1) --[[ new | Line: 210 | Upvalues: v2 (copy), Bindable (copy), v1 (copy) ]]
		v2(p1)

		local t = {
			Updated = Bindable.new(),
			Deleted = Bindable.new(),
			Callback = p1.Callback,
			AssertKey = p1.AssertKey,
			MaxAge = p1.MaxAge or (1 / 0),
			FailureRetryDelay = p1.FailureRetryDelay or 300
		}

		t.ReturnStale = if p1.ReturnStale == nil then true else p1.ReturnStale
		t.Freeze = if p1.Freeze == nil then true else p1.Freeze
		t.Cache = {}

		local v4 = setmetatable(t, v1)

		table.freeze(v4)

		return v4
	end
})