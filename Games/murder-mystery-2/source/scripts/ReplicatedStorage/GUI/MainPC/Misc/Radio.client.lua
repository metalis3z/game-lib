local GameGUI = script.Parent.Parent.Game;
local RadioButton = GameGUI.Settings.Radio;
local RadioFrame = GameGUI.Radio;

local HasRadio,CanUse = game.ReplicatedStorage.HasRadio:InvokeServer();

local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 335132309;
local HardcoreTestID = 345345;
local IsHardcore = (game.PlaceId == HardcoreID or game.PlaceId == HardcoreTestID);

local SongList = RadioFrame.Main.MySongs.ScrollFrame;
local AddFrame = RadioFrame.Main.MySongs.Adder;

local SearchFrame = RadioFrame.Main.Search;
local SearchList = RadioFrame.Main.Search.ScrollFrame;
local SearchBar = RadioFrame.Main.Search.Searcher;

function unescape(str)
	str = string.gsub( str, '&lt;', '<' )
	str = string.gsub( str, '&gt;', '>' )
	str = string.gsub( str, '&quot;', '"' )
	str = string.gsub( str, '&apos;', "'" )
	
	str = string.gsub( str, '&#(%d+);',function(n)
		if tonumber(n) and tonumber(n)<126 then
			return string.char( tonumber(n) )
		else
			return "";
		end;
	end)
	
	str = string.gsub( str, '&#x(%d+);', function(n)
		if tonumber(n) and tonumber(n)<126 then
			return string.char( tonumber(n) )
		else
			return "";
		end;
	end)
	
	str = string.gsub( str, '.', function(n)
		local C = string.byte(n);
		if C and C<126 then
			return n;
		else
			return "";
		end;
	end)
	
	str = string.gsub( str, '&amp;', '&' ) -- Be sure to do this after all others
	return str
end


