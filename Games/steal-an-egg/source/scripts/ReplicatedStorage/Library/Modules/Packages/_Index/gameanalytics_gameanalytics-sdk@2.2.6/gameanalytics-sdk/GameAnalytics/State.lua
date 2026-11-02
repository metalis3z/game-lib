-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Validation = require(script.Parent.Validation)
local Logger = require(script.Parent.Logger)
local HttpApi = require(script.Parent.HttpApi)
local Store = require(script.Parent.Store)
local Events = require(script.Parent.Events)
local HttpService = game:GetService("HttpService")
local t = {
	_enableEventSubmission = true,
	Initialized = false,
	ReportErrors = true,
	UseCustomUserId = false,
	AutomaticSendBusinessEvents = true,
	ConfigsHash = "",
	_availableCustomDimensions01 = {},
	_availableCustomDimensions02 = {},
	_availableCustomDimensions03 = {},
	_availableGamepasses = {}
}
local v1 = nil

local function getClientTsAdjusted(p1) --[[ getClientTsAdjusted | Line: 23 | Upvalues: Store (copy), Validation (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p1)

	if not v1 then
		return os.time()
	end

	local v2 = os.time()
	local v3 = v2 + v1.ClientServerTimeOffset

	if Validation:validateClientTs(v3) then
		return v3
	end

	return v2
end

local function populateConfigurations(p1) --[[ populateConfigurations | Line: 38 | Upvalues: Store (copy), Validation (copy), Logger (copy), v1 (ref) ]]
	local v12 = Store:GetPlayerDataFromCache(p1.UserId)
	local SdkConfig = v12.SdkConfig

	if SdkConfig.configs then
		for k, v in pairs(SdkConfig.configs) do
			local v2

			if v then
				local v3 = v.key or ""
				local v6 = Store:GetPlayerDataFromCache(p1.UserId)

				if v6 then
					local v7 = os.time()
					local v8 = v7 + v6.ClientServerTimeOffset

					v2 = if Validation:validateClientTs(v8) then v8 else v7
				else
					v2 = os.time()
				end

				if #v3 > 0 and (v.value and ((v.start_ts or 0) < v2 and v2 < (v.end_ts or (1 / 0)))) then
					v12.Configurations[v3] = v.value
					Logger:d("configuration added: key=" .. v.key .. ", value=" .. v.value)
				end
			end
		end
	end

	Logger:i("Remote configs populated")
	v12.RemoteConfigsIsReady = true
	v1 = v1 or game:GetService("ReplicatedStorage"):WaitForChild("GameAnalyticsRemoteConfigs")
	v1:FireClient(p1, v12.Configurations)
end

function t.sessionIsStarted(p1, p2) --[[ sessionIsStarted | Line: 75 | Upvalues: Store (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p2)

	if not v1 then
		return false
	end

	return v1.SessionStart ~= 0
end
function t.isEnabled(p1, p2) --[[ isEnabled | Line: 84 | Upvalues: Store (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p2)

	if v1 then
		return v1.InitAuthorized and true or false
	end

	return false
end
function t.validateAndFixCurrentDimensions(p1, p2) --[[ validateAndFixCurrentDimensions | Line: 95 | Upvalues: Store (copy), Validation (copy), Logger (copy) ]]
	local v1 = Store:GetPlayerDataFromCache(p2)

	if not Validation:validateDimension(p1._availableCustomDimensions01, v1.CurrentCustomDimension01) then
		Logger:d("Invalid dimension01 found in variable. Setting to nil. Invalid dimension: " .. v1.CurrentCustomDimension01)
	end

	if not Validation:validateDimension(p1._availableCustomDimensions02, v1.CurrentCustomDimension02) then
		Logger:d("Invalid dimension02 found in variable. Setting to nil. Invalid dimension: " .. v1.CurrentCustomDimension02)
	end

	if Validation:validateDimension(p1._availableCustomDimensions03, v1.CurrentCustomDimension03) then
		return
	end

	Logger:d("Invalid dimension03 found in variable. Setting to nil. Invalid dimension: " .. v1.CurrentCustomDimension03)
end
function t.setAvailableCustomDimensions01(p1, p2) --[[ setAvailableCustomDimensions01 | Line: 123 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateCustomDimensions(p2) then
		p1._availableCustomDimensions01 = p2
		Logger:i("Set available custom01 dimension values: (" .. table.concat(p2, ", ") .. ")")
	end
end
function t.setAvailableCustomDimensions02(p1, p2) --[[ setAvailableCustomDimensions02 | Line: 132 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateCustomDimensions(p2) then
		p1._availableCustomDimensions02 = p2
		Logger:i("Set available custom02 dimension values: (" .. table.concat(p2, ", ") .. ")")
	end
end
function t.setAvailableCustomDimensions03(p1, p2) --[[ setAvailableCustomDimensions03 | Line: 141 | Upvalues: Validation (copy), Logger (copy) ]]
	if Validation:validateCustomDimensions(p2) then
		p1._availableCustomDimensions03 = p2
		Logger:i("Set available custom03 dimension values: (" .. table.concat(p2, ", ") .. ")")
	end
end
function t.setAvailableGamepasses(p1, p2) --[[ setAvailableGamepasses | Line: 150 | Upvalues: Logger (copy) ]]
	p1._availableGamepasses = p2
	Logger:i("Set available game passes: (" .. table.concat(p2, ", ") .. ")")
end
function t.setEventSubmission(p1, p2) --[[ setEventSubmission | Line: 155 ]]
	p1._enableEventSubmission = p2
end
function t.isEventSubmissionEnabled(p1) --[[ isEventSubmissionEnabled | Line: 159 ]]
	return p1._enableEventSubmission
end
function t.setCustomDimension01(p1, p2, p3) --[[ setCustomDimension01 | Line: 163 | Upvalues: Store (copy) ]]
	Store:GetPlayerDataFromCache(p2).CurrentCustomDimension01 = p3
end
function t.setCustomDimension02(p1, p2, p3) --[[ setCustomDimension02 | Line: 168 | Upvalues: Store (copy) ]]
	Store:GetPlayerDataFromCache(p2).CurrentCustomDimension02 = p3
end
function t.setCustomDimension03(p1, p2, p3) --[[ setCustomDimension03 | Line: 173 | Upvalues: Store (copy) ]]
	Store:GetPlayerDataFromCache(p2).CurrentCustomDimension03 = p3
end
function t.startNewSession(p1, p2, p3, p4) --[[ startNewSession | Line: 178 | Upvalues: t (copy), Logger (copy), Store (copy), HttpApi (copy), Events (copy), populateConfigurations (copy), HttpService (copy), Validation (copy) ]]
	if t:isEventSubmissionEnabled() and p3 == nil then
		Logger:i("Starting a new session.")
	end

	local v1 = Store:GetPlayerDataFromCache(p2.UserId)

	t:validateAndFixCurrentDimensions(p2.UserId)

	local v2 = HttpApi:initRequest(Events.GameKey, Events.SecretKey, Events.Build, v1, p2.UserId)
	local statusCode = v2.statusCode
	local body = v2.body

	if (statusCode == HttpApi.EGAHTTPApiResponse.Ok or statusCode == HttpApi.EGAHTTPApiResponse.Created) and body then
		local v3 = body.server_ts or -1

		body.time_offset = if v3 > 0 then v3 - os.time() else 0

		if statusCode ~= HttpApi.EGAHTTPApiResponse.Created then
			local SdkConfig = v1.SdkConfig

			if SdkConfig.configs then
				body.configs = SdkConfig.configs
			end

			if SdkConfig.ab_id then
				body.ab_id = SdkConfig.ab_id
			end

			if SdkConfig.ab_variant_id then
				body.ab_variant_id = SdkConfig.ab_variant_id
			end
		end

		v1.SdkConfig = body
		v1.InitAuthorized = true
	elseif statusCode == HttpApi.EGAHTTPApiResponse.Unauthorized then
		Logger:w("Initialize SDK failed - Unauthorized")
		v1.InitAuthorized = false
	else
		if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse or statusCode == HttpApi.EGAHTTPApiResponse.RequestTimeout then
			Logger:i("Init call (session start) failed - no response. Could be offline or timeout.")
		elseif statusCode == HttpApi.EGAHTTPApiResponse.BadResponse or (statusCode == HttpApi.EGAHTTPApiResponse.JsonEncodeFailed or statusCode == HttpApi.EGAHTTPApiResponse.JsonDecodeFailed) then
			Logger:i("Init call (session start) failed - bad response. Could be bad response from proxy or GA servers.")
		elseif statusCode == HttpApi.EGAHTTPApiResponse.BadRequest or statusCode == HttpApi.EGAHTTPApiResponse.UnknownResponseCode then
			Logger:i("Init call (session start) failed - bad request or unknown response.")
		end

		v1.InitAuthorized = true
	end

	v1.ClientServerTimeOffset = v1.SdkConfig.time_offset or 0
	v1.ConfigsHash = v1.SdkConfig.configs_hash or ""
	v1.AbId = v1.SdkConfig.ab_id or ""
	v1.AbVariantId = v1.SdkConfig.ab_variant_id or ""
	populateConfigurations(p2)

	if not t:isEnabled(p2.UserId) then
		Logger:w("Could not start session: SDK is disabled.")

		return
	end

	if p3 then
		v1.SessionID = p3.SessionID
		v1.SessionStart = p3.SessionStart
	else
		v1.SessionID = string.lower(HttpService:GenerateGUID(false))

		local v5 = Store:GetPlayerDataFromCache(p2.UserId)
		local v6

		if v5 then
			local v7 = os.time()
			local v8 = v7 + v5.ClientServerTimeOffset

			v6 = if Validation:validateClientTs(v8) then v8 else v7
		else
			v6 = os.time()
		end

		v1.SessionStart = v6
	end

	if not t:isEventSubmissionEnabled() then
		return
	end

	Events:addSessionStartEvent(p2.UserId, p3, p4)
end
function t.endSession(p1, p2, p3) --[[ endSession | Line: 277 | Upvalues: t (copy), Logger (copy), Events (copy), Store (copy) ]]
	if not (t.Initialized and t:isEventSubmissionEnabled()) then
		return
	end

	Logger:i("Ending session.")

	if not (t:isEnabled(p2) and t:sessionIsStarted(p2)) then
		return
	end

	Events:addSessionEndEvent(p2, p3)
	Store.PlayerCache[p2] = nil
end
function t.getRemoteConfigsStringValue(p1, p2, p3, p4) --[[ getRemoteConfigsStringValue | Line: 287 | Upvalues: Store (copy) ]]
	return Store:GetPlayerDataFromCache(p2).Configurations[p3] or p4
end
function t.isRemoteConfigsReady(p1, p2) --[[ isRemoteConfigsReady | Line: 292 | Upvalues: Store (copy) ]]
	return Store:GetPlayerDataFromCache(p2).RemoteConfigsIsReady
end
function t.getRemoteConfigsContentAsString(p1, p2) --[[ getRemoteConfigsContentAsString | Line: 297 | Upvalues: Store (copy), HttpService (copy) ]]
	return HttpService:JSONEncode(Store:GetPlayerDataFromCache(p2).Configurations)
end

return t