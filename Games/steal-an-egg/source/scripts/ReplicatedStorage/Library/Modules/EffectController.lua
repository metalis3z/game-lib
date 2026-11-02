-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Effects = script.Effects
local Libraries = script.Libraries
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Types)

local t = {}
local t2 = {
	Init = function(p1, p2) --[[ Init | Line: 15 | Upvalues: Effects (copy), Libraries (copy) ]]
		p1.Components = {}
		p1.Libraries = {}

		for k, v in pairs(Effects:GetDescendants()) do
			if v.ClassName == "ModuleScript" then
				task.spawn(function() --[[ Line: 20 | Upvalues: v (copy), p1 (copy) ]]
					local ok, result = pcall(require, v)

					if not ok then
						return
					end

					p1.Components[v.Name] = result
				end)
			end
		end

		for k, v in pairs(Libraries:GetChildren()) do
			if v.ClassName == "ModuleScript" then
				task.spawn(function() --[[ Line: 30 | Upvalues: v (copy), p1 (copy) ]]
					local ok, result = pcall(require, v)

					if not ok then
						return
					end

					p1.Libraries[v.Name] = result
				end)
			end
		end
	end,
	SplitName = function(p1, p2) --[[ SplitName | Line: 40 ]]
		local v1 = p2:split("/")

		if v1 then
			return v1[1], v1[2]
		end
	end,
	FetchComponent = function(p1, p2) --[[ FetchComponent | Line: 48 ]]
		if p1.Components[p2] then
			return p1.Components[p2]
		end

		warn(("Invalid Effect Name: %s, Component not Found."):format(p2))

		return nil
	end,
	FetchCache = function(p1, p2, p3) --[[ FetchCache | Line: 57 | Upvalues: t (copy), Trove (copy) ]]
		if not t[p2] then
			t[p2] = {}
		end

		if not t[p2][p3] then
			t[p2][p3] = {
				Cache = {},
				Container = Trove.new()
			}
		end

		return t[p2][p3]
	end,
	Play = function(p1, p2) --[[ Play | Line: 70 ]]
		if not p2.caster then
			warn(("No caster found in data table %s."):format((tostring(p2))))

			return false
		end

		local v1, v2 = p1:SplitName(p2.name_State)
		local v3 = p1:FetchComponent(v1)
		local v4 = if v3 then v3[v2] else v3
		local v5 = if v3 then p1:FetchCache(p2.caster, v3) else v3

		if v3 and (v4 and v5) then
			task.spawn(v4, {
				Caster = p2.caster,
				Parameters = p2.parameters,
				Libraries = p1.Libraries,
				Default = p1.Libraries.Default,
				Cache = v5.Cache,
				Container = v5.Container
			})

			return true
		end

		warn(("Component Found: %s, Callback Found: %s, Cache Found: %s."):format(tostring(v3), tostring(v4), (tostring(v5))))

		return false
	end,
	Request = function(p1, p2) --[[ Request | Line: 103 ]]
		error("unimplemented")
	end
}

task.spawn(t2.Init, t2, Players.LocalPlayer)

return t2