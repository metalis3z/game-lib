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
-- CQMlB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnCkdldFNlcnZpY2UPVHdpc3RlZCBCb2JldHRlBE5hbWUNTWFpbkNoYXJhY3RlcgZSYXJpdHkHSG9saWRheQlDaHJpc3RtYXMccmJ4YXNzZXRpZDovLzEyNTM0MTg1NjIzODc5OARJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bhlMb3N0SW50ZXJlc3RBbmltYXRpb25UaW1lBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3IMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly84NjQxNTkxMjg4NzQ5Mw1Ob3JtYWxUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDY4MDgwNTA3MjUxNzcNQXR0YWNrVGV4dHVyZRtyYnhhc3NldGlkOi8vNzQ5MTgzOTU4MjUyMDEAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAKQUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAASoAAAAABAAAAQIAR6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQYAAAAAAG8CBAAwAgG6BQAAAG8CBgAwAgHyBwAAAKkCAQAwAgHuCAAAAKkCAQAwAgGtCQAAAG8CCgAwAgGuCwAAAIwCUAAwAgGLDAAAAIwCKAAwAgFDDQAAAIwCCAAwAgGODgAAAIwCGQAwAgFDDwAAAG8CEAAwAgHbEQAAAIwCtAAwAgFYEgAAAIwCAQAwAgEPEwAAAG8CFAAwAgHcFQAAAG8CFgAwAgEBFwAAAIwCBAAwAgGwGAAAAIwCBgAwAgFXGQAAAG8CEAAwAgFCGgAAAOICHgDiAyUAMAMC2R0AAAAwAgH4JgAAAMACJwASAAEAMAIBkCgAAACCAQIAKQMCBAAAAEADAwMJAwoDCwMMAw0DDgMPAxADEQMSAxMDFAMVAgAAAAAAAARAAxYDFwMYAs3MzMzMzPw/AxkCAAAAAAAA4D8DGgMbAxwDHQMeAx8DCAgCGxwAAAAd/////wMgAyEDIgMjAyQDJQgDHyAAAAAhIgAAACMkAAAAAwcGAAMFAQABAAEYAAAAAAAAAAIAAwAAAQAAAwAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAwAAAgIAAP4ACQAAAAUBAAAAAAEH8b1JATzkDV5nu+Ek4iI7d+mqPTU110g=

-- https://lua.expert/
game:GetService("ReplicatedStorage")

local t = {
	Name = "Twisted Bobette",
	Rarity = "MainCharacter",
	Holiday = true,
	Christmas = true,
	Icon = "rbxassetid://125341856238798",
	VisionRadius = 80,
	InstantRadius = 40,
	WalkSpeed = 8,
	RunSpeed = 25,
	InterestTime = 2.5,
	HearingRadius = 180,
	Damage = 1,
	WaitTime = 1.8,
	LineOfSight = 0.5,
	KillRadius = 4,
	HitCooldown = 6,
	LostInterestAnimationTime = 2.5,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://86415912887493",
			NormalTexture = "rbxassetid://106808050725177",
			AttackTexture = "rbxassetid://74918395825201"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 41 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t