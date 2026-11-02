--!strict
local NotificationService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)

local NotifyRemote = Net:RemoteEvent("NotificationService/Notify")

function NotificationService.Notify(Player: Player, Text: string, Duration: number?, Sound: string?, Position: string?, NotificationId: string?)
	if not Player or not Player.Parent then return end
	NotifyRemote:FireClient(Player, Text, Duration or 5, Sound, Position, nil, NotificationId)
end

function NotificationService.Error(Player: Player, Text: string)
	NotificationService.Notify(Player, ("<font color=\"#FA0103\">%s</font>"):format(Text), 5, "Sounds.Sfx.Error")
end

function NotificationService.Success(Player: Player, Text: string)
	NotificationService.Notify(Player, ("<font color=\"#92FF67\">%s</font>"):format(Text), 5, "Sounds.Sfx.Success")
end

function NotificationService.NotifyTop(Player: Player, Text: string, Duration: number?, Sound: string?)
	NotificationService.Notify(Player, Text, Duration or 5, Sound, "Top")
end

function NotificationService.CreateUpdatableNotify(Player: Player, NotificationId: string, Text: string, Sound: string?, Position: string?)
	NotificationService.Notify(Player, Text, 1e9, Sound, Position, NotificationId)
end

function NotificationService.UpdateNotify(Player: Player, NotificationId: string, NewText: string)
	NotificationService.Notify(Player, NewText, 1e9, nil, nil, NotificationId)
end

function NotificationService.CloseNotify(Player: Player, NotificationId: string, FadeTime: number?)
	if not Player or not Player.Parent then return end
	NotifyRemote:FireClient(Player, "", FadeTime or 0, nil, nil, nil, NotificationId, true)
end

function NotificationService.Broadcast(Text: string, Duration: number?, Sound: string?)
	NotifyRemote:FireAllClients(Text, Duration or 5, Sound, nil, nil, nil)
end

function NotificationService.BroadcastTop(Text: string, Duration: number?, Sound: string?)
	NotifyRemote:FireAllClients(Text, Duration or 5, Sound, "Top", nil, nil)
end

function NotificationService.BroadcastUpdatable(NotificationId: string, Text: string, Sound: string?, Position: string?)
	NotifyRemote:FireAllClients(Text, 1e9, Sound, Position, nil, NotificationId)
end

function NotificationService.UpdateBroadcast(NotificationId: string, NewText: string)
	NotifyRemote:FireAllClients(NewText, 1e9, nil, nil, nil, NotificationId)
end

function NotificationService.CloseBroadcast(NotificationId: string, FadeTime: number?)
	NotifyRemote:FireAllClients("", FadeTime or 0, nil, nil, nil, NotificationId, true)
end

local function runTimer(
	Seconds: number,
	FormatFn: (number) -> string,
	update: (text: string) -> (),
	close: () -> (),
	OnComplete: (() -> ())?
)
	local cancelled = false
	update(FormatFn(Seconds))

	task.spawn(function()
		local startClock = os.clock()
		local nextTick = 1

		while nextTick <= Seconds do
			local target = startClock + nextTick
			local remaining = target - os.clock()
			if remaining > 0 then
				task.wait(remaining)
			end
			if cancelled then return end

			local secondsLeft = Seconds - nextTick
			if secondsLeft <= 0 then
				update(FormatFn(0))
				close()
			else
				update(FormatFn(secondsLeft))
			end
			nextTick += 1
		end

		if not cancelled and OnComplete then
			OnComplete()
		end
	end)

	return function(closeFade: number?)
		if cancelled then return end
		cancelled = true
		close()
	end
end

function NotificationService.BroadcastTimer(
	NotificationId: string,
	Seconds: number,
	FormatFn: (number) -> string,
	Sound: string?,
	Position: string?,
	OnComplete: (() -> ())?
)
	NotificationService.BroadcastUpdatable(NotificationId, FormatFn(Seconds), Sound, Position)
	return runTimer(
		Seconds,
		FormatFn,
		function(text) NotificationService.UpdateBroadcast(NotificationId, text) end,
		function() NotificationService.CloseBroadcast(NotificationId, 0.5) end,
		OnComplete
	)
end

function NotificationService.TimerForPlayers(
	TargetPlayers: {Player},
	NotificationId: string,
	Seconds: number,
	FormatFn: (number) -> string,
	Sound: string?,
	Position: string?,
	OnComplete: (() -> ())?
)
	for _, plr in TargetPlayers do
		NotificationService.CreateUpdatableNotify(plr, NotificationId, FormatFn(Seconds), Sound, Position)
	end

	return runTimer(
		Seconds,
		FormatFn,
		function(text)
			for _, plr in TargetPlayers do
				NotificationService.UpdateNotify(plr, NotificationId, text)
			end
		end,
		function()
			for _, plr in TargetPlayers do
				NotificationService.CloseNotify(plr, NotificationId, 0.5)
			end
		end,
		OnComplete
	)
end

return NotificationService