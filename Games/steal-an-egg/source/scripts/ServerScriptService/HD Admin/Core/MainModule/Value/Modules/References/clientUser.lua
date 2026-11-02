local main = script:FindFirstAncestor("MainModule")
local State = require(main.Value.Modules.Objects.State)

local perm = State.new()
perm:sync(`UserPerm`)

local temp = State.new()
temp:sync(`UserTemp`)

local everyone = State.new()
everyone:sync(`UserEveryone`)

local clientUser = {
	temp = temp,
	perm = perm,
	everyone = everyone
}

return clientUser