-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Asserts = require(Library.Asserts)
local Directory = require(ReplicatedStorage.Directory.Gamepasses).Directory
local Save = require(Library:WaitForChild("Client"):WaitForChild("Save"))
local t = {}

for k, v in pairs(Directory) do
	local ProductId = v.ProductId

	if ProductId and not t[ProductId] then
		t[ProductId] = v
	end
end

local t2 = {}

local function parseGamepassId(p1) --[[ parseGamepassId | Line: 24 | Upvalues: Directory (copy), Asserts (copy) ]]
	local v1

	if type(p1) == "number" then
		v1 = p1
	elseif type(p1) == "string" then
		local v2 = Directory[p1]

		assert(v2, (("Unknown gamepass: %*"):format(p1)))
		v1 = v2.ProductId
	else
		assert(Directory[p1._id] == p1, (("Unknown gamepass: %*"):format(p1)))
		v1 = p1.ProductId
	end

	Asserts.integer(v1)

	return v1
end

function t2.GetById(p1) --[[ GetById | Line: 40 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.integer(p1)

	return t[p1]
end
function t2.Owns(p1, p2) --[[ Owns | Line: 45 | Upvalues: parseGamepassId (copy), t (copy), Save (copy) ]]
	local v1 = t[parseGamepassId(p1)]

	assert(v1, (("Unknown gamepass: %*"):format(p1)))

	local v3 = Save.Get(p2)

	if not v3 then
		return false
	end

	return v3.Gamepasses[v1._id] == true
end
function t2.GetAll(p1) --[[ GetAll | Line: 58 | Upvalues: Players (copy), Save (copy) ]]
	local v2 = Save.Get(if p1 then p1 else Players.LocalPlayer)

	if v2 then
		return v2.Gamepasses
	end

	return {}
end

return t2