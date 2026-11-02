-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Types = Library:WaitForChild("Types")
local Items = Library:WaitForChild("Items")
local Client = Library:WaitForChild("Client")
local Modules = Library:WaitForChild("Modules")
local Asserts = require(Library.Asserts)
local Functions = require(Library.Functions)
local CurrencyCmds = require(Library.Client.CurrencyCmds)
local Trading = require(Types.Trading)
local Types2 = require(Items.Types)
local v1 = require(Modules.Event)
local Network = require(Client.Network)
local Save = require(Client.Save)
local FFlags = require(Client.FFlags)
local TradeState = require(script.TradeState)
local Trading2 = Network.NET_MAP.Trading
local t = {}
local t2 = {}
local v2 = 0

local function Requests(p1) --[[ Requests | Line: 24 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		v1 = {}
		t[p1] = v1
	end

	return v1
end

local function getTradingUnlockMessage() --[[ getTradingUnlockMessage | Line: 33 | Upvalues: Trading (copy) ]]
	return ("You need to reach <font color=\"rgb(255, 225, 0)\">REBIRTH %d</font> to unlock trading!"):format(Trading.RequiredRebirth)
end

local t3 = {
	TradeRequested = v1.new(),
	TradeRejected = v1.new(),
	TradeRequestsUpdated = v1.new(),
	TradeCreated = TradeState.TradeCreated,
	TradeSetReady = TradeState.TradeSetReady,
	TradeSetConfirmed = TradeState.TradeSetConfirmed,
	TradeSetItem = TradeState.TradeSetItem,
	TradeMessage = TradeState.TradeMessage,
	TradeExecuting = TradeState.TradeExecuting,
	TradeDestroyed = TradeState.TradeDestroyed,
	GetState = function(p1) --[[ GetState | Line: 124 | Upvalues: t2 (copy), v2 (ref) ]]
		return t2[if p1 then p1 else v2]
	end,
	GetAllRequests = function() --[[ GetAllRequests | Line: 128 | Upvalues: t (copy) ]]
		return t
	end,
	GetRequestFromPlayer = function(p1) --[[ GetRequestFromPlayer | Line: 132 | Upvalues: t (copy) ]]
		return t[p1]
	end
}

function t3.HasRequestFromPlayer(p1) --[[ HasRequestFromPlayer | Line: 136 | Upvalues: t3 (copy), Players (copy) ]]
	local v1 = t3.GetRequestFromPlayer(p1)

	return if v1 == nil then false else v1[Players.LocalPlayer] ~= nil
end
function t3.GetOutgoingRequestToPlayer(p1) --[[ GetOutgoingRequestToPlayer | Line: 145 | Upvalues: t (copy), Players (copy) ]]
	local v1 = t[Players.LocalPlayer]

	if v1 then
		return v1[p1]
	end

	return nil
end
function t3.HasOutgoingRequestToPlayer(p1) --[[ HasOutgoingRequestToPlayer | Line: 154 | Upvalues: t3 (copy) ]]
	return t3.GetOutgoingRequestToPlayer(p1) ~= nil
end
function t3.HasTradingUnlocked(p1) --[[ HasTradingUnlocked | Line: 158 | Upvalues: Save (copy), Trading (copy), getTradingUnlockMessage (copy) ]]
	local v1 = Save.Get(p1)

	if not v1 then
		return false, "Player is still Loading!"
	end

	if Trading.HasRequiredRebirth(if typeof(v1.Rebirth) == "number" then v1.Rebirth else 0) then
		return true
	end

	return false, getTradingUnlockMessage()
end
function t3.Request(p1) --[[ Request | Line: 172 | Upvalues: Players (copy), Asserts (copy), FFlags (copy), t3 (copy), Save (copy), Network (copy), Trading2 (copy) ]]
	Asserts.Player(p1)
	assert(Players.LocalPlayer ~= p1, "You cannot request a trade with yourself!")

	if not (FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass()) then
		return false, "Sorry! This is disabled right now, try again soon!"
	end

	local v2, v3 = t3.HasTradingUnlocked()

	if not v2 then
		return false, v3
	end

	if not Save.Get(p1) then
		return false, "Player is still loading!"
	end

	if t3.HasTradingUnlocked(p1) then
		return Network.Invoke(Trading2.REQUEST, p1)
	end

	return false, p1.Name .. " has not unlocked trading yet!"
end
function t3.Reject(p1) --[[ Reject | Line: 198 | Upvalues: Players (copy), Asserts (copy), Network (copy), Trading2 (copy) ]]
	Asserts.Player(p1)
	assert(Players.LocalPlayer ~= p1, "You cannot reject your own trade!")

	return Network.Invoke(Trading2.REJECT, p1)
end
function t3.Decline() --[[ Decline | Line: 206 | Upvalues: t3 (copy), Network (copy), Trading2 (copy) ]]
	local v1 = t3.GetState()

	if v1 then
		return Network.Invoke(Trading2.DECLINE, v1._id)
	end

	return false, "Trade not found!"
end
function t3.SetReady(p1) --[[ SetReady | Line: 215 | Upvalues: t3 (copy), FFlags (copy), Network (copy), Trading2 (copy) ]]
	local v1 = t3.GetState()

	if not v1 then
		return false, "Trade not found!"
	end

	if FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass() then
		return Network.Invoke(Trading2.SET_READY, v1._id, p1, v1._counter)
	end

	return false, "Sorry! This is disabled right now, try again soon!"
end
function t3.SetConfirmed(p1) --[[ SetConfirmed | Line: 226 | Upvalues: t3 (copy), FFlags (copy), Network (copy), Trading2 (copy) ]]
	local v1 = t3.GetState()

	if not v1 then
		return false, "Trade not found!"
	end

	if FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass() then
		return Network.Invoke(Trading2.SET_CONFIRMED, v1._id, p1, v1._counter)
	end

	return false, "Sorry! This is disabled right now, try again soon!"
end
function t3.SetItem(p1, p2, p3) --[[ SetItem | Line: 237 | Upvalues: t3 (copy), Trading (copy), FFlags (copy), Network (copy), Trading2 (copy) ]]
	local v1 = t3.GetState()

	if not v1 then
		return false, "Trade not found!"
	end

	if not Trading.IsTradableItemType(p1) then
		return false, "That trade item type is disabled."
	end

	if FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass() then
		return Network.Invoke(Trading2.SET_ITEM, v1._id, p1, p2, p3)
	end

	return false, "Sorry! This is disabled right now, try again soon!"
end
function t3.Message(p1) --[[ Message | Line: 250 | Upvalues: Trading (copy), t3 (copy), Network (copy), Trading2 (copy) ]]
	assert(type(p1) == "string", "Expected message to be a string!")

	if #p1 == 0 then
		return false, "Cannot send an empty message!"
	end

	if Trading.MessageLimit < #p1 then
		return false, "Message is too long! Please keep it under " .. tostring(Trading.MessageLimit) .. " characters!"
	end

	local v2 = t3.GetState()

	if v2 then
		return Network.Invoke(Trading2.MESSAGE, v2._id, p1)
	end

	return false, "Trade not found!"
end
function t3.SetCurrency(p1, p2) --[[ SetCurrency | Line: 267 | Upvalues: Trading (copy), CurrencyCmds (copy), FFlags (copy), t3 (copy) ]]
	if not Trading.IsTradableItemType("Currency") then
		return false, "Currency trading is disabled."
	end

	local v1 = CurrencyCmds.GetItem(p1)

	if not v1 then
		return false, "You don\'t have any " .. p1 .. "!"
	end

	if FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass() then
		return t3.SetItem("Currency", v1:GetId(), p2)
	end

	return false, "Sorry! This is disabled right now, try again soon!"
end
function t3.GetTradeSettings(p1) --[[ GetTradeSettings | Line: 282 | Upvalues: Asserts (copy), Save (copy) ]]
	Asserts.Player(p1)

	local v1 = Save.Get(p1)

	if v1 and (v1.Settings and v1.Settings.Trading) then
		return true, v1.Settings.Trading
	end

	return false
end
function t3.CanTrade(p1) --[[ CanTrade | Line: 292 | Upvalues: FFlags (copy) ]]
	if not (FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass()) then
		return false, "Sorry! This is disabled right now, try again soon!"
	end

	if p1:IsLocked() then
		return false, "Item is locked!"
	end

	if p1:IsTradable() then
		return true
	end

	return false, "Item is not tradable!"
end
function t3.DecodeItems(p1) --[[ DecodeItems | Line: 304 | Upvalues: Types2 (copy), Functions (copy) ]]
	local t = {}

	for k, v in pairs(p1) do
		local v1 = Types2.TypeUnchecked(k)

		if v1 then
			for k2, v2 in pairs(v) do
				local v22 = v1:From(Functions.DeepCopyUnsafe(v2))

				v22:SetUID(k2)
				table.insert(t, v22)
			end
		end
	end

	return t
end
Network.Fired(Trading2.SETTINGS_UPDATED):Connect(function(p1, p2) --[[ Line: 319 | Upvalues: Asserts (copy), Save (copy) ]]
	Asserts.nonNegativeInteger(p2)
	assert(if p2 >= 1 then if p2 <= 3 then true else false else false, "Settings value must be between 1 and 3, got " .. tostring(p2))

	local v3 = Save.Get(p1)

	if not (v3 and (v3.Settings and v3.Settings.Trading)) then
		return
	end

	v3.Settings.Trading = p2
end)
Network.Fired(Trading2.REQUESTED):Connect(function(p1, p2, p3) --[[ Line: 333 | Upvalues: t (copy), t3 (copy) ]]
	local v1 = t[p1]

	if not v1 then
		v1 = {}
		t[p1] = v1
	end

	v1[p2] = p3
	t3.TradeRequested:FireAsync(p1, p2, p3)
end)
Network.Fired(Trading2.REJECTED):Connect(function(p1, p2, p3) --[[ Line: 338 | Upvalues: t (copy), t3 (copy) ]]
	local v1 = t[p1]

	if not v1 then
		v1 = {}
		t[p1] = v1
	end

	v1[p2] = nil
	t3.TradeRejected:FireAsync(p1, p2, p3)
end)
Network.Fired(Trading2.CREATED):Connect(function(p1, p2, p3, p4) --[[ Line: 344 | Upvalues: t2 (copy), t (copy), t3 (copy), TradeState (copy), v2 (ref) ]]
	local v1 = not t2[p1]

	assert(v1, "Trade with ID " .. tostring(p1) .. " already exists!")

	local v3 = t[p2]

	if v3 and v3[p3] then
		v3[p3] = nil
	end

	local v4 = t[p3]

	if v4 and v4[p2] then
		v4[p2] = nil
	end

	t3.TradeRequestsUpdated:FireAsync()

	local v5 = TradeState.new(p1, p2, p3, p4, function() --[[ Line: 358 | Upvalues: t2 (ref), p1 (copy), v2 (ref) ]]
		t2[p1] = nil

		if v2 ~= p1 then
			return
		end

		v2 = 0
	end)

	t2[p1] = v5
	v2 = p1
	v5:Created()
end)
Network.Fired(Trading2.SET_READY_EVENT):Connect(function(p1, p2, p3, p4) --[[ Line: 371 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:SetReady(p2, p3, p4)
end)
Network.Fired(Trading2.SET_CONFIRMED_EVENT):Connect(function(p1, p2, p3, p4) --[[ Line: 379 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:SetConfirmed(p2, p3, p4)
end)
Network.Fired(Trading2.SET_ITEM_EVENT):Connect(function(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 387 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:SetItem(p2, p3, p4, p5, p6, p7)
end)
Network.Fired(Trading2.MESSAGE_EVENT):Connect(function(p1, p2, p3) --[[ Line: 403 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:Message(p2, p3)
end)
Network.Fired(Trading2.EXECUTING):Connect(function(p1) --[[ Line: 410 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:Execute()
end)
Network.Fired(Trading2.DESTROYED):Connect(function(p1, p2) --[[ Line: 417 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	t2[p1] = nil
	v1:Destroy(p2)
end)
Network.Fired(Trading2.ADD_HISTORY):Connect(function(p1) --[[ Line: 425 | Upvalues: Save (copy), Functions (copy), Trading (copy) ]]
	local v1 = Save.Get()

	if not v1 then
		return
	end

	Functions.InsertWithLimit(v1.TradeHistory, p1, Trading.HistoryLimit)
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 432 | Upvalues: t (copy), t3 (copy) ]]
	t[p1] = nil

	for k, v in pairs(t) do
		v[p1] = nil
	end

	t3.TradeRequestsUpdated:FireAsync()
end)

return t3