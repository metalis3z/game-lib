--// BatArchiTechMan

local Chance = math.random(1, 3)

script.Parent.Chemical.BrickColor = BrickColor.Random()

if Chance == 1 then
	script.Parent:Destroy()
end