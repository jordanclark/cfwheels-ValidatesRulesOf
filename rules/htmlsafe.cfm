<cfif arguments.autoFix>
	<cfset arguments.value = reReplaceNoCase( arguments.value, "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe)[^>]*>", "", "all" )>
</cfif>

<cfif len( arguments.value ) AND reFindNoCase( "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe).*>", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "<[/!]?(object|embed|script|applet|meta|link|frame|frameset|iframe)[^>]*>", "", "all" )>
	</cfif>
	<cfset arguments.message = "must not contain restricted HTML tags: object, embed, script, applet, meta, link, frameset, frame or iframe">
</cfif>

