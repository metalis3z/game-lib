-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Expectation = require(script.Expectation)
local TestBootstrap = require(script.TestBootstrap)
local TestEnum = require(script.TestEnum)
local TestPlan = require(script.TestPlan)
local TestPlanner = require(script.TestPlanner)
local TestResults = require(script.TestResults)
local TestRunner = require(script.TestRunner)
local TestSession = require(script.TestSession)
local TextReporter = require(script.Reporters.TextReporter)
local TextReporterQuiet = require(script.Reporters.TextReporterQuiet)
local TeamCityReporter = require(script.Reporters.TeamCityReporter)
local v1 = {}

function v1.run(v2, v3) -- line 18 | captures: TestBootstrap, TestPlanner, TestRunner
    local v4 = TestBootstrap:getModules(v2)
    local v5 = TestPlanner.createPlan(v4)
    v3((TestRunner.runPlan(v5)))
end

v1.Expectation = Expectation
v1.TestBootstrap = TestBootstrap
v1.TestEnum = TestEnum
v1.TestPlan = TestPlan
v1.TestPlanner = TestPlanner
v1.TestResults = TestResults
v1.TestRunner = TestRunner
v1.TestSession = TestSession
v1.Reporters = {
    TextReporter = TextReporter,
    TextReporterQuiet = TextReporterQuiet,
    TeamCityReporter = TeamCityReporter
}
return v1
