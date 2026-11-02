

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local MapInformation = require(ReplicatedStorage.Shared.MapInformation)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net):RemoteEvent("EventService/RainingTacos/Shoot")

local Name = script.Name

local managedObj = Trove.new()

local _unused = workspace.CurrentCamera

data.OnStart = function(_)

	local flag = ServerData.IsTsunamiServer()
	assert((EventController:GetActiveEventData(Name)))
	ReplicatedStorage:SetAttribute("RainingTacosEvent", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("RainingTacosEvent", nil)
		SoundController:UpdateOST()
		CycleController:Update()
	end)
	SoundController:UpdateOST()
	CycleController:Update()
	local getPivotObj = managedObj:Clone(script.Cannon)
	local l_v21_Pivot_0 = getPivotObj:GetPivot()

	local function updateCannonPosition()

		local l_v21_Pivot_0 = l_v21_Pivot_0
		if flag then
			l_v21_Pivot_0 = CFrame.new(-411.413, 55.718, 262.401) * CFrame.fromOrientation(0, 1.5707963267948966, 0)
		elseif ServerData.IsBiggerServer() then
			l_v21_Pivot_0 = CFrame.new(-410.091, 24.718, -393.962) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
		end

		if not flag and ReplicatedStorage:GetAttribute("DivineStairsEnabled") == true then
			l_v21_Pivot_0 = l_v21_Pivot_0 - Vector3.new(0, 11, 0, 0)
		end
		getPivotObj:PivotTo(l_v21_Pivot_0)
	end

	if not flag then
		managedObj:Add(ReplicatedStorage:GetAttributeChangedSignal("DivineStairsEnabled"):Connect(updateCannonPosition))
	end
	updateCannonPosition()
	getPivotObj.Parent = workspace
	local managedObj_2 = if ServerData.IsBiggerServer() then script.TacoAmbientBigger:Clone() else script.TacoAmbient:Clone()
	managedObj:Add(function()

		for _, descendant in managedObj_2:GetDescendants() do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = false
			end
		end
		task.wait(5)
		managedObj_2:Destroy()
	end)
	managedObj_2:PivotTo(MapInformation.MapCenter.CFrame + Vector3.new(0, 40, 0, 0))
	managedObj_2.Parent = workspace
	local ref1 = getPivotObj.Top["Meshes/tacolauncher_Cube.004"]["Meshes/tacolauncher_Cube.003"]
	local ref2 = getPivotObj.Bottom.RootPart["Meshes/tacolauncher_Cube.004"]
	local impulseObj = Spring.new(0)
	impulseObj.Speed = 6.5
	impulseObj.Damper = 0.85
	local impulseObj_2 = Spring.new(0)
	impulseObj_2.Speed = 9
	impulseObj_2.Damper = 0.6
	managedObj:Add(RunService.PostSimulation:Connect(function(_)

		debug.profilebegin("Raining Tacos Cannon Spring")
		ref1.C1 = CFrame.new(impulseObj.Position, 0, 0)
		ref2.C1 = CFrame.Angles(0, 0, -math.rad(impulseObj_2.Position))
		debug.profileend()
	end))
	managedObj:Add(Net.OnClientEvent:Connect(function(val1, val2, val3)

		local managedObj_3 = script.Taco:Clone()
		managedObj_3.Parent = workspace
		task.spawn(function()

			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Raining Tacos"].Shoot, getPivotObj:GetPivot().Position)
		end)
		task.spawn(function()

			impulseObj_2:Impulse(650)
			task.wait(0.05)
			impulseObj:Impulse(35)
		end)
		local Position = getPivotObj.ShootPart.CFrame.Position
		local val4 = val3 or 2.5
		local connectResult = nil
		connectResult = RunService.PreRender:Connect(function()

			debug.profilebegin("Raining Tacos")
			local flag_2 = ClientEventUtils.getAnimalPosition(val1)
			if not flag_2 then
				return
			else
				local val5 = flag and 120 or 60
				local val6 = Position + (flag_2 - Position) * 0.5 + Vector3.new(0, val5, 0)
				local serverTimeNow = math.clamp(1 - (val2 + val4 - workspace:GetServerTimeNow()) / val4, 0, 1)
				local val7 = MathUtils.quadBezier(serverTimeNow, Position, val6, flag_2)
				local val8 = MathUtils.quadBezier(serverTimeNow + 0.1, Position, val6, flag_2)
				managedObj_3.CFrame = CFrame.lookAt(val7, val8)
				if serverTimeNow >= 1 then
					connectResult:Disconnect()
					managedObj_3:Destroy()
					ClientEventUtils.playBurst(script.StruckVFX, val1, {
						ReplicatedStorage.Sounds.Events["Raining Tacos"].Hit
					})
				end
				debug.profileend()
				return
			end
		end)
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

end

return data
