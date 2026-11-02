-- Decompiled using Krnl
local v1 = true
local notfiList = {}
local CL_MAIN_GameScript = script.Parent:WaitForChild("CL_MAIN_GameScript")
local function OnInvoke(p5)
	if v1 == true then
		v1 = false
		return notfiList
	end
end
script.SendQueue.OnInvoke = OnInvoke

game.ReplicatedStorage:WaitForChild("Remote").Notify.OnClientEvent:Connect(function(p1,p2,p3,p4)
	if v1 then
		table.insert(notfiList, {
			info = p1, title = p2, func = p3, img = p4
		})
		return 
	end
	CL_MAIN_GameScript.Notify:Fire(p1, p2, p3, p4)
end)