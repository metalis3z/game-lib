--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMlBXBhaXJzDkdldERlc2NlbmRhbnRzD1BhcnRpY2xlRW1pdHRlcgNJc0ENQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50BkNvbG9yMwdmcm9tUkdCBUNvbG9yBUxpZ2h0CUFwcGx5U2tpbg1Db3p5IExpZ2h0aW5nBE5hbWUEQ29zdApEYW5keVN0b3JlHHJieGFzc2V0aWQ6Ly8xMDcyMTM3NzgzNDEwMDgDUnVuHHJieGFzc2V0aWQ6Ly8xMzIyMzQxMzI0Njc1MTMEV2FsaxxyYnhhc3NldGlkOi8vMTEwMjk2MDQ3Nzg4MjE1BElkbGUbcmJ4YXNzZXRpZDovLzk3NTcwOTc1MjQ1MjY2BVF1aXJrG3JieGFzc2V0aWQ6Ly85NDIyODMzNTA2Mzk1NAZEZWNvZGUccmJ4YXNzZXRpZDovLzEyMjU0NTUxODA4NDYxMQdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzk3NjI0MTUxNzcxODUxBk5vcm1hbBxyYnhhc3NldGlkOi8vMTM4MTkzNTM3NzEwMDg3BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTc3MzAwMDkxMDI2MjkESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAg8BAAAABgMAAAUBBzqkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXATAAbwgDALwGBf4EAAAAnwYDAg4GHgCkBgcAABhQgP8HAAACAAAApAgJAAAYgICMCQAApAoMAAAsoICMC94AjAzMAIwNtwCfCgQAnwgAAqQJCQAAGICAjAoBAKQLDAAALKCAjAzeAIwNzACMDrcAnwsEAJ8JAADFBwgAAQAAAJ8GAgIwBgWkDQAAAGUADQBvCA4AvAYF/gQAAACfBgMCDgYIAKQGDAAALKCAjAf/AIwIwACMCS4AnwYEAjAGBaQNAAAAbgHP/wIAAACCAAEADwMBBAAAAEADAgMDAwQDBQMGBAAYUIADBwQAGICAAwgDCQQALKCAAwoDCwAYDAEYAAAAAAAAAAEAAAAAAQAAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAAABAAAAAABAAAAAAAAAPkACxoAAAAAAwAAAQIANqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAIwBWAIwAQAjAgAAAKkBAQAwAQBOAwAAAP8BBAAAAAAAbwIEADACARYFAAAAbwIGADACAZ8HAAAAbwIIADACAZIJAAAAbwIKADACAXgLAAAAbwIMADACAe4NAAAAbwIOADACAfQPAAAAMAEA6RAAAAD/AQMAAAAAAG8CEQAwAgEQEgAAAG8CEwAwAgGZFAAAAG8CFQAwAgHFFgAAADABACEXAAAAqQEBADABAMIYAAAAwAEZADABAOkaAAAAggACABsDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQYAAwwBAAEAARgAAAACAAABAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAABEBAAAAAAGCNH+jM84S3cJ3McBVN5Lt8ixo17DwFaI=

-- https://lua.expert/
return {
	Name = "Cozy Lighting",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Run = "rbxassetid://107213778341008",
		Walk = "rbxassetid://132234132467513",
		Idle = "rbxassetid://110296047788215",
		Quirk = "rbxassetid://97570975245266",
		Decode = "rbxassetid://94228335063954",
		Ability = "rbxassetid://122545518084611"
	},
	FaceTextures = {
		Normal = "rbxassetid://97624151771851",
		Blink = "rbxassetid://138193537710087",
		Hurt = "rbxassetid://117730009102629"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(222, 204, 183)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 204, 183)) })

				continue
			end

			if v:IsA("Light") then
				v.Color = Color3.fromRGB(255, 192, 46)
			end
		end
	end
}