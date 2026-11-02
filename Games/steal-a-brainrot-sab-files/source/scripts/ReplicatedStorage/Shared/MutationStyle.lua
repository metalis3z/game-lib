

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Index = require(Datas.Index)
local Mutations = require(Datas.Mutations)
local t1 = {
	Rainbow = "Rainbow",
	Christmas = "SlowGreenRed"
}
local t2 = {}

local function getGradientPreset(s1: string)
	return t1[s1]
end
local function getColor(s2: string)
	if t1[s2] then
		return nil
	end

	local v13 = Index[s2] or Mutations[s2]

	return v13 and v13.MainColor
end
local function applyToLabel(p1, s3: string?)
	if not s3 then
		return nil
	end

	local v16 = t1[s3]

	if v16 then
		p1.TextColor3 = Color3.fromRGB(255, 255, 255)

		return Gradients.apply(p1, v16)
	end

	local v17

	if t1[s3] then
		v17 = nil
	else
		local v18 = Index[s3] or Mutations[s3]

		v17 = v18 and v18.MainColor
	end

	if v17 then
		p1.TextColor3 = v17
	end

	return nil
end

t2.GetGradientPreset = getGradientPreset
t2.GetColor = getColor
t2.ApplyToLabel = applyToLabel

return table.freeze(t2)
