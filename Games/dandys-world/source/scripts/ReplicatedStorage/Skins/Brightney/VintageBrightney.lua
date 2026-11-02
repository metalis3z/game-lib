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
-- CQMZBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQhNYXRlcmlhbARFbnVtBE5lb24YcmJ4YXNzZXRpZDovLzE3Njc2NTU2NTM5CVRleHR1cmVJRAZDb2xvcjMHZnJvbVJHQgVDb2xvcg9QYXJ0aWNsZUVtaXR0ZXINQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50BkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUYcmJ4YXNzZXRpZDovLzE3Njc2NTU5NzQzB1RleHR1cmUNTm9ybWFsVGV4dHVyZQlBcHBseVNraW4RVmludGFnZSBCcmlnaHRuZXkETmFtZQACDwEAAAAAVqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBOgBvCAMAvAYF/gQAAACfBgMCDgYTAE0GBS0FAAAApAcIAAcUYMDxBgUABwAAAG8GCQAwBgWECgAAAGUAKwCkBg0AADCwgIwHsACMCLAAjAmwAJ8GBAIwBgWkDgAAAGUAIgBvCA8AvAYF/gQAAACfBgMCDgYdAKQGEgAARACB/wcAAAIAAACkCBQAAEQwgYwJAACkCg0AADCwgIwL/wCMDP8AjA3/AJ8KBACfCAACpAkUAABEMIGMCgEApAsNAAAwsICMDP8AjA3/AIwO/wCfCwQAnwkAAMUHCAABAAAAnwYCAjAGBaQOAAAAbgHF/wIAAABvAxUAvAEA0xYAAACfAQMCbwQXALwCAdMWAAAAnwIDAm8DGAAwAwJPGQAAAG8FGgC8AwHTFgAAAJ8DAwJvBAkAMAQDTxkAAACCAAEAGwMBBAAAAEADAgMDAwQDBQMGAwcEBxRgwAMIAwkDCgMLBAAwsIADDAMNAw4DDwQARACBAxAEAEQwgQMRAxIDEwMUAxUDFgAFFwEYAAAAAAAAAAEAAAAAAQAAAAAAAQAAAAIAAAAAAAAAAAIAAAAAAQAAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAD4AA8AAAABAAAAAgAAAgAAAAIAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMYAxkGAAMXAQABAAEYAAAAAgAAAgAAHAEAAAAAAXUGHnBPxkpP09Gx9KJZV8cFHgkER8J0cQ==

-- https://lua.expert/
return {
	Name = "Vintage Brightney",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				if v.Material == Enum.Material.Neon then
					v.Color = Color3.fromRGB(176, 176, 176)

					continue
				end

				v.TextureID = "rbxassetid://17676556539"

				continue
			end

			if v:IsA("ParticleEmitter") then
				v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://17676559743"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://17676556539"
	end
}