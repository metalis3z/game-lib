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
-- CQMIBHRhc2sFZGVmZXIERmlyZQ5HZXRQYXJ0c0luUGFydAZzY3JpcHQGUGFyZW50BlJlc3VsdBVCaW5kVG9NZXNzYWdlUGFyYWxsZWwAAgoDAQAACAUAAAUDDwcHDaQDAgAABACA+wQAAE0EBN0DAAAA+wUAAFIIAgBSCQEAvAYAtQQAAACfBgQAnwMAAYIAAQAFAwEDAgQABACAAwMDBAAHAAEYAAAAAAAAAAAAAAAAAQgAAAAABgAAAQIADqMAAACkAAEAAAAAQE0AACQCAAAATQEADgMAAABvBAQAwAUFABIAAQC8AgBaBgAAAJ8CBAGCAAEABwMFBAAAAEADBgMHAwQGAAMIAQABAAEYAAEAAAABAAQAAAAAAAMBAAAAAAHjLY9z12tzKuwaWy7pFnwvkzWYB9Hp5XI=

-- https://lua.expert/
local v1 = script.Parent
local Result = v1.Result

v1:BindToMessageParallel("GetPartsInPart", function(p1, p2, p3) --[[ Line: 7 | Upvalues: Result (copy) ]]
	task.defer(Result.Fire, Result, p1:GetPartsInPart(p3, p2))
end)