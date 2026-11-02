-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(ReplicatedStorage.Library.Types.OfferFunnel)

local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Analytics = Constants.NETWORK_MAP.Analytics
local t = {}
local t2 = {}

local function fireStep(p1, p2, p3) --[[ fireStep | Line: 31 | Upvalues: Asserts (copy), Network (copy), Analytics (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.string(p3)
	assert(p3 ~= "", "SessionKey cannot be empty")
	Network.Fire(Analytics.OFFER_FUNNEL_STEP, {
		OfferName = p1,
		StepName = p2,
		SessionKey = p3
	})
end

function t2.TrackImpression(p1, p2) --[[ TrackImpression | Line: 49 | Upvalues: t (copy), wcall (copy), fireStep (copy) ]]
	if t[p1] ~= p2 then
		t[p1] = p2
		task.spawn(wcall, fireStep, p1, "Impression", p2)
	end
end
function t2.TrackOfferClick(p1, p2) --[[ TrackOfferClick | Line: 59 | Upvalues: wcall (copy), fireStep (copy) ]]
	task.spawn(wcall, fireStep, p1, "OfferClick", p2)
end
function t2.TrackBuyClick(p1, p2) --[[ TrackBuyClick | Line: 63 | Upvalues: wcall (copy), fireStep (copy) ]]
	task.spawn(wcall, fireStep, p1, "BuyClick", p2)
end
function t2.TrackDeclined(p1, p2) --[[ TrackDeclined | Line: 67 | Upvalues: wcall (copy), fireStep (copy) ]]
	task.spawn(wcall, fireStep, p1, "Declined", p2)
end

return t2