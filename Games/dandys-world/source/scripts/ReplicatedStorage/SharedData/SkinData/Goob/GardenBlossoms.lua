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
-- CQM9HHJieGFzc2V0aWQ6Ly8xMTM0NDc5NzM5OTM5NTIMRmFjZVRleHR1cmVzBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTg2MjIwMzgyODkxNTQGTm9ybWFsBEh1cnQEdGFzawR3YWl0DUJsaW5rU2VxdWVuY2UHcmVxdWlyZQtTaGFyZWRVdGlscwhVbml2ZXJzZQZJc0dhbWUTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTAyMjM4MDUwNTIzNDQxB0FiaWxpdHkJQXBwbHlTa2luCExlZnRIYW5kDFdhaXRGb3JDaGlsZARNZXNoCVJpZ2h0SGFuZAZNZXNoSWQJVGV4dHVyZUlECVRleHR1cmVJZAVwYWlycw5HZXREZXNjZW5kYW50cw5Sb3BlQ29uc3RyYWludANJc0EKQnJpY2tDb2xvcgNuZXcLRGFyayBub3VnYXQFQ29sb3IKVXNlQWJpbGl0eQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UPR2FyZGVuIEJsb3Nzb21zBE5hbWUER29vYglUb3dlck5hbWUEQ29zdApTaGFyZWREYXRhDFJlbGVhc2VUaW1lcw1FYXN0ZXIyMDI2X1c1B1VubG9ja3MGRWFzdGVyC0hvbGlkYXlTa2luG3JieGFzc2V0aWQ6Ly84MDU3NTY2ODI5ODYwNQRXYWxrHHJieGFzc2V0aWQ6Ly8xMjIwNDkxNjc5NDM1MjEDUnVuHHJieGFzc2V0aWQ6Ly8xMTYxMTc1NTYwMjI2MDEFUXVpcmsbcmJ4YXNzZXRpZDovLzczNzQ3NjQ1Njk1NDMyBElkbGUbcmJ4YXNzZXRpZDovLzgwMTQyMjkyMjUyMTU0BkRlY29kZRtyYnhhc3NldGlkOi8vNzgzNDQzODkwMDQ4ODkbcmJ4YXNzZXRpZDovLzg2NDU3ODk3MzIyMzQwG3JieGFzc2V0aWQ6Ly84NzU0OTU2ODQzOTYzMg5VU0VfU0tJTl9NT0RFTAAECgIBAAAHBAAABQIPBCf/AgAABAAAAG8DAAD7BAAATQQEIQEAAABNBASZAgAAAG8FAwD7BgAATQYGIQEAAABNBgYQBAAAAMUCAwUBAAAAjAUBABwDAgCMBAEAqAMSAFIGAABSBwEAhwgCBfsJAABNCQkhAQAAAE0JCcUFAAAAnwYEAaQGCAAAHGCADQUDAAkAAIBvBwoAZQABAG8HCwCfBgIBiwPu/4IAAQAMAwEDAgMDAwQDBQMGAwcDCAQAHGCAAgAAAAAAAABAApqZmZmZmck/ApqZmZmZmbk/ACAJARgAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAAAAAEAAAAAAAAA/gQjAAAAAAMBAgAABgMAAAUBBxOkAQEAAAAAQPsCAABNAgKgAgAAAE0CAhkDAAAAnwECArwBAfEEAAAAnwECAg4BBgD7AQEATQEB6QUAAABvAgYAMAIB9AcAAACCAAEACAMKBAAAAEADCwMMAw0DDgMPAxAAKxEBGAAAAAAAAAAAAAAAAAEAAAAAAAMtAAAAAAwCAAAABwQAAAUCBwdFbwQAALwCAdMBAAAAnwIDAm8EAgC8AgLTAQAAAJ8CAwJvBQMAvAMB0wEAAACfAwMCbwUCALwDA9MBAAAAnwMDAm8GAAC8BADTAQAAAJ8EAwJNBATVBAAAADAEAtUEAAAAbwYDALwEANMBAAAAnwQDAk0EBNUEAAAAMAQD1QQAAABvBgAAvAQA0wEAAACfBAMCTQQEhAUAAAAwBAL3BgAAAG8GAwC8BADTAQAAAJ8EAwJNBASEBQAAADAEA/cGAAAApAQIAAAAcEC8BQFHCQAAAJ8FAgCfBAAEFwQLAG8LCgC8CQj+CwAAAJ8JAwIOCQYApAkOAAA0wIBvCg8AnwkCAjAJCKQQAAAAbgT0/wIAAACCAAEAEQMSAxMDFAMVAxYDFwMYAxkEAABwQAMaAxsDHAMdAx4EADTAgAMfAyAAMyEBGAAAAAAAAAAAAQAAAAAAAAACAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAEAAAAAAP4ABjUAAAAABgAAAQIAXKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQUAAAAAAG8CBAAwAgG6BQAAAG8CBgAwAgGHBwAAAIwCWAIwAgEjCAAAAKQCCgAAAJBApAMBAAAAAEBvBQIAvAMDFgMAAACfAwMCTQMDZAsAAABNAwMKDAAAAJ8CAgJNAgLlDQAAADACAVEOAAAAqQIBADACAREPAAAAqQIBADACAbwQAAAA/wIEAAAAAABvAxEAMAMCnxIAAABvAxMAMAMCFhQAAABvAxUAMAMCeBYAAABvAxcAMAMCkhgAAABvAxkAMAMC7hoAAABvAxsAMAMC9BwAAAAwAgHpHQAAAP8CAwAAAAAAbwMeADADAsUfAAAAbwMgADADAhAhAAAAbwMiADADApkjAAAAMAIBISQAAACpAgEAMAIBwiUAAADAAiYAEgABADACAXInAAAAwAIoABIAAAASAAEAMAIB6SkAAADAAioAMAIBsisAAACCAQIALAMiBAAAAEADIwMkAyUDJgMnAygDKQMKBAAAkEADKgMrAywDLQMuAy8DMAMxAzIDMwM0AzUDNgM3AzgDOQMPAxADDgM6AwYDOwMFAzwDAwMCAz0GAAMJBgEDEQYCAyEDAAECAQABGAAAAAAAAAABAAIAAAEAAAEAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAABAAD6AAkAAQAAAQAAAQAA/QAIAAACAAAACwAAAAAIAAAUAQAAAAAD9TczfR6pdxYuMExUsNdJ6YUvJAnH81l8

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	Name = "Garden Blossoms",
	TowerName = "Goob",
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W5,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://80575668298605",
		Run = "rbxassetid://122049167943521",
		Quirk = "rbxassetid://116117556022601",
		Idle = "rbxassetid://73747645695432",
		Decode = "rbxassetid://80142292252154",
		Ability = "rbxassetid://102238050523441"
	},
	FaceTextures = {
		Hurt = "rbxassetid://78344389004889",
		Normal = "rbxassetid://86457897322340",
		Blink = "rbxassetid://87549568439632"
	},
	USE_SKIN_MODEL = true
}

