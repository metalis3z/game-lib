-- CONFIG
local MAIN_MODULE_ID = 3239236979
local FALLBACK_MODEL_ID = 857927023
local LOADER_VERSION = 1
local SANDBOX_FIX_MESSAGE = [[


[HD ADMIN SANDBOX FIX]

Roblox inserted this model in a sandboxed state, which stops HD Admin from running.
To fix it, select the 'HD Admin' folder in the Explorer, then paste this into the Command Bar and press enter

local selected = game.Selection:Get()[1]
for _, descendant in selected:GetDescendants() do descendant.Sandboxed = false end
while selected and selected ~= game do selected.Sandboxed = false selected = selected.Parent end

]]


-- LOCAL
local core = script.Parent
local loader = core.Parent
local InsertService = game:GetService("InsertService")


-- LOCAL FUNCTIONS
-- Apparently some models from the toolbox are randomly sandboxed which blocks essential
-- features so we detect this early and show the developer the fix
local function errorIfSandboxed()
	local success, problem = pcall(function()
		return (script :: any).Sandboxed
	end)
	if not success and type(problem) == "string" and string.find(problem, "lacking capability") then
		error(SANDBOX_FIX_MESSAGE)
	end
end

-- While we progressively roll over to v2, we can't guarantee the MainModule we're requiring actually
-- is v2, in the beginning it will be v1. This therefore stops a v1 application being loaded from v2
local function isUsableMainModule(candidate: any): boolean
	return type(candidate) == "table" and candidate.supportsV2 == true and type(candidate.initialize) == "function"
end

local function describeRejection(success: boolean, result: any): string
	if not success then
		return tostring(result)
	end
	return "the fetched module does not support v2 yet"
end

-- This tries first the MainModule then the Model, and if both of these fail, it
-- passes this information on to the 'your HD Admin is outdated' notice in-game
local function fetchLatestMainModule(): (any?, string?, string?)
	local success, result = pcall(require, MAIN_MODULE_ID)
	if success and isUsableMainModule(result) then
		return result, "live", nil
	end
	local liveReason = describeRejection(success, result)
	local fallbackSuccess, fallbackResult = pcall(function()
		local asset = InsertService:LoadAsset(FALLBACK_MODEL_ID)
		local moduleInstance = asset:FindFirstChild("MainModule", true)
		if not moduleInstance then
			error(`no MainModule found inside asset {FALLBACK_MODEL_ID}`)
		end
		return require(moduleInstance)
	end)
	if fallbackSuccess and isUsableMainModule(fallbackResult) then
		return fallbackResult, "backup", nil
	end
	local backupReason = describeRejection(fallbackSuccess, fallbackResult)
	return nil, nil, `live: {liveReason}, backup: {backupReason}`
end


-- SETUP
errorIfSandboxed()

-- Unparent and make nil right away so it never replicates to clients
local bundledModule = core:WaitForChild("MainModule", 10)
if bundledModule then
	bundledModule.Parent = nil
end

local autoUpdate = loader:GetAttribute("AutoUpdate")
if autoUpdate == nil then
	autoUpdate = true
end

loader:SetAttribute("HDApp", "v2")
loader:SetAttribute("HDLoaderVersion", LOADER_VERSION)

local handshake = {
	app = "v2",
	loaderVersion = LOADER_VERSION,
	autoUpdate = autoUpdate,
	updateSource = "bundled",
}
local mainModule = nil

if autoUpdate then
	-- This script can never be updated once shipped, so if the update logic itself
	-- has a bug we catch it here and still start the bundled copy
	local success, fetchedModule, fetchedSource, failReason = pcall(fetchLatestMainModule)
	if success then
		mainModule = fetchedModule
		if fetchedModule then
			handshake.updateSource = fetchedSource
		end
		handshake.updateFailReason = failReason
	else
		warn("HD Admin hit an unexpected error while checking for updates, loading the copy bundled inside this loader instead\nReason: " .. tostring(fetchedModule))
		handshake.updateFailReason = tostring(fetchedModule)
	end
end

-- We always include the full application inside the loader so games keep working
-- even if every remote source fails
if not mainModule then
	if not bundledModule then
		error("HD Admin could not find the MainModule bundled inside this loader. Try reinstalling HD Admin from the Creator Store")
	end
	mainModule = require(bundledModule)
end
mainModule.initialize(loader, handshake)