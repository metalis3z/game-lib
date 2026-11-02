-- Decompiled with the Synapse X Luau decompiler.

return {
	run = function(p1)
		local l__Shopkeeper__1 = p1.Shopkeeper;
		local v2 = {};
		for v3 = 1, 2 do
			local v4 = "Tentacle" .. v3;
			local v5 = v2[v4];
			local v6 = l__Shopkeeper__1:FindFirstChild(v4);
			local v7 = {};
			for v8, v9 in pairs({ { "Bone", "TentacleBase" .. v3 }, { "Bone.001", "T" .. v3 .. "_P1" }, { "Bone.002", "T" .. v3 .. "_P2" }, { "Bone.003", "T" .. v3 .. "_P3" }, { "Bone.004", "T" .. v3 .. "_P4" }, { "Bone.005", "T" .. v3 .. "_P5" }, { "Bone.006", "T" .. v3 .. "_P6" }, { "Bone.007", "T" .. v3 .. "_P7" }, { "Bone.008", "T" .. v3 .. "_P8" }, { "Bone.009", "T" .. v3 .. "_P9" } }) do
				table.insert(v7, { v6:FindFirstChild(v9[1], true), v6:FindFirstChild(v9[2], true) });
			end;
			v2[v4] = v7;
		end;
		coroutine.wrap(function()
			for v10 = 1, 10000000000 do
				for v11 = 1, 2 do
					local v12 = v2["Tentacle" .. v11];
					for v13 = 1, 10 do
						local v14 = v12[v13];
						v14[1].WorldCFrame = v14[2].CFrame;
					end;
				end;
				game["Run Service"].Heartbeat:wait();
			end;
		end)();
	end
};
