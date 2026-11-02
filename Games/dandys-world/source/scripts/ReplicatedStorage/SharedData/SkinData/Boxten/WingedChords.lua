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
-- CQMmCUFwcGx5U2tpbg1XaW5nZWQgQ2hvcmRzBE5hbWUGQm94dGVuCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzIHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEyMzA4ODQzMTMyMjc2OANSdW4ccmJ4YXNzZXRpZDovLzEyMzE0MTkxMjA4MjM0NARXYWxrG3JieGFzc2V0aWQ6Ly85NTcyNzMxOTQyMzA5MwRJZGxlHHJieGFzc2V0aWQ6Ly8xMDM3NzYwOTUxNDIwOTkGRGVjb2RlHHJieGFzc2V0aWQ6Ly8xMDkzOTAyNzkxMTI4MjYFUXVpcmsTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vOTc5NDQwOTI2NjI0NjUGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMTc2Mjk0MDc1NjE0NzIFQmxpbmsbcmJ4YXNzZXRpZDovLzg0NzU3MzA2NTk3MzU3BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIBAQAAAAABggABAAAAIAEBGAAkAAAAAAUAAAECAFCjAAAA/wAFAAAAAABvAQAAMAEAugEAAABvAQIAMAEAhwMAAABvAQQAMAEA4gUAAACpAQAAMAEAPAYAAACMAVgCMAEAIwcAAACkAQkAAACAQKQCCwAAAKBAbwQMALwCAhYNAAAAnwIDAk0CAmQOAAAATQICCg8AAACfAQICTQEB/BAAAAAwAQBREQAAAKkBAQAwAQAREgAAAKkBAQAwAQC8EwAAAP8BBAAAAAAAbwIUADACARYVAAAAbwIWADACAZ8XAAAAbwIYADACAZIZAAAAbwIaADACAe4bAAAAbwIcADACAXgdAAAAMAEA6R4AAAD/AQMAAAAAAG8CHwAwAgEQIAAAAG8CIQAwAgGZIgAAAG8CIwAwAgHFJAAAADABACElAAAAqQEBADABAMImAAAAwAEnADABAOkoAAAAggACACkDAgMDAwQDBQMGAwcDCAMJAwoEAACAQAMLBAAAoEADDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYGAAMBAQABAAEYAAEAAgAAAQAAAQAAAQAAAgAAAQAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAPsACAABAAABAAABAAD9AAYAAAIAAAYBAAAAAAGtEFpD0mmwCWhLngpli8Vu3QhNN5/UMEI=

-- https://lua.expert/
return {
	Name = "Winged Chords",
	TowerName = "Boxten",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W2,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://123088431322768",
		Walk = "rbxassetid://123141912082344",
		Idle = "rbxassetid://95727319423093",
		Decode = "rbxassetid://103776095142099",
		Quirk = "rbxassetid://109390279112826"
	},
	FaceTextures = {
		Normal = "rbxassetid://97944092662465",
		Blink = "rbxassetid://117629407561472",
		Hurt = "rbxassetid://84757306597357"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 32 ]] end
}