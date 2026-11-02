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
-- CQNAB3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UGSXNHYW1lEEh1bWFub2lkUm9vdFBhcnQMV2FpdEZvckNoaWxkBXBhaXJzDkdldERlc2NlbmRhbnRzClBvaW50TGlnaHQDSXNBCVNwb3RMaWdodAZDb2xvcjMHZnJvbVJHQgVDb2xvcgROb3NlCFJvb3RQYXJ0BHJvb3QKQXR0YWNobWVudAV0b3Jzbw5GaW5kRmlyc3RDaGlsZAVjaGVzdARoZWFkBkNGcmFtZQNuZXcGQW5nbGVzBlBhcmVudAZTaGFkb3cEd2Fybj5bSG9sbHlKb2xseV0gTm9zZSBwYXJ0IG5vdCBmb3VuZCAtIHNraXBwaW5nIG5vc2UgY3VzdG9taXphdGlvbglBcHBseVNraW4EZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlC0hvbGx5IEpvbGx5BE5hbWUFUnVkaWUJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QJQ2hyaXN0bWFzC0hvbGlkYXlTa2luHHJieGFzc2V0aWQ6Ly8xMjY1NzEzNzUwNTkwODgDUnVuHHJieGFzc2V0aWQ6Ly8xMDMzNTMzNzc4NzA3MDUEV2FsaxtyYnhhc3NldGlkOi8vODQ5MjM5NTE1MTc4MjAESWRsZRxyYnhhc3NldGlkOi8vMTEyNzE5NjY5NTM3ODYyBVF1aXJrG3JieGFzc2V0aWQ6Ly85ODQ5MDgyNzIzNzMzNgZEZWNvZGUbcmJ4YXNzZXRpZDovLzc3NjkyODI5MjM4Nzg4B0FiaWxpdHkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vOTY1MTYwOTM2NDU1OTQGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMTkzODcwNDk5NTIzNTcFQmxpbmsbcmJ4YXNzZXRpZDovLzgwMzA3MzQ3MzkxNTA5BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIRAgEAAAcEAAAFAgcHlQGkAgEAAAAAQPsDAABNAwOgAgAAAE0DAxkDAAAAnwICArwDAvEEAAAAnwMCAisDAQCCAAEAbwUFALwDANMGAAAAnwMDAqQECAAAAHBAvAUDRwkAAACfBQIAnwQABBcEEgBvCwoAvAkI/gsAAACfCQMCKwkFAG8LDAC8CQj+CwAAAJ8JAwIOCQgApAkPAAA40ICMCtUAjAsnAIwMJQCfCQQCMAkIpBAAAABuBO3/AgAAAG8GEQCMBwUAvAQA0wYAAACfBAQCbwcSALwFANMGAAAAnwUDAm8HEwC8BQXTBgAAAJ8FAwIOBFYA/wYAAAAAAACkBwgAAABwQLwIBEcJAAAAnwgCAJ8HAAQXBxUAbw4KALwMC/4LAAAAnwwDAisMBQBvDgwAvAwL/gsAAACfDAMCDgwLAKQMDwAAONCAjA3VAIwOJwCMDyUAnwwEAjAMC6QQAAAAHA0GAJUMDRRqCwYMbgfq/wIAAABvCRUAjAoDALwHBNMGAAAAnwcEAlIIBQAOCAQAbwoWALwIBQMXAAAAnwgDAlIJCAAOCQQAbwsYALwJCAMXAAAAnwkDAlIKCQAOCgQAbwwZALwKCQMXAAAAnwoDAg4HEwAOChIApAwcAABsoIGMDf//bw4dAIwPAACfDAQCpA0fAAB4oIFvDiAAjA8AAIwQAACfDQQCCQsMDTALB4UaAAAAMAoHJCEAAACCAAEApAsIAAAAcEBSDAYAnwsCBBcLAwCpEAAAMBAPASIAAABuC/z/AgAAAIIAAQCkBiQAAAAwQm8HJQCfBgIBggABACYDAQQAAABAAwIDAwMEAwUDBgMHBAAAcEADCAMJAwoDCwMMAw0EADjQgAMOAw8DEAMRAgAAAAAAAPA/AxIDEwMUAxUDFgMXAxgEAGyggQIzMzMzMzP7vwMZBAB4oIECGC1EVPsh+b8DGgMbAxwEAAAwQgMdACAeARgAAAAAAAAAAAIAAAABAwAAAAIAAAAAAAABAAAAAAAAAAAAAQAAAAAAAAD+AAYAAAAAAQAAAAAAAAACAQABAAAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAQAA/QAGAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAEAAQAAAAAAAAAAAAAAAAAAAQAAAgAAAAABAAD/AAAFAAAAAyIAAAAABAAAAQIASaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQUAAAAAAG8CBAAwAgG6BQAAAG8CBgAwAgGHBwAAAG8CCAAwAgHiCQAAAKkCAAAwAgE8CgAAAIwCWAIwAgEjCwAAAKkCAQAwAgGtDAAAAKkCAQAwAgG8DQAAAP8CBAAAAAAAbwMOADADAhYPAAAAbwMQADADAp8RAAAAbwMSADADApITAAAAbwMUADADAngVAAAAbwMWADADAu4XAAAAbwMYADADAvQZAAAAMAIB6RoAAAD/AgMAAAAAAG8DGwAwAwIQHAAAAG8DHQAwAwKZHgAAAG8DHwAwAwLFIAAAADACASEhAAAAqQIBADACAcIiAAAAwAIjABIAAAAwAgHpJAAAAIIBAgAlAx8EAAAAQAMgAyEDIgMjAyQDJQMmAycDKAMpAyoDKwMsAy0DLgMvAzADMQMyAzMDNAM1AzYDNwM4AzkDOgM7AzwDPQM+Az8DQAYAAx4BAAEAARgAAAAAAAAAAQACAAABAAABAAABAAACAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAAtAQAAAAABWCA9nahPqJkZPaLPz4keOig4Kulq5Fec

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Holly Jolly",
	TowerName = "Rudie",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://126571375059088",
		Walk = "rbxassetid://103353377870705",
		Idle = "rbxassetid://84923951517820",
		Quirk = "rbxassetid://112719669537862",
		Decode = "rbxassetid://98490827237336",
		Ability = "rbxassetid://77692829238788"
	},
	FaceTextures = {
		Normal = "rbxassetid://96516093645594",
		Blink = "rbxassetid://119387049952357",
		Hurt = "rbxassetid://80307347391509"
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
			warn("[HollyJolly] Nose part not found - skipping nose customization")

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