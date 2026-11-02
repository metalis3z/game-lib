
local config = {
	
	UniqueId = "1";
	
	TrackingId = "UA-46440126-2";
	
	Http_MaxRequestsPerMinute = {

		SessionTracking = 80;
		
		Purchase = 100;
		
		Error = 25;
		
		Misc = 50;
		
	};
	
	
	--Http_DisableRequests = false;
	--Http_SpamPrintUsedRequestSpace = true;	
	
	Http_PrintPosts = true;
	
	PrintReports = true;
	
	--GoogleAnalytics_DebugEnabled = false;
	
}

local GA = require(game:GetService("ServerStorage"):FindFirstChild("MainModule") or 269812508).new(config)


--GA:AutoReportServerSessions()

GA:AutoReportPlayerSessions()

--GA:AutoReportServerErrors()



return GA
