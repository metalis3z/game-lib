-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	Name = "SetupGenerators", 
	Title = "Setup Generators", 
	Description = "Complete the puzzles on each generator to get them up & running. (<PROGRESS>/<REQUIREMENT>)\nSurvive until the timer runs out.", 
	RequiredProgress = 5, 
	Order = 1, 
	YieldUntilCompleted = true, 
	NoStatsAdded = true, 
	OnCreation = function(v0) --[[ Line: 12 ]] --[[ Name: OnCreation ]]
		for _ = 1, v0.RequiredProgress do
			local v2 = script.Generator:Clone();
			local v3 = v0.Map and v0.Map:FindFirstChild("GeneratorPositions") and v0.Map.GeneratorPositions:GetChildren();
			local v4 = v3 and v3[math.random(1, #v3)];
			if v2 and v4 then
				v2:SetPrimaryPartCFrame(v4.CFrame);
				v2.Parent = v0.Map;
				v4:Destroy();
				for _, v6 in pairs(v2.Scripts:GetChildren()) do
					v6.Enabled = true;
				end;
				v2.Remotes.BE.Event:Connect(function(v7, v8) --[[ Line: 31 ]]
					-- upvalues: v0 (copy)
					require(game.ReplicatedStorage.Modules.Util):AddToPlayerStat(v7, "KillerChance", 0.5);
					local v9 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[v7];
					if v9 and v9.Behavior and v9.Behavior.OnObjectiveCompleted then
						v9.Behavior:OnObjectiveCompleted(v9, 1);
					end;
					v0:RemoveTime(3.5, true);
					if v8 >= 100 then
						v0:AddProgress(v7);
					end;
				end);
				v2.Destroying:Connect(function() --[[ Line: 51 ]]
					-- upvalues: v0 (copy)
					v0:AddProgress();
				end);
			else
				v0:AddProgress();
			end;
		end;
		local v10 = v0.Map and v0.Map:FindFirstChild("GeneratorPositions") and v0.Map.GeneratorPositions:GetChildren();
		local l_pairs_0 = pairs;
		local v12 = v10 or {};
		for _, v14 in l_pairs_0(v12) do
			local v15 = Instance.new("CFrameValue", v0.Map.GeneratorPositions);
			v15.Name = "GeneratorPosition";
			v15.Value = v14.CFrame;
			v14:Destroy();
		end;
	end, 
	OnProgression = function(_) --[[ Line: 71 ]] --[[ Name: OnProgression ]]

	end, 
	OnCompletion = function(v17) --[[ Line: 76 ]] --[[ Name: OnCompletion ]]
		task.delay(5, function() --[[ Line: 78 ]]
			-- upvalues: v17 (copy)
			v17:Destroy();
		end);
	end
};