local Log = {};

game:GetService("LogService").MessageOut:connect(function(Message,Type)
	if Type == Enum.MessageType.MessageError then
	    table.insert(Log,1,{
			Time = time();
			Message = Message;
			Type = Type;
		});
	end;
end)

function game.ReplicatedStorage.GetLogs.OnServerInvoke()
	return Log;
end