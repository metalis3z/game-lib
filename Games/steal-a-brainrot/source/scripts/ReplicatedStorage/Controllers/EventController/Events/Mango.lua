
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local any_new_result1_upvr = require(ReplicatedStorage.Packages.Trove).new()
local Lighting_upvr = game:GetService("Lighting")
local CycleController_upvr = require(ReplicatedStorage.Controllers.CycleController)
local SoundController_upvr = require(ReplicatedStorage.Controllers.SoundController)
function module.OnStart(arg1) -- Line 17
	--[[ Upvalues[4]:
		[1]: Lighting_upvr (readonly)
		[2]: any_new_result1_upvr (readonly)
		[3]: CycleController_upvr (readonly)
		[4]: SoundController_upvr (readonly)
	]]
	local Atmosphere_upvr = Lighting_upvr:FindFirstChild("Atmosphere")
	if Atmosphere_upvr then
		Atmosphere_upvr.Parent = script
		any_new_result1_upvr:Add(function() -- Line 22
			--[[ Upvalues[2]:
				[1]: Atmosphere_upvr (readonly)
				[2]: Lighting_upvr (copied, readonly)
			]]
			Atmosphere_upvr.Parent = Lighting_upvr
		end)
	end
	any_new_result1_upvr:Clone(script.AtmosphereMango).Parent = Lighting_upvr
	local Cartoon_upvr = Lighting_upvr:FindFirstChild("Cartoon")
	if Cartoon_upvr then
		Cartoon_upvr.Parent = script
		any_new_result1_upvr:Add(function() -- Line 31
			--[[ Upvalues[2]:
				[1]: Cartoon_upvr (readonly)
				[2]: Lighting_upvr (copied, readonly)
			]]
			Cartoon_upvr.Parent = Lighting_upvr
		end)
	end
	any_new_result1_upvr:Clone(script.SkyMango).Parent = Lighting_upvr
	local clone_upvr = script.MangoWeather:Clone()
	clone_upvr.Parent = workspace
	any_new_result1_upvr:Add(function() -- Line 39
		--[[ Upvalues[1]:
			[1]: clone_upvr (readonly)
		]]
		for _, v in clone_upvr:GetDescendants() do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		task.wait(4)
		clone_upvr:Destroy()
	end)
	CycleController_upvr:Update()
	SoundController_upvr:UpdateOST()
end
function module.OnStop(arg1) -- Line 52
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	any_new_result1_upvr:Destroy()
end
function module.OnLoad(arg1) -- Line 56
end
return module