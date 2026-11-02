--credit to prince games studio
local RunService = game:GetService("RunService")
local Util = require(script.Parent.Util)
local t = {
	Cmdr = nil,
	TypeMethods = Util.MakeDictionary({
		"Transform",
		"Validate",
		"Autocomplete",
		"Parse",
		"DisplayName",
		"Listable",
		"ValidateOnce",
		"Prefixes",
		"Default",
		"ArgumentOperatorAliases"
	}),
	CommandMethods = Util.MakeDictionary({
		"Name",
		"Aliases",
		"AutoExec",
		"Description",
		"Args",
		"Run",
		"ClientRun",
		"Data",
		"Group"
	}),
	CommandArgProps = Util.MakeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
	Types = {},
	TypeAliases = {},
	Commands = {},
	CommandsArray = {},
	Hooks = {
		BeforeRun = {},
		AfterRun = {}
	}
}

t.Stores = setmetatable({}, {
	__index = function(p1, p2) --[[ __index | Line: 20 ]]
		p1[p2] = {}

		return p1[p2]
	end
})
t.AutoExecBuffer = {}
function t.RegisterType(p1, p2, p3) --[[ RegisterType | Line: 30 ]]
	if not p2 or typeof(p2) ~= "string" then
		error("Invalid type name provided: nil")
	end

	if not p2:find("^[%d%l]%w*$") then
		error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p2))
	end

	for k in pairs(p3) do
		if p1.TypeMethods[k] == nil then
			error("Unknown key/method in type \"" .. p2 .. "\": " .. k)
		end
	end

	if p1.Types[p2] ~= nil then
		error(("Type \"%s\" has already been registered."):format(p2))
	end

	p3.Name = p2
	p3.DisplayName = p3.DisplayName or p2
	p1.Types[p2] = p3

	if not p3.Prefixes then
		return
	end

	p1:RegisterTypePrefix(p2, p3.Prefixes)
end
function t.RegisterTypePrefix(p1, p2, p3) --[[ RegisterTypePrefix | Line: 59 ]]
	if not p1.TypeAliases[p2] then
		p1.TypeAliases[p2] = p2
	end

	p1.TypeAliases[p2] = ("%s %s"):format(p1.TypeAliases[p2], p3)
end
function t.RegisterTypeAlias(p1, p2, p3) --[[ RegisterTypeAlias | Line: 67 ]]
	assert(if p1.TypeAliases[p2] == nil then true else false, ("Type alias %s already exists!"):format(p3))
	p1.TypeAliases[p2] = p3
end
function t.RegisterTypesIn(p1, p2) --[[ RegisterTypesIn | Line: 73 ]]
	for k, v in pairs(p2:GetChildren()) do
		if v:IsA("ModuleScript") then
			v.Parent = p1.Cmdr.ReplicatedRoot.Types
			require(v)(p1)

			continue
		end

		p1:RegisterTypesIn(v)
	end
end
t.RegisterHooksIn = t.RegisterTypesIn
function t.RegisterCommandObject(p1, p2, p3) --[[ RegisterCommandObject | Line: 90 | Upvalues: RunService (copy) ]]
	for k in pairs(p2) do
		if p1.CommandMethods[k] == nil then
			error("Unknown key/method in command " .. (p2.Name or "unknown command") .. ": " .. k)
		end
	end

	if p2.Args then
		for k, v in pairs(p2.Args) do
			if type(v) == "table" then
				for k2 in pairs(v) do
					if p1.CommandArgProps[k2] == nil then
						error(("Unknown property in command \"%s\" argument #%d: %s"):format(p2.Name or "unknown", k, k2))
					end
				end
			end
		end
	end

	if p2.AutoExec and RunService:IsClient() then
		table.insert(p1.AutoExecBuffer, p2.AutoExec)
		p1:FlushAutoExecBufferDeferred()
	end

	local v1 = p1.Commands[p2.Name:lower()]

	if v1 and v1.Aliases then
		for k, v in pairs(v1.Aliases) do
			p1.Commands[v:lower()] = nil
		end
	elseif not v1 then
		table.insert(p1.CommandsArray, p2)
	end

	p1.Commands[p2.Name:lower()] = p2

	if not p2.Aliases then
		return
	end

	for k, v in pairs(p2.Aliases) do
		p1.Commands[v:lower()] = p2
	end
