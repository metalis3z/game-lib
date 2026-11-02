local v8 = {}
local v_u_9 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
local v_u_14 = require(game.ReplicatedStorage.Modules.Util)
local v_u_5 = game:GetService("Players")

function v8.OnIntroduction(_, p68, p_u_69, p70)
	-- upvalues: (copy) v_u_9, (copy) v_u_14, (copy) v_u_5
	v_u_9:SetCustomLighting(p68.Config.IntroLighting)
	if p_u_69:FindFirstChild("FakeCrown") then
		p_u_69.FakeCrown.Face.ParticleEmitter.Enabled = true
		p_u_69.Voidstar:Destroy()
		p_u_69.VoidstarCrown:Destroy()
	else
		warn("THIS LOSER HAS NO FAKE CROWN!!!!")
	end
	local v_u_71 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v_u_72 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_72, (copy) v_u_71
		while v_u_72 do
			for v73, v74 in pairs(v_u_71.Voidstars:GetChildren()) do
				v74.CFrame = v74.CFrame * CFrame.Angles(0, v73 % 2 == 0 and 0.0225 or -0.0225, 0)
			end
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_72, (copy) v_u_71
		while v_u_72 do
			local v75 = v_u_71.Skybox
			v75.CFrame = v75.CFrame * CFrame.Angles(0, 0.004363323129985824, 0)
			task.wait()
		end
	end)
	local v_u_76 = v_u_14:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p70)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_76
		v_u_76.Value = 0.275
	end)
	task.delay(p70, function()
		-- upvalues: (ref) v_u_72, (copy) p_u_69, (ref) v_u_9
		v_u_72 = false
		if p_u_69:FindFirstChild("FakeCrown") then
			p_u_69.FakeCrown.Transparency = 1
		end
		p_u_69.VoidstarCrown.Transparency = 0
		p_u_69.Voidstar.Transparency = 0
		v_u_9:SetAsCurrentLighting()
	end)
end

return v8