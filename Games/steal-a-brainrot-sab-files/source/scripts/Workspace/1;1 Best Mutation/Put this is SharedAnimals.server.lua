--[[

elseif p4 == "Toxic" then

			local TweenService =
				game:GetService("TweenService")

			local EffectFolder =
				Instance.new("Folder")

			EffectFolder.Name =
				"ToxicEffects"

			EffectFolder.Parent =
				p2


			local Root =
				p2.PrimaryPart
				or p2:FindFirstChildWhichIsA(
					"BasePart"
				)


			if Root then

				-- TOXIC GREEN AURA

				local Highlight =
					Instance.new("Highlight")

				Highlight.Name =
					"ToxicAura"

				Highlight.Adornee =
					p2

				Highlight.FillColor =
					Color3.fromRGB(
						20,
						180,
						45
					)

				Highlight.OutlineColor =
					Color3.fromRGB(
						120,
						255,
						70
					)

				Highlight.FillTransparency =
					0.88

				Highlight.OutlineTransparency =
					0.15

				Highlight.Parent =
					EffectFolder


				local Glow =
					Instance.new("PointLight")

				Glow.Name =
					"ToxicGlow"

				Glow.Color =
					Color3.fromRGB(
						60,
						255,
						45
					)

				Glow.Brightness =
					0.4

				Glow.Range =
					7

				Glow.Parent =
					Root


				-- SAVE ORIGINAL TRANSPARENCY

				local Parts = {}

				for _, Object in
					p2:GetDescendants() do

					if Object:IsA("BasePart")
						and not t[Object] then

						Parts[Object] =
							Object.Transparency

					end

				end


				task.spawn(function()

					while
						p2.Parent
						and EffectFolder.Parent
					do

						-- GREEN TOXIC PULSE

						local PulseIn =
							TweenService:Create(

								Highlight,

								TweenInfo.new(
									1.8,
									Enum.EasingStyle.Sine,
									Enum.EasingDirection.InOut
								),

								{
									FillTransparency = 0.55,
									OutlineTransparency = 0
								}

							)

						PulseIn:Play()


						TweenService:Create(

							Glow,

							TweenInfo.new(
								1.8,
								Enum.EasingStyle.Sine,
								Enum.EasingDirection.InOut
							),

							{
								Brightness = 1.5,
								Range = 11
							}

						):Play()


						PulseIn.Completed:Wait()


						-- GREEN PART FINISHED


						-- FADE THE WHOLE BRAINROT AWAY

						for Part in pairs(Parts) do

							if Part.Parent then

								TweenService:Create(

									Part,

									TweenInfo.new(
										0.5,
										Enum.EasingStyle.Sine,
										Enum.EasingDirection.InOut
									),

									{
										Transparency = 1
									}

								):Play()

							end

						end


						task.wait(0.5)


						-- STAY INVISIBLE FOR 2 SECONDS

						task.wait(2)


						-- BRING THE WHOLE BRAINROT BACK

						for Part, Transparency in
							pairs(Parts) do

							if Part.Parent then

								TweenService:Create(

									Part,

									TweenInfo.new(
										0.7,
										Enum.EasingStyle.Sine,
										Enum.EasingDirection.InOut
									),

									{
										Transparency =
											Transparency
									}

								):Play()

							end

						end


						-- RESET THE TOXIC AURA

						TweenService:Create(

							Highlight,

							TweenInfo.new(
								1.5,
								Enum.EasingStyle.Sine,
								Enum.EasingDirection.InOut
							),

							{
								FillTransparency = 0.9,
								OutlineTransparency = 0.25
							}

						):Play()


						TweenService:Create(

							Glow,

							TweenInfo.new(
								1.5,
								Enum.EasingStyle.Sine,
								Enum.EasingDirection.InOut
							),

							{
								Brightness = 0.4,
								Range = 7
							}

						):Play()


						task.wait(2)

					end

				end)

			end

--]]