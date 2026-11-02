

local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning)

local function create(n1: number, p1)
	deprecationWarning("List." .. script.Name, "table.create")

	return table.create(n1, p1)
end

return create
