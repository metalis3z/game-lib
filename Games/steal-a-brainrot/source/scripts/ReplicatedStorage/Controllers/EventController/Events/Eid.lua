local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Lighting")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_7 = require(v_u_1.Controllers.EffectController)
local v_u_8 = require(v_u_1.Controllers.SoundController)
local v_u_9 = require(v_u_1.Controllers.CycleController)
local v_u_10 = require(v_u_1.Controllers.EventController)
local v_u_11 = require(v_u_1.Shared.SharedEventUtils)
local v_u_12 = require(v_u_1.Packages.Observers)
local v_u_13 = require(v_u_1.Datas.ServerData)
local v_u_14 = require(v_u_1.Packages.Trove)
local v15 = require(v_u_1.Packages.Net)
require(v_u_1.Shared.VFX)
local v_u_16 = script.Name
local v_u_17 = {
	["Red"] = Color3.fromRGB(255, 50, 50),
	["Green"] = Color3.fromRGB(50, 200, 50),
	["Blue"] = Color3.fromRGB(50, 100, 255),
	["Orange"] = Color3.fromRGB(255, 150, 30),
	["Purple"] = Color3.fromRGB(160, 50, 220),
	["Yellow"] = Color3.fromRGB(255, 230, 50),
	["Rainbow"] = Color3.fromRGB(255, 255, 255)
}
local v_u_18 = v15:RemoteEvent((("EventService/%*/Burst"):format(v_u_16)))
local v_u_19 = v_u_14.new()

function v5.OnStart(_)
	local v20 = v_u_10:GetActiveEventData(v_u_16)
	assert(v20)
	v_u_9:Update()
	v_u_8:UpdateOST()
	v_u_7:Activate("Blink")
	local v21
	if v_u_13.IsBiggerServer() then
		v21 = v_u_19:Clone(script.BiggerEidMap)
	else
		v21 = v_u_19:Clone(script.EidMap)
	end
	v21.Parent = workspace
	v_u_7:Run("EidEvent", "GrassRecolor")
	v_u_19:Add(function()
		v_u_7:Stop("EidEvent", "GrassRecolor")
	end)
	local v_u_22 = v_u_4:FindFirstChild("Cartoon")
	if v_u_22 then
		v_u_22.Parent = script
		v_u_19:Add(function()
			v_u_22.Parent = v_u_4
		end)
	end
	v_u_19:Clone(script.SkyEid).Parent = v_u_4
	local v23 = Random.new()
	for _, v24 in v21.Lanterns:GetChildren() do
		local v25 = v24:FindFirstChildWhichIsA("BasePart")
		if v25 then
			v25.Anchored = false
			for _, v26 in v24:QueryDescendants("BasePart") do
				if v26 ~= v25 then
					v26.Anchored = false
					local v27 = v_u_19:Add(Instance.new("WeldConstraint"))
					v27.Part0 = v26
					v27.Part1 = v25
					v27.Parent = v26
				end
			end
			local v_u_28 = v_u_19:Add(Instance.new("Motor6D"))
			v_u_28.Part0 = workspace.Terrain
			v_u_28.Part1 = v25
			v_u_28.C0 = v25.CFrame
			v_u_28.Parent = v25
			local v_u_29 = v23:NextInteger(0, 1000000)
			local v_u_30 = v23:NextNumber(4, 7)
			local v_u_31 = v23:NextNumber(0.5, 0.65)
			local v_u_32 = v23:NextNumber(0.25, 0.4)
			v_u_19:Add(v_u_3.PostSimulation:Connect(function()
				local v33 = v_u_29 + os.clock()
				debug.profilebegin("Eid Lantern Update")
				local v34 = v_u_28
				local v35 = CFrame.new
				local v36 = v33 * v_u_31
				v34.Transform = v35(0, math.sin(v36) * v_u_30, 0) * CFrame.Angles(0, v33 * v_u_32 % 6.283185307179586, 0)
				debug.profileend()
			end))
		end
	end
	local v_u_37 = {}
	v_u_19:Add(v_u_12.observeTag("EidBalloon", function(p_u_38)
		local v_u_39 = v_u_14.new()
		local v40 = p_u_38:GetAttribute("BalloonColor") or "Red"
		if not v_u_17[v40] then
			local _ = v_u_17.Red
		end
		local v41 = v_u_39:Clone(script.Balloons[v40])
		v41.Parent = p_u_38
		local v42 = v_u_11.loadAnimation(v_u_39, v41.AnimationController.Animator, script.Idle)
		v42.Looped = true
		v42:Play(0, 1, (Random.new():NextNumber(0.3, 0.75)))
		local v_u_43 = v41.RootPart
		v_u_37[p_u_38.Name] = v41
		local v_u_44 = os.clock()
		local v_u_45 = Random.new():NextNumber(0, 1) * 3.141592653589793 * 2
		v_u_39:Add(v_u_3.PreRender:Connect(function()
			debug.profilebegin("EidBalloon:visual")
			local v46 = os.clock() - v_u_44 + v_u_45
			local v47 = math.sin(v46) * 0.6
			local v48 = p_u_38.CFrame * CFrame.new(0, v47, 0)
			v_u_11.pushPartCFrame(v_u_43, v48)
			debug.profileend()
		end))
		return function()
			v_u_37[p_u_38.Name] = nil
			v_u_39:Destroy()
		end
	end, { workspace }))
	v_u_19:Add(function()
		v_u_7:Activate("Blink")
		v_u_9:Update()
		v_u_8:UpdateOST()
	end)
end

function v5.OnStop(_)
	v_u_19:Destroy()
end

function v5.OnLoad(_)
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_18.OnClientEvent:Connect(function(p49, _)
		v_u_19:Add(v_u_6.playBurst(script.Burst, p49, { v_u_1.Sounds.Events.Eid.Hit }))
	end)
end

return v5