local Admins = {}

if table.find(Admins, game.Players.LocalPlayer.UserId) then
	script.Parent.Enabled = true
else
	script.Parent.Enabled = false
end

local BaseINFO_Text = "FPS: 60\nPing: Unknown"
local IsStudio = game:GetService("RunService"):IsStudio()
local RunService = game:GetService("RunService")
local TimeFunction = RunService:IsRunning() and time or os.clock
local NewFPS = "60"
local LastIteration, Start
local FrameUpdateTable = {}

local function HeartbeatUpdate()
	LastIteration = TimeFunction()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
	end

	FrameUpdateTable[1] = LastIteration
	NewFPS = tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start)))
end

local function ShowStats(FPS : number, PING : number)
	BaseINFO_Text = `FPS: {tostring(FPS)}\n<font color="#AFE1AF">Ping: {tostring(PING)}</font>`
	script.Parent.Info.Text = BaseINFO_Text	
end

task.spawn(function()
	while task.wait() do
		local t = tick()
		game.ReplicatedStorage.Remote.FetchPlayerPing:InvokeServer()
		local ping = ((tick() - t) / 2) * 1000
		ShowStats(NewFPS, math.floor(ping))
	end
end)
Start = TimeFunction()
RunService.Heartbeat:Connect(HeartbeatUpdate)