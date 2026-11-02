local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")

require(ReplicatedStorage.Datas.ServerData)

local Signal = require(Packages.Signal)
local Timer = require(Packages.Timer)

local t1 = {
	List = {},
	Methods = {},
	OnUpdateEnabled = Signal.new(),
	OnUpdateDisabled = Signal.new()
}

function t1.Methods.IsEnabled(s1: string)
	local v9 = t1.List[s1]

	if not v9 then
		return false
	end

	return workspace:GetServerTimeNow() >= v9.UnixTimeStamp
end

function t1.Methods.GetUpdateTime(s2: string)
	local v11 = t1.List[s2]

	if not v11 then
		return
	end

	return v11.UnixTimeStamp
end

function t1.Methods.GetTimeLeft(s3: string)
	local v13 = t1.List[s3]

	if not v13 then
		return
	end

	return v13.UnixTimeStamp - workspace:GetServerTimeNow()
end

t1.List["Update-06/13/2026"] = {
	UnixTimeStamp = 1781377200,
}
t1.List["Update-07/04/2026"] = {
	UnixTimeStamp = 1783191600,
}

local function Setup()
	local t2 = {}

	local function checkUpdate(s4: string, t3: {[any]: any})
		if t2[s4] then
			if not t1.Methods.IsEnabled(s4) then
				t2[s4] = nil
				t1.OnUpdateDisabled:Fire(s4)
				return
			end
		elseif t1.Methods.IsEnabled(s4) then
			t2[s4] = t3.UnixTimeStamp
			t1.OnUpdateEnabled:Fire(s4)
		end
	end

	local v16 = Timer.new(1)
	v16.Tick:Connect(function()
		for v23, v24 in t1.List do
			checkUpdate(v23, v24)
		end
	end)
	v16:Start()

	for v19, v20 in t1.List do
		if t1.Methods.IsEnabled(v19) then
			t1.OnUpdateEnabled:Fire(v19)
		else
			task.spawn(function()
				while not t1.Methods.IsEnabled(v19) do
					local v25 = v20.UnixTimeStamp - workspace:GetServerTimeNow()

					task.wait((math.clamp(v25, 0.01, 1e999)))
				end

				t1.OnUpdateEnabled:Fire(v19)
			end)
		end
	end
end

Setup()

return t1