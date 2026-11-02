
local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = v1:WaitForChild("Packages")
local u3 = require(v2.Trove)
local v4 = require(v2.Net)
local v5 = v1:WaitForChild("Utils")
local u6 = require(v5.NumberUtils)
local u7 = require(v1.Datas.Animals)
local v8 = v1:WaitForChild("Shared")
local u9 = require(v8.Animals)
local u10 = Instance.new("RemoteEvent").FireServer
local u11 = v4:RemoteEvent("f40f7d9e-2f0d-4167-b250-899273f46874")
local u12 = {}
u12.__index = u12
function u12.GetState(p13)
	return p13.State
end
function u12.SetState(p14, p15, p16)
	p14.State = p15
	local v17 = p14.ProximityPrompt
	local v18 = p14.AnimalIndex
	local v19
	if v18 then
		v19 = u7[v18]
	else
		v19 = v18
	end
	local v20
	if v19 then
		v20 = v19.DisplayName or v18
	else
		v20 = v18
	end
	v17.ObjectText = (not v18 or (string.find(v18, "None") or p15 == "Sell")) and "" or (v20 or v18)
	v17.Enabled = p15 ~= "None"
	v17:SetAttribute("State", p15)
	if p15 == "Sell" then
		v17.ActionText = not v18 and "" or ("Sell: $%*"):format((u6:ToString(u9:GetSellValue(v18), 2)))
	elseif p15 == "Open" then
		v17.ActionText = "Open"
	elseif p15 == "Steal" then
		v17.ActionText = "Steal"
	elseif p15 == "Grab" then
		v17.ActionText = "Grab"
	elseif p15 == "Place" then
		v17.ActionText = "Place"
	elseif p15 == "Return" then
		v17.ActionText = "Return"
	end
	if p16 then
		p14.TargetCallback = p16
	end
end
function u12.SetCallback(p21, p22)
	p21.TargetCallback = p22
end
function u12.new(p23, p24, p25, p26)
	local v27 = u12
	local u28 = setmetatable({}, v27)
	u28.Index = p23
	u28.AnimalIndex = p24
	u28.Collector = u3.new()
	local u29 = Instance.new("ProximityPrompt")
	u29.HoldDuration = 1.5
	u29.RequiresLineOfSight = true
	u29.Style = Enum.ProximityPromptStyle.Custom
	if p26 then
		for v30, v31 in p26 do
			u29[v30] = v31
		end
	end
	u28.ProximityPrompt = u29
	u29.Parent = p25
	u28.Collector:Add(u29)
	u28.Collector:Add(u29.Changed:Connect(function()
		u29.HoldDuration = 1.5
		u29.RequiresLineOfSight = true
		u29.MaxActivationDistance = 10
	end))
	u28.Collector:Add(u29.PromptButtonHoldBegan:Connect(function()
		u29.HoldDuration = 1.5
		u29.RequiresLineOfSight = true
		u29.MaxActivationDistance = 10
	end))
	u28.Collector:Add(u29.Triggered:Connect(function()
		if u28.TargetCallback then
			u28.TargetCallback()
		end
	end))
	u28.Collector:Add(u29.PromptButtonHoldBegan:Connect(function()
		if u28.State == "Steal" then
			u10(u11, workspace:GetServerTimeNow() + 124, "68c86eb7-eb7e-4b4d-96ae-cf7cd847c5b0")
			u11:FireServer(workspace:GetServerTimeNow() + 124, "07b9cc25-2a1f-4a26-a0ec-f2fab578d8bd")
		end
	end))
	return u28
end
function u12.Destroy(p32)
	p32.Collector:Destroy()
end
return u12