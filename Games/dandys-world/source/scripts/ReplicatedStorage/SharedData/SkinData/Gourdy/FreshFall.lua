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
-- CQNKCUFwcGx5U2tpbghIdW1hbm9pZAxXYWl0Rm9yQ2hpbGQQSHVtYW5vaWRSb290UGFydARTaXplAVkJSGlwSGVpZ2h0BVBhcnRzCWdvdXJkeUFPRQ5GaW5kRmlyc3RDaGlsZAR3YXJuM2dvdXJkeUFPRSBtZXNoIG5vdCBmb3VuZCBpbiBSZXBsaWNhdGVkU3RvcmFnZS5QYXJ0cwVDbG9uZQl3b3Jrc3BhY2UGUGFyZW50CEFuY2hvcmVkCkNhbkNvbGxpZGUIQ2FuUXVlcnkKQ2FzdFNoYWRvdwhDYW5Ub3VjaAZDb2xvcjMHZnJvbVJHQgVDb2xvcgxUcmFuc3BhcmVuY3kGQ0ZyYW1lA25ldwhQb3NpdGlvbgdWZWN0b3IzB1Bpdm90VG8JVHdlZW5JbmZvBEVudW0LRWFzaW5nU3R5bGUFQ3ViaWMGQW5nbGVzBkNyZWF0ZQRQbGF5B0FkZEl0ZW0KVXNlQWJpbGl0eQRnYW1lBkRlYnJpcwpHZXRTZXJ2aWNlEVJlcGxpY2F0ZWRTdG9yYWdlDFR3ZWVuU2VydmljZQpGcmVzaCBGYWxsBE5hbWUGR291cmR5CVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0CUhhbGxvd2VlbgtIb2xpZGF5U2tpbhtyYnhhc3NldGlkOi8vNzI3MTk5MTc3NzAwOTADUnVuG3JieGFzc2V0aWQ6Ly85OTQ2NTc4MDIzMTUxOQRXYWxrHHJieGFzc2V0aWQ6Ly8xMzk5Njk5OTQyOTUwMzIESWRsZRtyYnhhc3NldGlkOi8vOTk4NDAzMTc1NzAxOTIFUXVpcmsccmJ4YXNzZXRpZDovLzExNzA0MDAwNjEyNDkyNQdBYmlsaXR5HHJieGFzc2V0aWQ6Ly8xMTIxMTc1ODQ2MjYxMjcGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzg2Mjc1NDQ0NDcyODU4Bk5vcm1hbBxyYnhhc3NldGlkOi8vMTIxMDU1NTMwODM0ODIzBUJsaW5rG3JieGFzc2V0aWQ6Ly85MTg0MTA3MzI2MDg3MwRIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAADAQEAAAAGAwAABQEHAYIAAQAAACIBARgAJgAAAAAPAQMAAAoDAAEFAQcICUoBc28DAAC8AQDTAQAAAJ8BAwJvBAIAvAIA0wEAAACfAgMCTQUCLwQAAABNBQV4BQAAAD4EBQNNBQEXBgAAAEMDBAX7BAAATQQELwcAAABvBggAvAQEAwkAAACfBAMCKwQFAKQFCwAAAKBAbwYMAJ8FAgGCAAEAvAUEOg0AAACfBQICpAYPAAAA4EAwBgUkEAAAAKkGAQAwBgVFEQAAAKkGAAAwBgXTEgAAAKkGAAAwBgViEwAAAKkGAAAwBgU+FAAAAKkGAAAwBgX2FQAAAKQGGAAAXGCBjAekAIwI1ACMCYYAnwYEAjAGBaQZAAAAbwYaADAGBdkbAAAApAYeAAB0wIFNCAI7HwAAAIwKAAA5DAMAlQsMGowMAABMNgACpAkhAAB0AIKfCQQCQwcICZ8GAgJSCQYAvAcFwiIAAACfBwMBpAckAAB0MIJvCCUApAkpACicYMKfBwMC4ggsAE0KBYUcAAAApAsuAAC0wIGMDAAAbw0vAIwOAACfCwQCCQkKCzAJCIUcAAAA+wkBAFILBQBSDAcAUg0IALwJCZYwAAAAnwkFArwKCe4xAAAAnwoCAfsKAgBSDAUAjA0DALwKCngyAAAAnwoEAYIAAQAzAwIDAwMEAgAAAAAAAABAAwUDBgMHAwgDCQMKAwsEAACgQAMMAw0DDgQAAOBAAw8DEAMRAxIDEwMUAxUDFgQAXGCBAxcCmpmZmZmZyT8DGAMZAxoEAHTAgQMbAxwEAHQAggMdAx4EAHQwggJI4XoUrkf1PwMfAyADIQQonGDCB/YomkEAAIA+xaCgQQAAAAACAAAAAAAA8D8IAwQqAAAAGysAAAAc/////wMiBAC0wIECGC1EVPsh6b8DIwMkAyUAKCYBGAAAAAABAAAAAQAAAAAAAAADAAAAAAAAAQEAAAABAwAAAQAAAAEAAAEAAAEAAAEAAAEAAAMAAAAAAAAAAQAAAwAAAAAAAAAAAAAAAAABAAAABgABAQD+BgMAAAAAAAAAAAAABAAAAAAAAAEAAAMAAAAAAAEqAAAAAAYAAAECAFqjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAUAvAICFgMAAACfAgMC/wMFAAAAAABvBAYAMAQDugcAAABvBAgAMAQDhwkAAABvBAoAMAQD4gsAAACpBAAAMAQDPAwAAACMBFgCMAQDIw0AAACpBAEAMAQDaQ4AAACpBAEAMAQDvA8AAAD/BAQAAAAAAG8FEAAwBQQWEQAAAG8FEgAwBQSfEwAAAG8FFAAwBQSSFQAAAG8FFgAwBQR4FwAAAG8FGAAwBQT0GQAAAG8FGgAwBQTuGwAAADAEA+kcAAAA/wQDAAAAAABvBR0AMAUEEB4AAABvBR8AMAUEmSAAAABvBSEAMAUExSIAAAAwBAMhIwAAAKkEAQAwBAPCJAAAAMAEJQAwBAPpJgAAAMAEJwASAAEAEgACABIAAAAwBAOyKAAAAIIDAgApAycEAAAAQAMoAykDKgMrAywDLQMuAy8DMAMxAzIDMwM0AzUDNgM3AzgDOQM6AzsDPAM9Az4DPwNAA0EDQgNDA0QDRQNGA0cDSANJA0oGAAMBBgEDJgIAAQEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAQACAAABAAABAAABAAACAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAYAAAAAADUBAAAAAALTV2zJfuZW85QDN42e34c8o097veGTBsg=

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

