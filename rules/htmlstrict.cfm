<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "<[/!]?[^>]*>", "", "all" )>
	<cfset arguments.value = htmlEditFormat( arguments.value )>
</cfif>
	
<cfif reFindNoCase( "<[!/]?[a-z]*[0-9]?.*>", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "<[/!]?[^>]*>", "", "all" )>
		<cfset arguments.value = htmlEditFormat( arguments.value )>
	</cfif>
	<cfset arguments.message = "must not contain any HTML tags">
</cfif>