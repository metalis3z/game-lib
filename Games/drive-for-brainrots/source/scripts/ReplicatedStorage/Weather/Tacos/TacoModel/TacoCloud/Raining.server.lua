-- credit wolfawesome123456
local tacos = script.Parent.Taco
local base = script.Parent
local baseLocX = base.CFrame.X
local baseLocZ = base.CFrame.Z
local baseLocY = base.CFrame.y
local baseSizeX = base.Size.x / 2
local baseSizeZ = base.Size.z / 2 
local baseSizeY = base.Size.y

_G.numberofTacos = 0 -- do not change unless you know what you are doing


local maxTacos = 100000 --change number of spawning tacos here, would only change if you change the actual size or change how long a taco is alive

--print(baseSizeX, baseSizeZ, baseSizeY)

function spawnTacos(x,y,z, max, locX,locY,locZ)
	--Spawns tacos in random locations
	--this loop will not break if maxTacos is high enough and wait time of tacos is low, if the loop breaks it can look choppy there are ways to fix that
	while _G.numberofTacos ~= max do
		-- randx and randz let tacos spawn within the base 'TacoCloud' at position then adds the size so tacos do not spawn in the center all the time
		local randX = locX + math.random(-x,x)

		local randZ = locZ + math.random(-z,z)
		local tacoClone = tacos:Clone()
		tacoClone.Position = Vector3.new(randX, locY, randZ)
		tacoClone.Anchored = false --do not delete
		tacoClone.Parent = script.Parent.clones
		_G.numberofTacos +=1
		
		wait(0) -- change the timing of when a taco falls the lower the faster they will spawn
	end




end
function spawnNewTaco(max)
	--kinda redundant but works for testing so I left it in here 
	if _G.numberofTacos ~= max then
		
		spawnTacos(baseSizeX, baseSizeY, baseSizeZ, max, baseLocX,baseLocY, baseLocZ)
		--print("spawned taco")
		
	end



end	

while true do --sorry if runtime error :)
	spawnNewTaco(maxTacos)
	wait(1)
end
