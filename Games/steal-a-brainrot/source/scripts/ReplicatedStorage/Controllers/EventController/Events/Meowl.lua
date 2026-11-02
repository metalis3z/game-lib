local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EffectController)
local v_u_7 = require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.EventController)
local v_u_9 = require(v_u_1.Controllers.SoundController)
require(v_u_1.Packages.CreateTween)
local v_u_10 = require(v_u_1.Packages.Observers)
local v_u_11 = require(v_u_1.Packages.Trove)
local v12 = require(v_u_1.Packages.Net)
local v_u_13 = require(v_u_1.Shared.VFX)
local v_u_14 = script.Name
local v_u_15 = v12:RemoteEvent((("EventService/%*/Burst"):format(v_u_14)))
local v_u_16 = v_u_11.new()
function v5.OnStart(_)
	local v17 = v_u_8:GetActiveEventData(v_u_14)
	assert(v17)
	v_u_1:SetAttribute("MeowlEvent", true)
	v_u_16:Add(function()
		v_u_1:SetAttribute("MeowlEvent", nil)
	end)
	v_u_16:Clone(script.Map).Parent = workspace
	local v_u_18 = v_u_3:FindFirstChild("Atmosphere")
	if v_u_18 then
		v_u_18.Parent = script
		v_u_16:Add(function()
			v_u_18.Parent = v_u_3
		end)
	end
	v_u_16:Clone(script.AtmosphereMeowl).Parent = v_u_3
	v_u_16:Add(task.spawn(function()
	end))
	v_u_16:Add(v_u_10.observeTag("MeowlEventMeowl", function(p19)
		local v20 = v_u_11.new()
		local v21 = v20:Clone(script.Meowl)
		v21.Parent = workspace
		local v22 = Instance.new("Weld")
		v22.Part0 = v21.PrimaryPart
		v22.Part1 = p19
		v22.C0 = v21.PrimaryPart.PivotOffset
		v22.Parent = v21.PrimaryPart
		local v_u_23 = v21.AnimationController.Animator:LoadAnimation(script.Idle)
		v_u_16:Add(function()
			v_u_23:Stop(0)
			v_u_23:Destroy()
		end)
		v_u_23.Priority = Enum.AnimationPriority.Idle
		v_u_23.Looped = true
		v_u_23:Play()
		local v_u_24 = v21.AnimationController.Animator:LoadAnimation(script.Fly)
		v_u_16:Add(function()
			v_u_24:Stop(0)
			v_u_24:Destroy()
		end)
		v_u_24.Priority = Enum.AnimationPriority.Action
		v_u_24.Looped = true
		local v_u_25 = v21.AnimationController.Animator:LoadAnimation(script.Attack)
		v_u_16:Add(function()
			v_u_25:Stop(0)
			v_u_25:Destroy()
		end)
		v_u_25.Priority = Enum.AnimationPriority.Action2
		v_u_25.Looped = false
		v20:Add(v_u_10.observeAttribute(p19, "Flying", function(p26)
			if p26 then
				v_u_24:Play()
			else
				v_u_24:Stop()
			end
			return nil
		end))
		v20:Add(p19:GetAttributeChangedSignal("Attack"):Connect(function()
			v_u_25:Play()
		end))
		return v20:WrapClean()
	end, { workspace }))
	v_u_6:Activate("Blink")
	v_u_6:Run("MeowlEvent", "GrassRecolor")
	v_u_6:Run("MeowlEvent", "WallRecolor")
	v_u_6:Run("MeowlEvent", "WallBottomRecolor")
	v_u_16:Add(function()
		v_u_6:Stop("MeowlEvent", "GrassRecolor")
		v_u_6:Stop("MeowlEvent", "WallRecolor")
		v_u_6:Stop("MeowlEvent", "WallBottomRecolor")
		v_u_6:Activate("Blink")
	end)
end
function v5.OnStop(_)
	v_u_16:Destroy()
end
function v5.OnLoad(_)
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_15.OnClientEvent:Connect(function(p27)
		local v28 = v_u_7:GetAnimals()[p27]
		if v28 then
			local v29 = v28.AnimalModel
			local v30
			if v29 then
				v30 = v29.PrimaryPart
			else
				v30 = v29
			end
			local v31 = v28.Instance
			local v32
			if v31 then
				v32 = v31.PrimaryPart
			else
				v32 = v31
			end
			if v32 and v30 then
				local v33 = v_u_16:Clone(script.Burst)
				v33:PivotTo(v32.CFrame * CFrame.new(0, (v33.Size.Y + v29:GetExtentsSize().Y) / 2, 0))
				v33.Parent = v31
				local v34 = Instance.new("WeldConstraint")
				v34.Part0 = v33
				v34.Part1 = v28.AnimalModel.PrimaryPart
				v34.Parent = v33
				v_u_13.emit(v33)
				v_u_4:AddItem(v33, 5)
				v_u_9:PlaySound(v_u_1.Sounds.Events.Meowl.BrainrotHit, v32.CFrame.Position, false)
				v_u_9:PlaySound(v_u_1.Sounds.Events.Meowl.Flap, v32.CFrame.Position, false)
			end
		else
			return
		end
	end)
end
return v5