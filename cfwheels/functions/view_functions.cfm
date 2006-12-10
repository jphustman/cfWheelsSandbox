<!--- Functions that return HTML --->

<cffunction name="stylesheetLinkTag" output="false" returntype="string" hint="[DOCS] Returns a css link tag per source given as argument">
	<cfargument name="name" type="string" required="yes" hint="Comma delimited list of stylesheets to create tags for">
	<cfargument name="media" type="string" required="no" default="all" hint="Media type for the stylesheets (print,screen,aural,etc)">

	<!---
	[DOCS:COMMENTS START]
	You have to place all .css files in the "/stylesheets" folder or below it when using this function to include them. 
	If you supply the media argument it applies to all supplied stylesheets so if you need to output links for different media types you should call this function multiple times.
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Include layout.css and forms.css:
	#stylesheetLinkTag("layout,forms")#
	[DOCS:EXAMPLE 1 END]

	[DOCS:EXAMPLE 2 START]
	Include forprint.css and set the media type to print:
	#stylesheetLinkTag(name="forprint", media="print")#
	[DOCS:EXAMPLE 2 END]
	--->

	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<cfloop list="#arguments.name#" index="thisSheet"><link rel="stylesheet" href="#application.pathTo.stylesheets#/#Trim(thisSheet)#.css" type="text/css" media="#arguments.media#" /></cfloop>
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>


<cffunction name="javascriptIncludeTag" output="false" hint="[DOCS] Returns a script include tag per source given as argument">
	<cfargument name="name" type="string" required="true" hint="Comma delimited list of .js files to create tags for">
	
	<!---
	[DOCS:COMMENTS START]
	You have to place all .js files in the "/javascripts" folder or below it when using this function to include them. 
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Include myscripts.js and prototype.js:
	#javascriptIncludeTag("myscripts,prototype")#
	[DOCS:EXAMPLE 1 END]
	--->

	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<cfloop list="#arguments.name#" index="thisScript"><script src="#application.pathTo.javascripts#/#Trim(thisScript)#.js" type="text/javascript"></script></cfloop>
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>


<cffunction name="imageTag" output="false" hint="[DOCS] Returns an image tag">
	<cfargument name="source" type="string" required="yes" hint="The source for the image">
	<cfargument name="alt" type="string" required="no" default="" hint="Content for the alt attribute">
	<cfargument name="size" type="string" required="no" default="" hint="Content for the width and height attributes. Supplied as XxY">
	<cfargument name="id" type="string" required="no" default="" hint="Content for the id attribute">
	<cfargument name="class" type="string" required="no" default="" hint="Content for the class attribute">
	<cfargument name="style" type="string" required="no" default="" hint="Content for the style attribute">

	<!---
	[DOCS:COMMENTS START]
	The source argument can be supplied as a full path, a filename which assumes the image is in "/images" or a name only which assumes the image is in "/images" and is in the PNG format.
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Display logo.png in the "/images" folder:
	#imageTag(source="logo")#
	[DOCS:EXAMPLE 1 END]
	--->

	<cfset var src = "">
	<cfset var sizeArray = ArrayNew(1)>
	<cfset var output = "">
	
	<cfif Left(arguments.source, 1) IS "/">
		<cfset src = arguments.source>
	<cfelseif arguments.source Contains ".">
		<cfset src = "#application.pathTo.images#/#arguments.source#">
	<cfelse>
		<cfset src = "#application.pathTo.images#/#arguments.source#.png">
	</cfif>
	
	<cfif arguments.size IS NOT "">
		<cfset sizeArray = listToArray(size, "x")>
	</cfif>
	
	<cfsavecontent variable="output"><cfoutput>
		<img src="#src#"<cfif ArrayLen(sizeArray) GT 0> width="#sizeArray[1]#" height="#sizeArray[2]#"</cfif><cfif arguments.alt IS NOT ""> alt="#arguments.alt#"</cfif><cfif arguments.id IS NOT ""> id="#arguments.id#"</cfif><cfif arguments.class IS NOT ""> class="#arguments.class#"</cfif><cfif arguments.style IS NOT ""> style="#arguments.style#"</cfif> />
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>


