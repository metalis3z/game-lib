-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:14
-- Luau version 6, Types version 3
-- Time taken: 0.011657 seconds

local module_upvr = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://107648255423077";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
		Actions = {
			Wave = "rbxassetid://128777973";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 16
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "MeetBrandon")
	end
	arg1:CreateDialog({
		Text = "lets chat! how are you feeling";
		Action = "Wave";
	})
	local function cancelDialog_upvr() -- Line 37, Named "cancelDialog"
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local tbl = {"Goodbye!"}
		arg1:CreateDialog({
			Text = tbl[math.random(1, #tbl)];
		})
	end
	arg1:ProcessResponse(arg1:GetUserResponse({{
		Choice = "feeling good";
	}, {
		Choice = "feeling bad";
	}, {
		Choice = "Goodbye!";
	}}), {function() -- Line 46
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: cancelDialog_upvr (readonly)
		]]
		local tbl_2 = {"cool :D what have you been up too"}
		arg1:CreateDialog({
			Text = tbl_2[math.random(1, #tbl_2)];
		})
		local function recursive() -- Line 52
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: cancelDialog_upvr (copied, readonly)
			]]
			arg1:ProcessResponse(arg1:GetUserResponse({{
				Choice = "playing games";
			}, {
				Choice = "hanging out";
			}, {
				Choice = "Goodbye!";
			}}), {function() -- Line 62
				--[[ Upvalues[2]:
					[1]: arg1 (copied, readonly)
					[2]: cancelDialog_upvr (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "oh whats your favorite game right now?";
				})
				local function recursive() -- Line 65
					--[[ Upvalues[2]:
						[1]: arg1 (copied, readonly)
						[2]: cancelDialog_upvr (copied, readonly)
					]]
					arg1:ProcessResponse(arg1:GetUserResponse({{
						Choice = "heli wars";
					}, {
						Choice = "work at a pizza place";
					}, {
						Choice = "survive disasters";
					}, {
						Choice = "Goodbye!";
					}}), {function() -- Line 75
						--[[ Upvalues[1]:
							[1]: arg1 (copied, readonly)
						]]
						arg1:CreateDialog({
							Text = "<Color=Blue>ozo<Color=/> is that you? LOL it must be! hope you still get out there and pwn, so much fun";
						})
					end, function() -- Line 78
						--[[ Upvalues[1]:
							[1]: arg1 (copied, readonly)
						]]
						arg1:CreateDialog({
							Text = "<Color=Red>There was a problem receiving data, Please reconnect. (Error Code:260)<Color=/>";
						})
					end, function() -- Line 81
						--[[ Upvalues[1]:
							[1]: arg1 (copied, readonly)
						]]
						arg1:CreateDialog({
							Text = "<Color=Red>There was a problem receiving data, Please reconnect. (Error Code:260)<Color=/>";
						})
					end, cancelDialog_upvr})
				end
				recursive()
			end, function() -- Line 88
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "<Color=Red>There was a problem receiving data, Please reconnect. (Error Code:260)<Color=/>";
				})
			end, cancelDialog_upvr})
		end
		recursive()
	end, function() -- Line 96
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: cancelDialog_upvr (readonly)
		]]
		local tbl_3 = {"sorry :( whats going on?"}
		arg1:CreateDialog({
			Text = tbl_3[math.random(1, #tbl_3)];
		})
		;(function() -- Line 102, Named "recursive"
			--[[ Upvalues[2]:
				[1]: arg1 (copied, readonly)
				[2]: cancelDialog_upvr (copied, readonly)
			]]
			arg1:ProcessResponse(arg1:GetUserResponse({{
				Choice = "something online";
			}, {
				Choice = "something irl";
			}, {
				Choice = "Goodbye!";
			}}), {function() -- Line 112
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "noobs/trolls bothering you? try ignoring :D itll be okay";
				})
			end, function() -- Line 116
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "hope it works out, wish i could help sooner.. try talking it out with the person";
				})
			end, cancelDialog_upvr})
		end)()
	end, cancelDialog_upvr})
end
return module_upvr