

local val = script.Parent.Parent.val

script.Parent.h.OnServerInvoke = function(plr, handle, teest)
	 local Wallet = plr.stats.Cash
	 if Wallet then
	    Wallet.Value = Wallet.Value + val.Value
		script.Parent.Parent.Cashed.Value = true
	end
end