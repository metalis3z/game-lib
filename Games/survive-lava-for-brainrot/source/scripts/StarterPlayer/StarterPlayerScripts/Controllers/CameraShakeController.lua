-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local _ = game:GetService("Players").LocalPlayer
local v_u_2 = v1:WaitForChild("Remotes"):WaitForChild("ShakeCamera")
local v_u_3 = require(v1.Modules.CameraShaker)
local v_u_11 = {
	["Start"] = function(_)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		local v_u_4 = workspace.CurrentCamera
		local v_u_6 = v_u_3.new(Enum.RenderPriority.Camera.Value, function(p5)
			-- upvalues: (copy) v_u_4
			v_u_4.CFrame = v_u_4.CFrame * p5
		end)
		v_u_2.OnClientEvent:Connect(function(p7, p8)
			-- upvalues: (copy) v_u_6, (ref) v_u_3
			local v9 = v_u_6[p7]
			if v9 then
				local v10 = v_u_3.Presets[p8]
				if v10 then
					v_u_6:Start()
					v9(v_u_6, v10.Magnitude, v10.Roughness, v10.fadeInDuration, v10.fadeOutDuration)
				end
			else
				return
			end
		end)
	end
}
task.spawn(function()
	-- upvalues: (copy) v_u_11
	v_u_11:Start()
end)
return v_u_11
