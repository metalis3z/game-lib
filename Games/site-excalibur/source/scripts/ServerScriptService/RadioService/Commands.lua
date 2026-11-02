local Commands = {};
--------------------------
Commands['/broadcast'] = {
	Requirements = {'Player:13417664','Player:1489844303','3222359483','2410920183','660269927'};
	Invoke = function(RadioService, Player, Message)
		return RadioService:Broadcast(Message)
	end,
}

Commands['/unmute'] = { --   ~[NOTE]~ : : : The unmute command DOESN'T WORK YET. It will work in V2. If it does work or you fix it, DM
	--me on discord (TalanVision#0001). For now to unmute, simply yell the player to rejoin and or kick them from the game.
	Requirements = {'Player:13417664','Player:1259792250','1445659291','419680707','2241829015'};
	Invoke = function(RadioService, Player, Message)
		local User = RadioService:SplitArguements(Message);
		local PlayerData = RadioService.Users[Player.UserId];
		local UserData = RadioService.Users[User.UserId];
		
		if UserData then
			RadioService.Users[User.UserId].Muted = false;
			
			RadioService:Transmit({
				Title = "SYSTEM";
				Message = 'Successfully unmuted ' .. User.Name .. '.';
				Color = Color3.fromRGB(0,0,0);
				Channel = PlayerData.Channel
			}, {{Player = Player, Channel = PlayerData.Channel}})

			return RadioService:Transmit({
				Title = "SYSTEM";
				Message = 'You have been unmuted by ' .. Player.Name;
				Color = Color3.fromRGB(0,0,0);
				Channel = UserData.Channel
			}, {{Player = User, Channel = UserData.Channel}})
			
		end
	end
}

Commands['/mute'] = {
	Requirements = {'13417664','Player:1259792250','1445659291','419680707','2241829015'};
	Invoke = function(RadioService, Player, Message)
		local UserData = RadioService.Users[Player.UserId];
		local PossibleUser, Reason = RadioService:SplitArguements(Message);
		
		local User = RadioService:GetPlayerFromPartial(PossibleUser or ' ');
		
		if User and RadioService.Users[User.UserId] then
			if Player:GetRankInGroup(13770960) > User:GetRankInGroup(13770960) then
				if not RadioService.Users[User.UserId].Muted then
					if Reason then
						RadioService.Users[User.UserId].Muted = {
							Authorizer = Player,
							Reason = Reason;
						}
						
						RadioService:Transmit({
							Title = "SYSTEM";
							Message = 'Successfully muted ' .. User.Name .. ' for ' .. Reason;
							Color = Color3.fromRGB(0,0,0);
							Channel = UserData.Channel
						}, {{Player = Player, Channel = UserData.Channel}})
						
						return RadioService:Transmit({
							Title = "SYSTEM";
							Message = 'You have been muted by ' .. Player.Name .. '.\nReason: ' .. Reason;
							Color = Color3.fromRGB(218, 31, 31);
							Channel = RadioService.Users[User.UserId].Channel
						}, {{Player = User, Channel = RadioService.Users[User.UserId].Channel}})
					else
						return RadioService:Transmit({
							Title = "SYSTEM";
							Message = 'ERROR: You must provide a reason for the mute you are attempting to invoke. Please re-invoke the command in the following format: /mute <name> <reason>.';
							Color = Color3.fromRGB(0,0,0);
							Channel = UserData.Channel
						}, {{Player = Player, Channel = UserData.Channel}})
					end
				else
					return RadioService:Transmit({
						Title = "SYSTEM";
						Message = 'That user is already muted by another executive.';
						Color = Color3.fromRGB(0,0,0);
						Channel = UserData.Channel
					}, {{Player = Player, Channel = UserData.Channel}})
				end
			else
				return RadioService:Transmit({
					Title = "SYSTEM";
					Message = 'ERROR: You cannot mute a user who has more or the same authority as you.';
					Color = Color3.fromRGB(0,0,0);
					Channel = UserData.Channel
				}, {{Player = Player, Channel = UserData.Channel}})
			end
		else
			return RadioService:Transmit({
				Title = "SYSTEM";
				Message = 'ERROR: There was an issue fetching that user, please be more specific in your search.';
				Color = Color3.fromRGB(0,0,0);
				Channel = UserData.Channel
			}, {{Player = Player, Channel = UserData.Channel}})
		end
	end
}

Commands['/channel'] = {
	Requirements = nil;
	Invoke = function(RadioService, Player, Message)
		local UserData = RadioService.Users[Player.UserId];
		local Channel = RadioService:SplitArguements(Message);
		local Content, Color = 'There was an issue resolving this command.', Color3.fromRGB(218, 173, 67);

		if UserData.Channel == Channel then
			Content = "You cannot switch to the channel you're already on.";
			Color = Color3.fromRGB(218, 173, 67);
		elseif UserData.Channel ~= Channel then
			if RadioService.Channels[Channel] then
				if RadioService.Utility.Permissions(Player, RadioService.Channels[Channel].Requirements) then
					RadioService.Users[Player.UserId].Channel = Channel;
					RadioService.Transmitter:FireClient(Player, 'UpdateChannel', Channel);
					Content = "You have switched to the " .. Channel .. " channel.";
					Color = Color3.fromRGB(218, 173, 67);
				else
					Content = "You do not meet the requirements to access that channel.";
					Color = Color3.fromRGB(218, 31, 31);
				end
			else
				Content = "The channel you specified does not exist.";
				Color = Color3.fromRGB(218, 173, 67);
			end
		end
		
		return RadioService:Transmit({
			Title = "SYSTEM";
			Message = Content;
			Color = Color;
			Channel = UserData.Channel
		}, {{Player = Player, Channel = UserData.Channel}})
	end,
}

Commands['/channels'] = {
	Requirements = nil;
	Invoke = function(RadioService, Player, Message)
		local UserData = RadioService.Users[Player.UserId];
		local Channels = RadioService.Channels;
		local Utility = RadioService.Utility;
		local Content = 'You can access the following channels: ';
		
		for Name,ChannelData in pairs(Channels) do
			if Utility.Permissions(Player, ChannelData.Requirements) then
				Content = Content .. Name .. ', ';
			end
		end
		
		return RadioService:Transmit({
			Title = "SYSTEM";
			Message = Content;
			Color = Color3.fromRGB(21, 21, 21);
			Channel = UserData.Channel
		}, {{Player = Player, Channel = UserData.Channel}})
	end
}

Commands['/commands'] = {
	Requirements = nil;
	Invoke = function(RadioService, Player, Message)
		local UserData = RadioService.Users[Player.UserId];
		local Utility = RadioService.Utility;
		local Content = 'You can access the following commands: ';
		
		for Name,CommandData in pairs(Commands) do
			if Utility.Permissions(Player, CommandData.Requirements) then
				Content = Content .. "'" .. Name .. "', ";
			end
		end

		return RadioService:Transmit({
			Title = "SYSTEM";
			Message = Content;
			Color = Color3.fromRGB(21, 21, 21);
			Channel = UserData.Channel
		}, {{Player = Player, Channel = UserData.Channel}})
	end
}
--------------------------
return Commands