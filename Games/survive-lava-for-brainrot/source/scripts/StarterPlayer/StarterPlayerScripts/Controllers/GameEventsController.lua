-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ReplicatedStorage")
local v1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("SocialService")
game:GetService("Players")
task.delay(30, function()
	-- upvalues: (copy) v_u_2
	local v3, v4 = pcall(function()
		-- upvalues: (ref) v_u_2
		return v_u_2:GetEventRsvpStatusAsync("4358705658912834110")
	end)
	if not v3 or v4 ~= Enum.RsvpStatus.Going then
		pcall(function()
			-- upvalues: (ref) v_u_2
			v_u_2:PromptRsvpToEventAsync("4358705658912834110")
		end)
	end
end)
local v5 = {}
for _, v6 in v1:GetTagged("FollowEvent") do
	local v_u_7 = v6:GetAttribute("Event")
	if v_u_7 then
		local v8 = v6:FindFirstChild("ProximityPrompt")
		if v8 then
			v8.Triggered:Connect(function(_)
				-- upvalues: (copy) v_u_2, (copy) v_u_7
				local v9, v10 = pcall(function()
					-- upvalues: (ref) v_u_2, (ref) v_u_7
					return v_u_2:GetEventRsvpStatusAsync(v_u_7)
				end)
				if not v9 or v10 ~= Enum.RsvpStatus.Going then
					pcall(function()
						-- upvalues: (ref) v_u_2, (ref) v_u_7
						v_u_2:PromptRsvpToEventAsync(v_u_7)
					end)
				end
			end)
		end
	end
end
return v5
