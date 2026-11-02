local t = {}
local RunService = game:GetService("RunService")
local Util = game.ReplicatedStorage:WaitForChild("Util")
local t2 = {}

setmetatable(t, t)
function handleError(p1, p2) --[[ handleError | Line: 7 ]]
	print("bad index:", p2, "for", p1.Name)
	print("Did you perhaps mean: ")

	for k, v in pairs(p1) do
		if string.find(string.sub(p2, 1, #p2 / 2), k) or string.find(string.sub(p2, #p2 / 2), k) then
			print(k)
		end
	end
end
function load(p1, p2) --[[ load | Line: 20 | Upvalues: t2 (copy) ]]
	local v1 = p2:FindFirstChild(p1.Name)

	if not v1 then
		return
	end

	t2[p1.Name] = require(v1)

	for k, v in pairs(v1) do
		rawset(p1, k, v)
	end
end

local function FindPackage(p1, p2) --[[ FindPackage | Line: 29 | Upvalues: RunService (copy) ]]
	if RunService:IsServer() then
		load(p1, game.ServerScriptService.Util)
	end

	if RunService:IsClient() then
		load(p1, game.Players.LocalPlayer:WaitForChild("PlayerScripts").Util)
	end

	local v1 = rawget(p1, p2)

	if v1 then
		return v1
	end

	handleError(p1, p2)

	return v1
end

function PackageModule(p1) --[[ PackageModule | Line: 48 | Upvalues: FindPackage (copy) ]]
	local v1 = require(p1)

	if not v1.new then
		setmetatable(v1, v1)
		v1.Name = p1
		v1.__index = FindPackage
	end

	return v1
end

local function SearchInFolder(p1) --[[ SearchInFolder | Line: 58 | Upvalues: t (copy) ]]
	local t2 = {}

	setmetatable(t2, t2)
	function t2.__index(p1, p23) --[[ Line: 61 | Upvalues: p1 (copy), t2 (copy) ]]
		local v1 = p1:FindFirstChild(p23)

		if v1 then
			local v22 = PackageModule(v1)

			rawset(t2, p23, v22)

			return v22
		end
	end
	rawset(t, p1.Name, t2)

	return t2
end

for k, v in pairs(require(Util.Functional)) do
	t[k] = v
end

function t.__index(p1, p2) --[[ Line: 79 | Upvalues: Util (copy), t (copy), RunService (copy) ]]
	local v1 = nil
	local v2 = Util:FindFirstChild(p2)

	if v2 then
		if v2:IsA("Folder") then
			local t2 = {}

			setmetatable(t2, t2)
			function t2.__index(p1, p23) --[[ Line: 61 | Upvalues: v2 (copy), t2 (copy) ]]
				local v1 = v2:FindFirstChild(p23)

				if v1 then
					local v22 = PackageModule(v1)

					rawset(t2, p23, v22)

					return v22
				end
			end
			rawset(t, v2.Name, t2)

			return t2
		end

		local v5 = PackageModule(v2)

		rawset(t, p2, v5)

		return v5
	end

	if RunService:IsServer() then
		local v7 = game.ServerScriptService.Util:FindFirstChild(p2)

		if not v7 then
			task.spawn(error, "Server Module " .. p2 .. " not found in ServerScriptService.Util")
		end

		local v8 = PackageModule(v7)

		rawset(p1, p2, v8)
		v1 = v8
	end

	if RunService:IsClient() then
		local v9 = game.Players.LocalPlayer:WaitForChild("PlayerScripts").Util:FindFirstChild(p2)

		if not v9 then
			task.spawn(error, "Module " .. p2 .. " not found in PlayerScripts.Util\n" .. debug.traceback())
		end

		local v10 = PackageModule(v9)

		rawset(p1, p2, v10)
		v1 = v10
	end

	return v1
end
function t.Inject(p1, p2) --[[ Inject | Line: 108 | Upvalues: t (copy) ]]
	rawset(t, p1, p2)
end
function t.Import(p1) --[[ Import | Line: 112 | Upvalues: t (copy) ]]
	return t[p1]
end
t.Get = t.Import
function t.Service(p1) --[[ Service | Line: 117 ]]
	return game:GetService(p1)
end
function t.pcall(p1, ...) --[[ Line: 121 ]]
	local ok, result = pcall(p1, ...)

	if not ok then
		task.spawn(error, result)
	end

	return result
end
t.Inject("CS", game:GetService("CollectionService"))
t.Inject("TS", game:GetService("TweenService"))
t.Inject("RS", game:GetService("RunService"))
t.Inject("MS", game:GetService("MarketplaceService"))
t.Inject("Network", require(Util:WaitForChild("Net")))
t.Inject("UpdateRobuxPrice", Instance.new("BindableEvent"))
t.Inject("r", Random.new())

return t