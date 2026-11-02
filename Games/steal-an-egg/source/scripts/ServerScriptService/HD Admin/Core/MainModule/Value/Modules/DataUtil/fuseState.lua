--!strict
-- This bridges a connection between HD state objects, and Fusion StateObjects, by
-- creating a StateObject (scope:Value) with a value of self:get(...) or nil,
-- and then binds changes from this state to the Fusion StateObject
-- For example:

--[[
local Fusion = require(modules.Parent.Packages.Fusion)
local fuseState = require(modules.DataUtil.fuseState)
local scoped, peek = Fusion.scoped, Fusion.peek
local scope = scoped(Fusion) :: Fusion.Scope
scope.Fuse = fuseState

local value = scope:Fuse("everyone", "CommandInfo") --value is a Fusion StateObject. You can do peek(commandInfo), commandInfo:set(...), etc
scope:Observer(value):onBind(function()
    print("CommandInfo =", peek(value))
end)
]]

local modules = script:FindFirstAncestor("MainModule").Value.Modules
local State = require(modules.Objects.State)
local Fusion = require(modules.Parent.Packages.Fusion)
local clientUser = require(modules.References.clientUser)

export type ClientStateKey = keyof<typeof(clientUser)>

return function(scope: Fusion.Scope, state: State.Class | ClientStateKey, ...: string | {string}): (Fusion.Value<any>, (...any) -> (), () -> ())
	if typeof(state) == "string" then
		state = (clientUser :: any)[state]
	end
	if typeof(state) ~= "table" then
		error("Invalid state provided to fuseState")
	end
	state = state :: State.Class
	return state:fuse(scope, ...)
end