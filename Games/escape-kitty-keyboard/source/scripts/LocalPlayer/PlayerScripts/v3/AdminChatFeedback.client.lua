-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("TextChatService")
v1:WaitForChild("AdminFeedback").OnClientEvent:Connect(function(p3, p4)
	-- upvalues: (copy) u2
	local v5 = u2:FindFirstChild("RBXGeneral", true)
	if v5 then
		v5:DisplaySystemMessage("<font color=\'" .. p4 .. "\'><b>[SYSTEM]</b> " .. p3 .. "</font>")
	end
end)