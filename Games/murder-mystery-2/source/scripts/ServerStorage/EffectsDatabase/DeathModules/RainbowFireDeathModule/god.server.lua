local Fire = script.Parent

local add = 10
local k = 1
local x = 215
while true do
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(255/255,k/255,0/255)
		k = k + add
		wait()
	end
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(255/255 - k/255,255/255,0/255)
		k = k + add
		wait()
	end
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(0/255,255/255,k/255)
		k = k + add
		wait()
	end
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(0/255,255/255 - k/255,255/255)
		k = k + add
		wait()
	end
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(k/255,0/255,255/255)
		k = k + add
		wait()
	end
	k = 1
	while k <= 255 do
		Fire.Color = Color3.new(255/255,0/255,255/255 - k/255)
		k = k + add
		wait()
	end
	while k <= 255 do
		Fire.Color = Color3.new(255/255 - k/255,0/255,0/255)
		k = k + add
		wait()
	end
end