function t.BlinkSequence(p1, p2) --[[ BlinkSequence | Line: 32 | Upvalues: t (copy) ]]
	local t2 = {
		"rbxassetid://113447973993952",
		t.FaceTextures.Blink,
		"rbxassetid://118622038289154",
		t.FaceTextures.Normal
	}

	for i = 1, #t2 do
		p1(p2, t2[i], t.FaceTextures.Hurt)
		task.wait(if i == 2 then 0.2 else 0.1)
	end
end
function t.ApplySkin(p1) --[[ ApplySkin | Line: 43 | Upvalues: ReplicatedStorage (copy), t (copy) ]]
	if not require(ReplicatedStorage.SharedUtils.Universe):IsGame() then
		return
	end

	t.OverwriteAnimations.Ability = "rbxassetid://102238050523441"
end
function t.UseAbility(p1, p2) --[[ UseAbility | Line: 51 ]]
	local Mesh = p2:WaitForChild("LeftHand"):WaitForChild("Mesh")
	local Mesh2 = p2:WaitForChild("RightHand"):WaitForChild("Mesh")

	Mesh.MeshId = p1:WaitForChild("LeftHand").MeshId
	Mesh2.MeshId = p1:WaitForChild("RightHand").MeshId
	Mesh.TextureId = p1:WaitForChild("LeftHand").TextureID
	Mesh2.TextureId = p1:WaitForChild("RightHand").TextureID

	for k, v in pairs(p2:GetDescendants()) do
		if v:IsA("RopeConstraint") then
			v.Color = BrickColor.new("Dark nougat")
		end
	end
end

return t