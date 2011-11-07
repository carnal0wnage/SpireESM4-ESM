<cfcomponent extends="resources.system" displayname="Spirev Media esmPI" hint="Spire Media Enterprise Site Manager">
		
	<cfscript>
		This.name="charteresm";
		This.applicationtimeout = CreateTimeSpan(2, 0, 0, 0);
		This.clientmanagement = false;
		this.clientstorage = "none";
		This.sessionmanagement = true;
		This.sessiontimeout = CreateTimeSpan(0, 2, 0, 0);
		This.setclientcookies = true;
		This.setdomaincookies = true;
		This.scriptprotect = false;
		This.loginStorage = "cookie";
	</cfscript>
	
</cfcomponent>
