-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Modules = Library:WaitForChild("Modules")
local Asserts = require(Library.Asserts)
local Types = require(Items.Types)
local v1 = require(Modules.Event)
local t = {}

t.__index = t
t.TradeCreated = v1.new()
t.TradeSetReady = v1.new()
t.TradeSetConfirmed = v1.new()
t.TradeSetItem = v1.new()
t.TradeMessage = v1.new()
t.TradeExecuting = v1.new()
t.TradeDestroyed = v1.new()
function t.new(p1, p2, p3, p4, p5) --[[ new | Line: 43 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Player(p2)
	Asserts.Player(p3)

	return setmetatable({
		_destroyed = false,
		_executing = false,
		_counter = 1,
		_destroyCallback = p5,
		_id = p1,
		_players = { p2, p3 },
		_ready = { false, false },
		_confirmed = { false, false },
		_items = {
			{},
			{}
		},
		_lastModified = p4
	}, t)
end
function t.Created(p1) --[[ Created | Line: 70 | Upvalues: t (copy) ]]
	t.TradeCreated:FireAsync(p1._id, p1:Player1(1), p1:Player1(2), p1._lastModified)
end
function t.PlayerIndex(p1, p2) --[[ PlayerIndex | Line: 74 ]]
	return table.find(p1._players, p2)
end
function t.Index1(p1, p2) --[[ Index1 | Line: 78 ]]
	return p2
end
function t.Index2(p1, p2) --[[ Index2 | Line: 82 ]]
	return 3 - p2
end
function t.Player1(p1, p2) --[[ Player1 | Line: 86 ]]
	return p1._players[p2]
end
function t.Player2(p1, p2) --[[ Player2 | Line: 90 ]]
	return p1._players[3 - p2]
end
function t.SetReady(p1, p2, p3, p4) --[[ SetReady | Line: 94 | Upvalues: t (copy) ]]
	if not p1._destroyed then
		p1._ready[p2] = p3
		p1._readyTimer = p4
		t.TradeSetReady:FireAsync(p1._id, p2, p3)
	end
end
function t.SetConfirmed(p1, p2, p3, p4) --[[ SetConfirmed | Line: 105 | Upvalues: t (copy) ]]
	if not p1._destroyed then
		p1._confirmed[p2] = p3
		p1._confirmedTimer = p4
		t.TradeSetConfirmed:FireAsync(p1._id, p2, p3)
	end
end
function t.SetItem(p1, p2, p3, p4, p5, p6, p7) --[[ SetItem | Line: 122 | Upvalues: Types (copy), t (copy) ]]
	local v1 = p1._items[p2]
	local v2 = v1[p3]

	if not v2 then
		v2 = {}
		v1[p3] = v2
	end

	local v3

	if p5 then
		local v4 = Types.From(p3, p5):Clone()

		if p5._uid then
			v4:SetUID(p5._uid)
		end

		v4:Freeze()
		v3 = v4
	else
		v3 = nil
	end

	v2[p4] = v3
	p1._counter = p6
	p1._lastModified = p7
	t.TradeSetItem:FireAsync(p1._id, p2, p3, p4, v3, p6, p7)
end
function t.Message(p1, p2, p3) --[[ Message | Line: 157 | Upvalues: t (copy) ]]
	t.TradeMessage:FireAsync(p1._id, p2, p3)
end
function t.Execute(p1) --[[ Execute | Line: 162 | Upvalues: t (copy) ]]
	if p1._destroyed then
		return
	end

	if not p1._executing then
		p1._executing = true
		t.TradeExecuting:FireAsync(p1._id)
	end
end
function t.IsEveryoneReady(p1) --[[ IsEveryoneReady | Line: 174 ]]
	for i, v in ipairs(p1._ready) do
		if not v then
			return false
		end
	end

	return true
end
function t.Destroy(p1, p2) --[[ Destroy | Line: 183 | Upvalues: t (copy) ]]
	if p1._destroyed then
		return false
	end

	p1._destroyed = true
	t.TradeDestroyed:FireAsync(p1._id, p2)
	p1._destroyCallback()

	return true
end

return t