return function(startCFrame, targetCFrame, whitelist)
	local endCFrame = startCFrame * targetCFrame
	
	local ray = Ray.new(startCFrame.p, (endCFrame.p - startCFrame.p).unit * 3500)
	
	return game.Workspace:FindPartOnRayWithWhitelist(ray, whitelist)
end