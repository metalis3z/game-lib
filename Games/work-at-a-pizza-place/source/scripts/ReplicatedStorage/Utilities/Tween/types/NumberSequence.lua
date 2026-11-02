--[[
	For each point on each line, find the values of the other sequence at that point in time through interpolation
		then interpolate between the known value and the learned value
		then use that value to create a new keypoint at the time
		then build a new sequence using all the keypoints generated
--]]

local sortByTime = function(a, b)
	return a.Time < b.Time
end

return function(a, b, t)
	local keypoints = {}
	local addedTimes = {}
	
	for i, ap in next, a.Keypoints do
		local closestAbove, closestBelow
		
		for i, bp in next, b.Keypoints do
			if bp.Time == ap.Time then
				closestAbove, closestBelow = bp, bp
				break
			elseif bp.Time < ap.Time and (closestBelow == nil or bp.Time > closestBelow.Time) then
				closestBelow = bp
			elseif bp.Time > ap.Time and (closestAbove == nil or bp.Time < closestAbove.Time) then
				closestAbove = bp
			end
		end
		
		local bValue, bEnvelope
		if closestAbove == closestBelow then
			bValue, bEnvelope = closestAbove.Value, closestAbove.Envelope
		else
			local p = (ap.Time - closestBelow.Time)/(closestAbove.Time - closestBelow.Time)
			bValue = (closestAbove.Value - closestBelow.Value)*p + closestBelow.Value
			bEnvelope = (closestAbove.Envelope - closestBelow.Envelope)*p + closestBelow.Envelope
		end
		local interValue = (bValue - ap.Value)*t + ap.Value
		local interEnvelope = (bEnvelope - ap.Envelope)*t + ap.Envelope
		local interp = NumberSequenceKeypoint.new(ap.Time, interValue, interEnvelope)
		
		table.insert(keypoints, interp)
		
		addedTimes[ap.Time] = true
	end
	for i, bp in next, b.Keypoints do
		if not addedTimes[bp.Time] then
			local closestAbove, closestBelow
			
			for i, ap in next, a.Keypoints do
				if ap.Time == bp.Time then
					closestAbove, closestBelow = ap, ap
					break
				elseif ap.Time < bp.Time and (closestBelow == nil or ap.Time > closestBelow.Time) then
					closestBelow = ap
				elseif ap.Time > bp.Time and (closestAbove == nil or ap.Time < closestAbove.Time) then
					closestAbove = ap
				end
			end
			
			local aValue, aEnvelope
			if closestAbove == closestBelow then
				aValue, aEnvelope = closestAbove.Value, closestAbove.Envelope
			else
				local p = (bp.Time - closestBelow.Time)/(closestAbove.Time - closestBelow.Time)
				aValue = (closestAbove.Value - closestBelow.Value)*p + closestBelow.Value
				aEnvelope = (closestAbove.Envelope - closestBelow.Envelope)*p + closestBelow.Envelope
			end
			local interValue = (bp.Value - aValue)*t + aValue
			local interEnvelope = (bp.Envelope - aEnvelope)*t + aEnvelope
			local interp = NumberSequenceKeypoint.new(bp.Time, interValue, interEnvelope)
			
			table.insert(keypoints, interp)
		end
	end
	
	table.sort(keypoints, sortByTime)
	
	return NumberSequence.new(keypoints)
end