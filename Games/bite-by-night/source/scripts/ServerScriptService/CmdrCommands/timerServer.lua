return function (context, Time: number): ()	
	workspace.GAME.TIMER.Value = Time
	
	return `Changed time to {Time} !`
end