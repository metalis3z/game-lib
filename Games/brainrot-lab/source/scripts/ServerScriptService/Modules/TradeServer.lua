--!strict
-- LOCATION: ServerScriptService/Modules/TradeServer
-- Server-side Trade System with full validation and anti-exploit measures

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local TradeServer = {}

-- [ CONSTANTS ]
local REQUEST_TIMEOUT = 15 -- seconds before trade request expires
local MAX_OFFER_SLOTS = 20 -- max items per side in a trade

-- [ STATE ]
-- Active trade sessions: { [player1] = session, [player2] = session }
local playerSessions: { [Player]: any } = {}
-- Pending trade requests: { [targetPlayer] = { requester, expireTime } }
local pendingRequests: { [Player]: any } = {}

-- [ EVENTS ]
local TradeEvents = ReplicatedStorage:WaitForChild("TradeSystem"):WaitForChild("TradeEvents")

-- [ HELPERS ]

local function getPlayerTools(player: Player): { Tool }
	local tools = {}
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("IsTemporary") ~= true then
				table.insert(tools, child)
			end
		end
	end
	local character = player.Character
	if character then
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") and child:GetAttribute("IsTemporary") ~= true then
				table.insert(tools, child)
			end
		end
	end
	return tools
end

local function isToolValid(player: Player, tool: Tool): boolean
	if not tool or not tool.Parent then return false end
	if not tool:IsA("Tool") then return false end
	if tool:GetAttribute("IsTemporary") == true then return false end
	local backpack = player:FindFirstChild("Backpack")
	local character = player.Character
	if tool.Parent ~= backpack and tool.Parent ~= character then return false end
	return true
end

local function serializeTool(tool: Tool)
	return {
		name = tool:GetAttribute("OriginalName") or tool.Name,
		mutation = tool:GetAttribute("Mutation") or "Normal",
		rarity = tool:GetAttribute("Rarity") or "Common",
		level = tool:GetAttribute("Level") or 1,
	}
end

local function buildStateForPlayer(session: any, player: Player)
	local partner = (session.player1 == player) and session.player2 or session.player1
	
	-- My offer (with tool references)
	local myOffer = {}
	for _, tool in ipairs(session.offers[player]) do
		local entry = serializeTool(tool)
		entry.tool = tool
		table.insert(myOffer, entry)
	end
	
	-- Partner's offer (data only, no tool refs)
	local partnerOffer = {}
	for _, tool in ipairs(session.offers[partner]) do
		table.insert(partnerOffer, serializeTool(tool))
	end
	
	return {
		partnerName = partner.Name,
		myOffer = myOffer,
		partnerOffer = partnerOffer,
		myAccepted = session.accepted[player] or false,
		partnerAccepted = session.accepted[partner] or false,
	}
end

local function sendStateUpdate(session: any)
	for _, player in ipairs({ session.player1, session.player2 }) do
		if player and player.Parent then
			local state = buildStateForPlayer(session, player)
			TradeEvents.UpdateTradeState:FireClient(player, state)
		end
	end
end

local function cancelSession(session: any, reason: string)
	if session.cancelled then return end
	session.cancelled = true
	
	-- Clear InTrade attributes
	for _, player in ipairs({ session.player1, session.player2 }) do
		if player and player.Parent then
			for _, tool in ipairs(session.offers[player]) do
				if tool and tool.Parent then
					tool:SetAttribute("InTrade", false)
				end
			end
			playerSessions[player] = nil
			TradeEvents.TradeCancelled:FireClient(player, reason)
		end
	end
end

local function executeTrade(session: any)
	-- Final validation: check all tools still exist and are valid
	for _, player in ipairs({ session.player1, session.player2 }) do
		for _, tool in ipairs(session.offers[player]) do
			if not isToolValid(player, tool) then
				cancelSession(session, "An item was no longer valid")
				return false
			end
		end
	end
	
	-- Clear InTrade attributes
	for _, player in ipairs({ session.player1, session.player2 }) do
		for _, tool in ipairs(session.offers[player]) do
			tool:SetAttribute("InTrade", false)
		end
	end
	
	-- Unequip any tools that are equipped
	for _, player in ipairs({ session.player1, session.player2 }) do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			for _, tool in ipairs(session.offers[player]) do
				if tool.Parent == character and humanoid then
					humanoid:UnequipTools()
				end
			end
		end
	end
	
	-- Move tools from player1 to player2
	local backpack2 = session.player2:FindFirstChild("Backpack")
	if backpack2 then
		for _, tool in ipairs(session.offers[session.player1]) do
			tool.Parent = backpack2
		end
	end
	
	-- Move tools from player2 to player1
	local backpack1 = session.player1:FindFirstChild("Backpack")
	if backpack1 then
		for _, tool in ipairs(session.offers[session.player2]) do
			tool.Parent = backpack1
		end
	end
	
	-- Notify both players
	for _, player in ipairs({ session.player1, session.player2 }) do
		if player and player.Parent then
			playerSessions[player] = nil
			TradeEvents.TradeComplete:FireClient(player)
		end
	end
	
	return true
end

-- [ EVENT HANDLERS ]

