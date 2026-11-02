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
-- CQMaBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQROYW1lBE5vc2UbcmJ4YXNzZXRpZDovLzkyOTk0MDkyMDkwNTkyCVRleHR1cmVJRAxXYWl0Rm9yQ2hpbGQGQ29sb3IzA25ldwVDb2xvcgpQb2ludExpZ2h0CVNwb3RMaWdodAR3YXJuQFtWaW50YWdlUnVkaWVdIE5vc2UgcGFydCBub3QgZm91bmQgLSBza2lwcGluZyBub3NlIGN1c3RvbWl6YXRpb24QSHVtYW5vaWRSb290UGFydAZDb25maWcLSHVydFRleHR1cmUccmJ4YXNzZXRpZDovLzExMzc4NTQ0NzUyNTcyMwdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzk5NzUxNTMyNjM5OTcJQXBwbHlTa2luDVZpbnRhZ2UgUnVkaWUAAgwBAAAAAHykAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwBNBgW6BQAAAPAGBAAGAAAAbwYHADAGBYQIAAAAbgHz/wIAAABvAwYAjAQFALwBANMJAAAAnwEEAg4BJACkAgwAACyggIwDAQCMBAEAjAUBAJ8CBAIwAgGkDQAAAKQCAQAAAABAvAMBRwIAAACfAwIAnwIABBcCEgBvCQ4AvAcG/gQAAACfBwMCKwcFAG8JDwC8Bwb+BAAAAJ8HAwIOBwgApAcMAAAsoICMCAEAjAkBAIwKAQCfBwQCMAcGpA0AAABuAu3/AgAAAGUABACkAhEAAAAAQW8DEgCfAgIBbwQTALwCANMJAAAAnwIDAqQDAQAAAABAvAQCRwIAAACfBAIAnwMABBcDEgBvCg4AvAgH/gQAAACfCAMCKwgFAG8KDwC8CAf+BAAAAJ8IAwIOCAgApAgMAAAsoICMCQEAjAoBAIwLAQCfCAQCMAgHpA0AAABuA+3/AgAAAG8FFAC8AwDTCQAAAJ8DAwJvBhUAvAQD0wkAAACfBAMCbwUWADAFBE8XAAAAbwcYALwFA9MJAAAAnwUDAm8IGQC8BgPTCQAAAJ8GAwJvBwcAMAcFTxcAAABvBxoAMAcGTxcAAACCAAEAGwMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwQALKCAAwwDDQMOAw8EAAAAQQMQAxEDEgMTAxQDFQMWAxcDGAAFGQEYAAAAAAAAAAEAAAAAAAAAAAEAAP4ABgAAAAABAQAAAAAAAAACAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAA/gAABgAAAAMAAAADAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAA/gAGAAAAAQAAAAIAAAIAAAABAAAAAgAAAQAAAQYAAAAAAgAAAQIACqMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAMABAgAwAQDpAwAAAIIAAgAEAxoDBQYAAxkBAAEAARgAAAACAAACAAApAQAAAAABPkMkQO+pRjZBop4Wo94uj05bMzQMh05B

-- https://lua.expert/
return {
	Name = "Vintage Rudie",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") and v.Name ~= "Nose" then
				v.TextureID = "rbxassetid://92994092090592"
			end
		end

		local Nose = p1:WaitForChild("Nose", 5)

		if Nose then
			Nose.Color = Color3.new(255/255, 255/255, 255/255)

			for k, v in pairs(Nose:GetDescendants()) do
				if v:IsA("PointLight") or v:IsA("SpotLight") then
					v.Color = Color3.new(255/255, 255/255, 255/255)
				end
			end
		else
			warn("[VintageRudie] Nose part not found - skipping nose customization")
		end

		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")

		for k, v in pairs(HumanoidRootPart:GetDescendants()) do
			if v:IsA("PointLight") or v:IsA("SpotLight") then
				v.Color = Color3.new(255/255, 255/255, 255/255)
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://113785447525723"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://92994092090592"
		BlinkTexture.Texture = "rbxassetid://139975153263997"
	end
}