--credit to leon games studio
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local v1 = RunService:IsServer()
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 12 | Upvalues: t (copy) ]]
	local t2 = {
		Response = nil,
		Dispatcher = p1.Dispatcher,
		Cmdr = p1.Dispatcher.Cmdr,
		Name = p1.CommandObject.Name,
		RawText = p1.Text,
		Object = p1.CommandObject,
		Group = p1.CommandObject.Group,
		State = {},
		Aliases = p1.CommandObject.Aliases,
		Alias = p1.Alias,
		Description = p1.CommandObject.Description,
		Executor = p1.Executor,
		ArgumentDefinitions = p1.CommandObject.Args,
		RawArguments = p1.Arguments,
		Arguments = {},
		Data = p1.Data
	}

	setmetatable(t2, t)

	return t2
end
function t.Parse(p1, p2) --[[ Parse | Line: 40 | Upvalues: Argument (copy) ]]
	local v1 = false

	for i, v in ipairs(p1.ArgumentDefinitions) do
		if type(v) == "function" then
			local v2 = v(p1)

			if v2 == nil then
				break
			end

			v = v2
		end

		local v3 = if v.Default == nil then if v.Optional == true then false else true else false

		if v3 and v1 then
			error(("Command %q: Required arguments cannot occur after optional arguments."):format(p1.Name))
		elseif not v3 then
			v1 = true
		end

		if p1.RawArguments[i] == nil and (v3 and p2 ~= true) then
			return false, ("Required argument #%d %s is missing."):format(i, v.Name)
		end

		if p1.RawArguments[i] or p2 then
			p1.Arguments[i] = Argument.new(p1, v, p1.RawArguments[i] or "")
		end
	end

	return true
end
function t.Validate(p1, p2) --[[ Validate | Line: 72 ]]
	p1._Validated = true

	local v1 = ""
	local v2 = true

	for k, v in pairs(p1.Arguments) do
		local v3, v4 = v:Validate(p2)

		if not v3 then
			v1, v2 = ("%s; #%d %s: %s"):format(v1, k, v.Name, v4 or "error"), false
		end
	end

	return v2, v1:sub(3)
end
function t.GetLastArgument(p1) --[[ GetLastArgument | Line: 91 ]]
	for i = #p1.Arguments, 1, -1 do
		if p1.Arguments[i].RawValue then
			return p1.Arguments[i]
		end
	end
end
function t.GatherArgumentValues(p1) --[[ GatherArgumentValues | Line: 100 ]]
	local t = {}

	for i = 1, #p1.ArgumentDefinitions do
		local v1 = p1.Arguments[i]

		if v1 then
			t[i] = v1:GetValue()

			continue
		end

		if type(p1.ArgumentDefinitions[i]) == "table" then
			t[i] = p1.ArgumentDefinitions[i].Default
		end
	end

	return t, #p1.ArgumentDefinitions
end
function t.Run(p1) --[[ Run | Line: 117 | Upvalues: v1 (copy) ]]
	if p1._Validated == nil then
		error("Must validate a command before running.")
	end

	local v12 = p1.Dispatcher:RunHooks("BeforeRun", p1)

	if v12 then
		return v12
	end

	if not v1 and (p1.Object.Data and p1.Data == nil) then
		local v2, v3 = p1:GatherArgumentValues()

		p1.Data = p1.Object.Data(p1, unpack(v2, 1, v3))
	end

	if not v1 and p1.Object.ClientRun then
		local v4, v5 = p1:GatherArgumentValues()

		p1.Response = p1.Object.ClientRun(p1, unpack(v4, 1, v5))
	end

	if p1.Response == nil then
		if p1.Object.Run then
			local v6, v7 = p1:GatherArgumentValues()

			p1.Response = p1.Object.Run(p1, unpack(v6, 1, v7))
		elseif v1 then
			local ClientRun = p1.Object.ClientRun

			p1.Response = "No implementation."
		else
			p1.Response = p1.Dispatcher:Send(p1.RawText, p1.Data)
		end
	end

	local v8 = p1.Dispatcher:RunHooks("AfterRun", p1)

	if v8 then
		return v8
	end

	return p1.Response
end
function t.GetArgument(p1, p2) --[[ GetArgument | Line: 162 ]]
	return p1.Arguments[p2]
end
function t.GetData(p1) --[[ GetData | Line: 170 | Upvalues: v1 (copy) ]]
	if p1.Data then
		return p1.Data
	end

	if p1.Object.Data and not v1 then
		p1.Data = p1.Object.Data(p1)
	end

	return p1.Data
end
function t.SendEvent(p1, p2, p3, ...) --[[ SendEvent | Line: 183 | Upvalues: v1 (copy), Players (copy) ]]
	assert(if typeof(p2) == "Instance" then true else false, "Argument #1 must be a Player")
	assert(p2:IsA("Player"), "Argument #1 must be a Player")
	assert(if type(p3) == "string" then true else false, "Argument #2 must be a string")

	if v1 then
		p1.Dispatcher.Cmdr.RemoteEvent:FireClient(p2, p3, ...)

		return
	end

	if not p1.Dispatcher.Cmdr.Events[p3] then
		return
	end

	assert(p2 == Players.LocalPlayer, "Event messages can only be sent to the local player on the client.")
	p1.Dispatcher.Cmdr.Events[p3](...)
end
function t.BroadcastEvent(p1, ...) --[[ BroadcastEvent | Line: 197 | Upvalues: v1 (copy) ]]
	if v1 then
		p1.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)

		return
	end

	error("Can\'t broadcast event messages from the client.", 2)
end
function t.Reply(p1, ...) --[[ Reply | Line: 206 ]]
	return p1:SendEvent(p1.Executor, "AddLine", ...)
end
function t.GetStore(p1, ...) --[[ GetStore | Line: 211 ]]
	return p1.Dispatcher.Cmdr.Registry:GetStore(...)
end
function t.HasImplementation(p1) --[[ HasImplementation | Line: 216 | Upvalues: RunService (copy) ]]
	if RunService:IsClient() and p1.Object.ClientRun then
		return true
	end

	if p1.Object.Run then
		return true
	end

	return false
end

return t