--mustwear!

--Put this script into Hats that players must wear; if a player is
--not wearing the hat then it is destroyed.

--This script is automatically cloned by HatAdder (!gethat)

hat = script.Parent
debris = game:GetService("Debris")

function check()
	local plr = game.Players:GetPlayerFromCharacter(hat.Parent)
	if not plr then
		debris:AddItem(hat, 0)
		wait()
		hat:Destroy()
		return
	end
end

hat.AncestryChanged:connect(function()
	check()
end)
check()


