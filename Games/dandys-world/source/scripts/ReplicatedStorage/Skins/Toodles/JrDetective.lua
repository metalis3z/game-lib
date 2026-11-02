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
-- CQMlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTMzMTE1ODgxMjIyNDMyCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NDUyMTI0NjExMDI4NwdUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjI5NTc4OTUzNzM5NDUEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQpBbmltYXRpb25zC0dldENoaWxkcmVuDkZpbmRGaXJzdENoaWxkCUFuaW1hdGlvbgtBbmltYXRpb25JZAhJbnN0YW5jZQNuZXcEV2VsZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5CUFwcGx5U2tpbhBKdW5pb3IgRGV0ZWN0aXZlAAITAQAAAACWAaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvBQoAvAMB0wgAAACfAwMCbwYLALwEAdMIAAAAnwQDAm8FDAAwBQJPDQAAAG8FDgAwBQNPDQAAAG8FBQAwBQRPDQAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICbwkZALwHANMIAAAAnwcDAqQIAQAAAABAbwsZALwJBtMIAAAAnwkDArwJCWgaAAAAnwkCAJ8IAAQXCBQATQ8MuhcAAAC8DQcDGwAAAJ8NAwIODQ4AbxAcALwODf4EAAAAnw4DAg4OCQBvEBwAvA4M/gQAAACfDgMCDg4EAE0ODLYdAAAAMA4Nth0AAABuCOv/AgAAAP8IAAAAAAAApAkBAAAAAEC8CgZoGgAAAJ8KAgCfCQAEFwkhAG8QAwC8Dg3+BAAAAJ8OAwIODhwApA4gAAB84IFvDyEAnw4CAk0QDboXAAAAhw8IECsPAgBNDw26FwAAAFISDwC8EADTCAAAAJ8QAwIwEA0kIgAAADANDiQiAAAAMA0OPCMAAAAwEA6xJAAAAKkRAAAwEQ1FJQAAAIwRAQAwERDZJgAAAG4J3v8CAAAAggABACcDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwQAAPBAAxADEQMSAxMDFAQAAFBBAxUDFgMXAxgDGQMaAxsDHAMdBAB84IEDHgMfAyADIQMiAyMABSQBGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAABAAAAAQAAAAIAAAEAAAEAAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAgAAAAEAAAAAAAAAAAAAAQAAAAABAAAAAAAAAAAAAAEAAAD9AAcAAgAAAAAAAAEAAAAAAQAAAAEAAAAAAAEAAAABAAEAAQABAAEAAAEAAPYADgcAAAAAAgAAAQIACqMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAMABAgAwAQDpAwAAAIIAAgAEAyUDFQYAAyQBAAEAARgAAAACAAACAAAxAQAAAAABvuHl16/jeM5DVBmxvizvv8758qOMJY/W

-- https://lua.expert/
return {
	Name = "Junior Detective",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://133115881222432"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://94521246110287"
		HurtTexture.Texture = "rbxassetid://122957895373945"
		NormalTexture.Texture = "rbxassetid://133115881222432"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()
		local Animations = p1:WaitForChild("Animations")

		for k, v in pairs(v1:WaitForChild("Animations"):GetChildren()) do
			local v2 = Animations:FindFirstChild(v.Name)

			if v2 and (v2:IsA("Animation") and v:IsA("Animation")) then
				v2.AnimationId = v.AnimationId
			end
		end

		local t = {}

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				local Weld = Instance.new("Weld")
				local v4 = p1:WaitForChild(t[v.Name] or v.Name)

				v.Parent = v4
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = v4
				v.Anchored = false
				v4.Transparency = 1
			end
		end
	end
}