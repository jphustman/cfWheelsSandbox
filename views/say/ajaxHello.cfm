<h1>Hello World!</h1>
<p>The current time is: <cfoutput>#time#</cfoutput></p>
<p>Time to say <cfoutput>#linkTo(text="goodbye", action="goodbye")#?</cfoutput></p>


<hr>
<cfoutput>

<h2></h2>
<p></p>

#linkTo(text="Alert me!", controller="say", action="ajaxHello", remote=true)#


</cfoutput>
