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
-- CQMOBkNyZWF0ZQRQbGF5CXBsYXlUd2Vlbg5zdGFydF9Qb3NpdGlvbghQb3NpdGlvbgxTZXRBdHRyaWJ1dGUKc3RhcnRfU2l6ZQRTaXplDnN0YXJ0X1JvdGF0aW9uCFJvdGF0aW9uDHNhdmVJbml0aWFscwRnYW1lDFR3ZWVuU2VydmljZQpHZXRTZXJ2aWNlAAMIAwEAAAAL+wMAAFIFAABSBgEAUgcCALwDA5YAAAAAnwMFArwEA+4BAAAAnwQCAYIDAgACAwEDAgAIAwEYAAAAAAAAAAEAAAEJAAAAAAUBAAAAABNvAwAATQQAOwEAAAC8AQAuAgAAAJ8BBAFvAwMATQQALwQAAAC8AQAuAgAAAJ8BBAFvAwUATQQAOAYAAAC8AQAuAgAAAJ8BBAGCAAEABwMEAwUDBgMHAwgDCQMKAA4LARgAAAAAAAABAAAAAAABAAAAAAABDwAAAAADAAABAgARowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BAgAAAAAAwAIEABIAAAAwAgFABQAAAMACBgAwAgFiBwAAAIIBAgAIAwwEAAAAQAMNAw4GAAMDBgEDCwIAAQEAARgAAwAAAAAAAgACAAAABgAABgEAAAAAAg3ohWX3j0pMTmN/1f4/LSR98JIRPyzvZA==

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

return {
	playTween = function(p1, p2, p3) --[[ playTween | Line: 8 | Upvalues: TweenService (copy) ]]
		local v1 = TweenService:Create(p1, p2, p3)

		v1:Play()

		return v1
	end,
	saveInitials = function(p1) --[[ saveInitials | Line: 14 ]]
		p1:SetAttribute("start_Position", p1.Position)
		p1:SetAttribute("start_Size", p1.Size)
		p1:SetAttribute("start_Rotation", p1.Rotation)
	end
}