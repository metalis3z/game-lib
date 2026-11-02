return function(context, Boolean: boolean)
	workspace.GAME.FROZENTIMER.Value = Boolean
	
	return Boolean and 'Froze the timer !' or 'Unfroze the timer !'
end
