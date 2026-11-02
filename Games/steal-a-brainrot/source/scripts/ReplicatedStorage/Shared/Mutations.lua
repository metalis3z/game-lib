local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)

local Events = {
	{ "DivineEvent", "Divine" },
	{ "CursedEvent", "Cursed" },
	{ "RadioactiveEvent", "Radioactive" },
	{ "YinYangEvent", "YinYang" },
	{ "GalaxyEvent", "Galaxy" },
	{ "MoltenEvent", "Lava" },
	{ "CandyEvent", "Candy" },
	{ "BloodmoonEvent", "Bloodmoon" },
	{ "CyberEvent", "Cyber" },
}

local function getList()
	local Result = {}

	for Index, EventData in ipairs(Events) do
		if ReplicatedStorage:GetAttribute(EventData[1]) then
			table.insert(Result, EventData[2])
		end
	end

	return Result
end

local function listsEqual(A, B)
	if #A ~= #B then
		return false
	end

	for Index, Value in ipairs(A) do
		if B[Index] ~= Value then
			return false
		end
	end

	return true
end

return {
	getList = getList,

	get = function()
		return getList()[1]
	end,

	watch = function(OnChanged)
		local CurrentList = getList()
		local Cleanup = Trove.new()

		local function tryUpdate()
			local NewList = getList()

			if listsEqual(CurrentList, NewList) then
				return
			end

			CurrentList = NewList
			OnChanged()
		end

		for Index, EventData in ipairs(Events) do
			Cleanup:Add(
				ReplicatedStorage
					:GetAttributeChangedSignal(EventData[1])
					:Connect(tryUpdate)
			)
		end

		return Cleanup:WrapClean()
	end
}