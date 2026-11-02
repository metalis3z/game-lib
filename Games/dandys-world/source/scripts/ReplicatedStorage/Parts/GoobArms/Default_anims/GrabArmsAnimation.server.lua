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
-- CQMLBnNjcmlwdAl3b3Jrc3BhY2UOSXNEZXNjZW5kYW50T2YHQWJpbGl0eQxXYWl0Rm9yQ2hpbGQGUGFyZW50E0FuaW1hdGlvbkNvbnRyb2xsZXIIQW5pbWF0b3INTG9hZEFuaW1hdGlvbgtBZGp1c3RTcGVlZARQbGF5AAEGAAABAgAoowAAAKQAAQAAAABApAIDAAAAIEC8AACtBAAAAJ8AAwIrAAEAggABAKQAAQAAAABAbwIFALwAANMGAAAAnwADAqQBAQAAAABATQEBJAcAAABvAwgAvAEB0wYAAACfAQMCbwMJALwBAdMGAAAAnwEDAlIEAAC8AgGUCgAAAJ8CAwKMBQIAvAMC3wsAAACfAwMBvAMC7gwAAACfAwIBggABAA0DAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAMJAwoDCwABAAEYAAEAAAAAAAAAAAIAAAAAAAEAAAAAAAAAAAAAAAIAAAABAAAAAQAAAgEAAAAAANq0s/51f2GGetb8DQ/Dnr2qrKSK6HDZ/w==

-- https://lua.expert/
if script:IsDescendantOf(workspace) then
	local Ability = script:WaitForChild("Ability")
	local v1 = script.Parent:WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(Ability)

	v1:AdjustSpeed(2)
	v1:Play()
end