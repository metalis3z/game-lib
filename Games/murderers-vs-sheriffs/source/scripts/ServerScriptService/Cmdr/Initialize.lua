local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CreateGui = require(script.Parent.CreateGui)

--- Handles initial preparation of the game server-side.
return function (cmdr)
	local ReplicatedRoot, RemoteFunction, RemoteEvent

	local function Create (class, name, parent)
		local object = Instance.new(class)
		object.Name = name
		object.Parent = parent or ReplicatedRoot

		return object
	end

	ReplicatedRoot = ReplicatedStorage:FindFirstChild("CmdrClient") or script.Parent:FindFirstChild("CmdrClient")
	if not ReplicatedRoot then
		error("CmdrClient is missing; Cmdr cannot initialize.")
	end
	ReplicatedRoot.Parent = ReplicatedStorage

	RemoteFunction = ReplicatedRoot:FindFirstChild("CmdrFunction") or Create("RemoteFunction", "CmdrFunction")
	RemoteEvent = ReplicatedRoot:FindFirstChild("CmdrEvent") or Create("RemoteEvent", "CmdrEvent")

	if not ReplicatedRoot:FindFirstChild("Commands") then
		Create("Folder", "Commands")
	end
	if not ReplicatedRoot:FindFirstChild("Types") then
		Create("Folder", "Types")
	end

	local Shared = script.Parent:FindFirstChild("Shared") or ReplicatedRoot:FindFirstChild("Shared")
	if not Shared then
		error("Cmdr Shared folder is missing; Cmdr cannot initialize.")
	end
	Shared.Parent = ReplicatedRoot

	cmdr.ReplicatedRoot = ReplicatedRoot
	cmdr.RemoteFunction = RemoteFunction
	cmdr.RemoteEvent = RemoteEvent

	local BuiltInTypes = script.Parent:FindFirstChild("BuiltInTypes")
	if BuiltInTypes then
		cmdr:RegisterTypesIn(BuiltInTypes)
		BuiltInTypes:Destroy()
	end

	local BuiltInCommands = script.Parent:FindFirstChild("BuiltInCommands")
	if BuiltInCommands then
		BuiltInCommands.Name = "Server commands"
	end

	if StarterGui:FindFirstChild("Cmdr") == nil then
		CreateGui()
	end
end
