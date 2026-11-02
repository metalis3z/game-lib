--!strict
local Object = script.Parent
local Packages = Object.Parent.Parent

local None = require(Object.None)

return function<T, U, V, W>(target: T, source0: U?, source1: V?, source2: W?, ...): T & U & V & W
	if source0 ~= nil and typeof(source0 :: any) == "table" then
		for key, value in pairs(source0 :: any) do
			if value == None then
				(target :: any)[key] = nil
			else
				(target :: any)[key] = value
			end
		end
	end

	if source1 ~= nil and typeof(source1 :: any) == "table" then
		for key, value in pairs(source1 :: any) do
			if value == None then
				(target :: any)[key] = nil
			else
				(target :: any)[key] = value
			end
		end
	end

	if source2 ~= nil and typeof(source2 :: any) == "table" then
		for key, value in pairs(source2 :: any) do
			if value == None then
				(target :: any)[key] = nil
			else
				(target :: any)[key] = value
			end
		end
	end

	for index = 1, select("#", ...) do
		local rest = select(index, ...)

		if rest ~= nil and typeof(rest) == "table" then
			for key, value in pairs(rest) do
				if value == None then
					(target :: any)[key] = nil
				else
					(target :: any)[key] = value
				end
			end
		end
	end

	return (target :: any) :: T & U & V & W
end