<cfoutput>
<!--- Place HTML here that should be used as the default layout of your application --->
<html>
    <body>
        #includeContent()#

        #javaScriptIncludeTag("//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js")#
        #javaScriptIncludeTag("wheels.jquery")#
    </body>
</html>
</cfoutput>
