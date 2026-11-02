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
-- CQMWDEFwcGx5VHJpbmtldA1SZW1vdmVUcmlua2V0GlRyaWdnZXJTa2lsbENoZWNrRmFpbEV2ZW50Dk1vbnN0ZXJUcmlua2V0IVRoaXMgdGltZSwgdGhleSBjYW4ndCBoZWFyIHlvdeKApg1HZW5lcmF0b3JUZXh0HHJieGFzc2V0aWQ6Ly8xMDU3ODQ3NTU3MzIyNjkOR2VuZXJhdG9yU291bmQLTWltZSBNYWtldXAETmFtZRtyYnhhc3NldGlkOi8vNzk0NDk3OTIyMjAwMDEESWNvbgRSYXJlBlJhcml0eQRNYWluUFdoZW4gZmFpbGluZyBhIHNraWxsY2hlY2sgdGhlIHVzZXIgd2lsbCBub3QgYWxlcnQgdGhlIFR3aXN0ZWQgdG8gdGhlaXIgbG9jYXRpb24uC0Rlc2NyaXB0aW9uB1Bhc3NpdmULVHJpbmtldFR5cGUEQ29zdARDb2luDFJlcXVpcmVtZW50MQAEAgIAAAAAAYIAAQAAABcBARgAGQAAAAABAQAAAAABggABAAAAGwIBGAAdAAAAAAQDAAAAAAKpAwEAggMCAAAAHwMBGAAAIQAAAAAEAAABAgAzowAAAP8ABQAAAAAAqQEBADABAOYAAAAAbwEBADABAI8CAAAAbwEDADABAAsEAAAAbwEFADABALoGAAAAbwEHADABAK4IAAAAbwEJADABAPIKAAAAqQEAADABAFoLAAAAbwEMADABAOINAAAAbwEOADABAL8PAAAAjAH6ADABACMQAAAA/wEAAAIAAABvAhEAjAP6AMUBAgMBAAAAMAEAnxIAAADAARMAMAEAaxQAAADAARUAMAEArRYAAADAARcAMAEAshgAAACCAAIAGQMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWBgADAQYBAwIGAgMDAwABAgEAARgAAAAEAAABAAABAAADAAABAAACAAABAAACAAACAAACAAABAAAAAAAAAAIAAAQAAAQAAAUBAAAAAAMqItVMHh4CK+ry92CUwy93WjrCOBjmv00=

-- https://lua.expert/
return {
	MonsterTrinket = true,
	GeneratorText = "This time, they can\'t hear you\226\128\166",
	GeneratorSound = "rbxassetid://105784755732269",
	Name = "Mime Makeup",
	Icon = "rbxassetid://79449792220001",
	Rarity = "Rare",
	Main = false,
	Description = "When failing a skillcheck the user will not alert the Twisted to their location.",
	TrinketType = "Passive",
	Cost = 250,
	Requirement1 = { "Coin", 250 },
	ApplyTrinket = function(p1, p2) --[[ ApplyTrinket | Line: 23 ]] end,
	RemoveTrinket = function(p1) --[[ RemoveTrinket | Line: 27 ]] end,
	TriggerSkillCheckFailEvent = function(p1, p2, p3) --[[ TriggerSkillCheckFailEvent | Line: 31 ]]
		return true
	end
}