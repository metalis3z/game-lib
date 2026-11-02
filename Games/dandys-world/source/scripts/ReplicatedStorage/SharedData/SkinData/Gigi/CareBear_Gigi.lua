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
-- CQMmEEh1bWFub2lkUm9vdFBhcnQJVG9vbkxpZ2h0DkZpbmRGaXJzdENoaWxkClBvaW50TGlnaHQGQ29sb3IzB2Zyb21SR0IFQ29sb3IJQXBwbHlTa2luCVdpc2ggQmVhcgROYW1lBnNjcmlwdAlSb2J1eENvc3QMR2V0QXR0cmlidXRlCERhdGVUaW1lEWZyb21Vbml2ZXJzYWxUaW1lB1VubG9ja3MJUHJvZHVjdElkG3JieGFzc2V0aWQ6Ly84ODE0MDg0NDQ4MzQ1NQRXYWxrG3JieGFzc2V0aWQ6Ly83MTczODA3NTcxNDQ2NAVRdWlyaxtyYnhhc3NldGlkOi8vODgyNDUxOTkxODgyMzMDUnVuHHJieGFzc2V0aWQ6Ly8xMjU2ODY2NjA1MjY2ODMESWRsZRtyYnhhc3NldGlkOi8vOTg5NjMzODc0ODg5ODUGRGVjb2RlG3JieGFzc2V0aWQ6Ly85MjQ1NTA0MTU3NjIxMAdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzk5MTAwOTE4Njc1OTgxBk5vcm1hbBtyYnhhc3NldGlkOi8vODQwMjk0MDUxNTA4NjYFQmxpbmsbcmJ4YXNzZXRpZDovLzczMTQ3NTA5NDk1NjM1BEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIGAQAAAAYDAAAFAQcWTQEAZgAAAABvAwEAvAEBAwIAAACfAQMCDgEOAE0BAGYAAAAATQEBbAEAAABNAQE5AwAAAKQCBgAAFECAjANdAIwEyACMBc0AnwIEAjACAaQHAAAAggABAAgDAQMCAwMDBAMFAwYEABRAgAMHABkIARgAAAAAAAAAAQAAAAAAAAAAAAAAAAADGwAAAAAIAAABAgBHowAAAP8ABAAAAAAAbwEAADABALoBAAAApAIEAAAAMEBvBAUAvAICEgYAAACfAgMCkAECAjABAJIFAAAApAEJAAAgcICMAuoHjAMFAIwEGgCMBRMAjAYAAIwHAACfAQcCMAEAUQoAAABvAQsAMAEACwwAAAD/AQQAAAAAAG8CDQAwAgGfDgAAAG8CDwAwAgF4EAAAAG8CEQAwAgEWEgAAAG8CEwAwAgGSFAAAAG8CFQAwAgHuFgAAAG8CFwAwAgH0GAAAADABAOkZAAAA/wEDAAAAAABvAhoAMAIBEBsAAABvAhwAMAIBmR0AAABvAh4AMAIBxR8AAAAwAQAhIAAAAKkBAQAwAQDCIQAAAMABIgAwAQDpIwAAAIIAAgAkAwkDCgIAAAAAAADwvwMLBAAAMEADDAMNAw4DDwQAIHCAAxACAACAlU2l6kEDEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgYAAwgBAAEAARgAAAACAAABAAAAAAAAAAABAAAAAAAAAAAAAAEAAAIAAQAAAQAAAQAAAQAAAQAAAQAA+gAJAAEAAAEAAAEAAP0ABgAAAgAACAEAAAAAARXsTIAcZ0yfa8d1J9wWIkJl9Fv0JygmgQ==

-- https://lua.expert/
return {
	Name = "Wish Bear",
	RobuxCost = script:GetAttribute("RobuxCost") or -1,
	Unlocks = DateTime.fromUniversalTime(2026, 5, 26, 19, 0, 0),
	ProductId = 3576327340,
	OverwriteAnimations = {
		Walk = "rbxassetid://88140844483455",
		Quirk = "rbxassetid://71738075714464",
		Run = "rbxassetid://88245199188233",
		Idle = "rbxassetid://125686660526683",
		Decode = "rbxassetid://98963387488985",
		Ability = "rbxassetid://92455041576210"
	},
	FaceTextures = {
		Normal = "rbxassetid://99100918675981",
		Blink = "rbxassetid://84029405150866",
		Hurt = "rbxassetid://73147509495635"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 25 ]]
		if not p1.HumanoidRootPart:FindFirstChild("ToonLight") then
			return
		end

		p1.HumanoidRootPart.ToonLight.PointLight.Color = Color3.fromRGB(93, 200, 205)
	end
}