if not IsHardcore then
	
	local Songs = unpack({game.ReplicatedStorage.GetData:InvokeServer("RadioSongs")});
	
	for _,Button in pairs(RadioFrame.Nav:GetChildren()) do
		Button.MouseButton1Click:connect(function()
			script.Preview:Stop();
			script.Preview.SoundId = "";
			for _,B in pairs(RadioFrame.Nav:GetChildren()) do 
				B.Style = (B==Button and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton;
			end
			for _,F in pairs(RadioFrame.Main:GetChildren()) do
				F.Visible = F.Name == Button.Name;
			end
		end)
	end
	
	local CanPlay = false;
	game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role,Color,CodeName,LockFirstPerson)
		CanPlay = true;
	end)

	game.ReplicatedStorage.GetRadio.OnClientEvent:connect(function()
		CanPlay = true;
	end)
	
	local function UpdateSongList()
		SongList:ClearAllChildren();
		for Index,SongData in pairs(Songs) do
			local NewFrame = script.Song:Clone();
			NewFrame.Container.SongName.Text = SongData.Name;
			NewFrame.Container.Play.MouseButton1Click:connect(function()
				if CanPlay then
					if HasRadio then
						game.ReplicatedStorage.PlaySong:FireServer(SongData.ID);
					else
						game.ReplicatedStorage.GetRadio:FireServer();
					end;
				else
					RadioFrame.Main.MySongs.Wait.Visible = true;
					wait(2);
					RadioFrame.Main.MySongs.Wait.Visible = false;
				end;
			end)
			NewFrame.Container.Delete.MouseButton1Click:connect(function()
				table.remove(Songs,Index);
				game.ReplicatedStorage.RemoveSong:FireServer(Index);
				UpdateSongList();
			end)
			
			NewFrame.Position = UDim2.new(0,0,0,(Index-1)*NewFrame.Size.Y.Offset);
			NewFrame.Parent = SongList;
		end
	end
	
	local function AddSong(ID,SongName)
		local SoundID;

		if SongName == nil then
			pcall(function()
				if tonumber(ID) then
					local Info = game:GetService("MarketplaceService"):GetProductInfo(ID)
					if Info then
						if Info.AssetTypeId == 3 then
							SoundID = "https://www.roblox.com/asset/?id=" .. ID;
							SongName = unescape(Info.Name);
						end
					end
				end;
			end)
		else
			SoundID = "https://www.roblox.com/asset/?id=" .. ID;
		end;
		
		if SoundID then
			for _,Song2 in pairs(Songs) do
				if Song2.ID == SoundID then return end;
			end
			table.insert(Songs,1,{ID=SoundID,Name=SongName});
			if #Songs >= 30 then
				table.remove(Songs,30);
			end
			game.ReplicatedStorage.SaveSong:FireServer(SoundID,SongName);
			UpdateSongList();
		else
			AddFrame.ID.Text = "Invalid ID!";
		end;
	end
	
	RadioButton.MouseButton1Click:connect(function()
		GameGUI.Shop.Visible = false;
		GameGUI.Inventory.Visible = false;
		RadioFrame.Visible = not RadioFrame.Visible;
	end)
	
	--RadioFrame.Close.MouseButton1Click:connect(function()
		--RadioFrame.Visible = false;
	--end)
	
	-- Search
	
	local function SearchSongs(Override)
		if not HasRadio and not Override then game.ReplicatedStorage.GetRadio:FireServer(); return end;
		script.Preview:Stop();
		script.Preview.SoundId = "";
		for _,Frame in pairs(SearchFrame:GetChildren()) do if Frame.Name ~= "Searcher" then Frame.Visible = false; end end;
		SearchFrame.Processing.Visible = true;
		SearchFrame.Processing.Text = "Searching."
		spawn(function()
			local i=1;
			while SearchFrame.Processing.Visible do
				SearchFrame.Processing.Text = "Searching";
				for Index = 1,((i-1)%4) do
					SearchFrame.Processing.Text = SearchFrame.Processing.Text .. ".";
				end
				i = i + 1;
				wait(0.25);
			end
		end)
		
		local SongTable = game.ReplicatedStorage.SearchSongs:InvokeServer(  ((not Override) and SearchBar.ID.Text) or "" );
		SearchFrame.Processing.Visible = false;
		if SongTable then
			if SongTable ~= "Empty" then
				
				SearchList:ClearAllChildren();
				local Top = {ID=0,Name="",Takes=0,Index=0};
				for Index,SongData in pairs(SongTable) do
					local ID = SongData.AssetId;
					
					local Sales = SongData.Sales;

					if Sales > Top.Takes then
						Top.ID = SongData.AssetId;
						Top.Takes = Sales;
						Top.Index = Index;
						Top.Name = SongData.Name;
					end;
				end
				
				
				table.remove(SongTable,Top.Index);
				table.insert(SongTable,1,{AssetId=Top.ID,Name=Top.Name});

				for Index,SongData in pairs(SongTable) do
					local NewFrame = script.SearchedSong:Clone();
					NewFrame.Container.SongName.Text = tostring(SongData.Name);
					
					for _,Song2 in pairs(Songs) do 
						if Song2.ID == "https://www.roblox.com/asset/?id="..SongData.AssetId then
							NewFrame.Container.Add.Text = "Added";
							NewFrame.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
						end
					end;
					
					local AddCon;
					AddCon = NewFrame.Container.Add.MouseButton1Click:connect(function()
						AddCon:disconnect();
						NewFrame.Container.Add.Text = "Added";
						NewFrame.Container.Add.Style = Enum.ButtonStyle.RobloxRoundButton;
						AddSong(SongData.AssetId,SongData.Name);
					end)
					
					NewFrame.Container.Preview.MouseButton1Click:connect(function()
						for _,Frame in pairs(SearchList:GetChildren()) do 
							Frame.Container.Preview.Text = "Preview";
						end
						script.Preview:Stop();
						local SoundID = "https://www.roblox.com/asset/?id=" .. SongData.AssetId;
						local OldID = script.Preview.SoundId;
						script.Preview.SoundId = SoundID;
						if script.Preview.SoundId ~= OldID then 
							NewFrame.Container.Preview.Text = "Stop"; 
							script.Preview:Play(); 
						else
							script.Preview.SoundId = "";
						end;
					end)
					
					NewFrame.Position = UDim2.new(0,0,0,(Index-1)*NewFrame.Size.Y.Offset);
					SearchList.CanvasSize = UDim2.new(0,0,0,NewFrame.Size.Y.Offset*Index);
					NewFrame.Parent = SearchList;
				end
				SearchList.Visible = true;
			else
				SearchFrame.Empty.Visible = true;
			end;
		else
			SearchFrame.Error.Visible = true;
		end;
	end	
	
	--- Search
	
	SearchBar.Add.MouseButton1Click:connect(SearchSongs)
	SearchBar.ID.FocusLost:connect(function(Enter)
		if Enter then SearchSongs() end;
	end)
	
	
	AddFrame.Add.MouseButton1Click:connect(function()
		AddSong(AddFrame.ID.Text);
	end)
	
	SearchSongs(true);
	UpdateSongList();
else 
	if IsHardcore then
		pcall(function() game.Workspace.Lobby.RadioGamepass:Destroy() end);
	end;
end;