<cffunction name="mailTo" output="false" hint="[DOCS] Creates a link tag for starting an email to the specified email_address, which is also used as the name of the link unless name is specified">
	<cfargument name="email_address" type="string" required="yes" hint="The email address to send to">
	<cfargument name="encode" type="boolean" required="no" default="false" hint="If set to true the code will be obfuscated thus making it harder for spiders to harvest the email address.">
	<cfargument name="name" type="string" required="no" default="" hint="The text to wrap with the link">
	<!--- arguments for the link --->
	<cfargument name="id" type="string" required="no" default="" hint="Content for the id attribute">
	<cfargument name="class" type="string" required="no" default="" hint="Content for the class attribute">
	<cfargument name="style" type="string" required="no" default="" hint="Content for style attribute">
	<cfargument name="title" type="string" required="no" default="" hint="Content for the title attribute">
	
	<!---
	[DOCS:COMMENTS START]
	If you do not pass in 'name' it will default to the email address.
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Create a regular mailto link:
	#mailTo(email_address="webmaster@mysite.com")#
	[DOCS:EXAMPLE 1 END]

	[DOCS:EXAMPLE 2 START]
	Creates an obfuscated version of the code above (meaning the email address never appears as plain text in the source code):
	#mailTo(email_address="webmaster@mysite.com", encode=true)#
	[DOCS:EXAMPLE 2 END]
	--->
	
	<cfset var js = "">
	<cfset var encoded = "">
	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<a href="mailto:#arguments.email_address#"<cfif arguments.id IS NOT ""> id="#arguments.id#"</cfif><cfif arguments.class IS NOT ""> class="#arguments.class#"</cfif><cfif arguments.style IS NOT ""> style="#arguments.style#"</cfif><cfif arguments.title IS NOT ""> title="#arguments.title#"</cfif>><cfif arguments.name IS NOT "">#arguments.name#<cfelse>#arguments.email_address#</cfif></a>
	</cfoutput></cfsavecontent>
	<cfif arguments.encode IS true>
		<cfset js = "document.write('#Trim(output)#');">
		<cfloop index="i" from="1" to="#Len(js)#">
			<cfset encoded = encoded & "%" & right("0" & FormatBaseN(Asc(Mid(js,i,1)),16),2)>
		</cfloop>
		<cfset output = "<script type=""text/javascript"" language=""javascript"">eval(unescape('#encoded#'))</script>">
	</cfif>

	<cfreturn trim(output)>
</cffunction>


<cffunction name="linkTo" output="false" returntype="string" hint="[DOCS] Creates a link tag of the given name using an URL created by the supplied arguments">
	<cfargument name="link" type="string" required="no" default="" hint="The full URL to link to (only use this when not using controller/action/id type links)">
	<cfargument name="name" type="string" required="no" default="" hint="The text to wrap with the link">
	<cfargument name="linkID" type="string" required="no" default="" hint="Content for the id attribute">
	<cfargument name="class" type="string" required="no" default="" hint="Content for the class attribute">
	<cfargument name="style" type="string" required="no" default="" hint="Content for style attribute">
	<cfargument name="title" type="string" required="no" default="" hint="Content for the title attribute">
	<cfargument name="target" type="string" required="no" default="" hint="Content for the target attribute">
	<cfargument name="confirm" type="string" required="no" default="" hint="The question string for a javascript confirm alert">

	<!---
	[DOCS:ARGUMENTS]
	URLFor
	[DOCS:ARGUMENTS END]
	
	[DOCS:COMMENTS START]
	Supply the controller argument with a starting "/" if you don't want to use defaults in the generated url (ie the current action and id will not be included in the link).
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Link to delete a product with a javascript confirmation prompt:
	#linkTo(action="delete_product", id=id, confirm="Are you sure?")#
	[DOCS:EXAMPLE 1 END]
	--->

	<cfset var url = "">
	<cfset var output = "">
	<cfset var new_arguments = "">
	<cfset var i = "">
	
	<cfif arguments.link IS NOT "">
		<cfset url = arguments.link>
	<cfelse>
		<cfset new_arguments = duplicate(arguments)>
		<cfloop list="link,name,linkID,class,style,title,target,confirm" index="i">
			<cfset structDelete(new_arguments, i)>
		</cfloop>
		<cfset url = urlFor(argumentCollection=new_arguments)>
	</cfif>
	
	<cfif arguments.name IS "">
		<cfset arguments.name = url>
	</cfif>
	
	<cfsavecontent variable="output"><cfoutput>	
		<a href="#url#"<cfif arguments.title IS NOT ""> title="#arguments.title#"</cfif><cfif arguments.class IS NOT ""> class="#arguments.class#"</cfif><cfif arguments.style IS NOT ""> style="#arguments.style#"</cfif><cfif arguments.linkID IS NOT ""> id="#arguments.linkID#"</cfif><cfif arguments.target IS NOT ""> target="#arguments.target#"</cfif><cfif arguments.confirm IS NOT ""> onclick="return confirm('#JSStringFormat(arguments.confirm)#');"</cfif>>#arguments.name#</a>
	</cfoutput></cfsavecontent>

	<cfreturn trim(output)>
