local size = math.random(4,8)
local size2 = math.random(0,9)
local size3 = tonumber(tostring(size)..'.'..tostring(size2))
script.Parent.Size = Vector3.new(0.05,size3,size3)
local generatecolor = math.random(1,6)
if generatecolor == 1 then
	script.Parent.Color = Color3.fromRGB(151, 0, 0)
elseif generatecolor == 2 then
	script.Parent.Color = Color3.fromRGB(226, 155, 64)
elseif generatecolor == 3 then
	script.Parent.Color = Color3.fromRGB(173, 143, 34)
elseif generatecolor == 4 then
	script.Parent.Color = Color3.fromRGB(39, 70, 45)
elseif generatecolor == 5 then
	script.Parent.Color = Color3.fromRGB(0, 32, 96)
elseif generatecolor == 6 then
	script.Parent.Color = Color3.fromRGB(61, 21, 133)
end	

script.Parent.Parent.Bool.Changed:Connect(function()
	local size = math.random(4,8)
	local size2 = math.random(0,9)
	local size3 = tonumber(tostring(size)..'.'..tostring(size2))
	script.Parent.Size = Vector3.new(0.05,size3,size3)
	local generatecolor = math.random(1,6)
	if generatecolor == 1 then
		script.Parent.Color = Color3.fromRGB(151, 0, 0)
	elseif generatecolor == 2 then
		script.Parent.Color = Color3.fromRGB(226, 155, 64)
	elseif generatecolor == 3 then
		script.Parent.Color = Color3.fromRGB(173, 143, 34)
	elseif generatecolor == 4 then
		script.Parent.Color = Color3.fromRGB(39, 70, 45)
	elseif generatecolor == 5 then
		script.Parent.Color = Color3.fromRGB(0, 32, 96)
	elseif generatecolor == 6 then
		script.Parent.Color = Color3.fromRGB(61, 21, 133)
	end	
end)
