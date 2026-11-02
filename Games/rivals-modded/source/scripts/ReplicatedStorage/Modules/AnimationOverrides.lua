-- Animation ids the place owner has re-uploaded under their own account.
--
-- The game's own animations belong to the original creator, and Roblox refuses to play them in
-- another place (they load with Length 0). ServerStorage.AnimationOverrides holds an Animation
-- per key, named after it:
--
--   AnimationLibrary keys      "scythe_sprint", "fists_attack1"...        (viewmodels)
--   PreloadController names   "SlidingStartForward"...                   (character)
--   Crouch_<Animate name>     "Crouch_idle", "Crouch_walk"...            (character, crouched)
--
-- The server copies the folder to ReplicatedStorage when it starts. Ids already re-uploaded are
-- baked into the Reuploaded child module and removed from the folder.
--
-- Get(key, default): the folder's id, else the baked one, else the default.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOLDER_NAME = "AnimationOverrides"

local Reuploaded = require(script:WaitForChild("Reuploaded"))

local AnimationOverrides = {}

local byName: { [string]: string }? = nil

local function load(): { [string]: string }
	if byName then
		return byName
	end
	local found = {}
	local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if not folder and RunService:IsServer() then
		folder = game:GetService("ServerStorage"):FindFirstChild(FOLDER_NAME)
	elseif not folder then
		folder = ReplicatedStorage:WaitForChild(FOLDER_NAME, 10)
	end
	for _, animation in folder and folder:GetDescendants() or {} do
		if animation:IsA("Animation") and animation.AnimationId ~= "" then
			found[animation.Name] = animation.AnimationId
		end
	end
	byName = found
	return found
end

function AnimationOverrides.Get(key: string, default: string?): string?
	return load()[key] or Reuploaded[key] or default
end

-- Server only: make the overrides visible to clients.
function AnimationOverrides.Publish()
	local source = game:GetService("ServerStorage"):FindFirstChild(FOLDER_NAME)
	local old = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if old then
		old:Destroy()
	end
	if source then
		source:Clone().Parent = ReplicatedStorage
	else
		local empty = Instance.new("Folder")
		empty.Name = FOLDER_NAME
		empty.Parent = ReplicatedStorage
	end
	byName = nil
end

return AnimationOverrides
