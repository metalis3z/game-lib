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
-- CQMSBGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlCElzU2VydmVyCERhdGVUaW1lA25vdw1Vbml4VGltZXN0YW1wBnNjcmlwdAdTdGFydHVwDFNldEF0dHJpYnV0ZQxHZXRBdHRyaWJ1dGUZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbARXYWl0BVN0YXJ0BFRvb24GU3Byb3V0EWZyb21Vbml2ZXJzYWxUaW1lBEZpbm4AAQwAAAECAFCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCvAEACwQAAACfAQICUgIBAA4CBQCkAgcAABhQgJ8CAQJNAgK3CAAAAA4BCACkAwoAAACQQG8FCwBSBgIAvAMDLgwAAACfAwQBZQAXAKQDCgAAAJBAbwULALwDAxINAAAAnwMDAisDCQCkAwoAAACQQG8FCwC8AwMWDgAAAJ8DAwK8AwP3DwAAAJ8DAgGkAwoAAACQQG8FCwC8AwMSDQAAAJ8DAwJSAgMA/wMCAAAAAADiBBMApAUVAABQUICMBuoHjAcFAIwIAQCMCRMAjAoAAIwLAACfBQcCMAUEHBAAAAAwBAPZEgAAAOIEFwCkBRUAAFBQgIwG6geMBwYAjAgMAIwJEgCMCgAAjAsAAJ8FBwIwBQQcEAAAADAEA3wWAAAAggMCABgDAQQAAABAAwIDAwMEAwUDBgQAGFCAAwcDCAQAAJBAAwkDCgMLAwwDDQMOAw8DEAgCEP////8REgAAAAMRBABQUIADEggCEP////8RFgAAAAABAAEYAAAAAAAAAAIAAAEAAAAAAAACAQAAAAAAAAACAAAAAAAAAQAAAAAAAAAAAgAAAAAAAAMAAQEAAAAAAAAAAAAA/wAFAQAAAAAAAAAAAAD/AAkBAAAAAADb7IqrnU0bA+g9iLgGVpQBq/Sd3+ko4Ko=

-- https://lua.expert/
local v1 = game:GetService("RunService"):IsServer()
local v2 = if v1 then DateTime.now().UnixTimestamp else v1

if v1 then
	script:SetAttribute("Startup", v2)
else
	if not script:GetAttribute("Startup") then
		script:GetAttributeChangedSignal("Startup"):Wait()
	end

	script:GetAttribute("Startup")
end

return {
	Sprout = {
		Toon = "Sprout",
		Start = DateTime.fromUniversalTime(2026, 5, 1, 19, 0, 0)
	},
	Finn = {
		Toon = "Finn",
		Start = DateTime.fromUniversalTime(2026, 6, 12, 18, 0, 0)
	}
}