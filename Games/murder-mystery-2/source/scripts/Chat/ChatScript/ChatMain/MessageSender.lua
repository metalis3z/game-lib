--	// FileName: MessageSender.lua
--	// Written by: Xsitsu
--	// Description: Module to centralize sending message functionality.

local module = {}
local blacklisted = {"/murderer","/map","/sheriff"}
local commands = {"/murderer","/map","/sheriff"}
local blacklistedMessage =  "This message contains inappropriate insults."
local filterList = {
	"PRISM",
	"AL3X",
	"SUB0",
	"D3NIS",
	"SK3TCH",
	"G0LD3NB4TW1NG",
	"0C34N",
	"B34CHB411",
	"SUMMERW1NG",
	"4THJULY",
	"GH0ST",
	"H4UNTEDH0US3",
	"T0X1C",
	"FLASHLIGHT",
	"Alien",
	"TEAMGREEN",
	"TEAMBLUE",
	"M00NH3X",
	"M1CKEYMOUSE",
	"CarrotBlade",
	"RoadTo50M!",
}
--////////////////////////////// Include
--//////////////////////////////////////
local modulesFolder = script.Parent

--////////////////////////////// Methods
--//////////////////////////////////////
local methods = {}
methods.__index = methods

local function CheckWord(word)
	for i,v in pairs(filterList) do
		if word:lower():match(v:lower()) then
			return true
		end
	end
	return false
end

local function CheckCommands(tw, msg)
	local words = msg:split(" ")
	for _,word in pairs(words) do
		if word:lower() == tw:lower() then
			return true
		end
	end
	return false
end

function methods:SendMessage(message, toChannel)
	local newMsg
	local doesContain
	newMsg = blacklistedMessage
	if message:sub(1,9) == "/sheriff " or message:sub(1,10) == "/murderer " or message:sub(1,5) == "/map " then
		-- self.SayMessageRequest:FireServer(message, "normalchat")
	elseif CheckWord(message) then
		-- self.SayMessageRequest:FireServer(blacklistedMessage, "normalchat")
	else
		self.SayMessageRequest:FireServer(message, "normalchat")
	end
end

function methods:RegisterSayMessageFunction(func)
	self.SayMessageRequest = func
end

--///////////////////////// Constructors
--//////////////////////////////////////

function module.new()
	local obj = setmetatable({}, methods)
	obj.SayMessageRequest = nil

	return obj
end

return module.new()
