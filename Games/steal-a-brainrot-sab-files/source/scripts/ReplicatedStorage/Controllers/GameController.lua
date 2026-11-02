-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local isLoaded = false
local queue = {}

return {
	Start = function()
		task.spawn(function()
			while ReplicatedFirst:GetAttribute("ClientLoaded") ~= true do
				task.wait()
			end

			while ReplicatedFirst:GetAttribute("DataLoaded") ~= true do
				task.wait()
			end

			isLoaded = true

			for i = 1, #queue do
				local callback = queue[i]
				task.spawn(callback)
			end

			table.clear(queue)
		end)
	end, 

	OnGameLoaded = function(self, callback)
		if isLoaded then
			return callback()
		else
			table.insert(queue, callback)
		end
	end
}