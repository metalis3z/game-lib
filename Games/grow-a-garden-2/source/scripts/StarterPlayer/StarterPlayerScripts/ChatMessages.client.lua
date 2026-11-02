--credit to prince games studio
local t = { "<font color=\"#00aaff\"><b>[TIP]</b></font> Your garden literally grows <font color=\"#55ff7f\"><b>offline</b></font>!", "<font color=\"#00aaff\"><b>[TIP]</b></font> Fruits <font color=\"#ff5555\"><b>decay</b></font> if you go away go too long!", "<font color=\"#00aaff\"><b>[TIP]</b></font> Pets have a chance to <font color=\"#55aaff\"><b>big</b></font>... or even <font color=\"#aa55ff\"><b>huge</b></font>!", "<font color=\"#00aaff\"><b>[TIP]</b></font> Invite your <font color=\"#55ff7f\"><b>friends</b></font> for <font color=\"#ffd700\"><b>sheckles bonuses</b></font> and more fun!", "<font color=\"#00aaff\"><b>[TIP]</b></font> <font color=\"#55aaff\"><b>Watering seed packs</b></font> might give more <font color=\"#ffd700\"><b>luck</b></font>, who knows!", "<font color=\"#00aaff\"><b>[TIP]</b></font> <font color=\"#55aaff\"><b>Sprinklers</b></font> give your plants more <font color=\"#ffd700\"><b>luck</b></font>!", "<font color=\"#00aaff\"><b>[TIP]</b></font> Some <font color=\"#ff8855\"><b>props</b></font> can be used for <font color=\"#ff8855\"><b>defense</b></font>!" }
local RBXGeneral = game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral")

task.spawn(function() --[[ Line: 13 | Upvalues: t (copy), RBXGeneral (copy) ]]
	local v1 = nil
	local v2 = nil

	while true do
		local v3

		task.wait(300)

		repeat
			v3 = math.random(1, #t)
		until v3 ~= v1 and v3 ~= v2

		RBXGeneral:DisplaySystemMessage(t[v3])
		v1, v2 = v3, v1
	end
end)