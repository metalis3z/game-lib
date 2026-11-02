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
-- CQMNB1BDX0NBRkUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDlBsYXlXYXZlRXZlbnRzDFdhaXRGb3JDaGlsZBNQbGF5V2F2ZUNsaWVudFJlYWR5CkZpcmVTZXJ2ZXIEd2Fybi9bUGxheVdhdmVdIFBsYXlXYXZlQ2xpZW50UmVhZHkgZXZlbnQgbm90IGZvdW5kLg9QbGF5V2F2ZUJlbmVmaXQNT25DbGllbnRFdmVudAdDb25uZWN0AAIBAQAAAAAD8AABAAAAAICCAAEAAQMBAA4AARgAAAMPAAAAAAcAAAECACujAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCbwMEAIwEHgC8AQDTBQAAAJ8BBAJSAgEADgIFAG8EBgCMBR4AvAIB0wUAAACfAgQCDgIEALwDAmsHAAAAnwMCAWUABACkAwkAAACAQG8ECgCfAwIBUgMBAA4DBQBvBQsAjAYeALwDAdMFAAAAnwMEAg4DBgBNBAOMDAAAAMAGDQC8BATHDgAAAJ8EAwGCAAEADwMCBAAAAEADAwMEAwUDBgMHAwgDCQQAAIBAAwoDCwMMBgADDQEAAQABGAAAAAAAAAACAAAAAAEAAAAAAAACAQAAAAIAAAADAAAAAAAAAQEAAAAAAAYBAAAAAAEp+2u5Pq0frhH5oOMMdaNpWeN8zRs/Abg=

-- https://lua.expert/
local PlayWaveEvents = game:GetService("ReplicatedStorage"):WaitForChild("PlayWaveEvents", 30)
local v1 = if PlayWaveEvents then PlayWaveEvents:WaitForChild("PlayWaveClientReady", 30) else PlayWaveEvents

if v1 then
	v1:FireServer()
else
	warn("[PlayWave] PlayWaveClientReady event not found.")
end

local v2 = if PlayWaveEvents then PlayWaveEvents:WaitForChild("PlayWaveBenefit", 30) else PlayWaveEvents

if not v2 then
	return
end

v2.OnClientEvent:Connect(function(p1) --[[ Line: 14 ]] end)