end
function t.RegisterCommand(p1, p2, p3, p4) --[[ RegisterCommand | Line: 135 | Upvalues: RunService (copy) ]]
	local v1 = require(p2)
	local v2 = if typeof(v1) == "table" then true else false

	assert(v2, (("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(p2.Name, (typeof(v1)))))

	if p3 then
		assert(RunService:IsServer(), "The commandServerScript parameter is not valid for client usage.")
		v1.Run = require(p3)
	end

	if p4 and not p4(v1) then
		return
	end

	p1:RegisterCommandObject(v1)
	p2.Parent = p1.Cmdr.ReplicatedRoot.Commands
end
function t.RegisterCommandsIn(p1, p2, p3) --[[ RegisterCommandsIn | Line: 157 ]]
	local tbl = {}
	local t = {}

	for k, v in pairs(p2:GetChildren()) do
		if v:IsA("ModuleScript") then
			if v.Name:find("Server") then
				tbl[v] = true

				continue
			end

			local v1 = p2:FindFirstChild(v.Name .. "Server")

			if v1 then
				t[v1] = true
			end

			p1:RegisterCommand(v, v1, p3)

			continue
		end

		p1:RegisterCommandsIn(v, p3)
	end

	for k in pairs(tbl) do
		local _ = t[k]
	end
end
function t.RegisterDefaultCommands(p1, p2) --[[ RegisterDefaultCommands | Line: 186 | Upvalues: RunService (copy), Util (copy) ]]
	assert(RunService:IsServer(), "RegisterDefaultCommands cannot be called from the client.")

	local v2 = if type(p2) == "table" then true else false

	if v2 then
		p2 = Util.MakeDictionary(p2)
	end

	local v3 = v2 and (function(p1) --[[ Line: 195 | Upvalues: p2 (ref) ]]
		return p2[p1.Group] or false
	end) or p2

	p1:RegisterCommandsIn(p1.Cmdr.DefaultCommandsFolder, v3)
end
function t.GetCommand(p1, p2) --[[ GetCommand | Line: 201 ]]
	return p1.Commands[(p2 or ""):lower()]
end
function t.GetCommands(p1) --[[ GetCommands | Line: 207 ]]
	return p1.CommandsArray
end
function t.GetCommandNames(p1) --[[ GetCommandNames | Line: 212 ]]
	local t = {}

	for k, v in pairs(p1.CommandsArray) do
		table.insert(t, v.Name)
	end

	return t
end
t.GetCommandsAsStrings = t.GetCommandNames
function t.GetTypeNames(p1) --[[ GetTypeNames | Line: 225 ]]
	local t = {}

	for k in pairs(p1.Types) do
		table.insert(t, k)
	end

	return t
end
function t.GetType(p1, p2) --[[ GetType | Line: 237 ]]
	return p1.Types[p2]
end
function t.GetTypeName(p1, p2) --[[ GetTypeName | Line: 242 ]]
	return p1.TypeAliases[p2] or p2
end
function t.RegisterHook(p1, p2, p3, p4) --[[ RegisterHook | Line: 247 ]]
	if not p1.Hooks[p2] then
		error(("Invalid hook name: %q"):format(p2), 2)
	end

	table.insert(p1.Hooks[p2], {
		callback = p3,
		priority = p4 or 0
	})
	table.sort(p1.Hooks[p2], function(p1, p2) --[[ Line: 253 ]]
		return p1.priority < p2.priority
	end)
end
t.AddHook = t.RegisterHook
function t.GetStore(p1, p2) --[[ GetStore | Line: 261 ]]
	return p1.Stores[p2]
end
function t.FlushAutoExecBufferDeferred(p1) --[[ FlushAutoExecBufferDeferred | Line: 266 | Upvalues: RunService (copy) ]]
	if not p1.AutoExecFlushConnection then
		p1.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() --[[ Line: 271 | Upvalues: p1 (copy) ]]
			p1.AutoExecFlushConnection:Disconnect()
			p1.AutoExecFlushConnection = nil
			p1:FlushAutoExecBuffer()
		end)
	end
end
function t.FlushAutoExecBuffer(p1) --[[ FlushAutoExecBuffer | Line: 279 ]]
	for i, v in ipairs(p1.AutoExecBuffer) do
		for i2, v2 in ipairs(v) do
			p1.Cmdr.Dispatcher:EvaluateAndRun(v2)
		end
	end

	p1.AutoExecBuffer = {}
end

return function(p1) --[[ Line: 289 | Upvalues: t (copy) ]]
	t.Cmdr = p1

	return t
end