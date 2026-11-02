local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_2 = game:GetService("Lighting")
game:GetService("Players")

require(v_u_1.Shared.EventTypes)

local v3 = {}
local v_u_4 = require(v_u_1.Controllers.AnimalController)
require(v_u_1.Controllers.EffectController)
local v_u_5 = require(v_u_1.Controllers.SoundController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.CycleController)

require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)

local v8 = require(v_u_1.Packages.Trove)
local v9 = require(v_u_1.Packages.Net)
local v_u_10 = require(v_u_1.Shared.VFX)

local v_u_11 = "Elexir" -- CHANGÉ
local v_u_12 = v9:RemoteEvent("EventService/Rain/Hit") -- CHANGÉ
local v_u_13 = v8.new()

function v3.OnStart(_)
	local v14 = v_u_6:GetActiveEventData(v_u_11)
	assert(v14)

	v_u_1:SetAttribute("Elexir", true) -- CHANGÉ
	v_u_13:Add(function()
		v_u_1:SetAttribute("Elexir", nil)
	end)

	local v15 = v14.startedAt + 4 - workspace:GetServerTimeNow()

	local v_u_16 = v_u_13:Clone(script.ElexirWeather) -- rename ton objet aussi
	v_u_10.disable(v_u_16)
	v_u_16.Parent = workspace

	v_u_13:Add(task.delay(v15, function()
		local v_u_17 = v_u_2:FindFirstChild("Atmosphere")
		if v_u_17 then
			v_u_17.Parent = script
			v_u_13:Add(function()
				v_u_17.Parent = v_u_2
			end)
		end

		v_u_13:Clone(script.AtmosphereElexir).Parent = v_u_2 -- rename assets

		local v_u_18 = v_u_2:FindFirstChild("Cartoon")
		if v_u_18 then
			v_u_18.Parent = script
			v_u_13:Add(function()
				v_u_18.Parent = v_u_2
			end)
		end

		v_u_13:Clone(script.SkyElexir).Parent = v_u_2
		v_u_10.enable(v_u_16)
	end))

	v_u_7:Update()
	v_u_5:UpdateOST()
	v_u_5:UpdateAmbience()
end

function v3.OnStop(_)
	v_u_13:Destroy()
end

function v3.OnLoad(_)
	v_u_12.OnClientEvent:Connect(function(p19)
		local v20

		if type(p19) == "string" then
			local v21 = v_u_4:GetAnimals()[p19]
			if not v21 then return end

			local v22 = v21.AnimalModel
			local v23 = v22.PrimaryPart and v22.PrimaryPart.CFrame or v22:GetPivot()

			local v24 = v23.Position
			local v25 = v21.AnimalModel:GetExtentsSize().Y * 0.5

			v20 = v24 + Vector3.new(0, v25, 0)
			p19 = v21.AnimalModel.PrimaryPart
		else
			v20 = p19:GetPivot().Position
		end

		v_u_5:PlaySound(v_u_1.Sounds.Events.Rain.Burst, v20) -- CHANGÉ

		local v_u_26 = script.StruckVFX:Clone()
		v_u_26:PivotTo(CFrame.new(v20))
		v_u_26.Anchored = false

		local v27 = Instance.new("WeldConstraint")
		v27.Part0 = v_u_26
		v27.Part1 = p19
		v27.Parent = v_u_26

		v_u_26.Parent = workspace
		v_u_10.emit(v_u_26)

		task.delay(3, function()
			v_u_26:Destroy()
		end)
	end)
end

return v3