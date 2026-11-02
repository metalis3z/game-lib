--credit to prince games studio
game:GetService("ReplicatedStorage")

local GuildChatTag = require(script.GuildChatTag)

return {
	StartOrder = 5,
	Init = function(p1) --[[ Init | Line: 10 | Upvalues: GuildChatTag (copy) ]]
		GuildChatTag.Install()
	end
}