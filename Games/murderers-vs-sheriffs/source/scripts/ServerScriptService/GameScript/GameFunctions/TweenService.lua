local TweenService = {}
local RunningTweens = {}
local ServerTweens = {}

TweenService.PlayTween = function(Part,State,TweenInfos)
	RunningTweens[Part] = RunningTweens[Part] or {}
	RunningTweens[Part][State] = TweenInfos
	if ServerTweens[Part] and ServerTweens[Part][State] then
		ServerTweens[Part][State]:Cancel()
	end
	ServerTweens[Part] = ServerTweens[Part] or {}
	ServerTweens[Part][State] = game.TweenService:Create(Part,TweenInfo.new(TweenInfos.Time,Enum.EasingStyle[TweenInfos.EasingStyle],Enum.EasingDirection[TweenInfos.EasingDirection],0,false,TweenInfos.DelayTime),TweenInfos.Properties)
	game.ReplicatedStorage.ClientTweenEvents.CreateClientTween:FireAllClients(Part,State,TweenInfos)
	game.ReplicatedStorage.ClientTweenEvents.PlayClientTween:FireAllClients(Part,State)
	ServerTweens[Part][State]:Play()
end

TweenService.CancelTween = function(Part,State)
	RunningTweens[Part][State] = nil
	ServerTweens[Part][State]:Cancel()
	ServerTweens[Part][State] = nil
	game.ReplicatedStorage.ClientTweenEvents.StopClientTween:FireAllClients(Part,State)
end

TweenService.ClearTweens = function()
	game.ReplicatedStorage.ClientTweenEvents.ClearTweens:FireAllClients()
	RunningTweens = {}
end

game.ReplicatedStorage.ClientTweenEvents.GetClientTween.OnServerInvoke = function(Part,State)
	return RunningTweens[Part][State]
end

_G.PlayTween = TweenService.PlayTween
_G.CancelTween = TweenService.CancelTween
_G.ClearTweens = TweenService.ClearTweens
return TweenService
