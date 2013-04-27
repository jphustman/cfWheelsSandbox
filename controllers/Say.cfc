<cfcomponent extends="Controller">

    <cffunction name="init">
        <cfset provides("html,json,js")>
    </cffunction>

    <cffunction name="hello">
        <cfset time=Now()>
    </cffunction>

    <cffunction name="goodbye">

    </cffunction>

    <cffunction name="ajaxHello">
        <!--- Prepare the message for the user --->
        <cfset greeting = {}>
        <cfset greeting["message"] = "Hello, you used AJAX!">
        <cfset greeting["time"] = Now()>

        <!--- Respond to all requests with `renderWith` --->
        <cfset renderWith(greeting)>
    </cffunction>

</cfcomponent>
