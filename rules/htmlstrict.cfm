<cfif attributes.autoFix>
	<cfset attributes.value = reReplace( attributes.value, "<[/!]?[^>]*>", "", "all" )>
	<cfset attributes.value = htmlEditFormat( attributes.value )>
</cfif>
	
<cfif reFindNoCase( "<[!/]?[a-z]*[0-9]?.*>", arguments.value )>
	<cfif attributes.mutable AND NOT attributes.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "<[/!]?[^>]*>", "", "all" )>
		<cfset arguments.value = htmlEditFormat( arguments.value )>
	</cfif>
	<cfset arguments.message = "must not contain any HTML tags">
</cfif>