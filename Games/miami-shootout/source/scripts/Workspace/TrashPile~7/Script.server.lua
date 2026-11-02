local rand = math.random(20,100)
local mathrand = math.random(10,25)

local pat = math.random(1,15)

wait(pat)

local ac = mathrand+rand

local decal = script.Parent.Decal

-- 1 = invisible
-- 0 = visible

while wait(ac) do

	if decal.Transparency == 1 then
		decal.Transparency = 0
	end

	if decal.Transparency ~= 0 and decal.Transparency ~= 1 then
		print("invalid!")
		decal.Transparency = 0
	end

end