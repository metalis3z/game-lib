-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: MenuRoot, time of decompilation: Sun May  3 10:11:16 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local SubMenu = require(ReplicatedStorage.Source.Features.App.Components.SubMenu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local t1 = {}
local t2 = {}
local t3 = {}
local t4 = {}
local u10 = false

local function registerModule(p1) -- line: 25
	-- upvalues: t2 (copy), t1 (copy), t4 (copy), t3 (copy)
	if not p1:IsA("ModuleScript") or (not p1.Name:find("Menu") or p1 == script or p1.Name == "Menu" or p1.Name == "SubMenu") then
		return
	end

	local lib = require(p1)
	local v17 = p1.Name:find("SubMenu") ~= nil
	local v18 = if type(lib) ~= "table" then nil else if not v17 then lib.menuId else lib.subMenuId or lib.menuId

	if type(lib) ~= "table" or not v18 or not lib.Component then
		return
	end

	local v19 = if not v17 then t1 else t2
	local v20 = if not v17 then t3 else t4

	if lib.alwaysMounted then
		table.insert(v19, lib.Component())

		return
	end

	v20[v18] = function() -- line: 50
		-- upvalues: lib (copy)
		return lib.Component(), 1
	end
end

return function() -- line: 66
	-- upvalues: u10 (ref), ReplicatedStorage (copy), registerModule (copy), Vide (copy), screenCoveredSource (copy), Menu (copy), SubMenu (copy), t1 (copy), t3 (copy), t2 (copy), t4 (copy)
	if not u10 then
		u10 = true

		for _, v24 in ReplicatedStorage.Source.Features:GetDescendants() do
			registerModule(v24)
		end
	end

	local v25 = Vide.derive(function() -- line: 69
		-- upvalues: screenCoveredSource (copy), Menu (copy)
		if screenCoveredSource() then
			return nil
		end

		return (Menu.openedMenu())
	end)
	local v26 = Vide.derive(function() -- line: 73
		-- upvalues: screenCoveredSource (copy), Menu (copy), SubMenu (copy)
		if screenCoveredSource() or Menu.openedMenu() == nil then
			return nil
		end

		return SubMenu.openedMenu()
	end)

	Vide.effect(function() -- line: 81
		-- upvalues: Menu (copy), SubMenu (copy)
		if Menu.openedMenu() == nil and SubMenu.openedMenu() ~= nil then
			SubMenu.openedMenu(nil)
		end
	end)

	return {
		t1,
		Vide.switch(v25)(t3),
		t2,
		Vide.switch(v26)(t4)
	}
end
