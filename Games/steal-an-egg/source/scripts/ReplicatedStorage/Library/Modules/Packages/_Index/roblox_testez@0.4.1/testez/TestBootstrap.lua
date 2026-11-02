-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TestPlanner = require(script.Parent.TestPlanner)
local TestRunner = require(script.Parent.TestRunner)
local TextReporter = require(script.Parent.Reporters.TextReporter)
local t = {}

local function stripSpecSuffix(p1) --[[ stripSpecSuffix | Line: 11 ]]
	return p1:gsub("%.spec$", "")
end

local function isSpecScript(p1) --[[ isSpecScript | Line: 14 ]]
	return p1:IsA("ModuleScript") and p1.Name:match("%.spec$")
end

local function getPath(p1, p2) --[[ getPath | Line: 18 ]]
	local v1 = if p2 then p2 else game
	local t = {}
	local v2, v3

	if p1.Name == "init.spec" then
		v2 = p1.Parent
		v3 = v1
	else
		v2 = p1
		v3 = v1
	end

	while v2 ~= nil and v2 ~= v3 do
		table.insert(t, (v2.Name:gsub("%.spec$", "")))
		v2 = v2.Parent
	end

	table.insert(t, (v3.Name:gsub("%.spec$", "")))

	return t
end

local function toStringPath(p1) --[[ toStringPath | Line: 38 ]]
	local v1 = true
	local v2 = ""

	for i, v in ipairs(p1) do
		if v1 then
			v1 = false
			v2 = v

			continue
		end

		v2 = v .. " " .. v2
	end

	return v2
end

function t.getModulesImpl(p1, p2, p3, p4) --[[ getModulesImpl | Line: 52 | Upvalues: getPath (copy) ]]
	local v2 = p4 or p2
	local v3 = v2:IsA("ModuleScript")

	if not (v3 and v2.Name:match("%.spec$")) then
		return
	end

	local v6 = require(v2)
	local v7 = getPath(v2, p2)
	local v8, v9, v10 = true, "", if p3 then p3 else {}

	for i, v in ipairs(v7) do
		if v8 then
			v8 = false
			v9 = v

			continue
		end

		v9 = v .. " " .. v9
	end

	table.insert(v10, {
		method = v6,
		path = v7,
		pathStringForSorting = v9:lower()
	})
end
function t.getModules(p1, p2) --[[ getModules | Line: 72 ]]
	local t = {}

	p1:getModulesImpl(p2, t)

	for i, v in ipairs(p2:GetDescendants()) do
		p1:getModulesImpl(p2, t, v)
	end

	return t
end
function t.run(p1, p2, p3, p4) --[[ run | Line: 99 | Upvalues: TextReporter (copy), TestPlanner (copy), TestRunner (copy) ]]
	local v2 = if p4 then p4 else {}

	if type(p2) ~= "table" then
		error(("Bad argument #1 to TestBootstrap:run. Expected table, got %s"):format((typeof(p2))), 2)
	end

	local v5 = tick()
	local t, v6 = {}, if p3 then p3 else TextReporter

	for i, v in ipairs(p2) do
		for i2, v8 in ipairs((p1:getModules(v))) do
			table.insert(t, v8)
		end
	end

	local v8 = tick()
	local v9 = TestPlanner.createPlan(t, v2.testNamePattern, v2.extraEnvironment or {})
	local v10 = tick()
	local v11 = TestRunner.runPlan(v9)
	local v12 = tick()

	v6.report(v11)

	local v13 = tick()

	if not v2.showTimingInfo then
		return v11
	end

	print(table.concat({
		("Took %f seconds to locate test modules"):format(v8 - v5),
		("Took %f seconds to create test plan"):format(v10 - v8),
		("Took %f seconds to run tests"):format(v12 - v10),
		("Took %f seconds to report tests"):format(v13 - v12)
	}, "\n"))

	return v11
end

return t