</cffunction>


<cffunction name="linkImageTo" output="false" returntype="string" hint="[DOCS] Returns an image wrapped in a link tag using an URL created by the supplied arguments">
		
	<!---
	[DOCS:ARGUMENTS]
	URLFor
	linkTo (linkClass|class,linkStyle|style)
	imageTag (image|id,imageClass|class,imageStyle|style)
	[DOCS:ARGUMENTS END]

	[DOCS:EXAMPLE 1 START]
	Link back to home page using the company logo:
	#linkImageTo(source="logo.gif", alt="Company Logo", controller="main", action="index")#
	[DOCS:EXAMPLE 1 END]
	--->

	<cfset var theLink = "">
	<cfset var theImage = "">
	<cfset var imageLink = "">
	<cfset var output = "">
	<cfset var new_arguments = "">
	<cfset var i = "">
	
	<cfset arguments.name = chr(7)>
	
	<cfif structKeyExists(arguments,'linkClass') AND arguments.linkClass IS NOT "">
		<cfset arguments.class = arguments.linkClass>
	<cfelse>
		<cfset arguments.class = "">
	</cfif>
	<cfif structKeyExists(arguments,'linkStyle') AND arguments.linkStyle IS NOT "">
		<cfset arguments.style = arguments.linkStyle>
	<cfelse>
		<cfset arguments.style = "">
	</cfif>
	
	<cfset new_arguments = duplicate(arguments)>
	<cfloop list="source,alt,size,imageID,imageClass,imageStyle,linkClass,linkStyle" index="i">
		<cfset structDelete(new_arguments, i)>
	</cfloop>
	<cfset theLink = linkTo(argumentCollection=new_arguments)>

	<cfif structKeyExists(arguments,'imageClass') AND arguments.imageClass IS NOT "">
		<cfset arguments.class = arguments.imageClass>
	<cfelse>
		<cfset arguments.class = "">
	</cfif>
	<cfif structKeyExists(arguments,'imageStyle') AND arguments.imageStyle IS NOT "">
		<cfset arguments.style = arguments.imageStyle>
	<cfelse>
		<cfset arguments.style = "">
	</cfif>
	<cfif structKeyExists(arguments,'imageID') AND arguments.imageID IS NOT "">
		<cfset arguments.id = arguments.imageID>
	<cfelse>
		<cfset arguments.id = "">
	</cfif>

	<cfset new_arguments = duplicate(arguments)>
	<cfloop list="link,controller,action,anchor,onlypath,trailingSlash,host,protocol,imageID,imageClass,imageStyle,linkID,linkClass,linkStyle,title,target,confirm" index="i">
		<cfset structDelete(new_arguments, i)>
	</cfloop>
	<cfset theImage = imageTag(argumentCollection=new_arguments)>

	<cfset output = replace(theLink, chr(7), Trim(theImage))>

	<cfreturn trim(output)>	
</cffunction>


