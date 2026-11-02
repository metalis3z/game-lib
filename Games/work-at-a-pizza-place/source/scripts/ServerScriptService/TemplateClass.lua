local ServerScriptService = script.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Template = {}
local Houses = Global.Houses
local Players = Global.Players
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


Template.__index = Template



function Template.new(object)
	
	
	
	local this = {}
	setmetatable(this, Template)
	this.Object = object


	return this

end





return Template
