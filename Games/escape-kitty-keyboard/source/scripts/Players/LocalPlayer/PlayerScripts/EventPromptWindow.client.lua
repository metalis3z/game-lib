-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("Players")
local v2 = game:GetService("CollectionService")
local u3 = game:GetService("SocialService")
local v4 = game:GetService("ReplicatedStorage")
local v5 = v4:WaitForChild("EventRsvpId", 10)
if v5 and v5.Value ~= "" then
	local u6 = v5.Value
	local u7 = v4:WaitForChild("Remotes"):WaitForChild("ClaimRsvpBoost", 10)
	local u8 = v1.LocalPlayer
	local u9 = false
	local u10 = false
	local u11 = false
	local function u18() -- name: promptRSVP
		-- upvalues: (ref) u10, (copy) u3, (copy) u6, (ref) u11, (copy) u7
		if u10 then
			return
		else
			u10 = true
			local v12, v13 = pcall(function()
				-- upvalues: (ref) u3, (ref) u6
				return u3:GetEventRsvpStatusAsync(u6)
			end)
			if v12 then
				if v13 == Enum.RsvpStatus.Going then
					if not u11 and u7 then
						u11 = true
						u7:FireServer()
					end
					u10 = false
					return
				else
					local v14, v15 = pcall(function()
						-- upvalues: (ref) u3, (ref) u6
						return u3:PromptRsvpToEventAsync(u6)
					end)
					if v14 then
						local v16, v17 = pcall(function()
							-- upvalues: (ref) u3, (ref) u6
							return u3:GetEventRsvpStatusAsync(u6)
						end)
						if v16 and (v17 == Enum.RsvpStatus.Going and (not u11 and u7)) then
							u11 = true
							u7:FireServer()
						end
						u10 = false
					else
						warn("[EventRsvpPrompt] RSVP prompt failed:", v15)
						u10 = false
					end
				end
			else
				warn("[EventRsvpPrompt] Failed to get RSVP status:", v13)
				u10 = false
				return
			end
		end
	end
	task.spawn(function()
		-- upvalues: (copy) u3, (copy) u6, (ref) u11, (copy) u7
		task.wait(3)
		local v19, v20 = pcall(function()
			-- upvalues: (ref) u3, (ref) u6
			return u3:GetEventRsvpStatusAsync(u6)
		end)
		if v19 and (v20 == Enum.RsvpStatus.Going and not u11) then
			if not u7 then
				return
			end
			u11 = true
			u7:FireServer()
		end
	end)
	local function u23(p21) -- name: onZoneTouched
		-- upvalues: (ref) u9, (copy) u8, (copy) u18
		if u9 then
			return
		else
			local v22 = u8.Character
			if v22 and p21:IsDescendantOf(v22) then
				u9 = true
				task.spawn(u18)
			end
		end
	end
	local u24 = u9
	local function v26(p25) -- name: connectZone
		-- upvalues: (copy) u23
		p25.Touched:Connect(u23)
	end
	for _, v27 in ipairs(v2:GetTagged("EventRSVPzone")) do
		v27.Touched:Connect(u23)
	end
	v2:GetInstanceAddedSignal("EventRSVPzone"):Connect(v26)
	local function v30(p28) -- name: connectPrompt
		-- upvalues: (copy) u8, (copy) u18
		if p28:IsA("ProximityPrompt") then
			p28.Triggered:Connect(function(p29)
				-- upvalues: (ref) u8, (ref) u18
				if p29 == u8 then
					task.spawn(u18)
				end
			end)
		end
	end
	for _, v31 in ipairs(v2:GetTagged("EventRSVPbutton")) do
		if v31:IsA("ProximityPrompt") then
			v31.Triggered:Connect(function(p32)
				-- upvalues: (copy) u8, (copy) u18
				if p32 == u8 then
					task.spawn(u18)
				end
			end)
		end
	end
	v2:GetInstanceAddedSignal("EventRSVPbutton"):Connect(v30)
	task.delay(600, function()
		-- upvalues: (ref) u24, (copy) u18
		if not u24 then
			u24 = true
			u18()
		end
	end)
else
	warn("[EventRsvpPrompt] No event_id available, script disabled")
end