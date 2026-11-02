-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Functions = require(ReplicatedStorage.Library.Functions)
local Variables = require(ReplicatedStorage.Library.Variables)
local Signal = require(ReplicatedStorage.Library.Signal)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local TradingCmds = require(ReplicatedStorage.Library.Client.TradingCmds)
local FFlags = require(ReplicatedStorage.Library.Client.FFlags)
local Message = require(ReplicatedStorage.Library.Client.Message)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Audio = require(ReplicatedStorage.Library.Audio)
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local LocalPlayer = game.Players.LocalPlayer
local v2 = GUI.TradeMessage()
local Frame = v2:WaitForChild("Frame")
local Title = Frame.Message.Title
local Buttons = Frame.Buttons
local Yes = Buttons.Yes
local No = Buttons.No
local v3 = UDim2.new(0.5, 0, -0.2, 5)
local t = {}

t.__index = t
t.__class = "TradingNotifs"
function t._build() --[[ _build | Line: 57 | Upvalues: t (copy), FuncWrapper (copy) ]]
	local v2 = setmetatable({}, t)

	v2._tradeQueue = {}
	v2._activeTrade = nil
	v2._tradeResumeTime = nil
	v2._funcWrapper = FuncWrapper.CreateWrapper(v2)
	v2:_init()

	return v2
end
function t._getQueue(p1, p2) --[[ _getQueue | Line: 73 ]]
	for i, v in ipairs(p1._tradeQueue) do
		if v.player == p2 then
			return v
		end
	end

	return nil
end
function t.Remove(p1) --[[ Remove | Line: 82 | Upvalues: v3 (copy), Functions (copy), Frame (copy), v2 (copy) ]]
	if not p1._activeTrade then
		return
	end

	p1._activeTrade.removing = true
	Functions.Tween(Frame, {
		Position = v3
	}, { 0.35, "Quad", "Out" }).Completed:Connect(function() --[[ Line: 88 | Upvalues: v2 (ref), p1 (copy) ]]
		v2.Enabled = false
		p1._activeTrade = nil
	end)
end
function t.HasTradeNotif(p1) --[[ HasTradeNotif | Line: 99 ]]
	if p1._activeTrade ~= nil then
		return true
	end

	return #p1._tradeQueue > 0
end
function t._onTradeRequested(p1, p2, p3) --[[ _onTradeRequested | Line: 104 | Upvalues: LocalPlayer (copy), v1 (copy) ]]
	local v12 = LocalPlayer
	local v2 = if p2 == v12 then p3 or p2 else p2

	v1:AtTrace():Log(("Trade requested from %* by %*, self:"):format(v2.Name, v12.Name), p1)

	if p2 == v12 then
		return
	end

	if p1:_getQueue(v2) then
		return
	end

	table.insert(p1._tradeQueue, {
		duration = 10,
		created = nil,
		player = v2
	})
end
function t._onTradeAccepted(p1) --[[ _onTradeAccepted | Line: 124 | Upvalues: v1 (copy), TradingCmds (copy), Variables (copy), TabController (copy), FFlags (copy), Message (copy) ]]
	local v12 = v1:AtTrace()

	v12:Log(("Trade accept button pressed, HasRequestFromPlayer: %*, self:"):format(p1._activeTrade and TradingCmds.HasRequestFromPlayer(p1._activeTrade.player)), p1)

	if not p1._activeTrade then
		return
	end

	if Variables.Console and TabController.Get() ~= nil then
		return
	end

	if TradingCmds.HasRequestFromPlayer(p1._activeTrade.player) then
		if not (FFlags.Get(FFlags.Keys.Trading) or FFlags.CanBypass()) then
			return
		end

		local v4, v5 = TradingCmds.Request(p1._activeTrade.player)

		v1:AtTrace():Log((("Trade request sent to %*, success: %*, errorMsg: %*"):format(p1._activeTrade.player.Name, v4, v5)))

		if v4 or not v5 then
			p1:Remove()

			return
		end

		Message.New(v5, {
			err = true
		})

		return
	end

	Message.New("You no longer have a trade request from " .. p1._activeTrade.player.Name, {
		err = true
	})
	p1:Remove()
end
function t._onTradeRejected(p1) --[[ _onTradeRejected | Line: 146 | Upvalues: v1 (copy), TradingCmds (copy) ]]
	v1:AtTrace():Log(("Trade reject button pressed, HasRequestFromPlayer: %*, self:"):format(p1._activeTrade and TradingCmds.HasRequestFromPlayer(p1._activeTrade.player)), p1)

	if not p1._activeTrade then
		return
	end

	TradingCmds.Reject(p1._activeTrade.player)
	p1:Remove()
end
function t._update(p1) --[[ _update | Line: 154 | Upvalues: Signal (copy), Variables (copy), TradingCmds (copy), Frame (copy), v3 (copy), v2 (copy), Title (copy), Audio (copy), Functions (copy) ]]
	if #p1._tradeQueue == 0 or (p1._activeTrade ~= nil or (Signal.Invoke("Notifications: Has Queue") or Variables.Trading)) then
		return
	end

	if p1._tradeResumeTime and math.abs(p1._tradeResumeTime - workspace:GetServerTimeNow()) < 0.5 then
		return
	end

	local player = p1._tradeQueue[1].player

	if not TradingCmds.HasRequestFromPlayer(player) then
		table.remove(p1._tradeQueue, 1)

		return
	end

	p1._tradeResumeTime = workspace:GetServerTimeNow()
	Variables.HideProgressUI = true

	local v32 = assert(p1._tradeQueue[1], "Trade queue is empty")

	p1._activeTrade = v32
	table.remove(p1._tradeQueue, 1)
	v32.created = tick()
	Frame.Position = v3
	v2.Enabled = true
	Title.Text = "Trade from @" .. (player:GetAttribute("Partner") and v32.player.Name .. " (\240\159\148\165 Partner)" or v32.player.Name)
	Audio.Play("rbxassetid://133842042346471", script, nil, 2)
	Functions.Tween(Frame, {
		Position = UDim2.new(0.5, 0, 0.05, 5)
	}, { 0.65, "Back", "Out" })
	task.delay(v32.duration, function() --[[ Line: 190 | Upvalues: v32 (copy), p1 (copy) ]]
		if v32.removing then
			return
		end

		p1:Remove()
	end)
end
function t._init(p1) --[[ _init | Line: 201 | Upvalues: RunService (copy), GUI (copy), Yes (copy), No (copy), Signal (copy), TradingCmds (copy), ButtonFX (copy) ]]
	RunService.RenderStepped:Connect(p1._funcWrapper(p1._update))
	GUI.ButtonActivated(Yes, p1._funcWrapper(p1._onTradeAccepted))
	GUI.ButtonActivated(No, p1._funcWrapper(p1._onTradeRejected))
	Signal.Invoked(Signal.MAP.Client.TradingNotifications.HAS_TRADE_NOTIF).OnInvoke = p1._funcWrapper(p1.HasTradeNotif)
	Signal.Fired(Signal.MAP.Client.TradingNotifications.FORCE_CLOSE_NOTIF):Connect(p1._funcWrapper(p1.Remove))
	TradingCmds.TradeRequested:Connect(p1._funcWrapper(p1._onTradeRequested))
	ButtonFX(Yes)
	ButtonFX(No)
end

return t._build()