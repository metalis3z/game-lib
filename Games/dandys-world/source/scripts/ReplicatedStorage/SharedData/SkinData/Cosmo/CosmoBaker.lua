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
-- CQM+CUFwcGx5U2tpbghQb3NpdGlvbghwYXJhYm9sYQVjaGFzZQdyZXF1aXJlBVBhcnRzDVJlbmRlck1vZHVsZXMLQ29zbW9Db29raWUITW92ZW1lbnQGQ29va2llBUNsb25lB0FkZEl0ZW0Jd29ya3NwYWNlBlBhcmVudAhCYXNlUGFydANJc0EGQ29sb3IzB2Zyb21SR0IFQ29sb3IFVHJhaWwORmluZEZpcnN0Q2hpbGQHRW5hYmxlZA1Db2xvclNlcXVlbmNlA25ldxVDb2xvclNlcXVlbmNlS2V5cG9pbnQJU21va2VQYXJ0DFRyYW5zcGFyZW5jeQlIZWFydFBhcnQERW1pdANFYXQEUGxheQpVc2VBYmlsaXR5D0NhcmFtZWwgRHJpenpsZQROYW1lBENvc3QKRGFuZHlTdG9yZRtyYnhhc3NldGlkOi8vOTU1OTc1NTgzMDU4NDIEV2FsaxtyYnhhc3NldGlkOi8vNzE1ODQ0MDUwMzc3MzADUnVuG3JieGFzc2V0aWQ6Ly83MTcwMTM1OTk1NTI1OQVRdWlyaxtyYnhhc3NldGlkOi8vOTcwOTk1MjQzNDMzMTYESWRsZRxyYnhhc3NldGlkOi8vMTE5Njk5Mzg2NzI4Mjk0BkRlY29kZRtyYnhhc3NldGlkOi8vOTg4NzQ2ODY2MTc1MTUHQWJpbGl0eRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzY0OTU3MjY2OTQxNDYGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMTk5ODI4MTkyNDAzMDgFQmxpbmsbcmJ4YXNzZXRpZDovLzc3NzAxMTYzMTA1MTUzBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQZEZWJyaXMMVHdlZW5TZXJ2aWNlAAQBAQAAAAYDAAAFAQcBggABAAAAGAEBGAAcAAAAAAkAAwAAAA/7AAAATQAAOwAAAAD7AQEA+wICAE0CAkgBAAAA+wMAAFIEAABSBQEAjAYUAIwHGQBvCAIAnwIHAYIAAQADAwIDAwIAAAAAAADgPwBIBAEYAAAAAQUAAAAAAAAAAAABSQAAAAAQBAIAAACwAaQEAQAAAABA+wUAAE0FBS8CAAAATQUFuAMAAABNBQXuBAAAAE0FBVoFAAAAnwQCAvsFAABNBQUvAgAAAE0FBbgDAAAATQUF7gQAAABNBQWWBgAAALwFBToHAAAAnwUCAvsGAQBSCAUAjAkCALwGBngIAAAAnwYEAaQGCgAAAJBAMAYFJAsAAABNBgI7DAAAADAGBTsMAAAAbwgNALwGBf4OAAAAnwYDAg4GCACkBhEAAEDwgIwHzACMCJkAjAlmAJ8GBAIwBgWkEgAAAG8IEwC8BgUDFAAAAJ8GAwIOBiQATQYFuRMAAACpBwEAMAcG8BUAAABNBgW5EwAAAKQHGAAAXGCB/wgAAAIAAACkCRoAAFyQgYwKAACkCxEAAEDwgIwMmQCMDWYAjA4zAJ8LBACfCQACpAoaAABckIGMCwEApAwRAABA8ICMDf8AjA7MAIwPmQCfDAQAnwoAAMUICQABAAAAnwcCAjAHBqQSAAAAbwgbALwGBQMUAAAAnwYDAg4GJABNBgXLGwAAAKkHAQAwBwbwFQAAAE0GBcsbAAAApAcYAABcYIH/CAAAAgAAAKQJGgAAXJCBjAoAAKQLEQAAQPCAjAzMAIwNmQCMDmYAnwsEAJ8JAAKkChoAAFyQgYwLAQCkDBEAAEDwgIwN/wCMDuUAjA/MAJ8MBACfCgAAxQgJAAEAAACfBwICMAcGpBIAAABNBgM7DAAAANkHAAASAAUAEgADABIABABNCAU7DAAAAE0JBEgcAAAAUgoFAFILCABSDAMAjA0UAIwOGQBvDx0AnwkHAQ4FGABNCAXLGwAAAKkJAAAwCQjwFQAAAIwIAQAwCAXZHgAAAE0IBaMfAAAAjAoKALwICFYgAAAAnwgDAW8KIQC8CAUDFAAAAJ8IAwIOCAUATQgF7CEAAAC8CAjuIgAAAJ8IAgGCAAEAIwMFBAAAAEADBgMHAwgDCQMKAwsDDAMNBAAAkEADDgMCAw8DEAMRAxIEAEDwgAMTAxQDFQMWAxcDGAQAXGCBAxkEAFyQgQMaAwMCAAAAAAAA4D8DGwMcAx0DHgMfAQEhIAEYAAAAAAAAAAAAAAAAAwAAAAAAAAAAAAAABAAAAAAAAgAAAAIAAAADAAAAAAEAAAAAAAAABAAAAAABAAAAAAEAAAAAAAEAAAAAAAAAAAABAAAAAAAAAAAAAAD+AAAHAAAAAAEAAAAAAQAAAAAAAQAAAAAAAAAAAAEAAAAAAAAAAAAAAP4AAAYAAgAAAAEABgAAAAAAAAAABQEAAAAAAQAAAQAAAAAAAQAAAAABAAAAAAMiAAAAAAYAAAECAE2jAAAA/wAEAAAAAABvAQAAMAEAugEAAACMAVgCMAEAIwIAAACpAQEAMAEATgMAAAD/AQQAAAAAAG8CBAAwAgGfBQAAAG8CBgAwAgEWBwAAAG8CCAAwAgF4CQAAAG8CCgAwAgGSCwAAAG8CDAAwAgHuDQAAAG8CDgAwAgH0DwAAADABAOkQAAAA/wEDAAAAAABvAhEAMAIBEBIAAABvAhMAMAIBmRQAAABvAhUAMAIBxRYAAAAwAQAhFwAAAKkBAQAwAQDCGAAAAMABGQAwAQDpGgAAAKQBHAAAALBBbwMdALwBARYeAAAAnwEDAqQCHAAAALBBbwQfALwCAhYeAAAAnwIDAqQDHAAAALBBbwUgALwDAxYeAAAAnwMDAsAEIQASAAEAEgACADAEALIiAAAAggACACMDIQMiAyMDJAMlAyYDJwMoAykDKgMrAywDLQMuAy8DMAMxAzIDMwM0AzUDNgM3AzgDOQYAAwEDOgQAALBBAzsDPAM9Az4GAgMgAgACAQABGAAAAAIAAAEAAAEAAAIAAQAAAQAAAQAAAQAAAQAAAQAA+gAJAAEAAAEAAAEAAP0ABgAAAgAABgAAAAAAAQAAAAAAAQAAAAAAAQAAAAA+AQAAAAAD15whKRmwHAawclUUoP8xyKeENl3lWEso

