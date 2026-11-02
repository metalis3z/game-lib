
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local t1 = {
	{
		"PhantomEvent",
		"Phantom"
	},
	{
		"CyberEvent",
		"Cyber"
	},
	{
		"DivineEvent",
		"Divine"
	},
	{
		"CursedEvent",
		"Cursed"
	},
	{
		"RadioactiveEvent",
		"Radioactive"
	},
	{
		"YinYangEvent",
		"YinYang"
	},
	{
		"GalaxyEvent",
		"Galaxy"
	},
	{
		"MoltenEvent",
		"Lava"
	},
	{
		"CandyEvent",
		"Candy"
	},
	{
		"BloodmoonEvent",
		"Bloodrot"
	}
}

local function getList()
	local t2 = {}

	for _, v8 in t1 do
		if ReplicatedStorage:GetAttribute(v8[1]) then
			table.insert(t2, v8[2])
		end
	end

	return t2
end
local function shallowEquals(p1, p2)
	if #p1 ~= #p2 then
		return false
	end

	for v11, v12 in p1 do
		if v12 ~= p2[v11] then
			return false
		end
	end

	return true
end

return {
	getList = getList,
	get = function()
		return getList()[1]
	end,
	watch = function(p3)
		local u14 = getList()

		local function tryUpdate()
			local v19 = getList()
			local v20 = u14
			local v21, g24

			if #v20 ~= #v19 then
				v21 = false
			else
				g24 = nil
				v21 = nil

				for v22, v23 in v20 do
					if v23 ~= v19[v22] then
						v21 = false
						g24 = true
					end

					if g24 then
						break
					end
				end

				if not g24 then
					v21 = true
				end
			end

			g24 = false

			if v21 then
				return
			end

			u14 = v19
			p3()
		end

		local v16 = Trove.new()

		for _, v18 in t1 do
			v16:Add(ReplicatedStorage:GetAttributeChangedSignal(v18[1]):Connect(tryUpdate))
		end

		return v16:WrapClean()
	end
}
