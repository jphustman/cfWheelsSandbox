<cfcomponent extends="wheelsMapping.test">

	<cfinclude template="/wheelsMapping/global/functions.cfm">

	<cffunction name="test_access_public_methods">
		<cfset loc.params.controller = "filterTestPublic">
		<cfset loc.params.action = "index">
		<cfset loc.controller = $controller(controllerName="filterTestPublic", controllerPath="wheels/tests/_assets/controllers").$createControllerObject(loc.params)>
		<cfset loc.controller.$runFilters(type="before", action="index")>
		<cfset assert("StructKeyExists(request, 'filterTestPublic') AND request.filterTestPublic")>
		<cfset StructDelete(request, "filterTestPublic")>
	</cffunction>

	<cffunction name="test_access_private_methods">
		<cfset loc.params.controller = "filterTestPrivate">
		<cfset loc.params.action = "index">
		<cfset loc.controller = $controller(controllerName="filterTestPrivate", controllerPath="wheels/tests/_assets/controllers").$createControllerObject(loc.params)>
		<cfset loc.controller.$runFilters(type="before", action="index")>
		<cfset assert("StructKeyExists(request, 'filterTestPrivate') AND request.filterTestPrivate")>
		<cfset StructDelete(request, "filterTestPrivate")>
	</cffunction>

</cfcomponent>