-- https://lua.expert/
local t = {
	Name = "Caramel Drizzle",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://95597558305842",
		Run = "rbxassetid://71584405037730",
		Quirk = "rbxassetid://71701359955259",
		Idle = "rbxassetid://97099524343316",
		Decode = "rbxassetid://119699386728294",
		Ability = "rbxassetid://98874686617515"
	},
	FaceTextures = {
		Normal = "rbxassetid://136495726694146",
		Blink = "rbxassetid://119982819240308",
		Hurt = "rbxassetid://77701163105153"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]] end
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

game:GetService("TweenService")
function t.UseAbility(p1, p2, p3, p4) --[[ UseAbility | Line: 33 | Upvalues: ReplicatedStorage (copy), Debris (copy) ]]
	local Movement = require(ReplicatedStorage.Parts.RenderModules.CosmoCookie.Movement)
	local v1 = ReplicatedStorage.Parts.RenderModules.CosmoCookie.Cookie:Clone()

	Debris:AddItem(v1, 2)
	v1.Parent = workspace
	v1.Position = p3.Position

	if v1:IsA("BasePart") then
		v1.Color = Color3.fromRGB(204, 153, 102)
	end

	if v1:FindFirstChild("Trail") then
		v1.Trail.Enabled = true
		v1.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(153, 102, 51)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 153)) })
	end

	if v1:FindFirstChild("SmokePart") then
		v1.SmokePart.Enabled = true
		v1.SmokePart.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 153, 102)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 229, 204)) })
	end

	local Position = p4.Position

	local function chase() --[[ chase | Line: 72 | Upvalues: v1 (copy), p4 (copy), Movement (copy) ]]
		Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)
	end

	Movement.parabola(v1, v1.Position, p4, 20, 25, 0.5)

	if not v1 then
		return
	end

	v1.SmokePart.Enabled = false
	v1.Transparency = 1
	v1.HeartPart:Emit(10)

	if not v1:FindFirstChild("Eat") then
		return
	end

	v1.Eat:Play()
end

return t