-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = require(script.Parent)
	local Vector = require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Vector"))
	local Matrix = require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Matrix"))
	local v2 = v1.Cellular.new()

	v2:SetFrequency(1)
	v2:SetAmplitude(1)
	v2:GeneratePoints(30, Vector.new(0, 0), Vector.new(1, 1))

	local v3 = v2:ToMatrix(100)
	local t = {}

	for i = 1, 100 do
		t[i] = {}

		for j = 1, 100 do
			t[i][j] = 0
		end
	end

	for i, v in ipairs(v2.Points) do
		local v4 = (v * 100):Round()

		t[v4[1]][v4[2]] = 1
	end

	local t2 = {}

	for k = 1, 100 do
		t2[k] = Vector.new(unpack(t[k]))
	end

	v2:Debug(p1, 4, Matrix.new(unpack(t2)), v3)

	return function() --[[ Line: 37 ]] end
end