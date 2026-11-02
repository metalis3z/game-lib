-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("TestersLogEvent").OnClientEvent:Connect(function(p1, p2)
	if p2 == Enum.MessageType.MessageWarning then
		warn("SERVER: ", p1)
		return
	elseif p2 == Enum.MessageType.MessageOutput then
		print("SERVER: ", p1)
		return
	elseif p2 == Enum.MessageType.MessageInfo then
		game:GetService("TestService"):Message("SERVER: " .. p1)
	elseif p2 == Enum.MessageType.MessageError then
		game:GetService("TestService"):Error("SERVER: " .. p1)
	end
end)