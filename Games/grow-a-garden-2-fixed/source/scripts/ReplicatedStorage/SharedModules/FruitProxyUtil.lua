--credit to quartz games studio
local WeightFormat = require(script.Parent.WeightFormat)
local t = {}

local function IsFruitProxy(p1) --[[ IsFruitProxy | Line: 7 ]]
	return p1:IsA("Configuration") and p1:GetAttribute("FruitProxy") == true
end

local function IsFruitTool(p1) --[[ IsFruitTool | Line: 11 ]]
	return p1:IsA("Tool") and p1:GetAttribute("HarvestedFruit") == true
end

local function IsFruitInstance(p1) --[[ IsFruitInstance | Line: 15 ]]
	return p1:IsA("Configuration") and (if p1:GetAttribute("FruitProxy") == true then true else false) or p1:IsA("Tool") and p1:GetAttribute("HarvestedFruit") == true
end

local function SetFruitAttributes(p1, p2) --[[ SetFruitAttributes | Line: 19 | Upvalues: WeightFormat (copy) ]]
	for v1, v2 in p2 do
		p1:SetAttribute(v1, v2)
	end

	p1:SetAttribute("HarvestedFruit", true)
	p1:SetAttribute("Fruit", p2.FruitName)
	p1:SetAttribute("Weight", p2.Weight)

	local v3 = WeightFormat.FormatGrams(p2.Weight or 0)

	p1.Name = ("%*%* [%*]"):format(p2.FruitName, p2.Mutation and (" [%*]"):format(p2.Mutation) or "", v3)
end

local function CreateProxy(p1) --[[ CreateProxy | Line: 32 | Upvalues: SetFruitAttributes (copy) ]]
	local Configuration = Instance.new("Configuration")

	Configuration:SetAttribute("FruitProxy", true)
	SetFruitAttributes(Configuration, p1)

	return Configuration
end

local function CreateTool(p1, p2) --[[ CreateTool | Line: 39 | Upvalues: SetFruitAttributes (copy) ]]
	local v1 = p1:Clone()

	SetFruitAttributes(v1, p2)

	return v1
end

local Networking = require(script.Parent.Networking)

local function RequestPromote(p1) --[[ RequestPromote | Line: 47 | Upvalues: Networking (copy) ]]
	task.spawn(function() --[[ Line: 48 | Upvalues: Networking (ref), p1 (copy) ]]
		Networking.Backpack.PromoteFruit:Fire(p1)
	end)
end

local function RequestDemote(p1) --[[ RequestDemote | Line: 53 | Upvalues: Networking (copy) ]]
	task.spawn(function() --[[ Line: 54 | Upvalues: Networking (ref), p1 (copy) ]]
		Networking.Backpack.DemoteFruit:Fire(p1)
	end)
end

t.IsFruitProxy = IsFruitProxy
t.IsFruitTool = IsFruitTool
t.IsFruitInstance = IsFruitInstance
t.SetFruitAttributes = SetFruitAttributes
t.CreateProxy = CreateProxy
t.CreateTool = CreateTool
t.RequestPromote = RequestPromote
t.RequestDemote = RequestDemote
t.Pending = {
	Equip = nil,
	Slots = {}
}

return t