<cffunction name="linkImageToUnlessCurrent" output="false" returntype="string" hint="[DOCS] Returns an image wrapped in a link tag using an URL created by the supplied arguments unless the current request is the same as the link's, in which case only the image is returned">

	<!---
	[DOCS:ARGUMENTS]
	URLFor
	linkTo (linkClass|class,linkStyle|style)
	imageTag (image|id,imageClass|class,imageStyle|style)
	[DOCS:ARGUMENTS END]

	[DOCS:EXAMPLE 1 START]
	Link back to home page with logo.jpg in the "/public/skins/3/" folder unless we're currently on the home page:
	#linkImageToUnlessCurrent(source="/skins/3/logo.jpg", size="50x100", controller="main", action="index")#
	[DOCS:EXAMPLE 1 END]
	--->
		
	<cfset var output = "">
	<cfset var new_arguments = "">
	<cfset var i = "">
	
	<cfsavecontent variable="output">	
		<cfif isCurrentPage(controller=arguments.controller, action=arguments.action, id=arguments.id) IS true>
			<cfif arguments.imageClass IS NOT "">
				<cfset arguments.class = arguments.imageClass>
			<cfelse>
				<cfset arguments.class = "">
			</cfif>
			<cfif arguments.imageStyle IS NOT "">
				<cfset arguments.style = arguments.imageStyle>
			<cfelse>
				<cfset arguments.style = "">
			</cfif>
			<cfif arguments.imageID IS NOT "">
				<cfset arguments.id = arguments.imageID>
			<cfelse>
				<cfset arguments.id = "">
			</cfif>
			<cfset new_arguments = duplicate(arguments)>
			<cfloop list="link,controller,action,anchor,onlypath,trailingSlash,host,protocol,imageID,imageClass,imageStyle,linkID,linkClass,linkStyle,title,target,confirm" index="i">
				<cfset structDelete(new_arguments, i)>
			</cfloop>
			<cfoutput>#imageTag(argumentCollection=new_arguments)#</cfoutput>
		<cfelse>
			<cfoutput>#linkImageTo(argumentCollection=arguments)#</cfoutput>
		</cfif>
	</cfsavecontent>

	<cfreturn trim(output)>
</cffunction>


<cffunction name="linkToUnlessCurrent" output="false" returntype="string" hint="[DOCS] Creates a link tag of the given name using an URL created by the supplied arguments unless the current request is the same as the link's, in which case only the name is returned">

	<!---
	[DOCS:ARGUMENTS]
	linkTo
	URLFor
	[DOCS:ARGUMENTS END]

	[DOCS:COMMENTS START]
	Takes the same arguments as the linkTo function.
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	A typical website menu:
	<ul>
		<li>#linkToUnlessCurrent(name="Home Page", action="home")#</li>
	  	<li>#linkToUnlessCurrent(name="Search Products", action="search")#</li>
	  	<li>#linkToUnlessCurrent(name="View Shopping Cart", action="cart")#</li>
	</ul>
	[DOCS:EXAMPLE 1 END]
	--->
	
	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<cfif isCurrentPage(argumentCollection=arguments) IS true>
			#arguments.name#
		<cfelse>
			#linkTo(argumentCollection=arguments)#
		</cfif>
	</cfoutput></cfsavecontent>

	<cfreturn trim(output)>
</cffunction>


<cffunction name="simpleFormat" output="false" returntype="string" hint="[DOCS] Returns text transformed into HTML using very simple formatting rules">
	<cfargument name="text" type="string" required="yes" hint="The text to format">
		
	<!---
	[DOCS:COMMENTS START]
	Surrounds paragraphs with <p> / </p> tags, and converts line breaks into <br />.
	Two consecutive newlines are considered as a paragraph, one newline is considered a linebreak.
	[DOCS:COMMENTS END]

	[DOCS:EXAMPLE 1 START]
	Format some text stored in a variable (since this function only takes one argument there is no need to name it):
	#simpleFormat(comment)#
	[DOCS:EXAMPLE 1 END]
	--->
	
	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<p>#replace(replace(replace(replace(arguments.text, "#chr(13)##chr(10)##chr(13)##chr(10)#", "</p><p>", "all"), "#chr(13)##chr(10)#", "<br />", "all"), "#chr(10)##chr(10)#", "</p><p>", "all"), "#chr(10)#", "<br />", "all")#</p>
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>


