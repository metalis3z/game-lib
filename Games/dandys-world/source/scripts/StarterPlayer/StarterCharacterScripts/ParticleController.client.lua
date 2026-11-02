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
-- CQMTEEh1bWFub2lkUm9vdFBhcnQMV2FpdEZvckNoaWxkDVBhcnRpY2xlVGhpbmcGQ29uZmlnDkZpbmRGaXJzdENoaWxkDlBhcnRpY2xlVG9nZ2xlBVZhbHVlD1BhcnRpY2xlRW1pdHRlcgNJc0EHRW5hYmxlZAVwY2FsbBdzZXR1cENoYXJhY3RlclBhcnRpY2xlcwRnYW1lB1BsYXllcnMKR2V0U2VydmljZQtMb2NhbFBsYXllcg5DaGFyYWN0ZXJBZGRlZAdDb25uZWN0CUNoYXJhY3RlcgADBgACAAAAJfsAAABvAgAAjAMDALwAANMBAAAAnwAEAg4AHQBvAwIAjAQDALwBANMBAAAAnwEEAg4BFwD7AgEAbwQDALwCAgMEAAAAnwIDAg4CCQBvBQUAvAMCAwQAAACfAwMCDgMEAE0EA+wGAAAAKwQBAIIAAQBvBQcAvAMB/ggAAACfAwMCDgMDAKkDAQAwAwHwCQAAAIIAAQAKAwEDAgMDAwQDBQMGAwcDCAMJAwoABwABGAAAAAAAAAEBAAAAAAECAAAAAAEBAAAAAQAAAAIFAAAAAAEAAAQIAAAAAAMBAQAAAAekAQEAAAAAQNkCAAASAAAAEgIAAJ8BAgKCAAEAAgMLBAAAAEABAAUMARgAAAAAAAAWBwAAAAAGAAABAgAdowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAk0BADEEAAAAwAIFABIAAQBNAwGXBgAAAFIFAgC8AwPHBwAAAJ8DAwFNAwFpCAAAAA4DCABNAwFpCAAAAKQECgAAAJBA2QUBABIAAwASAAEAnwQCAoIAAQALAw0EAAAAQAMOAw8DEAYBAxEDEgMTAwsEAACQQAIBAAEAARgAAAAAAAAAAQADABsAAAAAAAMAAAEA4wAAAAAAHwEAAAAAAsuLzGqdOWSBxzf99tM8zvO7k9se+U+maw==

-- https://lua.expert/
local LocalPlayer = game:GetService("Players").LocalPlayer

local function setupCharacterParticles(p1) --[[ setupCharacterParticles | Line: 5 | Upvalues: LocalPlayer (copy) ]]
	pcall(function() --[[ Line: 7 | Upvalues: p1 (copy), LocalPlayer (ref) ]]
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart", 3)

		if not HumanoidRootPart then
			return
		end

		local ParticleThing = HumanoidRootPart:WaitForChild("ParticleThing", 3)

		if not ParticleThing then
			return
		end

		local Config = LocalPlayer:FindFirstChild("Config")

		if Config then
			local ParticleToggle = Config:FindFirstChild("ParticleToggle")

			if ParticleToggle and not ParticleToggle.Value then
				return
			end
		end

		if not ParticleThing:IsA("ParticleEmitter") then
			return
		end

		ParticleThing.Enabled = true
	end)
end

LocalPlayer.CharacterAdded:Connect(setupCharacterParticles)

if not LocalPlayer.Character then
	return
end

local Character = LocalPlayer.Character

pcall(function() --[[ Line: 7 | Upvalues: Character (copy), LocalPlayer (copy) ]]
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 3)

	if not HumanoidRootPart then
		return
	end

	local ParticleThing = HumanoidRootPart:WaitForChild("ParticleThing", 3)

	if not ParticleThing then
		return
	end

	local Config = LocalPlayer:FindFirstChild("Config")

	if Config then
		local ParticleToggle = Config:FindFirstChild("ParticleToggle")

		if ParticleToggle and not ParticleToggle.Value then
			return
		end
	end

	if not ParticleThing:IsA("ParticleEmitter") then
		return
	end

	ParticleThing.Enabled = true
end)