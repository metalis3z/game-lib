local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Shared.StockMachineTypes)

local Net = require(ReplicatedStorage.Packages.Net)

local SetFocusedEvent = Net:RemoteEvent("StockEventService/SetFocused")
local ReturnEvent = Net:RemoteEvent("StockEventService/Return")
local RedeemEvent = Net:RemoteEvent("StockEventService/Redeem")

local ListItemsFunction = Net:RemoteFunction("StockEventService/ListItems")
Net:RemoteFunction("StockEventService/Delivery")

local CachedItemsByMachine = {}

local StockMachineMethods = {}

function StockMachineMethods:GetStock(StockKey)
	return ReplicatedStorage:GetAttribute(
		("StockEvent_%s"):format(string.gsub(StockKey, "%s", "_"))
	)
end

function StockMachineMethods:OnStockChange(StockKey, Callback)
	return ReplicatedStorage:GetAttributeChangedSignal(
		("StockEvent_%s"):format(string.gsub(StockKey, "%s", "_"))
	):Connect(Callback)
end

function StockMachineMethods:Redeem(StockKey)
	RedeemEvent:FireServer(self.MachineName, StockKey)
end

function StockMachineMethods:Return(PodiumId)
	ReturnEvent:FireServer(self.MachineName, PodiumId)
end

function StockMachineMethods:SetOpen(IsOpen)
	SetFocusedEvent:FireServer(
		"2298b248-44dd-4a34-bbfe-e1174e8ae1b4",
		self.MachineName,
		IsOpen
	)
end

function StockMachineMethods:ListItems()
	if CachedItemsByMachine[self.MachineName] then
		return true, CachedItemsByMachine[self.MachineName]
	end

	local Retries = 3
	local Success, Result

	while true do
		Success, Result = ListItemsFunction:InvokeServer(
			"2298b248-44dd-4a34-bbfe-e1174e8ae1b4",
			self.MachineName
		)

		if Success then
			break
		end

		task.wait(3)

		if Result ~= "Retry" then
			Retries -= 1
			if Retries <= 0 then
				break
			end
		end
	end

	if Success and typeof(Result) == "table" then
		CachedItemsByMachine[self.MachineName] = Result
	end

	return Success, Result
end

return {
	Create = function(MachineName)
		return setmetatable(
			{
				MachineName = MachineName
			},
			{
				__index = StockMachineMethods
			}
		)
	end
}