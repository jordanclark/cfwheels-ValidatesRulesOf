<cfif arguments.autoFix>
	<cfset arguments.value = trim( reReplaceNoCase( arguments.value, "[^[:alnum:]]", "", "all" ) )>
</cfif>

<cfif reFindNoCase( "[^[:alnum:]]", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = trim( reReplaceNoCase( arguments.value, "[^[:alnum:]]", "", "all" ) )>
	</cfif>
	<cfset arguments.message = "can only contain letters (A-Z) and numbers (0-9)">
</cfif>

