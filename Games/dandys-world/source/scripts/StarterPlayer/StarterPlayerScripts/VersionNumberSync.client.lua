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
-- CQMUCVRleHRMYWJlbANJc0EKVGV4dEJ1dHRvbgdUZXh0Qm94C0dhbWVWZXJzaW9uDEdldEF0dHJpYnV0ZQh0b3N0cmluZwRUZXh0B2FwcGx5VG8GaXBhaXJzDVZlcnNpb25OdW1iZXIJR2V0VGFnZ2VkCmFwcGx5VG9BbGwEZ2FtZRFDb2xsZWN0aW9uU2VydmljZQpHZXRTZXJ2aWNlCVdvcmtzcGFjZRZHZXRJbnN0YW5jZUFkZGVkU2lnbmFsB0Nvbm5lY3QZR2V0QXR0cmlidXRlQ2hhbmdlZFNpZ25hbAADBAEBAAAAH28DAAC8AQD+AQAAAJ8BAwIrAQsAbwMCALwBAP4BAAAAnwEDAisBBgBvAwMAvAEA/gEAAACfAQMCKwEBAIIAAQD7AQAAbwMEALwBARIFAAAAnwEDAkcBCAAAAAAAuz8BA1IDAQCkAgcAAABgQJ8CAgIwAgD1CAAAAIIAAQAJAwEDAgMDAwQDBQMGAwcEAABgQAMIAAcJARgAAAAAAAAAAAAAAAAAAAABAgAAAAABAAEAAAAAAAACCAAAAAAHAAIAAAAPpAABAAAAAED7AQAAbwMCALwBAQUDAAAAnwEDAJ8AAARRAAMA+wUBAFIGBACfBQIBbgD8/wIAAICCAAEABAMKBAAAAEADCwMMABENARgAAAAAAAAAAAABAAD/AAMSAAAAAAsAAAEAADCjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCwAIFABIAAQDAAwYAEgAAABIAAgCkBAgAAABwQG8HCQC8BQAFCgAAAJ8FAwCfBAAEUQQDAFIJAgBSCggAnwkCAW4E/P8CAACAbwYJALwEAF4LAAAAnwQDAlIGAgC8BATHDAAAAJ8EAwFvBg0AvAQBFg4AAACfBAMCUgYDALwEBMcMAAAAnwQDAYIAAQAPAw4EAAAAQAMPAxADEQYABgEDCgQAAHBAAwsDDAMSAxMDBQMUAgABAQABGAAAAAAAAAABAAAAAAAFAAoAAAEAAAAAAAAAAQAA/wAHAAAAAAAAAAEAAAAAAAAAAQEAAAAAAoTF+Qq6eSQfj7558F7qyL303e5+tgGTCw==

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local function applyTo(p1) --[[ applyTo | Line: 7 | Upvalues: Workspace (copy) ]]
	if not (p1:IsA("TextLabel") or (p1:IsA("TextButton") or p1:IsA("TextBox"))) then
		return
	end

	local v1 = Workspace:GetAttribute("GameVersion")

	if v1 == nil then
		return
	end

	p1.Text = tostring(v1)
end

local function applyToAll() --[[ applyToAll | Line: 17 | Upvalues: CollectionService (copy), applyTo (copy) ]]
	for i, v in ipairs(CollectionService:GetTagged("VersionNumber")) do
		applyTo(v)
	end
end

for i, v in ipairs(CollectionService:GetTagged("VersionNumber")) do
	applyTo(v)
end

CollectionService:GetInstanceAddedSignal("VersionNumber"):Connect(applyTo)
Workspace:GetAttributeChangedSignal("GameVersion"):Connect(applyToAll)