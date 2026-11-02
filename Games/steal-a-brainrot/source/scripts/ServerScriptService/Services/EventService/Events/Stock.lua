local Stock = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Countdown = workspace.Events.Stock.Model.Overhead.BillboardGui:WaitForChild("Countdown")

local TargetPosition = Vector3.new(-380.375, -5, 16.715)
local TargetOrientation = Vector3.new(0, -180, 0)

local TimerConnection = nil
local OriginalPivot = nil
local LastSecond = -1

local function FormatTime(Seconds)
	Seconds = math.max(0, math.floor(Seconds))

	if Seconds < 60 then
		return string.format("%ds", Seconds)
	end

	local Minutes = math.floor(Seconds / 60)
	local Remainder = Seconds % 60

	if Remainder == 0 then
		return string.format("%dm", Minutes)
	end

	return string.format("%dm %ds", Minutes, Remainder)
end

local function GetStockModel()
	return workspace.Events.Stock:WaitForChild("Model")
end

function Stock.OnStart(EventData)
	if not EventData or not EventData.endsAt then
		return
	end

	local StockModel = GetStockModel()

	ReplicatedStorage:SetAttribute("StockEvent", true)
	StockModel:SetAttribute("Hidden", false)

	OriginalPivot = StockModel:GetPivot()

	local RotationCFrame = CFrame.Angles(math.rad(TargetOrientation.X), math.rad(TargetOrientation.Y), math.rad(TargetOrientation.Z))

	StockModel:PivotTo(CFrame.new(TargetPosition) * RotationCFrame)

	if TimerConnection then
		TimerConnection:Disconnect()
	end

	LastSecond = -1

	TimerConnection = RunService.Heartbeat:Connect(function()
		local TimeLeft = math.max(0, EventData.endsAt - workspace:GetServerTimeNow())

		local Rounded = math.floor(TimeLeft)

		if Rounded ~= LastSecond then
			LastSecond = Rounded
			Countdown.Text = FormatTime(Rounded)
		end
	end)
end

function Stock.OnStop()
	local StockModel = GetStockModel()

	ReplicatedStorage:SetAttribute("StockEvent", false)
	ReplicatedStorage:SetAttribute("StockEvent", nil)

	StockModel:SetAttribute("Hidden", true)
	
	Countdown.Text = "10:00"

	if OriginalPivot then
		StockModel:PivotTo(OriginalPivot)
	end

	if TimerConnection then
		TimerConnection:Disconnect()
		TimerConnection = nil
	end
end

return Stock