return {
	Name = "Fresh Fall",
	TowerName = "Gourdy",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://72719917770090",
		Walk = "rbxassetid://99465780231519",
		Idle = "rbxassetid://139969994295032",
		Quirk = "rbxassetid://99840317570192",
		Ability = "rbxassetid://117040006124925",
		Decode = "rbxassetid://112117584626127"
	},
	FaceTextures = {
		Normal = "rbxassetid://86275444472858",
		Blink = "rbxassetid://121055530834823",
		Hurt = "rbxassetid://91841073260873"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 34 ]] end,
	UseAbility = function(p1) --[[ UseAbility | Line: 40 | Upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")
		local v1 = HumanoidRootPart.Size.Y / 2 + Humanoid.HipHeight
		local gourdyAOE = ReplicatedStorage.Parts:FindFirstChild("gourdyAOE")

		if gourdyAOE then
			local v2 = gourdyAOE:Clone()

			v2.Parent = workspace
			v2.Anchored = true
			v2.CanCollide = false
			v2.CanQuery = false
			v2.CastShadow = false
			v2.CanTouch = false
			v2.Color = Color3.fromRGB(164, 212, 134)
			v2.Transparency = 0.2
			v2:PivotTo((CFrame.new(HumanoidRootPart.Position + Vector3.new(0, -v1 + 0.2, 0))))
			TweenService:Create(v2, TweenInfo.new(1.33, Enum.EasingStyle.Cubic), {
				Size = Vector3.new(19.27, 0.25, 20.0785),
				Transparency = 1,
				CFrame = v2.CFrame * CFrame.Angles(0, -0.7853981633974483, 0)
			}):Play()
			Debris:AddItem(v2, 3)
		else
			warn("gourdyAOE mesh not found in ReplicatedStorage.Parts")
		end
	end
}