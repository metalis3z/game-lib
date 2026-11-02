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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTI4MTQ2NTI1ODA5MjA5CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDE3OTU4ODg1OTg3MTMHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTAwMDc3NTY1OTgwMjU1CUFwcGx5U2tpbg5WaW50YWdlIEVnZ3NvbgROYW1lB01hc3RlcnkAAgkBAAAAACukAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8GDQC8BAHTCAAAAJ8EAwJvBQUAMAUDTwsAAABvBQ4AMAUETwsAAACCAAEADwMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgAGDwEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAABAAAAAgAAAQAAAQcAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAMABAwAwAQDpBAAAAIIAAgAFAxADEQMSBgADDwEAAQABGAAAAAIAAAEAAAIAABMBAAAAAAFgPxxOwNvSSBpsgPad9cXwECcLOlL7dk8=

-- https://lua.expert/
return {
	Name = "Vintage Eggson",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://128146525809209"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://101795888598713"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://128146525809209"
		BlinkTexture.Texture = "rbxassetid://100077565980255"
	end
}