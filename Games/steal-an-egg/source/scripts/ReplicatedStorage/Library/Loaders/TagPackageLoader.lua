-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local v1 = RunService:IsServer()
local v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16

if v1 or game:IsLoaded() then
	v2 = script.Private
	v3 = ReplicatedStorage.Library.Functions
	v4 = require(v3.UtilityPackageInjector)
	v5 = require(v2.Database)
	v6 = require(v2.Templates)
	v7 = require(ReplicatedStorage.Library.Asserts)
	v8 = require(v3.InstanceCheck)
	v9 = require(script.Parent.Bootstrapper)
	v10 = require(ReplicatedStorage.Library.Modules.Packages.t)
	v11 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
	v12 = os.clock()
	v13 = ""
	v14 = setmetatable({}, {
		__mod = "k"
	})
	v15 = v10.optional(v10.union(v10.string, v10.table))
	v16 = v4.new(nil, v5.Exclude_Protocol)
	v16.__index = v16
	function v16.new(p13, p23) --[[ new | Line: 62 | Upvalues: v7 (copy), v15 (copy), v4 (copy), v5 (copy), v16 (copy) ]]
		v7.string(p13)
		assert(v15(p23))

		return setmetatable(v4.new({
			__tagPackageLoader_ecosystem = {
				__master_logger = {},
				Flag = p13,
				Directories = {},
				Logger = p23
			}
		}, v5.Exclude_Protocol), v16)
	end
	function v16.Get_Logs(p13) --[[ Get_Logs | Line: 86 | Upvalues: v12 (copy), v13 (ref) ]]
		return ("(%*)ms:%*"):format((os.clock() - v12) * 1000, v13)
	end
	function v16.Extract_Token(p13, p23) --[[ Extract_Token | Line: 90 | Upvalues: v8 (copy), HttpService (copy) ]]
		if not v8(p23, "ModuleScript") then
			return
		end

		return p23:GetAttribute("__overwrite") or (p23:GetAttribute("__guid") and HttpService:GenerateGUID(false) or p23.Name)
	end
	function v16.Read_Logger(p13) --[[ Read_Logger | Line: 100 | Upvalues: v6 (copy) ]]
		local Logger = p13.__tagPackageLoader_ecosystem.Logger
		local v1 = if typeof(Logger) == "table" and Logger then Logger elseif typeof(Logger) == "string" then v6[Logger] else false

		if not v1 then
			p13.__tagPackageLoader_ecosystem.Logger = "All_Extensions"
		end

		return if v1 then v1 else v6.All_Extensions
	end
	function v16.Bootstrap_Directory(p13, p23, p33, ...) --[[ Bootstrap_Directory | Line: 111 | Upvalues: v9 (copy) ]]
		local v1 = if p33 then p13.__tagPackageLoader_ecosystem.Directories else p33

		if p33 and v1[p23] then
			return v1[p23]
		end

		local v2 = if typeof(p23) == "string" then p13[p23] else false

		if typeof(v2) ~= "table" then
			return
		end

		local v3 = v9.new(v2):Bootstrap(...)

		if p33 then
			v1[p23] = v3
		end

		return v3
	end
	function v16.Bootstrap_All(p13, ...) --[[ Bootstrap_All | Line: 130 ]]
		local __master_logger = p13.__tagPackageLoader_ecosystem.__master_logger

		if typeof(__master_logger) ~= "table" then
			return warn("The initialization must happen before bootstrapping all")
		end

		for v1, v2 in __master_logger do
			p13:Bootstrap_Directory(v2, true, ...)
		end

		return __master_logger
	end
	function v16.Load(p13, p23) --[[ Load | Line: 143 | Upvalues: CollectionService (copy), v14 (copy), v13 (ref), v1 (copy), v11 (copy) ]]
		local t2 = {}

		p13.__tagPackageLoader_ecosystem.__master_logger = t2

		local t22 = {}
		local sum2 = 0
		local v12 = 0

		for v2, v3 in p13:Read_Logger() do
			local v4 = if typeof(v3) == "string" then CollectionService:GetTagged(p13.__tagPackageLoader_ecosystem.Flag .. v3) else false

			if typeof(v4) == "table" and #v4 ~= 0 then
				assert(not p13[v3], (("Attempt to load directory: \"%*\", multiple times"):format(v3)))
				t22[v3] = v4
				p13[v3] = {}
				table.insert(t2, v3)
				sum2 = sum2 + #v4
			end
		end

		local v7 = if sum2 > 0 then true else false

		assert(v7, (("Attempt to load an empty module directory: [%*]"):format((table.concat(p13:Read_Logger(), ", ")))))

		for v9, v10 in t22 do
			local v112 = p13[v9]

			for i = 1, #v10 do
				local function perform() --[[ perform | Line: 174 | Upvalues: v10 (copy), i (copy), v9 (copy), v14 (ref), v112 (copy), v12 (ref), p13 (copy), v13 (ref), v1 (ref), sum2 (ref), v11 (ref) ]]
					local v15 = os.clock()
					local v2 = false
					local v3 = v10[i]

					assert(v3 and v3:IsA("ModuleScript"), (("Attempt to load a non-module script: \"%*\" in directory: \"%*\""):format(v3:GetFullName(), v9)))

					local v6 = v14[v3]

					if typeof(v6) == "table" then
						v112[v6.Key] = v6.Result
						v12 = v12 + 1

						return
					end

					local v7 = p13:Extract_Token(v3)

					if not v7 then
						return
					end

					task.delay(5, function() --[[ Line: 202 | Upvalues: v2 (ref), v3 (copy), v13 (ref) ]]
						if not v2 then
							local v1 = ("TagPackageLoader:Load(\"%*\") taking longer than expected"):format((v3:GetFullName()))

							warn(v1)
							v13 = v13 .. (v1 or "") .. "\n"
						end
					end)

					local v8 = v3.Name

					debug.setmemorycategory(v8)

					local v92 = true
					local v102 = nil
					local v113 = ("[TagPackageLoader] REQUIRE %* failed: %%ERROR"):format(v3.Name)

					local function requireModule() --[[ requireModule | Line: 220 | Upvalues: v3 (copy), v112 (ref), v7 (copy), v14 (ref) ]]
						local v1 = require(v3)

						v112[v7] = v1
						v14[v3] = {
							Result = v1,
							Key = v7
						}
					end

					xpcall(requireModule, function(p13) --[[ Line: 227 | Upvalues: v113 (copy), v92 (ref), v102 (ref) ]]
						local v1 = v113:gsub("%%ERROR", (tostring(p13)))

						v92 = false
						v102 = v1
						warn("ERROR: " .. v1 .. "\n" .. debug.traceback())
					end)

					if not v92 then
						debug.setmemorycategory("post-TagPackageLoader-error")
						error(v102)
					end

					v13 = v13 .. "\n" .. (("[%* TagPackageLoader] Module \"%*\" finished requiring under \"%*\". (%* ms)"):format(if v1 then "Server" else "Client", v8, v9, (math.floor((os.clock() - v15) * 1000))) or "") .. "\n"

					local v142 = (debug.info(2, "s") or "unknown"):split(".")

					debug.setmemorycategory(v142[#v142])
					v12 = v12 + 1

					if v12 == sum2 then
						v11:AtTrace():SepLog()
						v11:AtTrace():Log((("\nSuccessfully loaded directories, (%*/%*): [%*]"):format(v12, sum2, (table.concat(p13:Read_Logger(), ", ")))))
						v11:AtTrace():SepLog()
					end
				end

				if p23 then
					perform()
				else
					task.spawn(perform)
				end

				if i % 400 == 0 then
					task.wait()
				end
			end
		end

		return p13
	end

	return v16
end

game.Loaded:Wait()
v2 = script.Private
v3 = ReplicatedStorage.Library.Functions
v4 = require(v3.UtilityPackageInjector)
v5 = require(v2.Database)
v6 = require(v2.Templates)
v7 = require(ReplicatedStorage.Library.Asserts)
v8 = require(v3.InstanceCheck)
v9 = require(script.Parent.Bootstrapper)
v10 = require(ReplicatedStorage.Library.Modules.Packages.t)
v11 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
v12 = os.clock()
v13 = ""
v14 = setmetatable({}, {
	__mod = "k"
})
v15 = v10.optional(v10.union(v10.string, v10.table))
v16 = v4.new(nil, v5.Exclude_Protocol)
v16.__index = v16
function v16.new(p13, p23) --[[ new | Line: 62 | Upvalues: v7 (copy), v15 (copy), v4 (copy), v5 (copy), v16 (copy) ]]
	v7.string(p13)
	assert(v15(p23))

	return setmetatable(v4.new({
		__tagPackageLoader_ecosystem = {
			__master_logger = {},
			Flag = p13,
			Directories = {},
			Logger = p23
		}
	}, v5.Exclude_Protocol), v16)
end
function v16.Get_Logs(p13) --[[ Get_Logs | Line: 86 | Upvalues: v12 (copy), v13 (ref) ]]
	return ("(%*)ms:%*"):format((os.clock() - v12) * 1000, v13)
end
function v16.Extract_Token(p13, p23) --[[ Extract_Token | Line: 90 | Upvalues: v8 (copy), HttpService (copy) ]]
	if not v8(p23, "ModuleScript") then
		return
	end

	return p23:GetAttribute("__overwrite") or (p23:GetAttribute("__guid") and HttpService:GenerateGUID(false) or p23.Name)
end
function v16.Read_Logger(p13) --[[ Read_Logger | Line: 100 | Upvalues: v6 (copy) ]]
	local Logger = p13.__tagPackageLoader_ecosystem.Logger
	local v1 = if typeof(Logger) == "table" and Logger then Logger elseif typeof(Logger) == "string" then v6[Logger] else false

	if not v1 then
		p13.__tagPackageLoader_ecosystem.Logger = "All_Extensions"
	end

	return if v1 then v1 else v6.All_Extensions
end
function v16.Bootstrap_Directory(p13, p23, p33, ...) --[[ Bootstrap_Directory | Line: 111 | Upvalues: v9 (copy) ]]
	local v1 = if p33 then p13.__tagPackageLoader_ecosystem.Directories else p33

	if p33 and v1[p23] then
		return v1[p23]
	end

	local v2 = if typeof(p23) == "string" then p13[p23] else false

	if typeof(v2) ~= "table" then
		return
	end

	local v3 = v9.new(v2):Bootstrap(...)

	if p33 then
		v1[p23] = v3
	end

	return v3
end
function v16.Bootstrap_All(p13, ...) --[[ Bootstrap_All | Line: 130 ]]
	local __master_logger = p13.__tagPackageLoader_ecosystem.__master_logger

	if typeof(__master_logger) ~= "table" then
		return warn("The initialization must happen before bootstrapping all")
	end

	for v1, v2 in __master_logger do
		p13:Bootstrap_Directory(v2, true, ...)
	end

	return __master_logger
end
function v16.Load(p13, p23) --[[ Load | Line: 143 | Upvalues: CollectionService (copy), v14 (copy), v13 (ref), v1 (copy), v11 (copy) ]]
	local t2 = {}

	p13.__tagPackageLoader_ecosystem.__master_logger = t2

	local t22 = {}
	local sum2 = 0
	local v12 = 0

	for v2, v3 in p13:Read_Logger() do
		local v4 = if typeof(v3) == "string" then CollectionService:GetTagged(p13.__tagPackageLoader_ecosystem.Flag .. v3) else false

		if typeof(v4) == "table" and #v4 ~= 0 then
			assert(not p13[v3], (("Attempt to load directory: \"%*\", multiple times"):format(v3)))
			t22[v3] = v4
			p13[v3] = {}
			table.insert(t2, v3)
			sum2 = sum2 + #v4
		end
	end

	local v7 = if sum2 > 0 then true else false

	assert(v7, (("Attempt to load an empty module directory: [%*]"):format((table.concat(p13:Read_Logger(), ", ")))))

	for v9, v10 in t22 do
		local v112 = p13[v9]

		for i = 1, #v10 do
			local function perform() --[[ perform | Line: 174 | Upvalues: v10 (copy), i (copy), v9 (copy), v14 (ref), v112 (copy), v12 (ref), p13 (copy), v13 (ref), v1 (ref), sum2 (ref), v11 (ref) ]]
				local v15 = os.clock()
				local v2 = false
				local v3 = v10[i]

				assert(v3 and v3:IsA("ModuleScript"), (("Attempt to load a non-module script: \"%*\" in directory: \"%*\""):format(v3:GetFullName(), v9)))

				local v6 = v14[v3]

				if typeof(v6) == "table" then
					v112[v6.Key] = v6.Result
					v12 = v12 + 1

					return
				end

				local v7 = p13:Extract_Token(v3)

				if not v7 then
					return
				end

				task.delay(5, function() --[[ Line: 202 | Upvalues: v2 (ref), v3 (copy), v13 (ref) ]]
					if not v2 then
						local v1 = ("TagPackageLoader:Load(\"%*\") taking longer than expected"):format((v3:GetFullName()))

						warn(v1)
						v13 = v13 .. (v1 or "") .. "\n"
					end
				end)

				local v8 = v3.Name

				debug.setmemorycategory(v8)

				local v92 = true
				local v102 = nil
				local v113 = ("[TagPackageLoader] REQUIRE %* failed: %%ERROR"):format(v3.Name)

				local function requireModule() --[[ requireModule | Line: 220 | Upvalues: v3 (copy), v112 (ref), v7 (copy), v14 (ref) ]]
					local v1 = require(v3)

					v112[v7] = v1
					v14[v3] = {
						Result = v1,
						Key = v7
					}
				end

				xpcall(requireModule, function(p13) --[[ Line: 227 | Upvalues: v113 (copy), v92 (ref), v102 (ref) ]]
					local v1 = v113:gsub("%%ERROR", (tostring(p13)))

					v92 = false
					v102 = v1
					warn("ERROR: " .. v1 .. "\n" .. debug.traceback())
				end)

				if not v92 then
					debug.setmemorycategory("post-TagPackageLoader-error")
					error(v102)
				end

				v13 = v13 .. "\n" .. (("[%* TagPackageLoader] Module \"%*\" finished requiring under \"%*\". (%* ms)"):format(if v1 then "Server" else "Client", v8, v9, (math.floor((os.clock() - v15) * 1000))) or "") .. "\n"

				local v142 = (debug.info(2, "s") or "unknown"):split(".")

				debug.setmemorycategory(v142[#v142])
				v12 = v12 + 1

				if v12 == sum2 then
					v11:AtTrace():SepLog()
					v11:AtTrace():Log((("\nSuccessfully loaded directories, (%*/%*): [%*]"):format(v12, sum2, (table.concat(p13:Read_Logger(), ", ")))))
					v11:AtTrace():SepLog()
				end
			end

			if p23 then
				perform()
			else
				task.spawn(perform)
			end

			if i % 400 == 0 then
				task.wait()
			end
		end
	end

	return p13
end

return v16