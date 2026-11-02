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
-- CQMjCUFwcGx5U2tpbhlTaG93LVRpbWUgUmF6emxlICYgRGF6emxlBE5hbWUccmJ4YXNzZXRpZDovLzEzNDcxNDY2NTQ2OTkzMwpEYXp6bGVfUnVuHHJieGFzc2V0aWQ6Ly8xMDk3NTM2MDI3ODUwNjMLRGF6emxlX1dhbGsccmJ4YXNzZXRpZDovLzEyMzEwMTYyNjg0Nzk1NQRJZGxlG3JieGFzc2V0aWQ6Ly83NzU5NzE5OTk1MDc4NwxSYXp6bGVfUXVpcmsccmJ4YXNzZXRpZDovLzExMjgzNDQxNTIzMjEwNwlMb2JieV9ydW4ccmJ4YXNzZXRpZDovLzEwNjcyNjE4NTEyMzUzMgxEYXp6bGVfUXVpcmsccmJ4YXNzZXRpZDovLzEyODcwODgyNTYyNzQwOQpMb2JieV93YWxrHHJieGFzc2V0aWQ6Ly8xMDU4MTY5MjY1MDE1NTUNUmF6emxlX0RlY29kZRxyYnhhc3NldGlkOi8vMTE3MDkzNDcyNDA4MDA0DURhenpsZV9EZWNvZGUccmJ4YXNzZXRpZDovLzEzMTAwODYxMDg4NDQyOQpSYXp6bGVfUnVuHHJieGFzc2V0aWQ6Ly8xMzkyODQ0NDk2NzY2NTULUmF6emxlX1dhbGsGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzExMjgwMDkwNjU0ODI4NwVCbGluaxxyYnhhc3NldGlkOi8vMTI5NjY0MDk3MDQwNzAzBEh1cnQccmJ4YXNzZXRpZDovLzEzOTQzMzIwNjcxNDQ3MAZOb3JtYWwMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIBAQAAAAYDAAAFAQcBggABAAAAHwEBGAAjAAAAAAMAAAECAEKjAAAA/wAEAAAAAABvAQAAMAEAugEAAAD/AQUAAAAAAG8CAgAwAgFJAwAAAG8CBAAwAgFdBQAAAG8CBgAwAgGSBwAAAG8CCAAwAgGaCQAAAG8CCgAwAgExCwAAAG8CDAAwAgGoDQAAAG8CDgAwAgHsDwAAAG8CEAAwAgFgEQAAAG8CEgAwAgGSEwAAAG8CFAAwAgFbFQAAAG8CFgAwAgErFwAAAG8CEgAwAgHuGAAAADABAOkZAAAA/wEDAAAAAABvAhoAMAIBmRsAAABvAhwAMAIBxR0AAABvAh4AMAIBEB8AAAAwAQAhIAAAAKkBAQAwAQDCIQAAAMABIgAwAQDpIwAAAIIAAgAkAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMGAAMBAQABAAEYAAAAAgAABQABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAD0AA8AAQAAAQAAAQAA/QAGAAACAAAGAQAAAAABnS12kZj0XFulIiFJVeSIt+01YeWv6RyQ

-- https://lua.expert/
return {
	Name = "Show-Time Razzle & Dazzle",
	OverwriteAnimations = {
		Dazzle_Run = "rbxassetid://134714665469933",
		Dazzle_Walk = "rbxassetid://109753602785063",
		Idle = "rbxassetid://123101626847955",
		Razzle_Quirk = "rbxassetid://77597199950787",
		Lobby_run = "rbxassetid://112834415232107",
		Dazzle_Quirk = "rbxassetid://106726185123532",
		Lobby_walk = "rbxassetid://128708825627409",
		Razzle_Decode = "rbxassetid://105816926501555",
		Dazzle_Decode = "rbxassetid://117093472408004",
		Razzle_Run = "rbxassetid://131008610884429",
		Razzle_Walk = "rbxassetid://139284449676655",
		Decode = "rbxassetid://117093472408004"
	},
	FaceTextures = {
		Blink = "rbxassetid://112800906548287",
		Hurt = "rbxassetid://129664097040703",
		Normal = "rbxassetid://139433206714470"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}