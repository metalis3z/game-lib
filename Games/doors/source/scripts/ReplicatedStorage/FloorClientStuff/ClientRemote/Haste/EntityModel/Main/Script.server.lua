function tweenToMovingPart(movePart, targetPart, duration)
	local startCFrame = movePart.CFrame
	local startTime = os.clock()
	local connection = nil
	connection = game:GetService('RunService').Heartbeat:Connect(function()
		local t = math.clamp((os.clock()-startTime)/duration, 0 ,1)
		if movePart and movePart.Parent and targetPart and targetPart.Parent then
			movePart.CFrame = startCFrame:Lerp(targetPart.CFrame, t)
		end
		if t == 1 then
			connection:Disconnect()
			connection = nil
		end
	end)
end

tweenToMovingPart(workspace.EntityModel.PrimaryPart, workspace.Point, 15)