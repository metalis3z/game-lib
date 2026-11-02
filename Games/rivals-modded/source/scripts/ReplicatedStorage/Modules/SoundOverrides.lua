-- Sound ids the place owner wants played instead of the game's own (re-uploaded copies, or
-- anything else).
--
-- ServerStorage.SoundOverrides holds a Sound per sound worth changing, grouped in folders (Guns,
-- Duels, Lobby, Hits). Each keeps the game's id in its OriginalId attribute; setting its SoundId
-- to something else is all it takes. The server copies the folder to ReplicatedStorage when it
-- starts.
--
-- Get(soundId): the replacement for that id, or the id itself. Utility:CreateSound (every weapon,
-- hit and interface sound) and MusicController (the lobby music) ask here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOLDER_NAME = "SoundOverrides"

local SoundOverrides = {}

local byId: { [string]: string }? = nil

local function digits(soundId: any): string?
	return type(soundId) == "string" and string.match(soundId, "%d+") or nil
end

local function load(): { [string]: string }
	if byId then
		return byId
	end
	local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if not folder and RunService:IsServer() then
		folder = game:GetService("ServerStorage"):FindFirstChild(FOLDER_NAME)
	end
	local found = {}
	for _, sound in folder and folder:GetDescendants() or {} do
		if sound:IsA("Sound") then
			local original = digits(sound:GetAttribute("OriginalId"))
			local replacement = sound.SoundId
			if original and replacement ~= "" and digits(replacement) ~= original then
				found[original] = replacement
			end
		end
	end
	-- The folder may not have replicated yet: look again next time.
	if folder then
		byId = found
	end
	return found
end

function SoundOverrides.Get(soundId: string): string
	local original = digits(soundId)
	return original and load()[original] or soundId
end

-- Server only: make the overrides visible to clients.
function SoundOverrides.Publish()
	local source = game:GetService("ServerStorage"):FindFirstChild(FOLDER_NAME)
	local old = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if old then
		old:Destroy()
	end
	local copy = source and source:Clone() or Instance.new("Folder")
	copy.Name = FOLDER_NAME
	-- Only the ids travel; the Sounds must not play or load by themselves.
	for _, sound in copy:GetDescendants() do
		if sound:IsA("Sound") then
			sound.Playing = false
			sound.Looped = false
		end
	end
	copy.Parent = ReplicatedStorage
	byId = nil
end

return SoundOverrides
