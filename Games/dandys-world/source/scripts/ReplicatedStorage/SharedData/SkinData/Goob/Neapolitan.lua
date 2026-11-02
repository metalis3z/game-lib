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
-- CQM6HHJieGFzc2V0aWQ6Ly8xMzI3OTI1OTUyMzc1NDMMRmFjZVRleHR1cmVzBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMjk0NjA5Nzc3MDA5NjUGTm9ybWFsBEh1cnQEdGFzawR3YWl0DUJsaW5rU2VxdWVuY2UIUm9vdFBhcnQMV2FpdEZvckNoaWxkBnJvb3QueApzcGluZV8wMS54CnNwaW5lXzAyLngGbmVjay54BmhlYWQueBFMYXRjaGVkQXR0YWNobWVudAZDRnJhbWUDbmV3BkFuZ2xlcwdyZXF1aXJlC1NoYXJlZFV0aWxzCFVuaXZlcnNlBklzR2FtZRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMDIyMzgwNTA1MjM0NDEHQWJpbGl0eQVzcGF3bglBcHBseVNraW4ITGVmdEhhbmQETWVzaAlSaWdodEhhbmQGTWVzaElkCVRleHR1cmVJRAlUZXh0dXJlSWQKVXNlQWJpbGl0eQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKTmVhcG9saXRhbgROYW1lBENvc3QKRGFuZHlTdG9yZRxyYnhhc3NldGlkOi8vMTIyMDQ5MTY3OTQzNTIxA1J1bhtyYnhhc3NldGlkOi8vODA1NzU2NjgyOTg2MDUEV2FsaxtyYnhhc3NldGlkOi8vNzM3NDc2NDU2OTU0MzIESWRsZRxyYnhhc3NldGlkOi8vMTE2MTE3NTU2MDIyNjAxBVF1aXJrG3JieGFzc2V0aWQ6Ly84MDE0MjI5MjI1MjE1NAZEZWNvZGUbcmJ4YXNzZXRpZDovLzc3NzQ3MTcwMjMyNzQxHHJieGFzc2V0aWQ6Ly8xMzcyMzgyOTU0NTcyMjgccmJ4YXNzZXRpZDovLzEyMzUzNzczNDA4OTc3MxtyYnhhc3NldGlkOi8vOTkzMTU3MjU3NDE3MDkOVVNFX1NLSU5fTU9ERUwABQoCAQAABwQAAAUCDwQn/wIAAAQAAABvAwAA+wQAAE0EBCEBAAAATQQEmQIAAABvBQMA+wYAAE0GBiEBAAAATQYGEAQAAADFAgMFAQAAAIwFAQAcAwIAjAQBAKgDEgBSBgAAUgcBAIcIAgX7CQAATQkJIQEAAABNCQnFBQAAAJ8GBAGkBggAABxggA0FAwAJAACA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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {
	Name = "Neapolitan",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Run = "rbxassetid://122049167943521",
		Walk = "rbxassetid://80575668298605",
		Idle = "rbxassetid://73747645695432",
		Quirk = "rbxassetid://116117556022601",
		Decode = "rbxassetid://80142292252154",
		Ability = "rbxassetid://77747170232741"
	},
	FaceTextures = {
		Normal = "rbxassetid://137238295457228",
		Blink = "rbxassetid://123537734089773",
		Hurt = "rbxassetid://99315725741709"
	},
	USE_SKIN_MODEL = true
}

function t.BlinkSequence(p1, p2) --[[ BlinkSequence | Line: 25 | Upvalues: t (copy) ]]
	local t2 = {
		"rbxassetid://132792595237543",
		t.FaceTextures.Blink,
		"rbxassetid://129460977700965",
		t.FaceTextures.Normal
	}

	for i = 1, #t2 do
		p1(p2, t2[i], t.FaceTextures.Hurt)
		task.wait(if i == 2 then 0.2 else 0.1)
	end
end
function t.ApplySkin(p1) --[[ ApplySkin | Line: 36 | Upvalues: ReplicatedStorage (copy), t (copy) ]]
	if not require(ReplicatedStorage.SharedUtils.Universe):IsGame() then
		return
	end

	t.OverwriteAnimations.Ability = "rbxassetid://102238050523441"
	task.spawn(function() --[[ Line: 41 | Upvalues: p1 (copy) ]]
		local RootPart = p1:WaitForChild("RootPart", 5)
		local v1 = if RootPart then RootPart:WaitForChild("root.x", 5) else RootPart
		local v2 = if v1 then v1:WaitForChild("spine_01.x", 5) else v1
		local v3 = if v2 then v2:WaitForChild("spine_02.x", 5) else v2
		local v4 = if v3 then v3:WaitForChild("neck.x", 5) else v3
		local v5 = if v4 then v4:WaitForChild("head.x", 5) else v4

		if not v5 then
			return
		end

		local LatchedAttachment = v5:WaitForChild("LatchedAttachment", 5)

		if LatchedAttachment then
			LatchedAttachment.CFrame = CFrame.new(-1, 2.2, -0.5) * CFrame.Angles(0, -1.9198621771937625, 0) * CFrame.Angles(1.9198621771937625, 0, -3.141592653589793)
		end
	end)
end
function t.UseAbility(p1, p2) --[[ UseAbility | Line: 67 ]]
	local Mesh = p2:WaitForChild("LeftHand"):WaitForChild("Mesh")
	local Mesh2 = p2:WaitForChild("RightHand"):WaitForChild("Mesh")

	Mesh.MeshId = p1:WaitForChild("LeftHand").MeshId
	Mesh2.MeshId = p1:WaitForChild("RightHand").MeshId
	Mesh.TextureId = p1:WaitForChild("LeftHand").TextureID
	Mesh2.TextureId = p1:WaitForChild("RightHand").TextureID
end

return t