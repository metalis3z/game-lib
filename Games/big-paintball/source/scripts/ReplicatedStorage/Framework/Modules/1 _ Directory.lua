--[[

    aimee was here fuck you local mf rbx.lua Framework [2023]
    WRITTEN BY ME, AIMEE. YOU DICKWAD
    Developed with a keyboard and pixie dust.
    
--]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local debugInit = true

----------------------

local Directory = {}

----------------------


--- Iterate through (physical) directory
for _, dirFolder in ipairs(script:GetChildren()) do
	--- Debug
	if debugInit then  
		print('-----------------------------------------------')  
	end

	--- Setup directory
	local dirName = dirFolder.Name
	Directory[dirName] = {}
	local dirData = Directory[dirName]

	--- Folder? Scan it!
	for _, module in ipairs(dirFolder:GetDescendants()) do
		if module.ClassName == "ModuleScript" then
			--- Add module to directory
			local moduleData = require(module)
			for key, value in pairs(moduleData) do
				dirData[key] = value
				if debugInit then  print(key, value)  end
			end
		end
	end

	--- Debug
	if debugInit then  
		print('-----------------------------------------------\nLOADED '.. dirName)  
	end
end

function Directory.NumberIDs(dirFolderName)
	return #script[dirFolderName]:GetChildren()
end

----------------------

return Directory