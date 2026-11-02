local Pads = game.Workspace.VoteIcons:GetChildren();

local Votes = {}

for i = 1,#Pads do
	if Pads[i]:IsA("BasePart") and string.sub(Pads[i].Name,1,1) == "V" then
		local PlayersTouching = {}

		Pads[i].Votes.Changed:connect(function()
			Pads[i].MapInfo.Surface.Frame.Votes.Text = Pads[i].Votes.Value
			Pads[i].MapInfo.Surface.Frame.Votes.Text = "Votes: " .. Pads[i].Votes.Value;

		end)

		Pads[i].Map.Changed:connect(function()
			if Pads[i].Map.Value ~= nil then
				Votes[Pads[i]] = {}
				Pads[i].MapInfo.Surface.Frame.MapName.Text = Pads[i].Map.Value.Name;
				Pads[i].MapInfo.Surface.Frame.MapName.Text = Pads[i].Map.Value.Name
				if Pads[i].Map.Value:FindFirstChild("IconSq") then
					Pads[i].Surface.Background.Image = Pads[i].Map.Value.IconSq.Texture;
				end
			end
		end)

		Pads[i].Voting.Changed:connect(function()
			if Pads[i].Voting.Value then
				Pads[i].Surface.Enabled = true;
				Pads[i].MapInfo.Surface.Frame.Votes.Text = "Votes: 0";
				Pads[i].MapInfo.Surface.Enabled = true; 
			else

				Pads[i].MapInfo.Surface.Enabled = false;
				Pads[i].Surface.Enabled = false;
			end
		end)

		local Pad = Pads[i]
		local Detector = script.Parent["Detector" .. string.sub(Pads[i].Name,string.len(Pads[i].Name))];
		local Region = Region3.new(Detector.Position-Detector.Size/2,(Detector.Position+Detector.Size/2)+Vector3.new(0,10,0))
		local Total = 0;

		local newThread = coroutine.create(function()
			while wait(0.1) do
				local Total = 0;
				local Parts = game.Workspace:FindPartsInRegion3(Region,nil,100)
				for e = 1,#Parts do
					if Parts[e].Name == "HumanoidRootPart" then
						local HumanoidRootPartOffset1 = Detector.CFrame:toObjectSpace( Parts[e].CFrame );
						if math.abs(HumanoidRootPartOffset1.x ) <= Detector.Size.x / 2 and math.abs( HumanoidRootPartOffset1.z ) <= Detector.Size.z / 2 then
							local plr = game.Players:FindFirstChild(Parts[e].Parent.Name)
							if plr then
								for i,v in pairs(Votes) do
									v[plr] = nil
								end

								Votes[Pad][plr] = true
							end
						end
					end
				end
				for i,v in pairs(Votes) do
					if i == Pad then
						for i,v in pairs(v) do
							Total += 1
						end
					end
				end
				Pad.Votes.Value = Total;
			end
		end)

		coroutine.resume(newThread)

	end
end