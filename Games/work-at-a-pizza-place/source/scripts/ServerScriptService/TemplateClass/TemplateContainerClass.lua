local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Template = Global.Template
local Houses = Global.Houses
local Players = Global.Players
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


Template.AllData = {}




function Template:Initialize()
	
end



--keep at bottom
setmetatable(Template, {
	__index = Template.AllData,
	__newindex = Template.AllData
})


return Template


