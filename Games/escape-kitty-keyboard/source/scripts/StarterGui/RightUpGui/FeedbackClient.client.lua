-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- CQMaBlJlYXNvbgAdUHJvbXB0RmVlZGJhY2tTdWJtaXNzaW9uQXN5bmMFcGNhbGwEd2FyblZbRmVlZGJhY2tDbGllbnRdIFByb21wdEZlZWRiYWNrU3VibWlzc2lvbkFzeW5jIHVuYXZhaWxhYmxlLCBkaXNhYmxpbmcgZmVlZGJhY2sgYnV0dG9uOgJvcwVjbG9jawZ0eXBlb2YIZnVuY3Rpb24EdGFzawVzcGF3bgRnYW1lDVNvY2lhbFNlcnZpY2UKR2V0U2VydmljZQdQbGF5ZXJzC0xvY2FsUGxheWVyBnNjcmlwdAZQYXJlbnQORmVlZGJhY2tCdXR0b24MV2FpdEZvckNoaWxkCUd1aUJ1dHRvbgNJc0E6W0ZlZWRiYWNrQ2xpZW50XSBGZWVkYmFja0J1dHRvbiBtaXNzaW5nIG9yIG5vdCBhIEd1aUJ1dHRvbglBY3RpdmF0ZWQHQ29ubmVjdAAEBAACAAAAB/sAAAD7AgEA4gMCALwAAEADAAAAnwAEAYIAAQAEAwEDAggBAAEAAAADAwAkAAEYAAAAAAAAAScAAAAABQADAAAAD6QAAQAAAABAwAECABICAAASAgEAnwACAysABwCpAgEA3gICAKQCBAAAADBAbwMFAFIEAQCfAgMBggABAAYDBAQAAABABgADBQQAADBAAwYBACMAARgAAAAAAAAFAQABAAAAAAIkAAAAAAIABAAAACP7AAAADgABAIIAAQCkAAIAAAQAgJ8AAQL7AQEAYAACAAEAAACCAAEApAECAAAEAICfAQEClQABA94AAQD7AQIATQEBQAQAAAC7LAECpAAGAAAAUECfAAIC8AAEAAcAAACpAAEA3gAAAIIAAQCkAAoAACSAgNkBAAASAgIAEgIDABICAACfAAIBggABAAsDBwMIBAAEAIACAAAAAAAAAEADAwMJBAAAUEADCgMLAwwEACSAgAEBGQABGAAAAAEAAAAAAAABAAAAAAIAAAAAAAAAAAEAAQMAAAAAAAALGgAAAAAKAAABAgAxowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBAQAAAABAbwMEALwBARYDAAAAnwEDAk0CATEFAAAApAMHAAAAYEBNAwMkCAAAAG8GCQCMBwoAvAQD0woAAACfBAQCDgQFAG8HCwC8BQT+DAAAAJ8FAwIrBQUApAUOAAAA0EBvBg8AnwUCAYIAAQCMBQAAqQYAAE0HBB4QAAAA2QkAABIBBv8SAQX/EgAAABIAAgC8BwfHEQAAAJ8HAwHBBQAAggABABIDDQQAAABAAw4DDwMQAxEDEgQAAGBAAxMDFAMVAxYDFwMFBAAA0EADGAMZAxoBAgEAARgACAAAAAAAAQAAAAAAAgABAAAAAgAAAAABAAAAAAABAAAAAQQBAgAAAAAAAAAAABYAAQAAAAADMODJVvnS3YHtp7BbN22BskD43iICJKNX

-- https://lua.expert/
local SocialService = game:GetService("SocialService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local FeedbackButton = script.Parent:WaitForChild("FeedbackButton", 10)

if FeedbackButton and FeedbackButton:IsA("GuiButton") then
	local v1 = 0
	local v2 = false

	FeedbackButton.Activated:Connect(function() --[[ Line: 25 | Upvalues: v2 (ref), v1 (ref), SocialService (copy), LocalPlayer (copy) ]]
		if v2 then
			return
		end

		if os.clock() < v1 then
			return
		end

		v1 = os.clock() + 2

		local PromptFeedbackSubmissionAsync = SocialService.PromptFeedbackSubmissionAsync

		if typeof(PromptFeedbackSubmissionAsync) == "function" then
			task.spawn(function() --[[ Line: 35 | Upvalues: SocialService (ref), LocalPlayer (ref), v2 (ref) ]]
				local ok, result = pcall(function() --[[ Line: 36 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
					SocialService:PromptFeedbackSubmissionAsync(LocalPlayer, {
						Reason = ""
					})
				end)

				if ok then
					return
				end

				v2 = true
				warn("[FeedbackClient] PromptFeedbackSubmissionAsync unavailable, disabling feedback button:", result)
			end)
		else
			v2 = true
		end
	end)
else
	warn("[FeedbackClient] FeedbackButton missing or not a GuiButton")
end