

local v1 = game:GetService("CollectionService")
local v2 = script.Parent
local v3 = nil
for _, v4 in ipairs(v1:GetTagged("SecretTalk")) do
	if v4:IsDescendantOf(v2) then
		v3 = v4
		break
	end
end
local v5 = v3 or v2:FindFirstChild("SecretTalk", true)
if v5 then
	v5.Text = ""
	for v6 = 1, 56 do
		v5.Text = string.sub("Hey mate ! Don\'t cheat at this game, alright? Have fun !", 1, v6)
		task.wait(0.017857142857142856)
	end
	task.wait(4)
	v2:Destroy()
else
	task.wait(5)
	v2:Destroy()
end