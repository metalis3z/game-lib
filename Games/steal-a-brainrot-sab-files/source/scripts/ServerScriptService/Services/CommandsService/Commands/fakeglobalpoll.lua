local module = function(Conch, Config)

	local PollService =
		require(game.ServerScriptService.Services.PollService)

	Conch.register("fakeglobalpoll",{
		permissions={
			Config.RequiredRole or "super-user"
		},

		arguments=function()
			return
				{
					kind="argument",
					type="string",
					name="Question"
				},
			{
				kind="argument",
				type="string",
				name="Option1"
			},
			{
				kind="argument",
				type="string",
				name="Option2"
			},
			{
				kind="argument",
				type="number",
				name="TargetA"
			},
			{
				kind="argument",
				type="number",
				name="TargetB"
			},
			{
				kind="argument",
				type="number",
				name="Duration",
				optional=true
			}
		end,

		callback=function(
			question,
			option1,
			option2,
			targetA,
			targetB,
			duration
		)

			duration = duration or 60

			local pollID =
				PollService.startGlobalPoll({
					question = question,
					option1 = option1,
					option2 = option2,
					duration = duration
				})

			if not pollID then
				return false,"failed"
			end

			task.spawn(function()

				task.wait(1)

				local a=0
				local b=0

				while a<targetA or b<targetB do

					local startTick=tick()

					local votesThisSecond=
						math.random(30,70)

					for i=1,votesThisSecond do

						if a>=targetA and b>=targetB then
							break
						end

						local remainingA=
							targetA-a

						local remainingB=
							targetB-b

						if remainingA<=0 then

							b+=1

							PollService.InjectFakeVote(
								pollID,
								"B"
							)

						elseif remainingB<=0 then

							a+=1

							PollService.InjectFakeVote(
								pollID,
								"A"
							)

						else

							local targetRatio=
								targetA/
								(targetA+targetB)

							local currentRatio=
								a/math.max(
									1,
									a+b
								)

							local diff=
								targetRatio-
								currentRatio

							local chance=
								math.clamp(
									0.5+(diff*2),
									0.35,
									0.65
								)

							if math.random()<chance then

								a+=1

								PollService.InjectFakeVote(
									pollID,
									"A"
								)

							else

								b+=1

								PollService.InjectFakeVote(
									pollID,
									"B"
								)

							end
						end

						task.wait(
							1/votesThisSecond
						)

					end

					local spent=
						tick()-startTick

					if spent<1 then
						task.wait(
							1-spent
						)
					end

				end

			end)

			return true,
			"🌍 Fake global poll started"

		end
	})

end

return module