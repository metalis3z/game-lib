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
-- CQM9B3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UGSXNHYW1lEEh1bWFub2lkUm9vdFBhcnQMV2FpdEZvckNoaWxkBXBhaXJzDkdldERlc2NlbmRhbnRzClBvaW50TGlnaHQDSXNBCVNwb3RMaWdodAZDb2xvcjMHZnJvbVJHQgVDb2xvcgROb3NlCFJvb3RQYXJ0BHJvb3QKQXR0YWNobWVudAV0b3Jzbw5GaW5kRmlyc3RDaGlsZAVjaGVzdARoZWFkBkNGcmFtZQNuZXcGQW5nbGVzBlBhcmVudAZTaGFkb3cEd2FybkFbR29sZGVuQW50bGVyc10gTm9zZSBwYXJ0IG5vdCBmb3VuZCAtIHNraXBwaW5nIG5vc2UgY3VzdG9taXphdGlvbglBcHBseVNraW4EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDkdvbGRlbiBBbnRsZXJzBE5hbWUFUnVkaWUJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5HHJieGFzc2V0aWQ6Ly8xMzgwNzIyMjE5MjE0NTIDUnVuHHJieGFzc2V0aWQ6Ly8xMTk0MjA4OTU2MDIxNTIEV2FsaxxyYnhhc3NldGlkOi8vMTA3NzE2MzQ5MjUxNzE3BElkbGUbcmJ4YXNzZXRpZDovLzc2OTQ2OTY2NDc2NTg2BVF1aXJrHHJieGFzc2V0aWQ6Ly8xMzQ0MDU1MDU1MTg3MzkGRGVjb2RlG3JieGFzc2V0aWQ6Ly83OTMwODcwMTAwNDQ0MwdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEzNDM2NjQ0NDI1MjE0OAZOb3JtYWwccmJ4YXNzZXRpZDovLzEwNTg1MjU2OTY0NjA5NAVCbGluaxxyYnhhc3NldGlkOi8vMTA0ODc3ODIzNTE4MjEzBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIRAgEAAAcEAAAFAgcHlQGkAgEAAAAAQPsDAABNAwOgAgAAAE0DAxkDAAAAnwICArwDAvEEAAAAnwMCAisDAQCCAAEAbwUFALwDANMGAAAAnwMDAqQECAAAAHBAvAUDRwkAAACfBQIAnwQABBcEEgBvCwoAvAkI/gsAAACfCQMCKwkFAG8LDAC8CQj+CwAAAJ8JAwIOCQgApAkPAAA40ICMCtUAjAsnAIwMJQCfCQQCMAkIpBAAAABuBO3/AgAAAG8GEQCMBwUAvAQA0wYAAACfBAQCbwcSALwFANMGAAAAnwUDAm8HEwC8BQXTBgAAAJ8FAwIOBFYA/wYAAAAAAACkBwgAAABwQLwIBEcJAAAAnwgCAJ8HAAQXBxUAbw4KALwMC/4LAAAAnwwDAisMBQBvDgwAvAwL/gsAAACfDAMCDgwLAKQMDwAAONCAjA3VAIwOJwCMDyUAnwwEAjAMC6QQAAAAHA0GAJUMDRRqCwYMbgfq/wIAAABvCRUAjAoDALwHBNMGAAAAnwcEAlIIBQAOCAQAbwoWALwIBQMXAAAAnwgDAlIJCAAOCQQAbwsYALwJCAMXAAAAnwkDAlIKCQAOCgQAbwwZALwKCQMXAAAAnwoDAg4HEwAOChIApAwcAABsoIGMDf//bw4dAIwPAACfDAQCpA0fAAB4oIFvDiAAjA8AAIwQAACfDQQCCQsMDTALB4UaAAAAMAoHJCEAAACCAAEApAsIAAAAcEBSDAYAnwsCBBcLAwCpEAAAMBAPASIAAABuC/z/AgAAAIIAAQCkBiQAAAAwQm8HJQCfBgIBggABACYDAQQAAABAAwIDAwMEAwUDBgMHBAAAcEADCAMJAwoDCwMMAw0EADjQgAMOAw8DEAMRAgAAAAAAAPA/AxIDEwMUAxUDFgMXAxgEAGyggQIzMzMzMzP7vwMZBAB4oIECGC1EVPsh+b8DGgMbAxwEAAAwQgMdACAeARgAAAAAAAAAAAIAAAABAwAAAAIAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAD+AAYAAAAAAQAAAAAAAAACAQABAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAQAA/QAGAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAQAAAAAAAAAAAAAAAAAAAQAAAgAAAAABAAD/AAAFAAAAAyIAAAAABAAAAQIAQKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQQAAAAAAG8CBAAwAgG6BQAAAG8CBgAwAgGHBwAAAG8CCAAwAgHiCQAAAKkCAAAwAgE8CgAAAP8CBAAAAAAAbwMLADADAhYMAAAAbwMNADADAp8OAAAAbwMPADADApIQAAAAbwMRADADAngSAAAAbwMTADADAu4UAAAAbwMVADADAvQWAAAAMAIB6RcAAAD/AgMAAAAAAG8DGAAwAwIQGQAAAG8DGgAwAwKZGwAAAG8DHAAwAwLFHQAAADACASEeAAAAqQIBADACAcIfAAAAwAIgABIAAAAwAgHpIQAAAIIBAgAiAx8EAAAAQAMgAyEDIgMjAyQDJQMmAycDKAMpAyoDKwMsAy0DLgMvAzADMQMyAzMDNAM1AzYDNwM4AzkDOgM7AzwDPQYAAx4BAAEAARgAAAAAAAAAAQACAAABAAABAAABAAAIAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAAtAQAAAAAB3CX2Q1Y59WYA7IRT+DRP/6w94Tfu4ZxC

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Golden Antlers",
	TowerName = "Rudie",
	Description = "No description yet",
	Mastery = false,
	OverwriteAnimations = {
		Run = "rbxassetid://138072221921452",
		Walk = "rbxassetid://119420895602152",
		Idle = "rbxassetid://107716349251717",
		Quirk = "rbxassetid://76946966476586",
		Decode = "rbxassetid://134405505518739",
		Ability = "rbxassetid://79308701004443"
	},
	FaceTextures = {
		Normal = "rbxassetid://134366444252148",
		Blink = "rbxassetid://105852569646094",
		Hurt = "rbxassetid://104877823518213"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1, p2) --[[ ApplySkin | Line: 32 | Upvalues: ReplicatedStorage (copy) ]]
		if not require(ReplicatedStorage.SharedUtils.Universe):IsGame() then
			return
		end

		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")

		for k, v in pairs(HumanoidRootPart:GetDescendants()) do
			if v:IsA("PointLight") or v:IsA("SpotLight") then
				v.Color = Color3.fromRGB(213, 39, 37)
			end
		end

		local Nose = p1:WaitForChild("Nose", 5)
		local root = p1:WaitForChild("RootPart"):WaitForChild("root")

		if not Nose then
			warn("[GoldenAntlers] Nose part not found - skipping nose customization")

			return
		end

		local tbl = {}

		for k, v in pairs(Nose:GetDescendants()) do
			if v:IsA("PointLight") or v:IsA("SpotLight") then
				v.Color = Color3.fromRGB(213, 39, 37)
				tbl[#tbl + 1] = v
			end
		end

		local Attachment = Nose:WaitForChild("Attachment", 3)
		local v1 = if root then root:FindFirstChild("torso") else root
		local v2 = if v1 then v1:FindFirstChild("chest") else v1
		local v3 = if v2 then v2:FindFirstChild("head") else v2

		if Attachment and v3 then
			Attachment.CFrame = CFrame.new(-1, -1.7, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
			Attachment.Parent = v3

			return
		end

		for k, v in pairs(tbl) do
			v.Shadow = false
		end
	end
}