<!---
<cffunction name="truncate" output="false" returntype="string" hint="[DOCS] Truncates text to the supplied length and replaces the last three characters with the supplied truncate_string if the text is longer than length">
	<cfargument name="text" type="string" required="yes" hint="The text to truncate">
	<cfargument name="length" type="numeric" required="yes" hint="The length to truncate at">
	<cfargument name="truncateString" type="string" required="no" default="..." hint="The string to replace the last 3 characters with">
		
	<!---
	[DOCS:EXAMPLE 1 START]
	Keeps the product description at 30 characters with "..." at the end:
	#truncate(description, 30)#
	[DOCS:EXAMPLE 1 END]

	[DOCS:EXAMPLE 2 START]
	Keeps the product description at 50 characters and inserts a link when the length is longer:
	<cfset readMoreLink = linkTo(name=" (read more...)", action="show_product")>
	#truncate(text=description, length=50, truncateString=readMoreLink)#
	[DOCS:EXAMPLE 2 END]
	--->

	<cfset var output = "">
	
	<cfsavecontent variable="output"><cfoutput>
		<cfif len(arguments.text) GT arguments.length>
			#left(arguments.text, (arguments.length-3))##arguments.truncateString#
		<cfelse>
			#arguments.text#
		</cfif>
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>


<cffunction name="paginationLinks" output="false" returntype="string" hint="[DOCS] Creates links for the given paginator">
	<cfargument name="model" type="string" required="yes" hint="Name of the model to create links for">
	<cfargument name="name" type="string" required="no" default="page" hint="The variable name for this paginator">
	<cfargument name="windowSize" type="numeric" required="no" default=2 hint="The number of pages to show around the current page">
	<cfargument name="linkToCurrentPage" type="boolean" required="no" default="false" hint="Whether or not the current page should be linked to">
	<cfargument name="prependToLink" type="string" required="no" default="" hint="The HTML to prepend to each link">
	<cfargument name="appendToLink" type="string" required="no" default="" hint="The HTML to append to each link">
	<cfargument name="classForCurrent" type="string" required="no" default="" hint="The class to set for the link to the current page (if linkToCurrentPage is set to false the number is wrapped in a span tag with the class)">
	<cfargument name="alwaysShowAnchors" type="boolean" required="no" default="true" hint="Whether or not the first and last pages should always be shown">

	<!---
	[DOCS:EXAMPLE 1 START]
	Keeps the product description at 30 characters with "..." at the end:
	#truncate(description, 30)#
	[DOCS:EXAMPLE 1 END]

	[DOCS:EXAMPLE 2 START]
	Keeps the product description at 50 characters and inserts a link when the length is longer:
	<cfset readMoreLink = linkTo(name=" (read more...)", action="show_product")>
	#truncate(text=description, length=50, truncateString=readMoreLink)#
	[DOCS:EXAMPLE 2 END]
	--->

	<cfset var thisModel = evaluate("#arguments.model#")>
	<cfset var new_arguments = "">
	<cfset var i = "">
	<cfset var output = "">

	<cfset new_arguments = duplicate(arguments)>
	<cfloop list="model,name,windowSize,linkToCurrentPage,prependToLink,appendToLink,classForCurrent,alwaysShowAnchors" index="i">
		<cfset structDelete(new_arguments, i)>
	</cfloop>
	
	<cfsavecontent variable="output"><cfoutput>
		<cfif arguments.alwaysShowAnchors>
			<cfif (thisModel.paginatorCurrentPage - arguments.windowSize) GT 1>
				<cfset "new_arguments.#arguments.name#" = 1>
				<cfset new_arguments.name = 1>
				#linkTo(argumentCollection=new_arguments)# ...
			</cfif>
		</cfif>
		<cfloop from="1" to="#thisModel.paginatorTotalPages#" index="i">
			<cfif (i GTE (thisModel.paginatorCurrentPage - arguments.windowSize) AND i LTE thisModel.paginatorCurrentPage) OR (i LTE (thisModel.paginatorCurrentPage + arguments.windowSize) AND i GTE thisModel.paginatorCurrentPage)>
				<cfset "new_arguments.#arguments.name#" = i>
				<cfset new_arguments.name = i>
				<cfif arguments.classForCurrent IS NOT "" AND thisModel.paginatorCurrentPage IS i>
					<cfset new_arguments.class = arguments.classForCurrent>
				<cfelse>
					<cfset new_arguments.class = "">
				</cfif>
				<cfif arguments.prependToLink IS NOT "">#arguments.prependToLink#</cfif><cfif thisModel.paginatorCurrentPage IS NOT i OR arguments.linkToCurrentPage>#linkTo(argumentCollection=new_arguments)#<cfelse><cfif arguments.classForCurrent IS NOT ""><span class="#arguments.classForCurrent#">#i#</span><cfelse>#i#</cfif></cfif><cfif arguments.appendToLink IS NOT "">#arguments.appendToLink#</cfif>
			</cfif>
		</cfloop>
		<cfif arguments.alwaysShowAnchors>
			<cfif thisModel.paginatorTotalPages GT (thisModel.paginatorCurrentPage + arguments.windowSize)>
				<cfset "new_arguments.#arguments.name#" = thisModel.paginatorTotalPages>
				<cfset new_arguments.name = thisModel.paginatorTotalPages>
			... #linkTo(argumentCollection=new_arguments)#
			</cfif>
		</cfif>
	</cfoutput></cfsavecontent>
	
	<cfreturn trim(output)>
