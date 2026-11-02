--credit to leon games studio
local t = {
	Products = {},
	Gamepasses = {}
}
local t2 = {}
local t3 = {}

local function indexProduct(p1) --[[ indexProduct | Line: 9 | Upvalues: t2 (copy), t3 (copy) ]]
	if type(p1) == "table" and type(p1.Key) == "string" then
		t2[p1.Key] = p1
	end

	if type(p1) ~= "table" then
		return
	end

	if type(p1.ProductId) ~= "number" then
		return
	end

	t3[p1.ProductId] = p1
end

local function addProduct(p1) --[[ addProduct | Line: 19 | Upvalues: t (copy), t2 (copy), t3 (copy) ]]
	t.Products[#t.Products + 1] = p1

	if type(p1) == "table" and type(p1.Key) == "string" then
		t2[p1.Key] = p1
	end

	if type(p1) ~= "table" then
		return
	end

	if type(p1.ProductId) ~= "number" then
		return
	end

	t3[p1.ProductId] = p1
end

local t4 = {}

for v1, v2 in t.Products do
	if type(v2) == "table" and type(v2.Key) == "string" then
		t2[v2.Key] = v2
	end

	if type(v2) == "table" and type(v2.ProductId) == "number" then
		t3[v2.ProductId] = v2
	end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.SharedModules.SeedData)
require(ReplicatedStorage.SharedModules.Networking)

local SeedShop = ReplicatedStorage:WaitForChild("StockValues"):WaitForChild("SeedShop")

SeedShop:WaitForChild("Items")
SeedShop:WaitForChild("UnixNextRestock")
SeedShop:WaitForChild("UnixLastRestock")

local function getSeedProductKey(p1) --[[ getSeedProductKey | Line: 37 ]]
	return "Seed:" .. p1
end

function t.GetByKey(p1) --[[ GetByKey | Line: 41 | Upvalues: t2 (copy) ]]
	return t2[p1]
end
function t.GetByProductId(p1) --[[ GetByProductId | Line: 45 | Upvalues: t3 (copy) ]]
	return t3[p1]
end
function t.GetSeedProductKey(p1) --[[ GetSeedProductKey | Line: 49 ]]
	return "Seed:" .. p1
end
function t.AddProduct(p1) --[[ AddProduct | Line: 53 | Upvalues: t (copy), t2 (copy), t3 (copy) ]]
	t.Products[#t.Products + 1] = p1

	if type(p1) == "table" and type(p1.Key) == "string" then
		t2[p1.Key] = p1
	end

	if type(p1) ~= "table" then
		return
	end

	if type(p1.ProductId) ~= "number" then
		return
	end

	t3[p1.ProductId] = p1
end
function t.AddGamepass(p1) --[[ AddGamepass | Line: 57 | Upvalues: t (copy), t4 (copy) ]]
	t.Gamepasses[p1.Key] = p1

	if type(p1.GamepassId) ~= "number" then
		return
	end

	t4[p1.GamepassId] = p1
end
function t.GetByGamepassId(p1) --[[ GetByGamepassId | Line: 64 | Upvalues: t4 (copy) ]]
	return t4[p1]
end
function t.GetGamepassByKey(p1) --[[ GetGamepassByKey | Line: 68 | Upvalues: t (copy) ]]
	return t.Gamepasses[p1]
end

return t