-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local function u9(u2) -- name: setupCharacterVisuals
	local u3 = u2:WaitForChild("Humanoid", 10)
	local u4
	if u3 then
		u4 = u3:WaitForChild("Animator", 10)
	else
		u4 = u3
	end
	if u4 then
		local u5 = nil
		local function v8() -- name: updateAnimation
			-- upvalues: (copy) u2, (ref) u5, (copy) u4, (copy) u3
			if u2:GetAttribute("IsOnTreadmill") then
				if not u5 then
					local v6 = u2:FindFirstChild("Animate")
					local v7 = v6 and v6:FindFirstChild("run")
					if v7 then
						v7 = v7:FindFirstChildOfClass("Animation")
					end
					if v7 then
						u5 = u4:LoadAnimation(v7)
						u5.Priority = Enum.AnimationPriority.Movement
						u5.Looped = true
					end
				end
				if u5 and not u5.IsPlaying then
					u5:Play(0.3)
					return
				end
			elseif u5 then
				u5:Stop(0.3)
				u5 = nil
				task.defer(function()
					-- upvalues: (ref) u3
					if u3 and u3.Parent then
						u3:ChangeState(Enum.HumanoidStateType.Landed)
					end
				end)
			end
		end
		u2:GetAttributeChangedSignal("IsOnTreadmill"):Connect(v8)
		v8()
	end
end
v1.PlayerAdded:Connect(function(p10) -- name: onPlayerAdded
	-- upvalues: (copy) u9
	if p10.Character then
		task.spawn(u9, p10.Character)
	end
	p10.CharacterAdded:Connect(u9)
end)
for _, v11 in ipairs(v1:GetPlayers()) do
	if v11.Character then
		task.spawn(u9, v11.Character)
	end
	v11.CharacterAdded:Connect(u9)
end