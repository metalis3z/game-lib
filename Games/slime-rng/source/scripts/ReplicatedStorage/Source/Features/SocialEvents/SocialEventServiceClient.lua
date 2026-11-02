-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SocialEventServiceClient, time of decompilation: Sun May  3 10:12:38 2026 ]]
local t1 = {}
local SocialService = game:GetService("SocialService")

function t1.promptNextUpcomingEvent(t2: {[any]: any}, b1: boolean?) -- line: 6
	-- upvalues: SocialService (copy)
	t2.hasPrompted = true

	local ok, result = pcall(function() -- line: 8
		-- upvalues: SocialService (copy)
		return SocialService:GetUpcomingExperienceEventsAsync()
	end)

	if not ok then
		warn("Failed to load upcoming events:", result)

		return
	end

	local u7 = nil

	for _, v in ipairs(result) do
		if not v.HasStarted and not v.HasEnded then
			u7 = v

			break
		end
	end

	if not u7 then
		return false
	end

	local ok2, result2 = pcall(function() -- line: 30
		-- upvalues: b1 (copy), SocialService (copy), u7 (ref)
		if not b1 or SocialService:GetEventRsvpStatusAsync(u7.Id) == Enum.RsvpStatus.None then
			SocialService:PromptRsvpToEventAsync(u7.Id)
		end
	end)

	if ok2 then
		return true
	end

	warn("RSVP prompt failed:", result2)

	return false
end
function t1.init(p1) -- line: 44
	p1.hasPrompted = false
	task.spawn(function() -- line: 46
		-- upvalues: p1 (copy)
		task.wait(1020)

		if p1.hasPrompted then
			return
		end

		p1:promptNextUpcomingEvent(true)
	end)
end

return t1
