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
-- CQNDBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAtCYXJuYWJ5X0dlbwxXYWl0Rm9yQ2hpbGQOQmFybmFieVRleHR1cmUESGVhZAhQYXJ0aWNsZQ9QYXJ0aWNsZUVtaXR0ZXINQ29sb3JTZXF1ZW5jZQNuZXcVQ29sb3JTZXF1ZW5jZUtleXBvaW50BkNvbG9yMwVDb2xvcglBcHBseVNraW4EU2l6ZQFZCUhpcEhlaWdodAVQYXJ0cw9GaW5uSWNob3JTcGxhc2gLSWNob3JTcGxhc2gFQ2xvbmUJVHdlZW5JbmZvBEVudW0LRWFzaW5nU3R5bGUEUXVhZA9FYXNpbmdEaXJlY3Rpb24CSW4DT3V0B2Zyb21SR0IJd29ya3NwYWNlBlBhcmVudAhBbmNob3JlZApDYW5Db2xsaWRlCENhblF1ZXJ5CkNhc3RTaGFkb3cIQ2FuVG91Y2gLUHJpbWFyeVBhcnQIUG9zaXRpb24HVmVjdG9yMwZTcGxhc2gEUGxheQdBZGRJdGVtDFRyYW5zcGFyZW5jeQZDRnJhbWUGQW5nbGVzBkNyZWF0ZQpVc2VBYmlsaXR5DFZpbnRhZ2UgRmlubgROYW1lB01hc3RlcnkEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDFR3ZWVuU2VydmljZQZEZWJyaXMTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTMwNjgyODk4NTM3NDk2BUJsaW5rG3JieGFzc2V0aWQ6Ly84MzAwMTM1MTIyNTQ3OARIdXJ0G3JieGFzc2V0aWQ6Ly83OTIwODczMzA2NjQxORtyYnhhc3NldGlkOi8vODI0NDIxMjQyNTg0NjUAAwsBAQAABgMAAAUBB0KkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAABvAwgAvAEA0wkAAACfAQMC+wIAAE0CAoAKAAAAMAIBhAcAAABNAQATCwAAAE0BATYMAAAATQEBow0AAACkAhAAADzggP8DAAACAAAApAQSAAA8EIGMBQAApAYUAAA8MIGM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

-- https://lua.expert/
local t = {
	Name = "Vintage Finn",
	Mastery = true
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

t.OverwriteAnimations = {}
t.FaceTextures = {
	Blink = "rbxassetid://130682898537496",
	Hurt = "rbxassetid://83001351225478",
	Normal = "rbxassetid://79208733066419"
}
t.BarnabyTexture = "rbxassetid://82442124258465"
function t.ApplySkin(p1) --[[ ApplySkin | Line: 21 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end

	p1:WaitForChild("Barnaby_Geo").TextureID = t.BarnabyTexture
	p1.Head.Particle.ParticleEmitter.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0/255, 0/255, 0/255)), ColorSequenceKeypoint.new(1, Color3.new(0/255, 0/255, 0/255)) })
end
function t.UseAbility(p1, p2, p3, p4) --[[ UseAbility | Line: 37 | Upvalues: ReplicatedStorage (copy), Debris (copy), TweenService (copy) ]]
	local v1 = p3.Size.Y / 2 + p2.HipHeight
	local Parts = ReplicatedStorage:WaitForChild("Parts")
	local v2 = Parts.FinnIchorSplash.IchorSplash:Clone()

	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	v2.Color = Color3.fromRGB(0, 0, 0)
	v2.Parent = workspace
	v2.Anchored = true
	v2.CanCollide = false
	v2.CanQuery = false
	v2.CastShadow = false
	v2.CanTouch = false
	v2.Size = Vector3.new(0, 0.25, 0)
	v2.Position = p1.PrimaryPart.Position + Vector3.new(0, -v1 + 0.125, 0)
	v2.Splash:Play()
	Debris:AddItem(v2, 5)
	TweenService:Create(v2, v3, {
		Size = Vector3.new(20, 0.25, 20),
		Transparency = 1,
		CFrame = v2.CFrame * CFrame.new(0, 0.25, 0) * CFrame.Angles(0, 2.7401669256310974, 0),
		Color = Color3.fromRGB(172, 172, 172)
	}):Play()

	local v4 = Parts.FinnIchorSplash.IchorSplash:Clone()

	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false)

	local v5 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false)

	v4.Color = Color3.fromRGB(180, 180, 180)
	v4.Parent = workspace
	v4.Anchored = true
	v4.CanCollide = false
	v4.CanQuery = false
	v4.CastShadow = false
	v4.CanTouch = false
	v4.Size = Vector3.new(0, 0.25, 0)
	v4.Position = p1.PrimaryPart.Position + Vector3.new(0, -v1, 0)
	Debris:AddItem(v4, 5)
	TweenService:Create(v4, v5, {
		Size = Vector3.new(12, 0.25, 12),
		Transparency = 1,
		CFrame = v4.CFrame * CFrame.new(0, 0.25, 0) * CFrame.Angles(0, 2.7401669256310974, 0),
		Color = Color3.fromRGB(172, 172, 172)
	}):Play()
end

return t