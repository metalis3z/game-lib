-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return {
	["30,000 Credits"] = {
		ID = 876683202, 
		Callback = function(p1, p2)
			local v1 = u1.Saving.Get(p1);
			if not v1 then
				return;
			end;
			v1.Credits = v1.Credits + 30000;
			return true;
		end
	}, 
	["180,000 Credits"] = {
		ID = 876682654, 
		Callback = function(p3, p4)
			local v2 = u1.Saving.Get(p3);
			if not v2 then
				return;
			end;
			v2.Credits = v2.Credits + 180000;
			return true;
		end
	}, 
	["725,000 Credits"] = {
		ID = 876687572, 
		Callback = function(p5, p6)
			local v3 = u1.Saving.Get(p5);
			if not v3 then
				return;
			end;
			v3.Credits = v3.Credits + 725000;
			return true;
		end
	}, 
	["2,800,000 Credits"] = {
		ID = 876688236, 
		Callback = function(p7, p8)
			local v4 = u1.Saving.Get(p7);
			if not v4 then
				return;
			end;
			v4.Credits = v4.Credits + 2800000;
			return true;
		end
	}, 
	["11,750,000 Credits"] = {
		ID = 876688676, 
		Callback = function(p9, p10)
			local v5 = u1.Saving.Get(p9);
			if not v5 then
				return;
			end;
			v5.Credits = v5.Credits + 11750000;
			return true;
		end
	}, 
	["Winter Pack"] = {
		ID = 944332597, 
		Callback = function(p11, p12)
			return u1.Packs.GivePack(p11, "1");
		end
	}, 
	["Royale Pack"] = {
		ID = 967842492, 
		Callback = function(p13, p14)
			return u1.Packs.GivePack(p13, "3");
		end
	}, 
	["Shattered Pack"] = {
		ID = 1090283984, 
		Callback = function(p15, p16)
			return u1.Packs.GivePack(p15, "4");
		end
	}, 
	["Hacker Pack"] = {
		ID = 1168130138, 
		Callback = function(p17, p18)
			return u1.Packs.GivePack(p17, "5");
		end
	}, 
	["Anime Pack"] = {
		ID = 1204985255, 
		Callback = function(p19, p20)
			return u1.Packs.GivePack(p19, "6");
		end
	}, 
	["Game Makers Pack"] = {
		ID = 0, 
		Callback = function(p19, p20)
			return u1.Packs.GivePack(p19, "7");
		end
	}, 
	["Summer Crate"] = {
		ID = 1243955494, 
		Callback = function(p21, p22)
			local v6 = u1.Crates.Open("1");
			if u1.Crates.Get("1").disabled then
				return false;
			end;
			if not v6 then
				return false;
			end;
			local v7 = u1.GunCmds.DoesOwnGun(p21, v6);
			local v8 = u1.GunCmds.Get(v6);
			local v9 = u1.Saving.Get(p21);
			if not v9 or not v9.Credits then
				return false;
			end;
			u1.Network.Fire("Crate Opening Sequence", p21, "1", v6);
			if v7 then
				coroutine.wrap(function()
					task.wait(1);
					u1.Network.Fire("Already Owns From Crate", p21, v6, v8.price);
					v9.Credits = v9.Credits + v8.price;
				end)();
			elseif not u1.Shared.giveGun(p21, v6) then
				return false;
			end;
			return true;
		end
	}, 
	["Toxic Crate"] = {
		ID = 1277100788, 
		Callback = function(p23, p24)
			local v10 = u1.Crates.Open("2");
			if u1.Crates.Get("2").disabled then
				return false;
			end;
			if not v10 then
				return false;
			end;
			local v11 = u1.GunCmds.DoesOwnGun(p23, v10);
			local v12 = u1.GunCmds.Get(v10);
			local v13 = u1.Saving.Get(p23);
			if not v13 or not v13.Credits then
				return false;
			end;
			u1.Network.Fire("Crate Opening Sequence", p23, "2", v10);
			if v11 then
				coroutine.wrap(function()
					task.wait(1);
					u1.Network.Fire("Already Owns From Crate", p23, v10, v12.price);
					v13.Credits = v13.Credits + v12.price;
				end)();
			elseif not u1.Shared.giveGun(p23, v10) then
				return false;
			end;
			return true;
		end
	}
};
