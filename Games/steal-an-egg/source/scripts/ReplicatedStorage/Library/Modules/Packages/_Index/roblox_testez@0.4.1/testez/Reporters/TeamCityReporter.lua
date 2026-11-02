-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local t = {}

local function teamCityEscape(p1) --[[ teamCityEscape | Line: 7 ]]
	return string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")
end

local function teamCityEnterSuite(p1) --[[ teamCityEnterSuite | Line: 14 ]]
	return string.format("##teamcity[testSuiteStarted name=\'%s\']", (string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end

local function teamCityLeaveSuite(p1) --[[ teamCityLeaveSuite | Line: 18 ]]
	return string.format("##teamcity[testSuiteFinished name=\'%s\']", (string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end

local function teamCityEnterCase(p1) --[[ teamCityEnterCase | Line: 22 ]]
	return string.format("##teamcity[testStarted name=\'%s\']", (string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end

local function teamCityLeaveCase(p1) --[[ teamCityLeaveCase | Line: 26 ]]
	return string.format("##teamcity[testFinished name=\'%s\']", (string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end

local function teamCityFailCase(p1, p2) --[[ teamCityFailCase | Line: 30 ]]
	return string.format("##teamcity[testFailed name=\'%s\' message=\'%s\']", string.gsub(string.gsub(string.gsub(p1, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n"), (string.gsub(string.gsub(string.gsub(p2, "([]|\'[])", "|%1"), "\r", "|r"), "\n", "|n")))
end

local function v1(p1, p2, p3) --[[ reportNode | Line: 38 | Upvalues: TestEnum (copy), teamCityEnterSuite (copy), v1 (copy), teamCityLeaveSuite (copy), teamCityEnterCase (copy), teamCityFailCase (copy), teamCityLeaveCase (copy) ]]
	local v12 = if p2 then p2 else {}
	local v2 = p3 or 0

	if p1.status == TestEnum.TestStatus.Skipped then
		return v12
	end

	if p1.planNode.type == TestEnum.NodeType.Describe then
		table.insert(v12, teamCityEnterSuite(p1.planNode.phrase))

		local v4 = v12

		for i, v in ipairs(p1.children) do
			v1(v, v4, v2 + 1)
		end

		table.insert(v4, teamCityLeaveSuite(p1.planNode.phrase))
	else
		table.insert(v12, teamCityEnterCase(p1.planNode.phrase))

		if p1.status == TestEnum.TestStatus.Failure then
			table.insert(v12, teamCityFailCase(p1.planNode.phrase, table.concat(p1.errors, "\n")))
		end

		table.insert(v12, teamCityLeaveCase(p1.planNode.phrase))
	end
end

local function reportRoot(p1) --[[ reportRoot | Line: 59 | Upvalues: v1 (copy) ]]
	local t = {}

	for i, v in ipairs(p1.children) do
		v1(v, t, 0)
	end

	return t
end

local function report(p1) --[[ report | Line: 69 | Upvalues: reportRoot (copy) ]]
	return table.concat(reportRoot(p1), "\n")
end

function t.report(p1) --[[ report | Line: 75 | Upvalues: reportRoot (copy), TestService (copy) ]]
	local t = {}
	local v1 = reportRoot(p1)

	t[1] = "Test results:"
	t[2] = table.concat(v1, "\n")
	t[3] = ("%d passed, %d failed, %d skipped"):format(p1.successCount, p1.failureCount, p1.skippedCount)
	print(table.concat(t, "\n"))

	if p1.failureCount > 0 then
		print(("%d test nodes reported failures."):format(p1.failureCount))
	end

	if not (#p1.errors > 0) then
		return
	end

	print("Errors reported by tests:")
	print("")

	for i, v in ipairs(p1.errors) do
		TestService:Error(v)
		print("")
	end
end

return t