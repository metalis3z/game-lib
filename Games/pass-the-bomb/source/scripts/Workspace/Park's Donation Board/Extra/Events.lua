--[[
	
	THIS WILL ONLY WORK IF YOU HAVE PREMIUM!
	
	This is basically a Callback Function
	
	The NumberRange contains the price range that will activate the event
	
	It will give you three parameters:
	The player that donated,
	the amount they donated,
	and the custom message if there is one
	
]]

return {
	[NumberRange.new(5, 10)] = function(Plr, Price, CustomMessage)
		print("omg!!!!!!!! "..Plr.Name.." donated 5 bobux 🤯🤑")
	end,
}