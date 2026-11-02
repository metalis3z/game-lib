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
-- CQMIBXBhaXJzBnNjcmlwdAZQYXJlbnQQSHVtYW5vaWRSb290UGFydAtHZXRDaGlsZHJlbgVTb3VuZANJc0EGVm9sdW1lAAEIAAABAAAZowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAWYFAAAAvAEBaAYAAACfAQIAnwAABBcACABvBwcAvAUE/ggAAACfBQMCDgUDAIwFAAAwBQRLCQAAAG4A9/8CAAAAggABAAoDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAABAAEYAAAAAAAAAAAAAAAAAAABAAAAAAEAAP4ABAEAAAAAAA==

-- https://lua.expert/
for k, v in pairs(script.Parent.HumanoidRootPart:GetChildren()) do
	if v:IsA("Sound") then
		v.Volume = 0
	end
end