--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local getNameFromUserIdAsync = require(modules.PlayerUtil.getNameFromUserIdAsync)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>


-- HELPERS
-- Peeks a raw number or a Fusion.Value<number?>. Inputs that aren't a
-- usable userId return nil so the lookup is skipped
local function peekUserId(input: any): number?
	local id = if typeof(input) == "table" then Fusion.peek(input) else input
	if typeof(id) ~= "number" or id <= 0 then return nil end
	return id
end


-- MODULE
-- Re-resolves when the input Value changes (like profile switches users
-- while the panel is still open). A torn-down scope swallows late writes
-- because :Value will no-op after teardown
return function(scope: Scope, userId: UsedAs<number?> | number): Fusion.Value<string>
	local out: Fusion.Value<string> = scope:Value("")

	local function resolve(id: number)
		task.spawn(function()
			local ok, name = getNameFromUserIdAsync(id)
			local resolved = if ok and typeof(name) == "string" then name else tostring(id)
			local current = peekUserId(userId)
			-- Stops late writes after the input switched users
			if current ~= id then return end
			out:set(resolved)
		end)
	end

	local initial = peekUserId(userId)
	if initial then resolve(initial) end

	if typeof(userId) == "table" then
		scope:Observer(userId :: any):onChange(function()
			out:set("")
			local id = peekUserId(userId)
			if id then resolve(id) end
		end)
	end

	return out
end
