local StockEvent = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TargetPosition = Vector3.new(-380.375, -5, 10.715)
local TargetOrientation = Vector3.new(0, -180, 0)

local TimerConnection = nil
local OriginalPivot = nil
local LastSecond = -1

--local function FormatTime(Seconds)
--	local Minutes = math.floor(Seconds / 60)
--	local RemainderSeconds = math.floor(Seconds % 60)
--
--	if RemainderSeconds == 0 then
--		return string.format("%dm", Minutes)
--	end
--
--	return string.format("%dm %ds", Minutes, RemainderSeconds)
--end

local function GetStockModel()
	return workspace
		:WaitForChild("Events")
		:WaitForChild("Stock")
		:WaitForChild("Model")
end

function StockEvent.OnStart(EventData)
	if not EventData or not EventData.endsAt then
		return
	end

	local StockModel = GetStockModel()

	ReplicatedStorage:SetAttribute("StockEvent", true)
	StockModel:SetAttribute("Hidden", false)

	OriginalPivot = StockModel:GetPivot()

	local RotationCFrame = CFrame.Angles(
		math.rad(TargetOrientation.X),
		math.rad(TargetOrientation.Y),
		math.rad(TargetOrientation.Z)
	)

	StockModel:PivotTo(
		CFrame.new(TargetPosition) * RotationCFrame
	)

	local Overhead = StockModel:WaitForChild("Overhead")
	local Billboard = Overhead:WaitForChild("BillboardGui")
--	local Countdown = Billboard:WaitForChild("Countdown")

	if TimerConnection then
		TimerConnection:Disconnect()
	end

	LastSecond = -1

--	TimerConnection = RunService.Heartbeat:Connect(function()
--		local TimeLeft = math.max(
--			0,
--			EventData.endsAt - workspace:GetServerTimeNow()
--		)
--
--		local Rounded = math.floor(TimeLeft)
--
--		if Rounded ~= LastSecond then
--			LastSecond = Rounded
--			Countdown.Text = FormatTime(Rounded)
--		end
--	end)
end

function StockEvent.OnStop()
	local StockModel = GetStockModel()

	ReplicatedStorage:SetAttribute("StockEvent", false)
	ReplicatedStorage:SetAttribute("StockEvent", nil)

	StockModel:SetAttribute("Hidden", true)

	if OriginalPivot then
		StockModel:PivotTo(OriginalPivot)
	end

	if TimerConnection then
		TimerConnection:Disconnect()
		TimerConnection = nil
	end
end

return StockEvent