</cffunction>
--->

<!--- Internal Functions --->


<cffunction name="isCurrentPage" output="false" returntype="boolean" hint="returns true if the current page is the same as the arguments passed in">
	<cfargument name="controller" type="string" required="no" default="" hint="The controller to link to">
	<cfargument name="action" type="string" required="no" default="" hint="The action to link to">
	<cfargument name="id" type="numeric" required="no" default=0 hint="The ID to link to">
			
	<cfif #urlFor(arguments.controller, arguments.action, arguments.id)# IS #request.currentrequest#>
		<cfreturn true>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>


<cffunction name="URLFor" output="true" returntype="string" hint="Outputs a URL for the included parameters">
	<cfargument name="controller" type="string" required="no" default="" hint="The controller to link to">
	<cfargument name="action" type="string" required="no" default="" hint="The action to link to">
	<cfargument name="id" type="numeric" required="no" default=0 hint="The ID to link to">
	<cfargument name="anchor" type="string" required="no" default="" hint="Specifies the anchor name to be appended to the URL">
	<cfargument name="onlyPath" type="boolean" required="no" default="true" hint="If true, returns the absolute URL (omitting the protocol, host name, and port)">
	<cfargument name="trailingSlash" type="boolean" required="no" default="false" hint="If true, adds a trailing slash">
	<cfargument name="host" type="string" required="no" default="" hint="Overrides the current host if provided">
	<cfargument name="protocol" type="string" required="no" default="" hint="Overrides the default protocol if provided">
	
	<cfset var url = "">
	<cfset var newController = "">
	<cfset var newAction = "">
	<cfset var newID = "">
	<cfset var newParams = "">
	<cfset var argList = "controller,action,id,anchor,onlyPath,trailingSlash,host,protocol">

	<cfif arguments.controller IS NOT "">
		<cfset newController = arguments.controller>
	<cfelse>
		<cfset newController = request.params.controller>
	</cfif>

	<cfif arguments.action IS NOT "">
		<cfset newAction = arguments.action>
	<cfelse>
		<cfif newController IS request.params.controller>
			<!--- Keep the action only if controller stays the same --->
			<cfset newAction = request.params.action>
		</cfif>
	</cfif>

	<cfif arguments.id IS NOT 0>
		<cfset newID = arguments.id>
	<cfelse>
		<cfif isDefined("request.params.id") AND request.params.id IS NOT "" AND newController IS request.params.controller AND newAction IS request.params.action>
			<!--- Keep the ID only if controller and action stays the same --->
			<cfset newID = request.params.id>
		</cfif>
	</cfif>

	<cfloop collection="#arguments#" item="arg">
		<cfif NOT listFindNoCase(argList, arg)>
			<cfif newParams Does Not Contain "?">
				<cfset newParams = "?">
			</cfif>
			<cfset newParams = newParams & arg & "=" & evaluate("arguments.#arg#") & "&">
		</cfif>
	</cfloop>
	<cfif newParams IS NOT "">
		<cfset newParams = left(newParams, len(newParams)-1)>
	</cfif>

	<cfset url = "/#newController#/#newAction#">
	
	<cfif newID IS NOT "">
		<cfset url = url & "/#newID#">	
	</cfif>
	<cfif newParams IS NOT "">
		<cfset url = url & "#newParams#">	
	</cfif>
	<cfif arguments.trailingSlash>
		<cfset url = url & "/">	
	</cfif>
	<cfif arguments.anchor IS NOT "">
		<cfset url = url & "###arguments.anchor#">
	</cfif>

	<cfif cgi.script_name Contains "dispatch.cfm">
		<cfset url = "/dispatch.cfm?wheelsaction=" & url>
	</cfif>

	<cfif NOT arguments.onlyPath>
		<cfif arguments.host IS NOT "">
			<cfset url = arguments.host & url>	
		<cfelse>
			<cfset url = cgi.server_name & url>	
		</cfif>
		<cfif arguments.protocol IS NOT "">
			<cfset url = arguments.protocol & "://" & url>	
		<cfelse>
			<cfset url = lCase(spanExcluding(cgi.server_protocol, "/")) & "://" & url>	
		</cfif>
	</cfif>

	<cfreturn url>
