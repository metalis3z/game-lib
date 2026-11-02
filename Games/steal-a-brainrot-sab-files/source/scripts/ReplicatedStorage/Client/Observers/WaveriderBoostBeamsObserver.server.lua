local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Spring = require(ReplicatedStorage.Packages.Spring)
local t = {}

local function collectBeams(rig)
	local beams = {}
	local Cube = rig:FindFirstChild("Cube")
	local Bone = if Cube then Cube:FindFirstChild("Bone") else nil
	local Boosting = if Bone then Bone:FindFirstChild("Boosting") else nil
	local RearAnchor = if Boosting then Boosting:FindFirstChild("RearAnchor") else nil

	if not RearAnchor then
		return beams
	end

	local WaterLoops = RearAnchor:FindFirstChild("WaterLoops")
	if WaterLoops and WaterLoops:IsA("Beam") then
		table.insert(beams, { Beam = WaterLoops, Width0 = WaterLoops.Width0, Width1 = WaterLoops.Width1 })
	end

	local Rotate = RearAnchor:FindFirstChild("Rotate")
	if Rotate then
		local ThurstMain = Rotate:FindFirstChild("ThurstMain")
		if ThurstMain and ThurstMain:IsA("Beam") then
			table.insert(beams, { Beam = ThurstMain, Width0 = ThurstMain.Width0, Width1 = ThurstMain.Width1 })
		end

		local Water = Rotate:FindFirstChild("Water")
		if Water and Water:IsA("Beam") then
			table.insert(beams, { Beam = Water, Width0 = Water.Width0, Width1 = Water.Width1 })
		end
	end

	return beams
end

Observers.observeTag("WaveriderRig", function(rig)
	local beams = collectBeams(rig)

	if #beams == 0 then
		return nil
	end

	local isBoostBeams = rig:GetAttribute("BoostBeams") == true
	local spring = Spring.new(if isBoostBeams then 1 else 0)
	spring.Speed = 16
	spring.Damper = 0.7
	spring.Target = if isBoostBeams then 1 else 0

	t[rig] = {
		Spring = spring,
		Beams = beams,
	}

	local boostBeamsConn = rig:GetAttributeChangedSignal("BoostBeams"):Connect(function()
		spring.Target = if rig:GetAttribute("BoostBeams") == true then 1 else 0
	end)

	return function()
		boostBeamsConn:Disconnect()
		t[rig] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	for rig, data in t do
		local val = math.max(data.Spring.Position, 0)

		for _, beamData in data.Beams do
			beamData.Beam.Width0 = beamData.Width0 * val
			beamData.Beam.Width1 = beamData.Width1 * val
		end
	end
end)