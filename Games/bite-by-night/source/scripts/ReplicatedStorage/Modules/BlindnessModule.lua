-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v_u_2 = nil
function v_u_1.Activate(p3)
	-- upvalues: (ref) v_u_2, (copy) v_u_1
	if v_u_2 then
		v_u_1.Clear(true)
	end
	local v4 = 250 - 10 * p3
	v_u_2 = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
	v_u_2.Parent = script
	game:GetService("Lighting").FogStart = 0
	game:GetService("Lighting").FogEnd = 999
	game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		["FogEnd"] = v4
	}):Play()
	
	game:GetService("TweenService"):Create(workspace.BlindnessSFX, TweenInfo.new(0.5), {
		["Volume"] = 0.1
	}):Play()
end

function v_u_1.Clear(p5)
	-- upvalues: (ref) v_u_2
	if p5 then
		workspace.BlindnessSFX.Volume = 0
		game:GetService("Lighting").FogEnd = 999
		if v_u_2 and v_u_2.Parent ~= nil then
			v_u_2.Parent = game:GetService("Lighting")
			return
		end
	else
		game:GetService("TweenService"):Create(workspace.BlindnessSFX, TweenInfo.new(0.5), {
			["Volume"] = 0
		}):Play()
		game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			["FogEnd"] = 999
		}):Play()
		task.delay(0.5, function()
			-- upvalues: (ref) v_u_2
			if v_u_2 and v_u_2.Parent ~= nil then
				v_u_2.Parent = game:GetService("Lighting")
			end
		end)
	end
end
return v_u_1