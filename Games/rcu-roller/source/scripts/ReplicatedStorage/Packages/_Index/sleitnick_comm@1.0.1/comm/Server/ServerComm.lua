-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:45
-- Luau version 6, Types version 3
-- Time taken: 0.001366 seconds

local Parent_upvr = require(script.Parent)
local module_upvr = {}
module_upvr.__index = module_upvr
local Util_upvr = require(script.Parent.Parent.Util)
function module_upvr.new(arg1, arg2) -- Line 44
	--[[ Upvalues[2]:
		[1]: Util_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	local IsServer = Util_upvr.IsServer
	assert(IsServer, "ServerComm must be constructed from the server")
	if typeof(arg1) ~= "Instance" then
		IsServer = false
	else
		IsServer = true
	end
	assert(IsServer, "Parent must be of type Instance")
	local DefaultCommFolderName = Util_upvr.DefaultCommFolderName
	if arg2 then
		DefaultCommFolderName = arg2
	end
	assert(not arg1:FindFirstChild(DefaultCommFolderName), "Parent already has another ServerComm bound to namespace "..DefaultCommFolderName)
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._instancesFolder = Instance.new("Folder")
	setmetatable_result1._instancesFolder.Name = DefaultCommFolderName
	setmetatable_result1._instancesFolder.Parent = arg1
	return setmetatable_result1
end
function module_upvr.BindFunction(arg1, arg2, arg3, arg4, arg5) -- Line 76
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	return Parent_upvr.BindFunction(arg1._instancesFolder, arg2, arg3, arg4, arg5)
end
function module_upvr.WrapMethod(arg1, arg2, arg3, arg4, arg5) -- Line 108
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	return Parent_upvr.WrapMethod(arg1._instancesFolder, arg2, arg3, arg4, arg5)
end
function module_upvr.CreateSignal(arg1, arg2, arg3, arg4, arg5) -- Line 146
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	return Parent_upvr.CreateSignal(arg1._instancesFolder, arg2, arg3, arg4, arg5)
end
function module_upvr.CreateProperty(arg1, arg2, arg3, arg4, arg5) -- Line 195
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	return Parent_upvr.CreateProperty(arg1._instancesFolder, arg2, arg3, arg4, arg5)
end
function module_upvr.Destroy(arg1) -- Line 207
	arg1._instancesFolder:Destroy()
end
return module_upvr