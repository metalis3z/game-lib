--!strict
print("[Bootstrap] Starting require phase...")

local function safeRequire(label: string, path: Instance)
	local ok, result = pcall(require, path)
	if ok then
		print("[Bootstrap] Require OK: " .. label)
		return result
	else
		warn("[Bootstrap] Require FAILED: " .. label .. " -> " .. tostring(result))
		return nil
	end
end

script:SetAttribute("RequireStage", "Data")
local Data = safeRequire("Core_PlayerData", script.Parent.Core_PlayerData)
script:SetAttribute("RequireStage", "Plots")
local Plots = safeRequire("Core_Plots", script.Parent.Core_Plots)
script:SetAttribute("RequireStage", "Assets")
local ActiveAssets = safeRequire("Core_Assets", script.Parent.Core_Assets)
script:SetAttribute("RequireStage", "Eggs")
local Eggs = safeRequire("Core_Eggs", script.Parent.Core_Eggs)
script:SetAttribute("RequireStage", "Treadmills")
local Treadmills = safeRequire("Core_Treadmills", script.Parent.Core_Treadmills)
script:SetAttribute("RequireStage", "Guards")
local Guards = safeRequire("Core_Guards", script.Parent.Core_Guards)
script:SetAttribute("RequireStage", "Progression")
local Progression = safeRequire("Core_Progression", script.Parent.Core_Progression)
script:SetAttribute("RequireStage", "Trails")
local Trails = safeRequire("Core_Trails", script.Parent.Core_Trails)
script:SetAttribute("RequireStage", "Compatibility")
local Compatibility = safeRequire("Core_Compatibility", script.Parent.Core_Compatibility)
script:SetAttribute("RequireStage", "Purchases")
local Purchases = safeRequire("Core_Purchases", script.Parent.Core_Purchases)
script:SetAttribute("RequireStage", "Done")

print("[Bootstrap] Require phase complete. Data=" .. tostring(Data ~= nil) .. " Plots=" .. tostring(Plots ~= nil))

-- Wrap each Init in pcall so a failure in one system does not prevent
-- Data.Start() from running (which is critical for plot assignment).
local function safeInit(label: string, fn: () -> ())
	local ok, err = pcall(fn)
	if not ok then
		warn(("[Bootstrap] %s failed: %s"):format(label, tostring(err)))
	end
end

print("[Bootstrap] Starting Init phase...")

script:SetAttribute("BootStage", "Plots")
if Plots and Data then
	safeInit("Plots", function() Plots.Init(Data) end)
else
	warn("[Bootstrap] Skipping Plots.Init - missing Data or Plots module")
end
script:SetAttribute("BootStage", "Assets")
if ActiveAssets and Data and Plots then
	safeInit("Assets", function() ActiveAssets.Init(Data, Plots) end)
else
	warn("[Bootstrap] Skipping Assets.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Eggs")
if Eggs and Data and Plots and ActiveAssets then
	safeInit("Eggs", function() Eggs.Init(Data, Plots, ActiveAssets) end)
else
	warn("[Bootstrap] Skipping Eggs.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Guards")
if Guards and Eggs then
	safeInit("Guards", function() Guards.Init(Eggs) end)
else
	warn("[Bootstrap] Skipping Guards.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Treadmills")
if Treadmills and Data and Plots then
	safeInit("Treadmills", function() Treadmills.Init(Data, Plots) end)
else
	warn("[Bootstrap] Skipping Treadmills.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Progression")
if Progression and Data then
	safeInit("Progression", function() Progression.Init(Data) end)
else
	warn("[Bootstrap] Skipping Progression.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Trails")
if Trails and Data and Treadmills then
	safeInit("Trails", function() Trails.Init(Data, Treadmills) end)
else
	warn("[Bootstrap] Skipping Trails.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Compatibility")
if Compatibility then
	safeInit("Compatibility", function() Compatibility.Init() end)
else
	warn("[Bootstrap] Skipping Compatibility.Init - missing module")
end
script:SetAttribute("BootStage", "Purchases")
if Purchases and Data and Eggs and Treadmills and ActiveAssets then
	safeInit("Purchases", function() Purchases.Init(Data, Eggs, Treadmills, ActiveAssets) end)
else
	warn("[Bootstrap] Skipping Purchases.Init - missing dependencies")
end
script:SetAttribute("BootStage", "Data")
if Data then
	safeInit("Data", function() Data.Start() end)
else
	warn("[Bootstrap] CRITICAL: Data module failed to load - plot assignment will not work!")
end
script:SetAttribute("BootStage", "Ready")

print("[StealAnEgg] Server systems are ready")
