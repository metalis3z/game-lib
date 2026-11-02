--[[

	Decides what each player is allowed to see of a replicated state table
	before it gets replicated

]]



local modules = script:FindFirstAncestor("MainModule").Value.Modules

export type StateVerifierAction = "OnlyInclude" | "Exclude"

return function(firstKey: string, action: StateVerifierAction, actionTable: {any}, requiredRolePermission: string?, requiredPageView: string?, gatedFields: {any}?, gatedRequiredPageView: string?)
	actionTable = actionTable or {}
	return function(player, pathway, value): (boolean, any)
		local totalKeys = #pathway
		local thisFirstKey = pathway[1]
		if thisFirstKey ~= firstKey then
			return false
		end
		local isPlayer = typeof(player) == "Instance" and (player :: any):IsA("Player")
		if (requiredRolePermission or requiredPageView) and isPlayer then
			local User = require(modules.Objects.User) :: any
			local Roles = require(modules.Parent.Services.Roles) :: any
			local viewingUser = User.getUser(player)
			if not viewingUser then return true, nil end
			if requiredRolePermission and not Roles.hasPermission(viewingUser, requiredRolePermission) then
				return true, nil
			end
			if requiredPageView and not Roles.canViewPage(viewingUser, requiredPageView) then
				return true, nil
			end
		end
		local extraStrip: {any}? = nil
		if gatedFields and gatedRequiredPageView and isPlayer then
			local User = require(modules.Objects.User) :: any
			local Roles = require(modules.Parent.Services.Roles) :: any
			local viewingUser = User.getUser(player)
			if not viewingUser or not Roles.canViewPage(viewingUser, gatedRequiredPageView) then
				extraStrip = gatedFields
			end
		end
		local function shouldStrip(fieldName: any): boolean
			if action == "OnlyInclude" and not table.find(actionTable, fieldName) then return true end
			if action == "Exclude" and table.find(actionTable, fieldName) then return true end
			if extraStrip and table.find(extraStrip, fieldName) then return true end
			return false
		end
		if totalKeys >= 3 then
			-- Gate on the depth-3 key for this and any deeper path, so a client can't
			-- reach a stripped nested value by tacking extra keys on the end
			if shouldStrip(pathway[3]) then
				return true, nil
			end
			return false
		end
		if typeof(value) ~= "table" then
			return false
		end
		local function updateTable(incomingTable)
			for propertyKey, propertyValue in incomingTable do
				if shouldStrip(propertyKey) then
					incomingTable[propertyKey] = nil
				end
			end
		end
		local tableToReturn: any = value
		if totalKeys == 2 then
			updateTable(tableToReturn)
		elseif totalKeys == 1 then
			for key, info in tableToReturn do
				if typeof(info) == "table" then
					updateTable(info)
				end
			end
		end
		return true, tableToReturn
	end
end
