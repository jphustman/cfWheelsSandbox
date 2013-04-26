<cfoutput>

<h1>Edit User #user.name#</h1>

<cfif flashKeyExists("success")>
    <p class="success">#flash("success")#</p>
</cfif>

#startFormTag(action="update")#
    <p>#hiddenField(objectName="user", property="id")#</p>

    <p>#textField(objectName="user", property="name", label="Name")#</p>

    <p>#textField(objectName="user", property="email", label="Email")#</p>

    <p>#passwordField(objectName="user", property="password", label="Password")#</p>

    <p>#submitTag()#</p>
#endFormTag()#

<p>#linkTo(text="Back to Index", action="index")#</p>

</cfoutput>
