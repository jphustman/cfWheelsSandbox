<cfcomponent extends="Controller">

    <cffunction name="index">
        <cfset users = model("user").findAll(order="name")>
    </cffunction>

    <cffunction name="new">
        <cfset user = model("user").new()>
    </cffunction>

    <cffunction name="create">
        <cfset user = model("user").create(params.user)>
        <cfset redirectTo(
            action="index",
            success="User #user.name# created successfully."
        )>
    </cffunction>

    <cffunction name="edit">
        <cfset user = model("user").findByKey(params.key)>
    </cffunction>

    <cffunction name="update">
        <cfset user = model("user").findByKey(params.user.id)>
        <cfset user.update(params.user)>
        <cfset redirectTo(
            action="edit",
            key=user.id,
            success="User #user.name# updated successfully."
        )>
    </cffunction>

    <cffunction name="delete">
        <cfset user = model("user").findByKey(params.key)>
        <cfset user.delete()>
        <cfset redirectTo(
            action="index",
            success="#user.name# was successfully deleted."
        )>
    </cffunction>

</cfcomponent>
