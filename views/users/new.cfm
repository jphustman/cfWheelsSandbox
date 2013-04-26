<cfoutput>

<h1>Create a New User</h1>

#startFormTag(action="create")#

    <p>#textField(objectName="user", property="name", label="Name")#</p>

    <p>#textField(objectName="user", property="email", label="Email")#</p>

    <p>#passwordField(objectName="user", property="password", label="Password")#</p>

    <p>#submitTag()#</p>

#endFormTag()#

</cfoutput>