local function onRequestTrade(player: Player, targetPlayer: Player)
	-- Validate
	print("[TradeServer] RequestTrade received from", player.Name, "to", targetPlayer and targetPlayer.Name or "nil")
	if not targetPlayer or not targetPlayer.Parent then return end
	if targetPlayer == player then return end
	if playerSessions[player] then return end -- already in a trade
	if playerSessions[targetPlayer] then -- target already in trade
		TradeEvents.TradeRequestResult:FireClient(player, false, targetPlayer.Name .. " is already in a trade")
		return
	end
	if pendingRequests[targetPlayer] then -- target has pending request
		TradeEvents.TradeRequestResult:FireClient(player, false, targetPlayer.Name .. " has a pending request")
		return
	end
	
	-- Create pending request
	pendingRequests[targetPlayer] = {
		requester = player,
		expireTime = os.clock() + REQUEST_TIMEOUT,
	}
	
	-- Notify target
	TradeEvents.TradeRequestReceived:FireClient(targetPlayer, player.Name, player.UserId)
	
	-- Set up timeout
	task.delay(REQUEST_TIMEOUT, function()
		if pendingRequests[targetPlayer] and pendingRequests[targetPlayer].requester == player then
			pendingRequests[targetPlayer] = nil
			TradeEvents.TradeRequestResult:FireClient(player, false, "Request timed out")
		end
	end)
end

local function onRespondTradeRequest(player: Player, requester: Player, accepted: boolean)
	local pending = pendingRequests[player]
	if not pending or pending.requester ~= requester then return end
	
	pendingRequests[player] = nil
	
	if not accepted then
		TradeEvents.TradeRequestResult:FireClient(requester, false, player.Name .. " declined the trade")
		return
	end
	
	-- Check both players are still available
	if not requester.Parent or not player.Parent then return end
	if playerSessions[requester] or playerSessions[player] then
		TradeEvents.TradeRequestResult:FireClient(requester, false, "Trade no longer possible")
		return
	end
	
	-- Create trade session
	local session = {
		player1 = requester,
		player2 = player,
		offers = {
			[requester] = {},
			[player] = {},
		},
		accepted = {
			[requester] = false,
			[player] = false,
		},
		cancelled = false,
	}
	
	playerSessions[requester] = session
	playerSessions[player] = session
	
	-- Notify BOTH players that trade was accepted (each gets the other's name)
	TradeEvents.TradeRequestResult:FireClient(requester, true, player.Name)
	TradeEvents.TradeRequestResult:FireClient(player, true, requester.Name)
	
	-- Send initial state to both players
	sendStateUpdate(session)
end

local function onAddItem(player: Player, tool: Tool)
	local session = playerSessions[player]
	if not session or session.cancelled then return end
	
	-- Validate tool
	if not isToolValid(player, tool) then return end
	if tool:GetAttribute("InTrade") == true then return end -- already in offer
	
	-- Check offer limit
	if #session.offers[player] >= MAX_OFFER_SLOTS then return end
	
	-- Add to offer
	tool:SetAttribute("InTrade", true)
	table.insert(session.offers[player], tool)
	
	-- Reset both players' accept status
	session.accepted[session.player1] = false
	session.accepted[session.player2] = false
	
	-- Update both clients
	sendStateUpdate(session)
end

local function onRemoveItem(player: Player, tool: Tool)
	local session = playerSessions[player]
	if not session or session.cancelled then return end
	
	-- Find and remove from offer
	local found = false
	for i, t in ipairs(session.offers[player]) do
		if t == tool then
			table.remove(session.offers[player], i)
			tool:SetAttribute("InTrade", false)
			found = true
			break
		end
	end
	
	if not found then return end
	
	-- Reset both players' accept status
	session.accepted[session.player1] = false
	session.accepted[session.player2] = false
	
	-- Update both clients
	sendStateUpdate(session)
end

local function onAcceptTrade(player: Player)
	local session = playerSessions[player]
	if not session or session.cancelled then return end
	
	-- Set accept status
	session.accepted[player] = true
	
	-- Check if both accepted
	if session.accepted[session.player1] and session.accepted[session.player2] then
		-- Execute trade
		executeTrade(session)
	else
		-- Update both clients with new accept status
		sendStateUpdate(session)
	end
end

local function onCancelTrade(player: Player)
	local session = playerSessions[player]
	if not session or session.cancelled then return end
	cancelSession(session, player.Name .. " cancelled the trade")
end

local function onPlayerRemoving(player: Player)
	-- Cancel any active trade session
	local session = playerSessions[player]
	if session then
		cancelSession(session, player.Name .. " left the game")
	end
	
	-- Clear pending requests
	pendingRequests[player] = nil
	for target, pending in pairs(pendingRequests) do
		if pending.requester == player then
			pendingRequests[target] = nil
		end
	end
end

-- [ LIFECYCLE ]

function TradeServer:Init(controllers: any)
	print("[TradeServer] Initializing...")
	
	-- Connect RemoteEvents
	TradeEvents.RequestTrade.OnServerEvent:Connect(onRequestTrade)
	TradeEvents.RespondTradeRequest.OnServerEvent:Connect(onRespondTradeRequest)
	TradeEvents.AddItem.OnServerEvent:Connect(onAddItem)
	TradeEvents.RemoveItem.OnServerEvent:Connect(onRemoveItem)
	TradeEvents.AcceptTrade.OnServerEvent:Connect(onAcceptTrade)
	TradeEvents.CancelTrade.OnServerEvent:Connect(onCancelTrade)
	
	-- Handle player leaving
	Players.PlayerRemoving:Connect(onPlayerRemoving)
	
	print("[TradeServer] Initialized.")
end

function TradeServer:Start()
	print("[TradeServer] Started.")
end

return TradeServer