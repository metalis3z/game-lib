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
-- CQMQD1BhcnRpY2xlRW1pdHRlcgNJc0EKQWRkRW1pdHRlcg1SZW1vdmVFbWl0dGVyB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZRBVSV9FbWl0dGVyTW9kdWxlBXBhaXJzB1BsYXllcnMLTG9jYWxQbGF5ZXIJUGxheWVyR3VpDkdldERlc2NlbmRhbnRzD0Rlc2NlbmRhbnRBZGRlZAdDb25uZWN0EkRlc2NlbmRhbnRSZW1vdmluZwADBQEBAAAADG8DAAC8AQD+AQAAAJ8BAwIOAQYA+wEAAFIDAACMBAEAvAEBNgIAAACfAQQBggABAAMDAQMCAwMACQABGAAAAAAAAQAAAAAAAgoAAAAABAEBAAAAC28DAAC8AQD+AQAAAJ8BAwIOAQUA+wEAAFIDAAC8AQG9AgAAAJ8BAwGCAAEAAwMBAwIDBAAQAAEYAAAAAAABAAAAAAIRAAAAAAoAAAEAAESjAAAApAABAAAAAECkAQMAAAAgQE0BAT8EAAAATQEBpQUAAACfAAICpAEHAAAAYECkAgMAAAAgQE0CAlAIAAAATQICMQkAAABNAgKZCgAAALwCAkcLAAAAnwICAJ8BAAQXAQoAbwgMALwGBf4NAAAAnwYDAg4GBQBSCAUAjAkBALwGADYOAAAAnwYEAW4B9f8CAAAApAEDAAAAIEBNAQFQCAAAAE0BATEJAAAATQEBmQoAAABNAQFkDwAAAMADEAASAAAAvAEBxxEAAACfAQMBpAEDAAAAIEBNAQFQCAAAAE0BATEJAAAATQEBmQoAAABNAQGzEgAAAMADEwASAAAAvAEBxxEAAACfAQMBggABABQDBQQAAABAAwYEAAAgQAMHAwgDCQQAAGBAAwoDCwMMAw0DAQMCAwMDDgYAAw8DEAYBAgABAQABGAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAABAAAAAAEAAAAA/gAGAAAAAAAAAAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAKAQAAAAACjPq8PXSxpsmIANLW2YzNdPziq0m+PtY8

-- https://lua.expert/
local UI_EmitterModule = require(game.ReplicatedStorage.UI_EmitterModule)

for k, v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
	if v:IsA("ParticleEmitter") then
		UI_EmitterModule:AddEmitter(v, 1)
	end
end

game.Players.LocalPlayer.PlayerGui.DescendantAdded:Connect(function(p1) --[[ Line: 9 | Upvalues: UI_EmitterModule (copy) ]]
	if not p1:IsA("ParticleEmitter") then
		return
	end

	UI_EmitterModule:AddEmitter(p1, 1)
end)
game.Players.LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(p1) --[[ Line: 16 | Upvalues: UI_EmitterModule (copy) ]]
	if not p1:IsA("ParticleEmitter") then
		return
	end

	UI_EmitterModule:RemoveEmitter(p1)
end)