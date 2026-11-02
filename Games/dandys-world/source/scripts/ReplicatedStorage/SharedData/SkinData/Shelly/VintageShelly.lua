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
-- CQMkBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4ESGVhZAxXYWl0Rm9yQ2hpbGQKQXR0YWNobWVudA9QYXJ0aWNsZUVtaXR0ZXIERW1pdApVc2VBYmlsaXR5DlZpbnRhZ2UgU2hlbGx5BE5hbWUHTWFzdGVyeRtyYnhhc3NldGlkOi8vNzMwMjAxOTMxMTkzMzYEV2FsaxxyYnhhc3NldGlkOi8vMTAwODQ5MzQ1MjEzNDQ3BElkbGUccmJ4YXNzZXRpZDovLzExMjUzMDE5NDYxMjUxOQdBYmlsaXR5G3JieGFzc2V0aWQ6Ly83NzA1NzQzNTM5ODkwNgNSdW4ccmJ4YXNzZXRpZDovLzEzNDU2ODUzNTAwNTUwMQVRdWlyaxxyYnhhc3NldGlkOi8vMTI1MjMxNTQ5Nzg2Nzg5BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly85ODIxNjk0Nzk0MjYxNBxyYnhhc3NldGlkOi8vMTE2NTgwMzM4MzcwNDEwBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTE3NTMwMzUyNTgxMjgESHVydA5VU0VfU0tJTl9NT0RFTAADCQEBAAAAFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwAXCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhkAAAAABwEAAAAAEW8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIB0wEAAACfAgMCbwUDALwDAtMBAAAAnwMDAowGAgC8BANWBAAAAJ8EAwGCAAEABQMJAwoDCwMMAw0AIQ4BGAAAAAABAAAAAQAAAAEAAAABIgAAAAADAAABAgA3owAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEEAAAAAABvAgMAMAIBnwQAAABvAgUAMAIBkgYAAABvAgcAMAIB9AgAAABvAgkAMAIBFgoAAABvAgsAMAIBeAwAAABvAg0AMAIB7g4AAAAwAQDpDwAAAP8BAwAAAAAAbwIQADACARARAAAAbwISADACAZkTAAAAbwIUADACAcUVAAAAMAEAIRYAAACpAQAAMAEAwhcAAADAARgAEgAAADABAOkZAAAAwAEaADABALIbAAAAggACABwDDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAwYDIAMhAyIDIwMFAyQGAAMIBgEDDgIAAQEAARgAAAACAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAAKAAAHAQAAAAAC13W7sZr406H/sRJ/WZFktadtrMXlsdGw

-- https://lua.expert/
local t = {
	Name = "Vintage Shelly",
	Mastery = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://73020193119336",
		Idle = "rbxassetid://100849345213447",
		Ability = "rbxassetid://112530194612519",
		Run = "rbxassetid://77057435398906",
		Quirk = "rbxassetid://134568535005501",
		Decode = "rbxassetid://125231549786789"
	},
	FaceTextures = {
		Normal = "rbxassetid://98216947942614",
		Blink = "rbxassetid://116580338370410",
		Hurt = "rbxassetid://111753035258128"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 23 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end
function t.UseAbility(p1) --[[ UseAbility | Line: 33 ]]
	p1:WaitForChild("Head"):WaitForChild("Attachment"):WaitForChild("ParticleEmitter"):Emit(2)
end

return t