</cffunction>


<cffunction name="capitalize" access="public" returntype="string" output="false" hint="">
	<cfargument name="text" type="string" required="true" hint="">

	<cfreturn uCase(left(arguments.text,1)) & lCase(right(arguments.text,len(arguments.text)-1))>
</cffunction>

<cffunction name="distanceOfTimeInWords" returntype="string" access="public" output="false" hint="[DOCS] Reports the approximate distance in time between two dates">
	<cfargument name="fromTime" type="date" required="yes" hint="The start date/time">
	<cfargument name="toTime" type="date" required="yes" hint="The end date/time">
	<cfargument name="includeSeconds" type="boolean" required="no" default="false" hint="When set to true will give more detailed wording when difference is less than 1 minute">
	
	<cfset var minuteDiff = dateDiff("n", fromTime, toTime)>
	<cfset var secondDiff = dateDiff("s", fromTime, toTime)>
	<cfset var hours = 0>
	<cfset var days = 0>
	<cfset var output = "">

	<cfif minuteDiff LT 1>
		<cfif arguments.includeSeconds>
			<cfif secondDiff LTE 5>
				<cfset output = "less than 5 seconds">
			<cfelseif secondDiff LTE 10>
				<cfset output = "less than 10 seconds">
			<cfelseif secondDiff LTE 20>
				<cfset output = "less than 20 seconds">
			<cfelseif secondDiff LTE 40>
				<cfset output = "half a minute">
			<cfelse>
				<cfset output = "less than a minute">
			</cfif>
		<cfelse>
			<cfset output = "less than a minute">
		</cfif>	
	<cfelseif minuteDiff LT 2>
		<cfset output = "1 minute">
	<cfelseif minuteDiff LTE 45>
		<cfset output = minuteDiff & " minutes">
	<cfelseif minuteDiff LTE 90>
		<cfset output = "about 1 hour">
	<cfelseif minuteDiff LTE 1440>
		<cfset hours = ceiling(minuteDiff/60)>
		<cfset output = "about #hours# hours">
	<cfelseif minuteDiff LTE 2880>
		<cfset output = "1 day">
	<cfelse>
		<cfset days = int(minuteDiff/60/24)>
		<cfset output = days & " days">
	</cfif>

	<cfreturn output>
</cffunction>

<cffunction name="timeAgoInWords" returntype="string" access="public" output="false" hint="[DOCS] Reports the approximate distance in time between the supplied date and the current date">
	<cfargument name="fromTime" type="date" required="yes" hint="The start date/time">
	<cfargument name="includeSeconds" type="boolean" required="no" default="false" hint="When set to true will give more detailed wording when difference is less than 1 minute">
	
	<cfset arguments.toTime = now()>
	
	<cfreturn distanceOfTimeInWords(argumentCollection=arguments)>
</cffunction>