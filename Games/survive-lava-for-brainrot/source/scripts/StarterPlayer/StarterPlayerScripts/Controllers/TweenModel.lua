-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("RunService")
if not (v2:IsServer() and v2.Heartbeat) then
	local _ = v2.RenderStepped
end
local v_u_3 = {}
return function(p_u_4, p5, p_u_6)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	local v7 = v_u_3[p_u_4]
	if v7 then
		v7:Cancel()
		v7:Destroy()
		task.cancel(v7.Thread)
		v_u_3[p_u_4] = nil
	end
	local v_u_8 = Instance.new("NumberValue")
	v_u_8.Value = p_u_4:GetScale()
	local v_u_9 = Instance.new("CFrameValue")
	v_u_9.Value = p_u_4:GetPivot()
	local v_u_10 = v_u_1:Create(v_u_8, p5, {
		["Value"] = p_u_6.Scale
	})
	local v_u_11 = v_u_1:Create(v_u_9, p5, {
		["Value"] = p_u_6.CFrame
	})
	local v_u_12 = nil
	v_u_12 = {
		["Instance"] = p_u_4,
		["Play"] = function()
			-- upvalues: (copy) v_u_10, (copy) v_u_11, (ref) v_u_12, (copy) p_u_6, (copy) p_u_4, (copy) v_u_8, (copy) v_u_9
			v_u_10:Play()
			v_u_11:Play()
			task.spawn(function()
				-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) p_u_6, (ref) p_u_4, (ref) v_u_8, (ref) v_u_9
				while true do
					task.wait(0.01)
					v_u_12.PlaybackState = v_u_10.PlaybackState
					if v_u_10.PlaybackState ~= Enum.PlaybackState.Playing then
						break
					end
					if p_u_6.Scale then
						local v13 = p_u_4
						local v14 = v_u_8.Value
						v13:ScaleTo((math.clamp(v14, 1e-9, (1 / 0))))
					end
					if p_u_6.CFrame then
						p_u_4:PivotTo(v_u_9.Value)
					end
				end
			end)
		end,
		["Pause"] = function()
			-- upvalues: (copy) v_u_10, (copy) v_u_11
			v_u_10:Pause()
			v_u_11:Pause()
		end,
		["Destroy"] = function()
			-- upvalues: (copy) v_u_10, (copy) v_u_11
			v_u_10:Destroy()
			v_u_11:Destroy()
		end,
		["Cancel"] = function()
			-- upvalues: (copy) v_u_10, (copy) v_u_11
			v_u_10:Cancel()
			v_u_11:Cancel()
		end,
		["PlaybackState"] = Enum.PlaybackState.Begin,
		["TweenInfo"] = p5,
		["Completed"] = v_u_10.Completed,
		["Thread"] = task.delay(50, function()
			-- upvalues: (ref) v_u_3, (copy) p_u_4
			v_u_3[p_u_4] = nil
		end)
	}
	v_u_3[p_u_4] = v_u_12
	return v_u_12
end
