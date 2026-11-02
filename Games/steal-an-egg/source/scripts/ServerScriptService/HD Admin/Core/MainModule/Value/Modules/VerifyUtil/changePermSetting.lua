local modules = script:FindFirstAncestor("MainModule").Value.Modules
local getDataSize = require(modules.VerifyUtil.getDataSize)
local User = require(modules.Objects.User)

return function(player: Player, path: {string}, newValue: unknown): (boolean, string?)
	local user = User.getUser(player)
	if not user then
		return false, "User not loaded"
	end
	if getDataSize(newValue) > 1000 then
		return false, "Perm value is too large"
	end
	user.perm:set(path, newValue)
	return true
end
