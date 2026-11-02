--!strict
local registeredKeys: {[number]: string} = {}
local RemoteCallerRoles = {}

function RemoteCallerRoles.register(userId: number, roleKey: string)
	registeredKeys[userId] = roleKey
end

function RemoteCallerRoles.getKey(userId: number): string?
	return registeredKeys[userId]
end

-- The current top role key of someone in this server, nil for everyone else
function RemoteCallerRoles.resolveLocalKey(userId: number): string?
	local modules = script:FindFirstAncestor("MainModule").Value.Modules
	local User = require(modules.Objects.User) :: any
	local Roles = require(modules.Parent.Services.Roles) :: any
	local user = User.getUserByUserId(userId)
	local role = if user then Roles.getTopRole(user) else nil
	if typeof(role) == "table" and (role :: any).key then
		return (role :: any).key
	end
	return nil
end

return RemoteCallerRoles
